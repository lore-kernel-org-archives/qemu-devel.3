Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B6CCD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV8-000104-7i; Mon, 18 May 2026 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUa-0000hf-Fc
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUX-0000YQ-Ga
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so1003976f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089658; x=1779694458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+iu7qI/bfTfc7zE92mQyqfTKFdbM6w/27VtcRMqn6Y=;
 b=jyOcQ2fkEDEFk+hwXuQXTDEW9VsQRI4zfGBnCYoXOgCyQrXyhjMeyCFymsc9owkC32
 1Sz7H71aGGXEKdfiLUPFiPc0kovNOLsDWxLhT13D2QXU4RleWG85Oi8hyvytJF2xw35K
 +eyDh0zXKXdQ8VBuliIqd4/RPSeX0+bal5ThFZTbd/8UwXPkO6kwSSh/VOeHYm9wn4MT
 cig3zYgnkjKJDgapIOa2mQJ/Kojyb/NrS5gApvz0Y3tO3x9Tp1Hz+E3qzAgV6FyscoEh
 PL+8SF8z3RGUOCL4ET2j6tl++HsM/njeB4jX+zM/cIsMXrnhDizv6txKw8UB/qOjvKWA
 SyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089658; x=1779694458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+iu7qI/bfTfc7zE92mQyqfTKFdbM6w/27VtcRMqn6Y=;
 b=mAoCWPvVjqzvq5tXwMI/5VLRFHvWsIH237L1ZnjX7VQRGJqSSLHvC2SBrzJwsbtW5S
 cheBbewIJLS1Ou724oqWoYYA/j7LnqMrcVvCnQU57HUJj6qnaEjtnr7AOW4OyIlWUKa3
 UZrCtpIgDDoiqGCKyeXmFTZ4tvpus14DlRUHfeCRlyJksU6o76JHdxE81jptdVtGqdeJ
 mONGmqlqLzRkZHBigEVYGqSb4sz8LxtUwBDGOJQSDAOMoVRe3WSb3wf1YUOL54+237mw
 gOrUmRsXfqvtki2rr/jdiPHPdwHlFnxRShpxHDoZoA1I8N7YMJpD7eBVZzUVk3ZeHjGI
 aCRQ==
X-Gm-Message-State: AOJu0YwtetDWYq6wuQ4T1BAQjgmTHF/biUxBIWIDdZbLmelV7HuIH8j1
 ZH/ZHooo3JiNAfZUzdVQH9Gozi18FsimMm8B8SdoTAdfo4OpaEc8gEaq9yAaoOmx
X-Gm-Gg: Acq92OGiX+kjeSuGkUkOG1+8sw/41Uz0mofBSXZq8eroJ0m5NhE3XAFwqgOvlN7oyot
 /gxGVWubE9EmGsyvH3nZ2RC0+tG4d+Z3A4WZXDYPBS/zqo/rkMJDvm4jis8ceAcIimbxMYdrnfk
 6O8AP492OD/yxaJ7Tfnf254sn0Vz4gdMnCbpnKPMt1VRZqSWK3cR3NQRP3buAYzcpeS3wtcbT22
 z5gfmplJ8zeGx4bdh0zotRzQP/axi+6V/zYw6WDMjSaYTQ/3SYjRj/gJsAhe8/e01ct+zZW0kYV
 iwKADrJqIZbiX3HKrHkEBVFMzrMSQ6ggqZJQs3aL64kYyvwLN9g9UwjPLiEZIRdL0jv5H9Pjf7q
 5NpmwY+1BGQwWeD0I9cZ8VRwo0Hi6fp45dZHUeel4F2LcdxOKUAh26eCYBvG01IWAxt85tChZ0H
 byO1TYGvxv5BHc06qxoJIxPb4x2+/2qFEZyiTlU31TMhK2Dg==
X-Received: by 2002:a05:6000:230b:b0:452:8772:b36a with SMTP id
 ffacd0b85a97d-45e5c58fd1cmr20290131f8f.2.1779089657733; 
 Mon, 18 May 2026 00:34:17 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:17 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 14/16] hw/arm/xilinx_zynq: Make PS frequency configurable
Date: Mon, 18 May 2026 09:33:59 +0200
Message-ID: <20260518073401.11279-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

Add ps_clk_freq to ZynqMachineClass so derived machine types can set
their own PS clock frequency instead of using the hardcoded default.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 3 ++-
 include/hw/arm/xilinx_zynq.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 5aac215c27..a464189542 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -259,7 +259,7 @@ static void zynq_init(MachineState *machine)
     object_property_add_child(OBJECT(zynq_machine), "ps_clk",
                               OBJECT(zynq_machine->ps_clk));
     object_unref(OBJECT(zynq_machine->ps_clk));
-    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+    clock_set_hz(zynq_machine->ps_clk, zmc->ps_clk_freq);
 
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
@@ -485,6 +485,7 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
     zmc->qspi_flash_type = "n25q128";
+    zmc->ps_clk_freq = PS_CLK_FREQUENCY;
 }
 
 static const TypeInfo zynq_machine_type = {
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index 662b390431..bf411f1cc2 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(ZynqMachineState, ZynqMachineClass, ZYNQ_MACHINE)
 struct ZynqMachineState {
     MachineState parent;
     Clock *ps_clk;
+    Clock *mpcore_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
     uint8_t boot_mode;
 };
@@ -31,6 +32,7 @@ struct ZynqMachineState {
 struct ZynqMachineClass {
     MachineClass parent_class;
     const char *qspi_flash_type;
+    uint64_t ps_clk_freq;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.47.3


