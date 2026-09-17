Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA083C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77S3-0001yw-2r; Thu, 17 Sep 2026 04:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Rt-0001y3-ID
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:29 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77Rp-0002vg-Uh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:26:28 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so5254225ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633582; x=1790238382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJDnLsnWHhzbZgpskXvFIj3BvWPVniv6p550VmuEYUQ=;
 b=W+lex79b0Lz7FEGjcHJ+wOKWN18XsOv0Dyc2DDQPtdgL+Ngs7oC/1LckzQthe5HbHC
 u3kEu9TIxCabVv4WAGMvHPz4fa/PNEC/VXYoXd1eFlRpPoYL/CtSBN6MJbT0t7GSjaMO
 uIood1jnQqmOMFgrMaYkf+PsotyYbQ7tOYgTTXje6vDnUI/N7OpOJJh4NrhFVfkZCd5P
 rphjhQYrJq5od7HwHAmOMVvNn+qLXSFnsRjjWFoPt3kPL6Dy/BaEIEQkV9b7fuRsf4/x
 0KLPHz3PEmemJQAGZSgIPwoZidh++xCDokrcS6iYuesrhE3OJvRKjC8EvmG87+WgtUk+
 /XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633582; x=1790238382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJDnLsnWHhzbZgpskXvFIj3BvWPVniv6p550VmuEYUQ=;
 b=JcmMd7o31Qmg9QLe02jFDqYS686LL1h1H9qpVrK5Cwmw27gVuXSHrWp0oCyaYEYA9E
 lqLN24n5SdhcF6mpEwu7Xy/HYKO5M27js/yP1iOwcMG3k1CCJXP3xWiQs3MMXxEDVb9n
 Z+BCXwRAUjbC4Eh0nEadzBkvjlgm2qRBDEn2H01TsxXAEKFfGQIFHsHzBzG0PsY6DIyb
 wXd4eytzwVPE1TNvzYGqM0kgg/Oyt6yZb0muaXnTsRCW8y1i0LmXIbOW7nnvXR4DP9tU
 +aiX7YmB9O45thcyIP8IXp8fhQnamvcE7zCChA3RRO4vD8Eq/kTvnBXERj5cDPzHxTOI
 ICkw==
X-Gm-Message-State: AFuF++n8Vrwu8tCiXizoMDEc6BB0/yNTo9g+5DPEZOMXbWeZ3dilH4a1
 y62EOc1rQpN9TbNKqgisJL4QVPgpFEpijsX7aZcw6+w4AaOsVtS2TA3IjTiDhg2x6v1/Uq6kMi1
 zkF1+oaM=
X-Gm-Gg: AYBFou29Yaigu9wLZnv+5O13bpihc6Ufik1b06iE+sxie4rt22x++K1wZayT/TW/pa0
 TNkxwbuedCZ+UZ+8sxdjbr5a6xIl4SZa/SuydEjZYfyPhhies6XWmJiPTpsKZioS6eHk0yZ+kqm
 2drHAqDegpf5Ma3vCya3UddHhmRcUJBltObUnE93K43OPjcM8liE95UXI6lj+Xnga+J9kXPZ/2Y
 OqgUqXcsETgrrKpQPhirYRX7AYwU6meI0qy8sqZrJFBFXQIcstxe/NoWab/Cj3/GBJIJdv75bpd
 E+usNJt6B8n7v+3+JO/4qAUxvDBCdEohM3u0sGfY0HacfyvDMWQqLBe9I6wdKCo4uC6GmqzYKej
 KSCwgfiKKW4IpAakdDAj4oxKhjGSP1tS5W7lVJr6J/1EVO6XEdm3voixotvwiXykQZwyVA1IEV1
 IJIrT2TultgNRB7A3cZB4RW/vw9rrY44KiPZZs9la4gwrw9OyZHKnLw73zfQ1YCZRuQDb9FEPii
 vkrcu7c
X-Received: by 2002:a17:902:f54f:b0:2dd:8b95:d8fb with SMTP id
 d9443c01a7336-2dd8e52df8emr128503095ad.14.1789633581988; 
 Thu, 17 Sep 2026 01:26:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac978esm13484357eec.18.2026.09.17.01.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 1/2] accel: Change AccelOpsClass.update_guest_debug to void
Date: Wed, 16 Sep 2026 22:26:17 -1000
Message-ID: <20260917082618.1076988-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917082618.1076988-1-richard.henderson@linaro.org>
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The return value is never used, so drop it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/accel-cpu-ops.h | 2 +-
 include/system/hvf_int.h      | 2 +-
 accel/hvf/hvf-accel-ops.c     | 3 +--
 accel/kvm/kvm-accel-ops.c     | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index f0c7ee7542c..af71fd9ab34 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -85,7 +85,7 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    int (*update_guest_debug)(CPUState *cpu);
+    void (*update_guest_debug)(CPUState *cpu);
     int (*insert_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
                                      vaddr addr, vaddr len);
     int (*remove_gdbstub_breakpoint)(CPUState *cpu, GdbBreakpointType type,
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a01691ce172..1b419b5428a 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -105,7 +105,7 @@ void hvf_arch_remove_all_gdbstub_hw_breakpoints(void);
  * Update guest to enable or disable debugging. Per-arch specifics will be
  * handled by calling down to hvf_arch_update_guest_debug.
  */
-int hvf_update_guest_debug(CPUState *cpu);
+void hvf_update_guest_debug(CPUState *cpu);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d2276d8513e..6491a109ba4 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -227,10 +227,9 @@ static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
     hvf_arch_update_guest_debug(cpu);
 }
 
-int hvf_update_guest_debug(CPUState *cpu)
+void hvf_update_guest_debug(CPUState *cpu)
 {
     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
 }
 
 static int hvf_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c8e7aa38709..47244d33f7d 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -86,9 +86,9 @@ static bool kvm_cpus_are_resettable(void)
 }
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-static int kvm_update_guest_debug_ops(CPUState *cpu)
+static void kvm_update_guest_debug_ops(CPUState *cpu)
 {
-    return kvm_update_guest_debug(cpu, 0);
+    kvm_update_guest_debug(cpu, 0);
 }
 #endif
 
-- 
2.53.0


