Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ACFCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkR0-0004TJ-1M; Wed, 03 Sep 2025 06:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQt-0004Hi-EG
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQr-0008Rd-Mp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d7acso2366916f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894175; x=1757498975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6UGFBv7QtABA3WFkaPUA0uUav3GpS4iAJMcQFZCcBg=;
 b=gAgpxahBzJNxvXfvPDzAC20jmWPrd2E4lS88xUe7uJ3MhoYbFrbvxKehQJ35vQsT2F
 CJtTSIU4xhXezivF4C5ifSNVXx8f8Nm4yt9VjsFwdvv7bcikPtFC3cuIiCf7YkSZPVgB
 fmOFh4gtuGsFJ/vQUIbwDbGBvUEsm1DAU5P+PpG5EqkeUj9S+HzKNWmU2MFEs8RYp70t
 jfQd6JeLan9BlzK/EVUXJINpB4q/THK3W+5cEyua6K2YZqX9S11O4lo++eopdK8invYd
 rsLYAXVdtE8CGsntwT5isSPJP2Zhi+3mCGRAcwTqIc0WTV3Rt8m3VHu+doaXzyz/72Wa
 m8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894175; x=1757498975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6UGFBv7QtABA3WFkaPUA0uUav3GpS4iAJMcQFZCcBg=;
 b=BGso+Us1seiX8EihrkhzACUdlSKaObFi9UoAx9ResqZoo5lgeXUJ8jy5y2WiaOkifq
 L3snX9XHkG44Az/0ktbcuOGjAHLv33hf6t6HEYCYVswBgMDqsoMYYK9BIMNJNmXzK3Rf
 2TTSKt0qg0B6B+uTvWIdaJjyPiUZ0H/9C+s2m/lJ5oHLY/HWRuR5H+jmFBf0KuaLz89R
 WCr+dnDmSp/WzSmn/1/KlXHo20touEUwklT9hLVnA0BFouUYmKCIYLh7EDVrox0WRpIr
 wVfzcJZc0kxPUB38HMKtwexTNp3Kg+qOATgKFWFYGrGWrcFATw9TsKHMsXryTYYvrad2
 hmiA==
X-Gm-Message-State: AOJu0YwFLdtiQHGjTCj0x6G7LVWaNieDNH8ZZgs2erDwKYW/AVsOQIjD
 UtLP94EZ727YKSuKSSsr/EZLurTc+64s369zxmZGo5J0AAWEvfP63ohFDmpJQJ05JDJEtlgUw9K
 UfLlUDWdR3g==
X-Gm-Gg: ASbGncuA6cT4LCtMK6PHcTXTbfaAhRaS1WVDEqM0nwZ8nvG358SCcgbmuUmwiGKMqxb
 0LjsNHCVjq2UpapsbVk2t+SnbLRMMyhwOHmyZ0eE5A7Txq/yjh3m7P6uhbfP4fFvRYbeF67GHV4
 j6lJXJOqlpaNeK/MPa2ZNsAFLFszhc0AokicpP5/fQDWbRW2eTTcaLPSMPHr3E7jaXtpQHX+dWR
 AHaUkVX04cH4JBc0m1F9TsNOiI6LPrZgGnfTPkSb+YL0NMfcrzI2W/B5bImUGfK4ZNNkRcQWIiY
 zmzR7guHM6PUqXs7WjQPmRqv2VUCV5bSaCy5uxWZNtWS1vSf2CQbFaNBi9EJFwymPcUGXuYnzdC
 nE8RR+SxMxL4oHvgJ/lWXYXkDT99Yl+kdUajqRY7nyTSePeRRvSPyompTkDc/pIkRs8OYbKpJRd
 g/WldBsmmcGKCL36nZ
X-Google-Smtp-Source: AGHT+IGEjVimI8+MizAyDYl5SGJcK7K4/JM92msUcSztcGMPOkbzUd2GtuhDPJe1Sw+RFeT5xVbjpg==
X-Received: by 2002:a05:6000:250a:b0:3d0:3eae:576d with SMTP id
 ffacd0b85a97d-3d1de4b1c23mr10459789f8f.22.1756894175503; 
 Wed, 03 Sep 2025 03:09:35 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6dc1sm316744055e9.1.2025.09.03.03.09.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 17/24] target/arm/hvf: Factor hvf_handle_vmexit() out
Date: Wed,  3 Sep 2025 12:06:53 +0200
Message-ID: <20250903100702.16726-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Factor hvf_handle_vmexit() out of hvf_vcpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 51 ++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3db0a8e288c..0cfe3066c23 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2111,10 +2111,34 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     return ret;
 }
 
-int hvf_arch_vcpu_exec(CPUState *cpu)
+/* Must be called by the owning thread */
+static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-    hv_vcpu_exit_t *hvf_exit = cpu->accel->exit;
+    int ret = 0;
+
+    switch (exit->reason) {
+    case HV_EXIT_REASON_EXCEPTION:
+        hvf_sync_vtimer(cpu);
+        ret = hvf_handle_exception(cpu, &exit->exception);
+        break;
+    case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
+        cpu->accel->vtimer_masked = true;
+        break;
+    case HV_EXIT_REASON_CANCELED:
+        /* we got kicked, no exit to process */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return ret;
+}
+
+int hvf_arch_vcpu_exec(CPUState *cpu)
+{
+    int ret;
     hv_return_t r;
 
     if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
@@ -2133,6 +2157,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     bql_lock();
     switch (r) {
     case HV_SUCCESS:
+        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
         break;
     case HV_ILLEGAL_GUEST_STATE:
         trace_hvf_illegal_guest_state();
@@ -2141,27 +2166,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         g_assert_not_reached();
     }
 
-    /* handle VMEXIT */
-    uint64_t exit_reason = hvf_exit->reason;
-
-    switch (exit_reason) {
-    case HV_EXIT_REASON_EXCEPTION:
-        /* This is the main one, handle below. */
-        break;
-    case HV_EXIT_REASON_VTIMER_ACTIVATED:
-        qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
-        cpu->accel->vtimer_masked = true;
-        return 0;
-    case HV_EXIT_REASON_CANCELED:
-        /* we got kicked, no exit to process */
-        return 0;
-    default:
-        g_assert_not_reached();
-    }
-
-    hvf_sync_vtimer(cpu);
-
-    return hvf_handle_exception(cpu, &hvf_exit->exception);
+    return ret;
 }
 
 static const VMStateDescription vmstate_hvf_vtimer = {
-- 
2.51.0


