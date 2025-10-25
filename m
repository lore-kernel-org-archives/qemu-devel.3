Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70941CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgzB-0004nR-1i; Sat, 25 Oct 2025 12:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgz9-0004ms-SG
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:20 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgz8-0004BQ-8D
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D3FD60623;
 Sat, 25 Oct 2025 16:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F07C4CEFF;
 Sat, 25 Oct 2025 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409156;
 bh=FND8rsNuJWvVjbyj2hs3c750kvVjLgqtceD6fSGSOco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TQZlX/zMXyF4B2tu2DI9cN7EyYmmTs+38y1iBSCZ7oJY8Haac5bTcfjoVHUJAIEh8
 am2zibopYVv8zPiP/2qMhrwi7PpIct83IJdzMnnR5ySaqFMjUSoVAeAS/Xr+kbwisu
 Uka8erXwj/MetdVf65E4ni9rtzcxWSi5W3qgXyKfNQ1+zr2eR8vcWylhF0lIR9SShM
 e4JHCACOU/EVFPwclf2SQZsx9HVEIsov8LWkwycaaGBPtFUxqPkOKF7GkCSp6Q7gfQ
 G7iKj5Ke7uA2evTJ5tRdGzn/v6ioHMK0Z3IYvrKCL6WelqcBS3wf4v5L1YXGhVoWV2
 dpFS7j7dEXuLw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 05/11] hw/scsi: Add config option for new ncr710 driver
Date: Sat, 25 Oct 2025 18:18:55 +0200
Message-ID: <20251025161901.32710-6-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025161901.32710-1-deller@kernel.org>
References: <20251025161901.32710-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Add config option and wire up in meson makefile.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/Kconfig     | 5 +++++
 hw/scsi/meson.build | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 1feab84c4c..5743ee9b4d 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -7,6 +7,11 @@ config LSI_SCSI_PCI
     depends on PCI
     select SCSI
 
+config NCR710_SCSI
+    bool
+    default y if LASI
+    select SCSI
+
 config MPTSAS_SCSI_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index bb7d289aa0..b874fe1ecd 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -12,6 +12,7 @@ scsi_ss.add(files(
 scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
 scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
 scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
+scsi_ss.add(when: 'CONFIG_NCR710_SCSI', if_true: files('ncr53c710.c', 'lasi_ncr710.c'))
 scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
 scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
 scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
-- 
2.51.0


