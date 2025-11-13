Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD88CD5BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTBB-0007LN-0T; Thu, 13 Nov 2025 03:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1vJTB9-0007Kb-LX
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:59:43 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1vJTB6-0003wL-B0
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:59:43 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A395D8A406;
 Thu, 13 Nov 2025 11:59:34 +0300 (MSK)
Received: from d-tatianin-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:a8c1:6d5e:1ea8:2667])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pwL8SG0FBiE0-vD64DQsG; Thu, 13 Nov 2025 11:59:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763024374;
 bh=wt9YlCdRhhj+OCdI7QYlLCUK7ca7o6j6lI/FM3djSF8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=v1uCRhbZUeTF3ygyhmKZPx9FPm7IrqGL/hQILcgBJz4NguQb/OdEBcWDMUeAAFCSW
 zAWWcPct+OvjLTyWuqjPLgjNblH0/WXonjdmobEEMsLbd0/MrzAZD54w1ix0I45e3n
 mOOpGWn2EF5+ONTnCOLeMPplc34UBF7x+3ccurg0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
Date: Thu, 13 Nov 2025 11:58:42 +0300
Message-Id: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just having a file descriptor is not enough to consider a memory region
public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
writes to this region won't be visible to the vhost-user backend, thus
causing it to read all zeroes or garbage. Make sure we don't pass such
regions and include that to our definition of what a private region is.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..eb098a25c5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -591,11 +591,13 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
         /*
          * Some backends (like vhost-user) can only handle memory regions
          * that have an fd (can be mapped into a different process). Filter
-         * the ones without an fd out, if requested.
-         *
-         * TODO: we might have to limit to MAP_SHARED as well.
+         * the ones without an fd out, if requested. Also make sure that
+         * this region is mapped as shared so that the vhost backend can
+         * observe modifications to this region, otherwise we consider it
+         * private.
          */
-        if (memory_region_get_fd(section->mr) < 0 &&
+        if ((memory_region_get_fd(section->mr) < 0 ||
+            !qemu_ram_is_shared(section->mr->ram_block)) &&
             dev->vhost_ops->vhost_backend_no_private_memslots &&
             dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
             trace_vhost_reject_section(mr->name, 2);
-- 
2.34.1


