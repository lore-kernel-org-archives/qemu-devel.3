Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465B2CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlKk-0000pU-7f; Fri, 04 Oct 2024 12:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlIb-0002Sj-6A
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:37:02 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlIY-0006jR-F3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:37:00 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539973829e7so2389776e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059815; x=1728664615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xxV2v0QPsMAJ2+RBFGZoSHYGXcFciUFYUOuAoIuqTc=;
 b=adK7yN1lhJKKvrYX1L2gLziUONI67JzxOz/5mkmk7eUn3zM1jWnjquJOnpgmq0LG9r
 g55SaHF6U6oewVeaddLqPFJ68Tp3TmCeebZKcz/syghGEAZ5YxW9ZOMWrttEO4bx/5O6
 nMtkgcK3LA/u8VzclZPAh5OEGjKCVqrBmbCyf4iWGSaH20abkFj4lky49Xd1Pbp68Cvx
 K7soQSFuubOFyx904xElv+6SZP3NlN95i/M7kLG+xeFXyY28OZMxq4Mxtlno1t86OajQ
 nEqhC5ZpLXj31lZYLQTuakjL7RZV+Pqr5lE+GDd28gFQg/FLS2IAzftArVokV9MV0GeT
 gIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059815; x=1728664615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xxV2v0QPsMAJ2+RBFGZoSHYGXcFciUFYUOuAoIuqTc=;
 b=gLuVkPRinuyPFNmsMMB1Z0EMyma8xNvatzv88VAQ5IQWgoTx0S0dyu2OwObeuH4VFA
 WVaeUjceSD+jtDj1dAa0y90AYlSJPfOgupDZscgmYavk65LyNYUegRuv+0TXrfUb1vkZ
 s2X/g4uAHqp7X0EJnK7D9uHbvQ6BDRm8v2IhCrx9gMIs2xilylktNxxnBdXBKcxRdKXA
 9RCV/l6vyNQiW/0K/mtZ2qDFOA9XvW546V3etCcmBjb+YLt5Qlvk3Btgak8LSGXU/gFD
 AxFjKRkkQFdRkYjicGLscQnRt+YJLNsbszCMzYmlhrPJsRg37GsFxCJiZbtWW/qLMzVr
 CF8g==
X-Gm-Message-State: AOJu0YzaT00aNYmCb2jKIi6KoJdOkzrvgIg779HnuebDZjmhZmSMvAa/
 blPLShX1I+n78ZoiVtfGhLY/LHwwTs79ybI/9y2qgyWs94xkjLo/ef2P1GdnzKXtE6yw27+SSdO
 1iIgYQQ==
X-Google-Smtp-Source: AGHT+IHRO/heO4stSqHxn6O54m0xlWSECyVCdwPbXS8fz06hWXQKcyCH5b3Xwjeh40ry/zu4NRL9bA==
X-Received: by 2002:ac2:4c49:0:b0:539:88ae:ded6 with SMTP id
 2adb3069b0e04-539ab87e1ebmr2548554e87.35.1728059814899; 
 Fri, 04 Oct 2024 09:36:54 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff235casm1392e87.226.2024.10.04.09.36.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:36:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/25] hw/ppc/e500: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:41 -0300
Message-ID: <20241004163042.85922-26-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 32-bit PPC architecture uses big endianness. Directly use
the big-endian LD/ST API for the E500 hardware.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/*/*e500*); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppce500_spin.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index e08739a443d..8e0ef9467e4 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -64,9 +64,9 @@ static void spin_reset(DeviceState *dev)
     for (i = 0; i < MAX_CPUS; i++) {
         SpinInfo *info = &s->spin[i];
 
-        stl_p(&info->pir, i);
-        stq_p(&info->r3, i);
-        stq_p(&info->addr, 1);
+        stl_be_p(&info->pir, i);
+        stq_be_p(&info->r3, i);
+        stq_be_p(&info->addr, 1);
     }
 }
 
@@ -96,9 +96,9 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     hwaddr map_start;
 
     cpu_synchronize_state(cs);
-    stl_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
-    env->nip = ldq_p(&curspin->addr) & (map_size - 1);
-    env->gpr[3] = ldq_p(&curspin->r3);
+    stl_be_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
+    env->nip = ldq_be_p(&curspin->addr) & (map_size - 1);
+    env->gpr[3] = ldq_be_p(&curspin->r3);
     env->gpr[4] = 0;
     env->gpr[5] = 0;
     env->gpr[6] = 0;
@@ -106,7 +106,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     env->gpr[8] = 0;
     env->gpr[9] = 0;
 
-    map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
+    map_start = ldq_be_p(&curspin->addr) & ~(map_size - 1);
     mmubooke_create_initial_mapping(env, 0, map_start, map_size);
 
     cs->halted = 0;
@@ -141,14 +141,14 @@ static void spin_write(void *opaque, hwaddr addr, uint64_t value,
         stb_p(curspin_p, value);
         break;
     case 2:
-        stw_p(curspin_p, value);
+        stw_be_p(curspin_p, value);
         break;
     case 4:
-        stl_p(curspin_p, value);
+        stl_be_p(curspin_p, value);
         break;
     }
 
-    if (!(ldq_p(&curspin->addr) & 1)) {
+    if (!(ldq_be_p(&curspin->addr) & 1)) {
         /* run CPU */
         run_on_cpu(cpu, spin_kick, RUN_ON_CPU_HOST_PTR(curspin));
     }
@@ -163,9 +163,9 @@ static uint64_t spin_read(void *opaque, hwaddr addr, unsigned len)
     case 1:
         return ldub_p(spin_p);
     case 2:
-        return lduw_p(spin_p);
+        return lduw_be_p(spin_p);
     case 4:
-        return ldl_p(spin_p);
+        return ldl_be_p(spin_p);
     default:
         hw_error("ppce500: unexpected %s with len = %u", __func__, len);
     }
-- 
2.45.2


