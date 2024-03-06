Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226BAC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS3-0007Ij-0t; Wed, 06 Mar 2024 09:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS0-00078A-Bp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001TJ-9C
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412e784060cso5720475e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736043; x=1710340843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2Ye6Zrq5ycHJhjf1w+zvDuLih/aI2ewQNO57VPgIhs=;
 b=btNnCXZM20Nr3KsNk9UDxk57AOFcAn1Rqb+eJyngGJ5cpZApvJ4SIjY7kHG7RcRthI
 d9hKcAIBzzuClkPnymwpUJD8fKjiKVvSl6eeuPnzAhFvHxnqymqyL79CNjeN7f2DuFeq
 pyI+AkfqXPT8QhRedhzDE4ivrj2mQtl3MPBTF8Dm7w9KzvL4o8f/Mad7AnlfM07cfSUq
 EAQsMRRrH64+99eD8HbTElx35/WFw27tEzEMq/wcUD6dCZiu4K1sa5O2QCNsrXG2C/8V
 4p5bjnxYXt9bsUpyysCT0HZUQJEK6FaH5idbl1HSZvy3glVbwp6Z1k1yfl2r4OFxhnWX
 qNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736043; x=1710340843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2Ye6Zrq5ycHJhjf1w+zvDuLih/aI2ewQNO57VPgIhs=;
 b=uEhhkKJZ5hiLuHYrYHSPEk3cXKPCCYIhwcS2s8Xzt7rhCWwsdyJwymb/egllckFJI2
 WRoON4EBass75GNJCo4twd5dZxdW8kQmDFZpoEidTmFiQsZWmIkEuVJ0HXwqsUz4m9ku
 CytYaw1SxYK0hqfJTLR8eiDvSqb79GuWPvneHRgLcNsrM4Qs7XUI/c8s2P+3/bq8Mmwr
 2gYIyuLUoXOOnFct10v0K4UDwqSMhcLWe59tysH6ZUS6VNfK0DDj0rYD45WGc2BYsues
 7RCDXXndpQI2skXy6MRj1liAagmqvd/FNzm+StuM0lws7pTe5uxAKy3+31YSgnkvg+SC
 0yYw==
X-Gm-Message-State: AOJu0YwjKgB0B3zUwzRFZ4jNb739s/pj9Cp86mBNScnBTfb/7YsB/UkV
 VF4Ign/lHQ4wEWhK6vpvfstCpRU558Whi4WxmFCdvgjxcaQvyfa1MTKhls7PVHE=
X-Google-Smtp-Source: AGHT+IHlz45Gn7ESMV/ctU8xgFgN0UC6JJJgTe8NnCAyoC/UUn26RqywWd+2E3SrpBEtB9FrXCLcDw==
X-Received: by 2002:a05:600c:1d09:b0:412:c285:1091 with SMTP id
 l9-20020a05600c1d0900b00412c2851091mr4915995wms.7.1709736042789; 
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c3ac800b00412e84e59d8sm7327075wms.44.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B71465F94F;
 Wed,  6 Mar 2024 14:40:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/29] gdbstub: Support disablement in a multi-threaded process
Date: Wed,  6 Mar 2024 14:40:14 +0000
Message-Id: <20240306144041.3787188-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The upcoming follow-fork-mode child support will require disabling
gdbstub in the parent process, which may have multiple threads (which
are represented as CPUs).

Loop over all CPUs in order to remove breakpoints and disable
single-step. Move the respective code into a separate function.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-3-alex.bennee@linaro.org>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14918d1a217..3ce20b7bbfc 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,16 +356,27 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+static void disable_gdbstub(CPUState *thread_cpu)
+{
+    CPUState *cpu;
+
+    close(gdbserver_user_state.fd);
+    gdbserver_user_state.fd = -1;
+    CPU_FOREACH(cpu) {
+        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        /* no cpu_watchpoint_remove_all for user-mode */
+        cpu_single_step(cpu, 0);
+    }
+    tb_flush(thread_cpu);
+}
+
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    close(gdbserver_user_state.fd);
-    gdbserver_user_state.fd = -1;
-    cpu_breakpoint_remove_all(cpu, BP_GDB);
-    /* no cpu_watchpoint_remove_all for user-mode */
+    disable_gdbstub(cpu);
 }
 
 /*
-- 
2.39.2


