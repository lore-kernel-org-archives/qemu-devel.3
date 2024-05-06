Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A416BC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcx-0004X5-Ml; Mon, 06 May 2024 08:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xco-0003rS-Py
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcl-00027y-NJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b794510cdso15114335e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999157; x=1715603957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/Fp8DKElE44Fn+ap9z01bjvDp7koqMm6QbA7s6TWS0=;
 b=fb4GpYfMg6cUPm0Bmlf46mTeWVPFZI9VgXhV9CMID8Rn6b8pl+ShGu8bnbGScH2gWT
 fDMmCwCGyeTnBVXbGxcu7mWIRjHMneLOJC3v+grY8vG1eVOzOR9lSBEVvdWEG0j9EizQ
 zwcXOkGn5iwxb+COBwSiJS3lnflJKxUKXjTiSplzWN2BldlzQj3qLUmsRS4Lda17TKU3
 uWG0g5lhkkawt0Pl/oFT7v7z3alDcYI4y0cDa5Sz0hHd6lOZ6QhxX2scyrPL4FbXvwPS
 Tz7vLKYi4nAKUjf8Mjt7vbXnKHbv9IlPwArywk6v0c3PZvkS97BCUO7uG/64IqdtiG7Z
 x52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999157; x=1715603957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/Fp8DKElE44Fn+ap9z01bjvDp7koqMm6QbA7s6TWS0=;
 b=i5PcfzY63byK2oLMAjkcDGgNJr/5KJRdQCUu4h0rKVDdbHRKZpD7VqSUJvBOMHPEmZ
 1VqJDGGeMWxxfm/P/+yvhUgK8EdIS/RQPyat+F+qMBXFVT12Peq6Z3GoNgf9jv0WU2RY
 OUzNmfDKcLNCZUF1scPQODLG73hfrK4JHKiXvHPDLkOxjJSzggCJNifXL7E5kjZ6ZkQJ
 vGJXv6d4ozFggq45bsSPnF7sE6qdSrYKAxlxQZXcBlGz90la5IqRalQSUahVR+vBiWnk
 N012480KoklR4W6xpJEYRAvx29KWXCoGh1w7eyWqKduuIAgPZp+4e6m85E2unCw1h9qn
 p5mg==
X-Gm-Message-State: AOJu0Yw7aYkzRKWyEZ6NyeJXBmWpJqKoRhyYfP1dtwQ7g2wR6z1nBtng
 NeII4pN1mWE/QWg5/+zwsDDEQTVHh9L6zk30TUZ0bmz5OL6uWftfeyU/33GrZxyo90jqMlUEyHQ
 Q
X-Google-Smtp-Source: AGHT+IG6+HGdXHbsGqMQFJxAOHi9y8kE6+10UOueQ0oU/hK5fsCgavf11g/uzy3dW3WYUFbPf61crQ==
X-Received: by 2002:a05:6000:d87:b0:34d:a1fb:8f73 with SMTP id
 dv7-20020a0560000d8700b0034da1fb8f73mr7057376wrb.4.1714999157442; 
 Mon, 06 May 2024 05:39:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 n8-20020adffe08000000b0034df2d0bd71sm10588152wrr.12.2024.05.06.05.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/28] user: Use get_task_state() helper
Date: Mon,  6 May 2024 14:37:15 +0200
Message-ID: <20240506123728.65278-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-11-philmd@linaro.org>
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


