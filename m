Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E6CC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKEA-0004VI-0v; Fri, 10 Jul 2026 19:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDq-0004IS-VV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDp-00032s-AG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-381216921aaso1704490a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724488; x=1784329288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3j6SDZoTLvq8C32dokLeUzdBUsM/y/njfPybJ8zfNIw=;
 b=EGbuCmUnVzntf/M/r2GulsnFuf6kd4WbLxhfW558y1Ye/FsnZMqMac5epNhkKILw4e
 DHcqsYZUCUf3NQ3qz0JrihZ2s0Ykp1z0F5+zEdJLB2aC9TK8qvAQ4s7DgP2SbEQ9FUlz
 AZUeCYK3bKln8ACBk/JEL81wcLzEmKVicssIxVCF/UooM+rxsIRvLHo5R6mNhZh3MzQ9
 CliVDeYH2UrxhjRUd/WJ6baS6KO7JDQcqYO9Jl3RK89Ww8S2UmiYjulnyCjlQWpH7w6W
 PTlP7rYGqO9wbYnuAJi2RKVg/JtCd4dutAOlT0NBOoHoqn9AfFpMJ74jB/RYsLF+Tf1I
 I9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724488; x=1784329288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3j6SDZoTLvq8C32dokLeUzdBUsM/y/njfPybJ8zfNIw=;
 b=Z74wSUb4KnWao5zyeE4HQZQJ2nPdlo/s6ScxeLiw+OcIb6J/6LwcCb+wL0b5bEAHmm
 HBB8ae3KvYv+9IRebslw35+zCKsv1Qmve68WagDW7CVmuDRRz1mcot+3J/6QetriKN95
 mogckmWZk2TZZ2QFlRdovfGtOPmT/savnNguOhKD0ZbIi+7fCvt7GHVjA4q7RMUntaBJ
 gFcZaNleNtG5BaHgW+8oUNIob5L7aw8yhYJCBEFZWfOHIiMqmDobcgxpzYbZf/XPBnWv
 E3oNhX2lGz/2nktPmhjabpU2ddM93QOBq/aLWKau5HlYbQONb1hLb3GF7gqlR35U7B27
 2unQ==
X-Gm-Message-State: AOJu0Yw2vxCCHPDHzqbN9HOEWQgXPPs/eIjV/bDB0XTz5sw4ifxPdJiM
 BR8azd5eA2tfUrmbSlO4TFtO2KJtgX693xSVQ74ML8Ecis7G4cSkUpurv42xNoUc4heVr2O+oeH
 1y+Ux
X-Gm-Gg: AfdE7cm8xEASnuYO6OgEhyQR9swm9tqSnwORK99CZTD26beU5CqknCJCJ1y8lLiBOQD
 tw4eHwOkC9tvt/COVAZpUx4NoLN4s1xet5hSO/e9BRe/SznXsQodOHy7VWkQiolWktj4vm6MwMY
 J2NOUi38ArCh7L6gBnmOI1BfFSJiDdTnFN6nfrS9dgxwA+1G8esd0PAGzVnetve1mGuLwkfTsPy
 UNrOCuhcLSQXkF1tEN8yotpbxvk1qg9Hru/qdDMNDDzGbAw3BACgnI2ZQS9o+YNBRgIXCJpbkdA
 GNOxnR8DBKANFxh0iica/l9SAgUw1o3CDu1McBEy8y1O52aKs1NTgfqugDCF1AFnCGaoTldhjR8
 Zasg/XzS90Ulk+wCPrdwDqFAX/7AGoT8Ke0FviokJtRWzSedz7OYmSwONdwm9WM/WeevUcNrPI2
 5hpR/lwtxHbZ+7TEcJbQ==
X-Received: by 2002:a17:90b:180a:b0:387:e0cb:c8db with SMTP id
 98e67ed59e1d1-38dc77998d2mr628215a91.36.1783724487834; 
 Fri, 10 Jul 2026 16:01:27 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PULL 13/13] common-user: Move guest_base,
 have_guest_base to probe-guest-base.c
Date: Fri, 10 Jul 2026 16:01:16 -0700
Message-ID: <20260710230116.900171-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Unify the definitions of guest_base and have_guest_base.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c                | 3 +--
 common-user/probe-guest-base.c | 4 ++++
 linux-user/main.c              | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 5277b4e099..694481ae3e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -63,8 +63,7 @@ intptr_t qemu_host_page_mask;
 
 static bool opt_one_insn_per_tb;
 static unsigned long opt_tb_size;
-uintptr_t guest_base;
-bool have_guest_base;
+
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.c
index 77722fe63f..6f1247cf1a 100644
--- a/common-user/probe-guest-base.c
+++ b/common-user/probe-guest-base.c
@@ -7,6 +7,7 @@
 #include "qemu/log.h"
 #include "user/guest-base.h"
 #include "user/mmap-min-addr.h"
+#include "user/guest-base.h"
 #include "user/guest-host.h"
 #include "user/probe-guest-base.h"
 #include "user/selfmap.h"
@@ -18,6 +19,9 @@
 #define MAP_FIXED_NOREPLACE  (MAP_FIXED | MAP_EXCL)
 #endif
 
+uintptr_t guest_base;
+bool have_guest_base;
+
 /**
  * pgb_try_mmap:
  * @addr: host start address
diff --git a/linux-user/main.c b/linux-user/main.c
index 01cf5bf079..60a695b7ca 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -79,8 +79,6 @@ static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
 static const char *seed_optarg;
-uintptr_t guest_base;
-bool have_guest_base;
 
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
-- 
2.43.0


