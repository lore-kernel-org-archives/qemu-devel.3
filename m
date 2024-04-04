Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCFCCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWA6-00020e-NP; Thu, 04 Apr 2024 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA0-0001zB-6l
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:20 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsW9y-0007hY-Kv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:19 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so1215898a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271976; x=1712876776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXNxunD293g232TU+51MeWlmAuFekT13Nuf8XRAYogk=;
 b=HpWJWpyn4CEi2u0dNTxi9/1T2eWS6noOOcqiuzyazY7s+Ed5VkRll7a1ZNfuW04S/A
 1OvQm7fWsa8zJBy7mZvFeAd0KmJcDicmq0CIKA2P7ydSEb+OGCJlDYBnb3u2SyYcQCaI
 53qNUcfjTgREoM0YBFbf81ICS646sdU8pVCwpLvWPdmjQREqnYBaPRNVqT1WWGjMDWns
 i+AIKP6/6x+mFnFX8lFTcwcZQFgIuz4JJsEjcycVx5gRzGSD2whic9HNV6IzsLuqOSSl
 rf0l5KFYI7X2hLX6YQpV7OC0oMkLFdDChIOLK53xRuEpDROtCkie1l0cjhO/JwOTnwp3
 Y0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271976; x=1712876776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXNxunD293g232TU+51MeWlmAuFekT13Nuf8XRAYogk=;
 b=kvRQC4cbjw/FuESg4+NTKiSchB3mBXg1V/hOB/c+etljCnJp9wtcLrEqW+UPVUla1Q
 2gEfAdJTmyOttYh95CeeoI2FxcJfLHSAgCW7H75T3X/eYRyXMy9m4ePpgMW6HLXWzXlJ
 rW/6wW7gyqJg9gW09vK1MBng6QnE7A5vctbrLnwgS2nYwe7yz94zTh2bHbD3Z8OysD4Q
 a3EluezyQBzLZM2n4g9neEFbAlTlYqn3tnnbZRAjUmsFZyJ0+yPt9TgoHLi1MTW7Z8+A
 WV0Sj72rRLhDEG+V4kze0/CGRV4Y5qzxKSyCxa6MfvnidQdyHKuKbYuYpr0RuK9BhH5X
 HvdQ==
X-Gm-Message-State: AOJu0YypN0kAFgC9aGEcgGavNMJEbJrsIWFLLeRMYC1FPOgxrnE15bT7
 z2FgZRJIAKngijJVQIfnpfcSNQy4VZXKKox9Xjlhq1d0h8oArP9jnm00/rzT0O0BLEhX8sMLREG
 j
X-Google-Smtp-Source: AGHT+IFMQZBfYtsuvomkEmHzSmCJ9ifTtCIAbnUpvjivP38hqgVG4NxCivtOYzTdu18PDaM7r1/FVA==
X-Received: by 2002:a17:90b:f18:b0:2a2:bc68:2897 with SMTP id
 br24-20020a17090b0f1800b002a2bc682897mr3640872pjb.44.1712271976328; 
 Thu, 04 Apr 2024 16:06:16 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 02/21] tcg: Make tcg/helper-info.h self-contained
Date: Thu,  4 Apr 2024 13:05:52 -1000
Message-Id: <20240404230611.21231-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Move MAX_CALL_IARGS from tcg.h and include for
the define of TCG_TARGET_REG_BITS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 3 +++
 include/tcg/tcg.h         | 2 --
 tcg/tci.c                 | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 7c27d6164a..909fe73afa 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -12,6 +12,9 @@
 #ifdef CONFIG_TCG_INTERPRETER
 #include <ffi.h>
 #endif
+#include "tcg-target-reg-bits.h"
+
+#define MAX_CALL_IARGS  7
 
 /*
  * Describe the calling convention of a given argument type.
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 05a1912f8a..e4c598428d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -39,8 +39,6 @@
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
 
-#define MAX_CALL_IARGS  7
-
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 39adcb7d82..3afb223528 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
+#include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
 #include <ffi.h>
 
-- 
2.34.1


