Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30889C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEcH-0000rL-Ub; Fri, 11 Jul 2025 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaEUA-00037d-Vw
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaEU9-0006ry-6z
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16492885e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752243139; x=1752847939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3m2xCBWgNTpSBtTlXSwY8EecH7DKne1tkTijcTygfo=;
 b=WpJMEqyER3IQ/dvEwb3T8pUdupy3stuZffdTdUKw6T3qK6Qc1jUSmMiIpLxN2vpugJ
 QJMpbDX6f2igroEjC1KnYovumcD8/BYINZm4fNYk8QxcXs4e8a+0lTjUpOfoqjKNrA5/
 DExJkjVaIewGk4ZrB7a/dVhnTyIysLsoMjNrmWzSYQiEYGUplOC6t5q+VYgaX3ZM3kUt
 E6MEM1z14sFpD2COr/EHS76yg31Kv0R3UFIA6v/nKcYaq0mh4op0yNUfUvVB6O7ZY0bK
 vone2mhH3ad0n3qXnC19vhBDIe8Auy8nUuYgabd3vlXxVV85mDjEj0eccBu4tmJpksvp
 k/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752243139; x=1752847939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3m2xCBWgNTpSBtTlXSwY8EecH7DKne1tkTijcTygfo=;
 b=JFnbvhRGxyPIdt7ywaGHI4Hp3KA4XCPAJwyfWuXwK7UuunkB6p9rWlPL3sEryiVEJM
 jpP9wB9gGV024gATLtOm+H1gfuMK8AhDN5WDb9bXjiadv13QRGIfW/jSmmI37DdG3ZGl
 xBXHVbTO3rN44rFlt0ZX5+FU/litk+PFO7/rBR4+8q/uEhSKyiXGcc23xRlPiJDR+kZd
 655c8W5ch2Vs01P4poYRO1HzKaE037D+Sm2o966vmWtKdO5nDN3d+u3ehKV/5Bj4K6Vm
 v8FMpvYwxDU3TDoCRjPy/CL3E9/uJx6+hwNxH5Ml6FN1cViQMF6Fx2cqFsAq8NDMeL+i
 LgGw==
X-Gm-Message-State: AOJu0Yw5COyIOExGhBKrnepsB/RARGk3CqcU6GIwBoHtBcZYlONtA6pE
 Ufb3j/A6iH/0eiHJ1tOAqGksrnS+G9Y2y2rWIE+HSBVDTKwPlYHwjomw+3e2RjObDddn/hZjucF
 NLbpO
X-Gm-Gg: ASbGnctiKiHVLQnkXg5XAV8rLu/ztHeHG0vKJ8MbOCCTgoBrFbRcfZrMrLBkgkxh3lv
 pr8yVbEUTCyOYUiry1bscme0UVHCtAH/1IYf60Outizu3JwVF6zV2/vcWI8sKWKKSugJ9m/qqP6
 nMGhzioILLYVrgdixl/yptzH1bkisOF9UkCzM4S9gZE5WGKbR3AFi6NssrGQh93on+lbiV+QNxu
 KJk203RMFJU/UGoOKE830GoxpHeFYDv7QlMQzZKT029HpKOQV4nF/nTcTC43Kw5JOGEaouf3cmf
 R+8pLgpSzfJCLU/gC3AijuCoJxF+E8yIEehkH9FyeFeRmLWASDZG3ewwWabQVPuVqeL4fjItqpZ
 ipCbaX6d+3eFEstRQ9hPDEmSZb+9d
X-Google-Smtp-Source: AGHT+IF5Tde4/rzITWMR7sAQQr08TzORxFtpCviXj9IsYmaWA6q1pR8QayZF42/ACNkQgm6uzrMnyw==
X-Received: by 2002:a05:600c:820a:b0:453:6183:c443 with SMTP id
 5b1f17b1804b1-454ec13beefmr30157175e9.5.1752243138909; 
 Fri, 11 Jul 2025 07:12:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1736sm4626944f8f.15.2025.07.11.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:12:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Use qemu_set_cloexec() to mark pidfd as FD_CLOEXEC
Date: Fri, 11 Jul 2025 15:12:17 +0100
Message-ID: <20250711141217.1429412-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In the linux-user do_fork() function we try to set the FD_CLOEXEC
flag on a pidfd like this:

    fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL) | FD_CLOEXEC);

This has two problems:
 (1) it doesn't check errors, which Coverity complains about
 (2) we use F_GETFL when we mean F_GETFD

Deal with both of these problems by using qemu_set_cloexec() instead.
That function will assert() if the fcntls fail, which is fine (we are
inside fork_start()/fork_end() so we know nothing can mess around
with our file descriptors here, and we just got this one from
pidfd_open()).

(As we are touching the if() statement here, we correct the
indentation.)

Coverity: CID 1508111
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c600d5ccc0e..b7ec9a4f363 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6743,10 +6743,9 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 int pid_child = ret;
                 pid_fd = pidfd_open(pid_child, 0);
                 if (pid_fd >= 0) {
-                        fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL)
-                                               | FD_CLOEXEC);
+                    qemu_set_cloexec(pid_fd);
                 } else {
-                        pid_fd = 0;
+                    pid_fd = 0;
                 }
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
-- 
2.43.0


