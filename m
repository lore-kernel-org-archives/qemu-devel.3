Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcZ5-0000aR-Uv; Mon, 29 Jul 2024 22:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcZ4-0000Qk-H8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:26:14 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcZ2-0007Y1-It
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:26:13 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e05f4c63de6so2942855276.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306371; x=1722911171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xjo9tP3yEe4cBC1QG8qcYKpejenHpZvG1UA2aTLnj0=;
 b=fJqWXfgis+sfm/FmFl9g+1ND1mMrLW3SWCcqs7D6jSYgzf/FFEub0sPp+ReZSbjbyM
 UOLyyHfJFAQM7KpAOMxeT4yrPUUfUZJ/ZQkxZctBM+KuVKByIix0Xye0bGYW8mTzmISy
 gNsM6aYB1u3suxnoQEPrimKL+NtEnP5jr97tptu3Zcif1h7U9HlLhfauGZygWUoCN4Nx
 aTZSVgF4Z55pjAiBVhBhFnce+Q/ISgnhk4HPSY98kPqrLwr1kludRoSVqEH92YaRwtcj
 Tsj4fzSo+kn9wVxP8Bs5r6qdLIv/DRG9PRzU/bB4zf8vM6mBoqPtx/o2ax+KpUjmDtDB
 wNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306371; x=1722911171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xjo9tP3yEe4cBC1QG8qcYKpejenHpZvG1UA2aTLnj0=;
 b=INMKRPXLtIHWL85kirYRORXvclShvj04ZVJcx/AEa/vw3nzYMi/AXa+6OR6Yum6a+/
 K2CFS8P9sorKwbOROhL7A+x0XDl8Ia6sjkOuDQZKT/VQGzS4Za14hkcm3bS3/GgGS1mt
 QA/JKbQQcVqJeZjOhgIBroEHONevp8UdIUOmEqqcZvZqBsc9bVt4ulz1YAR6ccrZ7kAc
 su/KWH0zY6RWnWx2oVWkvuY9uqbQqwljq+zWixITMa1nodNDXP6nOTWDr92dpybpqm90
 75ri0+Hm5WbEpg8j+z9KbQGTH+Lu4EWLRgcItMXMc50dpIG4sMTsoYRbGr8SNGRHQ8kL
 n4YQ==
X-Gm-Message-State: AOJu0YypV6wVVaswB/8IJqnxfiqYYc4v+TtE5GvTBTXFNom/grMwbwYD
 U6xXWxZdZHLIBP37t3yrcBrsDo7pYKYb13fXSlvA3TXJXHcsQeGWZmfu+zeV6JOccqLPfoGto/f
 AN8E=
X-Google-Smtp-Source: AGHT+IEe4+S0MgzmNfCjCASGufeZErsxP3yqh31Ka/I3Flfx1FJlKbdUhJQNGAojb4TxN3J7NxCoSQ==
X-Received: by 2002:a05:6e02:b42:b0:382:3c83:6acb with SMTP id
 e9e14a558f8ab-39aec2dcf52mr108891715ab.8.1722301942009; 
 Mon, 29 Jul 2024 18:12:22 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabio D'Urso <fdurso@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 5/5] linux-user: open_self_stat: Implement num_threads
Date: Tue, 30 Jul 2024 11:12:02 +1000
Message-ID: <20240730011202.480829-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2d.google.com
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

From: Fabio D'Urso <fdurso@google.com>

The num_threads field reports the total number of threads in the
process. In QEMU, this is equal to the number of CPU instances.

Signed-off-by: Fabio D'Urso <fdurso@google.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20240619194109.248066-1-fdurso@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b8c278b91d..9d5415674d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8168,6 +8168,16 @@ static int open_self_stat(CPUArchState *cpu_env, int fd)
         } else if (i == 3) {
             /* ppid */
             g_string_printf(buf, FMT_pid " ", getppid());
+        } else if (i == 19) {
+            /* num_threads */
+            int cpus = 0;
+            WITH_RCU_READ_LOCK_GUARD() {
+                CPUState *cpu_iter;
+                CPU_FOREACH(cpu_iter) {
+                    cpus++;
+                }
+            }
+            g_string_printf(buf, "%d ", cpus);
         } else if (i == 21) {
             /* starttime */
             g_string_printf(buf, "%" PRIu64 " ", ts->start_boottime);
-- 
2.43.0


