Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F66C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFj-00040v-P8; Wed, 15 May 2024 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFe-0003y5-1n
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFa-0003FH-VN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42011507a54so25965105e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785741; x=1716390541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah4RAfb74Ry/QSCvgzicI92Xf6jvMyFD3fqYCPKUsdU=;
 b=iQBgzp6kEUFiPWy4dO+UHQO87wVow4hKxUgE2M4S5hsdDIlooCrMrXXQucixbuT7P+
 2dFBrm3WfpiILmNCxbokAfZXINkl65x7g6vjE/d/GlQeVNFGZ/o7tpA/WuxWBWvCRWj7
 Ss2KqJQ+p4QaxC4gsBUYt/A+/qbu+VbM0mOShLCsnMfBolVk/VNScP6E2c8PxEUJSbF9
 clMP270ULe1rAtFlUi9NI8oT/LwS9RPLVw1NNckJlICr8QMApwhbuXNAWZSuLuDySnFA
 /SVRoS9U+ehqme/QgHwDhIL1Zw8jvrtugZ5OtHiQAn4AiBUEo/2fT0fxIGSZcjj6y0qM
 OVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785741; x=1716390541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah4RAfb74Ry/QSCvgzicI92Xf6jvMyFD3fqYCPKUsdU=;
 b=gEC5QfHFGEF/yRGL9E3SVChChWrsi5rpZW81ApxQjYHI49103gXjvOC43xVqGQMtBY
 8sALIR0Fb8+IfuMITAhacQqz2LDeC1ZFlwbU9+22FjZN8FFVie/UaY0E7l5nW/FO0rfu
 UWn06TAjZgRKkZaRaSi6SadTi1zMOq9xzg3y3+6ESEd6WrjnH7Oopwk0vvwy9jrt7wdJ
 99/XDUzwucLsKBDUraKsa1JD6hMASS/ANFyhSpEReeN/HXUmufncdo5t8CfY2xyfde6i
 infLj0yjhKfp/2FazbBm6NE/v85WsrEnYpj5APWx6h55MpgZvbRF2ojws0CoiNXXXi+s
 SLBA==
X-Gm-Message-State: AOJu0YwOzbm3m3OC2LM5Nat5sK+qGXS8EA1w3M2eTu8wyX/WuBTaY/yh
 Qd22lCb5CTmMLAAI6Zytfzl+1zTqu2MqzD9pYzfbC71X1u+DrZfSiUZb9SMUgzqexWfH0yeItgI
 GlBk=
X-Google-Smtp-Source: AGHT+IGXFBaGqvIa7SszHxBEK542ENA2BO5TDJT9cPZ66EK5ty31740R+ui9kJkm8qp1vmomkQK1aA==
X-Received: by 2002:a05:600c:4754:b0:41f:ae5a:c72f with SMTP id
 5b1f17b1804b1-41fbc91f419mr185164525e9.1.1715785740796; 
 Wed, 15 May 2024 08:09:00 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 27/28] target/i386: Pass host pointer and size to
 cpu_x86_{fxsave, fxrstor}
Date: Wed, 15 May 2024 17:08:36 +0200
Message-Id: <20240515150837.259747-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            |  4 ++--
 linux-user/i386/signal.c     | 13 +++++--------
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2897faccb9..dbd91c064d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2243,8 +2243,8 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
 void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
 void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
-void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
-void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
+void cpu_x86_fxsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_fxrstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
 void cpu_x86_xrstor(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
 
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 816e8ab2a9..1f5a3e9a0b 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -294,14 +294,11 @@ static abi_ptr get_sigframe(struct target_sigaction *ka, CPUX86State *env,
  * Set up a signal frame.
  */
 
-static void fxsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxstate,
-                              abi_ptr fxstate_addr)
+static void fxsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxstate)
 {
     struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
 
-    /* fxstate_addr must be 16 byte aligned for fxsave */
-    assert(!(fxstate_addr & 0xf));
-    cpu_x86_fxsave(env, fxstate_addr);
+    cpu_x86_fxsave(env, fxstate, sizeof(*fxstate));
     __put_user(0, &sw->magic1);
 }
 
@@ -412,7 +409,7 @@ static void setup_sigcontext(CPUX86State *env,
         xsave_sigcontext(env, fxstate, fpstate_addr, fxstate_addr, fpend_addr);
         break;
     case FPSTATE_FXSAVE:
-        fxsave_sigcontext(env, fxstate, fxstate_addr);
+        fxsave_sigcontext(env, fxstate);
         break;
     default:
         break;
@@ -669,7 +666,7 @@ static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         break;
     }
 
-    cpu_x86_fxrstor(env, fxstate_addr);
+    cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
     return true;
 }
 
@@ -687,7 +684,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
         }
         break;
     case FPSTATE_FXSAVE:
-        cpu_x86_fxrstor(env, fxstate_addr);
+        cpu_x86_fxrstor(env, fxstate, sizeof(*fxstate));
         break;
     case FPSTATE_FSAVE:
         break;
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 05db16a152..0e5368951f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3041,22 +3041,28 @@ void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
     do_frstor(&ac, 0, true);
 }
 
-void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
+void cpu_x86_fxsave(CPUX86State *env, void *host, size_t len)
 {
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = sizeof(X86LegacyXSaveArea),
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_STORE, 0);
-    do_fxsave(&ac, ptr);
+    assert(ac.size <= len);
+    do_fxsave(&ac, 0);
 }
 
-void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
+void cpu_x86_fxrstor(CPUX86State *env, void *host, size_t len)
 {
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = sizeof(X86LegacyXSaveArea),
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_LOAD, 0);
-    do_fxrstor(&ac, ptr);
+    assert(ac.size <= len);
+    do_fxrstor(&ac, 0);
 }
 
 void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
-- 
2.34.1


