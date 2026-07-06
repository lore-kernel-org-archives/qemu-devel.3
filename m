Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F2AC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggip-0007Uh-Mg; Mon, 06 Jul 2026 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiT-00076V-T0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiR-0003O7-07
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so18285015e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334294; x=1783939094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vaarXhZ2gUUxnXrUImuA3SXpHAUC7gm2EOhq4j7dpug=;
 b=nXHS57vTHt5GOPGlzwnt3rvJmsjr/Vdfmp+teMdEM7iIrseihQBS4YtvQaVyl0PPLz
 ryX6IEZpnXDnEihlG9oRK9Ei4gavK/eut/OdNyIjMpZ5UbJ2vG8wtO2eO0es927yxfEG
 f57kciV7iAg28uxpbOT5NChX2YuCaJ+KupfZt90WEdYxqxzuQ1l0lyTo56nBdIQjK4SN
 UUsBg1HMUb/pT8YWQD1Vbk90ocDy8CcFBCgmDmOq8/+WAKQ9H3FB6puXYg741AAzEfok
 BGJafRjh7sbEkxD6c98DCwuDSelhEedFXEW4T8EW2XsqnqnbyZAONKLIsBnOAKOGjbw0
 QxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334294; x=1783939094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vaarXhZ2gUUxnXrUImuA3SXpHAUC7gm2EOhq4j7dpug=;
 b=dZg2KxVJ/GM/psj/e4RmJFmAQh35CYEaHaZT2Iy/g3g59yxmdcjslEfSA02q3H4GjQ
 RLxWPUZZh5dbJOtXNwr1AEeN1nQzGoHHSnPHo6rjgcTYJQ9yWXAT2MLfvVcN+dW8S2A2
 3eYFrTxaWRXOrt5/j9bqVbbEpqT/NIJ0DUS1rLN9p4/jTf1bhDCHvDKYCmvzyfoRVFje
 Xk28J+NRzi/mGChJjhImlGga9tyvbmvLEjmMOj+J2HtkyNmp7yCnCJ++pbgrivJ6LL9h
 dkUA7vOVTWmUMV4Z4kmDdlX0/4AOyVs3u1//v4ejuOK56Gi+n0DLPDoECT+wKTfACDci
 1BSQ==
X-Gm-Message-State: AOJu0YxnBVnlzr0xgdhIlPxBmxeKtlkHsQsfByHf1ZpfopvD/O91rPqp
 EGk91v/31icfHoHME9moIhaDUddBs12PcjVcc5Sig0HySIfx4yLJX8wkctcoCbQTh87FJP76o2r
 xNvzVzuBasQ==
X-Gm-Gg: AfdE7ckZQFvlc/hQbFYiwZEPAj6GcDwRSXlTtZcH4ZJx5L8OAMYWbBBAYiqdxcyCB2U
 X9ILHIwAGKGpx96VThvZPau9iID9hdvxNF4OI6viV0fL2AcZsOGhYBbn88E4z1+tB4CZ2dE8t8/
 X9ijAaQyWcErCJGpEGouZMBrNRbCxcI36QUfADxh5s9+p+0ggXEJU9XSjD9fTf3beSgzcXVVZz8
 iK66Eijysu8hOlohcysFYOJo2MD5FVk+W92fABY4XesNG69l4MnaHVZdRStzmfkupAblxvs64n6
 Uu4cfK7JHlCMiPiGQsK3PPDea7riXcxHbILEMg2Xty5WT0oYiDlJqz3i1fhfSRxK0yGY9Vq+KSh
 ZQYjG+R3dtsKItLidNTB7DdjttXLdfxcmXedTkETi9zuixC8+rMJXpnwxOO2joGDRDv2rqLr1pS
 FB8ISqEklpUgvh6qqRdo3gx9WLUSt50JehivyXswj+oaoRzvqFR09OlF1jtA7eZwyApYdCGrJwt
 nNZjIKmXR/I7nTspeb0bg==
X-Received: by 2002:a05:600c:628d:b0:493:c2ac:58f with SMTP id
 5b1f17b1804b1-493decbf152mr1099655e9.8.1783334293621; 
 Mon, 06 Jul 2026 03:38:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/49] docs/specs/fw_cfg: Document all architecture register
 layouts
Date: Mon,  6 Jul 2026 11:37:21 +0100
Message-ID: <20260706103752.320511-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We implement the fw_cfg device for more architectures and machines
that we let on about in our documentation.  Luckily most of the new
ones (notably riscv and loongarch) have followed the straightforward
layout that the Arm virt board picked.

Restructure the documentation to present this as the "standard"
layout, followed by the other layouts used by various other boards
for historical reasons.  This adds PA-RISC, SPARC, PPC and MIPS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260529174639.451353-2-peter.maydell@linaro.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/fw_cfg.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
index 31ae31576b..7e2fe0851d 100644
--- a/docs/specs/fw_cfg.rst
+++ b/docs/specs/fw_cfg.rst
@@ -84,15 +84,35 @@ increasing address order, similar to memcpy().
 Register Locations
 ------------------
 
+For a memory-mapped fw_cfg device, the standard register layout is:
+
+    * base address : Data Register (64 bit)
+    * base address + 8 : Selector Register (16 bit)
+    * base address + 16 : DMA Address Register (64 bit)
+
+Some architectures or machines have a different layout for historical reasons:
+
 x86, x86_64
     * Selector Register IOport: 0x510
     * Data Register IOport:     0x511
     * DMA Address IOport:       0x514
 
-Arm
-    * Selector Register address: Base + 8 (2 bytes)
-    * Data Register address:     Base + 0 (8 bytes)
-    * DMA Address address:       Base + 16 (8 bytes)
+PA-RISC:
+    * base address : Selector Register (16 bit)
+    * base address + 4 : Data Register (8 bit)
+
+32-bit SPARC, PPC ``g3beige``, ``mac99``, ``prep``:
+   * base address : Selector Register (16 bit)
+   * base address + 2 : Data Register (8 bit)
+
+64-bit SPARC:
+    * base address : Selector Register (16 bit)
+    * base address + 1 : Data Register (8 bit)
+
+MIPS ``loongson3-virt`` machine:
+    * base address : Selector Register (16 bit)
+    * base address + 8 : Data Register (64 bit)
+
 
 ACPI Interface
 --------------
-- 
2.43.0


