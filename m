Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F16EC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxSX-0002G6-Mp; Tue, 25 Aug 2026 16:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSV-0002E3-Dh; Tue, 25 Aug 2026 16:09:23 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxST-0003M7-Qy; Tue, 25 Aug 2026 16:09:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FEEF6011F;
 Tue, 25 Aug 2026 20:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C8D1F000E9;
 Tue, 25 Aug 2026 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787688553;
 bh=LwWR7zUnszifL+10OLV4lfkrO2s6LsshfY8NTWEiGag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SQbk1XYnfJShz28RBAvSib3JhZjL1YtxOSrbXfOQzAIxabbnluMJftp2x8IhAUcZo
 4CB7Tuo1habhRrdKS1oOvw5fj39xSfOuEHeu0S3kUxOFxKpHKFrm+cQ/Bnqq7rVB3o
 7D5+DCa1bB/0NLtt9EsmPwBUXCFvBdKuW4hgcQiChNw1GQwFpeQfiFLe77a2//uLpJ
 UZulGG9iJjf7p9Z1xz3voQi6qyYv0HfqM2MVi9K7DXJIuJUojGYpZA+Uyw1eF1Xn4U
 gx6n10hd0Zl+KUkLNxFRb0Sdq4V2yH+1IHYsaKda4T9peDvNaSg4xW5jgGCFPWN9xa
 4JatG/Ug4gW4g==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 25 Aug 2026 22:08:03 +0200
Subject: [PATCH 3/5] docs: add hw/nvme atomics section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nvme-mam-v1-3-afc38ac713ef@samsung.com>
References: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
In-Reply-To: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787688545; l=2459;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=DOKKiMr0NWxb2+WItuoEQJ4wUBThlPrd0mzZQVyJxG8=;
 b=C9gEQVM63JbppgWcYamjSQ9egDIjSreLLSsnhlwdBmZR9gVkNCkxrvwXe33X9tOxI1ydq4WOu
 LXLFEA7EJqUDm8MOH9sOApDLDVFtw09I6gIrMaaxlxOkQqzHjMdomHm
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
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

Document the atomic.* parameters of the nvme and nvme-ns devices.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 docs/system/devices/nvme.rst | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 98a44010438..ab3bb395ab4 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -9,8 +9,8 @@ See the following sections for specific information on
 
   * `Adding NVMe Devices`_, `additional namespaces`_ and `NVM subsystems`_.
   * Configuration of `Optional Features`_ such as `Controller Memory Buffer`_,
-    `Simple Copy`_, `Zoned Namespaces`_, `metadata`_ and `End-to-End Data
-    Protection`_,
+    `Simple Copy`_, `Zoned Namespaces`_, `metadata`_, `End-to-End Data
+    Protection`_, and `Atomic Writes`_.
 
 Adding NVMe Devices
 ===================
@@ -386,3 +386,40 @@ controller are:
 .. code-block:: console
 
    echo 0000:01:00.1 > /sys/bus/pci/drivers/nvme/bind
+
+Atomic Writes
+-------------
+
+Specific Atomic Boundaries parameters for ``nvme`` devices. Unless specified,
+values are in logical block units.
+
+``atomic.awun=UINT16`` (default: ``0``)
+  Set the Atomic Write Unit Normal (``AWUN``).
+
+``atomic.awupf=UINT16`` (default: ``0``)
+  Set the Atomic Write Unit Power Fail (``AWUPF``).
+
+``atomic.dn=BOOL`` (default: ``off``)
+  Set the Disable Normal (``DN``). When set, the controller ignores ``AWUN``
+  and ``NAWUN``.
+
+Namespace specific Atomic Boundaries parameters for ``nvme-ns`` devices:
+
+``atomic.nabo=UINT16`` (default: ``0``)
+  Set the Namespace Atomic Boundary Offset (``NABO``).
+
+``atomic.nabsn=UINT16`` (default: ``0``)
+  Set the Namespace Atomic Boundary Size Normal (``NABSN``). ``0`` means no
+  atomic boundaries for normal operations.
+
+``atomic.nabspf=UINT16`` (default: ``0``)
+  Set the Namespace Atomic Boundary Size Power Fail (``NABSPF``). ``0`` means no
+  atomic boundaries for power fail operations.
+
+``atomic.nawun=UINT16`` (default: ``0``)
+  Set the Namespace Atomic Write Unit Normal (``NAWUN``). ``0`` means that
+  ``AWUN`` will be used for the size of this namespace.
+
+``atomic.nawupf=UINT16`` (default: ``0``)
+  Set the Namespace Atomic Write Unit Power Fail (``NAWUPF``). ``0`` means that
+  ``AWUPF`` will be used for the size of this namespace.

-- 
2.55.0


