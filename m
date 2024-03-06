Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E15AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS1-00079k-MY; Wed, 06 Mar 2024 09:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRz-000718-0K
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001Tc-7V
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412f0655d81so10619705e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736045; x=1710340845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMg0/P2uHBERFN7NdoTSBDJ9hxY6gx6OhA8rGKHoyIo=;
 b=pbYOzzQhxj5t/Bsp4oUCC31YexBsdFaOwwxNQ/DI7o3SBxzKmg5iQOZ80lQzUfXU7g
 zjvafzvG8YynawWNWkmdvigvCiJtviGtwqn5fhFn4x8Kb8EuiTyyLVXgBwQWeqiXk4uA
 DKARvLxzzX7BptvQKxMS7TZ/uUngFUmdqB1kJAUB7ngJYy1mjJ/pwanJc0h8G6PEVRp2
 IDzyUilfkpRTJftoscSYQ8PrWBIMB/Rkelnv04MGy851iwYtpmEdygXWqn6Wb7vnrpM0
 +N7w2tqLYJyFWN9JJ+UyAR/0yXtKb5ROR/NRhE/XKGnRdT+7gX14QgScw4jLq34bf6Of
 6aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736045; x=1710340845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMg0/P2uHBERFN7NdoTSBDJ9hxY6gx6OhA8rGKHoyIo=;
 b=GEp2ncxwWDeFgkIQrwqHBe8mIq2DPth3aAkEwbLFqa0OINSOEv8T6IciH0mtoxO03p
 ZOZUOXrcsAQhir1cPaDUM9UcXOLkaaHpVItNExo7OogY6/UM0lmuYliBiozu7Tz7JPiD
 K96gm94usyfWr9SpqOHWQU7Cmy7Q4dH+9pmHZ8QKf/Hh5oMpiEr1yeC8635f5jdbHvuy
 WYR+gvmUf+7POSDKnONuoN8Qe+aor6b2RZXN9anT/mUKBOd83A/VEu5XNax986+yQDJA
 +mZcBTuGea07nZ9XdUz2jGzRvjPhJXz9sR4YYS72A/g4m6i+2w3IPOwQv7E/z5hFtyFX
 GTJA==
X-Gm-Message-State: AOJu0YyT96MBKfZrdTtruNI7uQnb4wFHtUec5Kk4FBY5DF76Wxk5P6L6
 hQU3lTSn4qyqqZX+AnhpQv2FkmQs+LuTYKun2RCGeMwRAtIGQPNMJ/DNchbZ2TY=
X-Google-Smtp-Source: AGHT+IFNcA719ohsRGcNOWS+K8o+GKrGFUzqDghvx6g8Ewm3Tl41VYh6oYDtPl17qOacUjaI0twZOQ==
X-Received: by 2002:a05:600c:46ce:b0:412:ad6e:88cb with SMTP id
 q14-20020a05600c46ce00b00412ad6e88cbmr12472667wmo.36.1709736045501; 
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c1c1000b00412d2dd4bb6sm14709099wms.42.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F2355F956;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 05/29] gdbstub: Introduce gdbserver_fork_start()
Date: Wed,  6 Mar 2024 14:40:17 +0000
Message-Id: <20240306144041.3787188-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

The upcoming follow-fork-mode child support requires knowing when
fork() is about to happen in order to initialize its state. Add a hook
for that.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-5-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-6-alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130c..e33f8d9a9a6 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -45,6 +45,11 @@ static inline int gdb_handlesig(CPUState *cpu, int sig)
  */
 void gdb_signalled(CPUArchState *as, int sig);
 
+/**
+ * gdbserver_fork_start() - inform gdb of the upcoming fork()
+ */
+void gdbserver_fork_start(void);
+
 /**
  * gdbserver_fork() - disable gdb stub for child processes.
  * @cs: CPU
diff --git a/bsd-user/main.c b/bsd-user/main.c
index e39eef3040f..517c6b3ec2f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -113,6 +113,7 @@ void fork_start(void)
     start_exclusive();
     cpu_list_lock();
     mmap_fork_start();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 3ce20b7bbfc..536fb43b03e 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,6 +356,10 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+void gdbserver_fork_start(void)
+{
+}
+
 static void disable_gdbstub(CPUState *thread_cpu)
 {
     CPUState *cpu;
diff --git a/linux-user/main.c b/linux-user/main.c
index 699da773714..755c566d6d2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -145,6 +145,7 @@ void fork_start(void)
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
-- 
2.39.2


