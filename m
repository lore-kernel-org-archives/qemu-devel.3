Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VU-0005B6-5w; Tue, 12 Mar 2024 08:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VI-0004cA-M3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VA-0000aT-Qm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTy1j2FcNx/LRv42hVeztNg1Pww4AJJ67w4oKt1Dfo0=;
 b=XToerOhGL7/haQvhyxvyZsFX2LWt6tXX4F9e+jxszM4VObFaoXfmpMJjuBnZu31nt/Q+W1
 3NM1sddvbxTEM9liDA6E+2mCPuogkux6r65QzNg5WWcB/Ll/OBp8jYAG/G2x3M0IC1O7sL
 MwkD11iu0o2vG3/yo4f37n8t+9WYupc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-ujwf2IJYMU2Mv4rLfFNuVA-1; Tue,
 12 Mar 2024 08:45:00 -0400
X-MC-Unique: ujwf2IJYMU2Mv4rLfFNuVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 585853C0F18F;
 Tue, 12 Mar 2024 12:44:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 378B5492BC4;
 Tue, 12 Mar 2024 12:44:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/55] target/hexagon: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Tue, 12 Mar 2024 13:43:25 +0100
Message-ID: <20240312124339.761630-42-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240129164514.73104-12-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/hexagon/cpu.c     | 25 ++++++-------------------
 target/hexagon/gdbstub.c |  6 ++----
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index d41c6452a2..3a716b9be3 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -236,10 +236,7 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
 
 static void hexagon_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-
-    hexagon_dump(env, f, flags);
+    hexagon_dump(cpu_env(cs), f, flags);
 }
 
 void hexagon_debug(CPUHexagonState *env)
@@ -249,25 +246,19 @@ void hexagon_debug(CPUHexagonState *env)
 
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-    env->gpr[HEX_REG_PC] = value;
+    cpu_env(cs)->gpr[HEX_REG_PC] = value;
 }
 
 static vaddr hexagon_cpu_get_pc(CPUState *cs)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-    return env->gpr[HEX_REG_PC];
+    return cpu_env(cs)->gpr[HEX_REG_PC];
 }
 
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
                                             const TranslationBlock *tb)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->gpr[HEX_REG_PC] = tb->pc;
+    cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
 static bool hexagon_cpu_has_work(CPUState *cs)
@@ -279,18 +270,14 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
-
-    env->gpr[HEX_REG_PC] = data[0];
+    cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
 static void hexagon_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj);
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 6007e6462b..502c6987f0 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -22,8 +22,7 @@
 
 int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
         uint32_t p3_0 = 0;
@@ -42,8 +41,7 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
-    CPUHexagonState *env = &cpu->env;
+    CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
         uint32_t p3_0 = ldtul_p(mem_buf);
-- 
2.44.0


