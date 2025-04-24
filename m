Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA13C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kua-0007ei-Fi; Wed, 23 Apr 2025 20:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktL-0005Zj-PA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:39 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktI-00053r-Tm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso512401b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456195; x=1746060995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNFmdxDxWM3CJyEBqzg4trONxoTdvHt+45glS8i3gj0=;
 b=diHCX95sE8T1ce9NAW8FSJOUzskMja6JVrbwgwgtnFhYxc+uvzkTQra2N4YowSrteh
 Jk04MY0YuEAUH86GVZZK8w8RQx7Q/vOUQ0MfAG9mMwT81dXyycngS/A3ZPmx4T9P65RJ
 2/rrHM+B0tseRI4HA2gD23gciniDlt+MWZEBs4cWLIEh8+xvn25GsqHQQsR/7XHXUsRC
 /FM3xZl5TIIpxby3pL42HgGApkUdXE3yekLw8tlpsPSXJPzPR7jz4kUhH/AWxIAtyzfV
 XWCL4tbN67hTFORhsIBFSXY8f+L9c+va7d0vUXG8p9dBu3pB9l+POpm+HZUzUFul3q8E
 XO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456195; x=1746060995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNFmdxDxWM3CJyEBqzg4trONxoTdvHt+45glS8i3gj0=;
 b=JlnI6YIp916H/24nWSbvxndII9G5Tr+J9ziDGhF91LCcdc3ADQEKsjZDkdDBujzwQk
 irZ3k1Ia5nIzUFpl1m79gIoqNdtJUSiaL+bzqFmXTc7bBxUj3tD0xvyWfJZIjrsMXPOI
 Tcw4kXbVG0adhf1FDRRH7EogbHmwduehybFh0F+sKWCLOMBsBHmLhn9QwT6ieV5oJaZg
 I5NHTHc+Izto/xl/BiMT8AsvTtTUpUl7WGh2GgWpwvHdyLE1ebPqo1UHb5O12CZD/3jZ
 lx2bXEVxoVUv4/AHmPweecFNKo/LwlReS1wE6q45t8sdypDwBr3WzR+50zQFK5Fi3JU6
 wk2A==
X-Gm-Message-State: AOJu0YzvoSI/fcFJaIlZiVtLHrAekRClBT1Lh7T5DaDArY68DOSLzzvk
 DIgegyGq7za++yQKtTmA83oYQVCMECSE1efQNdntyaioAzxk6AhI94HHbldOaLtU4ciy/Tg04JF
 D
X-Gm-Gg: ASbGnctUxv51AeiYzBGBoFANcajK5pdRwPVkgFrF0nkydnFolZ65amMXcBEFqxbFFch
 XpbPZjGQtj+jiOPCylXcmf/QbIJ2mXu5L8AFUBb+2+CizlQom6riGLCqlTkMNSBIVjR4u/nWw37
 OmfNugpMn11mTglB77o6qXY5IuSCrYZeppcPe3lLjpS7jq/LvAjvtNHJSJvDgp0KRidPoDXS8ff
 kv5MuitbzAKM0Aosucg3lv2Ubo6gZVwvOog/IYi5kK4EVxdLJbjg68wXUYQiA12uC+Bz3IVLg9J
 jEEpm7D3mEbtfbegTEVX6Wo+oQJd5a6Qd1GJO0554+mJr0OBCPb7hMO+ECKKxvElY+4vTGd+pBI
 =
X-Google-Smtp-Source: AGHT+IH9UfEysyuFx2rogEDXuLp7me2ad97DPO5ySSKps3JhZmAEEHDsD1Xy0dwnxe6IUDlB7wn83Q==
X-Received: by 2002:a05:6a21:204:b0:1f3:1ba1:266a with SMTP id
 adf61e73a8af0-20445af2509mr477405637.0.1745456194685; 
 Wed, 23 Apr 2025 17:56:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 080/148] target/i386: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:25 -0700
Message-ID: <20250424004934.598783-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move x86_cpu_mmu_index() to tcg-cpu.c, convert
CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-10-philmd@linaro.org>
---
 target/i386/cpu.h            |  2 --
 target/i386/tcg/tcg-cpu.h    |  2 ++
 target/i386/cpu.c            | 18 ------------------
 target/i386/tcg/seg_helper.c |  1 +
 target/i386/tcg/tcg-cpu.c    | 18 ++++++++++++++++++
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c9f39e99d3..0ad67fe0fd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2597,8 +2597,6 @@ static inline bool is_mmu_index_32(int mmu_index)
     return mmu_index & 1;
 }
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
 #define CC_SRC2 (env->cc_src2)
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 53a8494455..7580f8afb4 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -78,4 +78,6 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+
 #endif /* TCG_CPU_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd85663833..57f62cc869 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8664,23 +8664,6 @@ static bool x86_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
-{
-    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
-    int mmu_index_base =
-        pl == 3 ? MMU_USER64_IDX :
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-
-    return mmu_index_base + mmu_index_32;
-}
-
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    CPUX86State *env = cpu_env(cs);
-    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
-}
-
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -8922,7 +8905,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->get_pc = x86_cpu_get_pc;
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f4370202fe..9dfbc4208c 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -28,6 +28,7 @@
 #include "helper-tcg.h"
 #include "seg_helper.h"
 #include "access.h"
+#include "tcg-cpu.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b8aff825ee..818653ee6d 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -94,6 +94,23 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
+    int mmu_index_base =
+        pl == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
+}
+
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
@@ -112,6 +129,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
+    .mmu_index = x86_cpu_mmu_index,
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


