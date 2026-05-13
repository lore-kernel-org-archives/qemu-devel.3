Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2BCCD4F39
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Hx-0004gR-Ty; Wed, 13 May 2026 06:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fi-0003BZ-6Z
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fd-0001Ty-A9
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so73871015e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669737; x=1779274537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bN8pCQefCtNsnBDpXB7hEGPTq2VEcqB0gokfyFY1mgk=;
 b=cTdjvhpL9e+wMZGfwSoA1GiXt8hTDchNr0HtzgDPwnjxvDAXDs3qgqyZT+SV/CnSu3
 mo39pdtgNcmhICb4ADpW24JPT2tfyXnSH8WrWN1OiHqC0Un4ZxBDGmBpu3Ntb8xdoqkm
 DRcGAudtf8OVgL2zJu25HtqX7CjqA20IyVvtIc5L09npwd3WGwmYkteXQNCYRzl0m75E
 qoLyPmuzzJKTo79SIzoyUUKW36nIbWhc7Nz4J3vby2kpip9TbrMvDjV5qWzaJBU8HUeC
 N2b+pxh7cmK6nnikfvu1hlzmaRidbpYID05JnzjB/IrFZUQlqc4nzIcxIlqNInmtU7rA
 vP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669737; x=1779274537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bN8pCQefCtNsnBDpXB7hEGPTq2VEcqB0gokfyFY1mgk=;
 b=ePknB5pG/aaf06ieW4yA2/BLMgEUevwmvbrSaEoW18S2JUmrlqNFEngiN205xUHXUp
 rPFCo2AnuLgcDz4nNmHGHw2jggVZO13CE8JYeFIOuWMk7Z618i9qvRkRIOQfDDJvvI4d
 S1d8RZ3jeNcWcMDoYpVU3lEuqmYgP1qlrm/yKdl9hbdIWgvb+uWPRrRVmccNDuw6exvu
 gxAO7j0l557112i/CtSrwWhGtf6KZHyDawmsaal5RfMLB4CfMavLMuXGNTJAWk+MG3QS
 ARmsrrlhb4yCm9ALqg8Qgcz2OW+iv7FOehc/gYePgIC83K0AKw36aXCIB40+jAWybAwm
 jhzw==
X-Gm-Message-State: AOJu0YzfaBejnlO+d9Mx6NY1B//xT63S2aSF5tF2izhArNiZXt3yWx4X
 BMfp32F+u6Y64sIOE8f0i0f3XmzxzergzdjAMPS3dEzUy3v16GM+2hIFmqLDGRYr
X-Gm-Gg: Acq92OGcclMpZQgQgNv5wKBKXeroLkCpg0+W4z2pwn79+ge1hUN/lmsw7XU4D/xQdVY
 DhqQwgiqFzEC3Tt0xLKP2rWaYTmgpVv8O34iMPlx90JHZIMPedmZ+4FdvX5iKo2WqqhnYiPnmy4
 CRmMLsGZTWHHwzAtyIWmdim8ei6AYfHhgmAbDEY2bYKI+ENyBrSj9kqVZCG8E+LJwo4/n/pPZ2r
 isEh3IUXagwImPT03STOPZugt8+1Y7DxdBiOuxaLe1eMmCJzrL2u6PxKwmqZpsXydowqDxeXbtE
 gtwtP/f7kl5BeE3ZLZzwnBsQiWkSFqH9znbl9cokfVXlk+H/nZ1SvQNTSVaGR5E+i6uMw27u56T
 Tc43/+tlSC561ZzL7lX6scXq/7N5Q32ONHSbWCXnHTG/TLxzqomSvEliIsFPFqb3dGkiQYP/YIw
 NUkqNVSQRo65n0iTZIOAFtK1eydQh8VhbcPQYo+nLAqzO1
X-Received: by 2002:a05:600c:a48:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48fc9a0ef80mr40843965e9.11.1778669737373; 
 Wed, 13 May 2026 03:55:37 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:37 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v6 13/15] hw/arm/xilinx_zynq: Add flash-type property
Date: Wed, 13 May 2026 12:55:15 +0200
Message-ID: <20260513105517.146706-14-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Read flash-type value as machine property and set the flash type
accordingly.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c         | 25 ++++++++++++++++++++-----
 include/hw/arm/xilinx_zynq.h |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6c83439017..41085a3127 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -120,7 +120,8 @@ static void gem_init(uint32_t base, qemu_irq irq)
 }
 
 static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
-                                        bool is_qspi, int unit0)
+                                        bool is_qspi, int unit0,
+                                        const char *flash_type)
 {
     int unit = unit0;
     DeviceState *dev;
@@ -152,7 +153,7 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new("n25q128");
+            flash_dev = qdev_new(flash_type);
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
@@ -190,6 +191,14 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     m->boot_mode = mode;
 }
 
+static void zynq_set_flash_type(Object *obj, const char *str,
+                                                Error **errp)
+{
+    ZynqMachineState *m = ZYNQ_MACHINE(obj);
+    g_free(m->flash_type);
+    m->flash_type = g_strdup(str);
+}
+
 static void ddr_ctrl_init(uint32_t base)
 {
     DeviceState *dev;
@@ -283,9 +292,12 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
+    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0,
+                              zynq_machine->flash_type);
+    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n,
+                              zynq_machine->flash_type);
+    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n,
+                              zynq_machine->flash_type);
 
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
@@ -473,6 +485,9 @@ static void zynq_machine_class_init(ObjectClass *oc, const void *data)
                                           "Supported boot modes:"
                                           " jtag qspi sd nor");
     object_property_set_default_str(prop, "qspi");
+
+    prop = object_class_property_add_str(oc, "flash-type", NULL, zynq_set_flash_type);
+    object_property_set_default_str(prop, "n25q128");
 }
 
 static const TypeInfo zynq_machine_type = {
diff --git a/include/hw/arm/xilinx_zynq.h b/include/hw/arm/xilinx_zynq.h
index 0337d238ea..1720ca0db7 100644
--- a/include/hw/arm/xilinx_zynq.h
+++ b/include/hw/arm/xilinx_zynq.h
@@ -31,6 +31,7 @@ struct ZynqMachineState {
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
     uint8_t boot_mode;
+    char *flash_type;
 };
 
 #endif /* QEMU_ARM_ZYNQ_H */
-- 
2.47.3


