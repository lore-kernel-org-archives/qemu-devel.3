Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B794CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPH2-00009A-J0; Wed, 12 Nov 2025 23:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vJPGe-0007zJ-VP
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 23:49:12 -0500
Received: from outbound1.eu.mailhop.org ([52.28.251.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vJPGc-0000Qq-3X
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 23:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=EQiK/d4eR2OKP/BGJNe6aFXzoB5xSfYMqlOp9tbaIbs=;
 b=IzKzuIE4gUgPTkWrN3VAbgazAx64rNCX4PCGG0kVq+Nh9adPG+iHYDKbAvREoKr8mlnVljHuuevzd
 W9/3FTenmNrZkZI7I0Z894Kir++Qiylacdn7beiYlvNrnl9Z7r1oye9YeIu/fReqsLNHYvcXmJrhXF
 Woxya6iit01B1oUE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=EQiK/d4eR2OKP/BGJNe6aFXzoB5xSfYMqlOp9tbaIbs=;
 b=bHBB2BYBhBvTtHy9NaOsbHvVVHSX9A6RhNKuswuuUkyLOJS42i84kgBID7rZzz8wW1gLsZxekGzKK
 DOdw8bPhTXxZBb158OmVJfGmPpYv6iZgA4sXKRfDzzKk9kIrIwpEbcVzwp9Vot36S3M78j/t/keTo+
 VjNiDHGHxEddjCkk+1f1OcB5rgB22qwDawPiD8pRnK8TIrvU6pRC5+lrdZ9LJ4de0NOFQKcaDQQoET
 i65nrw/PT4azX4s3ZbcNLZQI2z8MhHQ0t/qtnq6ue2siYh1NuETkCrkIsG8c9nh1kUJO5lpyjPxzp0
 p7EWEcnEQvv6k6GKLDRSJF7Uj+CbrLQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 11b4fa91-c04c-11f0-b9e7-5f56af36decb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 11b4fa91-c04c-11f0-b9e7-5f56af36decb:5
CFBL-Address: prvs=04127d9ad8=abuse@outbound.mailhop.org; report=arf
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 11b4fa91-c04c-11f0-b9e7-5f56af36decb;
 Thu, 13 Nov 2025 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQiK/d4eR2OKP/BGJNe6aFXzoB5xSfYMqlOp9tbaIbs=; b=TwsNuLv+VTygyc0qu6CJjnH7Pr
 V/kTDvjrBt4b6dy9ooT6pIHcqoMOoSHv3OmP2ZMHbODs9xledPklPa+jy6TYp8jiIzlgr42zgZ9Wy
 KuzJKvWDVCuUmSaQqPdwnv9uzeFcrlZ1kJFNegHNatEL+NA2jbp/mrOKTMX4Sc1cq+uG1Hnc1RaaY
 5MAhu2L0e0Gv5TNUmHxd7lkiE3tkO0C4Jn1kFeldS/l/HUt8zP6KrBfpGoq2rG2ZnDQ53d7CUBmMF
 ov41yPhq8ZbusMljm67S3mLmPUjPtN1fEUCFgeg3CL4AkdjAmv5CwIu5eeI3rGTjmkPWlyziuz6cJ
 8VpaMulg==;
Received: from [134.3.93.166] (helo=debian.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1vJPGV-00000006YAi-1j1J;
 Thu, 13 Nov 2025 05:48:59 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 1/1] target/hppa: add 64 bit support to gdbstub
Date: Thu, 13 Nov 2025 05:48:57 +0100
Message-ID: <20251113044857.67290-2-svens@stackframe.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113044857.67290-1-svens@stackframe.org>
References: <20251113044857.67290-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=52.28.251.132; envelope-from=svens@stackframe.org;
 helo=outbound1.eu.mailhop.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0daa52f7af..777f4a48b9 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,16 +21,25 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
-/*
- * GDB 15 only supports PA1.0 via the remote protocol, and ignores
- * any provided xml.  Which means that any attempt to provide more
- * data results in "Remote 'g' packet reply is too long".
- */
+static int hppa_num_regs(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 96 : 128;
+}
+
+static int hppa_reg_size(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 8 : 4;
+}
 
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val;
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
 
     switch (n) {
     case 0:
@@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->cr[30];
         break;
     case 64 ... 127:
-        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
-        break;
-    default:
-        if (n < 128) {
-            val = 0;
+        if (hppa_is_pa20(env)) {
+            val = env->fr[n - 64];
         } else {
-            return 0;
+            val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
         }
         break;
+    default:
+        val = 0;
+        break;
     }
 
-    return gdb_get_reg32(mem_buf, val);
+    if (hppa_is_pa20(env)) {
+        return gdb_get_reg64(mem_buf, val);
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
 }
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val = ldl_p(mem_buf);
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
+
+    val = ldn_p(mem_buf, hppa_reg_size(env));
 
     switch (n) {
     case 0:
@@ -267,16 +287,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_hppa_loaded_fr0(env);
         break;
     case 65 ... 127:
-        {
+        if (hppa_is_pa20(env)) {
+            env->fr[n - 64] = val;
+        } else {
             uint64_t *fr = &env->fr[(n - 64) / 2];
             *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
         }
         break;
     default:
-        if (n >= 128) {
-            return 0;
-        }
         break;
     }
-    return 4;
+
+    return hppa_reg_size(env);
 }
-- 
2.51.0


