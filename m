Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08F6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkdk-0003dY-83; Wed, 20 May 2026 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdj-0003az-DP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdf-0003Os-QD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso68526805e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297802; x=1779902602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfLMAKm0cFQ1CO5b899F9cGVNdd+gP0hQK4cGU9J1eo=;
 b=YTK/Ix1CfxEEKIRiY0W9xHr9vujf7+wt7gnRY4I1lnGmfeMqlwDzffOmSV8jBmYkvO
 6ubdXexlFlyhAd/95FqJ/WlcjXTiOCi3U6HeYg4WXKyOZoi8KgZCYjlK8rDWJAtjZb9K
 Yde9tfK3YjfOaPmHoggsyfTtRIc6nc5XM6bqnmsVsei2rWy7o8Kk0G32IXX37hbxg8M+
 PIC4nwrJCdwP78gGJMNbcUs8rkP9daUEVgSJwNbrXSMqCsKw2N+9S0M3ouORx/PHA5/u
 TH1z6Z2Gy4tx75HHVLRzowYNty4BWo0VQ1nplQ/nivZVseQI40roXGkxQtMkyZf49WAN
 ik5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297802; x=1779902602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfLMAKm0cFQ1CO5b899F9cGVNdd+gP0hQK4cGU9J1eo=;
 b=MZgamFyBBuvUZxIvejWd5FxBe/Q/5aWocJRwg1OzJM8DFZTwtjMBbR2m6c1XuKJkYq
 IIwqNX47hroaDGpZ9eRMjn8h9pVtg4TuVbSZjoKVyZ0RdiABWnlT07q1g2qUljKq8Z34
 yYTMRmqKpRc1Vx8HUauR4cVc0/YCte6EBue0DsGsL8D8NMwBg7AtzWqMysUGS1+J3Kph
 pa5GmmyqgzOgme+wiiRRDOMnuNV79u8fr+q7ORb3mcljRzznCKimBqNiihZlFK9NMGgp
 BBFX85heGMJ12fY4BzDD2piUS+N+D023SSL+mLA/4k4YemwOnoZhvi2OHbrzUihmpBK0
 NAow==
X-Gm-Message-State: AOJu0Ywy9tQK9L3OMkt+gSPmqdJq+EYt+ks8dwMN6J77QQBqPG14Z0Fg
 MhIDkNlfXcl76pNsiXmLcZO4Q2h8P3e1Qc2DpxfxJ17F6x49Uv6F6wmQr834RcmM2UtD5AijD2T
 6kWBXkG8=
X-Gm-Gg: Acq92OHLnApo3BzWLX+bekow9GG9dz2kDz2Y/L42iqJ4acpmfgsZnJl3Jf1lCoF1ctO
 tscegm58Ow6kqNzHqSUTuamX6ZZFIWhGChcvsPz9AJ9OZ+rIlpgIt0DFZLJNwxmf//z6gCj75BX
 yg/U8+5M4uB04yzndMEqtP5y4ef+ujQuTqYr0VqmusQSMtp5JvG20orD1VEDpxeYiHxdQ20JYbu
 9whGNGam9miquPNPElAzS3/9C1yHBwiqbQbN19GEg1klKq2EGxak3DanvbEwJkgv/ZFwtxxAPVI
 WpS6d2vKDW0snceeWDTVW0QUS+5dy6sz/KwiHo2MZT3GFGc67d+rFMaZ4998Rx5uDcR4hIt/OR+
 /jma2YOSRE7HWDoJfhr9y0inai1+AkMQThKLyxphVPXby7RU+zpi1QAuXt22DVwOYkk94KWqYmf
 GI4YEHnyDwT+gNtV2KYskWh0+ILvCjk8NjvMB4cXm9z+6wxVZtlMuqCnECKMQezRG4CgMMVfrqv
 ODsZ5R9w9U=
X-Received: by 2002:a05:600c:3104:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-48fe651b2a9mr366137255e9.28.1779297802178; 
 Wed, 20 May 2026 10:23:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13b4sm55961400f8f.28.2026.05.20.10.23.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 01/24] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
Date: Wed, 20 May 2026 19:22:49 +0200
Message-ID: <20260520172313.23777-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7c..3f36c1695a5 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b6..20ea7c6ab9b 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2d4a8aa182b..5a8e00337a0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6630,6 +6630,19 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    switch (cmd) {
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12110,6 +12123,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);
-- 
2.53.0


