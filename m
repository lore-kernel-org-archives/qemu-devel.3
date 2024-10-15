Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21C2D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jn2-0002Pl-9Q; Tue, 15 Oct 2024 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmj-0001yT-4L
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:39 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmg-00016i-6a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:32 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-27d0e994ae3so2523203fac.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007309; x=1729612109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoVdSPoH5wb0VwFY5mr81ie4+HpYnQomv3PX5To8Uyg=;
 b=U9inwYBuh3BxlUCyvdgmTFyULtYr9KoJb6nGA5kkZd6wX2VCH1q1Kc0LRILfFfx4cE
 5PwgzIMtNiEIz8AqdB1SooG47SE7X6p/hmQTZMPW5VB5/goiSKoMcIE0DVkgiG3Bdtur
 YzMc7nbuXWZ3hJSOKGnRudwRnHjAwvgOXtklTuJ/IcM3b5A19DaRhGpn4zfRuElGdWPG
 s0cYp2J8F611XUrc9YtJZRvD3vb9vDHf2yjpAj4Bd542jbMYPujCCXfhFy6QH7fOqMun
 SZRG1pX2Gv+2813eNTgWenJz2KRqTspLCdL4v9O127iHlMQb+JUwb09+xXSXVLJa8Dx5
 XLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007309; x=1729612109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IoVdSPoH5wb0VwFY5mr81ie4+HpYnQomv3PX5To8Uyg=;
 b=NLOXajjCuk2Rjr3SZwew8eauNryd4L4KZNQyfYZs6PdI+wn5uYh/5h6zyuxmYcMpPk
 pcJ7BeknESHLIYw2pfNLtRZAsUHtc85Q0iUq21Lm1S+7pWs1Ucq77LQQM6tzBe9qRzwj
 ABG4F4PtxwBp7dyfRZ4J3EIBR/2X8yX1NuwoUY0uIEAovy18Rhxzo/yERDNah9fPrYJA
 KcliqBxiGyygF3gLLQCkjMf2DnqQTlZgW4BKsdU0LOVRZ6iEniXJ2BK0Jar/myV6YjrK
 l1qmySHTxrLnsC8zSpwI0KW1m3PLJPEsPF+vFNFkeJ+0OB3S9E+Y5LohPr+2A3ga9tZ0
 VWfw==
X-Gm-Message-State: AOJu0Yxp3GOuD7czlC6ei7An+BgyhOaRFudPpRMha/v6ERkNAowVRuDY
 MYaOIP34sSy4DWiRs6PO/q735Wm7zL/gjscPtAnPkxzY7CcC26eGpLbeFtkcHgCfj2ZiIwWbV5l
 G
X-Google-Smtp-Source: AGHT+IE4LOFDsCrL8lQdbaITPtn2XREfDeXUVm4SGd1chR/o8mfosJiu7/B5FwALyX7LpnqwdFhrkg==
X-Received: by 2002:a05:6870:d610:b0:24e:8987:6f34 with SMTP id
 586e51a60fabf-288872ad8f9mr7429876fac.3.1729007308760; 
 Tue, 15 Oct 2024 08:48:28 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e773e9ecfsm1418389b3a.89.2024.10.15.08.48.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/33] target/mips: Expose MIPSCPU::is_big_endian property
Date: Tue, 15 Oct 2024 12:44:40 -0300
Message-ID: <20241015154443.71763-32-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=philmd@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the "big-endian" property and set the CP0C0_BE bit in CP0_Config0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-15-philmd@linaro.org>
---
 target/mips/cpu.h |  3 +++
 target/mips/cpu.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3e906a175a3..070e11fe0da 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1209,6 +1209,9 @@ struct ArchCPU {
 
     Clock *clock;
     Clock *count_div; /* Divider for CP0_Count clock */
+
+    /* Properties */
+    bool is_big_endian;
 };
 
 /**
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 89655b1900f..04bf4b11db2 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -200,10 +200,8 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 
     /* Reset registers to their default values */
     env->CP0_PRid = env->cpu_model->CP0_PRid;
-    env->CP0_Config0 = env->cpu_model->CP0_Config0;
-#if TARGET_BIG_ENDIAN
-    env->CP0_Config0 |= (1 << CP0C0_BE);
-#endif
+    env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
+                                 CP0C0_BE, 1, cpu->is_big_endian);
     env->CP0_Config1 = env->cpu_model->CP0_Config1;
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
     env->CP0_Config3 = env->cpu_model->CP0_Config3;
@@ -541,6 +539,11 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 };
 #endif
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 /*
@@ -571,6 +574,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, mips_cpu_properties);
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, mips_cpu_reset_hold, NULL,
-- 
2.45.2


