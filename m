Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF51C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7W-0003G2-FH; Thu, 15 Feb 2024 01:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7T-0003Cl-Fc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7R-0005cs-PN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso4502535ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978072; x=1708582872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=FFVbwpqQ0IeZ/QNmDAsgitY8l2ck6762cD5sSFyvDLX/UssGgnDZcxrSfmz7CVGyIJ
 mjx2X/ef30VrZyHSbCxdopbWxIbbP/6VrJc7MJzmy2zxDli3IfRFOqhNQ/7wCyGgTpwF
 lUPHqkicMPqMCQ5Ad5RWJdBQPO/a0L0o3IFNc13Rc1IMCcjmOGM777xx0Lx+JruuVACv
 c/7duZ0gLXWUvj8/d++Cz4r2PUrRL7AWGV0u6ET0tW0qb/uayzZ8uBY0VojojGeU/TNe
 LpK3DGsP+NCLfR+zBN7sUlcBd1vXITriOyPvKqWWHuHGmuaZaHv5lvl6LMERri/4oJbB
 So4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978072; x=1708582872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=IozPfgDiMC9J2zRYO67u1vlxsI3b6vHmxSrDrrFFhpTUpa4VxHC/ejLjE73N34uUvA
 i7153d3eVgVKzy5Oaz2gbdsso+7soI9fUmrgb0F2tAVA1Df3jmb2mkAo9rSFxEzd5RF1
 3wL9YWML6XWxuQoHLff2VDdpuBoFUZwBMTffgoMeSNYOfis2QwXd4kIPSVF/E4fSSqdm
 cQcxJCjLedKqO7yHy9YLqYW5MfmfHlLwadykpGrnF4FlJfuXHJIrpLvv4UShLZ9CANdt
 yvhZXSa4cmnfPqFdv+2NDsBWx+9Ys03qdTtSr41uEEe75qxTHl6/r07HzCj1IBAB1+rI
 bCRA==
X-Gm-Message-State: AOJu0YzV2hFY/+lUoNXvwEBrNDSu9XkF8yvoq9WQHpjxse1X7ZMZbmLP
 k5r2MEunZZbfQ4avCb5Ii8oVQjQ+f07BisfpqupGXImSsBeQ2pb/tr65OBdl8cfsszyQAs5V3J9
 y
X-Google-Smtp-Source: AGHT+IGwtOFsP6+Q1s7TXiBuCA+KR2UgBUPh5YUS1UxwLoP+yP34JoqblbPw8FghDVVo6mtMYDMxdw==
X-Received: by 2002:a17:902:b609:b0:1d7:2e86:fb2a with SMTP id
 b9-20020a170902b60900b001d72e86fb2amr891899pls.65.1707978072391; 
 Wed, 14 Feb 2024 22:21:12 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 35/36] target/alpha: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Wed, 14 Feb 2024 20:20:17 -1000
Message-Id: <20240215062018.795056-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


