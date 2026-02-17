Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3168AE68158
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkW-0002mW-Cv; Tue, 17 Feb 2026 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkJ-0002Tb-Sb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:59 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkF-00065b-IN
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aad1bb5058so41040205ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321879; x=1771926679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KONI0odzEjpnPZwDGvH1YlLeEVQ/Hz1dcJSr9A9Azdc=;
 b=QXAKPlqxYDX74hIN8KP3z2yb8c7mY+hq6k5XVc89SfgmJdWIPY6/UcToKr6PtcqxWv
 AVgOnirOOrgl5wBRxDMLdBCst0zyBDAIxLmKFi6RT6YimRenyV4sV8Q3/X165moLXQ0T
 i49NOgZ6c55oOt9HdgwoWQfUdcx7JWU5nL6esU1LW2qB+/SN/S3PVr7drQetCMWQS8up
 RuKqqIbc/KJBvlAiDipL43XMALqVDXvLekdLrp/+YmHVFkHQQXGTEK5gdJIEwPzEXpFn
 CFLidU2vwB6jYL/jUkxKL3DZHPOqzmsUwiUxBNXdYuLizGEEwFDzndU8AbJJkvELO60y
 /05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321879; x=1771926679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KONI0odzEjpnPZwDGvH1YlLeEVQ/Hz1dcJSr9A9Azdc=;
 b=tlcEpn0sE4pkFulJELJPFMzWbxZf7+tVY+Y/7/+kTdFzJrRsOQVOkyrTY3dr/aRGxn
 gD+UaeFRG8P0z0Kle3ksns6ZG/mAK+SFwTKihInIp1+3aaN5rcHX7TWcjdJcpL2X1GWP
 /PICeV+YDjLXw2lquad9KCEg4Zv+VcT1XPYK2PG+haIy1wu2LCkVVQLweh/0KyrwuEmz
 1QoHsFr3Cmwtdj8QPcI/8PE6cAKW9vq5M6BeIoCOOJv6dPN+q7EF0VZbIaSlwXMZ+c1w
 6JQ+sOm6bnrh7SHWLhKRj3SKqz5oXAr1ZzkLPndouZbZHX3ujXzlvxuYdpp+nKrs5GC9
 TD7w==
X-Gm-Message-State: AOJu0YzZr501EX4GqKCHok8g8Hl4z2fiIU2pMbJIjXNHtrmlpHtzusX3
 qlxNeCdEKMNEbaBeHxVaxQBQSPTy6QQ2iYt/XsC6v/wm1dmcyZf/xRHl28kCA+4t7Y0HuoUpfv9
 73jO5+ik=
X-Gm-Gg: AZuq6aLVu7l2EsctO9tPbqd16C3+MLt00RVvT3YsH3cAMbCPhGfd4r50w+OJf571PyH
 dsWpWt5AjCFJ9RsdQ/2qYiJWz/PRxuMRF4gbOD2/rV8uAchAedeYEREQJNXFXGkBW1EMUv69mQB
 JjOL129l2ajgyVuf4N5WP5TSJ8YV7mSB6HECPujdxwGOAz7lmrWtkl0n9KV1cLgmxQYhcYfQYSI
 uAKjGMAs7IziRgJ423VTxC7h9Rngx0o8jK/IfIk5GsOJV9IXtkTFgql0acxI3PUs8vITrG+K293
 3hdRr8BVEDTip42WmsDEKc1UKfagDKFSUY5UzEZHzUk7Ad3BudX/kTRWfHEWl5xfirfwJKDJi+B
 t2yzdZDxrL9e3DOUCke7UzozFoHJ62L9XfMHKAxvK4xrrCaHUKywTU3ZKLTo+gFF/IY2MfDh90R
 4qdAjaFOtJiiy44PbTGItIyc54PIoFJQUy+o+iQLrFPQ/dOOFR0lmaavqgAHSqmj33gG5OLyj9E
 mAKW4zwU+px/5dQhr4E3JyPEk5Avj+nqnj6QQw=
X-Received: by 2002:a17:902:d4ce:b0:2aa:ecec:a442 with SMTP id
 d9443c01a7336-2ab505b7ccbmr149742125ad.40.1771321879451; 
 Tue, 17 Feb 2026 01:51:19 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 3/7] target-info: Move TARGET_PAGE_BITS sanity check
Date: Tue, 17 Feb 2026 19:51:02 +1000
Message-ID: <20260217095106.598486-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Move the check from page-vary-target.c to target-info-stub.c,
in the process of removing page-vary-target.c entirely.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 page-vary-target.c | 4 ----
 target-info-stub.c | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/page-vary-target.c b/page-vary-target.c
index ab92da4539..7c0565dd8d 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,10 +23,6 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
-#ifndef TARGET_PAGE_BITS_VARY
-QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
-#endif
-
 #ifndef CONFIG_USER_ONLY
 #include "exec/tlb-flags.h"
 
diff --git a/target-info-stub.c b/target-info-stub.c
index 896f16e582..f5896a7262 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -11,11 +11,17 @@
 #include "qemu/target-info-impl.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
+#include "exec/page-vary.h"
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
+/* Validate target page size, if invariant. */
+#ifndef TARGET_PAGE_BITS_VARY
+QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
+#endif
+
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
-- 
2.43.0


