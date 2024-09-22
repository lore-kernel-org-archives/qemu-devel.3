Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D141CF9C6D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHi-0001of-9B; Sun, 22 Sep 2024 08:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHR-0000xI-V7
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0002PY-I6
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:32 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso524943466b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006488; x=1727611288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0GCsI0EDoM1CVrc+ZccJKN3YAmnYpejqGvIr2IIOTw=;
 b=YQoFbmHSghLOCl9sRU/n7vIVTx5falY5orQHSTFb7Yu8uoWqQQcGt6tAmB30vr6vo9
 o8smi4m9tJAZd7/6xi/jIuZMVquxjRuMcBLXsu3wqIibok9J1tzZXBBYgYG5TvRU2GEX
 1RVQ680Ti/etBHY0rB/wPImRL4IzKioK2I3g+EdfVNi3V4WBqSnE0zXanSDrhBxPlS+5
 mxjcR+7GVPL6R3fFXFlZOMnXJfIZ0x124NgefT+xwUwIfEtuDSD7cDbePpJIhCHgfL6z
 0CO7UsK3gyryU99WLLtweLdo/41CbrrOSzMtBBRHaCVgQGkieF201fmjlHQDzf9flD9t
 BjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006488; x=1727611288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0GCsI0EDoM1CVrc+ZccJKN3YAmnYpejqGvIr2IIOTw=;
 b=fSVgtDSXqVXxbQkDqBwBwi3/zjaGzHurxoTD7J59qcYtpHJcybcQIHgfKfnPfSMW71
 5WK0Lh4AGBpi44XFlaS5Dbw85X+B7Wtkss5StOcGrLEKTVSE2jAn89/KIjgDcWbkSEJG
 bGzfWyiI8OCCBz9un/dbdU4thorGOtFbfPwC0Q/5zNZzuFbtDeYWPvEfNKJBBTzaIL1d
 i7ugxk+yKLJG3lRwkTBaCF9vsaYaHD2pzmoEpZ52P34ywJMAKe1OBVwi+/oRnQMTksN3
 I/9pXRj8bDAWs9FO8TbR1jznejlHIxGn4VrQmxix+beIHAoOlwElHKig60ggg9Rgbuc/
 pnHQ==
X-Gm-Message-State: AOJu0Yxm7NpZV8rqf0VfD4rix1UvBe5LP0bzFzWRcleYLNBadxjCK11Z
 MeqBp9V0JjKoasKpGIKuDb3Xj8TEyr53UbF/pLCrdBhVQj96Tv612bM5txVnvYBPqpqhm9K4TNZ
 Npt4=
X-Google-Smtp-Source: AGHT+IFr5cbHNt0ReH0ULDdKtaOF2N/YFlJUsKRAe/g1Rel1Ps3kE0N2VFkz/wVZq1qOx9wec03J1Q==
X-Received: by 2002:a17:907:1c19:b0:a8a:86f8:4eed with SMTP id
 a640c23a62f3a-a90d4fbc65cmr873145166b.10.1727006487962; 
 Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 24/31] linux-user,
 mips: update syscall-args-o32.c.inc to Linux v6.10
Date: Sun, 22 Sep 2024 14:01:05 +0200
Message-ID: <20240922120112.5067-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

From: Laurent Vivier <laurent@vivier.eu>

Updated running scripts/update-mips-syscall-args.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20240918074256.720617-3-laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/syscall-args-o32.c.inc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
index a6a2c5c566..780c0a8a49 100644
--- a/linux-user/mips/syscall-args-o32.c.inc
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -441,3 +441,23 @@
     [ 440] = 5, /* process_madvise */
     [ 441] = 6, /* epoll_pwait2 */
     [ 442] = 5, /* mount_setattr */
+    [ 443] = 4, /* quotactl_fd */
+    [ 444] = 3, /* landlock_create_ruleset */
+    [ 445] = 4, /* landlock_add_rule */
+    [ 446] = 2, /* landlock_restrict_self */
+    [ 447] = 1, /* memfd_secret */
+    [ 448] = 2, /* process_mrelease */
+    [ 449] = 5, /* futex_waitv */
+    [ 450] = 4, /* set_mempolicy_home_node */
+    [ 451] = 4, /* cachestat */
+    [ 452] = 4, /* fchmodat2 */
+    [ 453] = 3, /* map_shadow_stack */
+    [ 454] = 4, /* futex_wake */
+    [ 455] = 6, /* futex_wait */
+    [ 456] = 4, /* futex_requeue */
+    [ 457] = 4, /* statmount */
+    [ 458] = 4, /* listmount */
+    [ 459] = 4, /* lsm_get_self_attr */
+    [ 460] = 4, /* lsm_set_self_attr */
+    [ 461] = 3, /* lsm_list_modules */
+    [ 462] = 3, /* mseal */
-- 
2.43.0


