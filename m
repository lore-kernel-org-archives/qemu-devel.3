Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDC0E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8ee-0008QQ-TB; Sun, 12 Jan 2025 19:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eV-00083a-FT
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eT-00012p-TD
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso25910615e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729396; x=1737334196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QUcPQTSLIyjkEu3IRNgiae9ESabUrMs06G5+aRxsH0=;
 b=lM6VgTrQfYuHCskd5dXXjUTcIm1q2JYDpHdyhcwU9uAAuXWz1bjgN3zUSPCxpkzJeM
 GSa0Hg7qHfTU9LBHcpCoTPcbKJ9mMUtGX9fzQCwRoRmEv+nD6XC9ldmxfdMLDciUhqEi
 Irsu0m2bHcDRSXfwoeHMIfpzy2/pWCJBVNudUCEB4ejrAq8zxEeEoiJg3BjsIxOsUlYd
 LhDSM9/wS/pdu+i77IpapU3yHTI+MuC489AYjJ7eY+zkGnSZZ98hVOkuHakKi2uI8gvz
 7md/pXVMRjzQxJBwPpTl+d+J5L/I+a3S/Juq+nmqMkoDYLz5LOxM2iu24BM8vJozyvbr
 LTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729396; x=1737334196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QUcPQTSLIyjkEu3IRNgiae9ESabUrMs06G5+aRxsH0=;
 b=cyO1e6vgSrbUTYbn6mxNNaro2k5oKFcWSCa1C8y2Ge194yHFnsobjSaDXwqIHgYj3V
 QojryWOue1IGrypkzvWUW0zYjec+GY2Jw+48ldSplGK19Mnn5PxYvzThfbYF+hEuagjp
 IGhO/2HHoGCyJxhLJ2bw8SE77ARV6cpzRvk9vK/93qKn2vMlGvMu3C4psYAYv4DWZ/M+
 8Z/TFFw3Es1QSr2MlQ91R0UgMnMSWL5obgT7uN9m/8FO4MoQPdpkHdLk63B+P5Svu4R2
 +6GI1h7yUqAsTwUavfTMTffd6d263VlwYDqRk5AYGhGa2lN4TPBzxbbzLAFZK2g+BTxG
 LO5w==
X-Gm-Message-State: AOJu0Yxuf8OCCkyT0lj/gjezQeacACOBsjmQzhW+1x5oqCHX1Oj1vSue
 p0dAHgKqe4YLjkNSVY8WMsrtYK0prFUJ2hXIc0Pm7Dfc4eOQ9/kpYw0eoU/S+rb1qxyq6d5yuDQ
 Uve8=
X-Gm-Gg: ASbGncvkP7MV8Dsvo1DwxIgk20TYXrDMjHcAYDOcdSWLtTxEl+6RwRl5XPk9KbnWEHI
 0CA+U9jrQNPkB+F1w5Mr6rFGxTTIxOwUEg4UCI7hIORQgKPGEzIGoVOZYJel950azY4UgfxSxvZ
 s6lmTMGsZwRChk9i4+J56jQzChU49YBIbS3PiK9YvaNs6w8NdSUf83OQ5mchWNV0OGaPoU1hx/2
 rUr5KJlkrO2/T4TAKxpK/UarODY3sXXIt2a4rI/8dMQzdt9rf7NduGJKdSppyZjAGky6B0OOqz/
 ZmTB/87R2LlOEQR2dOXRKPn3OSbPGOk=
X-Google-Smtp-Source: AGHT+IGmPYK4+yml9nEJ1vg0hf99C1ulpd2K6QbPMkfU7wlTpKi0fvy2lJc+zNbWUPdOnuTUBGFOwg==
X-Received: by 2002:a05:600c:3554:b0:436:1be4:c9b4 with SMTP id
 5b1f17b1804b1-436e26ff1b2mr151791665e9.27.1736729396028; 
 Sun, 12 Jan 2025 16:49:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc895esm125348935e9.13.2025.01.12.16.49.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 22/23] hw/mips/malta: Propagate MaltaState to
 bl_setup_gt64120_jump_kernel()
Date: Mon, 13 Jan 2025 01:47:47 +0100
Message-ID: <20250113004748.41658-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
index 589e1a07e47..61b47b0dcbb 100644
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


