Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC1C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb279-0007ri-5a; Mon, 05 Aug 2024 14:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb276-0007Z9-Gl
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb274-0006Q0-P8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so70848145e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881237; x=1723486037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhjqKVMOEvjprgDLvTe8v8tblCl0hjWaV3RiPalNFPQ=;
 b=HK1glW2f/xpxfX6YsTS4znAtT7/MMw4Z3U49S5pDJfAqKTKAXrNlcaBLhuhdNr/4gX
 j3ZxIrGGvwjbQxO5OPcO/MOulKbodPD8byRS36yxxO480hf6jT+lqhs1z5/JxzsrtSa0
 8kLj65catrML8E166PLlokhtHmbqVjuaSeB2k25gEuXndLOPR9fisgqVtrJawk/kHHGS
 FMEH/WWEx+gheNj5U+L+cVGCHA/m6kRD+16K08I2jK/MJHu2Tyfq/o4R+5eTiiFP9lwe
 xCwEQlTvHKEGTA+D+/qn71Wi8Xm921niD/gEuMGCJDWpKTN3oR4n+exiUHP8GFFoFRIt
 DfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881237; x=1723486037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhjqKVMOEvjprgDLvTe8v8tblCl0hjWaV3RiPalNFPQ=;
 b=PGaWpAiMvSQGBW5xUaN2suWLay2rrNWf0cwTto9CAJFJ74d7fkqAbAxDkfEgInEv17
 QPQoK42k4Cusbe06P7rEHXAGRjNs497EvWAJIlFyKEa0eJxwuf3qszB/zqHs7D7KT47b
 LHm6S4OMXuN42018/g7yQPzFYNuN6CDk8/7lZWmwR7AAbalQ0hJ9I22M1Z27331xQ4Ix
 KIRQW2fxM7u2bEJWllRIvylmYwTFDRU1iAFE1lrnAbumjJQ9QFH+gZi8z21Udi3bC4I/
 cSWEXK+HuvdchM0K3+eGxaLcqLVVw/651j5e/nTd7/sK8gEbTSmrqojvV6uMNN/aXhHm
 iFFA==
X-Gm-Message-State: AOJu0Yy+8FN5Q3iLsfK7oJMnziMl5McOxgGOr3WU5w+8vO7/0BG8XzOT
 O+tjp32vrhYVvNG2LA3wH2IT0f4UxjyyYwO8uLsLfU0dvpfI5VcvnOU7jY021txeaJqwsaBPafC
 x
X-Google-Smtp-Source: AGHT+IGQ0gPMIa5VvAB1jUxng9d+0QYHquFyEE+lCGScdpD+OK+cZKmK7UwDAUmdWi7r5r/00X1ItA==
X-Received: by 2002:a05:600c:4e8e:b0:426:654e:16d0 with SMTP id
 5b1f17b1804b1-428e6a60397mr100328685e9.0.1722881236870; 
 Mon, 05 Aug 2024 11:07:16 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01efe5sm10706635f8f.46.2024.08.05.11.07.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 08/15] hw/intc/loongson_ipi: Add
 LoongsonIPICommonClass::get_iocsr_as handler
Date: Mon,  5 Aug 2024 20:06:15 +0200
Message-ID: <20240805180622.21001-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Allow Loongson IPI implementations to have their own get_iocsr_as()
handler.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-12-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi_common.h |  2 ++
 hw/intc/loongson_ipi.c                | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 967c70ad1c..1a2ee41cc9 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -39,6 +39,8 @@ struct LoongsonIPICommonState {
 
 struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
+
+    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
 };
 
 /* Mainy used by iocsr read and write */
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8bf16f26d4..eb99de9068 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -75,24 +75,30 @@ static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
     return loongson_ipi_core_readl(s, addr, data, size, attrs);
 }
 
-static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
-{
 #ifdef TARGET_LOONGARCH64
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+}
 #endif
+
 #ifdef TARGET_MIPS
+static AddressSpace *get_iocsr_as(CPUState *cpu)
+{
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
         return &MIPS_CPU(cpu)->env.iocsr.as;
     }
-#endif
+
     return NULL;
 }
+#endif
 
 static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
                                  uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
     int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+    AddressSpace *iocsr_as = licc->get_iocsr_as(cpu);
 
     if (!iocsr_as) {
         return MEMTX_DECODE_ERROR;
@@ -354,11 +360,13 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongson_ipi_realize,
                                     &lic->parent_realize);
     device_class_set_parent_unrealize(dc, loongson_ipi_unrealize,
                                       &lic->parent_unrealize);
+    licc->get_iocsr_as = get_iocsr_as;
 }
 
 static const TypeInfo loongson_ipi_types[] = {
-- 
2.45.2


