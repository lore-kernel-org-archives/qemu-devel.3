Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BC9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxSW-0002Ew-4b; Tue, 25 Aug 2026 16:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSU-0002Bp-EY; Tue, 25 Aug 2026 16:09:22 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSS-0003M3-SO; Tue, 25 Aug 2026 16:09:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 498D6417A4;
 Tue, 25 Aug 2026 20:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8341F000E9;
 Tue, 25 Aug 2026 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787688551;
 bh=mjWt2eG9bGCBu6fo83T7HNOlfG653ZKTc+ZgqhLkw38=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FrUTp4TgLn1Oii7ZyKh4Zgjrj74s1x0Cks4Y6VUAHKnRTTaS9UaEx1kP2LJoSubSI
 z2UfCp7CZH+fsOIzlgjkf3Yz/WY63yiOPb7SBTuseRRDFGjLIt3yKI+f8KHzFUDEp+
 SvbQJdBFgvJqYtQjmYwzl7UnvG8zvPNQFJumdjbZu0pXAZEBBcW8kXLGVVAvi1iq/l
 dRSjKyeCezVfBcIlotbLz8UIZPXuERjb5Uy517bKWvPCE6RGkE4CzuGAorD956z4pv
 lfrAsYeGXlS5jSasYzBIy6NwJagTmy7vtqTJJ+hffSS9R/ppoU18IYN0a4Lq3iYXGb
 K7aC11RwTUaKg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 25 Aug 2026 22:08:02 +0200
Subject: [PATCH 2/5] hw/nvme: add missing atomic.* fields in usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nvme-mam-v1-2-afc38ac713ef@samsung.com>
References: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
In-Reply-To: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787688545; l=1619;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=LZPT5SX6Uwbh9kVjr+dYBKu3eyw+0VX3INwwwIT8kfU=;
 b=KgGxejFHsf4+Y4a43A1C7kgdPH6pYhJYR4W6va7eLYGtpuBFmHmKZ2fkLeCJLfv6MQ+G8UmLQ
 KYjFYFMcaX8CU4cqr2T1cnZjfFSkXFjPzTZcEMen5dT0voDA54uTeQR
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Gomez <da.gomez@samsung.com>

Add the missing atomic.* namespace fields in the usage comment section.
While at it, fix the missing '=' in the atomic.{awun,awupf} fields.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c884ca8a181..3baf57af634 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -41,8 +41,8 @@
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
  *              atomic.dn=<on|off[optional]>, \
- *              atomic.awun<N[optional]>, \
- *              atomic.awupf<N[optional]>, \
+ *              atomic.awun=<N[optional]>, \
+ *              atomic.awupf=<N[optional]>, \
  *              subsys=<subsys_id>, \
  *              model=<model-str>, \
  *              firmware-version=<version-str>
@@ -55,7 +55,12 @@
  *              zoned.descr_ext_size=<N[optional]>, \
  *              zoned.max_active=<N[optional]>, \
  *              zoned.max_open=<N[optional]>, \
- *              zoned.cross_read=<true|false[optional]>
+ *              zoned.cross_read=<true|false[optional]>, \
+ *              atomic.nabo=<N[optional]>, \
+ *              atomic.nabsn=<N[optional]>, \
+ *              atomic.nabspf=<N[optional]>, \
+ *              atomic.nawun=<N[optional]>, \
+ *              atomic.nawupf=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now. By default, the

-- 
2.55.0


