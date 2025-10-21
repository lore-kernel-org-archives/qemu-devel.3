Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B84CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGT-0004nq-F9; Tue, 21 Oct 2025 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGQ-0004kH-6R
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGO-00013d-9L
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so57697215e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079641; x=1761684441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5qQhUmfu0ijfC215SBBbz2xixP8xuF3X5oCDjiJUZ2A=;
 b=St09JX1WXvMi3TuZtFCdhu7tgrA69CFNeKk9pfUf/QuICf2rSa9rKVQRtWgHMrU16P
 ejPVt9EyZACF44L2NQi0/laBfhpOrJ57gu1zdtrib/x2dHxoF8hvSFoVOtVuv47V5h9z
 ZnAXgK6qhwmHk79q9T1ZU8wFgdLucNxWxUGju7LNDemvCk3JvzrMsRx/0YwToeYXmlGD
 DbPFB4s2L+lL4sckEZs4sKFwPI0a8mjUj05hS+0dp60E+/LDa8XCpfUheLsYT4/YNtnE
 gw4O7vwgBUZWE5onOVzVHGw2TChGeflClOK6IXnw2wpN7mLzfVHFDFb6tufuO7Qitr/T
 bCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079641; x=1761684441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qQhUmfu0ijfC215SBBbz2xixP8xuF3X5oCDjiJUZ2A=;
 b=pANizN5CFCZgnV1ToAh34oPvU6yr3MGF4ovQuVOFBksx7h265IOYQpG8qlrJwY2ReQ
 Bxim4WC7ZgmB63KDHldMmye2MfU/bP7O4N/BOhM0TTuJnaQEXTOLaYSEzzQ25a81NxYc
 yU757pqOgIAu6Qaqg5WS5zWQ8F5Vix1Hk9UkG6Ofr7L3QNY0k3vKAzhaswWP2OWjFhXJ
 sa6D7Tvb8gFgm310b2IFI8S2iMeatJsFcs/hfFgTPiSbRWQupICB3E6zfftuRLx3kNHB
 dr8S0D3/FzEslV8vkCmwQUTWpk8A8N1o33hTyWyiPIJYCvnX7/Ui9rLSVJ36KjNs+bC5
 oI/w==
X-Gm-Message-State: AOJu0YzVfAFy4RqKdCyIjRpelMIuxjJwER4mdVP5s3EtQRvo9L54UWXO
 9Bwa4BIi+wLdvaPkrLMBjhJ4mQY16cs6QwxharIjkomaCRX1uMO8w6LhvpRvhudhYcn+I34muNU
 rU+YILNk=
X-Gm-Gg: ASbGncu1ACtb5UHz01JNECXLCtjQ6OAgHRcebnC8TdTBlSL36q9s6q/u7VQnTi4leR7
 be4FqV/iRvcRiMz0k5faTS9FLHoMmBPG6akEv3Wh0Boh8BeFdP455stRMnFg7694yAbTTfCkG0i
 v7eqFCeFWaQT1dxM1enM3vIrbPN+ZgHP2TSDeP/yUvnbdKzW0rbdYz0R2GScmDxGRerD+q1Dw4a
 jennh0OVrP06wDmLbncjJYRkUG3W2wUwQyLpNupmwEBeEZkmolK+MLmjqdnC/CMOQxP1dPYrG0i
 vPy1kBxQGNHQlKTpRyj/IDJvJs6Iw9qoTQNc6+KAf5+i4d42XmEGDOVP848wWQ5LkbGsa7zWSy7
 0BEQC5/gnrCDPSax9dwPZIm7iVZpObOkjnB6eK+W24LxNl7H9n6BtWS4gzsRIn5vIADp8NNdKMH
 VrZUqtYBxVNqUS/j8UWJo19IIuYkjuDOuWaG193bpA//bFbyRjSA==
X-Google-Smtp-Source: AGHT+IHL43kyulivHlVCJS6paN4cUn6qlNtFfSWej8eFue1H4lrFvaNuevJDG70UFO/41MiB0eeQLA==
X-Received: by 2002:a05:600c:1f93:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4711791c66fmr151450385e9.28.1761079641565; 
 Tue, 21 Oct 2025 13:47:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b4867sm9603925e9.14.2025.10.21.13.47.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/45] hw/pci-host/raven: Simplify direct config access address
 decoding
Date: Tue, 21 Oct 2025 22:46:18 +0200
Message-ID: <20251021204700.56072-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use ctz instead of an open coded version and rename function to better
show what it does.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <68c038fd225463db282d0277d80cb525e0551413.1760795082.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index f8c0be5d21c..ee9058e262a 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -72,16 +72,9 @@ struct PRePPCIState {
 
 #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
 
-static inline uint32_t raven_pci_io_config(hwaddr addr)
+static inline uint32_t raven_idsel_to_addr(hwaddr addr)
 {
-    int i;
-
-    for (i = 0; i < 11; i++) {
-        if ((addr & (1 << (11 + i))) != 0) {
-            break;
-        }
-    }
-    return (addr & 0x7ff) |  (i << 11);
+    return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
 }
 
 static void raven_pci_io_write(void *opaque, hwaddr addr,
@@ -89,7 +82,7 @@ static void raven_pci_io_write(void *opaque, hwaddr addr,
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    pci_data_write(phb->bus, raven_pci_io_config(addr), val, size);
+    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
 }
 
 static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
@@ -97,7 +90,7 @@ static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
 {
     PREPPCIState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    return pci_data_read(phb->bus, raven_pci_io_config(addr), size);
+    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
 }
 
 static const MemoryRegionOps raven_pci_io_ops = {
-- 
2.51.0


