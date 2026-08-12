Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD328C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuANF-0003sC-Ku; Wed, 12 Aug 2026 10:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAMm-0002XI-OU; Wed, 12 Aug 2026 10:55:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAMR-00082v-HJ; Wed, 12 Aug 2026 10:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=uxm9A6AdRsxgK+6ZXunG1n5eURpGcO+drgTUYDsDxrk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uIFWJ5pMdqwaBROY/JC80ffQDD2azCI8yNL2Sil3fuUfULzI1vjOcN0cAhbtkPUsi
 7Qol8MkvUdBXgOlALXxdJrGMLD8dFgpP9QJBbmY5oSxX+L+lFJaVDGBW9M/0BxAfvf
 OHhH195bVjoVHIaxpOCli31xvB5rFXyWtuhj43RR9fV1gnCDpUdkofgGxkW0erCM3r
 eNQYVw9Vmn++sIo6kl5u12zG1BaGKTDZvZh4lWmKa0ubJemUlZjA+47fLk+zXhn7Kf
 +Wlt0xMtFX80ggo3/XOTr/W63J3CNpPV0W/pMSPFigr9WxVBvYPuBvxaqULPcsimv4
 H4A/qmYzvLNvA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3311A1CA639;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D1C2409D7B;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EDC172F9CD; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Feifan Qian <bea1e@proton.me>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 053/120] virtio: fail early on bad config_len in
 migration
Date: Wed, 12 Aug 2026 17:48:36 +0300
Message-ID: <20260812144955.649205-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio_load() attempts to load config_len bytes from the migration
stream. If that's huge (e.g. 4g) this will uselessly spin
beyond the end of the stream for seconds. Not nice.
Check qemu_file_get_error() and bail out early, instead.

Also note that config_len is int32_t but is coerced to unsigned when
used. Switch it to uint32_t to make this clearer.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
(cherry picked from commit 665c854390e0db15ed55b985ca850c36b28b0e57)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2f357519193..b290d8650b0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3320,7 +3320,7 @@ int coroutine_mixed_fn
 virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
-    int32_t config_len;
+    uint32_t config_len;
     uint32_t num;
     uint32_t features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3368,6 +3368,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
 
     while (config_len > vdev->config_len) {
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         qemu_get_byte(f);
         config_len--;
     }
-- 
2.47.3


