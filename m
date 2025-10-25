Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B82CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgzH-0004pZ-Lm; Sat, 25 Oct 2025 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzF-0004pE-Sm
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:25 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzE-0004Cs-9F
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:25 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3979245075;
 Sat, 25 Oct 2025 16:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73146C4CEFB;
 Sat, 25 Oct 2025 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409163;
 bh=/XXWfi8pD6qSTMHtGWWp2z43DWCV+pClOPHviXTeCnk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EYyA2dUidLWXOVfGWKnjFYhdRggL4bxoUGws3a8mGel/4nl7bEtJ86Ci9A6r3akDQ
 O/z7I/ddSwBc1FxOYgYTe8yZDYH2lRmEKg9+qCY/OqcDonFEeJR5rvrn4AH7DOTGQt
 DsJkkn4tBmRaXtbRK53RnEAHZlEDjUKRqsNmvPR75qSkMHFB+styQefS2+sdcs71Vc
 GoAH5BIxR1vRRyXywgVovwBh+9I+2j4q6FXEDcoixKqt2pT5r8OsnJoqFaWmKf9IrG
 SHoe7P6SMi3RKBnHC15aKq8ni0TZ1OWJn5JrdNUztGM1b2T/0llBwhGE+Mmgm07l/F
 HxuepPLRoXo5Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/11] hw/hppa: Add NCR 710 SCSI driver to LASI chip
 Kconfig entry
Date: Sat, 25 Oct 2025 18:18:58 +0200
Message-ID: <20251025161901.32710-9-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025161901.32710-1-deller@kernel.org>
References: <20251025161901.32710-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The LASI chip is a multi I/O chip used in many older PA-RISC machines.
It includes functionality for NCR710 SCSI, serial, parallel, audio,
i82596 networking and PS/2 ports.

Add the functionality for NCR710_SCSI to the LASI Kconfig option
and move over the relevant parts from the generic HPPA_B160L Kconfig
option to get the dependeny rights.

v2: move dependency to NCR710 to LASI chip instead of base machine.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig | 2 --
 hw/misc/Kconfig | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index cab21045de..9ede4d1140 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -17,7 +17,5 @@ config HPPA_B160L
     select IDE_CMD646
     select MC146818RTC
     select LSI_SCSI_PCI
-    select LASI_82596
-    select LASIPS2
     select PARALLEL
     select ARTIST
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..fccd735c24 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -212,6 +212,11 @@ config VIRT_CTRL
 
 config LASI
     bool
+    select LASI_82596
+    select LASIPS2
+    select NCR710_SCSI
+    select PARALLEL
+    select SERIAL_MM
 
 config ALLWINNER_SRAMC
     bool
-- 
2.51.0


