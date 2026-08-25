Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DF2C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxSU-0002BN-BD; Tue, 25 Aug 2026 16:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSS-00026l-23; Tue, 25 Aug 2026 16:09:20 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wyxSQ-0003ML-KU; Tue, 25 Aug 2026 16:09:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69BF5417AB;
 Tue, 25 Aug 2026 20:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B51F000E9;
 Tue, 25 Aug 2026 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787688557;
 bh=FDrkPD5ObLfJHUFTJ06KX67fB7PZHqtaH4lmBtJxURE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=B+7WtJZshOOjFW+yLZy6ljfsR2zZVWip3pjt22z9nYpSMw30yA9tA3wpe8Jc6Ml74
 sGf6v0MiEFrbl2+4C0oGn/UnVhuchfJSUTXDb0nQ63B5mk8+69ylaZ5rbH/ZP6HDTT
 DKnhLon50VewTR/anmeP7CTkTQ+3PBlFJD4wiE1KeY5P17OT+0ZhHpnSOywtkrMtmd
 mv2J9Z1Hz5Lsxe7Tg7fiEFFgLWwVdS/3DekJF6waJUEl8RS5pT4M6aQBIseiNtpw/E
 igsYDH4F55G1+k4IGDGh2OU7hZaJ0xM9xTnXon02f+J8I56iHCuwQ1J0/By67R6GiK
 jKDkpEhsUO0Qg==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Tue, 25 Aug 2026 22:08:05 +0200
Subject: [PATCH 5/5] docs: update hw/nvme atomics with mam
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nvme-mam-v1-5-afc38ac713ef@samsung.com>
References: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
In-Reply-To: <20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787688545; l=997;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=bXb68Ts72E8566BriOUvYWi/wdEdKcvMt5kLv1iA+2E=;
 b=Xc62ddX4hRlncEqKuMrQTa6DG/u8y89rumULSR0EmRM8sJrmZhOt/T3SHBzZGLZlyicmmIiYN
 CiGl+7x3RBgBQjCVc6g5woAOaGnidhjrYDOJDZikfWYOs5K65lnzPNA
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

Update hw/nvme atomics section with Multiple Atomicity Mode (MAM)
namespace parameter.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 docs/system/devices/nvme.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index ab3bb395ab4..6a6eb918e71 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -405,6 +405,12 @@ values are in logical block units.
 
 Namespace specific Atomic Boundaries parameters for ``nvme-ns`` devices:
 
+``atomic.mam=BOOL`` (default: ``off``)
+  Set the Multiple Atomicity Mode (``MAM``). ``off`` means the controller
+  works in Single Atomicity Mode ``SAM``. When ``MAM`` is enabled, a write that
+  crosses the Namespace Atomic Boundary is divided into atomic LBA subranges,
+  each written atomically at those boundaries.
+
 ``atomic.nabo=UINT16`` (default: ``0``)
   Set the Namespace Atomic Boundary Offset (``NABO``).
 

-- 
2.55.0


