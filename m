Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CE6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffG-0001vs-80; Thu, 15 Feb 2024 12:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeW-00087C-Fc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeP-00043D-4g
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:03 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so482703f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018554; x=1708623354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdUKgKKtAN5IlCW6zloHfwl8PaZi+HbzzsL/pKG57pM=;
 b=wFeLo8dKQKa3iy5lGhllJdcVgHPLoiRBCmHI3P2Mf8jrDB2RcglGQ/iZkjVYIJLcgJ
 cMYSFqq8JezBrmj+qkHMNkS8JgkYwMi7stqsDmqYDqgdgjYvXR45MXVbYTpamMwTXYZH
 KJYW86qIDwr56WckhXRaHJsGamQntXr13Zoir2pMfmYqqlQH/AZPXbow4q3JOFmoN8Di
 7ArgyEwXoIv764kbYoG+6rqcXTzCaHrMW3rNYwt8dqvZ4f1FDXjKUaZzIE4xSkWq68rA
 EacyEJOT9kOH7zq5j6NQYJPIVPy4HUaZEF0mA2I4aRNkvLFaFFj7u10ZC8XOd6AdH9EB
 iDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018554; x=1708623354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdUKgKKtAN5IlCW6zloHfwl8PaZi+HbzzsL/pKG57pM=;
 b=jMq52PCpmrtUYJIA4hNgDKtHOQAtpHpqalV23HcvH5x9Bex/qjIzXZscqkVAFCXqst
 5CKedHOfIs5WepN8DTbKstFmA9XM5Zfjwk8i+BR4Q4Su1pl07YnA/qmUvlo/v1uS6C/Y
 YLC5wyIRBLYo37eGCMBGbxIBIExXPGOj3PM/3fSWlJSERZVsPRn9auMmmCh284RnF6g5
 7g/T4SjIG/zimhetHa0RukqU0QrYIuO7SJm9l5u3kDbyAycnc/1pGxgGPfZNRp68eNwa
 0aPRL02/4WNW0Tv/s7jSGt4VMMBd8k6VuE/LZTfwpZd11aOe3dZdAhUFzP8eS64LBtnF
 PIww==
X-Gm-Message-State: AOJu0YxG9xSI510Ad48ncvwIbK1yG0ShPumSmG7vx7pHGe3O5XuyD/Jf
 DchJGts5+PdwHYjG1L8MoxtoFQSnh+KKQpRApCmmHWEmIG8/7pPZ/B0eoFn7arEgdehMMiGu+c3
 3
X-Google-Smtp-Source: AGHT+IFL7IGkhoRhjest5NWIs5u5ul3w5I1U+7NQZdGDB1mdsgLqAXff8aTBY6kUCO9Hsoncu6JR6w==
X-Received: by 2002:a5d:6043:0:b0:33c:eb37:1748 with SMTP id
 j3-20020a5d6043000000b0033ceb371748mr1758951wrt.59.1708018554685; 
 Thu, 15 Feb 2024 09:35:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/35] docs: Add documentation for the mps3-an536 board
Date: Thu, 15 Feb 2024 17:35:38 +0000
Message-Id: <20240215173538.2430599-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Add documentation for the mps3-an536 board type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206132931.38376-14-peter.maydell@linaro.org
---
 docs/system/arm/mps2.rst | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index 8a75beb3a08..a305935cc49 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -1,7 +1,7 @@
-Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an547``)
-=========================================================================================================================================================
+Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an536``, ``mps3-an547``)
+=========================================================================================================================================================================
 
-These board models all use Arm M-profile CPUs.
+These board models use Arm M-profile or R-profile CPUs.
 
 The Arm MPS2, MPS2+ and MPS3 dev boards are FPGA based (the 2+ has a
 bigger FPGA but is otherwise the same as the 2; the 3 has a bigger
@@ -13,6 +13,8 @@ FPGA image.
 
 QEMU models the following FPGA images:
 
+FPGA images using M-profile CPUs:
+
 ``mps2-an385``
   Cortex-M3 as documented in Arm Application Note AN385
 ``mps2-an386``
@@ -30,6 +32,11 @@ QEMU models the following FPGA images:
 ``mps3-an547``
   Cortex-M55 on an MPS3, as documented in Arm Application Note AN547
 
+FPGA images using R-profile CPUs:
+
+``mps3-an536``
+  Dual Cortex-R52 on an MPS3, as documented in Arm Application Note AN536
+
 Differences between QEMU and real hardware:
 
 - AN385/AN386 remapping of low 16K of memory to either ZBT SSRAM1 or to
@@ -45,6 +52,30 @@ Differences between QEMU and real hardware:
   flash, but only as simple ROM, so attempting to rewrite the flash
   from the guest will fail
 - QEMU does not model the USB controller in MPS3 boards
+- AN536 does not support runtime control of CPU reset and halt via
+  the SCC CFG_REG0 register.
+- AN536 does not support enabling or disabling the flash and ATCM
+  interfaces via the SCC CFG_REG1 register.
+- AN536 does not support setting of the initial vector table
+  base address via the SCC CFG_REG6 and CFG_REG7 register config,
+  and does not provide a mechanism for specifying these values at
+  startup, so all guest images must be built to start from TCM
+  (i.e. to expect the interrupt vector base at 0 from reset).
+- AN536 defaults to only creating a single CPU; this is the equivalent
+  of the way the real FPGA image usually runs with the second Cortex-R52
+  held in halt via the initial SCC CFG_REG0 register setting. You can
+  create the second CPU with ``-smp 2``; both CPUs will then start
+  execution immediately on startup.
+
+Note that for the AN536 the first UART is accessible only by
+CPU0, and the second UART is accessible only by CPU1. The
+first UART accessible shared between both CPUs is the third
+UART. Guest software might therefore be built to use either
+the first UART or the third UART; if you don't see any output
+from the UART you are looking at, try one of the others.
+(Even if the AN536 machine is started with a single CPU and so
+no "CPU1-only UART", the UART numbering remains the same,
+with the third UART being the first of the shared ones.)
 
 Machine-specific options
 """"""""""""""""""""""""
-- 
2.34.1


