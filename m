Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53007C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CoS-00076N-D8; Sun, 28 Apr 2024 18:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoJ-0006vl-1z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:52 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoG-0005du-V0
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:50 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51abf1a9332so5257278e87.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342547; x=1714947347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbxYPWieuKJ2V2McIsSIqfnAs5Fqc2GnHDeEOuheOAc=;
 b=aS4Chf2zyBKHi8X7HDPOdG0ZonpyDhjIbPSEesnxJFVUG90ytN3ZJCFEfhtj1n20iR
 6l+2cNKb++1WP5Qx2NYHzXQu1clqyVHeP9OW2XpZqXBYUYcUlFw5xT4c/cFC3vv3WIRu
 V5MvBuGxTamhhU4KPRe1wTn4ALjxT0zTHONmcZPqEd+e1VCQnqhN/55m5YXEemcLOupG
 fw6Vy7SkztZXZ+tAGdvS6ZopC2glczExsNIogooU1PhTCWuYuR8yndT30Y2OMMfD7TDQ
 VxOT6TM5mD2m7Zx2D+bKE2xAx7xEBD8wiaSVEv7z6UIhDj+fsVGmt+yJTSszHq7iOPBw
 tGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342547; x=1714947347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbxYPWieuKJ2V2McIsSIqfnAs5Fqc2GnHDeEOuheOAc=;
 b=M6bU3i3tLarmhYbKvYaM5SkiCWAEzC2At8ZUlmmfv4bMQSNjLHlm9doXkzcu4k9rin
 kgiH4LoSPFK1AjIdTFpW+JMJgpokw363zeiKcwsRHnT5U6SngSvYK+3v6nzJEeGwleRF
 mu9AweU/8T+sIspzDPd265uxnqUABh8znWGqTg3wljj9JN6BrQHibrqn7mN78HaceteB
 yUVUkigIeiz7HFYXFr/6fcbgr9smrR1GrlS0t7LoRyeKxf5KjczcBjj46pQnYziK8fP4
 2l/nKqaUTpBd5vqlY8kczx4gcC/nTJ3a8ZRwuD2j16ctiTHLTl8VHr6U/gpV6x8ztcex
 upBg==
X-Gm-Message-State: AOJu0Yy5LOW+xu3w5bD6HVJdxm//GC2j3S+pP7WNMIWGDlihL+sEXWP+
 EJT4fAyDw3ZleoT4YhSyO5K7V4r2MIPEs0atnfu4HRE7tGDH9nPsmeCS/5kKSj8YyTntrlxPj0C
 j
X-Google-Smtp-Source: AGHT+IFuRewOVYiz+p6G7nIfwdFerVYrMbqRYl97JBQBBvDexzgfHUQ1Y9zZ26FjOBIIutX3rz+XSg==
X-Received: by 2002:a19:6909:0:b0:51d:1258:349a with SMTP id
 e9-20020a196909000000b0051d1258349amr2509865lfc.2.1714342546978; 
 Sun, 28 Apr 2024 15:15:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a170906339300b00a5592a12fe2sm10905821eja.128.2024.04.28.15.15.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/24] user: Use get_task_state() helper
Date: Mon, 29 Apr 2024 00:14:36 +0200
Message-ID: <20240428221450.26460-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Get the TaskState pointer calling get_task_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c     | 3 ++-
 gdbstub/user-target.c | 4 ++--
 linux-user/syscall.c  | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9c2b8b5d0a..b3574997ea 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -32,6 +32,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #ifdef CONFIG_USER_ONLY
+#include "accel/tcg/vcpu-state.h"
 #include "gdbstub/user.h"
 #else
 #include "hw/cpu/cluster.h"
@@ -1661,7 +1662,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
 
 #if defined(CONFIG_USER_ONLY)
 #if defined(CONFIG_LINUX)
-    if (gdbserver_state.c_cpu->opaque) {
+    if (get_task_state(gdbserver_state.c_cpu)) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
     g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 6646684a4c..a9c6c64512 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -216,7 +216,7 @@ void gdb_handle_query_offsets(GArray *params, void *user_ctx)
 {
     TaskState *ts;
 
-    ts = gdbserver_state.c_cpu->opaque;
+    ts = get_task_state(gdbserver_state.c_cpu);
     g_string_printf(gdbserver_state.str_buf,
                     "Text=" TARGET_ABI_FMT_lx
                     ";Data=" TARGET_ABI_FMT_lx
@@ -252,7 +252,7 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
 
     offset = get_param(params, 0)->val_ul;
     len = get_param(params, 1)->val_ul;
-    ts = gdbserver_state.c_cpu->opaque;
+    ts = get_task_state(gdbserver_state.c_cpu);
     saved_auxv = ts->info->saved_auxv;
     auxv_len = ts->info->auxv_len;
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1b42e80f9a..b9b5a387b3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6463,7 +6463,7 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
 
     case PR_GET_TID_ADDRESS:
         {
-            TaskState *ts = env_cpu(env)->opaque;
+            TaskState *ts = get_task_state(env_cpu(env));
             return put_user_ual(ts->child_tidptr, arg2);
         }
 
@@ -8124,7 +8124,7 @@ static int open_self_maps_2(void *opaque, target_ulong guest_start,
 static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
 {
     struct open_self_maps_data d = {
-        .ts = env_cpu(env)->opaque,
+        .ts = get_task_state(env_cpu(env)),
         .host_maps = read_self_maps(),
         .fd = fd,
         .smaps = smaps
-- 
2.41.0


