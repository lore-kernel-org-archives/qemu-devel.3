Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA4CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjI-00060X-UX; Fri, 17 Oct 2025 16:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjF-0005zM-Ov
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:09 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjC-0005Nz-Rv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E4A2E64620;
 Fri, 17 Oct 2025 20:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F9CC4CEE7;
 Fri, 17 Oct 2025 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731625;
 bh=URW2V7zPKBtVw4Jw8sBsKuV6eyWwm2Cw9QxpicWv3Gg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XVq+/CyzFzpA7CSHXLON8HbgtBYHzLW0zsWJC38xZP4og84qoKMdx4KVtZm7egSPR
 DeZhZS2BIZMb3dz7KgcxtfZmbLzQAgj1fOV2T9cc1LQSl3SMQ9bO9C0XEaYQUdW8HJ
 +XvB5lgJi3l5TRS+jIUG+CkXDd4JQM3FGmGYSBzEnJywoQcTORDe1rs3HDiaeHGju1
 i3CVNU+GlRbE0lKWwa89uwCeHg4CWGmU25Za9k+9MZcsBlzZveYBembsR3at4pV+YJ
 DUM/90KjYNONGP560F7amMYrMruknJN5vNfLs/Iby/Sk0EeYQVgVoaewcLYFndNJrY
 a69aGyEpw8ugA==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 05/10] hw/hppa: Fix firmware end address for LASI chip
Date: Fri, 17 Oct 2025 22:06:48 +0200
Message-ID: <20251017200653.23337-6-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The base address of a LASI chip on a 715 machine starts at HPA
0xf0100000.  Make sure that the firmware does not extend beyond that
address, otherwise it's not possible to access the LASI ports.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 21c777cba6..d422af0429 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -5,7 +5,7 @@
 #define HW_HPPA_HPPA_HARDWARE_H
 
 #define FIRMWARE_START  0xf0000000
-#define FIRMWARE_END    0xf0800000
+#define FIRMWARE_END    0xf0100000
 #define FIRMWARE_HIGH   0xfffffff0  /* upper 32-bits of 64-bit firmware address */
 
 #define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
@@ -19,6 +19,7 @@
 #define DINO_UART_HPA   0xfff83000
 #define  DINO_UART_BASE 0xfff83800
 #define DINO_SCSI_HPA   0xfff8c000
+#define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
 #define LASI_UART_HPA   0xffd05000
 #define LASI_SCSI_HPA   0xffd06000
-- 
2.51.0


