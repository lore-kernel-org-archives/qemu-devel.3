Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AAAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSq-0001qx-Bv; Fri, 11 Jul 2025 13:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSo-0001qa-Kb
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:10 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSn-00033E-0f
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:10 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40a4de175a3so1253767b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254587; x=1752859387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7yoiT0H1cbWcezhhOOQ6JGPwf+lfIZ37AHWPBQOdyo=;
 b=YJf2Itm8WCT5tX02ZGpisVtQjRAJCwFIX6EoRyE7jZkgPGeaSlmJQ1IUA/q311/7CF
 LUnso58m8NC2xCAzDFyBffnjyJf71Ar/D3/in6NBKvDVCI1Z+5Qn/j4LJA4r8Cs5NohO
 0hdpuJocUUDxqnvBjHUs23esazN36yZUCNT3RS7P00zprGGYUoPSlpVc8sh82Z1HJMfV
 VRUFlTkhIFk2VqOovuYoJTzFYhyT2MGqTJkRNRfb44iNCE77sAVvyKSjbG+RNy+jyZ/u
 n/0hMLqUcjstRfEhGnZ0gtby6oR8R/pcn0dh1atsonrWCMvqGO4/xOv7u53qY62Vujdq
 +hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254587; x=1752859387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7yoiT0H1cbWcezhhOOQ6JGPwf+lfIZ37AHWPBQOdyo=;
 b=VZ0AfZ1BKP5e5SOo2KwXMcHwqzabuEKngvy/ZkT2zWT6RmxGDjnovjnFabsysWHP75
 H3NDxr0T1EDpa6CJ8HCYTt0JKxIP38l3DACoNrwWhlEOzUvLz8nnzVEW5GhEVXbtBXCP
 kARpd7oL/NNW3zh4jXlp2svZOQ4GTtfkwMM7zlTyhOEV0y+2fLK4RYjDyEk6ZpEradTw
 rKmdRJkrRjk2RSJWXoQ18BaAsXK1FkcKT/dlegjkgidLo8anf8mpwYLoiZPinjucFIn0
 vRqLt1KNMD9Idz1gjMCBpaiDRVQ2x5wtXtxhCxlfkskIFYw2D/nR+FHWZxtbM04E0Hps
 HRlA==
X-Gm-Message-State: AOJu0Yz52sFLI/F5EtUNRNt3HDBiWsNGqj5YKVixqJpGhOmwiEdqyvKZ
 Tfg5CbEoasEoD74JHT+LCflASc4B+vkgbYSA9LUNP5i1r9kfRlgw4EYe1E4GBYog3EUdslPLjif
 Iuhyuzfk=
X-Gm-Gg: ASbGnctiZmBEsBj3Uf1bxUfRQPBdf2B8+//6Qmcl8Op05cYZGyAFS5B97aqFmayf3zN
 HaHvLqEK6gkqFu5LPVuE9fcP9BSB9ZW5LuFdkl2UtmBdRq0gedeaQFzF1UQYi6okOqy0d9OIier
 v8ox+MWuGLPJWg/PeiSolMvKtGx7ozECwnlbinBSkfh6iS5jd/Anti8Syh6pf6I1uydxZYlTCWc
 nVlB2iGdtIFQQ6EdrhV5yfYJYONcUsn+2+6BfK7CC03ZxLWHz0eGDjRWb3u1xMsTVLQoujslfNe
 eXDUJxQEkjyTzTWYHTodRAZWIO+Vt1H17UUh1P7qoWo01szmWYCHRVXFYbhnMarQ744s+6zzjiM
 hDa1ELTXwtzurM0I1YGceUPGBmtROpzullVRG+essQzx58A1VqaHpNxoddhIngJzvsii4SNrs1T
 wjlIzqPwZL
X-Google-Smtp-Source: AGHT+IE8ATu6rvRtAq+VDKQptqyzFJFW9y8FvFg/GlYZ37hN/CgoUWYzo8rK2ZA8B2mFYanyq3XTtA==
X-Received: by 2002:a05:6808:1587:b0:40b:555b:9024 with SMTP id
 5614622812f47-4150e31d37amr3350526b6e.17.1752254587398; 
 Fri, 11 Jul 2025 10:23:07 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 9/9] linux-user: Use qemu_set_cloexec() to mark pidfd as
 FD_CLOEXEC
Date: Fri, 11 Jul 2025 11:22:54 -0600
Message-ID: <20250711172254.229201-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250711141217.1429412-1-peter.maydell@linaro.org>
---
 linux-user/syscall.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 38dd563166..91360a072c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6747,10 +6747,9 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
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


