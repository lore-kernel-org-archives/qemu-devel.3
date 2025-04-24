Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F82C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837o-0008Gi-Pm; Thu, 24 Apr 2025 16:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837m-0008G2-Q7
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837l-00050b-3R
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so11020145e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526283; x=1746131083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpP1t+c/p8hP7ejHigBr04Z1PrmkdyRF/VY/JGUgbiA=;
 b=WS1iRCYyoHmD7TgCDsqT/lYhtI3SYJL6SAEv5xzdlYZFL4KLqDfV9sX17SZoMIgbLf
 0FiKRQpx7l5LvaD57qcz2jsxzHWWh62q91bL40oHBh/kJ46H/M8Qc78+BHcQJdRZMSAW
 g4UtuMo0d0FCFTDGks2jbyVplFBTZDRNgYShAlCpS8j6xAIMYKtAl/PlLtzHpDNKpTM1
 5nvrWrDXgAyk+Xybp5tFgvJPlc2/aO0cBr4gMCCyRrpysAxT+P3CDzKC0i9T9u/KRxd5
 +RNEXws1XWCpkJJ1DIwq+oU/FfPR3qscIdHRPkbql+K8QJtN5PyMD+TeJqolOcB431tw
 4vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526283; x=1746131083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpP1t+c/p8hP7ejHigBr04Z1PrmkdyRF/VY/JGUgbiA=;
 b=ICHtn469jR8hCfKleI/r6Uy1CCm91rBb4opxdtL3uHNB5+zEm+Y5hZeoLtHAPk725a
 Eu4VjcL5k58d5/MdeFPjAoNa/J7FbtCorZ+F6RM9Huk6D+8fKDViDI9+7wU4idcjziei
 GujXmYdA45rPIoTZJSKMn5lBcfyiIptoL7FNWaZISFLSn204JvJtAr/2BATpqX/EtS+S
 DnvDhThGPsRz7C5iobnUwIBtGEMaVGqOflDYxJZzVe4EorkwhZYGYO79vKXDFfnUnG/X
 +FLB/tqW3BmPE0KFaNf8a4KFj98i6Pu8QYOJsSp4oNqKHa54wSB5puDEdaj2a0bnOuMw
 QY9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ9rEu8RdDZiJ9/V8pM/TYoo9LkWisGIsxbQOeipoPM1fTWKZBdb4FRegeOs/t7BhRFBKo2e/yu6oL@nongnu.org
X-Gm-Message-State: AOJu0Yy9DesKxzDf2qxssa7pzDnaz+ts/rQW2nlLsLZxfAiGsDly0baN
 7LPlG1s7aG8PjUcYpKqARFE6kYFshFAqD44sUOvNIQ79tGXqbhsni/EqQ3O/n7M=
X-Gm-Gg: ASbGncuAA1U94EYZRwzlJ8nvWxwe4OHjaFFg10otgw2GVL4LC71QTk9oOeSIoD2Qbe8
 Dp0pcB3yUSJYtUbVSvJPDpi1zxdS4zZrDspP6VhUITL3zoKWqPkrOMqs4wXOZfyYOVjH/HWsmZo
 A+NeBGw0h/ORGiHmOoocgJca8ktJvFVhi0DNrNC25EqHyVrwerPanq/v2e8ngQAp6fHqeYz29jh
 ermr1dt438MhoYHH2GRVYKujYl/8dxZpRdSL/PCLXOGn84u8w87g9y4bbv32RUggKwGvPLOAz3X
 nubQ6ijVyEsULFDY39z/zSud62O1jn0ALa0kA5az5lsArszuhzpLniD6Eu6tOIepSbmIg8IDHjG
 ZvaQ3PS9+wN/uX+4=
X-Google-Smtp-Source: AGHT+IFksOZ1X3gMhfuqc3ZVQYq+gihIYnx/zFDLGMP3wABFAnP0I0F1HqwV16rqT/8iS/cyoAZJyQ==
X-Received: by 2002:a05:600c:1e0e:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-440a311437dmr7725745e9.18.1745526283381; 
 Thu, 24 Apr 2025 13:24:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a531072csm809155e9.18.2025.04.24.13.24.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/13] accel/tcg: Compile tb-maint.c twice
Date: Thu, 24 Apr 2025 22:24:05 +0200
Message-ID: <20250424202412.91612-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


