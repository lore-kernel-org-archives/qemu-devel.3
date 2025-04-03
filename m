Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF25C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0SgM-0008IR-Pm; Thu, 03 Apr 2025 18:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgK-0008I3-Pv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgI-0003mJ-PX
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso13569475e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717901; x=1744322701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L93zIKGNWPzjVCaNqO2VF85pjiuQ80Aoywgp0S0CVlQ=;
 b=AVwRHH9UvxpfJQATya4kp29VN/BKronQ+5jQs2KCmqxKxU2qUr9R+Ez5t5YvtUNWvi
 b3kMN8oR1lC59QM53O/PRUWbVuk4Wt1+9gAzeLilCFpdDPz1su5iK5WIcpGfMnl86DOh
 dq0kGmeTnN4LnI/IlHodX9HZ4F/HbJtTOMcbGNKVx/lZMfiN5NBti/zMzGcx9zy+MF1t
 Wx6f3aDI+Q9eOFk59Wp6w/JQjyfHzXK7dqRN9RSW8B7REWISL/OVX0PmC9geA+8gaTvR
 iH17Y2+BtwCA9YY2xpK+duroJAYXhHnPHQ/YBq8orCli7TqJkkgn4lqhpxC2ScvQmSM4
 AEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717901; x=1744322701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L93zIKGNWPzjVCaNqO2VF85pjiuQ80Aoywgp0S0CVlQ=;
 b=jME3xaQ1qIQgVM4YVyG2CZv1Zej56/cjYxQ5uhZMC07OFofBHMEbbcqJq1JggDIFLS
 0Ykag5mhZVk77NLYDbkECj8Z7SAo9THBy8FdYF4uanSSEZ3osgHNv2scfrb/p7JhaSp1
 iEtqc+q8QUhFovvqp5Gv/eqsdSkKkKyUwgp9FIB6wgNiXBw6qVgHQLYUVJx2J81ADDN9
 d7/jrlH9yh/aythG8xZastN0pPH77SUyDxD/yhjy+MDySdueL0eDIu9tYYyE17iNvqAV
 FWbEtndZoSO4d9c+UhoYteMt/1hYKy+7NZRMHhxo7QoY2gqgFb+pOG9esbuiybnNIcV1
 zqjA==
X-Gm-Message-State: AOJu0Yy80JEMsOuynBm+VO4Gh7zvHCPv40R/ewEpFhT0ck55CmTCJaKc
 vpffwbBNhZRnQ8IDx4lTTN6Y2EL0Lgm4g5cV/lKSFQ1lgPajzW/az6mjP4TJMoV3YWmjEeQgbFB
 o
X-Gm-Gg: ASbGncuUGpkArWj8QSqFwQz6D9WIXMfI1KSfTZ/KwuCQy6WJFxTbHSjrqR3+89JA2gb
 iJ1xI6N6lp9u2Tog9WmrchYDA5vTXej7Wv65p5FsrrF+mmg/fTZGwAPIxl/uekEg3VDMj+f2WtU
 kRZi4fzmGCIJwdj4tXgio+W8DP5Bg3jHRdK39kYgd5G2NoYDXRlfHzKqMUsew5JYWzYl7BmZH/5
 HE9F8cTJJDrbl1d0Pe7EogQjpq7UhtfBXr8wDC/xf5+Uixj7PC5VDL49JnR8Hznb3QTVUt6TdMv
 n6MkEFa4cZG4mkHYwQkox+hUVPd2Yn3F+8s6udYnSkl+Gm9Eau+htE9soVL2KbZEOon18deJERM
 gAEDFnuDVplVdGvxkFoRj0Fi6
X-Google-Smtp-Source: AGHT+IGDYrLMJL0j3pOiwsLEfcwN/Y2NWF74o295XSODIcP3HOROla0Nzmbz8Dl8dypVjMnTSY/DWQ==
X-Received: by 2002:a05:600c:3b14:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43ed0bf6aeemr3106965e9.11.1743717900923; 
 Thu, 03 Apr 2025 15:05:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0d06sm32770185e9.35.2025.04.03.15.05.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 08/19] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Fri,  4 Apr 2025 00:04:08 +0200
Message-ID: <20250403220420.78937-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
frontends, otherwise we use a default value of TCG_MO_ALL.

In order to simplify, require the definition for all targets,
defining it for hexagon, m68k, rx, sh4 and tricore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/hexagon/cpu-param.h | 3 +++
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e743..7cc63a01d4b 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,4 +25,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b2..10a8d74bfa9 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,4 +19,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bcaf..fe39a77ca38 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,4 +26,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee86..acdf2397495 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,4 +18,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c419..45fde756b6a 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,4 +14,7 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5590eb6955..7467255f6e4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,11 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-#ifdef TCG_GUEST_DEFAULT_MO
     tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
-#else
-    tcg_ctx->guest_mo = TCG_MO_ALL;
-#endif
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


