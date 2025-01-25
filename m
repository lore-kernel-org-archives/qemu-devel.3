Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0732C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjZD-0001G6-Hb; Sat, 25 Jan 2025 12:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYW-0000IZ-IR
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYU-0000Yp-Rg
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:48 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so2823108f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824565; x=1738429365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrE30xT1EmuXt0tg0kaHmGrX7iIi1CpOMZL7K4RG6J8=;
 b=vjNJXPia0PUsFanBpDmNz+UZKsSYPHKz9tMycJahgLJwn50yPOeuR/RPegF4zWzsyu
 1TRVwtKTonjZbYrCJvh+N3bxOhEb74g/bVdbFjmGcreHeaf7PKijJ8riqiBE9bHP6+sp
 updK4CX+X3PZVeY7PMSi2MWa004N/bbgbuRvOSBUAC1L7NBxpNoU/3jsQLIEDd/YiObO
 i9mio596nmoLYCKI4Rtk4IOXYYvizDd/OpWKGHdSOXpMJtxHXGi7ceiJTbfHhLimsurg
 SYIUNi1EN608wMSd6g75PxSC/nM223b+46c23GOe0frghu3xo7ZhRFYTzjxs879+pPXq
 8P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824565; x=1738429365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrE30xT1EmuXt0tg0kaHmGrX7iIi1CpOMZL7K4RG6J8=;
 b=saIoNxEHBbShTPF+msgQ3wNgQyJdds2bATNazscdL8xhj6yzEnojh6kLLyIxMn3zVF
 K11Lw2gWkh+PWfx8jBD9bNeeWCBjyyIihbspZ5CuZdwinUFUXY0HUUrRekpU01c6dh37
 13hkslcx/J2RGovmTVjAMuTigRks3iysH17DM0PqomO+oorHSM11Yz8UxBhBc3xFxT1m
 j8F8F5KqULTtni5l8XzIgApFkgvL7IxwZ1GBtQtscQOxrgeM4f/JR3MlhBRucDPBcI8J
 SXXyCWhBZ+HAzCv7tFHHjMk2wPoLDg62cnzNZudwYjlPEOQXhTHNP8lIUZwMz/dx982J
 3isw==
X-Gm-Message-State: AOJu0YyDDGwOr9PNH4wejNpfOp7ke0HjqPH62ESjqzvga4iiQhBImFh4
 u2dZHxCxQJlsOq6BdiQHkKxeWb1us69Flm2x7REvHZbjdFiTxyPgrddtgduUYyiaBpWwFiRNJa9
 2fMY=
X-Gm-Gg: ASbGncvA6WFrexan18XBXVYMkwRlS9IHvXuYwM57TBukCX5uq02NSRhGsuxnsgI65Uj
 cKASC3wWdgXeozWQqHOwsoD4pL+96ZiiyHqqaSavxiVJWRVZR7T0wN3zW8jqp4h6HWFBnKvyHRj
 VRj8HARVl2EFy7HLkSKpFnzAUHm7LZmzAQBeWrjIXmFOhEIu/DxYZ7SJ2n/ntUSZejES/JppMrw
 IRmMBkiHwvfin54L55jr2UhGhStqAE8t+EjKYikbIxTwHcG7/Q50Cu74resGJeZ039H6k8SRtu6
 2GJ7vCu1RXe2qXHhRw95HmV204Yo7sJ6jZ9HZPIxO4XJNQ1R8HJ6nV8=
X-Google-Smtp-Source: AGHT+IGNlyMXuaDnUDXdIELsE09/c/dVV0EjyQ3SCl8iTpsNtU2qcoEuigRn83q15WyThjIkwbVgaw==
X-Received: by 2002:a05:6000:d09:b0:38a:88d0:1c9c with SMTP id
 ffacd0b85a97d-38c22275430mr9605028f8f.17.1737824564866; 
 Sat, 25 Jan 2025 09:02:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm5861138f8f.89.2025.01.25.09.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 16/24] target/riscv: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:17 +0100
Message-ID: <20250125170125.32855-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Cc: qemu-riscv@nongnu.org
---
 target/riscv/internals.h | 4 +++-
 target/riscv/cpu.c       | 8 +++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 67291933f84..213aff31d85 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,8 +142,10 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
-/* Our implementation of CPUClass::has_work */
+#ifndef CONFIG_USER_ONLY
+/* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
+#endif
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..4a7e02d9a99 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1010,9 +1010,9 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+#ifndef CONFIG_USER_ONLY
 bool riscv_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     /*
@@ -1022,10 +1022,8 @@ bool riscv_cpu_has_work(CPUState *cs)
     return riscv_cpu_all_pending(env) != 0 ||
         riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE ||
         riscv_cpu_vsirq_pending(env) != RISCV_EXCP_NONE;
-#else
-    return true;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -2912,6 +2910,7 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
+    .has_work = riscv_cpu_has_work,
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
@@ -2933,7 +2932,6 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = riscv_cpu_class_by_name;
-    cc->has_work = riscv_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
-- 
2.47.1


