Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F9ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShJK-0003X8-RR; Thu, 28 May 2026 16:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIJ-0001kl-5z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShIG-0005Vz-R9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so8303853f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999927; x=1780604727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TquQUdlMRRYHj7XmSbmtpExSYqQiNjBhucGszPwHlX0=;
 b=a94y2Us/I6RN591r8WtGK5DV/bQ0sJYwyH6qAM/wCULltu696WLHItl33jfdCzFl/V
 YYckQ1R4N8u5or5s/lWACkNlDa8H2wpXbadO0hPgpI5s8qVH1jdFuH7+Xn/NhVhiTVWy
 MUzqwvauEWbbGGpfxQSM697l9kiX31QzFoAcatZKQbt6FN0+VJmP7FCCDtB8z+Z3YDBc
 vAXwOWOXLOeonKer1BrHZTImNzU019h68ln+9n92rRux8b+zSQJ6NoyCsdKTFoGMAOzN
 HDu1/xtA3EjwZTh6utofBtaMysZjhj1DC3aN2IP92dZ3OFNR77RoLQCKChC0fMCJn3Tb
 mzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999927; x=1780604727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TquQUdlMRRYHj7XmSbmtpExSYqQiNjBhucGszPwHlX0=;
 b=C6JKvP4p3ri/IZDeLcVZAjiDlKVUqXy5aQpS3c0nEzP1Q6wlTUwS39WMEpU8nQu1Ih
 ZwqOjiFSC2yezVLeWFkaBMYP2O7WnihdV9LgNKyjQ5PKRrMclg26RHERp6bqy6jlh/wu
 PxK6Ge52iB2/3ZFpprx+HzWCJCbPejbInIMSrE3FQRlREFztRNOVJrSHbsbdIXKZFvkO
 owrml47gFbmbPyUNf6Kkd/BlRSB5RhwhH4XWZi7Jq33O/cNJirqgWv3+RIxfrqpenYmc
 ZJEBVzx6Kklff3S3M4wQHogCjIOoSDUB0EOD1bBUnremByKfFjn7hgPZAoK7+tgOgwc3
 UwVA==
X-Gm-Message-State: AOJu0YzgtoUDhxQZirDO7Qk52QVdP/aUdoy1euOh0JT4tF16JYKzz8Dj
 /rVSbUHonDSsQi0nHCdr6Q8yTKgRzcz3TAIIM32sJenNaya1IbK49Kfx2EJSEZiY0iicorwlYU6
 fBvCOoqUu7w==
X-Gm-Gg: Acq92OF6KGRThEwvnhDH7naAAIllK/WIrWvs+g0Yft5aGDIUP+kIVfv66ya4u0H7QIl
 q4KBsY68L0kRBlkHhc8auiKDLl0uvH5KL/i0yyvmdnj4uKo1jgSP3mUriLi7ThxEVFBqq/3TPuE
 kr48NTXvurssFd6fzy9j7lViTGa9g5A6zPCsc/zgGDD0FmlFb9V8/b31lMijCdJDrhsTm9IynLc
 j4klcJimD8TOV30rcnR6aGbYlsxqrxiSyhxMBJJGN921izCbhkBEZb0AJO83XMZLIXq+UMKb3ht
 3z4Df/V0QfinxqNJ+EFdHzVR032GOuWm98paPO4KlnFtL1T9zNybCEDtq/8ib7aP+5oQaF2Ac0v
 fkVTjLa8r4CkOKkmItvap5uzsDz96SY2RQngHfJLv0RvOqIkolebavJELbQtpgVz2/p8oAY9jXA
 lGlw5YjMXatCvndbO6iJlMC0JDyzj+Xh5dlAMOHFuRnjC7V7jwVa5oWRR8EaDTOEzXHg==
X-Received: by 2002:a05:6000:25fa:b0:45e:655d:6f7 with SMTP id
 ffacd0b85a97d-45ef04da07cmr1211633f8f.24.1779999926658; 
 Thu, 28 May 2026 13:25:26 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2c87sm15844126f8f.17.2026.05.28.13.25.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/22] target/microblaze: Convert to translate_for_debug
Date: Thu, 28 May 2026 22:22:50 +0200
Message-ID: <20260528202253.49122-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
x86 and microblaze.  Convert microblaze to the newer
translate_for_debug method, as a step towards being able to remove
get_phys_addr_attrs_debug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260528161450.3564396-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h    |  4 ++--
 target/microblaze/cpu.c    |  2 +-
 target/microblaze/helper.c | 16 +++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 068da605295..b9602f72b94 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -369,8 +369,8 @@ struct MicroBlazeCPUClass {
 #ifndef CONFIG_USER_ONLY
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result);
 #endif /* !CONFIG_USER_ONLY */
 G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                            MMUAccessType access_type,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index c6a456dd5ec..a97c92a7b68 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -428,7 +428,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
     .has_work = mb_cpu_has_work,
-    .get_phys_addr_attrs_debug = mb_cpu_get_phys_addr_attrs_debug,
+    .translate_for_debug = mb_cpu_translate_for_debug,
 };
 #endif
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 3434ea47e8c..6a982c18c0f 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -280,8 +280,8 @@ void mb_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
-                                        MemTxAttrs *attrs)
+bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                TranslateForDebugResult *result)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     hwaddr paddr = 0;
@@ -289,10 +289,6 @@ hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
 
-    /* Caller doesn't initialize */
-    *attrs = (MemTxAttrs) {};
-    attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
-
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
@@ -303,7 +299,13 @@ hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
         paddr = addr;
     }
 
-    return paddr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = paddr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.53.0


