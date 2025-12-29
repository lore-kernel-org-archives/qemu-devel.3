Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BE1D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 12:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaC8s-0001nx-Cs; Mon, 29 Dec 2025 07:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vaC8o-0001n6-2Y
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:14:26 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vaC8m-0006N4-IM
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:14:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so5980692f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767010462; x=1767615262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cg/K9VgvAilbScUceQqlUu9k42/HHS1nN7+wlJHCh24=;
 b=f+xhs5iVvbhhqaLuKDMo99xjz39twxOIIhO1viP6GMJYFI59cmeOD5lLJff9aAUjVF
 5Adwf49cI0iKY4RZek4Y8DWQ/rHPxPqIzfenFmhEL92t/LfuHZX4k9RQspKJ9Nu8vKpN
 Hq8lgDQbAyroRdiBD+kxkRGi0971fuUafoRRPIC+J2mWnTDLUMvBMJ0/n18dLhTJFf2w
 IsPV7M0HOhgTPUwmaaSyOH0aIJKCt9qFRQgJUXMy0RQ6/NWZGybLn0T5Dh21u1JHzX2K
 h9pTCgsvEAmBj6r5pbA++hDab6n1+v4+63L4GuTlURl8iyjWtZtlCKZU5fh5yhXWYmf5
 gDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767010462; x=1767615262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cg/K9VgvAilbScUceQqlUu9k42/HHS1nN7+wlJHCh24=;
 b=LMLRMZf3CtoGqkUzoJj4Br4tVbJgCVbmwfZNaVe3sA+pVsh8xZ0FsbXwAFP9Y/Vy9U
 rptxi7/0dIDKCQhtx9NsmWQPC3aq4CkJeZCwc38L9oAkOFgr7CAX7Jwmck/tLTJ6vpr6
 mIGUN8/jM32bG7bbZgyQmnBHQfcWXBWaSzwYZqiZOdJVIgivh3ji+PXctrBArMCZs8YM
 Dn6ZFkpAp2Hk1X6TqCf/NFqDespzzXCU9vxZmzF86JURfspiX6bOjuYABPu9VJbXhYBS
 JOEculPndPqk9biW3cBdXGCgpm30o5QP58GJLivGbGaYpW4Y//pKJUU65k5+aN4EqWtQ
 YuOw==
X-Gm-Message-State: AOJu0Yyc2AkO3o7yo9DD5eerSwoq2+f1jI+dhzSNPwntZndenJ9Xst9a
 W5f5aNX6f/wjC2UgcvUoc9qPEDHf5qCA9cNrezbOv3wwaWv/eGLFYbU7RxhDgQ==
X-Gm-Gg: AY/fxX6oJVR+L1jwDEMy6yL6NKyfF0a9yG3O/dGtItzicfDggpb2cq7dH3I9XEQ52QO
 Rnjt4rqRWM5Y6dFtoG1+tR2xSciFp4O6j6zdiiYqzgt2VUDB6oyuzZe0DgOga0XtYGQwwcALeRt
 WdcNnOMJ2THxxkhKQJR5jPSHmmPU3/Qo5Rl+dE41hdBrqPXB+V4KGr+8uLa6ErTgXtcDzjocC63
 BFJ55LS3YBhp1yyjSr+zS2ZR/0USnx8v7awjG/hEXpbZSpwAAFopNfvjr51nqXCMh3B/eR6V+lg
 QYmCJCJFpEKcqSk8kPcAU811BEAh8w0SxomIB1hf6PmBw2kQP0dbmNmzonZsdN1wVHoC1koAcoJ
 E9WEZ0Ix9/GBX+xkMxD4pvL5M/3aVeXHuN+clczpctNKfdsv1FUi42F3b+Er3kSPeh4+jLwbEBI
 luEmnn6XEfCYi0K4NwpQeBcxb/PCR9xQ==
X-Google-Smtp-Source: AGHT+IH1O3zw067NRlhFKANyTyQNai/slOBOmI3q3X0/OXTzFZrZHH/7T81mBXyobN3nmFfUPcXQGQ==
X-Received: by 2002:a05:6000:2305:b0:431:808:2d49 with SMTP id
 ffacd0b85a97d-4324e4c6fbfmr31716300f8f.8.1767010461924; 
 Mon, 29 Dec 2025 04:14:21 -0800 (PST)
Received: from tuf-gaming ([2a02:2f01:7704:5801:e5d:77de:1b20:9c8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm63542255f8f.10.2025.12.29.04.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 04:14:21 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH v3] linux-user: allow null `pathname` for statx()/fstatat()
Date: Mon, 29 Dec 2025 14:14:16 +0200
Message-ID: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since Linux 6.11, the path argument may be NULL.

Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
perform the appropiate syscall and let the host's kernel handle null `pathname`.

Changelog v3:

1. Don't call `lock_user_string()` when arg2 is NULL.

Changelog v2:

1. Removed cover letter

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 linux-user/syscall.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..ee7c34027e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12141,9 +12141,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             int dirfd = arg1;
             int flags = arg3;
 
-            p = lock_user_string(arg2);
-            if (p == NULL) {
-                return -TARGET_EFAULT;
+            p = NULL;
+            /* Since Linux 6.11, the path argument may be NULL */
+            if (arg2 != 0) {
+                p = lock_user_string(arg2);
+                if (p == NULL) {
+                    return -TARGET_EFAULT;
+                }
             }
 #if defined(__NR_statx)
             {
-- 
2.51.0


