Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6F7C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tx-0002K4-AZ; Wed, 30 Apr 2025 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tn-0002Ck-R3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:00 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tm-0002fh-5c
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:59 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso8987a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025137; x=1746629937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyyYrSBpMjZGqDtX9J3tyJffb7EP1/gzXVNNR0hz1h4=;
 b=DY4qV67FHGjBW3GCzb7xdWBFz7WsNIXbZG0lK5fwCNbIC8i1PoX1Cd9AXlwxHG4Ap8
 ogkc4o/JdvxITol/Hzr5+RuJVXhBMiVF8hFYHtNNcasVpsTMsSmwoqbC8veLit2Drgxs
 OD8iWOBqTzRd5YJlgdwgwXy1eDY9coSjaOsx+QRTAEYyuKNwOGDkgNdlJqMzjbMkum8v
 igTvSaWWdweR66LlieVP2L3zHXuMDbVkZRHi+8ePAi+A5UOsU5SODmSfsiBWRZCuq+7t
 iEegzW4mzFDRD8N7ByQsXBjWAMAzysJ+HnvR3VZoFJy9Fsx2bkYPtRv/EijA0PYg3ze/
 pZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025137; x=1746629937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyyYrSBpMjZGqDtX9J3tyJffb7EP1/gzXVNNR0hz1h4=;
 b=S9UK2SujxvCeD1DpS7VVqYTAzso+ErjWyRhCSNYkcYz9uRgRDvW6mOlEiBba00a1LG
 WcwqV2YBnj/0UNBrk8RiLER4+nf52XkAwJwPJuZK96gQLvqUAY4OO8njUToSPGhXTyK8
 KJ2fkWTUctpCEJUfzVoNy7Qt3tH5MeiI51xsxTPOcc136SUxUavg8vMjJctgb+7KNEMi
 l0CUDVGNtpBTd7vvAwp+01Ny2B15+CjxOFmkZHk/CArg0YIE8HSC6UPC/pDjffs1I8GF
 KOcu5mVtzPdWlWdmehKkdKWA/CqMAwshoDnZ4dGXrjs32APoEXIHivKSw5SkjT5qTm9K
 h9yA==
X-Gm-Message-State: AOJu0YzDwY97cncX9s8iZlwPgee6e9h+Ta4MJSsZLJooV5yEQxLfaXBN
 YVNu5q1zxcPfjBSoQ7R5aD3G67hXtuHq8WZBMMGYDxzE00+8k9fUtHvNtCjsPjmG4vypqWcjJum
 U
X-Gm-Gg: ASbGnct8kk1xR5PeyORApV5oh7WCV6fBC3npfirRqrg2wCNnMaNIrf1djxT+uMFx9dV
 OECpHs+CQOzijBTb+5cwcVHcB6FGegFKH/1GCFt1gGnerMa1GnM+9gjKjRhUGOjX3h5fuFkBMnd
 NBZgoO7WAc50bvfATWtElY+7MlaovNY6OLUZFMyF5izVRyb2KRzEfLCgjs/jeoXHG/LTySSFe3L
 aJREDsI77CpZcuDL5Cm3nyn4kAWuhy8+y04tCqyRAHfMp7SWomFcLa67hr9YAuR+ECeDEsmDr7B
 +Qtson4oBU0S/8uE9wU6+eVT20Dy2AacxwuaRyd3
X-Google-Smtp-Source: AGHT+IEvk2/k61FiGJWqrBdSZmySJhG8AGUsfK2QYU6mePeCcDxMGSFr3zXKpTA2K1BLZ1Ge2SZ7Yg==
X-Received: by 2002:a17:90b:1346:b0:301:1c11:aa74 with SMTP id
 98e67ed59e1d1-30a333530c8mr5040805a91.28.1746025136746; 
 Wed, 30 Apr 2025 07:58:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/12] accel/hvf: add hvf_enabled() for common code
Date: Wed, 30 Apr 2025 07:58:32 -0700
Message-ID: <20250430145838.1790471-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Other accelerators define a CONFIG_{accel}_IS_POSSIBLE when
COMPILING_PER_TARGET is not defined, except hvf.

Without this change, target/arm/cpu.c can't find hvf_enabled.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h  | 14 +++++++++-----
 accel/hvf/hvf-stub.c  |  3 +++
 accel/hvf/meson.build |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 356fced63e3..1ee2a4177d9 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/hvf/hvf-stub.c b/accel/hvf/hvf-stub.c
new file mode 100644
index 00000000000..22e2f50c01d
--- /dev/null
+++ b/accel/hvf/hvf-stub.c
@@ -0,0 +1,3 @@
+#include "qemu/osdep.h"
+
+bool hvf_allowed;
diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..7745b94e50f 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -5,3 +5,4 @@ hvf_ss.add(files(
 ))
 
 specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
+common_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-- 
2.47.2


