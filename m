Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E6CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vk-0000XM-Jv; Mon, 18 May 2026 17:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Ve-0000VC-Sp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:22 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Va-0000WG-Tg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:22 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479e6bc357eso1005483b6e.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139697; x=1779744497;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NLw1jYsA1FC75BIK+XU/FjvD1FNM1m0O7ZBaQMzntbs=;
 b=n0QsfdPD+xaUHlC0/Vr2cbPPa5IX53slBMnYEsop+d4Fxk1odsmTPNm4jPjxPXSj46
 P7aSsOtmYxnHbxvmSAtAITU46liwpo2Wjx4vfr6OVafsug1kKL4aBASwSVIjn+b20zcm
 silbZ+q6TltEI4S/czxPHEz3aOR3/phaXr6sWePN0Gpw1Dn2ad+d7YSpGFs79j2mm16E
 GgqF6x/mO+W9pfrUI/9q77yt5sLDdBQN0/C33LdqofiEcrpoVP5PeoqFbZgXQeGT7538
 0sWjUtXyIXuKRudnTvBbNQtwTXmxHq24vjihVUSwDGkuQmQvJ5/8eAQoScyDXrGtnO8k
 ACNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139697; x=1779744497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NLw1jYsA1FC75BIK+XU/FjvD1FNM1m0O7ZBaQMzntbs=;
 b=KCbkTQohWk350+FwTg11Iwgv6u2Ipifa48xE2D2gyiLm9mf+D6G3YrQ35zfCqm6hal
 5RGIjKRWRkL7e7rjI4rbEt7l6HTS0EjHtECnv8mM/iwgf2a/Eq048xiX7w320Ape+Ejn
 5WHYycCCNb21gUFtQy0gghnF0HN/80HOFcKcUwtMFxN6QTtyqOr0jEP1PNVaYMfc3rrz
 q8n0yvDLGVd7oZBzBLxPG1Y2nCXZde/54pydMTedoC01VIcCQ5xAGwJd1Sc1Udrc/6nT
 t7QRkF2PE99fqDnbrpw0OS/VGQPiPuJounopILbO+O1xtCFU5TpKAmyBuxnvpcG4Jkzs
 vMLA==
X-Gm-Message-State: AOJu0YyiWoUhKUS9MkHNQcAZ4De3m3XNOb2n0ToY6C4o4dOEHGsEtkRI
 L0F22IXSINPZ1V1tI1tWcUA+lvK3vb+skzRLr8kFoVtORsccMaA9MhXwjuqrebXYjKg=
X-Gm-Gg: Acq92OHrQI3Dau53p2/OEtybVeTUIcC0Olt/JyXBOsekh04AYr0GqtslZkcbRvGzU/p
 2UeHj03/UkGMpwMe6MhtzxHp/oWnb72k0jwrG9RT7Z1ZaHUegEzCn3Qqpv62FNgoaBOFttorWld
 ZDpbkxhi2wuV0Do0SfTiWUEmR/yt9l9ea9D6qQXfZmNRUQnnqm/r/3MZPhIwBq7kFn0jQQ04LuL
 z3zIU27ZNy7a4Tcp+V+d1wQkjLf4GUgfdxK8OwVl6cWoqpdeldKYy7d8ayg+MYSWn4slMtyhr8P
 d3wJbfVCGiGVLSihsoWfSYk++FxdckEoBHqYUbHyQLvYWPOik2Jc1KQt85GhHXhyKAhWSpFWa0Z
 H1DOSCEexk8d1SYjhSJcJZmGZmhC/OnnlCmj32/WsiR/thTbpEO8i/5hoiXsNyh+c7X8/P5vaxw
 sTu8i9lua2oA==
X-Received: by 2002:a54:438e:0:b0:47b:c8d0:512e with SMTP id
 5614622812f47-482e577b3dcmr7866339b6e.34.1779139697265; 
 Mon, 18 May 2026 14:28:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:16 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:43 -0600
Subject: [PATCH v2 25/37] bsd-user: Add cpu_copy and make init_task_state
 non-static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-25-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=eDWZgAgv3qFfpEQZ8pRz9vg/5ayhGnyO/P476vk93so=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RIqVy/pi7k3DZyBX5FnQVZ+YbMtZe5rAQGT
 zhuy3eIy8GJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AGQxD/9941+EMW3JhBaevzrUxc0sh7h9E6+oxDxjXZsenqTIJpqhwFGmjLkVvCd2+RGVLZLBDx/
 ZKgBhduY/yV8sJXKmUyZ+EcWJTejsQ3x80uJJwWkdv9R2daO8nE05BX6W6++9ltLrWQlVUFy65v
 Us4OdIaDLRaTWu7gKglOsxYa1bEVxp6gv01hdocMUvpZ7AUel0/1zkVy+zO6gHNXGwiK1g6/d2I
 lYa7dd4RqNSX+fkxYabLFYX545PKJZvyY3c/u9F6d7W43jgZoakN4rgPkHc/YDGK9FXgm+WdvNK
 1hCJqnZw8Y8OvXOedKZh6A86PKvQXwqTSSFwhK35djYj0WocbGbypc5BK+n/C+Wo5bbi7HwYXYu
 UD1PcrTqnE9Lx8eG9ulIB/boKXNdywiIHQEIAma89my84dS2puiaBQmsYCqT1BaB1iEiaOB6vWe
 nDs9CuSdC4nnwLrfsAESV0uWpsh9lLc5mmhRdYc1yYa2gqNhFJm09cdfwnTAKUOlW3/ABmJRbWz
 ME5QFWWGgsJ6o3Q0ElJyDny8Y9ieU0vwC/ni+mfyHKQ8u7ePtv4eIzx6nqaGhurukqKXlzSgIMb
 32Gg2mtRWXoyG0OwgscfF2UTnkk5Bm6zItkZlWAM5CZYzSczUc4X0bZhK5/47X3wdL6Wlpp6e44
 dy5Dj2L0OQY/nhg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
 bsd-user/qemu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c327..3c150b54cd 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -49,6 +49,7 @@
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
2.52.0


