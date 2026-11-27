Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FA606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=D6dOiYN3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp93-00027z-Mp; Fri, 27 Nov 2026 01:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8D-0006nl-DC; Fri, 27 Nov 2026 01:08:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp89-0006ky-Bk; Fri, 27 Nov 2026 01:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=5YOSgujFhufSNGl5BVcgFzQAGPnE7v+nWsQjqXCNk8o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D6dOiYN3VcMhGckamy+OphtGSLYFW7OOPLujbRQS+im/uNZiH/1YHs7qFipOOGumz
 u9t0bETkBi2IztNKao0A39T/CZNCWY1hXNfBulskodM9d4JlhDjzBFu9AruCpHZVvT
 TwtjiKvh9ycHrOYV2gMtUtgve4d5xSkferWYnAbjFaPmTqL3hGv+/QSqbcIQTiMVBe
 WZsNp9XraKlvkAgssddiGa3ZgNogMmnaA1F8uVts3WYdJI7keS0EEptTEMYDAfvOoD
 IB9XnqlomqEeJPCSLv9qEJWXNw/aNi1Q4OgVSJmc/OdfvfBzo+XjmMYVL2rIywjXU0
 IY6HkbJn/s7Cw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F0021EA36A;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2CA9D469995;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0EB83CF322; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 120/152] nbd/client: Don't leak uninitialized
 memory on malicious server
Date: Fri, 27 Nov 2026 08:54:18 +0300
Message-ID: <20261127055709.39630-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Blake <eblake@redhat.com>

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
(cherry picked from commit 470888ffb0220911a0ab58f9ffd41d95f36e4a22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


