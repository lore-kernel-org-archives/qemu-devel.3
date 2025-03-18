Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E5DC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZp-0004OD-Ga; Tue, 18 Mar 2025 17:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY4-0001KP-U9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY2-0000nv-TO
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:32 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so110623475ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333549; x=1742938349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggA+NUCTfLjXVXevEP+BP9AcTpKIsc/HWrtDpZAfGPk=;
 b=i9+G+XcieQMojHKfgz/du8WSsnxTFD17ucyC6jktM60tlnxaSNvN1RoPk2xDzOiXRL
 08ojcFeymfTFYCOm0kgk9EbJjOquFzlPzvXTrRPc/YfBFekCkNDqagxYqHg4i1ltBzsI
 xCyujkYeLK43evv2ek5eaTb8f+ptywFfNR2a1RmQiBtD3kckXrBOjrFDgXMQP0EDaIYA
 FNUAuZE5A8neE1M9JiNV08rlgIQhCAcuO8eWqqJ9p4xfahf24t6WgEJngt6Ju677YYpE
 r4HtceIsUnKc9Oataj6w0QaKpwAUwhz2seXcu9wnJf6ahfZDy7YIHSr1FWkTebBnEYrZ
 2uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333549; x=1742938349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggA+NUCTfLjXVXevEP+BP9AcTpKIsc/HWrtDpZAfGPk=;
 b=vIE5Ow/d9WeoeyAkxde1u8SKWbNk42TmDFiSPsVAEtCQlNHVSKJ2xmaFPMng4FprY8
 XHlpFTAEqdt155rTtdZc9a3UXEvlvZPUDFRgVLGGQbyCEShDr9POEom8P/aMRXOY6SYh
 V3rb3u1tZ3K/9rSnCXFgWocB4wHFQORCsSidhaJg1sDS/e4gHdvnY//179yxsQkwah7H
 9grCjYPFMGYaiyIMH40RHX0QO82mBTxPvaEjax8enodAtg7gKmWaKglhzPa4wedvHBgg
 Z1e0IfRur3n1InjnXXEsJyA6LJ+j7nnSVMJ91sRoasAFe235e54PN3KTr3WtnmLZD5wO
 9MEQ==
X-Gm-Message-State: AOJu0YzYZt4YyrKkWZvXbtBidsfOT+c3WxyCsr0xQcKneLAx8AvSc7L7
 MGjj9bfVndFaIQXSoP51S2/7cWGDBWLkEIt8QAWAG6OvjGpo5jXXyXa865YEBfNhvFTi8EDcPjJ
 D
X-Gm-Gg: ASbGncvI1lG2ErdzlB4fUcCESqCIeu+eGqiKl93vDx/GATI+Ax4OhudFk4dpz6ZKJRp
 1JkoPFAQs8mXsPzYL6/gYYTLbw0NcKfRZ750hWbqD3wHUDcUTNaZIfKpo3jfofVwVudM185TBUq
 ucyfGNVoeL19eXD4+PYMegZ67p4HLTJfyCuiAXRN/hkSuo4qAfCjyhmeJfcMR7kHjRawcJZ5Dkw
 /H3T7Ly5rgqSMbVBplx8w+Y/jCtd+VyKnpOYuH9iQzb0++maHYtuq/t6q6Z0ST/x+cIdb80H9xW
 l+u51hEMm1y0l89L9y6N1jJ+DL42Gq90PJonmF6MW+gSUJ/G7ZMKs1sIZoccaroOvvGITniwc1U
 g
X-Google-Smtp-Source: AGHT+IHX43KV4Qy86mkEgJ3MbC/4FcVXPfvLtRC5+5oYf5U51w83RLZIer4Zfzpa5wCxdxZHCsqWkw==
X-Received: by 2002:a05:6a21:68f:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-1fbece41f10mr336813637.31.1742333549169; 
 Tue, 18 Mar 2025 14:32:29 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 26/42] semihosting: Move user-only implementation
 out-of-line
Date: Tue, 18 Mar 2025 14:31:51 -0700
Message-ID: <20250318213209.2579218-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Avoid testing CONFIG_USER_ONLY in semihost.h.
The only function that's required is semihosting_enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/semihosting/semihost.h | 29 ++---------------------------
 semihosting/user.c             | 15 +++++++++++++++
 semihosting/meson.build        |  2 ++
 3 files changed, 19 insertions(+), 27 deletions(-)
 create mode 100644 semihosting/user.c

diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index 97d2a2ba99..b03e637578 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
     SEMIHOSTING_TARGET_GDB
 } SemihostingTarget;
 
-#ifdef CONFIG_USER_ONLY
-static inline bool semihosting_enabled(bool is_user)
-{
-    return true;
-}
-
-static inline SemihostingTarget semihosting_get_target(void)
-{
-    return SEMIHOSTING_TARGET_AUTO;
-}
-
-static inline const char *semihosting_get_arg(int i)
-{
-    return NULL;
-}
-
-static inline int semihosting_get_argc(void)
-{
-    return 0;
-}
-
-static inline const char *semihosting_get_cmdline(void)
-{
-    return NULL;
-}
-#else /* !CONFIG_USER_ONLY */
 /**
  * semihosting_enabled:
  * @is_user: true if guest code is in usermode (i.e. not privileged)
@@ -59,17 +33,18 @@ static inline const char *semihosting_get_cmdline(void)
  * Return true if guest code is allowed to make semihosting calls.
  */
 bool semihosting_enabled(bool is_user);
+
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
+
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *optstr);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
-#endif /* CONFIG_USER_ONLY */
 void qemu_semihosting_guestfd_init(void);
 
 #endif /* SEMIHOST_H */
diff --git a/semihosting/user.c b/semihosting/user.c
new file mode 100644
index 0000000000..9473729beb
--- /dev/null
+++ b/semihosting/user.c
@@ -0,0 +1,15 @@
+/*
+ * Semihosting for user emulation
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "semihosting/semihost.h"
+
+bool semihosting_enabled(bool is_user)
+{
+    return true;
+}
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 86f5004bed..ab67f87e4f 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -15,5 +15,7 @@ system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
   'stubs-system.c',
 ))
 
+user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
+
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.43.0


