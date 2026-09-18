Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4393C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAh-0005mz-Om; Fri, 18 Sep 2026 00:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAf-0005kF-BD
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:57 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAd-0004Og-BU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:56 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7fcb425fb68so149259a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705544; x=1790310344;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FT7qDjjX53Ip8KeDH87xZBjOjstqFtM0Vn4ebZX3J3E=;
 b=PSRiciNwF1LvxBiuoTLxf9jEC8nojAgxh2GIdM/jOGwhF0Gp9Uut/kifVGAAZrKSzx
 q/+C6jo3KKn92fkkr3NaMpsG54rM7NIFTBAWFyUAssRzUXfFlKaoPvbeLDkjdFytJNvi
 hOZ5DRYoVvh0YlSBK5xtAoePMmW51j0iK9vn19ZJqc8C8BZx3TJpvAdc9eVq98LObojO
 2o67xECMjg0/VcTW4WM7KKcLWfCp3yIyd6X8QyH8NrsBERhqODlS8xQsziGrLtjHGR/3
 VZc1iYOvm77m/Chx5pNdNyiJPnG6AVRMEKuznCis0rFRRB1vzG2egQp5YDkvz6GwHGcp
 3vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705544; x=1790310344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FT7qDjjX53Ip8KeDH87xZBjOjstqFtM0Vn4ebZX3J3E=;
 b=zMHIaeE9j5SEYOtHpPRVZRxwCCCTwTQvlcrZ/pt10XOtd2p9WIYqkmSfUuy1iT3oK8
 8MeFoMvEC+kXLjRHL2fAcSpy/XGXJ2a0NJ9xKdHcjyCu0V8zbkrsukor5UXbSN+3Vk73
 kcXdBSjuMlAjs0P7zqpn6x9RxkT7oIJzl2dwXi3S/lKoofQ/wVHbGuqFo5il2sQ8Jw62
 h4QNn5nSLCvcp5FC6xEZxBeqLAAWkdk+3Rj1pHkWq0TPc8/Q9JejoIHc/FVwL/rlABpY
 gL1WotG4+X6vQ4oAhuOXHFiT+9dn3ifFyKmpygqDbAiWUz9X7RkSwehdIcSkQLZqlAcg
 V1Yw==
X-Gm-Message-State: AFuF++k0dMHGEsPLq4YO6rVqUrgVH5hsqYdD2tXYpOM0Q/VXLfIqXBwz
 ViAopjr8avBrbtf9hd7IuS9qbI88e/RQX8qMdwe++5p2QdnRJRfPrW62e8/WwLL1FajrSWSRXV5
 vwyiqnyg=
X-Gm-Gg: AYBFou2zj4jbatwpvfMJ4+rqLDc4lzd9DoVb+NqKIEgDO7UnCSdfpdjPF+bREKvbX2s
 IOsw/QVrz95EwIWC71AdIODgIqZX+X3n8IATPVudoCyxrW7iwRgNPKjFMqXhtLuzTjTfU+ugTLN
 3XPD544Y14fSFA95Ys/tCXE5fJ5pPjP2LnS24YDTLMAGOpt0Hn72CBHXrvOauekAwDe5zA8QgLj
 7ETOuZDRREtJa98NolsjT73oETEcXYZ7/tO9OfAUQLA4FvppcAz3TSxkd8Z90+0p74rHqQUEYNE
 FlcklPUjP96qQC/Hskwke0DX67lIy3lptxPfzCcBlzCq4vUZcPtU6Qfp2F23ISTBVkKPQN0B2hT
 9aLP/QQZpgaHZnxESgRSN4Knpci+aXJ0/t1nIRkVfwV1GcNeYQDXcwrAdZ0O2hL8iEzUwz/Kh01
 djcol40mZ3+l6sANj5j8/ZSH/uHwQeuMbaUtzFzWp7B3TgRjvsyC0Cx7FPBQ==
X-Received: by 2002:a05:6830:640c:b0:806:14ab:a7b0 with SMTP id
 46e09a7af769-80de34e4a1dmr1840900a34.30.1789705544357; 
 Thu, 17 Sep 2026 21:25:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/41] bsd-user: Add cpu_copy and make init_task_state
 non-static
Date: Thu, 17 Sep 2026 22:24:10 -0600
Message-ID: <20260918042422.38713-30-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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


