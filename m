Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287EFA374B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbh9Q-0002NN-VL; Fri, 02 Jan 2026 10:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vbh9F-0002ML-Ou
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vbh9A-0000ES-O5
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767367977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nFrLrZCiDlZtEtUOvTElvHeA5sWiKVa98ThpiYFzaZQ=;
 b=gj8j1lxUN0JDxQi/E/xt/bN3Es4mCTBUoEs5REbHfe4u21LsPXD1mNVAbf54mTgb3PAtHP
 kMwNkJHe/JoDa4GD4YOjxa0rOICR4qB34OQLq9lAlYslGTG4xIn3uWrNSY2aRSGlMbSUkz
 vT9uaP4pOcgVnDLzNV6w99aUTgpD0Z8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-HIBsbnBAOFiw_dkNTKhQXA-1; Fri, 02 Jan 2026 10:32:56 -0500
X-MC-Unique: HIBsbnBAOFiw_dkNTKhQXA-1
X-Mimecast-MFC-AGG-ID: HIBsbnBAOFiw_dkNTKhQXA_1767367975
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso151680505e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767367975; x=1767972775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nFrLrZCiDlZtEtUOvTElvHeA5sWiKVa98ThpiYFzaZQ=;
 b=E2hU1Pci00ktSBgCoA2YYMKWmFSokC62/J5eB+05LMGWcNEgudV1YStnmLr+pmcvPu
 IIwk7Acs4AqWLAjzy0GAXSUathQ8TezsPAYQPOTm66X18I1u8U34V0+Ds1wXeCVJ4c2W
 pDYdy2h98pnC5njX41tx2NXWpZj64z9PcRRDv1R8owFATUlLdKWjGDwUH0Nyk0M6rz/y
 6SvdaNV/KMwhr1SGmM/pGqCJm0HiZUSi+ESMNs/6nBcyFa5XLUKGt+mPzCcYKZBWAE64
 asyqTSWRJz+pE8ywTmLnLFk/J8TUHTPR0aEXSu4Yxx2izmxsdgLXrMQnDt7okKO5nK2K
 xP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767367975; x=1767972775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFrLrZCiDlZtEtUOvTElvHeA5sWiKVa98ThpiYFzaZQ=;
 b=Cl9mfxfnQDl0BeQPC2X5U/Lw4v6sRYt2I/UHOPrV373zlCQzd2a8eW2NI/RQN5VDJz
 Dnu5bEjRQSC1x/h5RbtZVI7Nl7XeyC0f1LWkhLZJKx5Apj6dlmtwlXzlCCqpMoqdVN3I
 fKAqMqgOnuQpVosInUNbE2l/twN931byXzqsG3l67yIczsl8C0HNRkVGY6HZBNuhLrBO
 /jD2CgwEz+nrdZxgRnGq9q4cmi7KnALVtRUAj1JriTMzUXI1wD14gWXHARBGe87++dYZ
 UJi36EGq2X6MT7NJfF98ca/owTKbT2Q79CKTHnfZIvMPlmVL1GOIbHOXyjJrkWTCmMGN
 9Lcg==
X-Gm-Message-State: AOJu0Yy2ek3CRgY1l2Lr8535dMrd4q4a24tXjg/YfV3nwLVC99bQKedN
 XiAC2gApiCe6aRUWXGOhwmt2K42w0QPGWsp6q+sFu7vxIovtXrBJIshQWm6F0CEr7J304BkSu6p
 T9IbKnIFpPCYZypq2YeJvx/k7Rfc/5XRPRBzUWiIrBBfzoW7ztll7WwoG
X-Gm-Gg: AY/fxX7yNZvGsVcXjisQzyxYn1Hrx+ud+crKH32V3ehm5f0orD7tJJE7kQZpXQSMUgJ
 Px8sxvFfWz7sCL1t7KZKt3hpKp+Haq3Lu1riAmCMVoAX45EIsldKKvY2wclkjt2k/K7Bu6dJLd9
 slvDQFLXIkFKmL2Ypptlq/JvpvNizu/IWTxgg7bPEZJO5IBFFFFP7yhhUzKvmGU69vmq9b2D0Uk
 VQw4hrCQYUCvJ2ievl3WfYbY4GE3pYFdZfh1IS15+aFcWPoVpIYNBaqXD3iZtuMvfJY8SfpAU5J
 zJSz/gCdHbb88nyriDXZ3t/sr1eGRLODyDR3ppk9KleKmaYKczlbquOZEfqrWNE3VQVYrE2Vjfc
 go4Vw5xB0I/hnGQKyX+GZGzulS4PWoE+InQAheKC4Iq2IFSAuSY3G0h9nSOC5FZuoccK9
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-47d1c629902mr404346545e9.4.1767367975044; 
 Fri, 02 Jan 2026 07:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhFnzwrOA9b55xtLyP+XQgnNGC2MHRyCuG0Q+bRY4W366buCVk05gCZsePiIIlkh1O0+/F0w==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-47d1c629902mr404346325e9.4.1767367974648; 
 Fri, 02 Jan 2026 07:32:54 -0800 (PST)
Received: from localhost
 (p200300cfd737d08ff714dff937d3d533.dip0.t-ipconnect.de.
 [2003:cf:d737:d08f:f714:dff9:37d3:d533])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm733045025e9.10.2026.01.02.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 07:32:53 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Peter Lieven <pl@dlhnet.de>, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] block/nfs: Do not enter coroutine from CB
Date: Fri,  2 Jan 2026 16:32:46 +0100
Message-ID: <20260102153246.154207-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The reasoning I gave for why it would be safe to call aio_co_wake()
despite holding the mutex was wrong: It is true that the current request
will not re-acquire the mutex, but a subsequent request in the same
coroutine can.  Because the mutex is a non-coroutine mutex, this will
result in a deadlock.

Therefore, we must either not enter the coroutine here (only scheduling
it), or release the mutex around aio_co_wake().  I opt for the former,
as it is the behavior prior to the offending commit, and so seems safe
to do.

Fixes: deb35c129b859b9bec70fd42f856a0b7c1dc6e61
       ("nfs: Run co BH CB in the coroutine’s AioContext")
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2622#note_2965097035
Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nfs.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 1d3a34a30c..b78f4f86e8 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -249,14 +249,15 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     }
 
     /*
-     * Safe to call: nfs_service(), which called us, is only run from the FD
-     * handlers, never from the request coroutine.  The request coroutine in
-     * turn will yield unconditionally.
-     * No need to release the lock, even if we directly enter the coroutine, as
-     * the lock is never re-taken after yielding.  (Note: If we do enter the
-     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
+     * Using aio_co_wake() here could re-enter the coroutine directly, while we
+     * still hold the mutex.  The current request will not attempt to re-take
+     * the mutex, so that is fine; but if the same coroutine then goes on to
+     * submit another request, that new request will try to re-take the mutex,
+     * resulting in a deadlock.
+     * To prevent that, only schedule the coroutine so it will be entered later,
+     * with the mutex released.
      */
-    aio_co_wake(task->co);
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -716,8 +717,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    /* Safe to call, see nfs_co_generic_cb() */
-    aio_co_wake(task->co);
+    /* Must not use aio_co_wake(), see nfs_co_generic_cb() */
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
-- 
2.52.0


