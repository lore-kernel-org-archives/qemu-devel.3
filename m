Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8503C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldn-00006d-MW; Sun, 04 Aug 2024 20:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldl-0008PV-8c
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldj-0002KC-LK
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso7494603b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817914; x=1723422714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCe4GkwH/iAnpmcpXgqjGYu6VSZ8QZlYv/hHC8b9IYI=;
 b=rdkeGhj16oa8Y5B8j6NgH7jUWTJkb1fHjsRMQFoVhbrYuMCJcGGe+4+/FTsk/ipgWb
 5PZ8kCs/7w6tBt7phOj8g9buewNhOE9+/J89nSEFteJBqcpl7uwI55ANK+yTcjvODb/8
 WjvOvg91F5a9Y/nvMYd21I3IvVeO6R3NSN7SZ2X7deG/D71GdDUsgnqn6+uR3dCBhwMi
 mLsQWtHpb7dsbiKTLFNoIEu3dCSD8U9wAZ4Wh5s57lHPW+DovOZBE8QmVWHGOpTjOOkk
 32NtHvbFkKv8QPSh7wIIICFYtMmQs+7rJb9poU3pgXk1Q8pGmHnQ1mvoEYAiH8AOx5Mz
 5kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817914; x=1723422714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCe4GkwH/iAnpmcpXgqjGYu6VSZ8QZlYv/hHC8b9IYI=;
 b=r+gSc7Qdm3BkhDQ/A0awXJPRGXtuXlLe8EyYzeUam22kOfp2gYsPisUzl1ZtFoL6AC
 maYPXoyCmxKDSCez2pR5yytyLG3O09kEqy/I3XJGtOAmORpT9fb1Gjajm6jLkzBVbuNG
 +bJWrGnMAi/SSbcmn54wOwDa+0hqpqcf+Cur8Snr+6Z992HmR72knKYoYboMlvnQMyDk
 jJKIXSMcxAk1bxgYYPRDHWEuZyko/tPd/cfXR5mQidLYArr2KqnikRL4Ae1eLBYifCC7
 jQr+34c+HJyfTIwVLaQPta/bs9Lqj0isr0XZOd/YbXsHrlevxnzP1MVQWUWsTIGX1EXH
 IseQ==
X-Gm-Message-State: AOJu0YziB3XwGQibUombyQ6LMUIuI1F3F02gaZmZakdce6JqTYCCtc3m
 nnAIQxce50jWwOMzUgAd1m0arN3C9rhU7sekHtwc7/nBmmsqGJGC18E1A0YDGICFIBdGW0FmO0U
 UYHaLAg==
X-Google-Smtp-Source: AGHT+IGI8rWmmxTFk6Jo3jU6wPokUjmP1UWm5VMT4a4ZHL/LMt90XTZXeuWrVzcA3TcD+o8TqJV/Dw==
X-Received: by 2002:a05:6a20:8416:b0:1c4:b927:1ffb with SMTP id
 adf61e73a8af0-1c69953db33mr9534159637.17.1722817914049; 
 Sun, 04 Aug 2024 17:31:54 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PULL 6/6] net/tap: Use qemu_close_all_open_fd()
Date: Mon,  5 Aug 2024 10:31:29 +1000
Message-ID: <20240805003130.1421051-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Clément Léger <cleger@rivosinc.com>

Instead of using a slow implementation to close all open fd after
forking, use qemu_close_all_open_fd().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802145423.3232974-6-cleger@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 net/tap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7b2d5d5703..3f90022c0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -387,13 +387,20 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
 static void close_all_fds_after_fork(int excluded_fd)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
+                           excluded_fd};
+    unsigned int nskip = ARRAY_SIZE(skip_fd);
 
-    for (i = 3; i < open_max; i++) {
-        if (i != excluded_fd) {
-            close(i);
-        }
+    /*
+     * skip_fd must be an ordered array of distinct fds, exclude
+     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
+     * range
+     */
+    if (excluded_fd <= STDERR_FILENO) {
+        nskip--;
     }
+
+    qemu_close_all_open_fd(skip_fd, nskip);
 }
 
 static void launch_script(const char *setup_script, const char *ifname,
-- 
2.43.0


