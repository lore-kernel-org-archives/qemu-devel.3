Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CF6CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSW-0005ra-3w; Tue, 29 Sep 2026 04:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSP-0005pz-AX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:02 -0400
Received: from mail-pz2-x16.google.com ([2607:f8b0:4864:3b::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSN-0003pA-Us
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:01 -0400
Received: by mail-pz2-x16.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso2323978a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671499; x=1791276299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jVxHr521NDdsP0576c5KkwGFcCZcrMwIiK5zVjnjcKY=;
 b=Rs9kQNgbrahMnySn6B9jz5nFD/BwqZ0Gr/rd3Hk6VJiZBSNKR1aWk+yJ5d5qEF2eky
 9/voFTy1dwzPnHc1/9+aX3a4W2zvJfGx6Ng0fFvVwQkhuCDnK2AJx1+bn1ooJA5UKtVJ
 EhUkluTKEbBGnhFamu9fQRL+ZjNUvdqYMmS+T+otU1T84Jw9ExD3U7Bn3kKRLQa4WYxF
 VZNlF/563t5pDR6eC3GJ9pVpxdbZWqNciSqYIlPWKn1UmGFilcDxd1JeBPFTgXwbARV5
 fwZQ/jYihsLoaMFxs0uaOhan0KMTzjTmnknURbFyPzvsg+9eQRT/hhMevxIuiauwhvL5
 L71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671499; x=1791276299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jVxHr521NDdsP0576c5KkwGFcCZcrMwIiK5zVjnjcKY=;
 b=OI3T9CjlaxfSrZ6sgS8X5lDxaHPZ3tw2mSCnixxu5tWcA2Y5zjpDeQoPadroGiQv+1
 J98VsP9X/RuOiHLDRLSEw720OKxbGk4ZEpdzIykpF+/cNv8auV/EtbAGL9Z0S+uHj/QF
 2j27+AT58KrK9ASgiUvF2NDR/ZbDFllPA8msPXUTlSLSsRd44o2MRpMrP6FU2jFu3cE4
 mOs54/VXo1Ci1RRZQ00JMG9UFURp9QTJZTwvfU1169RXwopVaj84fzgZq7v8LyL9SMGA
 yWbEzjGm8eIdKGg4MRBtvc9PZIlvqvMqxwF7AerEeWJXDSwvWAAyCGEA2vbHVhU1RrCj
 5LIA==
X-Gm-Message-State: AFq9FYK+txT9omj5VE2R1bZdfli4KmFo3T6XiamtOoeuWbIkufaIK0bM
 JcW1WyDg+u9NkE1KD9d4bbgrpyJiuiMZKr0RNEud3pXmtWKvjrQM73WDF49vwv5r
X-Gm-Gg: AYBFou2NOEARzpJ2siEGL3Ert9w6YLEpW5pWmPiHMA3A/63XXpycx+dNff8g3SBIVpf
 2yEnZxmPvA+m3iRHWHGrwtl93mwUnjLMPPEEPbQ4FEUZgohPfdAVRpzs3qo/OxQRGDo3XrnOEst
 rBIWF0nWrIfAl2vE1PLUpk4pyVr6SdvUSuc6A+915lDXMPMwlbd9NbFFhF/NKEpzpKCgcqEpD0a
 zLDX5b8lwRoh6CwcwQaZeQuTqca9gnpYk7M4Zis21cyHbWY7OGGoyNtfYbGsHldOVVniSpPVtMx
 Vchj6pyhG/GB7QBtzLdEbrpxNPtjzCMPtzmpPFsbESil9imc6z0W+bZlrfQdb2dLTVSKHBWgTJ4
 wv+Y4LKkApYauDJGMlYfoWTk4QC8TaSjx7ip7XA/Fq/VeqeDyoTk6y/gZcHoDswEG/RwDCGaByD
 WwKHDzzX5vvp+/WTdDiVz5g7TSbIEfS0Zl2fU1EqnyTv84xks4NNCemdVXdX51vrNXtR4oF0B1m
 yRNxbcg8pHLGsRWdVJgav1Fg2M=
X-Received: by 2002:a17:90b:3909:b0:3a4:ad5c:d48a with SMTP id
 98e67ed59e1d1-3a4ad5cdc9dmr296045a91.67.1790671498596; 
 Tue, 29 Sep 2026 01:44:58 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:58 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 10/13] xen-block: Update tracking iothread users with
 holder name
Date: Tue, 29 Sep 2026 16:44:13 +0800
Message-ID: <20260929084416.1600199-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::16;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x16.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.43.0


