Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EACBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDczh-0005o6-HY; Tue, 28 Oct 2025 02:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDczZ-0005lL-Q1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:15:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDczV-0007AB-C4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:15:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47112a73785so34988625e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632130; x=1762236930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SYDH18fMm8TitHd/YPkoDKy6b7rGIbyIx/6fd8SPFM=;
 b=x4yfPW65IxjrpxaKdxZeoaA/KvPAHVPbZALsxVJwxA0q4WHOhJZNaoTZH7cvaIkeO0
 co+q9IMA1xJ24DdsvJMhzg3q5SGL+bfg0b93lEEH8NOY/bQUx0AaHBr84BT4EUlF0dIO
 1ulTxoZpoU+wLxOgJ7cCeiK2XU2KyG5P+HLlVPOipyku6qh/fqQlTUB56zEIUa3xS3wU
 6hjRyw/EWCDJMCUJ+5TQWXOmiiyVUVF0d/fAUZlhKEKgbmt0pphzYQNoTUlGUTOHacR6
 Dlc7lnxs6WJjLmFkL/NMqVyC2pw9JmXjzCkL8sfbDSpXZLEbtoAniEJCAHf/lr9A+CUj
 F1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632130; x=1762236930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SYDH18fMm8TitHd/YPkoDKy6b7rGIbyIx/6fd8SPFM=;
 b=QSq7wU1Er8Ejky3qwZX8euMfoz3Q2dcIabf7fwCQ9ZSb8ZNd3N6Fvb1yxogImS1aX9
 PBUsiLS+NCL+jngAVFzo41Job578/WhpZuvXO0Nwj0DRB9ELv5jlAMRerqhfMiw+Q+ti
 kZ83gkBY4k6OS6HV6Giawv+qIOQ8gysCwgOXczgAuVMmVvrYvROj2CrU1hBTrQoNvz6z
 gjVZ7I3WNXH7UuE/ICU/D35NQrjxV5vZHkdY9sOYW2CXYo/Q5tINQ+Pp641rP4pI8Akg
 /TDBoQhLmsctCyt1yFqZj/QQ3/8o6ifrZxJAaPNiyE/Cyvk/8v/waKOYzhmU2bAUKZyV
 VPOg==
X-Gm-Message-State: AOJu0Yw986jWGtKH1BotKhvZLUh0ZIt36DBCjVfin/o+c74SUozF/NNp
 CKe+9PJ7i8Sxktajs5gnwrtm4fuLZ680ygkwoay72Nke23qLXx/Q/9LRCzK8UZl9PGzoenyX47c
 jthRIzlM=
X-Gm-Gg: ASbGncshzjzhNL1gkhVgr1iB0b+/R4QP0PbEz7L04pogskjkO61QvH7Ho3n3q95NQ5X
 Q9fNM5vgfJN5h4S45baXgQao58xTR0bnu+2f0xHqyYxhWsUJ0tiQ7qOu/SZOHKn78du3AdFpJcF
 Q0lu18krvDIqNL5S9VlSWWtsOQtBvH9TCWh3YxGIYkZwEkpVaiJhLdKpDhSemZL+RcR6/7lLkhZ
 pHXH2e8a2h6mWpvDuHiBlIVvPH3adAPhrqjdsXF/pYDIri5D0NTt0GJT6FY5lF9bn77Xq+mpJ2Q
 9U7/qZwVvOoDCBO3UjzZjdlmmxHcX0/280pDxlmnynoB5B05mHqydCoIGqyxwtoOUjfSIbpKfjQ
 Z5hyrjO6tBwCnX1VkucZo+x/tZdrjnbKFGJ5ilqmuEhmzPUabMJ/lkqzTnM8N72JIlCGPOjVTeg
 AAFtHQCOUQiqNNm5nu9v+4s5e454BFoEh90A/cETrPgEL8tHrsARnCINE=
X-Google-Smtp-Source: AGHT+IEvyhNX9314S2nHGVscKlnB4WMxFhtOyMc2lc+HPkguzVxInNR7W/W6Xyw8rYOJZ3R13+YXkQ==
X-Received: by 2002:a05:600c:a012:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-47717e41464mr14791725e9.30.1761632130557; 
 Mon, 27 Oct 2025 23:15:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771843eabfsm12890685e9.2.2025.10.27.23.15.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 46/59] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Tue, 28 Oct 2025 06:42:22 +0100
Message-ID: <20251028054238.14949-47-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h  | 2 ++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index c8e407a1463..96790b49386 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -106,4 +106,6 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e9dd2d24745..28d50e23017 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -360,6 +360,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f9d983fa123..b053bdd7cf2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -972,6 +972,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     hv_return_t ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b0c3fb97864..49f26169632 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -370,6 +370,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.51.0


