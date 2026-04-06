Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A16F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVk-000365-KW; Mon, 06 Apr 2026 11:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVj-00035I-5Y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVh-00044d-3N
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso18038475ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487904; x=1776092704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=j7WRKtqd5ezM+S+5gy9o3UQJrnGefN3IGD2vt0wEIZ4ya/ZBhdzbPT07fPaCPvhg9p
 U0qmnjiuNBpFSUa6cr9gXb/jnZf0AAf8KVvVqvJmdDqO2YRDpGqdt045mh5bR2zQKKsI
 jULwvjeAZO15PRtoIUUehVjrybmBhx6AQbhjDvFF6f8Zae+ThF8okJsQfYWRxa9DiipW
 mTdpDjFj/wr86miZu4l/Rsop0kbRxsQ0arlhuIO+mitt9rpxphl67xdulnIM9NvDYJvm
 TWkUU7+v7UkI3g3du6U55mpggwXVWAKYXHTitBJ5F+CtsE16CPZUD6O/UNj6Dx2aQcjH
 09sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487904; x=1776092704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVeSwZbNgMxucNnmt+bVJO+rTB1zblJZsZHbFuDjPLk=;
 b=EvZQEz5tkgradjnTVMTSkQMS9B1qg6HQlyxl9GFaffPKHAZFLrFrYbztDAzUA/9/uc
 QFf0r6ih6SpKWvXj96iPRTgqjWsDZZRrgOIP/2a9T35gHHU41l5pZ09NTfvvtoKEsbGM
 R0B24LGXTpQSaHYSHhms2e8tFjQw9x0/UDUDfzcLbXtlBAfX1xk+GE5CT5mEmr4OTMna
 A0VMF+jP6E8mnCQgIavrBbY19odcXkxQvBZzX8v13hUlNe7CvzCZLaMiE0nR1xdzaKaM
 liOIvdgw8vTjbozfGRg/6dGFnL6eXNkbgqpmJWH2hXsFOXjO89Edj/EDludPuJdhlj/8
 wHtw==
X-Gm-Message-State: AOJu0Yzvzgfmrr029CLbdTFbN8kJp3Fmb4VBVGIx495HJYC+lZk/SxFA
 s/2qdazytfOvfjyuIPfQxdSgBmfgWQyKH6xs0ld5IyYJMVJGyCZ71HTDYUwgnIEYtri2RnRuB7r
 H5cKDMpnoCA==
X-Gm-Gg: AeBDieuoM6GT/U+DFRofxyz0/NRWxuJ7mUO3boGu1LCt4N0fgYxUnzdBUrt6jHE3dCY
 VGbtXkdVeQLHCVjg2ToVRprT/awilc+Gob9L95so/6H3m4N/Lgk35w8+G2NQRT5ZNfjkuyzkAJH
 fofxjkh/1NIj3tzGu27M1iwWvFReXFhA5+TtPZWZY3Hj85/2x7DKWcWozBbqQu6wr/rWhCYvlvS
 QPfQcjnRQL5MkYAlr8vd7PLuQAn7fRiXLj6knd1pYXBQA9OacefNxjPe198IX3Vrnof8QvwfDgS
 L9Yz7kLr2aCywUb5gN5AWog2ornb5NJsHR4CO/mXo7maGUZWsUaC1CqUIyZcoOUO8ijNGwM+ZEg
 c0SHxsPOBkHbgGWupJ/qdOXVjFGjyM+1/spd7M9r2m+ku2WQSiYOfFBJ7esf4ZYESxi+tUFiTmn
 WUy5oQKsbWB809flTj3qni5KnHV/bURJLCQsZbWE9AHTnWfO7D01z/hs+MSBBepGybpPLnj/p7Y
 pNH
X-Received: by 2002:a17:903:b45:b0:2b2:54c1:2067 with SMTP id
 d9443c01a7336-2b2816f3dd3mr130959255ad.21.1775487903556; 
 Mon, 06 Apr 2026 08:05:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 10/14] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 08:04:30 -0700
Message-ID: <20260406150434.407201-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa26670587..0740de92c1a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


