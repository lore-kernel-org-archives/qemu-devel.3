Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FCC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Xw-0000Rs-7x; Tue, 12 Mar 2024 08:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VK-0004eQ-9s
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VI-0000bZ-3Y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXkoorxlTSEReqUP0thEsel8IhSLhhmlljcP3i1qTlY=;
 b=hoYr82GQA2xwQYTmtkr/NhNSBeaVAZo0YOYJJ5J3X8CMFPH7zBDp5BfqyKWY2qi3vYJ6j+
 TrWcEc6VAYX2GOQYo0fdUKQXRld64XenMRzHKaJ3TvTI3U9BTn37nBjL0fp6xHj6FCw8o0
 MtU7pMyTqjocA7j4pyJiQtyurheL9DM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-fuQxiqVOPj-Uykq2VpXB-A-1; Tue,
 12 Mar 2024 08:45:06 -0400
X-MC-Unique: fuQxiqVOPj-Uykq2VpXB-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77A5386A0A7;
 Tue, 12 Mar 2024 12:45:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF0FA492BC4;
 Tue, 12 Mar 2024 12:45:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/55] target/microblaze: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Tue, 12 Mar 2024 13:43:29 +0100
Message-ID: <20240312124339.761630-46-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-18-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/microblaze/gdbstub.c   | 3 +--
 target/microblaze/helper.c    | 3 +--
 target/microblaze/translate.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index eb168d1007..09d74e164d 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -110,9 +110,8 @@ int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
     uint32_t tmp;
 
     if (n > cc->gdb_num_core_regs) {
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 460eee0cf5..d25c9eb4d3 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -252,8 +252,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
 
     if ((interrupt_request & CPU_INTERRUPT_HARD)
         && (env->msr & MSR_IE)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a465c2d245..4e52ef32db 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1630,7 +1630,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
-    CPUMBState *env = cpu_env(cs);
     uint32_t ir;
 
     /* TODO: This should raise an exception, not terminate qemu. */
@@ -1641,7 +1640,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = cpu_ldl_code(env, dc->base.pc_next);
+    ir = cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
@@ -1800,8 +1799,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
+    CPUMBState *env = cpu_env(cs);
     uint32_t iflags;
     int i;
 
-- 
2.44.0


