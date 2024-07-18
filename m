Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D206AC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMh7-0004Oj-H4; Thu, 18 Jul 2024 04:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMh6-0004D7-Aa
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMh4-0005RG-Hm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso587825e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292053; x=1721896853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMNRRhSeVfqG/kjcaEtJKlT+Vgh7L7Gt4XuPo4Meh2s=;
 b=pcmdOx7kmFusMKjL9xe1SAupKB5rPcz+cWJypiyUVZYs+UeprDCHBEr4wxXKG+EvYJ
 G/ee9C8ippc1gnxbJNst7OWtJokr0lP8NwtRSLcMgioFNlmDNIuqaA8WI13jVrKJ3UjB
 QcWdER0H8bx4SlOSj/dkeiBugxcTBQGz9a/uZ/aroiCTUrl2EiZiBwXIQZD4mkqGTzim
 jlrUpUN0wwReDt0oBRAWCHziRckeYK4g2TGjqjTG3jqSQnPG/4xNfWIi9vGCSVb34xsY
 Bb2xybXmVLrj/+yPyjXuD7dmVSJ/woPW+fp7ejToSgYi1haJJ1gn/AJ7uDUButJiAq3w
 xBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292053; x=1721896853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMNRRhSeVfqG/kjcaEtJKlT+Vgh7L7Gt4XuPo4Meh2s=;
 b=i5nAHP/raHU9Dv3cAIGSYh5U1KXzu9c4Lncz+hRvNluLJbQcamHEcmrmrhlMAhX3+Z
 k5STwJzQlnVCpxc/HaykTYgtR4KXEjJTdxFo+65CKMEacrb9WuMkxuyWqLpzS4V1xePx
 NIhp6sY4FkTIYyGm1L6SC/ixZYebiIRj4Irx/iEpp/5WRqRc0+XfyMdMBzY4fQSfVglq
 nUjPRT3y9ojiu4Ma3tk8fFLV9j0XIdzxWSPDwmo11u20llT8P+B9QnbfL0CKyugSp2RL
 hnpKqD7W159ThtpPV++mSzmY3O/gsUGyTXbJfgG+xsJstJ+4WsEWKuxgxX5fwFwKYDg+
 APRQ==
X-Gm-Message-State: AOJu0YwizhHlLeH19+HJR8CIQNWTWN1pAbMungXGFWE8uGDY8Dc88Vge
 m350svvDR9/Ls41KlNsJgNNHgICo1UgH6O64QCiiQ4pVtt51doHmsfSf2qSQBNoUpFj48hgRKVG
 Vb60=
X-Google-Smtp-Source: AGHT+IFn10n9hBp9JMLF04hlHtns4aDF24pV2xgG/qSF4E4zY95pUHq0I1s5yKp+1J+W0Bcdnj2cRw==
X-Received: by 2002:a05:600c:4f56:b0:426:68dd:bc92 with SMTP id
 5b1f17b1804b1-427c2cadeefmr24834525e9.5.1721292052684; 
 Thu, 18 Jul 2024 01:40:52 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b13375sm1529415e9.7.2024.07.18.01.40.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 17/18] hw/intc/loongson_ipi: Restrict to MIPS
Date: Thu, 18 Jul 2024 10:38:41 +0200
Message-ID: <20240718083842.81199-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Now than LoongArch target can use the TYPE_LOONGARCH_IPI
model, restrict TYPE_LOONGSON_IPI to MIPS.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS            |  2 --
 hw/intc/loongson_ipi.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a670c8ee67..c2d51b0158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,10 +1250,8 @@ F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
-F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 86badb2972..051e910586 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -16,22 +16,9 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-#ifdef TARGET_LOONGARCH64
-static AddressSpace *get_iocsr_as(CPUState *cpu)
-{
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-}
-#endif
-
-#ifdef TARGET_MIPS
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
@@ -40,7 +27,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 
     return NULL;
 }
-#endif
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
-- 
2.41.0


