Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA399C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXY-00062V-NZ; Mon, 13 Jan 2025 14:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXW-000624-P8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXU-0007SO-5H
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso33945725e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798153; x=1737402953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jys96smoYe/UFvAgEu5KOk6WoWGY0ynuT+FPBUQuY0w=;
 b=Zn+ttxDXafHcLz1oYjOfSb+vy/5rludzVXCPKOpGgCpf2lr03TeWKFT3s78eYaAU7i
 3zFSa7IsJCNtL2MKdqffiR0+A4FbyPPzcoRGRT6mW9/0P91GZpJcoUsvUNUdTGSVx82P
 awxMs7eWwLNPLZcwHo106E2wts20Flqd9XW3HDz/yqB2sP3hfpXzVjFFH1cKxTLv7QTn
 ckg7gId0sOvkwyaqrmrJpWiORfovjcGDYpie3dT3iPepSJKkUm1oQIGYJuCE9Nx9EUGa
 h5rmA6ka7H2P3PFQVW6CyGljsz425NqC8FNXKoc7QdlgEgxAr63+HxBzPwo+fyXhyk8f
 ocHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798153; x=1737402953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jys96smoYe/UFvAgEu5KOk6WoWGY0ynuT+FPBUQuY0w=;
 b=CCksE/J9ixxjw1Edayo6gL1gqmsTZ51OlgBiCMFnwT1tDCUAT3uY2WYhOkvpKJOz7a
 GLTfAVaA1RxDUPkPOhQGKGhyRrhcosJj/L6wzDZW6V6oW/yfQn6VGS/Texyjxbz0qlfY
 9Da+nV22clULv/i1pbq4ZAPO9e0OMdGXGbHWNz7b1b5R0PVNqOnrJS9enQ1UDPriDGIU
 OgDmegIoQnOswx1bFB1OIV4dkO+cMtWwjuzHBPWna2ezNgkdVex485gUCkjRuExaWuy9
 HSzijHkfL4Wig4JivHjg8iGlxURY8/wZ86Ec5G1mXaSgn1lIzSoyB7BQ5tYgkSVSwGe1
 naCQ==
X-Gm-Message-State: AOJu0Yxx37TPh8sOUcu0FuK3rjoxeV4dmcmeLqJMKF/pDQUhmMEQDBYn
 cXxkYNi8Q7s2nM2ajolfZk0Y5o/Ucb8fnKgUGq/525Za8pS9Pf2AgYZxe3GFT2OoDCMRMoXgewh
 NK9A=
X-Gm-Gg: ASbGncvBkSvtP/rKvK9MkJOw6+4c9mLXZOKYu4JT4dl+GdmXmzW4c7QG7N70M7+N1JT
 Uzis7mUGwdCtXiY/p1sWZqrzljw0HSGb0GBwiJSXZi3IZ4Pt43E8I28csZLJihaqeEsEXTwJVzt
 aNN0neDY9XdaiuDK71CU1S5f/tDRH+h185DwUHnS1q2WFvzEqDn+AGAtmj7FO0Mu/SKy5/btKDl
 crfw7B3QLo/UpD/s/P/2jR+NvvlnDthVOLuZgq62+i4Dx8K3B/ChvWUP7YKUbnd5VRuyqyqmWMa
 pqZBkeKy1g3oro3Ex1f9HQquTyR2In0=
X-Google-Smtp-Source: AGHT+IGDSAWjgw2xXE30fI52dN56bBLo8YsKnvMDyDrobScNG5zs35ymvZ8+FK70lmH2hKSaqRT+cw==
X-Received: by 2002:a05:6000:712:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38a87306e8bmr21535020f8f.21.1736798153020; 
 Mon, 13 Jan 2025 11:55:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0bb7sm185609735e9.16.2025.01.13.11.55.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 05/19] hw/mips/malta: Propagate MaltaState to
 bl_setup_gt64120_jump_kernel()
Date: Mon, 13 Jan 2025 20:55:11 +0100
Message-ID: <20250113195525.57150-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Propagate MaltaState to bl_setup_gt64120_jump_kernel() so
it can access the MaltaState::cpus[] array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ec8fd954b4b..f7eb990c629 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -620,7 +620,8 @@ static void network_init(PCIBus *pci_bus)
     pci_init_nic_devices(pci_bus, "pcnet");
 }
 
-static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
+static void bl_setup_gt64120_jump_kernel(MaltaState *s, void **p,
+                                         uint64_t run_addr,
                                          uint64_t kernel_entry)
 {
     static const char pci_pins_cfg[PCI_NUM_PINS] = {
@@ -720,7 +721,7 @@ static void write_bootloader_nanomips(MaltaState *s,
 
     /* to_here: */
 
-    bl_setup_gt64120_jump_kernel((void **)&p, run_addr, kernel_entry);
+    bl_setup_gt64120_jump_kernel(s, (void **)&p, run_addr, kernel_entry);
 }
 
 /*
@@ -786,7 +787,7 @@ static void write_bootloader(MaltaState *s,
      *
      */
 
-    bl_setup_gt64120_jump_kernel((void **)&p, run_addr, kernel_entry);
+    bl_setup_gt64120_jump_kernel(s, (void **)&p, run_addr, kernel_entry);
 
     /* YAMON subroutines */
     p = (uint32_t *) (base + 0x800);
-- 
2.47.1


