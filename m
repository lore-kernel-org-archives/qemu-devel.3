Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70113E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9d3-0007o7-96; Thu, 19 Feb 2026 14:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9c9-0003yR-Eb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:10 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9c2-0008NV-Ix
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so7834605e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528977; x=1772133777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UPVpAvrQsTFqtfqwhbhR6gBAqs95Qv+GAT25RJhMX0=;
 b=hKcflSHzukkf6iCYmdaxU5g2iCA0SAca8w5EjEPzpy8azKSPhvFUFTacuJGqQ3Un7f
 rjChQKu1sgMacImslBTnhZVdTI5vi5vF+K8oq/6CLbl+lAX4Pzv0ROhOXNmMtUy6hoMV
 MD/DtsyQLf8/h7PuHWp2AEApInujJBG+N91PEGAdUNI6UuflG4znFRRxJZn159GglaJg
 1Dq2xIF/pHHZF2feyNOZxlf45JTbwlcW0oHoIAiiAYyiuGIWIblkbgDUfsLhW3/fh9Uv
 uAH78umd50V6q2aQIo9+YQuST7j2PM/d56a3I5JBrWleKnjQCvbTAfl0G3yOB6TXiRCr
 htCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528977; x=1772133777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6UPVpAvrQsTFqtfqwhbhR6gBAqs95Qv+GAT25RJhMX0=;
 b=U0I8clpMW0hntSCRTll8oCuCKBaElRKLz+iNHI6QYDSwmLe17/sYphpre3i0YurrO+
 PZFzmX6HYdj4Q5CoxeDAX0VqeAVx1Skd9zp9YG0lLq3hclu5Lc47rtpA8MUkHkYtfVwW
 Lvk2ERskUWRi3xKum8xX5xtz56WW2hcPnF015gGGt81oYjOHiolvIOSqd2fRJ5889CzE
 wLW0h+qNsQ19iH8duk+ud2dS74DD9W24t2GDD3MPO4BfQkQlh6lj+9kH9U1yMk2aTh35
 EC0XKUrNmwsOUcIuMZa2Cx8nxwHrla/B4uI4lR5QiObTJOqbrHm47FUY5PtQ3sDX3BLY
 /tJA==
X-Gm-Message-State: AOJu0YynBAKHV3oyl5AuxqtptxNEjJ9soM5uBAv8RamD8ixq0vhypL13
 uD8X/Z6E672f/VzYPZIo6PWnH1VwidLfJZM9b1utZUuqKLwgh24C92arXFgHC/fDlwOxTJtNX7i
 IoauhkbndBA==
X-Gm-Gg: AZuq6aKz/yAD/A7e4oiNKiwQPE1a+gglgc64QSrODqblE95lNi4IGcJncX0Kwx+CHqN
 CIuGua55Hennl2/Itz9+zoEPmCpfmoYZLs/qOaxuhsriM/ljLXdWmiLc3okaKJO0ZIqGqhRx1+v
 JOzN4hdzE5w4JVNMWFaQGq8WBS2zeO/Xub+5QR5qwKxSMjMVKlMrW5lzuj7s+29XNyzFBcl093c
 BQ8zz8StvuQGs+gPpeBX3YB8EQ05raSOWP+pQ3lfbYq1KubgAkLokUHGDcFCjylInrKHC26mWxt
 lMtiZhnjOz2KkgM/Sfh5gPS/FFRZH0rEkcjdkyfRtevy0RG+PpObZYmZ9OUS06qrx0QC5NszyMW
 yGzPuVOOWVbOf1OyzrA02n3x4P1dRK9m6+m21q/0xDGHnsG4IFteGZDYT5xOYS7Nr3J7ZeoWiML
 7RjHZCuQXyeyk1goCgcTz2Xt89Q9IqhnwcP7wiGh8sWtcpim/dgkMafqi8ImRz2d8pgMftGa1j
X-Received: by 2002:a05:600c:6091:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-4839e661d1bmr69464275e9.18.1771528976854; 
 Thu, 19 Feb 2026 11:22:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm46266122f8f.33.2026.02.19.11.22.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 25/50] target/ppc: Replace ldtul_p() -> ldn_p()
Date: Thu, 19 Feb 2026 20:19:27 +0100
Message-ID: <20260219191955.83815-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/gdbstub.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ece1e5c9bd7..e0aae9c9eaf 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -23,12 +23,12 @@
 #include "gdbstub/helpers.h"
 #include "internal.h"
 
-static int ppc_gdb_register_len(int n)
+static unsigned ppc_gdb_register_len(int n)
 {
     switch (n) {
     case 0 ... 31:
         /* gprs */
-        return sizeof(target_ulong);
+        return target_long_bits() / 8;
     case 66:
         /* cr */
     case 69:
@@ -42,7 +42,7 @@ static int ppc_gdb_register_len(int n)
         /* lr */
     case 68:
         /* ctr */
-        return sizeof(target_ulong);
+        return target_long_bits() / 8;
     default:
         return 0;
     }
@@ -85,7 +85,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
     uint8_t *mem_buf;
-    int r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(n);
 
     if (!r) {
         return r;
@@ -127,7 +127,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    int r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(n);
 
     if (!r) {
         return r;
@@ -135,17 +135,17 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     ppc_maybe_bswap_register(env, mem_buf, r);
     if (n < 32) {
         /* gprs */
-        env->gpr[n] = ldtul_p(mem_buf);
+        env->gpr[n] = ldn_p(mem_buf, r);
     } else if (n < 64) {
         /* fprs */
         *cpu_fpr_ptr(env, n - 32) = ldq_p(mem_buf);
     } else {
         switch (n) {
         case 64:
-            env->nip = ldtul_p(mem_buf);
+            env->nip = ldn_p(mem_buf, r);
             break;
         case 65:
-            ppc_store_msr(env, ldtul_p(mem_buf));
+            ppc_store_msr(env, ldn_p(mem_buf, r));
             break;
         case 66:
             {
@@ -154,17 +154,17 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
                 break;
             }
         case 67:
-            env->lr = ldtul_p(mem_buf);
+            env->lr = ldn_p(mem_buf, r);
             break;
         case 68:
-            env->ctr = ldtul_p(mem_buf);
+            env->ctr = ldn_p(mem_buf, r);
             break;
         case 69:
             cpu_write_xer(env, ldl_p(mem_buf));
             break;
         case 70:
             /* fpscr */
-            ppc_store_fpscr(env, ldtul_p(mem_buf));
+            ppc_store_fpscr(env, ldn_p(mem_buf, r));
             break;
         }
     }
-- 
2.52.0


