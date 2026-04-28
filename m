Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D933FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHkuW-00044G-6g; Tue, 28 Apr 2026 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksO-00036D-Mi
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksM-0003jZ-7l
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:31 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8318293f02bso2334254b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777392088; x=1777996888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+5wI6eYi21zzKtm0yWLn4MFkpmieEFORcN4wGstIFM=;
 b=DO/m0OqeXmLVKqMWXYHez9XSrtYh9vhHgepThO0dtd/2ixAGAUWlmoP3XMHXmis/s+
 MWJfunJMK3ohRA+4uCuDsiJ+YifojJE/J9hqt1CbXP/2TDVTrzxX7owhVgFAnc0+pbL8
 uVhT4Dwcu/WW3DU9YV9wFNDI+a/aEzvBQiG43iXNhrntrrjTC7NzZckiWqHgeSdn6wxK
 0oAgXl4omAnjWuhPY5xrODxFe3GeJhzHlR0GRz1UgynBNTGXJWtSi76FvHdhn8eXCYgC
 92QtYw1uFQMijAaXtcXpADDtcs9VwXYRtObuu97zczPk+VlpCVPupTiRFxSXbOs469th
 RY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392088; x=1777996888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I+5wI6eYi21zzKtm0yWLn4MFkpmieEFORcN4wGstIFM=;
 b=cJthgHlBhv9sOLAJ/e1A21NFaRT9J/vUT6nPEAl/Rp8jol2kqucAiqszrSBelKXQxl
 TAAhWrwRSR68esIY9fLVCnqnydyWig03xEHkF/cEam37iRTNFIVblqcwPaCRdYJHfnZa
 R6RWn6qMgWAc3uXfuvNbw+JuaTZIixsCmpW8TF7/qJ5kHMHWn9qJopPnye8QjJTwJuI5
 SJCllV/S+Hhtwa2zhOhPrAVGjY7WByo/y4LVrDMhHPXf1KU+VDOrRmlmO58HvT5CsJjq
 UEh2d02sWuqFTjoambdK9Qs8g2jRfWTdVE6E/tShd9m1ZdmKuCvG5Jo0hJYEXi2tcl1H
 O3ag==
X-Gm-Message-State: AOJu0YyW54fSO+hiLMizOiLAgIc12gQ+qBpbVLu9qCR3eda4RAur20jA
 TGKD1eCnk9BhwhOt9Vqn6NhUmN2qPUHsRB2iD9YBr0MsPW3DWu6DKh5dcEQp561ZGUn9AA8zhRB
 n40/bX8lzRFULuQx49NLELAP1Gmxh+pGNB1T0JGMdtwyr0PWQDgwTTdPCvMKX2YIniPBTs8rmgT
 ttXQYjg4KPn8wallA7GmL8Rs4Y7dIdJ3xF6xodFHI/
X-Gm-Gg: AeBDiesEVSyYSxmEiQffbscG3fwJmXAN9B8s0eNaNx6A5gHN0C3j6kInTlN8QL2buQ0
 VvTx9BW5598TUHhV0uHw7nkiWLPB2iy4FozdfWUs14q5T/8TAlzZ30EK76P4Qj9ZsPaFGYzRc1f
 nAEEwjMaRc//J0IMOyQQlwRbuo9gAjP26fbHsOT0qebt6kpCdzMsJOK7ZbUg31SIAgl4t1coQBt
 kmAvPNuF92H/ohVuZDs+lZuhqfrPcnhGuAQArIRJgKvrPkUpbRYXJtsMx4I2LEavI2CECslvUg9
 BYmodbcewjUPLpV2KUffWMzOdzUKSnANx0FpygpcxXMr6d83ccd9JqlRBvaFHl0LXl71qJu4l1Y
 8yq8AIX9qBYSfsO/3sBsRDuTeTtedo5oNcIuvIzD5EmnUN+hT8A4cXadLqQNaAAxoXjmmbT44am
 wZ5Tm+UGCkmzJ2dXtyINPSSIn/5F4o+DHi5wTEVMmQPhDZFO5yw9y2YafFuc/E00B8Cg==
X-Received: by 2002:a05:6a00:80a:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-834dcdaf080mr3424973b3a.25.1777392088000; 
 Tue, 28 Apr 2026 09:01:28 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf30fbfsm3002331b3a.33.2026.04.28.09.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:01:27 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 3/4] hw/intc: riscv_imsic: Add reset API to IMSIC
Date: Wed, 29 Apr 2026 00:01:02 +0800
Message-ID: <20260428160103.3551125-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428160103.3551125-1-jim.shu@sifive.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x434.google.com
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

Clearing IMSIC registers and qemu_irq in the reset function

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/intc/riscv_imsic.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7c9a0120335..ac59496c22b 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -342,6 +342,23 @@ static const MemoryRegionOps riscv_imsic_ops = {
     }
 };
 
+static void riscv_imsic_reset_enter(Object *obj, ResetType type)
+{
+    RISCVIMSICState *imsic = RISCV_IMSIC(obj);
+    int i;
+
+    memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
+    memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
+
+    for (i = 0; i < imsic->num_eistate; i++) {
+        imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
+    }
+
+    for (i = 0; i < imsic->num_pages; i++) {
+        qemu_irq_lower(imsic->external_irqs[i]);
+    }
+}
+
 static void riscv_imsic_realize(DeviceState *dev, Error **errp)
 {
     RISCVIMSICState *imsic = RISCV_IMSIC(dev);
@@ -425,9 +442,11 @@ static const VMStateDescription vmstate_riscv_imsic = {
 static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, riscv_imsic_properties);
     dc->realize = riscv_imsic_realize;
+    rc->phases.enter = riscv_imsic_reset_enter;
     dc->vmsd = &vmstate_riscv_imsic;
 }
 
-- 
2.43.0


