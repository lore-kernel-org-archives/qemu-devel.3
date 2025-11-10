Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BCCD1297
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 22:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIaLr-0004MI-VY; Mon, 10 Nov 2025 17:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vIaLo-00045M-8A
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:27:04 -0500
Received: from outbound1g.eu.mailhop.org ([52.28.6.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vIaLm-00009M-28
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=rErt73Sdbfn/qFee9Hf6kn2FwJUiCF0/ipcG6hLHciY=;
 b=PShQ9qJWRTya0L0EmBJXW1mVJJJhU/h9/ndStJD7rG9KOk5uv9m2W3l4BVWKCw1oPLZ61ltutJLVv
 TXDhRziVv/HqQ2FFqiHA2p1GnXgZLwRhMcY8BCkO7o5TrUwhNupU1HkJsh548NXF9ai+FtNSeAOKsU
 FEj1Qm69IdCNg5mg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=rErt73Sdbfn/qFee9Hf6kn2FwJUiCF0/ipcG6hLHciY=;
 b=Oyzjb/iyHMN2VDSTskzmEyzCL3/AMM1mPmNomwZ2wX4yf+t75JivcecfNCdXnpLtrSpQ7Tqkq2E2O
 KPNad+JM6tViNVBTFGRSQD9rz734NC24/V5oqDywOZHG0O28DB7g7FoBA5Q52ny3hUH5Db7qM+gE/y
 qYYmdh86+IX8XBSOpthJWxz24rfsEL21IQdbGXeAb0rX2C42o/pVcWt1q2IFqOgE6AgetUM2QCSBiT
 wCX9rs4KaR4vMA6Vl9cceuqly3B5DVrqOIOnmexyZh+9gQVd5xloaJsamScfMuAdBycJqystHZgjoe
 ksZF09De3tA99E0xMYEjZmkzdpORaLQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 5c02824e-be84-11f0-b95e-5f56af36decb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 5c02824e-be84-11f0-b95e-5f56af36decb:5
CFBL-Address: prvs=040923d279=abuse@outbound.mailhop.org; report=arf
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 5c02824e-be84-11f0-b95e-5f56af36decb;
 Mon, 10 Nov 2025 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rErt73Sdbfn/qFee9Hf6kn2FwJUiCF0/ipcG6hLHciY=; b=OPoph+FZhy26sozUSyFBbZ+Vt4
 IQmGDyLvtv7A3QdACmI5Gw5MVqmpVlJCZiFpPI4I0ChDKSNjhj/gxlmokqiq/BsdD69vQO8rIIgrx
 OzCaDyzoqP2C9RIbUl4sGQuQ/QhTUlXdJfwpyRO6W67aKUUsNxcXNudkfxOH7eqvNBG08gRP+RYfX
 Mz3iDS4M/nF/Wniphx0Pon0/vZTtdkcqZ1WfZZSSP2lOOSTmcxTUwtMXBNdY0J6SdqqeRmp4gSGUd
 8u8G7EZhWxUNHm6D84DvZkEttEvcCayorkg/l2fSeGX5maLMCP2CVTRRIXGUT1TQWD6pkgvzOAZ4X
 w3a3I9Gw==;
Received: from [134.3.93.166] (helo=debian.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1vIaLd-00000005qEU-2NSJ;
 Mon, 10 Nov 2025 23:26:53 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/1] target/hppa: add 64 bit support to gdbstub
Date: Mon, 10 Nov 2025 23:26:45 +0100
Message-ID: <20251110222646.180265-2-svens@stackframe.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110222646.180265-1-svens@stackframe.org>
References: <20251110222646.180265-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=52.28.6.212; envelope-from=svens@stackframe.org;
 helo=outbound1g.eu.mailhop.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0daa52f7af..d4fcbc535b 100644
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
@@ -133,24 +142,39 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
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
+    if (hppa_is_pa20(env)) {
+        val = ldq_p(mem_buf);
+    } else {
+        val = ldl_p(mem_buf);
+    }
 
     switch (n) {
     case 0:
@@ -267,16 +291,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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


