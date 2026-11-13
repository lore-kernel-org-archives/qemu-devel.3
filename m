Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05504606A54F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzN+d/+3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzuD-00043G-7O; Fri, 13 Nov 2026 17:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzuB-0003vn-9C
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzu9-0007qV-5r
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794609477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr34AFhT/zINqrCH1Z2lz59myyc5HktKLPX9hSFRZT8=;
 b=SzN+d/+3HH+laY2LvUHT6WK/wxZMihvhx6zNeN0TCiFZLNBAY1r3ctVb1RUHkKRVG9b83M
 f2mKHsM/0kV69z0UvhzMOpeZSModccqPr+gBPV104BFNUaJ9ugavQWwcPf95PsXiTTNcW4
 zGFmgw36BmB1GYrPH7Bs2Q0yK0DQ5tE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-t2jmLqLRPFiFz-2Y7xlNRw-1; Fri,
 13 Nov 2026 17:37:54 -0500
X-MC-Unique: t2jmLqLRPFiFz-2Y7xlNRw-1
X-Mimecast-MFC-AGG-ID: t2jmLqLRPFiFz-2Y7xlNRw_1794609473
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FB7319560BF; Fri, 13 Nov 2026 22:37:53 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EA161956086; Fri, 13 Nov 2026 22:37:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, bea1e@proton.me,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/4] nbd/client: Don't leak uninitialized memory on malicious
 server
Date: Fri, 13 Nov 2026 16:34:51 -0600
Message-ID: <20261113223742.2546619-9-eblake@redhat.com>
In-Reply-To: <20261113223742.2546619-6-eblake@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The NBD spec permits servers to send out-of-order replies for a
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
help of AI analysis demonstrated the ability to leak 0xa5 bytes from a
qemu process with MALLOC_PERTURB_=165, which implies a malicious
server can coerce QEMU into divulging other parts of its heap to a
guest for exfiltration, where knowing unscrubbed heap contents may
make further attacks against QEMU easier.

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
even if portions of the buffer get covered more than once, was
sufficient to guarantee that data left uninitialized by the server is
at least deterministic of showing as all zero in the guest's view.

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: CVE-2026-126657
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3815
Fixes: f140e300 ("nbd: Minimal structured read for client", v2.11.0)
CC: qemu-stable@nongnu.org
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
2.56.0


