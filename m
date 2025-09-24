Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5C9CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TUh-0002WI-Go; Wed, 24 Sep 2025 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TUd-0002VN-Sd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TUH-0001NB-8a
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso315005e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735657; x=1759340457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWZ1JRHTlGSHokgnR/eQLyapYp/xb5SnnlRWZ8dIPBk=;
 b=aBOuMjp8fczCcfm0PfWahPmmdtGRaegMm9waRHDX5ADxZmMESEinYesvyhP6UvGtx/
 PeFsd301VCvFBkAaQs9Z299awD0AGs92jaw8ELUkdGsAEAbg/bh77X16HQZvj6nAey1r
 WInTwvinUoXAdGwBaC4Nb4JxTkO9oMYxd4KsOeqXKnUm2Rl2K/hG910c3JbUMV5MY4EI
 KD0HXbcYA1niBW6vHeKtaN8tTW3c5ZMtsrypsXLZO7mAXPYb1LE1UXogrZ1Dwyf6Nafe
 A7ENT8HtRpBM+r8TxEUkLMl62nOtYapZVhr4+HaWOzaoPnC442axva45lfjI2k+1Q0zs
 2rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735657; x=1759340457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWZ1JRHTlGSHokgnR/eQLyapYp/xb5SnnlRWZ8dIPBk=;
 b=NebhFG1v21L7UXRCHuuHuoajeYzsLILbouIWrqfjIHCi4i8d+GMtW7u4I7jrIyjT6E
 IaUjG/xt0BSkpDlC+F6QhDWXae2Lxzgzv/XgMexCtHBkrbS4P/gqCAmu81box7MlNHRg
 92lkubJKms1abvdhz+03h38+H+lCXGDnhT1Zw40mZsqJakY9IGUr78kyxh3I2jZ4XXIO
 bkyZ+wHdeVENidBCzuSiiAlR+zJ+JMUNxKVU+bUI0Hc+KlWi5vd7IyguFkxO7LsfrBba
 R/NN7p/SnbnnbyHIB1WBS/C+CdruaqdrVLpHYjK/Rlb77ByX87Ih6sG8srKFyaTPVZ3V
 2tIg==
X-Gm-Message-State: AOJu0YwMhHLI8kQT28pE6oUTOLzNB9qa7SaF4vya+waxJY1kY6v2PFU6
 +bhowar8vIAXlv/mouZQ4do6HdTHWhzVr7ARbhmfvZa8++5tVEzsHW+4bAwVKyq6lpxWDbY8fyK
 +COLIz1kR0g==
X-Gm-Gg: ASbGnctzflb41Gf2ZpkQqHCKiTLC3gKr4C/OFAfqoBpoXM1fViG/N9kUWqQEJyQfR9h
 UlI7zM6vfRxKNSeBPqIxkBJeHxfmz6RdcAjLeo3YtdwZ/JTmGNscr10W3+s1xk/GhUF42H8rLkg
 wgGbXZ501n4MPSm/ryZhAk2aZOSPiqyqvf5/giIUJxHo9uItCronc9GDOjdHbPvuNxRzpHPfmNe
 phkgTkmEz+SqB1zabGth2rFfYEvUzMQpblwwCydlzCeg0z5LtOWztbYHG0VJqY2OXdmMl9nET+Z
 QSPvNgdRKgVi3TdlVjzMmrXoVEQ6d7Hzh2MME2M9qTtQ4xh97AEldCfw1M8VFwvzGU3Atw2H/9d
 B/u51TO5wqx6Q6sAlHEOyGrx0WbIEEoyOGKrW3WA4E+ptfa1svX97++hDQ6q5om+wRlZzHMO1
X-Google-Smtp-Source: AGHT+IGFCdnli76wsWxUzq4b/xsF11xfDJP4Gbu+KTW+VglfdcnxwFABWru9sEdBIq2Xz9i0I1+1bQ==
X-Received: by 2002:a05:600c:3226:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46e32a0e227mr4353685e9.28.1758735657472; 
 Wed, 24 Sep 2025 10:40:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e330fbcc5sm196475e9.4.2025.09.24.10.40.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:40:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] target/xtensa: Replace CPUXtensa:runstall by
 CPUState:start_powered_off
Date: Wed, 24 Sep 2025 19:40:45 +0200
Message-ID: <20250924174045.54241-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924174045.54241-1-philmd@linaro.org>
References: <20250924174045.54241-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

CPUXtensa::runstall and CPUState::start_powered_off are
semantically equivalent. Replace the target specific field
by the generic one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h    | 1 -
 target/xtensa/cpu.c    | 8 ++++++--
 target/xtensa/helper.c | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 74122ebe15c..43b8cabdcd3 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -529,7 +529,6 @@ struct CPUArchState {
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
     xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
     unsigned autorefill_idx;
-    bool runstall;
     AddressSpace *address_space_er;
     MemoryRegion *system_er;
     int pending_irq_level; /* level of last raised IRQ */
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea9b6df3aa2..65f0e778775 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -143,7 +143,7 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
 
-    return !env->runstall && env->pending_irq_level;
+    return !cs->start_powered_off && env->pending_irq_level;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -204,7 +204,11 @@ static void xtensa_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
     reset_mmu(env);
-    cs->halted = env->runstall;
+    if (cs->start_powered_off) {
+        cs->halted = 1;
+    } else {
+        cs->halted = 0;
+    }
 #endif
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2d93b45036d..a64df1cadac 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -311,11 +311,13 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
 {
     CPUState *cpu = env_cpu(env);
 
-    env->runstall = runstall;
-    cpu->halted = runstall;
     if (runstall) {
+        cpu->start_powered_off = true;
+        cpu->halted = 1;
         cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
     } else {
+        cpu->start_powered_off = false;
+        cpu->halted = 0;
         qemu_cpu_kick(cpu);
     }
 }
-- 
2.51.0


