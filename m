Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B8C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8gu-0004Nd-AL; Wed, 12 Aug 2026 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gm-0003io-A2; Wed, 12 Aug 2026 09:08:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gg-0005Qa-81; Wed, 12 Aug 2026 09:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=AT18YDJalbqkXIqbOFCkRp/nKWOreRTvakHRgZxqa18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OxJWuZW/WhSioU79xx994R+QDdnGd7qUmcgd5ZhaB8vtGG01FuHQHIh9MxNkhG/X3
 OrEDs1Sa/cHWyZDVMffc/r8Ga8kpUVqjcDsQ3Uhf0sdpO2t5S3SBCxtPMRGeN0rOav
 bxS8Enyu2eKNjn6rpIX5QPXD6LHscN/7Jo04pk/F/9WNWVQXcPgJ4dSimKShQyQtOT
 74Yzli2blTQlMse0bDwKDU4jnqjNrFMIs9TE9oR88j/GTx4M2UOqqGXUh5fpbaMQxJ
 rSGrmhs5wh3Sp3V6VxtIC092lelSsjXlJY5VBYHfP1quSVAvu+Z1WZ2fjG3IHIySmL
 lWJLztN/tRhnw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 100621CA4B4;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 45EDB409B97;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5534E2F8FE; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 053/102] hw/virtio/vdpa-dev: pass set_config buffer
 to vhost backend
Date: Wed, 12 Aug 2026 16:01:28 +0300
Message-ID: <20260812130233.621965-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vhost_vdpa_device_set_config() receives the updated config buffer, but
forwards s->config to the vhost backend. Since s->config is refreshed by
get_config(), it may contain stale backend state.

Pass the supplied config buffer to vhost_dev_set_config() instead.

Fixes: b430a2bd2303 ("vdpa: add vdpa-dev support")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
(cherry picked from commit 421f45d03f328267ebf77fab823a7a25ab3d6c83)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index ee228af66f2..7f890d60b14 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -213,7 +213,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const uint8_t *config)
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
     int ret;
 
-    ret = vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
+    ret = vhost_dev_set_config(&s->dev, config, 0, s->config_size,
                                VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("set device config space failed");
-- 
2.47.3


