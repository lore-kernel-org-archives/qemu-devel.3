Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D3CC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHH-0005Ju-Co; Fri, 10 Jul 2026 16:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFa-0002Nd-Jb
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFK-00010X-L3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1514299b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716881; x=1784321681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lp+19HN1hDJRD/nyQTZDKaLa3PwvYZGSdAI5w9aXD2A=;
 b=NRm5vutXosn0qEulf6s2AP8yiv/XvKe89Rh0B2V3gMDw+vAV+qEpzwZqB8udydLASm
 KRITViG9NOfHn6IdT1eUbWd6BVzrupMPzQIgLqeT5VhSjCdsHOKxke/5F1AM55d9mecv
 HfjyOrU5Io242Kf2uxaTkJm1/jiOIfgnSQ1HR1Lig/dzTkEM7053Royqa51opk0AmSDA
 OevP2h+hDK3W4Jn2F5KiGhBeVrjaiCo/alaVALMMCyaA2JeSYOBloGNSNqYjAlzTXpkW
 4LU7wg+uWtpFECG/IpSrfDH/KdZz/2EV8m/IDGRLRkGwsu3eRwcB5/RfCYmAVwuYHcdP
 I9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716881; x=1784321681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lp+19HN1hDJRD/nyQTZDKaLa3PwvYZGSdAI5w9aXD2A=;
 b=llXtZbM7r1dL1QZrywlqDVHKqf/EtaUNJmqd8eehQeekLuULa22HrYKjFDjGL2Guet
 +3/HN9/5StLZmP37n1WOEoF4tPMBqWJeqmpvd7c9/1P1NuZsK6LEt4lPSmo+UtUuW/fV
 S0ZgmzZo1Bu27Ds66Or3IA7UhBcnkmuY0dseoLlpGgTaJUxnS6r9gdtgJ4TPJ8ruVhVv
 SXl4ySW2IjMygC5MLhl6XN1+uyAyRecG2IQsw0PHzx2n0BHBJQRn4SWeWCz922KLP/o/
 FFlfVJBcbhzsO/Qy0qkK9/gsLZ4ZB/BhWK2fjCZooOpnBO2Mwlo8UGS3nkOKGuzusHJZ
 pP3Q==
X-Gm-Message-State: AOJu0YykmyG+cz6zKg6fgKiWnrMjxcLiTcXvQB2gsZf/I+7xr3yPD8+O
 3ABBaYVMb/vJIovthiN52J4/3VulXaMBavzBOXwPwFUTeQssZP0Ys9GL/0wLsctBj9tiJ9I8WrM
 pKYw2
X-Gm-Gg: AfdE7ck3PbpLClN2/U47sz74tNzq3orIW2ZN7hXnXQmpLMe1jkW5ZMzhghiCKVSIxtQ
 qZuGCSi+eBi0bIuE8Hna1bo+T1MtlCLvzzwU5flLjCjbd0dMtGJNjTpiwyxTeLKiNhL5IL90uO8
 G0hD2olK9TFPZVHWMtPDlRHjqeqJN8pXNzeP8I/sskxHsqcwiNuzWWR6d2biCMJSRVomXZT2mQy
 Vg3zowBynRSrUc6SIfUueeNk2bbNu29l/kYIIB90T78vjgEBk3IMd2N94XzNLu61q/rCWCEEvkV
 cFs19gHZu5cPD5nn5wF6BbjYKnXmztgNwrbT1+nEnPkeNhwmYmZSGFxQlu+lLaBHv+EvL2UgVEU
 8xFGWmXkWyh6V1fYS8/cVEy4s97e+yePKxaZ96r1O2MZWBdPO/iLqmYcS7Mm/im3W5th1nVVXMc
 rQHGfgiy6jHTlzISvZAQ==
X-Received: by 2002:a05:6a00:1256:b0:847:904c:8452 with SMTP id
 d2e1a72fcca58-8488986fb9emr455784b3a.38.1783716881331; 
 Fri, 10 Jul 2026 13:54:41 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 36/51] target/riscv: Set badaddr in
 riscv_cpu_debug_excp_handler
Date: Fri, 10 Jul 2026 13:53:46 -0700
Message-ID: <20260710205401.836304-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Setting badaddr in riscv_cpu_debug_check_breakpoint was a minor
buglet as that function should only be testing if the breakpoint
should trigger.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 4 ----
 target/riscv/debug.c      | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c318dcd633..f9556c04a5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2373,10 +2373,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             break;
         case RISCV_EXCP_BREAKPOINT:
             tval = env->badaddr;
-            if (cs->watchpoint_hit) {
-                tval = cs->watchpoint_hit->hitaddr;
-                cs->watchpoint_hit = NULL;
-            }
             break;
         case RISCV_EXCP_SW_CHECK:
             tval = env->sw_check_code;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 994a77fd31..f4689519d8 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -919,6 +919,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    env->badaddr = hit->hitaddr;
     do_trigger_action(env, DBG_ACTION_BP);
 }
 
@@ -929,12 +930,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     int i = bp->id;
     trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    if (trigger_common_match(env, trigger_type, i)) {
-        env->badaddr = env->tdata2[i];
-        return true;
-    }
-
-    return false;
+    return trigger_common_match(env, trigger_type, i);
 }
 
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
-- 
2.43.0


