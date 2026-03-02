Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60220D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyt7-0001ZJ-RO; Mon, 02 Mar 2026 03:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt4-0001X7-3x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysy-0001Wk-9l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxeFgXMQUKofiCJ9WaS9KH7c4WL0gbGsydEVVUW1XxA=;
 b=Eqec8GDj6ja7xKZPLWd5wNHhoC+epn4dCLG7TDbXdrv1PRbjdHuG2im4veZkBazf+NbV+0
 NV0mUEPQkHEN9wsnHkhR7uQBX1jKOZ3poQwYq7kPqaBEj/UYvX6948al/afqgkkqTCeDNj
 JQ/IagRqCW80ecRIcpkqITFHcUJEAfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-A58fMCZXMf6G8FBQIxxptQ-1; Mon, 02 Mar 2026 03:44:12 -0500
X-MC-Unique: A58fMCZXMf6G8FBQIxxptQ-1
X-Mimecast-MFC-AGG-ID: A58fMCZXMf6G8FBQIxxptQ_1772441051
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso32788695e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441049; x=1773045849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxeFgXMQUKofiCJ9WaS9KH7c4WL0gbGsydEVVUW1XxA=;
 b=TGarHLB3flNu6DpjqCsIok/eGV/rO/fsFtOX3b6Hpntotp7PQB+ZUlXW3sQ6sc4mGO
 gHSTw641a5F0/mWLM5XwToujgc3nLbLphJpe49rMfZhVw+is5Dmtgtv0vyofuCC5AN+c
 eWsG37dMSd5C00DC1+SvpXz6CkHeF5Tdnz1kI6aAZ771UrNjTMFIH5hiqTVrhrS2q327
 /3FRMwH58ql6f1LpC3vKW/hnlX7vlwVgPglwUnoNuPE9fT6fvQbI3QKRxC4PpUvglemW
 oYQH/pKU8fZZCQatQmqeuMavRp9M9kTWHEjhl8t/wpkxiMmozPfB5fUHb9dBC7ck4ZQe
 r8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441049; x=1773045849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KxeFgXMQUKofiCJ9WaS9KH7c4WL0gbGsydEVVUW1XxA=;
 b=ufqScnXn3QZBIP2N+rl3qCynjc3qCLM1XNLKj7cDG6Ffo5jhDiZcsVwmIQwG12AQVR
 07NZOwbPISlHqOHz+BvP2z0+IlzBiXchJ2JJ9FDMG56Tudsu9dlQycgIkqre1tFt8zQ/
 m2yD6BvKmacCKbYLkGOeP3ZOHyg9Z7Uu4GDHTWstmMo3ef8Tf+X0i9uvSFOlt3D8WPFh
 ljKckB5pZHFrQT2mfxiaCzMGBD4IFk955Z/A2CDMHnX+ZTaZ9aCUpyGGLa8+4zIFtoHu
 mMVcVrOMtyhza+nyJq+t9P94wiZ1kMMesowoAwXmxQvJyuUQZiC4KTM7R0gHGDueQMTi
 j0sA==
X-Gm-Message-State: AOJu0Yw1H8zXZmEadE6bu4HhGJLJmYclkhsLGgVKkS5hOETxoGhmCEYm
 lDdKn5upEJxKDeMCx0ueyei4S/I/RwCmrhEd5kMkAm0mURtpKiXVdrFOE1o+3o2kI6Nuc7qRAup
 vWOaesP0Ay0TwlPlOtElFP8peLaGIC6MGLPKFSh/OJrQkjOtfvq/5R7thG8PZ7uT2HBsA5WuhB1
 TM3DRmoOpxwg95Mspuzbe8KxgPcZ0w+ecnuTV7EvoZ
X-Gm-Gg: ATEYQzzmvVIdcfOJKRjNjW/+Mw6c+vXRlYD9y6wCJTbwPuDAL+hlxyZ5vg5nhB92ztE
 JhJg7ljnrpc3ypbzi75XANlJs7htCQY0Htv7bydFR++Cmps+OqztR23b8JBEr1h48ghymtXp5qI
 /hzDJcCrtqDGn6xBPFntkXASb2rMyMxwIB294dK4hUWcYdecXUhdlhfi0I3JDGyfwZHfdK5i3kC
 3jSrMpLW9JA3HyP2k5m3qH0U1VQFauNTAI2OD84PZLykVGtY44N6UnIIRD8co5PMyD0hREAKAb1
 M/iqMnAyJvzAaxy2Cu9MHajsu16dglgv4P/deZdUyYt+Qisy1wWrwMOZjOphcv6mw//d0hCE9ST
 sCVU6ViLuCGOLTnsWo1Txj8l3h30mabAJG1sqhzCjHH/fh074hCb8CrWq3cuK1zM5qaUFawuRsU
 zVCAmOIOnV5Bx4tSiQdXe0al+Z330=
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211380195e9.2.1772441049219; 
 Mon, 02 Mar 2026 00:44:09 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211379655e9.2.1772441048686; 
 Mon, 02 Mar 2026 00:44:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm413479265e9.7.2026.03.02.00.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 010/102] whpx: move whpx_get_reg/whpx_set_reg to generic code
Date: Mon,  2 Mar 2026 09:42:05 +0100
Message-ID: <20260302084338.473368-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

These will be used in the next commit on the x86_64 backend too.
Also move flush_cpu_state as it's used by get_reg/set_reg and the arm64 code.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20260223233950.96076-10-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-common.h |  3 +++
 accel/whpx/whpx-common.c     | 35 ++++++++++++++++++++++++++++++++++
 target/arm/whpx/whpx-all.c   | 37 +-----------------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index b86fe9db6eb..a4e16e13099 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,6 +20,9 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+void whpx_flush_cpu_state(CPUState *cpu);
+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val);
+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val);
 
 /* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
 #define WHPX_INTERCEPT_DEBUG_TRAPS 1
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c57a0d3f0f9..21e9f1a1781 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,6 +46,41 @@ static HMODULE hWinHvEmulation;
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
 
+void whpx_flush_cpu_state(CPUState *cpu)
+{
+    if (cpu->vcpu_dirty) {
+        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+        cpu->vcpu_dirty = false;
+    }
+}
+
+void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    whpx_flush_cpu_state(cpu);
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, &val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
+    }
+}
+
 /* Tries to find a breakpoint at the specified address. */
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)
 {
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 0a31c7b9464..0d56e468bdf 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -273,14 +273,6 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
 };
 
-static void flush_cpu_state(CPUState *cpu)
-{
-    if (cpu->vcpu_dirty) {
-        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
-        cpu->vcpu_dirty = false;
-    }
-}
-
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 {
     if (exceptions != 0) {
@@ -313,33 +305,6 @@ void whpx_arch_destroy_vcpu(CPUState *cpu)
     /* currently empty on Arm */
 }
 
-static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-
-    flush_cpu_state(cpu);
-
-    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-         &reg, 1, val);
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
-    }
-}
-
-static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-         &reg, 1, &val);
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
-    }
-}
-
 static void whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE *val)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -526,7 +491,7 @@ int whpx_vcpu_run(CPUState *cpu)
         if (advance_pc) {
             WHV_REGISTER_VALUE pc;
 
-            flush_cpu_state(cpu);
+            whpx_flush_cpu_state(cpu);
             pc.Reg64 = vcpu->exit_ctx.MemoryAccess.Header.Pc + 4;
             whpx_set_reg(cpu, WHvArm64RegisterPc, pc);
         }
-- 
2.53.0


