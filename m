Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2F1E7AD60
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 15:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYnRV-0007er-42; Thu, 25 Dec 2025 10:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vYnRO-0007e2-6f
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 10:39:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vYnRM-0006R3-Q7
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 10:39:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-431048c4068so3705625f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766677187; x=1767281987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cd988AhuRCKRRkPEA9XFf/1v3WxvzRmU5HyC/shIZow=;
 b=M7ISf6Oaw1+z+KzhQPjgEdgAU7TDOdBG//c/NdQZM9yRKVGv9CZMWJ3vZLLt70UNEe
 sJSh1vA9MfHEkX+3mX3bYFI/iBMwI1HoOgyiO/jmvFyzJjI5dnDoXmaSdIKxY7oHcfAJ
 slLbUzdNh8nvIAO4FWLjg50Rdpf/MNaQLubPuM+RykG+JeRRBMCTRBAQffwoWYPZEBOH
 b3NvlXzJfF+Jc7Ly0NpEQhzoegd8Kdc/stXWCvjwLULwRChlka+w+kGwkFQO7EvXWIii
 T0Ygt1Cac7ZAoRXATGF4Ji/bh6wa/ZmnW2H/0ozGXRWj/tB3kIOpOIEaosxCtrj6Vewz
 aJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766677187; x=1767281987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd988AhuRCKRRkPEA9XFf/1v3WxvzRmU5HyC/shIZow=;
 b=NOHNkJMQ/KoixsuGeY8QwQW0nBSnhz3lqWJ0xtmXQHq4UtY3lV2LLzh4ck/cI1y1JB
 DPWWik9o0h7/IPsDYHNAfs+sAMkVlWBR83SspDnbk7Y4udJ9+lkYuIGlJVY2YsvdAk5t
 qOcCcQdYcWKPQa9T3ilqIjC6COSZRHftkRPBrpRyAJxWdimVBEpNLCcEnSWi4dxOXgZf
 O52jFVlJAVXRN0u8/GsyBkRdnSu0OsS//wE2qrE98FKz4qhFDnIuoREGQp9D/TrprZop
 kOandB36D3VonRpW++gnykEw7uEmfBhZaBD5KjfL9iPGTUGYrEbtPUznIEMvBcsvgYzy
 Zf8A==
X-Gm-Message-State: AOJu0Yxvv+ZidXFvAbBq6v2W45UPDe+i764GFU9hcg/RGoT1E/tjOQL9
 bPd+qm8GKu9wQ3xt0feHNG8Ksb4c98isW5jGzgROJFXC7mRv3sSUIgBrw1JARg==
X-Gm-Gg: AY/fxX4qwSYNOLbftyIYph2u3X2ngYJC9dRl0mpw8Qy8Ds5lMb1l+kCdoa14SjbBwFW
 +qp4PobUFLykC9qE7IUMy3uRxolPtuJK17BcoXeiO1t7GDbOR3coFp2Ar0I5D0n2ZKwQ/+Ym5hq
 UpapiQ7yirHs4gUKD6dLNPJNe3Tztc+JBz9yXxI+CRMvjamVaseN/tBpy84LaYJ5CwoKCjA+o3n
 8VtUwK3iLdQMU7UMo6YsCgnBezl0CjtjPlSWp9VlrHrNGvtq7V50mrDP23WtxDwnK+4aNm/81Sx
 lrI8OFMwYTRe2asyzLhqE89lyrPTlWWtZEZPg6I57vrST2Ab/nPjJIbmj7WA/KTFhk7BbuNhSMQ
 jacET1ueWXWqcAd/fiuIlxsWnKkgBofdW2YaGlNBYX51bnrlS846NVyfwCgNxgwQ7S2PJISHkIJ
 PxeGuhVWRvw8YcMm7xOJ741ygUoytpKGs=
X-Google-Smtp-Source: AGHT+IEswH4pZpQaRWMx94ZRLGei3mRrb3OBeUnZikHDQgwYdEWeud5HJtMWkw4yXB4mX42vJuro+w==
X-Received: by 2002:a05:6000:2586:b0:430:fdc8:8bd6 with SMTP id
 ffacd0b85a97d-4324e437897mr24524522f8f.31.1766677186700; 
 Thu, 25 Dec 2025 07:39:46 -0800 (PST)
Received: from tuf-gaming ([2a02:2f01:750c:5d01:e184:593a:9ad7:8300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm39936177f8f.33.2025.12.25.07.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 07:39:46 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH v2] linux-user: allow null `pathname` for statx()/fstatat()
Date: Thu, 25 Dec 2025 17:39:32 +0200
Message-ID: <20251225153932.1906919-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wr1-x429.google.com
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

Since Linux 6.11, statx() and fstatat() syscalls accept a null `pathname`.

Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
perform the appropiate syscall and let the host's kernel handle null `pathname`.

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..e1b61f6dc5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12142,7 +12142,8 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             int flags = arg3;
 
             p = lock_user_string(arg2);
-            if (p == NULL) {
+            /* Since Linux 6.11, the path argument may be NULL */
+            if (arg2 != 0 && p == NULL) {
                 return -TARGET_EFAULT;
             }
 #if defined(__NR_statx)
-- 
2.51.0


