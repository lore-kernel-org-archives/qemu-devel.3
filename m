Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B6606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SF+6WJ+2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHj9-0000Or-4G; Mon, 26 Oct 2026 06:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHib-00005c-VD; Mon, 26 Oct 2026 06:14:27 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHia-0001Yq-2a; Mon, 26 Oct 2026 06:14:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F95960A6A;
 Mon, 26 Oct 2026 10:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6CF1F01825;
 Mon, 26 Oct 2026 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009653;
 bh=uXCvO91dRIuN/SncYFFhIKKcJf66smDlFFYLf0JJrQc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SF+6WJ+2r1/W4P1IPsA9AYJcTL1n+eWv4bPIU24snAjaog8dG3jz/pvDqjHd/6+lo
 UEvTeNxbEOXl5gTPKze705wYw8Jjn3CxDL34UIsatmXnduK8ObeqAPeXSxSwkh3jlJ
 HMtbJSMimpdFgQz0BSXvpVMl2zDwTv9Bd4+g4iFbzCVM3hr+Z1sWetVWkaNOJM40qh
 KLh8xw7TgM7IuRaHmsMigS89xU9RNp+p/1Ao4oX8f5m61SMfzsL+u/W8IP1ldCCOfD
 B4shANCLMHRhgiVo6J4toiEZqQayYoyyUkjnKrrS/WQCdbe7CBBpEwUhGQfenwfu+K
 cc4VDrR8XEsYg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:13:58 +0100
Subject: [PATCH RESEND 3/5] docs: add hw/nvme atomics section
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-mam-v1-3-5d53b5529ffa@samsung.com>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=2459;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=H1vkn10praulP5zoclKNaIKHegQbmw5kjUOlvqrhDIc=;
 b=LoHUJc0Q+dTl+wJVBDZTpH8qWTzGcMVJroey1SoaYD3EXKOldZVvDa0oIoulRt1Mk/qlTaymT
 cCnb3H1fw0lCtzCtRA70YzFAbkiDnTHZY1wOJUtdJtaLk9aiPVDSuHD
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


