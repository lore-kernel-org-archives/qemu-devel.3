Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC4CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hb-00039N-VG; Sun, 21 Jun 2026 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hO-00033w-Vw
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:25 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hM-0005HI-IE
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:22 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-69e8aa31e9fso1620712eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015739; x=1782620539;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LlKlNKCcfcg7uKfhDKsp+7NtoCqHPRF95hiLVxo7EAM=;
 b=vdeGR2DlCqTkSOrxsVLuYO4qEk5fYn6tB7VKf/l2gtmRkS2v9ex7bLrvADWTNoYyh1
 QS4VdcQ5NArxWtcGRJ3O0Yj5SG/kcUCWkOS0j7LYYTnJsfmuIlVo4mevaIh+rJo9zBQq
 qv57rFMKXWgUDl0QTgQHr08MhXmLjbL+PxmD/q1zGAw4krXVHwO7xmN+xfL4nH/JMidZ
 yJ1YfkLAvJeiDEPGUI8bYAv3az0sJkK8RNkIhzced3t0u1Yb5LlpReLMomSq/D49O74+
 Mp9cRqu6sqTWXJ/yR9uRtg5L1o90lGENXBNEwdeECBNohqr5ZL6RFlKf1jVihidxZQSt
 WAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015739; x=1782620539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LlKlNKCcfcg7uKfhDKsp+7NtoCqHPRF95hiLVxo7EAM=;
 b=BBBtegqmXKX25xRxQBu774RBImWrY+CDoyLuptwN/zp9lo8uiKZSFevNDTfV0LcMnl
 PQmENaG+2fOQBGdeyuvluUD2zbskd1lEjZc2ZoQbChiab/lEiRfy/NV1yY08Hpcfn7QQ
 O4zWhmEu4C+vDYolRxzeWqzWHD4OZa1sqsvMPmxaXIQVwRgHBpn04hZiWbQ8wYcLUGlb
 X09ZX64ouZdbV8NBAu4iOlezbhmuylXPZ+wWzhE3Z4aZUpw5AVb+1biem45PFoe0RW4Z
 KhRRHDNFmD4+FPXB71JMje4VbYujiNv/nsc+XpzqXezxTFSgtn2Q+8LI0sRZ0+O9f2gX
 D+Ng==
X-Gm-Message-State: AOJu0Yw9BYd83N8kp7DIKWdulHdNtoYkHf/he/CXP9VpzOHT7WjHB3+X
 YNYVGmx5EMUWGJa2cd0doV72x0x4Gm7x3lKITL7ztnpcG2TFJZnKETf3TWg0pzUyaTs=
X-Gm-Gg: AfdE7clSUhzMR+oa7H0ABpqCCveligPh+YndIqClCEGxP/wWxsVHQ1BYtzGV6zZJ3+0
 E8XPkAgPKo9GaKz/byJu5os1gFSPVsHz++i/eHNi4FpUbQ5ohM9wJCbIbYFD8cDiGxQC2jx9ztG
 dL3v+8apjdXFcLtbZA7hwCcKIKPp+9pQs8hSw70pAlmTg8R4anx5ch/kwtr4pDhQIndE2YbRrx4
 D0KE6xOWVjlJceEBKlgssuPqWKoQMax9lQXJ6SCmw7ijG66wPxMxGwXUL+7X+BZVHLp6sD1JcPp
 iRw4zkZHRY8GDJZt7PXdGH1Qs6s+ZB5xG74ni7YzLnUxfzgP+DcNysKHAVUQV0qbv6LfjhL3N1/
 fL0XhrUo3HT0/0rLTsoAJIdSHtE8R/CD/z65JVSH1cg5M8iptz4iY0sReMyifPwIX8xRwN2LiNU
 Y=
X-Received: by 2002:a05:6820:81cd:b0:69e:89dd:175a with SMTP id
 006d021491bc7-6a0ddef3fb9mr6288024eaf.20.1782015739317; 
 Sat, 20 Jun 2026 21:22:19 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:14 -0600
Subject: [PATCH v3 27/40] bsd-user: Add cpu_copy and make init_task_state
 non-static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-27-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=WlR6Q9GQWWWUTxlkqv6eVWPHCyQJru+tkKYNMUnnttg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aASMqYbslykVIN/Ltv/uw6YOx7dqTd1xxnd
 VVmWeL9riqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AGSOD/9zGr/xitovDTtpfuBTB2o/Ne4yZaVL+Elt2gv918sixNlFsgg4wyBk8Ik5WTJ/xFsIg04
 ZvXtgwiIgLUU2KEA5xtC2z5LJWmuwwO1qB9jeRXNTQ52GNoTuhkTfo8fwxaPKLYSAsV/R3oWdKF
 Ity5iADYxaadchUkTsGxt+QZYONzhgujj2mrhj4b3eHzpzejRHihH0Sgrn7uuoOlnqNvT1CvgbW
 wKIDMVVvTr9p+d/8srmkHex3LgjEBCnGhL7S1Qn7ayoUZqTv9ru9l3OobZpmjGl1nD97apZh/r9
 996A51WxgjOAdNaWWTbAtgCs4ytd0XGraFbkGgajRCLS5kc0536pDr58HeSB3SgwJED55Vfvw1J
 UpPA5Y70VMQVkgAHflutBDAoZU3qTkFWHrRCH2xVxksPWNC/te8Jg5e/1MsCfp4BSYpAfpTZDbN
 sDAKYrMlSQUzE7RhyZTuIpEzLB8EoseZv+Voh/15wnSUaGJtIN/qEZ2au2bLNSzGbPjggf3k0qu
 k2RlvjHmzG3K0t1agb7ZLaSi0R8UyLiIYcac6sLK0oOsR541b6jwqcuR7NdGeT7ZrQW6Ts+hcm3
 WFbrb2I1dFCX+ogiaLThlHCC5JAEw/4ukImfzzxife/xNTGb3QMRMBwSXxxGjC9sZaGXzWzHInC
 1mFFOY2eOfMD6BQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
 bsd-user/qemu.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4f1544342e..9dff2cbcb7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -50,6 +50,7 @@
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
 #include "exec/page-vary.h"
+#include "exec/watchpoint.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -216,7 +217,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 }
 
 /* Assumes contents are already zeroed.  */
-static void init_task_state(TaskState *ts)
+void init_task_state(TaskState *ts)
 {
     ts->sigaltstack_used = (struct target_sigaltstack) {
         .ss_sp = 0,
@@ -225,6 +226,34 @@ static void init_task_state(TaskState *ts)
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
@@ -257,7 +286,6 @@ int main(int argc, char **argv)
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


