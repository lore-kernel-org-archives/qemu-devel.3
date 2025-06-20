Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA568C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5J-0002Wf-4e; Fri, 20 Jun 2025 18:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbr-00080y-69
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbm-0006dD-Vu
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a589d99963so2076221f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440769; x=1751045569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQvaTWJ84vGBT7RjC70BH9slhZwXcz3sDRCxnDfuym4=;
 b=tqUiTsG+Y+p8uYmdgaqZFkEenb5g8RtQvlIcyzhpvRS0uGjTFxF0U31PJzwvLPKwj3
 SSR0OZS8YY8gBi08n1A8VJwjeBVD9Uys1WxvTNIPN+P4CADevFlIqFmETZHQ6GBvE4SE
 JihVYaJUQ5abKfZbp6fzPpLJlCCEDUHUlU0GwovhrXpiJY0Ez6tLRNH4gtVW3M9pjmw2
 Gh1pOsT60oVsiaTiYH72LtmW/RBlGUhXbt0cU0mTs9/wVuJAtDxmZc/VrC9gXABzMLGo
 AH76Pqrq/3bio9HtL1+OT8vleFPnSKFBhsTag8zAKKuYeHPI8+CQeRTOwlS7qUtYXu50
 d4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440769; x=1751045569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQvaTWJ84vGBT7RjC70BH9slhZwXcz3sDRCxnDfuym4=;
 b=Vi5gDtMJA8QWp7egMJH42RrDqTbAETdDRJdgJKj6lfeDrERlqgoCiiSnHWNrZ1izmg
 83/npADNJire6JuhjexM8ghyz/R+dcPeTeKQHSBTsQ9OrqfkQeUYFXetO7BJROXWXf63
 jpxaGvebWTQSLUkIhaGpQ9EsqkHpuKJdPj0RyVaLIHGw2sn3hDjH/totzQGD1zI4gcJJ
 hwGMM/XYVTwGVgwyTWYlIDWP+Qxw6d7jxnTNDj5+PPUWtkG5fYFBgqynSJNvVvKLfc5p
 6f05FGPF1PV9dzM5HHZDzOa7HxnvEUkkesNyNNarNs/iK8pDkqoX7l3LlpFxF3ws4mMp
 B24A==
X-Gm-Message-State: AOJu0YxiW4EYu/g+Yw3GXsSaUnIbn4EVzYY9DmK9PfqyM+MEvUxRgu9e
 BMHKq8HoDHx+bPc5aIH3iOTmYeHaSpgrUqJy6W1PoyJA3TiyE/VGDKh85LcUATL+LgR2T8RDRBs
 AHwobIaS3xA==
X-Gm-Gg: ASbGnctDjcAhFSDrkGDeU5IYUF9umEnuyJETDZeN2zUTBePV9TzLAAcsQqOXzhN12Nj
 DxBI3goplw+A/kMMqFIG6pywumI8+tn4Hb2oPz51fnATEtYDhsMuCadhw33nMZY93Bzl1K5qIW6
 jDaSSYNp1DQfUb0RT4oDjjvPIwlFoXobuND9s/7mlIlncUrrJ7TPm+0P1U+hX6XIvLnEybJabu4
 sRAUCiuGvI0Ht4IMzG1f5INIO1Qnr4cU8Eb0DhqluN9KXSQZ4C65oL2i8lDxNohlsWrePvEFJjN
 eGypaEFqijVedXXffBTjiglhO/GJA8wRX6nDaMGJK2q//x8ovOZMEoM+Y8E6rPEui7wvMnL5XcX
 hgPM4Pl6SD3P9Re6DT95PEUl5VF2h6z5J0O4V1Fr+W878VUYbhe8VdmqZPvUiezE5FoA=
X-Google-Smtp-Source: AGHT+IHpbLCkzhf5+PRP07/Tnzc7aYLEqXpHuy1Rebfw9SPzmvwLu0S1fCnqyhlx/gvJ/9R+tcQbbg==
X-Received: by 2002:a5d:584e:0:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3a6d128a59bmr3488790f8f.5.1750440768626; 
 Fri, 20 Jun 2025 10:32:48 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1815dsm2551017f8f.28.2025.06.20.10.32.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 34/42] accel/split: Implement get_[vcpu]_stats()
Date: Fri, 20 Jun 2025 19:27:42 +0200
Message-ID: <20250620172751.94231-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel.h     |  5 +++++
 accel/split/split-accel-ops.c | 24 +++++++++++++++++++++++-
 accel/split/split-all.c       | 16 +++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
index 8a2888507f3..80a19bbb1e5 100644
--- a/accel/split/split-accel.h
+++ b/accel/split/split-accel.h
@@ -36,6 +36,11 @@ struct SplitAccelState {
 
     char *hw_name;
     char *sw_name;
+
+    struct {
+        unsigned transitions; /* number of HW <-> SW transitions */
+        uint64_t exec_count[2]; /* SW:0 HW:1 */
+    } stats;
 };
 
 struct AccelCPUState {
diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index d59e70e0d9b..615faf1d96b 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
+#include "qapi/type-helpers.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/core/cpu.h"
@@ -16,6 +17,7 @@
 #include "system/cpus.h"
 #include "system/hw_accel.h"
 #include "system/tcg.h"
+#include "monitor/monitor.h"
 #include "split-accel.h"
 #include "trace.h"
 
@@ -70,6 +72,7 @@ static void *split_cpu_thread_routine(void *arg)
                 r = swops->exec_vcpu_thread(cpu);
                 trace_accel_split_exec_vcpu_thread_sw(r);
             }
+            sas->stats.exec_count[acs->use_hw]++;
             switch (r) {
             case 0:
                 if (acs->use_hw) {
@@ -103,6 +106,7 @@ static void *split_cpu_thread_routine(void *arg)
                 assert(!acs->use_hw);
                 trace_accel_split_hw_accelerate();
                 acs->use_hw = true;
+                sas->stats.transitions++;
                 break;
             default:
                 /* Ignore everything else? */
@@ -314,7 +318,25 @@ static void split_remove_all_breakpoints(CPUState *cpu)
 
 static void split_get_vcpu_stats(CPUState *cpu, GString *buf)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    g_autofree char *cpu_model =
+        cpu_model_from_type(object_get_typename(OBJECT(cpu)));
+
+    if (cpu->cluster_index != -1) {
+        g_string_append_printf(buf, "CPU#%d@%d: %s\n",
+                               cpu->cpu_index, cpu->cluster_index, cpu_model);
+    } else {
+        g_string_append_printf(buf, "CPU#%d: %s\n",
+                               cpu->cpu_index, cpu_model);
+    }
+    if (hwc->ops->get_vcpu_stats) {
+        hwc->ops->get_vcpu_stats(cpu, buf);
+    }
+    if (swc->ops->get_vcpu_stats) {
+        swc->ops->get_vcpu_stats(cpu, buf);
+    }
 }
 
 static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 413954af96c..9e0848db971 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -94,7 +94,21 @@ static int split_gdbstub_supported_sstep_flags(AccelState *as)
 
 static void split_get_stats(AccelState *as, GString *buf)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    g_string_append_printf(buf,
+                           "%u transitions, %llu SW and %llu HW executions\n",
+                           sas->stats.transitions,
+                           sas->stats.exec_count[0],
+                           sas->stats.exec_count[1]);
+    if (hwc->get_stats) {
+        hwc->get_stats(as, buf);
+    }
+    if (swc->get_stats) {
+        swc->get_stats(as, buf);
+    }
 }
 
 static char *split_get_hw(Object *obj, Error **errp)
-- 
2.49.0


