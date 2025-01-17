Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66584C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNU-0000BA-9U; Fri, 17 Jan 2025 00:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMx-0008DO-VY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:15 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMv-00068x-Hb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:10 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216426b0865so29768375ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093488; x=1737698288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4L7T90Cb2/AeNnwyH/tIV+tlsdKaT9jwV7rg20ewlys=;
 b=kaKSIfVBG87wFUjzIr3Ki2luLZ3RVSiBNrew5JZofOcm/AM4Daiv5YG6FyDmdorMty
 8L9xI9XSQ40CSnWSUSCY8iEiOuh1SjEBej86/HrfeJPuTgXSf418GLrlfPIdyS9hiyaX
 U4RAFZ3iU7aGwaCGGzdBQqEPIrYU3j9B5r9DqC8I9YXDEecvv33ODnQrqVswaUBqu5gF
 b1vp0x9mCyQVYvYu/So2BCiBSfGJ0j7K8NhmThiA1mZsTaD4Y+I4YQOUZ7+noPtZZaE9
 +suzGMDEKIcYPlOmnrcpAvHh9u5a8T3vQhRqyfMtpIZ1M/wZ2Stvli6Wg8Tu/msskFQB
 Ytfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093488; x=1737698288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4L7T90Cb2/AeNnwyH/tIV+tlsdKaT9jwV7rg20ewlys=;
 b=iMZGmj7U1PtfVfgQJ9ubI8zsWt8xqDSjADnXI9ktbw1rUWxGtEcGXlBdULqA+TYj/0
 EMQnGtN2jA+S8TPssTVfdLqfxhyzlsKqiBpLzAZZxGDjk8ga4kv2yICjATSSPG0+f/9c
 XXwtdbhUjvlAdsY12qHmRDjTck6yI9kHU//Y41ltCN84kpxkzstvbzICbDeohsXaydTF
 jotuUIySJuNULOsLWETRYFp9JWtpV3v2OJw91xBviwojK3syRi/qOeHNV1LR8xTnkf1F
 U4p08/fqDpuAnNqHvbDogs+WE8xwGPxntSEeOK0RdSiR1FnkGe+ZJPX4QXbl2VKHUqjQ
 GRwg==
X-Gm-Message-State: AOJu0YwPJW5iCASFGHr0w+EsZ8rLRQbR1Ls8a3jy5jiECVx3KnIy/nOd
 FrZl43zaT5go/RhB/OzqRUT7sYkt0F+LSPe2stp+tN46On7eaH5ei7LZbA==
X-Gm-Gg: ASbGnctcXmxCXb9mHVUa7evEw9jj65NKsi3kWw2Y37/Ip0bRjxevBuzq628B+uIDByu
 ySsGsTvVPQ+xPV7NyO3yFR4wpuHHTwmjQCLsFMoH+a5+0hE+zamVzkqJDaWZS9PIvREPlWYn1Ze
 wp0U+wlGLz+lCyehjts0M8EMGL6g3gNDS/UTUgemSrrBvODZm8bxyJfxXaSr8MQMqDPFVkmsX+s
 oh3w8KN7f/7cnn8YXz0f63c5rFwgkUE0XdCdfJ9Nay18N2SoMF96ijwgdJkxs0IrYeSiyR6E4wY
 77jkq8CDmsBBXL2I4q23fVVlGLzxxgy5UPragGlXtk9jXwtR7Q3lo05YeLZs
X-Google-Smtp-Source: AGHT+IELQr+zv59/rxoyMWq3CI0ilpWJXqr30pNjoO37bmhGFRG34O6rPCeQFWdoXFlSRghURL2NQw==
X-Received: by 2002:a17:902:e74b:b0:218:a4ea:a786 with SMTP id
 d9443c01a7336-21c35607c4emr22713475ad.53.1737093487957; 
 Thu, 16 Jan 2025 21:58:07 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/50] target/riscv: Add implied rule for counter delegation
 extensions
Date: Fri, 17 Jan 2025 15:55:39 +1000
Message-ID: <20250117055552.108376-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Atish Patra <atishp@rivosinc.com>

The counter delegation/configuration extensions depend on the following
extensions.

1. Smcdeleg - To enable counter delegation from M to S
2. S[m|s]csrind - To enable indirect access CSRs

Add an implied rule so that these extensions are enabled by default
if the sscfg extension is enabled.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-10-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da40f68715..671fc3d1c1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2760,6 +2760,16 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssccfg),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
+        CPU_CFG_OFFSET(ext_smcdeleg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2777,7 +2787,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     NULL
 };
 
-- 
2.47.1


