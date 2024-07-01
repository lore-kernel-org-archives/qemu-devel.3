Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC089C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78V-0002xn-1R; Sun, 30 Jun 2024 22:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78T-0002tw-An
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78R-0008Vn-EK
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7066f68e22cso1474730b3a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802278; x=1720407078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPMDVI+D07uyiyyk8Iq5xR3y1Ye6RQN5Bs9ydJnDyA0=;
 b=Az0Twaeh5w2XSbykktmKCOSS43tx9AFv10//13yy3pktqNsOUwUDGE/4iygAuK5+gu
 CDroVflXbZzxsni9I//OoEJANSS9ndItebNECqLM+OcSzCrk1E4NQRUznwwPeR0ZNld4
 0Lt6Sei0iyNy7hcwEr2Ia6/HF4C5RKitxsihM6DI/N6GfJJZGIW/KLBlNybGA6iKvPEI
 +siVbGDdDS9Yx+1BQL/O5oQYMOY2/ossUoF4p0Kp0ZgV73cy7vewwE/wJTPA0VPuFa2M
 ugsnKH+cZbrxJxVe08YN23AdUpKB/ygt4HHG3zISJaayJdJ6HVDpOYS5fW7LEumCloHb
 EOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802278; x=1720407078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPMDVI+D07uyiyyk8Iq5xR3y1Ye6RQN5Bs9ydJnDyA0=;
 b=V9mIqYOJGzG/Fc6LLkOGqCwHjiTct1JbFbMOLQH4D3JKFY+EAD4oJQD3lmmqr6Aktp
 LPquhBNKmOhD9I+Bf9ogOeMgZNB71qkaXs0RHWrY8XGJFrvsuQE2QkKVs61CTVjEZSvm
 HNROP4uSCYABuKb9VTGI75u4Ykq6fVpXjtfwClmJeVZixuI78BN2hMEZQOPQXgiiJsQo
 08H0Se5IlANvZ3PkpRz68PHVc0Dl7NvLMO8/r5fxAEo/wUX61zF0bFZ6CIE2MuGQJclq
 qa5eMO03/GRnhk5GRT0j3kEMOt6PSqCYjvk8117k3k+GJ4Nc5D6qbf2kSkWqekO7zY1I
 tr2Q==
X-Gm-Message-State: AOJu0YxA4inUURr14lorGRrrXIUKPbS8HvCrBtmTEurKtbFG8IrKsrA2
 xgpVkqK4yjJBKdwTPebO8U3DTjiSs6kzD3OI+fi85Bi1VDZDjYZDhSeG8Qrkgs78AxZv7qfJdMh
 F
X-Google-Smtp-Source: AGHT+IFBMU+AcKDU/8esAshINhmce7uSp6vOsLD8OT/pjWRYbcsND7ZA/6+ii/ac2/Ii68phtKJctw==
X-Received: by 2002:a05:6a20:7fa9:b0:1bd:253e:28e with SMTP id
 adf61e73a8af0-1bef61398b1mr3590112637.16.1719802277424; 
 Sun, 30 Jun 2024 19:51:17 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 1/5] target/i386: Tidy cc_op_str usage
Date: Sun, 30 Jun 2024 19:51:11 -0700
Message-Id: <20240701025115.1265117-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Make const.  Use the read-only strings directly; do not copy
them into an on-stack buffer with snprintf.  Allow for holes
in the cc_op_str array, now present with CC_OP_POPCNT.

Fixes: 460231ad369 ("target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu-dump.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 3bb8e44091..dc6723aede 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -27,7 +27,7 @@
 /***********************************************************/
 /* x86 debug */
 
-static const char *cc_op_str[CC_OP_NB] = {
+static const char * const cc_op_str[] = {
     [CC_OP_DYNAMIC] = "DYNAMIC",
 
     [CC_OP_EFLAGS] = "EFLAGS",
@@ -347,7 +347,6 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int eflags, i, nb;
-    char cc_op_name[32];
     static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
 
     eflags = cpu_compute_eflags(env);
@@ -456,10 +455,16 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      env->dr[6], env->dr[7]);
     }
     if (flags & CPU_DUMP_CCOP) {
-        if ((unsigned)env->cc_op < CC_OP_NB)
-            snprintf(cc_op_name, sizeof(cc_op_name), "%s", cc_op_str[env->cc_op]);
-        else
-            snprintf(cc_op_name, sizeof(cc_op_name), "[%d]", env->cc_op);
+        const char *cc_op_name = NULL;
+        char cc_op_buf[32];
+
+        if ((unsigned)env->cc_op < ARRAY_SIZE(cc_op_str)) {
+            cc_op_name = cc_op_str[env->cc_op];
+        }
+        if (cc_op_name == NULL) {
+            snprintf(cc_op_buf, sizeof(cc_op_buf), "[%d]", env->cc_op);
+            cc_op_name = cc_op_buf;
+        }
 #ifdef TARGET_X86_64
         if (env->hflags & HF_CS64_MASK) {
             qemu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%s\n",
-- 
2.34.1


