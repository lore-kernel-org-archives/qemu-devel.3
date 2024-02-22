Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD99C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvi-0000Q4-Dy; Thu, 22 Feb 2024 15:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvg-00008Z-Rc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:28 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvf-0002qm-3u
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:28 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so77017a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634665; x=1709239465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=aapvMTa08l9dR6SGmYHP3k3nF1Jf7GTaTyZQI4KhzOYnjMQv1983H2ENRgrDL5wYDD
 lgSGkxCgLyW3qooo//o4xCb7Zkpm9fm0fdk5ITUx9OS9EPst87rsXXZ3ZRAGiRYuIp7h
 e+Jdjp7gv+51tnOZcbr96eAzV2EXRik61XXyyMYhqLZqidiDbznfWeSOvw+BCKcPUkzW
 pbuZIUlmdtF+SxI/HA1vwwUFVEgidvyIEinzwiAtmgQoiTdanBaxFyAM3G5Pn9NCPu/b
 ZTPCRrgm55BQW/jYJAC3JcrDeoBqF2TKNkV/e8ZGAZRFBJCAiVoGdI88XHFGGrGF4gfI
 7FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634665; x=1709239465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=sjlbrruH3o+1wRpcU41imEqBF5aJjfepTMjKyz0EZoFC1cb3aBiIlXRZb5AUSg8rWb
 BTfJxWe8XczitLkUg5JGoL+6w863QcEAf6xsi0NtBR/rlNu2hc8sWrMuKiM4O+QqP6gT
 rpSZCHI/cWID1SqJ1gzk8NfYH2FjgQGRLlnx/YL8jpV3FbAmHMuKFK9fmqgTHEBhVMFI
 jNm0icW89ngo7NlqQZ0P9Hu6wcZadcTeU096SAWD/q5rK4TqoEq+573S+YBbJUF1Nq7J
 L1rI0XJXS/2ohpbq1rG+5TvozhPYr0JRed8OnHubHXMv3Ip+4TBrAS5nzl7eaiKKTVN+
 7OxA==
X-Gm-Message-State: AOJu0YwpTmW/K8fOSeAhEP78puNF9/d5JhTmNzFrf9zXdJi9bTGFaKj1
 L6WA4nFaoP7nSTsEPBaXEwBKG6q26lR3Hup8i/sSR8DttjVcjggLO+EYzm2I49ylqmuHAbP+cQp
 Q
X-Google-Smtp-Source: AGHT+IGtk8U1oBd9J2hNINjlM3l+J+lqFhSsY3Q2lflLXPqzceAc/B1PsZTo/7Lifj7hZJAlFhQftw==
X-Received: by 2002:a17:902:a3c3:b0:1dc:1ff5:3dfe with SMTP id
 q3-20020a170902a3c300b001dc1ff53dfemr7073216plb.27.1708634664745; 
 Thu, 22 Feb 2024 12:44:24 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 38/39] target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Thu, 22 Feb 2024 10:43:22 -1000
Message-Id: <20240222204323.268539-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since alpha binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-34-richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 68c46f7998..c969cb016b 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -9,10 +9,22 @@
 #define ALPHA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
-#define TARGET_PAGE_BITS 13
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
-#define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+
+#ifdef CONFIG_USER_ONLY
+/*
+ * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
+ * but since any variance means guests cannot assume a fixed value, allow
+ * a 4k minimum to match x86 host, which can minimize emulation issues.
+ */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_VIRT_ADDR_SPACE_BITS  63
+#else
+# define TARGET_PAGE_BITS 13
+# define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+#endif
 
 #endif
-- 
2.34.1


