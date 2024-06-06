Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21762C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3pQ-0003iN-JJ; Wed, 05 Jun 2024 23:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3os-0003XB-0E
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003mZ-UP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c24115469bso1202063a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644573; x=1718249373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ta0pM6KcQt7rsvA3Ju6z7MgKxBm5RGfKrSL9DmIR7Q=;
 b=yF5Jty6EHL2gesYbeckoTJGLhrPxUYGX4SPSngMw/Wwr3/ZkdHaVVNZPWFgcHUd6Wv
 EHKV+tCYQ8WRxMALtCYXqCCcED23CwsAz6lYSoXpcZBjimwQV9mUMJa3NQ/CdHneM0Ru
 lUuNSRUWjwAXI664meIHepiEEcf4t4cC6+daHkBi0yWolnqDto6JotRCtY1LPA5BdmPq
 YZ6GBiJrF5gVlWz2ZBTZds7QEKjwFbWZuq6Pnp2+FK/3JHb4jckf41ByzoOmSjSYJlY9
 VnF6yvwd4HadOvHyeqJ/grIXYnJn2oB0xt6mnomL3NVYYVKniUZjaFhxNAeDO8M1RiyH
 CLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644573; x=1718249373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ta0pM6KcQt7rsvA3Ju6z7MgKxBm5RGfKrSL9DmIR7Q=;
 b=PoEJFrtzOEQ6XJTSNi0maP8FDKzojVZcVzimE2WaemDOZtAbGrr+uxJPFNk3oFQNrt
 Pv4ub2U+4lx77NFDZXUlwvV0vyJ4jjHwyhoCNpjiIAMycnAGKZal6YLx/GQZDhiljyrI
 J6l1tiw+JGS7Z85f6pu4utfHmkAGjVNvHG4AeL/XBg84xXFQRk+xAVzm+r+6c4JiU18H
 O7jIz2Nu6av8wxZubZZ3+xB+jMuhwJFxfOM8ZA2YslxagH8/J3/7isfgqpb3ZsU85Nj3
 wwiY6LqDjaWbrws1TgcMY/jddANC36SpSr+NvGnrxNab1VxZcSvh5Zsk/0CJ26gkjOgt
 eKRw==
X-Gm-Message-State: AOJu0Yxjjh2R2aYVyrxMdi0NtrSQz8CESar5QsCy/0IG9JTljvg/vIX/
 4VfRMFfE/5Odldop1s6tHPges87S18Knr7WBs/C+ORwtkfBqO8+EcLS2ywhhsldcMsuQ+ygPITk
 K
X-Google-Smtp-Source: AGHT+IEWvSQsT24ICh++D3LKliJRwg/QrL32ICiA72WqTPwr/Ewe709Ti3q4g0YAxBBOLljPKegXHQ==
X-Received: by 2002:a17:90a:b014:b0:2bf:9eb3:cea7 with SMTP id
 98e67ed59e1d1-2c299a04728mr1839256a91.24.1717644573154; 
 Wed, 05 Jun 2024 20:29:33 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 6/9] target/i386: Introduce cpu_compute_eflags_ccop
Date: Wed,  5 Jun 2024 20:29:23 -0700
Message-Id: <20240606032926.83599-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a generalization of cpu_compute_eflags, with a dynamic
value of cc_op, and is thus tcg specific.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h           |  2 ++
 target/i386/tcg/cc_helper.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c64ef0c1a2..48ad6f495b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2431,6 +2431,8 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
 
 uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
+uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op);
+
 static inline uint32_t cpu_compute_eflags(CPUX86State *env)
 {
     uint32_t eflags = env->eflags;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f76e9cb8cf..8203682ca8 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -225,6 +225,16 @@ uint32_t cpu_cc_compute_all(CPUX86State *env)
     return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, CC_OP);
 }
 
+uint32_t cpu_compute_eflags_ccop(CPUX86State *env, CCOp op)
+{
+    uint32_t eflags;
+
+    eflags = helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, op);
+    eflags |= env->df & DF_MASK;
+    eflags |= env->eflags & ~(VM_MASK | RF_MASK);
+    return eflags;
+}
+
 target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
                                  target_ulong src2, int op)
 {
-- 
2.34.1


