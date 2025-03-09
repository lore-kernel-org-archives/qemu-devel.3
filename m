Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C92EC28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsJ-0002eF-4f; Sun, 09 Mar 2025 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrY-0001M1-By
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrW-00057S-KW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5233235e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542892; x=1742147692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fBi504GZPv9DdfQ0J0gmyCUJh0vb9oYQT7R5XfexT5o=;
 b=VVB1N3vSDCcmtHNoEk8uupelDmjzs2Q1yJ1iQENpnB6Rq8ITblU8f0dldX7voOZBVl
 mEE9JSbXardCKHKWPBYVyYvQX5+DMOIMwDxO6Lv1dx7KGxMexriURpwsOcfmmk+QQUMj
 XqN18VKwNDeBVIsbrs0xPhCHEgTMTmszUJwj8FChUJbZKXwJyHhMhMHFmkSfOSRid9+P
 A0g0ePQXBEvJth4pYkgUyGZd0dQfCNA1SGU1bAje5QouT9FX6LbrchGVp+d/SL3QYbF5
 VmopFxsptgG5MX5sX2hEM+sfnlzXyE0b2uzWRBgGAv9Lmh0rqrTgQSNj6FkkhOQ2dOCD
 IxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542892; x=1742147692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBi504GZPv9DdfQ0J0gmyCUJh0vb9oYQT7R5XfexT5o=;
 b=UlspeCNGWaYhPmCYWF9hHbeQP+MoFfq/3mepRI/duRDX+RRjJbWmjtwKoT2x+4/eBJ
 26cppoexFhoFec3X+bZAhv3hdjsS6YjjSlsGJMHscm1/JbgKm1pQUxrA5+roh/YQVhal
 xbNoa8blvVcRiXBJsd1jg8uHzadCMUOIFm4bIgG8qQDw2khTR+ZZKGUUpT5vwveKbzCV
 oZSkP829u/jR+pmmAd4VrCEmfCmdk6tKL00HSjjfJLFrZK8U3HTuSfvwp6W/M7Sh0PxT
 M7gqV8WG4MIc+VC0QjIto2Gbfwp7VE8LHgRyuD+o/6jzo7PmneFLcV+SOP1c4P6nSanX
 yp5w==
X-Gm-Message-State: AOJu0YynOID0JH57LDK/DgW1ryBzSVdv7VJgUNZFvsnnzvrJnFhKEZWb
 eNInw3iiPxzVLpoH1sY9AThW65TxbD+XhYwWHLkzEWdA45IQEpLm4LU0vpJPGUfWIGpiMzA6fV+
 Jdao=
X-Gm-Gg: ASbGnctUBezu7lD+teyreG3nJOKzCAjwc0aDpIICLXUJGHDOYnsLFwnbTtPzk2ssIL7
 kZSEPy2prbXOrbUnxAVJJYDAzRIou+9qOqmKszYieszA5Ck3awQI2Os3LswekoorWIyG4fVpRxF
 URjqqqNTVMqnbtOdjoLjfHbumbm4xXtuO22ybcHNjkPuHY7d3XiMnAgfOhAMga/Neax7QUspnVw
 9koh8k/iWV6bSgQgjNKlfG+vytIJaewW7aEwRho7Pf22+yHjUV2vzhfGRpQfH32LToeptvGbFlE
 w68miwvEaCNZ7HhScTAnAauW/TlsA2MsZnIN5ef+iij6hznLRpu/5h6JA9ZDI6ao2sO1zMozMwh
 ZJBRjf8Rq1/K0p3dYd1Q=
X-Google-Smtp-Source: AGHT+IE2wcf1Pq8Sb36MdU+Tfu7F1VJDLg70kCQIm2iPQsPsV/G6SOCpjeu4jCOPhzIPqdT0Trn6dw==
X-Received: by 2002:a5d:64c3:0:b0:391:ccf:2d1b with SMTP id
 ffacd0b85a97d-39132db1454mr7196724f8f.49.1741542892242; 
 Sun, 09 Mar 2025 10:54:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba679sm12290297f8f.8.2025.03.09.10.54.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/38] target/sparc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:52:03 +0100
Message-ID: <20250309175207.43828-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-22-philmd@linaro.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e27b1fa2949..57161201173 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -777,11 +777,13 @@ static void sparc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -988,6 +990,7 @@ static const Property sparc_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
+    .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
 };
@@ -1029,7 +1032,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-- 
2.47.1


