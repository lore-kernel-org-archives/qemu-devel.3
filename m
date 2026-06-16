Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD5FCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDr-0005hH-1O; Tue, 16 Jun 2026 17:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDi-0005cC-0B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:20 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDg-0007Ru-HO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36b8e1760ccso3142155a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644875; x=1782249675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nnUc8dYVHT+sykoVpT7Jh5Z6Yg/95z1qsRa+JMWz3c=;
 b=A7PjO9KIj+QwCDs+2vy2aoaIQbCJPvAPJTdE8J+oMwoIl/+GIhnqLBUxAuLQUSUFcw
 +WoSPe544blv2cEN9eCxUrFIPnnKCLKZHrEjEo8NPWCoAsqXhCIpphaS1n1lu4dqax30
 x7N2MVZ+BPfTutsBxO4/8M03KuKBHnmgZRI7jGUrULCQ4KWXTgzYywKvEL1k5fE/pMvT
 N60bdTbAqDyh5bxMrPDfddAWHjScw4TGnqTdoRjwZmz09Y7d0trSplJ3Y1xv2ptLDnjw
 dTGAevcH/l+I3/O+Z87wnRgfNB+dabEDSblVNqFLVQ3Lb4GXvGL+v7AW/E7qe8ay4Hde
 3HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644875; x=1782249675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0nnUc8dYVHT+sykoVpT7Jh5Z6Yg/95z1qsRa+JMWz3c=;
 b=oDmNG1E2Fbi0ZrOQZ91NPrA60+POJf7ow/Tu0Jmeoi3GvLAun4/VJ6pOUVhX/O7L8H
 YOxNzlMBiRRqmamKBOxByxFv2v/eVUOxCZ85QxCSgoQzInntMwUH/fB8oTSjwdRPR5y8
 tvEarWgscorOojyEfVa6hK+kQ+/K+pi9FZvGTCfx8Go86ttjPAI3nCD9cSFMjHod3gkL
 tCi1MX84sB52I+k1xOdM4FS/PuN6Yvu8wCt1ty4cPSQPk8AgPGya5XSH2dGvJphrfBfq
 zkhEWJrR7SM/Js25MgLTILtYtF82YZlLcYJzgZspftSjVtl+9nyaRSmtftqEIXgbxE/I
 yxPg==
X-Gm-Message-State: AOJu0YzH8wEGkmQvrbcIo9iKr4OVOo/DZD1us5tdWVgP0knVAT2rzv2s
 ixjra4EaRJ2UCfWlgf6015ZxJi38JfhWGvLvjdMwN5pAdMFUTymx1gogmG3NGOn2yNtN4qm5PcX
 s+uQj
X-Gm-Gg: Acq92OHKS0B6NsDIYbT0uw/eemBYy2PyteiPqMewYJwoqQtHZKRZbGJ4aXNVI/shq6c
 qLNPr/ZffLoUyKBH/oD9HzZtGSLw2R3B5W/C3DwRyFz4ashB3fYUbk6d3i7lUwSEBj8UlRDV5rt
 tByLqUGf2YKi7/B5TfWwZ4Qd0BI6KQ6HZFFU1PpsSFjW4AJCOGEHCNvR1f5++jRFN/P+YLZflYJ
 veoW2hPJo1gnlzcKO+/p295hEtIH4tpca5KoEZ4SQXZgG6GGqTA3O6RoWF1M8t37CCTkNYaLUmY
 jqGy4etdifTVdEnBghsDrzk9v4LbNXexIjXW8lf+1K1dTNdnInp43SbgXFLqkDz6b5WTy5AWXCn
 YGTF99RtF/dtWahJ6FsJoqPgONlbOgYUJwh0gmVRgYh1p23dtwuF04FkLpojWMsop8h9Hv/f9Qy
 41h7UcJr2ERrVr/Phs9fhIg4bDxrMjN+kJjqfrtmck4ya2ap7YCvaZwp+PH3wW
X-Received: by 2002:a17:90b:4d81:b0:36b:bb66:fbd0 with SMTP id
 98e67ed59e1d1-37c92ea98f5mr986647a91.4.1781644875132; 
 Tue, 16 Jun 2026 14:21:15 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 13/13] common-user: Move guest_base,
 have_guest_base to probe-guest-base.c
Date: Tue, 16 Jun 2026 14:20:54 -0700
Message-ID: <20260616212055.334466-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c                | 3 +--
 common-user/probe-guest-base.c | 4 ++++
 linux-user/main.c              | 2 --
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 772a26199b..3201da2318 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -62,8 +62,7 @@ intptr_t qemu_host_page_mask;
 
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


