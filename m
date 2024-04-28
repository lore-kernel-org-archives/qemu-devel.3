Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8CCC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CoW-0007T1-Cu; Sun, 28 Apr 2024 18:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoU-0007GR-3i
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:02 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoS-0005eX-8i
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:01 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51d62b0ecb7so1141231e87.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342558; x=1714947358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1rpAj6pG3Iu5Z1qjdM7/D8i4CzaRkhAeVl3d7RMB7A=;
 b=U/5fcXoUOKOPnspc0RX0xjPZE/g7ygw6nVeyohJcJ4m7gRBLSQzb/1x/qFJ/nanZC6
 tTRx9+r+r17mlxbtLgPxMn5hEUoIKLd2VnB9SUf8jUxPYW9ROSCmge1F5gd5nba+AMdi
 zur/t74X/3oCeJ079QIgMtNFsJSsa1sVmR3BnbsezCnA9oqHE22Ff4lomST7T6YBQv5L
 Ok/WqooFRhRaarYM8ZGVXpc0BossbirYVJPCBfREPIT+X4t1LaScFfxYgrtCDDhuAFtY
 KtGKKXIc577SElHUGnzU1kiyuJHit+wIL7lRyRoRZdUxXF4FWThtdBMsevFuEq/lB0CE
 GlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342558; x=1714947358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1rpAj6pG3Iu5Z1qjdM7/D8i4CzaRkhAeVl3d7RMB7A=;
 b=jx1BYyyjWvxnTP/O4YPlwjhVzbZpAinOFTFVx9knURCnU5sfwWT8bsKBtDhApGJJoJ
 hS3G/nMo6rqXNi+tOc7eXqVY16VE7YIjW2w4pBChUzIrxGw5Gv890t7XarCFPAtF+rUM
 I0cEM0ey6LcQ4AwtD49eFQ5UGf4feye9DeqSuphBB2UpHFVEBDR+eJb/9ALP64XshnYy
 ARwNS41ONykmpSvOIlhA51vNd/82OMpe2rskkSrNBf3SROW5D64d5UAkwderzOa7rirZ
 H0AKNRCkXZ0pngzcs40OE3+f3uOWGa4/nwWaSm6BrOPj2gwUTGXkhDvQfypK0MoF+Imo
 Y/eQ==
X-Gm-Message-State: AOJu0YxACsDDsr/RnbrXQfeyNA87oH9jBaUqQyXE7iohMju68Xq0McLr
 Vbuh2Bzv+x6DU4L+lkBDmbsKqqwJej06eCqsfb+I/oGa50m7ysEceVzV3EW7Dn5lFEAhX5ViSn6
 e
X-Google-Smtp-Source: AGHT+IFvitlgsEl1W3PuxdkQPpMkRU4DD2UUQ9YZwKnpl6isWAXoWbkdiSJNaFwuSLjtidZAmLmvcg==
X-Received: by 2002:a05:6512:3196:b0:51d:3675:6a06 with SMTP id
 i22-20020a056512319600b0051d36756a06mr3815783lfe.66.1714342557839; 
 Sun, 28 Apr 2024 15:15:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170906645200b00a55bb18e3d7sm8230871ejn.168.2024.04.28.15.15.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/24] accel/tcg: Move TaskState from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:38 +0200
Message-ID: <20240428221450.26460-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

TaskState is specific to TCG user emulation, move it
to AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h | 6 ++++--
 include/hw/core/cpu.h  | 2 --
 bsd-user/main.c        | 2 +-
 linux-user/main.c      | 2 +-
 linux-user/syscall.c   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index d0dd1bbff8..cf8e3acef9 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -12,13 +12,15 @@
  * AccelCPUState:
  */
 struct AccelCPUState {
-    /* Empty */
+#ifdef CONFIG_USER_ONLY
+    TaskState *ts;
+#endif
 };
 
 #ifdef CONFIG_USER_ONLY
 static inline TaskState *get_task_state(const CPUState *cs)
 {
-    return cs->opaque;
+    return cs->accel->ts;
 }
 #endif
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 46b99a7ea5..9b99d8e8fe 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -490,8 +490,6 @@ struct CPUState {
     QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
     CPUWatchpoint *watchpoint_hit;
 
-    void *opaque;
-
     /* In order to avoid passing too many arguments to the MMIO helpers,
      * we store some rarely used information in the CPU context.
      */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 29a629d877..1ce4b0b6e4 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -590,7 +590,7 @@ int main(int argc, char **argv)
     init_task_state(ts);
     ts->info = info;
     ts->bprm = &bprm;
-    cpu->opaque = ts;
+    cpu->accel->ts = ts;
 
     target_set_brk(info->brk);
     syscall_init();
diff --git a/linux-user/main.c b/linux-user/main.c
index 94e4c47f05..5f7f03f4b0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -949,7 +949,7 @@ int main(int argc, char **argv, char **envp)
     /* build Task State */
     ts->info = info;
     ts->bprm = &bprm;
-    cpu->opaque = ts;
+    cpu->accel->ts = ts;
     task_settid(ts);
 
     fd_trans_init();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9b5a387b3..49db3052aa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6594,7 +6594,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         cpu_clone_regs_child(new_env, newsp, flags);
         cpu_clone_regs_parent(env, flags);
         new_cpu = env_cpu(new_env);
-        new_cpu->opaque = ts;
+        new_cpu->accel->ts = ts;
         ts->bprm = parent_ts->bprm;
         ts->info = parent_ts->info;
         ts->signal_mask = parent_ts->signal_mask;
-- 
2.41.0


