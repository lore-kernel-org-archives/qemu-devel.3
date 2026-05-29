Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C2ACD6E52
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAd-0006qy-Jf; Fri, 29 May 2026 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAb-0006l8-FG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAZ-0003Fg-NV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso4966098f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064798; x=1780669598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbRLYretApx2XFNweDx4MjqL1BkYigncE9vMgvnIk44=;
 b=xQWu5vhRixQtyGmXZ4O5XxYftfJJrMH9BYK5UXHqqj1gDy6GQ1o6Ss1syvFM1NDe7A
 SyKLUQJ1zeJGMdIDlhirnaxbdFHXc8voEqE0NvRkDlw3Oh6qBMXGHfuXOcKtP9AqPo1q
 uIgc6tcSlyl2p9D4F5ENY5qOyCR4g+IGCkslf+ncpxTdwUVaOQbHJVQ9GZBNN697K/BX
 GsyWfQ8CVFB/GGBGRYuYHTji3b/Hq5Pt1GjT+sBbECfCUVg19xtxQhQoMuhIgJNi30bZ
 5YzLXdR+yzrQGob4phDmrzEe7DUhsFh5/lXtlQKIj82ePJ59ksuEHJIy2fAvMMTgRPTI
 mfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064798; x=1780669598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GbRLYretApx2XFNweDx4MjqL1BkYigncE9vMgvnIk44=;
 b=PFHqQVTtKCyl6pJjHegWgegiPulnfnENALD4dvTtDoSbkrEfPMQcp+uENdt5OrYyU9
 YO05lm4M7EFhO6Lfd5lwrD415VW6lNsXy2D5YzQJT/Cn1ZjQWlPH2aLbRIvzFekDh9AV
 1v6CihsRc5hgZ0u2jkwB+eT+jylFNCD7I14JaURt2dxm6Ro0uJtG0p2oPiUAhovPoX7t
 L3N0obybdS5/s3LeucvAflKQ4Eo+sLjPQvgPohSbu6diGQYAt5vQQW6qpyjQUOxpY4GG
 IFFG92XkOEDnASmi3uKN/DviYUIwDjtsT5wY5zDgCtGuh4mBh4f9cQg7//dfxEzlCUTt
 mZcw==
X-Gm-Message-State: AOJu0YzqwhWRPXfgQ34/6SW79ZNKhp1BYj11STZaOk1ck6yr9FeZ/e7u
 NY8lERTOHIXr32Tz3QsKQCvf9dE+CJjgIyPKbtssoMZ8Xx2umCQf+YvzAxrsKZBvyAjm3GNAVPm
 iqwzARMpekg==
X-Gm-Gg: Acq92OH0VovxRaUmP1Qv4UVt7xDDckM3OJtBXEkD/xM1yLiD3GZFxVj6drd1FQcyWRy
 oFbfgW7v9a5XWrpFO6yfogSgAzqzGx522H5xX4bN6rzmowmrko86rPM+77H4DlXKJuiX+jNwqeH
 SYn72DgIhF3uqLWV/C9lF0AVNihzJcg+IztkLaSzHOqmIy0LXC8Er4R5lI+MHlXHrp1KeIBzryd
 +Pezk1PTVx30smsGCZnRg6h+1CyczIyEzXmfMqtZmIDKpXki/95M+hTixGdTsYW/qFmVRnMJeSa
 nQbfNkRJ5mLlf5SOxtByguK8v7NONn1RnV2U+u2sNPDYfWZ9QBT8hoET+g7bde4ODb44f0ictgq
 m7D3zF0Y4eJmJ+UhERnGazJBWwhD9P0jSRT7yxPrdk/NrhuYwwvd/YLcrT+SKDRz69UFVvOCgT0
 mEsGHTraQYlhwABF4JCtLfSyJW8o0MB9wqfCcrDeKyGsftF5cAqzlaxV+6YK5poqtY0w==
X-Received: by 2002:adf:e7cc:0:b0:45d:b14b:23fb with SMTP id
 ffacd0b85a97d-45ef6b24f8dmr59899f8f.11.1780064798213; 
 Fri, 29 May 2026 07:26:38 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3556f51sm3823250f8f.25.2026.05.29.07.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:26:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/17] accel/tcg: Convert RISCV AccelCPUClass ->
 TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 16:24:31 +0200
Message-ID: <20260529142434.87880-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Register AccelCPUClass::cpu_target_realize as
riscv_tcg_ops::cpu_realize. RISCV's ACCEL_CPU_NAME("tcg")
TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 703c2d9bd0a..c885af6c03f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -30,7 +30,6 @@
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
@@ -269,6 +268,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs);
+static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp);
 
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
@@ -276,6 +276,7 @@ const TCGCPUOps riscv_tcg_ops = {
 
     .initialize = riscv_translate_init,
     .cpu_instance_init = riscv_tcg_cpu_instance_init,
+    .cpu_realize = riscv_tcg_cpu_realize,
     .translate_code = riscv_translate_code,
     .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1676,24 +1677,3 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
         riscv_init_max_cpu_extensions(obj);
     }
 }
-
-static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_target_realize = riscv_tcg_cpu_realize;
-}
-
-static const TypeInfo riscv_tcg_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("tcg"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = riscv_tcg_cpu_accel_class_init,
-    .abstract = true,
-};
-
-static void riscv_tcg_cpu_accel_register_types(void)
-{
-    type_register_static(&riscv_tcg_cpu_accel_type_info);
-}
-type_init(riscv_tcg_cpu_accel_register_types);
-- 
2.53.0


