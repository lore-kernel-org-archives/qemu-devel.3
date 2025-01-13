Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCCAE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8fC-0000VJ-1z; Sun, 12 Jan 2025 19:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eh-0000CN-10
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:50:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8ea-000153-V6
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:50:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361c705434so26498505e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729402; x=1737334202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkJ53c1g/A3oVfRH9YrVVOx2OwtqwRGMfXxog5aOHSQ=;
 b=Qkx3EAKx9rT9PDOGrRdLoM6tw4XqjH0FtGEsKs6I1f7KP15BNzENIf8L849Uv2ZHsn
 ySW1vyuA1RmyqMWu0Nd+W5kq865RgcgQLalslEX2d/6OxxMy60/QRfOnzA19DJNW3weB
 B94vhr8VGZyPFpAwhFI9uDR+TK7xruwS4gdaW/T/a/uiNOGohpQDtM2jZDH/OQ8wlN4/
 WPI+JMi2m3vmrvA+BTjaNvmskKwPwhqsg4xWzBOPR9h4LuwBxmKaqwTUFrZjblEp8Gox
 9n+SW2XPfND0e76Pmb15FA6s6zSn0v/hYsRCwudCDAotwLnibEFOQh+esLpByALoO2Kc
 gh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729402; x=1737334202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkJ53c1g/A3oVfRH9YrVVOx2OwtqwRGMfXxog5aOHSQ=;
 b=qitcUCmwRZSIR8svJF1G4BOipiz8jQSIF/pMQh7YL2qyql/7ugjmTQTK/RougbTMLu
 8Z+OJFadjsIxNUIT7Aayym2I2kHqrTv5w7PAQfjEbt5PonrfkfqWGFhGAHXZv0QpVxjG
 21kCPT9Ye2gzLVIRhSpZYdpSDtYDIbbrbUD7b0k8ubigqMRRx6a6OQ/N5utgvQy8TOyO
 Sbn5LZfJnEXlMpicVX//S+nPMw2PwJOo9S0wy9TIzmqZ+H7gfD4XjI/pH4p+IhPz6AcY
 6tHnCdO2+a7nMjmxIsv2huoJjFJXkKjUFEnyznkvopInWFcmZyE5BYQegnId7ufl3krt
 BL+Q==
X-Gm-Message-State: AOJu0YwSphyY8B+D/sriWWa4z7MAq7628cCc2TAwgEpigceONmIQUTnE
 6p1HmNFoipxaeILbiD+WKcnYdqI/8xceuJYGk0lk+yyL0mDnuyK8P00UgXF+Rz7+qzgUBtFtozX
 HBOI=
X-Gm-Gg: ASbGnctvz5Mw0CfIA8aqDkGfum+E2ZzPGzWql6E2qlEPsmn7k9uQOqzQR/ED8aaayH+
 igc0RVABkq6mua3zggwUypm8tqyqNsUbJJI8o0BvBqDMfbIo68TVPtxRh6lVqCtQAMYxviHqmKo
 7oQ16KdUi2aOuoqbzmrV/+RkSs3TZ7dwu2oNnu8KESuZT7hQGFiW9SVajz9Unws65VKF30dFAjh
 Ux2pBdXPVCN7xjwE8UoKvbU8La5RTIsFU8RS2WrWsShck1aeA2PY86gygRJgM+YMc+DC2J0Imw/
 1fHTXDRlA1EaypZPUWl8KmaOWI/6Ou8=
X-Google-Smtp-Source: AGHT+IFRFBAoVg0Hr+JW3DVRqrODAWytXr5Rr97D7olpsZBeFvs5Ypcx9kgpBq62cd0MSG+VtBtgvg==
X-Received: by 2002:a5d:5985:0:b0:38a:2798:c3e0 with SMTP id
 ffacd0b85a97d-38a87358f3bmr15835355f8f.54.1736729402089; 
 Sun, 12 Jan 2025 16:50:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd11ddfdsm122124485e9.1.2025.01.12.16.49.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:50:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 23/23] hw/mips/malta: Remove all uses of &first_cpu global
Date: Mon, 13 Jan 2025 01:47:48 +0100
Message-ID: <20250113004748.41658-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Now than bl_setup_gt64120_jump_kernel() has access to the
MaltaState::cpus[] array, it doesn't need the &first_cpu
global anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 61b47b0dcbb..9622e122b4a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -638,29 +638,29 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
     /* setup MEM-to-PCI0 mapping as done by YAMON */
 
     /* move GT64120 registers from 0x14000000 to 0x1be00000 */
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_ISD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_ISD */
                      cpu_mips_phys_to_kseg1(NULL, 0x14000000 + 0x68),
                      cpu_to_gt32(0x1be00000 << 3));
 
     /* setup PCI0 io window to 0x18000000-0x181fffff */
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0IOLD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0IOLD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x48),
                      cpu_to_gt32(0x18000000 << 3));
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0IOHD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0IOHD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x50),
                      cpu_to_gt32(0x08000000 << 3));
 
     /* setup PCI0 mem windows */
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M0LD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0M0LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x58),
                      cpu_to_gt32(0x10000000 << 3));
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M0HD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0M0HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x60),
                      cpu_to_gt32(0x07e00000 << 3));
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M1LD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0M1LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x80),
                      cpu_to_gt32(0x18200000 << 3));
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M1HD */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0M1HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x88),
                      cpu_to_gt32(0x0bc00000 << 3));
 
@@ -671,16 +671,16 @@ static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
      * Load the PIIX IRQC[A:D] routing config address, then
      * write routing configuration to the config data register.
      */
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0_CFGADDR */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0_CFGADDR */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcf8),
                      tswap32((1 << 31) /* ConfigEn */
                              | PCI_BUILD_BDF(0, PIIX4_PCI_DEVFN) << 8
                              | PIIX_PIRQCA));
-    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0_CFGDATA */
+    bl_gen_write_u32(s->cpus[0], p, /* GT_PCI0_CFGDATA */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcfc),
                      tswap32(ldl_be_p(pci_pins_cfg)));
 
-    bl_gen_jump_kernel(MIPS_CPU(first_cpu), p,
+    bl_gen_jump_kernel(s->cpus[0], p,
                        true, ENVP_VADDR - 64,
                        /*
                         * If semihosting is used, arguments have already
-- 
2.47.1


