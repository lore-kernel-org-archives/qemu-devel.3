Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D38FC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyp-00082D-5X; Sun, 02 Feb 2025 22:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyl-0007zy-Vi
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyk-0002fQ-5x
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so84940305ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552709; x=1739157509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ8koAp3lno99JhZwLI7fXS72dpOl8VJ910HFJ9faM0=;
 b=ztN2hvLRxbPbg1J5ywFfO6u3n66fz3EH/BfqBjLXltzehD9V3psy+0R4VEq+OE0w3G
 XOv22ktIM09VfzfEnZktRXpCYk1yp1FmuIRZ+cj49qvXiV5ViTE/z0mgJu6D0GEqQRju
 TGudgEjeWKpCcu/viGrFra3GhOf5CozB+GJonRAkksyLa02N81AvmtaaNK4C+N/ZBlfX
 u1E2+MNqg83HAumTKOeXeM8FFSIUqcSseCw6uzLJRatpok5qXTLSX9ZFBqelZu64f1Nn
 9VYuadvT7cGQAz9zm+G+N/S1OOb0H4+VC6gD6aLoREihMCr7DwPiDzrv9sg4kW86JXyR
 XO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552709; x=1739157509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ8koAp3lno99JhZwLI7fXS72dpOl8VJ910HFJ9faM0=;
 b=JaWFHlmD7rlS1XFMXpKwVOLRCEhnp3Gs3h3B8y6RhJbu2Usot8So/9D6+baLjB0B85
 BP5JbxYQj86YWDJLhEJCGYcnrWG3CHNllKq4P0W2BsAU/iw18b82JnhYdu7/N5iPmzZI
 gfHHzJSUjzlofn9tQzibJdj0wAPqFw6HXgzzR0gtNslaLyBPyJudAA1hZwxIeas/Wngv
 rX9R1pWmQ3/b0enhgGWV3hNE0kVTJg3bXXwSEBSrOpqOVXS5Udz2LEPrQRFnxQhNlg6E
 Esz3R/undYpsgVCYMHKkfhS2S7lbH+IQcH8KJK+f2vROop9lVHFofcz9lIRvlGsGLktb
 PQUg==
X-Gm-Message-State: AOJu0YyOA9kh/Qz5gUWPdgZBBEXSs5GY3CMa3FQWK8JDJ4tSz6AE/9xW
 16aep+wQ+uq2hXSQkNSgjI0tPzOzPmYBh7DX6a2r/Xl8RTaZyjzPzcL0qsGSDikGe+SM9h/I4e7
 X
X-Gm-Gg: ASbGncvC2bmShU+Iz5x6SpbE34fCf6ibq5RxrAqDMEC9qmRcRUl8DXqN0UPiU7RdXpP
 pmB5ON866267g9hMorRvy7g0yuWLCvAL/SZarAs6NiM7BGV6MeCSC+ar3P7mMWQp8AROr7mTGy2
 pXT+Tq00czr5gCzumb9dulI8QsYJ7oMU+0UP8ypIkBHhG8AP+xuQtvY5wsDyAehyxTudlrLNJyc
 88/WrJnCPuOaHMGihjk8WtX+CZGQXgmpBN8J5cfHm1G7anFFSCPHUlVG0ThICPPD+IUg0IIM2cD
 U0JAl0y3CxbROmm8PCbHBpcFJtKoXRyV0KG1MqTsMq0jJBA=
X-Google-Smtp-Source: AGHT+IHwf9cp3+t2xWKq9P92LcsAd5ZEPuO+jFTLjB8NDp/XH8TNdPiH7YNbD2isf2fynVf0th7r1A==
X-Received: by 2002:a17:903:240c:b0:21a:87e8:3891 with SMTP id
 d9443c01a7336-21edd7eba4fmr196981355ad.6.1738552708754; 
 Sun, 02 Feb 2025 19:18:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 07/14] accel/stubs: Expand stubs for TCG
Date: Sun,  2 Feb 2025 19:18:14 -0800
Message-ID: <20250203031821.741477-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Add tcg_allowed, qmp_x_query_jit, qmp_x_query_opcount.
These are referenced when CONFIG_TCG is enabled globally,
but not for a specific target.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/tcg-stub.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 7f4208fddf..9c2e2dc6e1 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -13,6 +13,18 @@
 #include "qemu/osdep.h"
 #include "exec/tb-flush.h"
 #include "exec/exec-all.h"
+#include "qapi/error.h"
+
+/*
+ * This file *ought* to be built once and linked only when required.
+ * However, it is built per-target, which means qemu/osdep.h has already
+ * undef'ed CONFIG_TCG, which hides the auto-generated declaration.
+ */
+#define CONFIG_TCG
+#include "qapi/qapi-commands-machine.h"
+
+
+const bool tcg_allowed = false;
 
 void tb_flush(CPUState *cpu)
 {
@@ -27,3 +39,15 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
 {
     g_assert_not_reached();
 }
+
+HumanReadableText *qmp_x_query_jit(Error **errp)
+{
+    error_setg(errp, "JIT information is only available with accel=tcg");
+    return NULL;
+}
+
+HumanReadableText *qmp_x_query_opcount(Error **errp)
+{
+    error_setg(errp, "Opcode count information is only available with accel=tcg");
+    return NULL;
+}
-- 
2.43.0


