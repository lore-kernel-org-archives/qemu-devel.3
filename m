Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B93C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXRU-0007kM-JF; Mon, 26 May 2025 09:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRH-0007g1-Jy
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRF-0005Ui-Lc
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4dd5f69e7so366970f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748264417; x=1748869217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQBQ//7O5VH+AZrfuLAW9/nheUoZW+EJtwdyA0eqKvI=;
 b=tloeQC16MzLDnbpq75WaiiZ0GlcRNNspfxqQ5V4py64ssjJEAtKrv7TliLfOv6FkjU
 SYltLnZWNoVkOdc10rUzaSi9CUrhQRZLlG/XCg0PZDGVmUpZeiIeC1RHNMdWkSeWHS/2
 BM2drPb1QjkenfKJwkhY3TY0/2jA/xXaxf5CjDfi4G9CcP4XtEMd+FXi560iqWNGMQq2
 ke4UKvkM/BJkfMRhfkBFbqee549XsOsmGrmPFpusJO2sQH/9mb6nQzOofYqmfnJ80TPr
 1ip4pw2aH3TznH+szNasckZOZj6NsY4Nzs7rxsbJc11/N4nhxU04Iq+K+M1IXTmxDHn4
 0IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264417; x=1748869217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQBQ//7O5VH+AZrfuLAW9/nheUoZW+EJtwdyA0eqKvI=;
 b=MCAfC0ZtfozzH028sy1mmTUjeUV0i4uxncpoWsmCU+WDUFPNv5MZ/Xj6V9hzVKTxSp
 +p4lpmn1irirOYhEN3yEMyq6rc/Bt4oFEA0tgy7W37uyF3seo0C7WY69J8Nl5xxhc3Js
 NoLCYAqCn3UPU3gdf7Tud0BCPXj9dQ7ryIsBczUx3tcRGVE1YZfvTDMg5YAPkc5Smxpl
 FvkM0S4RFnwWjfwcWrM3+NY0j+n1VrgTab5rnqFXTT2gvFdYIpH3y99H3Xq3bkhS9q4u
 YWHR97LOkWJoduOuB+3bZYEjcNQVsAN20eoybtwfIDu2HRx64t4a9bt+KXprMk9RmwpG
 MFWA==
X-Gm-Message-State: AOJu0YzwiZDJuzj9kbx7UPFuDd+0qDyGui7aJ9F73qK1LiNszxp22nkR
 D6T3HGEB+PbBlKLu1Hgopn+xHU7/zE/rgAtOjpkmzwz4MSp6OXxhow0WvYR48pvE1/YuR4kyqrt
 RxJSuT9c1yw==
X-Gm-Gg: ASbGncvBvF1oJP7RPMfTmtAUNuWgPAIhxHamdwz+olst64RiS5Pg6nkOQPjIjLTNTbB
 eFoYPQ4y61vfWuKQsPsWX/NN9JdoZ4PbdiqqSalL6PLYqdSEWoGbhJk/GKgTLRkprJuUV72VoXc
 TNcBM6Z6MCJ/x46Uj8HzPIdNpiUtWQeQXNSShcaaViOkHIqaSxI0DmjvHJPXq/dJ6XCcnNW0JZf
 TTK5rx3YelvvM+f2Sw+iY32ynMq1YxS5crGhb+4f6TEOglK7p0TRMoP2xAAouT77VlqXndoyHbz
 RHwX4+42Oh9PbI6otIE6XO+AmJSlSR6o8OMHmJnL5i/LdfajZ7bHQxcce4+urglSpWGGVR1eRkm
 h6t+RWluYzGwJs420GHwk+plPW1ko73xh
X-Google-Smtp-Source: AGHT+IGC3Qkv4uBJ7dgkYFHe1ymMGaxpCuUuJhqXMnPZee84iIyqo1NWyQnDwl2hM7BuZQmh849HzA==
X-Received: by 2002:adf:ec4d:0:b0:3a4:cf40:ff2d with SMTP id
 ffacd0b85a97d-3a4cf41007bmr4701214f8f.21.1748264417154; 
 Mon, 26 May 2025 06:00:17 -0700 (PDT)
Received: from localhost.localdomain (44.87.95.79.rev.sfr.net. [79.95.87.44])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f182538fsm245226775e9.7.2025.05.26.06.00.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 06:00:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/3] hw/ppc/spapr: Only create default devices when requested
Date: Mon, 26 May 2025 15:00:04 +0200
Message-ID: <20250526130006.49817-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526130006.49817-1-philmd@linaro.org>
References: <20250526130006.49817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Only create default devices when requested, avoid have the
machine implementation to modify the generic 'usb' boolean
set from command line.

Fixes: 4ee9ced979e ("hw/ppc/spapr: simplify usb controller creation logic")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 702f774cda9..bbcb4695d4c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3032,7 +3032,6 @@ static void spapr_machine_init(MachineState *machine)
     has_vga = spapr_vga_init(phb->bus, &error_fatal);
     if (has_vga) {
         spapr->want_stdout_path = !machine->enable_graphics;
-        machine->usb |= defaults_enabled() && !machine->usb_disabled;
     } else {
         spapr->want_stdout_path = true;
     }
@@ -3040,7 +3039,7 @@ static void spapr_machine_init(MachineState *machine)
     if (machine->usb) {
         pci_create_simple(phb->bus, -1, "nec-usb-xhci");
 
-        if (has_vga) {
+        if (has_vga && defaults_enabled()) {
             USBBus *usb_bus;
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
-- 
2.47.1


