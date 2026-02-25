Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202DEFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO94-00048y-JM; Wed, 25 Feb 2026 18:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8t-0003nO-B3
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8r-0003Af-Mc
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48370174e18so1470365e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061484; x=1772666284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+6sM91w2bCKDd02R0x9+LUldc1Xf848frIT1oZOkaR4=;
 b=a1sL+wP4VrRcg+onIzrJzYOBi0WfvpLFhD2B/YB9Ax5pqs51ROmgc2uL0DV8FTFf0r
 VrYn/grIXEJ/6TnON0DYleg88OLPqLFKaXiljUBu006T3tnJivP3rNR8iMDQiuPpBzLl
 VtVKcMIDgJtRQsS6AX2kzNVTEQ1kGed5ve5f5yAbkmlGI/sk/3+paVzwQH+lzBEmFGRt
 xct3eypg4HhpiFugowy6yJBE8Uw3JvP/ql05YMGrYFll+6xgD73ye+Ai9PPGHXkDW4as
 /RADPnX13Z6XjLNGWQdruD6YT8HDwOjduTyrrtvrwDaDM+ropoMG2OPT+31MZ6VaO9Sw
 DP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061484; x=1772666284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+6sM91w2bCKDd02R0x9+LUldc1Xf848frIT1oZOkaR4=;
 b=q45mdGCmRrjgNPZCVfEnAtGB5PAmAkRc9849tXq3I68VHbej39nStbYV8JNZSxZ3XO
 LFN6Vj9eTkbDspEzNDMXOqQI1Q3515qUVbbUtqC7Cqdx0NZEA/cU626Rw0D4/Vwn9kaE
 sfIxdyWhNwEWDw643uHLMRWqvuQn1Fmo+375kY5j4DERboxk4KzvdP0kWHtLXx4Orldg
 wrgIfr5NpDEgo3sPwUNwraSi0SI/yRMIvA648emxhwsgqKYh4BfmmhQiaMyDL5CH54x5
 C1+tBFoZ9epruuQJApS/bvpIPOsY6Tp1Ai5qPWj9HSIDQ0xmXieBNzWWWOzuUftjOKvL
 qE0A==
X-Gm-Message-State: AOJu0YzFv8/MIPaELfgqxrfFO4P47m505rrUyb1Db88PQpwmjVNTv6d3
 k4XTFd1+QqqT8CXh1xY2ArkaQ0/CiPQDcf+9lX6ISPSnVVdKVPSkC+ZbsXpZN+COVeBfbFcA/Ud
 FMDskCso=
X-Gm-Gg: ATEYQzy0JzUHcl/IUICAChp5BYFDDFApGPZeccTglyTcyk20OYDjkFtrVMbp0e/eQXV
 qWX9kPBKZptuHPo0sjW4nJ9+UwUy4Ry+p40Rsyx6Vwku0Tv4KN7UWtsPMDbmUTeLg4uTVj2c2PQ
 bYekon1ouLtGfKUgsFD6f92vzeIbGBGvd4eDdL8rDCi8Q43H1mXB+CS8/Hzip95pT0ixKxpIbxZ
 agq6H5hglb75v+iOXHmKTa9v6GPOHwDwagUVzxgP2ZkKP5JEdjRHct7olu1qYLlfYz17PGGtHtz
 6JAvapKdw5ofRoySoRLQO0tnmtp8fTGZds+orYvs+JIRCjxpH/m/TvYvQ+q7WdoYkYck1BHVkdo
 qwqPVlLqsS4RlkIp3t04eW3g6a8EL0BSF4cMVnzok/SQeFsbTs97Fd26ImjaGiJMhzAHp4Qt37H
 1NECfyrBZfu9fJBDHZncJgTNP8awe0qU+cGRMPK9QJXDnuXeIn2jhor2IDIe50aXE929Q8JmNr3
 9WM3kefozU=
X-Received: by 2002:a05:600c:6098:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-483c21b31b0mr35153755e9.33.1772061483833; 
 Wed, 25 Feb 2026 15:18:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccd7b6sm20812405e9.24.2026.02.25.15.18.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/70] target/mips: Replace ldtul_p() -> ldn_p()
Date: Thu, 26 Feb 2026 00:13:34 +0100
Message-ID: <20260225231411.96482-35-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Use deposit64() in gdb_write_register(), allowing to remove
'target_ulong' type uses.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-27-philmd@linaro.org>
---
 target/mips/gdbstub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 169d47416a6..8e0b08a096c 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "cpu.h"
 #include "internal.h"
 #include "gdbstub/helpers.h"
@@ -77,14 +78,15 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    const unsigned regsz = target_long_bits() / 8;
     CPUMIPSState *env = cpu_env(cs);
-    target_ulong tmp;
+    uint64_t tmp;
 
-    tmp = ldtul_p(mem_buf);
+    tmp = ldn_p(mem_buf, regsz);
 
     if (n < 32) {
         env->active_tc.gpr[n] = tmp;
-        return sizeof(target_ulong);
+        return regsz;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -104,7 +106,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             }
             break;
         }
-        return sizeof(target_ulong);
+        return regsz;
     }
     switch (n) {
     case 32:
@@ -127,7 +129,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #endif
         break;
     case 37:
-        env->active_tc.PC = tmp & ~(target_ulong)1;
+        env->active_tc.PC = deposit64(tmp, 63, 1, 0);
         if (tmp & 1) {
             env->hflags |= MIPS_HFLAG_M16;
         } else {
@@ -144,5 +146,5 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     }
 
-    return sizeof(target_ulong);
+    return regsz;
 }
-- 
2.52.0


