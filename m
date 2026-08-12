Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347C9C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAN5-0003eM-NI; Wed, 12 Aug 2026 10:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALk-0000Gs-Cu; Wed, 12 Aug 2026 10:54:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALg-0007Nc-3K; Wed, 12 Aug 2026 10:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=piYQIwliEH/EXJYw7cYp5cdipRkqr747BOF2sE0T6ek=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=w7Xo7fqfiGk9YJy41idcC1gEo8eTPye+C0a8eTonh+V82uFmTG1RK/gA/RGPAQ9Z3
 TPvM2UWOJ9lxZqQRQUtPtDzxvpsiGlgU5rj6QHEklskvksMSb2el2dO/A/V/fMtEX+
 JMatvOoEO2KmC4XgEI71ycKAZxax+GwB9+bMbecEnYc9z/q0VyBUZVCgVSSnCSKID9
 MEONPR3oMB9J/oOpY7DQwZTPGIkMaWkvGuWmYI0qCS9UKvmTjGhO5nnJ629c+P4Bq1
 egUYwDW0oDocwwIiZUibDidGXdqUrVUYLYV+OeZPpJ8Xvx6FEI5417zcbCDDPClHos
 lbTHB0TlquqEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB5531CA631;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 52333409D73;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B29E52F9BD; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, huntr bubble <bubblehuntr@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 045/120] virtio: use masked features with
 set_features_ex
Date: Wed, 12 Aug 2026 17:48:28 +0300
Message-ID: <20260812144955.649205-45-mjt@tls.msk.ru>
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

virtio_set_features_nocheck() calls set_features_ex
with guest-supplied feature bits, without masking the value
with host features (unlike set_features which gets the
correct val & host_features).

This does not matter if the driver matches spec, but drivers
can be malicious or buggy and set bit outside the host mask.

Devices don't expect this, so unsupported guest feature bits getting set
can break the host. In virtio-net, this can enable RSC without vnet
header support and cause out-of-bounds reads from short packets.

Pass the masked features to set_features_ex, consistent with set_features.

Fixes: CVE-2026-63321
Fixes: 64a6a336f4 ("virtio: add support for negotiating extended features")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dfd27c9b26e442a2076f6ddc9bb3d38363d9b2da.1784891251.git.mst@redhat.com>
(cherry picked from commit a6e0519ea8ed6fc84fab9bf9ca82c7a55780f880)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b337c50c747..ddf8c13e99d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3153,7 +3153,7 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
     virtio_features_and(tmp, val, vdev->host_features_ex);
 
     if (k->set_features_ex) {
-        k->set_features_ex(vdev, val);
+        k->set_features_ex(vdev, tmp);
     } else if (k->set_features) {
         bad = bad || virtio_features_use_ex(tmp);
         k->set_features(vdev, tmp[0]);
-- 
2.47.3


