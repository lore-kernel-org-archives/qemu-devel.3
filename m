Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA27C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS4-0007QO-Sx; Wed, 06 Mar 2024 09:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS1-0007IK-Qq
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001TZ-9B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412f5e905e2so5481805e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736045; x=1710340845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0njWMdZJbPD5cZgXS+g7eH7Y9rT90hV9Vq0dFBAOsE=;
 b=FAOjv5bmqnLfHxjoJmra29Mo4KZa+DM5csDN0yPWUenYhLAFwALjZwITdgPpgaR8TP
 WMBAY1Wc+qq7lCr3BnehTypkAUBTpuWjw0vicD+SKKSS1Fov4XwG4kuZoov0kcwjFxzV
 JwsZkVXcz9pdNNW3/dXJGVF6yXkDLUtXrZi0LBFadr8BaaQyOaoqJx4Ns3DSpcBd+lsX
 uPZys1HsNu00FGFn+kdL364MSr4eRCmTjFXtoWSTVt3yGwE1PsU+mBEoV0j6Nr5omuqY
 d3cLrFreUbbF/xh+pLvgGAgQ2Z/0jRTjPanfnge2VjU2h27a23sYPq9a4GGoqdu108cB
 UcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736045; x=1710340845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0njWMdZJbPD5cZgXS+g7eH7Y9rT90hV9Vq0dFBAOsE=;
 b=g6IhseXmBw935NskSp9TSrvLYb3XGe3Z6DbKiKUp4NclR/l7zZ4hBhX3R2wRaFO0B0
 L+tsO8tFPbpD6TZurvhZsYPtwZvC+MfqJFntWO+PWHUV48IEgNweCKZO45IDnibZ+LG6
 xc3kPgBP4N5UM8eBtgZdB06yzRT3ukC7dizk2KPurlP9GF/Cxk+anBtT/1Jg913bI0uE
 j+uSl0E6O60W+f5MR5w6ZsneYV0PABPgwrcYgiRFQ/sbM9Ov4TlqP1v47D2Eyy8aRGDH
 4Ft932Xkm2Z+UtM8lS3yIax2x3XBHPBzo9zEfEfg2ErwEtOtTDd2sjPzeLGo3qbApXJG
 2BHQ==
X-Gm-Message-State: AOJu0YxSexefMc9FYc/YYID+CDTBfdUiLhAdwW4pOyZjHz7dM2mMXMT9
 SkptTZDdGfU6X0dB3mqdBjNWZbzTjzoehjIr7umM+k4IZQQ1uB4BGFrZjpvG+ZU=
X-Google-Smtp-Source: AGHT+IEPPa1Ecaqdsgx94fUWAtTx70U9UCQNfjgESyk/mob1TtsMjlSw+ffvvIri/MLIXUWTDqPRqA==
X-Received: by 2002:a05:600c:a002:b0:412:e339:14d9 with SMTP id
 jg2-20020a05600ca00200b00412e33914d9mr6221735wmb.0.1709736045329; 
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bq26-20020a5d5a1a000000b0033e2777f313sm12942842wrb.72.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 373E25F958;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 06/29] {linux,bsd}-user: Pass pid to fork_end()
Date: Wed,  6 Mar 2024 14:40:18 +0000
Message-Id: <20240306144041.3787188-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-7-alex.bennee@linaro.org>

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index d6418780344..3003c8cb637 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -208,7 +208,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      */
     set_second_rval(cpu_env, child_flag);
 
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
@@ -252,7 +252,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 
@@ -285,7 +285,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4adb75d19ff..1b0a591d2d2 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -192,7 +192,7 @@ void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 #include "qemu/log.h"
 
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index c63ef45fc78..ce11d9e21c1 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -71,7 +71,7 @@ const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 /**
  * probe_guest_base:
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 517c6b3ec2f..fca9b302043 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -116,8 +116,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
diff --git a/linux-user/main.c b/linux-user/main.c
index 755c566d6d2..cab95f5b0aa 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -148,8 +148,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c233d4eb30a..7f30defcb13 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6669,7 +6669,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         if (ret == 0) {
             /* Child Process.  */
             cpu_clone_regs_child(env, newsp, flags);
-            fork_end(1);
+            fork_end(ret);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
                tid is set.  This would require using either ptrace
@@ -6700,8 +6700,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 }
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
-                }
-            fork_end(0);
+            }
+            fork_end(ret);
         }
         g_assert(!cpu_in_exclusive_context(cpu));
     }
-- 
2.39.2


