Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F310C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tB4-0007lB-8r; Thu, 24 Apr 2025 05:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tB1-0007hd-M0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAz-0002aV-Uw
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso632822f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488044; x=1746092844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpP1t+c/p8hP7ejHigBr04Z1PrmkdyRF/VY/JGUgbiA=;
 b=TXhJZMWrg9aL+yPKuwJ8CiesM6zvynRcNG6zCgfbnVIsWHt5C5BowFhr/IOCm1TUZJ
 rCRBP0dkXqZNtKzpZM3f4PWF+aHmw4VeQOMK7DsIBIYN7YpKR4Z37s3+nrKXT1M6rzee
 pQ5g5bDUibwz5UFA+CI6owAMRczT45eChcbRGbm3uqBnC6KKhWfO/t4IfPUk368+Rm8U
 01B4SbVlZYF8fPLUnrXdPTHCmmVbfvyFlmz8AGo9CFdQWXII/f2WMx2AFFpDxeox3mHg
 CVNtCxV4u/OjeTJBsRwV6HiDzH6hrgHjVHmuHVA1HkeMGBoQtutRwrzWTnZJ85Tq7urL
 EHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488044; x=1746092844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpP1t+c/p8hP7ejHigBr04Z1PrmkdyRF/VY/JGUgbiA=;
 b=FSizbHB0YUZenES1oByXNshJ8RPVSwoRRAMT+urH4wvyJ6Zwg82vuhjL9b1zCm1Hi8
 4h9OlhJa3pCz/dS4oSQgMu05O8UAxTYA0E82vnyngLu3AwS1gq4gVPZyRItrkopE8FSR
 1KCnnD8tUHcnGUzghUaW+NWV5Uh3BrYB2ij6G7oMDg1VO45CmrV1Ac1QaU6ToB6NLjMA
 GKvjV+Vlwl9iqfXuo3EfigMwQTKUgdfhpMWTf4tBEySuDBiUywzl16Ekg0um8i0TV5EC
 eHLrLYdXt1pWS8GHxJjaJoJurNV1BKMnWauuNvTYCg8f+GNtKTpAmZd3p38XtFiEZrvC
 OXiQ==
X-Gm-Message-State: AOJu0YysWoSfy1/2Okg3AL0l60oUdbSYS0I6eC20+pVOuDIDGJSIjFPi
 3UaWhcHqkSymUUIJgAp9DXQ3UwgLXJ7lQ3l/Y9r3ga/vT5Txl1qcjblhW9/t66MxEakXP14aKGA
 Q
X-Gm-Gg: ASbGncurp4a+RKwEbcUAYGNbMTl9N5LMgw70adGBkLoTHoBHGnlgU6m13a/H6hEOav6
 4r4k+YF1n3Wv28k7K3n4ibDTpaAe1FfMLskhlQ7PnLSbZk7Q4TgEPcZ9yYOgVJz/N6vulZSIzM2
 l6bEaYZDaGJifOyDFy5z7xKgOXzhqugF2SjEPtc1p5NwwMJCPfveNZVvCzEisYqzCYiHvoS4YP9
 dhIeY9dvuuDgS2qIsw3/hkpXGmCMhr88MtqRxOSgDz5A+KOyuSTPqbuGrppqLBYB72DrmhzKLDl
 F/+4/2Xl08GDH0bf2B7HtMWue4i4SPqzlNi7EKthSqxZbdJoyDG2B4YdzVn9D+76PvkQ9TVYZ6i
 rp9kMR3kLgCuxq06quLh0
X-Google-Smtp-Source: AGHT+IFKQr4t6A4W4jdwFsLefyjO+dKSCcZxYWRgHYmQLSJScuOiQAOhdqQuKeRnAAYH1Op9XfugDg==
X-Received: by 2002:a5d:584b:0:b0:39c:1257:cd3e with SMTP id
 ffacd0b85a97d-3a06cfb293cmr1453015f8f.56.1745488043767; 
 Thu, 24 Apr 2025 02:47:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b8efsm14195305e9.6.2025.04.24.02.47.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/13] accel/tcg: Compile tb-maint.c twice
Date: Thu, 24 Apr 2025 11:46:46 +0200
Message-ID: <20250424094653.35932-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424011918.599958-16-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-hash.h   | 3 +--
 accel/tcg/tb-maint.c  | 2 --
 accel/tcg/meson.build | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 3bc5042d9d0..f7b159f04cb 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -20,8 +20,7 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
-#include "exec/cpu-defs.h"
-#include "exec/exec-all.h"
+#include "exec/vaddr.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "qemu/xxhash.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cf12a28eabf..512dae93bdf 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,10 +20,8 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
-#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 047afa49a28..3f7b127130b 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -8,6 +8,7 @@ tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
+  'tb-maint.c',
   'translator.c',
 ))
 if get_option('plugins')
@@ -21,7 +22,6 @@ tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
-  'tb-maint.c',
   'translate-all.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-- 
2.47.1


