Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTm-00018w-Vm; Thu, 06 Mar 2025 10:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDT1-00005o-10
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSz-0006Kp-7U
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so7159715e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276135; x=1741880935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tTLBFu22G8ChNwnUUuiiV0/VSwHr+qaXgLj/hapvjNA=;
 b=U1vgWMQxX69TlhsF4blk4qZwYqKIMTK6ekfzKEVov30ebnZF7s1VYz97Wl24wrgbTp
 az6wo0jkSTdeoJiLcGQfnSIA7/rDPZ4M9DXs/5qI6vGrTACtKcwixonkI0ncF5PMusPy
 KT7hr+IhYLp1fFSOCdVXNCN7jdq/suVBE/3GvwXtqI0hJFUVXEY8mzpv5qa6CuZmSAl8
 fMzTSrKc4zhRx4BmPUDjDJK95dqw/5H8EFj8vWu365+bf/Xc8llgiw7jI+BdnQ21Ze/j
 56yte3IG88UbDKOmDj1dIZBGwu6OrfdlKoAXT3h6vw/6iRf01NYEYWwVAcBoyRKsanUv
 5wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276135; x=1741880935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTLBFu22G8ChNwnUUuiiV0/VSwHr+qaXgLj/hapvjNA=;
 b=Q0MZXOtTi1g7c2iKzHQLfiDe8Pp9/Vx4XOklsuSVN/4Ai/zPpRwAxN3Z+0uLWoLCM2
 RB03qizs4Bfh0b0CmbOSqIg34lexdlmcvQDkRQJqp20HRvYO49LWEhyzBvVZKKLh5C5i
 vNWJ58Wqq4N8w4lERfyppljJ5TFrLtjbToq6Bt3x6TQJlD7UFLU0ACPtrc7iN7tkpEkG
 av7o9/rnJvEjZw+lVvLYU+5jG/oKIePBVxb4Dy0YJzcCcNjotDY6wWb8RQ4jIL9mBaiQ
 XRb3C3jmIAygfFx7KuYLsTGCnbHpuJiPqHunsB9ddlTVZec4WxwWW7m1YQeVdCIxBo4Z
 Wahg==
X-Gm-Message-State: AOJu0YyJlWH/cJHEsf1Qb/yqJI9IwKyyEf+TGRnD1k4IhvtD7psQstXx
 mHRI5/5n/YOsT0JC1iDpktvnOyMwB59YmKsiie4Xmb7PXTHbcuLZgyJpENfyaZ7xJ5V/TnS7kAf
 lYg8=
X-Gm-Gg: ASbGncuNAda6gcswniKTczeQyn5xvccgeI9gzqmnusbLAvP2cMQi4Fb2pqQWvM4en1L
 /6w/EyU04t3E25vWNnqW4aXc9D6BT31AG3Un8W4OtDefGE/gR92f0Y1RO+hqRJtyA0VAyDc+cbH
 vzalGRCTIZNp1EpRIdlVh2LXckSjd4lGHNEbdg5b5J1jJTvjIuZi75Ow+LuiRZdlIMWBDYAPW10
 ypgWDmUcemsfB0P00Y1AScP7AtHBABFE/eVnYRvr+iTIaXh3ewJP/qG+O56CD9EvM5ijR0BEWr5
 FHlCNLl1Pp4Hu4RnuAy5xNRbNWPAuOcCKJf8ir55yIw2pCz5zLa8vCWEEt97CJCwE+mRdhahzL0
 0VfY2T19npLODkBUarZU=
X-Google-Smtp-Source: AGHT+IFJr2jgtqTnLgcuDpOtP8ONwP4dgqyH2Y2WNPtLCuhBb2RVfdFnuVSOGidQ3T4uzOvqGKKVxQ==
X-Received: by 2002:a05:600c:4687:b0:439:8346:506b with SMTP id
 5b1f17b1804b1-43bd2ae56f5mr59372335e9.19.1741276135333; 
 Thu, 06 Mar 2025 07:48:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c01bsm54378555e9.2.2025.03.06.07.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/54] accel/tcg: Avoid using lock_user() in
 cpu_memory_rw_debug()
Date: Thu,  6 Mar 2025 16:46:59 +0100
Message-ID: <20250306154737.70886-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

We checked the page flags with page_get_flags(), so
locking the page is superfluous. Remove the lock_user()
calls and directly use g2h() in place.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250217130610.18313-5-philmd@linaro.org>
---
 cpu-target.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index b5230ce1837..3892ce12229 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -374,7 +374,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 {
     int flags;
     vaddr l, page;
-    void * p;
     uint8_t *buf = ptr;
     ssize_t written;
     int ret = -1;
@@ -393,13 +392,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         }
         if (is_write) {
             if (flags & PAGE_WRITE) {
-                /* XXX: this code should not depend on lock_user */
-                p = lock_user(VERIFY_WRITE, addr, l, 0);
-                if (!p) {
-                    goto out_close;
-                }
-                memcpy(p, buf, l);
-                unlock_user(p, addr, l);
+                memcpy(g2h(cpu, addr), buf, l);
             } else {
                 /* Bypass the host page protection using ptrace. */
                 if (fd == -1) {
@@ -424,13 +417,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                 }
             }
         } else if (flags & PAGE_READ) {
-            /* XXX: this code should not depend on lock_user */
-            p = lock_user(VERIFY_READ, addr, l, 1);
-            if (!p) {
-                goto out_close;
-            }
-            memcpy(buf, p, l);
-            unlock_user(p, addr, 0);
+            memcpy(buf, g2h(cpu, addr), l);
         } else {
             /* Bypass the host page protection using ptrace. */
             if (fd == -1) {
-- 
2.47.1


