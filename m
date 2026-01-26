Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ABED1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd4-0001ZI-UK; Mon, 26 Jan 2026 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcm-0001Ne-Gb
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcj-00006S-Rx
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so2794642f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449416; x=1770054216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nfmi5icMy+Gsd3bejmpv5t5fn/UEcE2B0XY0gkqF90U=;
 b=c0+MhU8I7E7YKLHx9yRvqvtPLL6NtTN4V+/Lh0xaWLN6ydeCO+sGUyKegkhVAcgmlT
 SEmbekddJFYHTQy0tjsXJQW7udmXIR5PF9f72JhMvoLa8OVeGWeo0cbWt+TEqZ35JYwN
 HHUk5sFE+evsjeFjhzoq/dVmUYRCMb7rSPeIbG60yjsf2SIfh1B/bm4SFjVMK1etascP
 hMb6KCEn4xKhA5fbK2rHBqQ11YIaL+VORZTwtDKIbXCraOamw0PtpMgZWjvkgQWvta1n
 uDhmmD9JbXzMPQq0Am8jJKaZf7HTl553b5V2HK71vjutXEjXB8wpnQRQ7SE6qczYE6WF
 7XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449416; x=1770054216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nfmi5icMy+Gsd3bejmpv5t5fn/UEcE2B0XY0gkqF90U=;
 b=vo9AIBc5PKJ2XLgTSnyKcGmwpYfvpbLBTuztfrdCk8AtrLB6449MemQoGSZKPLr/03
 nletxAoJWipo1i0OrVMgTB94+JM8C6X3d+19tW3Y1RhnVRHDCpByWNXb52Ndyax6l9b3
 MhRzbsS4WyyyfCdamEFwWWCzv4FQRDc6+Ee9mFt4NgJ3bWweaPxncFA0yRP90ZfogVP3
 v9iCte+tcOcAghj5pMiSV6aJ6gGxou+fAa1424JJAtSV4S0ZMYc3jkylDUvB52haPwXm
 HR4exSawySCA3L9EuT9MqVs/c317OZ5PJRIrmxm115YX+jgSjqcprCva72zi6ZH3d4h9
 5SeQ==
X-Gm-Message-State: AOJu0YxaG8UyryvD7qsd+o+RFCy8AHzdGsmzySkK7S1+SN/OTkh0TBI/
 8WqHQRpgXvD/4kluZ2Q0ww4K2uup5OF0MfNDUa8Gli+KAmwT1pXnED4p1Iv9GC8b
X-Gm-Gg: AZuq6aICAVUbCCGuU28SpkBoBnhKd2OoX8AG+kPXfB1DW5oO30vEfgEM5XBwVZFlJZF
 EclnTv2WEZ/u9hDmdqKqzXKnMukjfrBtJMSP0BjyQJd6Z5vMtCztVfOOGOYHmxH4LeQvwCZhK/j
 ijxkn+zBtpY4QwoLk+ckMD+b0ozmU8yvboUk3ehCrqXVko35gUjHhb5hEPl83LgGUvyjq0eyKEf
 hSaYTDotD415tdwJA4DOvNSRX85f08OdDXImwpzMHsfqP595JsH6qq/fmOTG4lKkiinODWTW7Vj
 GkW6WuUUgUMwajCFwj4dOI+kdb04VzLcyLsUBlSpwD+1jnoSkjzEVXtnCO9V0ThVwQhSpE+Eavm
 KsXTJsRY2vjDIx+NfO4Hj0uwd/r8oCEuc9ilMP0BUr8k4bmlpXKFzgU03j3AjLy1+nwOWFqTRVV
 EUUkgQNt4vDKlZRnptsEnlOgxnTn9WAKBGlhxQPBeKIsp+yWlvhppO3g==
X-Received: by 2002:a05:6000:2c01:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-435c9d1bc8fmr8133326f8f.22.1769449415988; 
 Mon, 26 Jan 2026 09:43:35 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:35 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 12/27] hw/core/fdt_generic_util: add TYPE_FDT_GENERIC_INTC
Date: Mon, 26 Jan 2026 18:42:58 +0100
Message-ID: <20260126174313.1418150-13-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x434.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add TYPE_FDT_GENERIC_INTC class and interface to allow
interrupt controllers to register callback which can
be used to get IRQ's from this controller.

Optionally, interrupt controllers may also provide
auto_parent() callabck which can be used to attach
it to corresponding CPU's or other interrupt parent.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         |  7 ++++
 include/hw/core/fdt_generic_util.h | 59 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index c0e974e53a..b22c612e0f 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -766,6 +766,12 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     return 0;
 }
 
+static const TypeInfo fdt_generic_intc_info = {
+    .name          = TYPE_FDT_GENERIC_INTC,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(FDTGenericIntcClass),
+};
+
 static const TypeInfo fdt_generic_mmap_info = {
     .name          = TYPE_FDT_GENERIC_MMAP,
     .parent        = TYPE_INTERFACE,
@@ -774,6 +780,7 @@ static const TypeInfo fdt_generic_mmap_info = {
 
 static void fdt_generic_register_types(void)
 {
+    type_register_static(&fdt_generic_intc_info);
     type_register_static(&fdt_generic_mmap_info);
 }
 type_init(fdt_generic_register_types)
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
index 38086ec1e4..c5aaa58dd6 100644
--- a/include/hw/core/fdt_generic_util.h
+++ b/include/hw/core/fdt_generic_util.h
@@ -16,6 +16,65 @@
 
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
 
+#define TYPE_FDT_GENERIC_INTC "fdt-generic-intc"
+
+#define FDT_GENERIC_INTC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericIntcClass, (klass), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericIntcClass, (obj), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC(obj) \
+     INTERFACE_CHECK(FDTGenericIntc, (obj), TYPE_FDT_GENERIC_INTC)
+
+typedef struct FDTGenericIntc {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericIntc;
+
+typedef struct FDTGenericIntcClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * get irq - Based on the FDT generic interrupt binding for this device
+     * grab the irq(s) for the given interrupt cells description. In some device
+     * tree bindings (E.G. ARM GIC with its PPI) a single interrupt cell-tuple
+     * can describe more than one connection. So populates an array with all
+     * relevant IRQs.
+     *
+     * @obj - interrupt controller to get irqs input for ("interrupt-parent")
+     * @irqs - array to populate with irqs (must be >= @max length
+     * @cells - interrupt cells values. Must be >= ncells length
+     * @ncells - number of cells in @cells
+     * @max - maximum number of irqs to return
+     * @errp - Error condition
+     *
+     * @returns the number of interrupts populated in irqs. Undefined on error
+     * (use errp for error checking). If it is valid for the interrupt
+     * controller binding to specify no (or a disabled) connections it may
+     * return 0 as a non-error.
+     */
+
+    int (*get_irq)(FDTGenericIntc *obj, qemu_irq *irqs, uint32_t *cells,
+                   int ncells, int max, Error **errp);
+
+    /**
+     * auto_parent. An interrupt controller often infers its own interrupt
+     * parent (usually a CPU or CPU cluster. This function allows an interrupt
+     * controller to implement its own auto-connections. Is called if an
+     * interrupt controller itself (detected via "interrupt-controller") has no
+     * "interrupt-parent" node.
+     *
+     * @obj - Interrupt controller top attempt autoconnection
+     * @errp - Error condition
+     *
+     * FIXME: More arguments need to be added for partial descriptions
+     */
+
+    void (*auto_parent)(FDTGenericIntc *obj, Error **errp);
+
+} FDTGenericIntcClass;
+
 #define TYPE_FDT_GENERIC_MMAP "fdt-generic-mmap"
 
 #define FDT_GENERIC_MMAP_CLASS(klass) \
-- 
2.43.0


