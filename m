Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505A2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlM-0004od-Ie; Sat, 30 Aug 2025 11:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bY-0004VS-Js
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bV-0003em-TE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7722e0ca299so859909b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506592; x=1757111392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8tFEvO+ZoPBCLNHGonW69VnjHHVqS7I0HfatvFevHQ=;
 b=g1BS7kwKVo6P+wV+DH5Ky+pLSVuJPYyifM39CFZScF2Ephz7hFkN5wG8j8sK/Isb0F
 7ZtGX2s9cOnxPOcJC91qE6J2VhraOYlClkFzIlBvNwe/lmQdTx4ZTTzttzZ0NpVKctsP
 5uq4xxQwDUna74x3iFeM/yf+GgYcrzFt1RcJ4Dm37skqneuKYTu+oqwAjn+rIK5obNHB
 Gxgepruki2NVS4PX0fnwKQcpZ9ZmfFc16ZwQW/+6bgF5hBVVev54sp1Gw42fvN9+ANx0
 d/5myRhoOJVkd3cM2oQwELdJkjup6upYPPZbgOUvRuwdUOzD8Gj9YUlrAsYQuOAPalH2
 axmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506592; x=1757111392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8tFEvO+ZoPBCLNHGonW69VnjHHVqS7I0HfatvFevHQ=;
 b=F963b+PVpfzxQtmwaxPNG886OVFqAPUVwaihVASkLpNPoy99jvvhm5SCA/7PFDeg9S
 DHWYzeCOUfexodOvPKUdjpbULrkWAFMnbkyYq9NPU47eDEanC27F/x//6FY9UmmeU1f8
 O6m03kK0AQFn5sIWh2yJtSVc6HxQq4HQvToniaQKP5ReGVGNzqatd4SPCs4Y3DT2vsge
 IMEWDjKp7N28flT7GAb6Hx07zZNNDO3vxtt9R9Wscn6DI6yP+Bv1ikYLY0pxKymehH8Z
 qFCSkUdpQJ/abbSDegEHlSyHCDcaksPIo6rvJpNrMmyuC6lnnBUqJqHGOpfcscYxpyQI
 ibfA==
X-Gm-Message-State: AOJu0YwYuG+Bm/0wQtAOaTaRRkiej5bssG/pqZWiuHo6+8h9uJuKw5ZY
 rQWVapCHPShZu57qFCU+ODdS9eosURnqkum9r/pe3PvPbuPYZpLM9cgtGJe5W7z62kous1hPoy2
 IznbhS34=
X-Gm-Gg: ASbGncsXhpo8VIEe5b+FDiCMYsvs0DvQuNYZVPgqlRKuOdAew0qTg3M4DIMWx4NUMjc
 ItptVTRPwlH9BF1rjrfT5+mbi4dy1F+CuB0IJYmEpQ5xiO3T+YdA5uZN8n9gfDwZuRbTNaBLobV
 DhNjqsfN/kiJoabiMnt+/Bmqx42tjmwz3kbXs6FDbUby8YQXV0mzMBDXti+HMZSRtEdF1Ols9B8
 x+vC8ybbZGhx4Hq8WBWFylzz2E2wChp2gz7+ohHS0Q0nqCJAXiKPGu/MVZKTRaGzMmAC08acuY+
 Zyj+A/SRaQ7X6scIerJpzM02EkXzvaq53siuzmZ0fkpSeBquPZZT7kqAQKM0MJMEkhdJ2MBeYah
 ywjeYQt0+OFVCOBWwo3rPDgT2TJiUxNHKtH7AjEMiF20xN9XmAx5jUKiN/QuBO6NLf/1Ki7oc0V
 pXSb4rrQJ/
X-Google-Smtp-Source: AGHT+IH8wlKqXSGb5ZQPZk+vvoapDAb4ZHvfdVVQPdPxGYeE4KjdlYOGeKAYG0/KuxWnib2kdqRVSA==
X-Received: by 2002:a05:6a20:12ce:b0:243:9587:a774 with SMTP id
 adf61e73a8af0-243d6f7ef50mr290905637.28.1756506592154; 
 Fri, 29 Aug 2025 15:29:52 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 57/91] linux-user/sh4: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:53 +1000
Message-ID: <20250829222427.289668-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Move target_pt_regs to target_ptrace.h.
Convert to abi_foo types.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_ptrace.h  | 18 ++++++++++++++++++
 linux-user/sh4/target_syscall.h | 11 -----------
 2 files changed, 18 insertions(+), 11 deletions(-)
 create mode 100644 linux-user/sh4/target_ptrace.h

diff --git a/linux-user/sh4/target_ptrace.h b/linux-user/sh4/target_ptrace.h
new file mode 100644
index 0000000000..b80218526b
--- /dev/null
+++ b/linux-user/sh4/target_ptrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef SH4_TARGET_PTRACE_H
+#define SH4_TARGET_PTRACE_H
+
+/* See arch/sh/include/uapi/asm/ptrace_32.h. */
+struct target_pt_regs {
+    abi_ulong regs[16];
+    abi_ulong pc;
+    abi_ulong pr;
+    abi_ulong sr;
+    abi_ulong gbr;
+    abi_ulong mach;
+    abi_ulong macl;
+    abi_long tra;
+};
+
+#endif /* SH4_TARGET_PTRACE_H */
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 148398855d..2f3557742d 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef SH4_TARGET_SYSCALL_H
 #define SH4_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-        unsigned long regs[16];
-        unsigned long pc;
-        unsigned long pr;
-        unsigned long sr;
-        unsigned long gbr;
-        unsigned long mach;
-        unsigned long macl;
-        long tra;
-};
-
 #define UNAME_MACHINE "sh4"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-- 
2.43.0


