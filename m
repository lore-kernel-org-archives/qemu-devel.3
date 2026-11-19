Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3F606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axrffaSj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8fg-0008U1-HL; Thu, 19 Nov 2026 15:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU8ff-0008TZ-Cd
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xU8fd-0003JY-7Q
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795119825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRUWMAi1eNHlg4Ac9L7ARUkj1IaKjLqyCIjaOJ8wO60=;
 b=axrffaSjAlHck8PwZdvgMMbPFOLa8tjYAEfhSAO6c4rf7qAKQuBPOddwJr6YKS8ijtx7X6
 ljaJp8NCSXudF6UCXqTQX10rz0BLKGh8WZYrn9LQf/wjTNhMB6RhJAboR1lJKkxQsWNFaF
 bUt2rGuLvl2Luo8ERXBXon/u9oDLV5c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-QgNkpGuAMcGvYH0m7dBoJg-1; Thu,
 19 Nov 2026 20:23:41 +0000
X-MC-Unique: QgNkpGuAMcGvYH0m7dBoJg-1
X-Mimecast-MFC-AGG-ID: QgNkpGuAMcGvYH0m7dBoJg_1795119820
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C8811802144; Thu, 19 Nov 2026 20:23:40 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA99D34C; Thu, 19 Nov 2026 20:23:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Feifan Qian <bea1e@proton.me>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 3/3] nbd/client: Don't leak uninitialized memory on malicious
 server
Date: Thu, 19 Nov 2026 14:23:13 -0600
Message-ID: <20261119202330.3853797-8-eblake@redhat.com>
In-Reply-To: <20261119202330.3853797-5-eblake@redhat.com>
References: <20261119202330.3853797-5-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NBD spec[1] permits servers to send out-of-order replies for a
structured read, which the client must re-assemble into the final
buffer of its NBD_CMD_READ request. The standard states a server must
send chunks covering the entire region, but leaves the burden on the
client for double-checking whether a server actually sent sufficient
reply chunks. If the client never checks for a server omitting chunks,
or even sending multiple chunks that re-write the same portion of the
buffer, then the NBD spec says behavior is unspecified.  But ever
since we added structured reads to QEMU, the actual behavior is that
we would end up silently leaking QEMU host heap contents into the
guest's view, which the guest blindly assumes is legitimate data sent
by the server.  A proof of concept reported by Feifan Qian with the
help of AI analysis demonstrated the ability to leak 0x5a bytes from a
qemu-kvm process with MALLOC_PERTURB_=165, which implies a malicious
server can coerce QEMU into divulging other parts of its heap to a
guest for exfiltration, where knowing unscrubbed heap contents may
make further attacks against QEMU easier.

[1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md

In terms of the security risk, a guest cannot detect when a server
does a short reply, and may misbehave if successive reads of the same
portion of the disk come back with different contents, based on
changes to QEMU's heap between those reads, making it easy for an
attacker to attempt to provoke a silent form of data corruption to
guests, even though the server cannot control the actual sequence of
guest reads or QEMU heap contents between those reads.  And although
modern computing tends to isolate heap contents to prevent
cross-process leaks, it is feasible that a determined attacker could
try to set up a scenario in a multi-tenant environment where a guest
under attacker control using a disk backed by an NBD server supplied
by the attacker could then exfiltrate unrelated information learned
from other guests on the same host.  As a mitigating factor, QEMU
recommends that NBD client connections utilize TLS traffic and x509
certificates to avoid connecting to untrusted NBD servers.  See also
CVE-2022-0485 for a similar issue with clients being made more robust
to a non-compliant server in libnbd.

It may be worth proposing a future enhancement to the NBD protocol to
allow the client and server to negotiate an additional handshake
guarantee that structured reads must occur in order (the client can
detect a non-compliant server with less overhead, or even refuse to
talk to a server that doesn't know the new protocol).  But for now,
tracking the highwater mark of what has been covered in the buffer,
even if portions of the buffer get covered more than once, is
sufficient to guarantee that data left uninitialized by the server is
at least deterministic of showing as all zero in the guest's view.

At the time I wrote this patch, I also had an AI-assisted unit test
ready for qemu-iotests, but the policy update on LLM contributions was
not yet ready.  I also investigated modifying the existing
tests/qemu-iotests/nbd-fault-injector.py to add a way for it to become
a non-compliant structured read server, but that would itself require
quite a bit of refactoring effort (the fault injector currently
negotiates only simple replies, not structured), and would be rendered
moot by later use of an AI-assisted unit test. So instead, I am
documenting the following two-line patch to turn QEMU into a
non-compliant server that transmits less data than normal for holes:

| diff --git a/nbd/server.c b/nbd/server.c
| index 8c45f9fc43f..5d754cefa29 100644
| --- a/nbd/server.c
| +++ b/nbd/server.c
| @@ -2251,7 +2251,8 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
|                           final ? NBD_REPLY_FLAG_DONE : 0,
|                           NBD_REPLY_TYPE_OFFSET_HOLE, request);
|              stq_be_p(&chunk.offset, offset + progress);
| -            stl_be_p(&chunk.length, pnum);
| +            /* HACK - truncate size of hole to test client response */
| +            stl_be_p(&chunk.length, 1 /* pnum */);
|              ret = nbd_co_send_iov(client, iov, 2, errp);
|          } else {
|              ret = blk_co_pread(exp->common.blk, offset + progress, pnum,

With that patch applied, you can see the difference in behavior by the
following setup (recall that qemu-io hard-codes 0xab content after
malloc() and before blk_pread(), so this behavior is unaffected by
your choice of MALLOC_PERTURB_):

$ qemu-img create -f qcow2 sample.qcow2 1m
$ $hacked/qemu-nbd -f qcow2 sample.qcow2 &
$ $old/qemu-io nbd://localhost:10809 -f raw -c 'read -v 0 16'
00000000:  00 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  ................
$ $patched/qemu-io nbd://localhost:10809 -f raw -c 'read -v 0 16'
00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
$ kill %1

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: CVE-2026-126657
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3815
Fixes: f140e300 ("nbd: Minimal structured read for client", v2.11.0)
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261113223742.2546619-9-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[eblake: Commit message enhanced with reproducer]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index d873892c197..fb4295bb235 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1151,6 +1151,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
     NBDReply reply;
     void *payload = NULL;
     Error *local_err = NULL;
+    uint64_t highwater = offset;

     NBD_FOREACH_REPLY_CHUNK(s, iter, cookie,
                             s->info.mode >= NBD_MODE_STRUCTURED,
@@ -1158,6 +1159,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
     {
         int ret;
         NBDStructuredReplyChunk *chunk = &reply.structured;
+        NBDStructuredReadHole *slice = NULL;

         assert(nbd_reply_is_structured(&reply));

@@ -1165,8 +1167,9 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
         case NBD_REPLY_TYPE_OFFSET_DATA:
             /*
              * special cased in nbd_co_receive_one_chunk, data is already
-             * in qiov
+             * in qiov, and payload is host-endian offset+length.
              */
+            slice = payload;
             break;
         case NBD_REPLY_TYPE_OFFSET_HOLE:
             ret = nbd_parse_offset_hole_payload(s, &reply.structured, payload,
@@ -1174,6 +1177,9 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
             if (ret < 0) {
                 nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
+            } else {
+                /* Successful parse swapped payload to host-endian. */
+                slice = payload;
             }
             break;
         default:
@@ -1187,10 +1193,26 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
             }
         }

+        /* Initialize any region skipped by a malicious server. */
+        if (slice) {
+            if (slice->offset > highwater) {
+                qemu_iovec_memset(qiov, highwater - offset, 0,
+                                  slice->offset - highwater);
+            }
+            highwater = MAX(highwater, slice->offset + slice->length);
+        }
+
         g_free(payload);
         payload = NULL;
     }

+    /* Initialize any trailing region not touched by server. */
+    if (iter.only_structured && iter.ret == 0 &&
+        highwater < offset + qiov->size) {
+        qemu_iovec_memset(qiov, highwater - offset, 0,
+                          offset + qiov->size - highwater);
+    }
+
     error_propagate(errp, iter.err);
     *request_ret = iter.request_ret;
     return iter.ret;
-- 
2.56.1


