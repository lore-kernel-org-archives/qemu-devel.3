Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335D0C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFt-0003mE-34; Sat, 19 Sep 2026 12:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFk-0003V3-0i
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:28 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFi-0008P5-Gj
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:27 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 46e09a7af769-804f7045f3eso618930a34.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836565; x=1790441365;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FT7qDjjX53Ip8KeDH87xZBjOjstqFtM0Vn4ebZX3J3E=;
 b=Nd/ULje3F+HLPp/u1JQyGVPfd+nbVcfmI82o2ayx8/nwy4LNZaFGGQLFJ471M4TXu8
 8a9wwKsEsrG+lPpjhlaD7cA0xHvBTQ576hLKJT7XoJtvIlL+vNAcdc7wnduOQPvFiv2+
 2Sxi827kgN+2vxaQ5Zr1Ol0YWaI5tPtMLcnydVcKR9laChe2824cOV05olO0K+kI8xoe
 oW4F0jfvGQFl7MT2gpY4IknzmZv3/dpawN9ExeUDHEVvRV5O28VFSHTpKyX+13pI9ULV
 Sg12cdZ+oZWyT6X4kTML0arnGhIFSrrd1PciEOaBA3+p2Uzm4B2EZ5g+szbhdASdJl2P
 7+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836565; x=1790441365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FT7qDjjX53Ip8KeDH87xZBjOjstqFtM0Vn4ebZX3J3E=;
 b=JlhJ7yA/skU+C+5iikPzvB1gh2XmoXEwb+m1Bu4t9uuNWWoonxqR02Vs3BcWfkDZzM
 /iBUyZnP5p/h/2chL27Re03Grh1ly1HSnleEuxe/ZigQkICu+9ieLbLH69pUM0NWez1Y
 cPVZCYrXJFVrNZzmloeXQNTHjrSwZUvkjY0EMhiWKWF1o94ljvftvIgx8kRufWwDSM96
 vaUGNrNXBkKm1zB0CBXRINcIyxvyKIdsSc7CHfsYxljQbvzxA3PkNVVUwsBOLRKNL/XO
 zTHr8MRXyLLUyLvz9+mIDkN1sNeg29AEjXRdmxOfQvg1ehLbSen+D/rdTMFB0g/Mw1FC
 jcUw==
X-Gm-Message-State: AFuF++lornD0TAYftY3w2TIemB5kRaHrpkcH1FKbYwEg9eKD5D/WsieX
 uUCYOD4ZLzyhF5fl6+j+EEzwFZHj89/rJ8cEwhq/8G4kcdKNkDlQKuDvGFDqbg78ETp3eJECWdL
 jx0DIG24=
X-Gm-Gg: AYBFou2F1izn16ZXwrqQPkbE5+kT6HmK4sCEU29mVo3q5B6QvA0P3D6sTbbNH/iagDA
 luMN2oprbLMFqZv+cl+dQ423rBNuzV5p/wlWTdJQHcYB2R5fFpeynUNHL509rIqcZaNx6dx46bQ
 O2TccTS/8uSETwWoAmtlhh+VzF8qHFHilAfhFfFdGtMyi0S5/3Yr/T73D9uI1ElDni7Ucw7OaLM
 gYAsBhhS5KAh5N+coPaHEXyV9XNv1/2aXrizyJK0LFvUgwV00OSPxG1BpEtQfQ16+y9kN2t30tZ
 UYWNUwi9iF963xuOtSTKR5vac/OkPD6RrLYDr6tWIryexzIqxrrykqDKGq4BX6uuEKk8M2olmtn
 M2k6tdhdSqcFVqP7sVpuCf+oRUMt96vfCAufYRBE71veD2dbczEDFuafxOCnK8xXljjikcR7aEI
 7aaDgGgj3MEUigqN71pkChSrEKppB1Bspc9p66bt8nMzZQWZKhdi/rkWPz6u6XtSsMQuOw
X-Received: by 2002:a05:6820:1c94:b0:6be:7d9:b14 with SMTP id
 006d021491bc7-6ca9a1314b3mr5459094eaf.4.1789836565369; 
 Sat, 19 Sep 2026 09:49:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/41] bsd-user: Add cpu_copy and make init_task_state
 non-static
Date: Sat, 19 Sep 2026 10:47:57 -0600
Message-ID: <20260919164810.70151-30-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add cpu_copy() function for thread creation support and make
init_task_state() non-static so it can be called from os-thread.c.
Move cpu_type to file scope so cpu_copy() can access it.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
 bsd-user/qemu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 694481ae3e..2fbbfc3d86 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -50,6 +50,7 @@
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
 #include "exec/page-vary.h"
+#include "exec/watchpoint.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -215,7 +216,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 }
 
 /* Assumes contents are already zeroed.  */
-static void init_task_state(TaskState *ts)
+void init_task_state(TaskState *ts)
 {
     ts->sigaltstack_used = (struct target_sigaltstack) {
         .ss_sp = 0,
@@ -224,6 +225,34 @@ static void init_task_state(TaskState *ts)
     };
 }
 
+static const char *cpu_type;
+
+CPUArchState *cpu_copy(CPUArchState *env)
+{
+    CPUState *cpu = env_cpu(env);
+    CPUState *new_cpu = cpu_create(cpu_type);
+    CPUArchState *new_env = cpu_env(new_cpu);
+    CPUBreakpoint *bp;
+
+    /* Reset non arch specific state */
+    cpu_reset(new_cpu);
+
+    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    memcpy(new_env, env, sizeof(CPUArchState));
+
+    /*
+     * Clone all break/watchpoints.
+     * Note: Once we support ptrace with hw-debug register access, make sure
+     * BP_CPU break/watchpoints are handled correctly on clone.
+     */
+    QTAILQ_INIT(&new_cpu->breakpoints);
+    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
+    }
+
+    return new_env;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 void gemu_log(const char *fmt, ...)
@@ -256,7 +285,6 @@ int main(int argc, char **argv)
 {
     const char *filename;
     const char *cpu_model;
-    const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     const char *seed_optarg = NULL;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 069baa7011..d2dd8c2ee8 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -122,6 +122,7 @@ struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16)));
 
+void init_task_state(TaskState *ts);
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;
-- 
2.55.0


