Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B837C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSn-0001pd-Ld; Fri, 11 Jul 2025 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSl-0001nk-Vs
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:08 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSk-00032F-A9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:07 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-407a6c6a6d4so704253b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254585; x=1752859385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xI3qXJJNrbG+1eXwshqtVlZ2UKNtJqDGVC4tuDSKaLE=;
 b=f8jL89sDYu/WspPQJwifkawB3FDMqdGtMEcIkfTb0un3BiAlhNhyIvHybMy3cvqnFa
 9dKqH5T7yQDApkD7MTNMCaI1k+MJJVEddI7mthpXEdMvXa4SJP6Al6R9WOirIsV/ICt0
 ebeQo5nhvegQdvUsenBfRouDP9zqTpRKh8oyR/LHx6rqLYlGXO4+JJN6SxPccPgwY1YR
 vtt8yFReNmvRsaAZvzy0pVWXrheswJz/YB0B5E0fKj4mIc4GSV3bhrCwxecZtC8dMB/2
 FakBzCj6ZUz0NAEq+4kmPKIx8SLuQcPiBOSVstFqopmk/acOdEfhEBCqDBLUk+hwNHOC
 GRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254585; x=1752859385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xI3qXJJNrbG+1eXwshqtVlZ2UKNtJqDGVC4tuDSKaLE=;
 b=n9nrnH+0nPWRfc3A/tdjgC19VGX10qC8MlSdv1IRDwwj1Q7T/2F73r+WziunJfUsAe
 anzhR1WJNJlOY1GwwqgH8xBYWF7UXPGLmRHzhpMpKNxQUH0vsK8OVNeNYF4N8cn1yuQW
 Q/VLMwkYvHI15RjwOIlE/g1K/TC758a/ZRuQhW/qubsX3qTcjUzJWR42QT4f06Sfnn5T
 ZZ69AU15wHM5c+OvYL23wVT3rCTY8fNXivbd4w1Wp5y5Woil8HA2uDBzzrzUDL+52xyj
 j9FMy69pSo7jTjQ7DC7e3ALEHpz/HNjYL1aFO+lWLo0XFoB+zI8E5b3V4f2XiW2Isxsi
 p48A==
X-Gm-Message-State: AOJu0YxPDMLg2Sb4Hozz2DPC15lB+xuDpZwJCCAHZwgstfKa977i8DiT
 vcCLDVNv3he3E2kNcApTI0YTSjW84o5HnlK7DAj9VtzpMhNcaNcw7MsGfsutsKmfjC/KWjv1Fro
 j6h9pLrM=
X-Gm-Gg: ASbGnctXJ8P5AQ1hCbCrx3PBd6rtH1rzhl80AXcLoa3/wtO4z4rI6en3WsKvilgx+8z
 NrdL6mN+BAvg5RjsrHkdL+S6Gxq0wMiQJQ33RQcQRSlHi+VNTHm8YFe9jaHC2PMFyTdN+8qbWIb
 4Ah+QhjEi8DQDsmhluhkwIl4+CF+FSjx4Lgba/9bZTvS+RbM+3EjdKw+es2rbj+OirTVjg9dXQT
 4SUHkWYkzJdKsJkueOslAVCNQ7QlDV00L+KpRpCDbb18Yb8LC73D9SHigL7ExDWDGwI9GbgEM3H
 L9pZdy2xX+POFtja29EaPCztrOJ6uLn9U39C5grV0sRkFlN9yDNcQbX75CL7BHQqhwk8a2MWYNX
 05iD1Z4V/etRWtzRmGmmCQBEdJBsYPe2XPsrd+OFUKTXZD8VxpvvvAaAY+6QnMxgZR+w4qF3e0U
 om1poXyHIL
X-Google-Smtp-Source: AGHT+IGOTasE1tX7VK2+32/MarPTidOjsEui7ZD0DIFTEZtrd+12wp2Qovx5MKFfRTgbUcN1pp+Wjg==
X-Received: by 2002:a05:6808:3307:b0:408:548:8050 with SMTP id
 5614622812f47-4150f5bb2ccmr3030102b6e.18.1752254585113; 
 Fri, 11 Jul 2025 10:23:05 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Geoffrey Thomas <geofft@ldpreload.com>,
	qemu-stable@nongnu.org
Subject: [PULL 7/9] linux-user: Hold the fd-trans lock across fork
Date: Fri, 11 Jul 2025 11:22:52 -0600
Message-ID: <20250711172254.229201-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

From: Geoffrey Thomas <geofft@ldpreload.com>

If another thread is holding target_fd_trans_lock during a fork,
then the lock becomes permanently locked in the child and the
emulator deadlocks at the next interaction with the fd-trans table.
As with other locks, acquire the lock in fork_start() and release
it in fork_end().

Cc: qemu-stable@nongnu.org
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Fixes: c093364f4d91 "fd-trans: Fix race condition on reallocation of the translation table."
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2846
Buglink: https://github.com/astral-sh/uv/issues/6105
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250314124742.4965-1-geofft@ldpreload.com>
---
 linux-user/fd-trans.h | 10 ++++++++++
 linux-user/main.c     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index 910faaf237..e14f96059c 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -36,6 +36,16 @@ static inline void fd_trans_init(void)
     qemu_mutex_init(&target_fd_trans_lock);
 }
 
+static inline void fd_trans_prefork(void)
+{
+    qemu_mutex_lock(&target_fd_trans_lock);
+}
+
+static inline void fd_trans_postfork(void)
+{
+    qemu_mutex_unlock(&target_fd_trans_lock);
+}
+
 static inline TargetFdDataFunc fd_trans_target_to_host_data(int fd)
 {
     if (fd < 0) {
diff --git a/linux-user/main.c b/linux-user/main.c
index a9142ee726..f4f2007439 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,12 +149,14 @@ void fork_start(void)
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
     gdbserver_fork_start();
+    fd_trans_prefork();
 }
 
 void fork_end(pid_t pid)
 {
     bool child = pid == 0;
 
+    fd_trans_postfork();
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
-- 
2.43.0


