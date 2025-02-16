Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74EC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlmF-0003gT-CJ; Sun, 16 Feb 2025 16:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlm9-0003YO-2S
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:02:08 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlm7-0007xk-IX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:02:04 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2857620f8f.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739722; x=1740344522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mX8deahLJd9g/czOO8F+DTVRecS9AsmpyHYz1+koZZ0=;
 b=ZzxqfvIwCUff/A50ax3KHIBt7kzq1SvTXvItWtY8Y3YAeJzfUDADS2s+gx3I381DT3
 JGdFG/jehFiQXygr5patrWhIFvaMuovAyVmFkEuhr4wWuy2zcQ4WEAbSDW7XaSxKaXYo
 jB9h73aMZIP/ksw062MAipbdPIIvPT8LkZBNYXe1Ro881Pl27cgS3kpBTyO/fqbO4iG5
 8Ekp1bPuG1pmFa36boNbhbuJWcvmwIi1bE8RSzCRGdm3tEQx2Ty8B4SOpEoOCwRbe5tN
 lprTxMSgINDlaFrrs4NKSYqYWeDnwsOtRjlbWf2swwLX3BNnyl41yhS24LSBMlIa6A9a
 73EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739722; x=1740344522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mX8deahLJd9g/czOO8F+DTVRecS9AsmpyHYz1+koZZ0=;
 b=YaNsJA+gdJeqD2Hk16u+UADXP8J4OuJ8RFedoZvup8q/+g/gyzY2WRXUc9TJGJ2ZK7
 jECAjGuaTYijzDGDCHhrfnKc1BS3mZsRm3kNFMScgWAeZpXa0gHeIUh1YcIDSLqIBHlW
 X81e1gAs/h4Uy+imqGDQ3EbF7qxeFZh+r3qCBz5dV6bEmRpWFSEMubzspOvO12kY3Qtt
 YNc0YByHep1M+8O0A4LYL4mY6m10bMPJ+NLCIpr5MoKyBpFtN+fG1rx/DEYABH3qg6Qi
 H4KYXVpAW5Z1jdFv7YjCTDw7lRAFYgqRpylyIxDneYn/ZuHYVi9zGaxKRU7avun3hFbr
 TZsA==
X-Gm-Message-State: AOJu0YzM5ZUKW3kE0iwPlu7/3nWqXErrhEmxsxhA64lKaMsjYVPUtLpC
 ObDLDE6j9Pi2imtiwncHOl9lLptiegFXRN+ys/JIMtUzmpHcedQ7XYL1saKTq1tbenanhMLbSyd
 bo4A=
X-Gm-Gg: ASbGnctxG5cyC9hQ5S0cR+2zgsS9V+tWCke5pXf4YR3FVRe+QYXdiR17xA8wxzk+9u8
 m5EUofp8PWfpJbXUP1NZo5aobZcFmBbenflcFNsm1jiGLg4VSuejVMNyBNq43q/WKRDlc0X7+4I
 Cgvx3P1yFliFur2O0Wpo4QcHKnr+8pe069n4ELUiwYo/bmmjbQIO+BlNsWw0s5aD+OntWwuwEVv
 0LExpmV8QMJy6dkQ0BBIoNzLhEWbk7+V3Z5ZHdArt/z40bF24BJkAOmUKnrDlwkuI312WpcNaPP
 Sk4dobsLs9/6BDhGkX0kAoXL25cn009uyDoN3puoSRWkOrFGSDQtj+hDQyTHiIZOYrwDHtY=
X-Google-Smtp-Source: AGHT+IFQo9SGkpWDZBdZBKoF59I+BynJ+8ezYFrY5v3y8IG8Qo9MHc0lShH7uNs+f8bJTd6SKmr2hw==
X-Received: by 2002:a5d:5889:0:b0:38d:b8fd:591f with SMTP id
 ffacd0b85a97d-38f24ce76d0mr16806733f8f.5.1739739721676; 
 Sun, 16 Feb 2025 13:02:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8115sm10579717f8f.92.2025.02.16.13.02.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:02:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/39] hw/rx: Allow execution without either bios or kernel
Date: Sun, 16 Feb 2025 22:01:03 +0100
Message-ID: <20250216210103.70235-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Keith Packard <keithp@keithp.com>

Users can use -device loader to get an ELF file loaded to
memory, so we don't need to require one of these options.

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250215021654.1786679-2-keithp@keithp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rx/rx-gdbsim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 88c8f12c101..4afd77efd56 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -110,9 +110,6 @@ static void rx_gdbsim_init(MachineState *machine)
     if (!kernel_filename) {
         if (machine->firmware) {
             rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
-        } else if (!qtest_enabled()) {
-            error_report("No bios or kernel specified");
-            exit(1);
         }
     }
 
-- 
2.47.1


