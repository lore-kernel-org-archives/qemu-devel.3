Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BBFC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyts-0003Gv-IV; Mon, 02 Mar 2026 03:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytm-0002aL-3v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyti-0001eD-OX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1//taG4v80HV7pxQnwGvKwm3iZy6wZS7mFJbO5AEtw=;
 b=e69wLZMaw7ttXEqiUOM59zzIRJDTYJzzlEYmMd7fZJ/7l038grsoqIRgA8mqPtwFGZ6XtX
 PYeemkEpsl46nA15tsKUwrcla3GxIj1kPsPPFJsJ247J6Xkm6WfVX+g47ZnuZZjJmOenjf
 bD2WVnzzXFoJEzD7F2uJ63j1bCatPJs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-aNMrBUreMnWZEN9E4zwyMg-1; Mon, 02 Mar 2026 03:45:00 -0500
X-MC-Unique: aNMrBUreMnWZEN9E4zwyMg-1
X-Mimecast-MFC-AGG-ID: aNMrBUreMnWZEN9E4zwyMg_1772441100
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b5346b6cso769440f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441098; x=1773045898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1//taG4v80HV7pxQnwGvKwm3iZy6wZS7mFJbO5AEtw=;
 b=lYkZw7H/m2Cz1CHFLKRHTL2pfwsNP4WOpoGdGztv0nDy5DEOFB4nV4+trxtBbYqPA9
 mGzOhdd5zuFY16PYmbvOsxhjMqhmHlN+9EKVFOEWhckb45Txq3l7eEZsAYy+GmOjfLgs
 U9xg9GpJuk5MB/Rj0mUQwvjhZwxFRgo7rohA5iTHF/YE+29zJkr3+4CfJtJeRQ9zc3Af
 +GGhVb+SJ16zeVXZscupdZAmGn2cJu6ojktWRFtsKwUAngSJh5b4jFJOiXPiFX1p36Ju
 g+a2n0BLRoXap7O6IZyqDY5zChwhNE1QlHgYKQkWknLKNkaA9uUCT+SIoqbVIp0XtSaT
 EifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441098; x=1773045898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1//taG4v80HV7pxQnwGvKwm3iZy6wZS7mFJbO5AEtw=;
 b=oWqmM6X2d3w59RMa0An6KQxmNllsxsY6Ut8kYd19XcoujulediOigeyrqQ9zP4rAUZ
 U+v0wKu6a3zhd6kWfr/xsVNxq5NIk5Ap1qSGAd275Ufnoq1gyxlEEiSv8c/TNGmDNiLJ
 fZg4Dxi3gnBHtPFNiePwfEJHPZ2NbDRbswGkchvXQb1UFwjVJmht2CcvL59DMEXYGO3W
 dba7D0uf20hdwvSzpqT5nZqjIRd5cjuLrKbmB9PSN15zbs7TvaZRxLKA7WS2Csxc56TN
 NcAPMcfGDYO3g1s7hZW3t+QBbDxvkfXQAm5h1zXFht8+Vr7kWyYy6p220VaXDbGNY+Mm
 hhUQ==
X-Gm-Message-State: AOJu0Yy1NLOhVMcNE41Uhb7XhqCz7Iz7L7B7oDEAanrJkLtkJ0RxTpHi
 WYQvw2og29L8713tagMf7Immihkca7+nPWsOqFYr8eT32fu6IGsm5pOk6VF8bMqVwj6QgXrpaqA
 SdboFlUZB16hExcc206MlMjH/k8u1poRgbYDpqt8qswKOG8KnlvR+47gBa9HfVXTNX0PGOIWV+b
 7HZ2gqAcZoZC43jE5iJKZh47GEk9wsuL+dCPvtgyTg
X-Gm-Gg: ATEYQzzrThyIUN6yyZLbmoh4uKsDcYRZzkEVFXT7G+Wk0aJe/h5VDBmKjrWadizZhdu
 7zVHnohj1XM2sn0zT1xHfL1+wYFg88GvveQYVQ++t/7OZKn5Fc3SfJlDO19N0PRqfju03Tys62k
 OgFoVI8XN3Au1oZluATuOwyReKDsgCTsuHgkPDzw2E/htgPTXf6kJbldet2qyhR2qpJzMccu6SE
 oRwv9VI4GpPsDNvSCX2zkvf0QaKd8K8T78NJ/HZqf6vMUAOG32VIuq+nJHeObYPAAb3jcFhgnf6
 RLdTEbBUtkVKcAXA52Fvm4nNPOmg31AEuSXhJq4L672YTq7zWTzEJYE4mLAVIjDVlK+HkrCcsYq
 OwPHfst5H092PK76K4Dhc2uYCwnqgpczBhE5ocj0y588IlIS/H/PhMYk7ZdfCdyVBnQN9e2pfn3
 64cCDRS5MBvuqZKI+tZxrfA2nTfPA=
X-Received: by 2002:a05:600c:81c9:b0:483:7783:5363 with SMTP id
 5b1f17b1804b1-483c9bfa6bdmr172976225e9.26.1772441098140; 
 Mon, 02 Mar 2026 00:44:58 -0800 (PST)
X-Received: by 2002:a05:600c:81c9:b0:483:7783:5363 with SMTP id
 5b1f17b1804b1-483c9bfa6bdmr172975785e9.26.1772441097503; 
 Mon, 02 Mar 2026 00:44:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm284181615e9.3.2026.03.02.00.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 029/102] target/i386: emulate: propagate errors all the way and
 stop early
Date: Mon,  2 Mar 2026 09:42:24 +0100
Message-ID: <20260302084338.473368-30-pbonzini@redhat.com>
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

This ended up being a bigger patch than I thought it'd be...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-29-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h |  18 +--
 target/i386/emulate/x86_emu.c | 227 ++++++++++++++++++++++------------
 2 files changed, 160 insertions(+), 85 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 6b691118221..0f284b0c3d1 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -44,15 +44,15 @@ target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
 target_ulong read_val_from_reg(void *reg_ptr, int size);
 void write_val_to_reg(void *reg_ptr, target_ulong val, int size);
-void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
+bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes);
-target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size);
+bool read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size, target_ulong* val);
 
-void exec_movzx(CPUX86State *env, struct x86_decode *decode);
-void exec_shl(CPUX86State *env, struct x86_decode *decode);
-void exec_movsx(CPUX86State *env, struct x86_decode *decode);
-void exec_ror(CPUX86State *env, struct x86_decode *decode);
-void exec_rol(CPUX86State *env, struct x86_decode *decode);
-void exec_rcl(CPUX86State *env, struct x86_decode *decode);
-void exec_rcr(CPUX86State *env, struct x86_decode *decode);
+bool exec_movzx(CPUX86State *env, struct x86_decode *decode);
+bool exec_shl(CPUX86State *env, struct x86_decode *decode);
+bool exec_movsx(CPUX86State *env, struct x86_decode *decode);
+bool exec_ror(CPUX86State *env, struct x86_decode *decode);
+bool exec_rol(CPUX86State *env, struct x86_decode *decode);
+bool exec_rcl(CPUX86State *env, struct x86_decode *decode);
+bool exec_rcr(CPUX86State *env, struct x86_decode *decode);
 #endif
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index ec6bc798a42..8d35f3338c1 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -47,7 +47,9 @@
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-    fetch_operands(env, decode, 2, true, true, false);  \
+    if (fetch_operands(env, decode, 2, true, true, false))  {\
+        return 1; \
+    }\
     switch (decode->operand_size) {                     \
     case 1:                                         \
     {                                               \
@@ -55,7 +57,7 @@
         uint8_t v2 = (uint8_t)decode->op[1].val;    \
         uint8_t diff = v1 cmd v2;                   \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 1);  \
+            if (write_val_ext(env, &decode->op[0], diff, 1)) { return 1; }  \
         } \
         FLAGS_FUNC##8(env, v1, v2, diff);           \
         break;                                      \
@@ -66,7 +68,7 @@
         uint16_t v2 = (uint16_t)decode->op[1].val;  \
         uint16_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 2); \
+            if (write_val_ext(env, &decode->op[0], diff, 2)) { return 1; } \
         } \
         FLAGS_FUNC##16(env, v1, v2, diff);          \
         break;                                      \
@@ -77,7 +79,7 @@
         uint32_t v2 = (uint32_t)decode->op[1].val;  \
         uint32_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 4); \
+            if (write_val_ext(env, &decode->op[0], diff, 4)) { return 1; } \
         } \
         FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
@@ -167,13 +169,20 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
     }
 }
 
-void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
+bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
     if (decode->type == X86_VAR_REG) {
         write_val_to_reg(decode->regptr, val, size);
     } else {
-        x86_write_mem(env_cpu(env), &val, decode->addr, size);
+        MMUTranslateResult res = x86_write_mem(env_cpu(env), &val, decode->addr, size);
+        if (res) {
+            if (res == MMU_TRANSLATE_GPA_UNMAPPED) {
+                return 0;
+            }
+            return 1;
+        }
     }
+    return 0;
 }
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
@@ -218,20 +227,19 @@ static bool read_val_from_mem(CPUX86State *env, target_long ptr, int size, targe
     return 0;
 }
 
-target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size)
+bool read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size, target_ulong* val)
 {
-    target_ulong val;
     if (decode->type == X86_VAR_REG) {
-        return read_val_from_reg(decode->regptr, size);
+        *val = read_val_from_reg(decode->regptr, size);
     } else {
-        if (read_val_from_mem(env, decode->addr, size, &val)) {
-            error_report("target/i386/emulate: read_val_ext: reading from unmapped address.");
+        if (read_val_from_mem(env, decode->addr, size, val)) {
+            return 1;
         }
-        return val;
     }
+    return 0;
 }
 
-static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
+static bool fetch_operands(CPUX86State *env, struct x86_decode *decode,
                            int n, bool val_op0, bool val_op1, bool val_op2)
 {
     int i;
@@ -251,8 +259,10 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
         case X86_VAR_RM:
             calc_modrm_operand(env, decode, &decode->op[i]);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, &decode->op[i],
-                                                 decode->operand_size);
+                if (read_val_ext(env, &decode->op[i],decode->operand_size,
+                                                            &decode->op[i].val)) {
+                    return 1;
+                }
             }
             break;
         case X86_VAR_OFFSET:
@@ -260,68 +270,81 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
                                                     decode->op[i].addr,
                                                     R_DS);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, &decode->op[i],
-                                                 decode->operand_size);
+                if (read_val_ext(env, &decode->op[i], decode->operand_size,
+                                                 &decode->op[i].val)) {
+                    return 1;
+                }
             }
             break;
         default:
             break;
         }
     }
+    return 0;
 }
 
-static void exec_mov(CPUX86State *env, struct x86_decode *decode)
+static bool exec_mov(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, false, true, false);
-    write_val_ext(env, &decode->op[0], decode->op[1].val,
-                  decode->operand_size);
+    if (write_val_ext(env, &decode->op[0], decode->op[1].val,
+                  decode->operand_size)) {
+        return 1;
+    }
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_add(CPUX86State *env, struct x86_decode *decode)
+static bool exec_add(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_or(CPUX86State *env, struct x86_decode *decode)
+static bool exec_or(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_adc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_adc(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_sbb(CPUX86State *env, struct x86_decode *decode)
+static bool exec_sbb(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_and(CPUX86State *env, struct x86_decode *decode)
+static bool exec_and(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_sub(CPUX86State *env, struct x86_decode *decode)
+static bool exec_sub(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xor(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xor(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_neg(CPUX86State *env, struct x86_decode *decode)
+static bool exec_neg(CPUX86State *env, struct x86_decode *decode)
 {
     /*EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);*/
     int32_t val;
@@ -342,15 +365,17 @@ static void exec_neg(CPUX86State *env, struct x86_decode *decode)
 
     /*lflags_to_rflags(env);*/
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_cmp(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmp(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_inc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_inc(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
@@ -358,33 +383,37 @@ static void exec_inc(CPUX86State *env, struct x86_decode *decode)
     EXEC_2OP_FLAGS_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_dec(CPUX86State *env, struct x86_decode *decode)
+static bool exec_dec(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
 
     EXEC_2OP_FLAGS_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_tst(CPUX86State *env, struct x86_decode *decode)
+static bool exec_tst(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_not(CPUX86State *env, struct x86_decode *decode)
+static bool exec_not(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 1, true, false, false);
 
     write_val_ext(env, &decode->op[0], ~decode->op[0].val,
                   decode->operand_size);
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_movzx(CPUX86State *env, struct x86_decode *decode)
+bool exec_movzx(CPUX86State *env, struct x86_decode *decode)
 {
     int src_op_size;
     int op_size = decode->operand_size;
@@ -398,13 +427,16 @@ void exec_movzx(CPUX86State *env, struct x86_decode *decode)
     }
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = read_val_ext(env, &decode->op[1], src_op_size);
+    if (read_val_ext(env, &decode->op[1], src_op_size, &decode->op[1].val)) {
+        return 1;
+    }
     write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_out(CPUX86State *env, struct x86_decode *decode)
+static bool exec_out(CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->opcode[0]) {
     case 0xe6:
@@ -426,9 +458,10 @@ static void exec_out(CPUX86State *env, struct x86_decode *decode)
         break;
     }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_in(CPUX86State *env, struct x86_decode *decode)
+static bool exec_in(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong val = 0;
     switch (decode->opcode[0]) {
@@ -463,6 +496,7 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static inline void string_increment_reg(CPUX86State *env, int reg,
@@ -523,7 +557,7 @@ static bool exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_ins(CPUX86State *env, struct x86_decode *decode)
+static bool exec_ins(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -533,9 +567,10 @@ static void exec_ins(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
@@ -551,7 +586,7 @@ static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_outs(CPUX86State *env, struct x86_decode *decode)
+static bool exec_outs(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -561,9 +596,10 @@ static void exec_outs(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
@@ -590,7 +626,7 @@ static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_movs(CPUX86State *env, struct x86_decode *decode)
+static bool exec_movs(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -600,9 +636,10 @@ static void exec_movs(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
@@ -630,7 +667,7 @@ static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmps(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_cmps_single, decode->rep);
@@ -638,6 +675,7 @@ static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
         exec_cmps_single(env, decode);
     }
     env->eip += decode->len;
+    return 0;
 }
 
 
@@ -660,7 +698,7 @@ static bool exec_stos_single(CPUX86State *env, struct x86_decode *decode)
 }
 
 
-static void exec_stos(CPUX86State *env, struct x86_decode *decode)
+static bool exec_stos(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_stos_single, 0);
@@ -669,6 +707,7 @@ static void exec_stos(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
@@ -685,7 +724,7 @@ static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_scas(CPUX86State *env, struct x86_decode *decode)
+static bool exec_scas(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = R_EAX;
@@ -696,6 +735,7 @@ static void exec_scas(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
@@ -711,7 +751,7 @@ static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_lods(CPUX86State *env, struct x86_decode *decode)
+static bool exec_lods(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_lods_single, 0);
@@ -720,6 +760,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code)
@@ -730,23 +771,25 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
     env->exception_injected = 1;
 }
 
-static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
     emul_ops->simulate_rdmsr(env_cpu(env));
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
     emul_ops->simulate_wrmsr(env_cpu(env));
     env->eip += decode->len;
+    return 0;
 }
 
 /*
  * flag:
  * 0 - bt, 1 - btc, 2 - bts, 3 - btr
  */
-static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
+static bool do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
 {
     int32_t displacement;
     uint8_t index;
@@ -755,7 +798,9 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
 
     VM_PANIC_ON(decode->rex.rex);
 
-    fetch_operands(env, decode, 2, false, true, false);
+    if (fetch_operands(env, decode, 2, false, true, false)) {
+        return 1;
+    }
     index = decode->op[1].val & mask;
 
     if (decode->op[0].type != X86_VAR_REG) {
@@ -769,14 +814,16 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
             VM_PANIC("bt 64bit\n");
         }
     }
-    decode->op[0].val = read_val_ext(env, &decode->op[0],
-                                     decode->operand_size);
+    if (read_val_ext(env, &decode->op[0],
+                                     decode->operand_size, &decode->op[0].val)) {
+        return 1;
+    }
     cf = (decode->op[0].val >> index) & 0x01;
 
     switch (flag) {
     case 0:
         set_CF(env, cf);
-        return;
+        return 0;
     case 1:
         decode->op[0].val ^= (1u << index);
         break;
@@ -787,41 +834,58 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
         decode->op[0].val &= ~(1u << index);
         break;
     }
-    write_val_ext(env, &decode->op[0], decode->op[0].val,
-                  decode->operand_size);
+    if (write_val_ext(env, &decode->op[0], decode->op[0].val,
+                  decode->operand_size)) {
+        return 1;
+    }
     set_CF(env, cf);
+    return 0;
 }
 
-static void exec_bt(CPUX86State *env, struct x86_decode *decode)
+static bool exec_bt(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 0);
+    if (do_bt(env, decode, 0)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_btc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_btc(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 1);
+    if (do_bt(env, decode, 1)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_btr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_btr(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 3);
+    if (do_bt(env, decode, 3)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_bts(CPUX86State *env, struct x86_decode *decode)
+static bool exec_bts(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 2);
+    if (do_bt(env, decode, 2)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_shl(CPUX86State *env, struct x86_decode *decode)
+bool exec_shl(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
 
-    fetch_operands(env, decode, 2, true, true, false);
+    if (fetch_operands(env, decode, 2, true, true, false)) {
+        return 1;
+    }
 
     count = decode->op[1].val;
     count &= 0x1f;      /* count is masked to 5 bits*/
@@ -878,12 +942,14 @@ void exec_shl(CPUX86State *env, struct x86_decode *decode)
 exit:
     /* lflags_to_rflags(env); */
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_movsx(CPUX86State *env, struct x86_decode *decode)
+bool exec_movsx(CPUX86State *env, struct x86_decode *decode)
 {
     int src_op_size;
     int op_size = decode->operand_size;
+    target_ulong val;
 
     fetch_operands(env, decode, 2, false, false, false);
 
@@ -895,15 +961,18 @@ void exec_movsx(CPUX86State *env, struct x86_decode *decode)
 
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = sign(read_val_ext(env, &decode->op[1], src_op_size),
-                             src_op_size);
+    if (read_val_ext(env, &decode->op[1], src_op_size, &val)) {
+        return 1;
+    }
+    decode->op[1].val = sign(val, src_op_size);
 
     write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_ror(CPUX86State *env, struct x86_decode *decode)
+bool exec_ror(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
 
@@ -979,9 +1048,10 @@ void exec_ror(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_rol(CPUX86State *env, struct x86_decode *decode)
+bool exec_rol(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
 
@@ -1060,10 +1130,11 @@ void exec_rol(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
 
-void exec_rcl(CPUX86State *env, struct x86_decode *decode)
+bool exec_rcl(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
@@ -1146,9 +1217,10 @@ void exec_rcl(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_rcr(CPUX86State *env, struct x86_decode *decode)
+bool exec_rcr(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
@@ -1221,9 +1293,10 @@ void exec_rcr(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xchg(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, true, true, false);
 
@@ -1233,20 +1306,22 @@ static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
                   decode->operand_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xadd(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xadd(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     write_val_ext(env, &decode->op[1], decode->op[0].val,
                   decode->operand_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
 static struct cmd_handler {
     enum x86_decode_cmd cmd;
-    void (*handler)(CPUX86State *env, struct x86_decode *ins);
+    bool (*handler)(CPUX86State *env, struct x86_decode *ins);
 } handlers[] = {
     {X86_DECODE_CMD_INVL, NULL,},
     {X86_DECODE_CMD_MOV, exec_mov},
-- 
2.53.0


