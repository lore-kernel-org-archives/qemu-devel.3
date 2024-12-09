Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E97E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVB-0006Gl-Md; Mon, 09 Dec 2024 15:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV7-0006De-W5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:06 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV5-0003DC-IA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:05 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so870330866b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776622; x=1734381422;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hi0SZTNhz11ho3vCY2FYS+EKuGIwlKWvrSV2lPVozDU=;
 b=LytLI0b4iJMT6mfRLDoHGMDH0C/XjYWsXujFYX1U/r/nifkvCkEQrUpeSjpEynhl5w
 Rsw8EIEnoTSjoODXWu0r7B538DG+pUEYzUib68JvFku+aO/NBQnU/iJ5jyljwwyTHsbj
 XsBmgSilDfCx+17WxR9GPNvMpkm7Syd/MURkGTjk2Z1qhTdslzolfu9R1kmtCSI0fpTs
 H4Oz4WyrA8YSghBAC3P2LFwzEvXlltk9dqGTLGuVEwx+OU8weo1fjLIvznbYML+vc/mn
 sP8e98AtqT/FQlTOtiXzDvODgmWtGKfxMv7ZZPgibqvwJHxsR6INqVTx2806Qgx9vojs
 N9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776622; x=1734381422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hi0SZTNhz11ho3vCY2FYS+EKuGIwlKWvrSV2lPVozDU=;
 b=mklPMLx4q8YKAPKYF+9UIcee5uzOIOOpyr6cigUKsZKJI9USR8Q0VWaMLUkvkA/iY1
 WpKhgCzwBBZ0feGcHXl8/tab6QlwndPd45v8GSa2CH8YjWPySVka4CbqkGXjM1lI4vvk
 ilYSXDsc/BpnH2x8MZ6i/oow9D1vmr6SEriVyl23shlp61DoKZ3tf3P30+5l6o0prqfA
 eh41uYocxnQiw4ml2yLT2DnlE5adi1DOsbNLfxWE1w2pgk02hPfLhML8TO4uCSNmSpNg
 5KqeddzYOoNVc8hAx6VxmzcSbeGzB1qeFY5soSxjyUnXqsz7fcYp6v2dm6RoaEFuip6l
 8r3A==
X-Gm-Message-State: AOJu0YxWUTyGCbtgGtb6X7f30vZuT0TivWAVAYvhFpOvzK/anPPvvOjs
 N1xGo5ZRq8kTPzA3uFcbL7AcFUSenGZdaK03lRrIagWld02V8DQjsoLq6+hfOb58h42CqFGk7ft
 OZw==
X-Gm-Gg: ASbGncsAxUhc1YAvOd1NzHjsvrDCp+mWmtCAH7oZYFzzSKSoive3+3+G9yP/5WxczmZ
 vgtba7CRxET9ZN0kXClTkoT/BRpXzrgo6JxIE78i/UKubuTJtH98sJck1bsCkU0Se0sZXHveoBK
 p6AjnjNM4HlzamF5p6m/rMWRypXuKgoRxAaADOUJGpcaUlWtgBld83v1/57gr0FUMlBKB1bWgUj
 CCVUOyUjEyLH2ZxzI+Yh4vS5wT08deAtAi3/XST6gH3VhEu4shpvQAcd4ok74e4fbe5CFhWdmr+
 s4+rHI9vLh4AVTEXFKA6QHsaAHN0+w==
X-Google-Smtp-Source: AGHT+IF97ZP4nL6Caxhy2PrICmPoNEio8MDbDpQr48YBwj0h6+Tmb9xVPRXPbfzgKVgW2Kg/0c4fyg==
X-Received: by 2002:a17:907:3f11:b0:aa6:42d8:afac with SMTP id
 a640c23a62f3a-aa6a01bea0bmr85134066b.15.1733776621756; 
 Mon, 09 Dec 2024 12:37:01 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:01 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 04/11] i386/hvf: Pre-fetch emulated instructions
Date: Mon,  9 Dec 2024 21:36:22 +0100
Message-Id: <20241209203629.74436-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::634;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x634.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The HVF x86 instruction decoder has previously read each instruction
component a few bytes at a time. The HVF vCPU VM exit reports the length
of the faulted instruction, so we can just pre-fetch the memory for the
whole thing in one go, saving extra round-trips for most instructions.

The old code path is retained in case there is a race between VM exit
and another thread overwriting the faulted instruction. In this case,
the instruction length could be wrong, so we allow fetching additional
instruction bytes the traditional way if the prefetched bytes are
overrun.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c        |  6 +++---
 target/i386/hvf/x86_decode.c | 18 +++++++++++++++---
 target/i386/hvf/x86_decode.h |  5 ++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 936c31dbdd..095f934923 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -522,7 +522,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 struct x86_decode decode;
 
                 load_regs(cpu);
-                decode_instruction(env, &decode);
+                decode_instruction(env, &decode, ins_len);
                 exec_instruction(env, &decode);
                 store_regs(cpu);
                 break;
@@ -562,7 +562,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             struct x86_decode decode;
 
             load_regs(cpu);
-            decode_instruction(env, &decode);
+            decode_instruction(env, &decode, ins_len);
             assert(ins_len == decode.len);
             exec_instruction(env, &decode);
             store_regs(cpu);
@@ -667,7 +667,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             struct x86_decode decode;
 
             load_regs(cpu);
-            decode_instruction(env, &decode);
+            decode_instruction(env, &decode, ins_len);
             exec_instruction(env, &decode);
             store_regs(cpu);
             break;
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index a4a28f113f..79dfc30408 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -73,8 +73,13 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    vmx_read_mem(env_cpu(env), &val, va, size);
+
+    if (decode->len + size < decode->prefetch_len) {
+        memcpy(&val, decode->prefetch_buf + decode->len, size);
+    } else {
+        target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
+        vmx_read_mem(env_cpu(env), &val, va, size);
+    }
     decode->len += size;
     
     return val;
@@ -2099,9 +2104,16 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+uint32_t decode_instruction(CPUX86State *env, x86_decode *decode,
+                            uint32_t ins_len)
 {
     memset(decode, 0, sizeof(*decode));
+
+    target_ulong va = linear_rip(env_cpu(env), env->eip);
+    uint32_t prefetch_len = MIN(ins_len, sizeof(sizeof(decode->prefetch_buf)));
+    vmx_read_mem(env_cpu(env), decode->prefetch_buf, va, prefetch_len);
+    decode->prefetch_len = prefetch_len;
+
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index a2d7a2a27b..0ff368210b 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -297,11 +297,14 @@ typedef struct x86_decode {
     bool is_fpu;
     uint32_t flags_mask;
 
+    uint8_t prefetch_buf[16];
+    uint16_t prefetch_len;
 } x86_decode;
 
 uint64_t sign(uint64_t val, int size);
 
-uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
+uint32_t decode_instruction(CPUX86State *env, x86_decode *decode,
+                            uint32_t ins_len);
 
 target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size);
-- 
2.39.3 (Apple Git-146)


