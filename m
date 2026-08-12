Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F2AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAP6-0005b8-00; Wed, 12 Aug 2026 10:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAO2-0004J0-AX; Wed, 12 Aug 2026 10:57:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANz-0000hc-3I; Wed, 12 Aug 2026 10:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=GZhYjmhSD6JPltTTY4LQ8wcYUAKdepxlLebQ1NiSWoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=umcq3uV8GNJWH9MXBXzfyb71YzTbTjbqjTLqv4LMn4PAfJbDbnGdwLo4QOwowAm7C
 tdVQgK7Wdzjpw25egoRZ9yL4AiHd5C8FBT286D/ZMPdtjsIKfY6QwdoAixqxCPK81G
 RWlUdOVj/3TbQQIoysso4cEQpGgmQU9UkyPZjKWgw/Qm+yURTvTGKlX3HttRnwp1QW
 nzfyZizNAdXkflbsWpiCrsTATnfwA8GA9waCdt/YDYbzJbccUIbnLaAR+5MD9k6OVs
 7bHhJS8T26zTrrFURmABWJsa6/K8eiDuhCEorqNmYlfNduvFC+gai8aizmQWOOp3hp
 eQ+5Y+FgQtBGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7987F1CA643;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4B4F409D85;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 406302F9E1; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 063/120] hw/virtio/vdpa-dev: pass set_config buffer to
 vhost backend
Date: Wed, 12 Aug 2026 17:48:46 +0300
Message-ID: <20260812144955.649205-63-mjt@tls.msk.ru>
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
index 7d98b23b471..2dcfc9d9297 100644
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


