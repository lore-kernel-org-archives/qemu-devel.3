Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1EFC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLa-0005S2-5x; Thu, 01 May 2025 02:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKz-0005AE-TX
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKx-000734-BU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so626552b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080638; x=1746685438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=CztqShK+5zYdGKb7sOkqe/c2WUZTnLf6s2Zj4ghjr7/2CObdUceIAwivmsJyrt2t9F
 4jregcpBVOHlRVRns15nuuWjI2ep+k9xFgMgFXRoJ1JYw1eX0T6nWDt3iC6L1fqTNxHX
 pbitIdslwaKWgCpCeHVesmAiOu9WzUtPq5R1Ek72KDBANdBxfH9hOfMJ6F7oWrshAS55
 KLFr3fvU5H6czXWbqufmn6X/z+nC0l1kmkuzocXYPv+VxoUZQVo2EHfCNx1mtzL4PFJR
 5iJXWPdVI/GWkVzzxiip08GMaCzBhDZ1EKlpwqhWTnxtEYcb9d5GkoAN/MIzI6StOfUx
 koOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080638; x=1746685438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=VQGDTjrjXRFyMBRZRrVs8bYRpS10iBKxIwrL7i3w4NMLxV+4rXtN8XPiSf/cOp7xqT
 vUsWTQUaQ+oo4tzH8/F8bsX2SYvpL4X79LwVWPzzM5HbNo4fKCHWM2cD8Bwl7LWhGh56
 ZKA84BM2T1bHJS1HPK3UqvPVpeGjc7vTtGXikOIhQMKD/K+yTf7ONFbGa6h642fURHrD
 Gm2fvKw1OJNw/VEb2cXWv8Mg5l2kBYtdPTtDVbDsmgNriPonM/4A4uVZ4nUWtocw89h/
 jlK36qHLwEJ8B1ZUvqub9EB7YeWFsOi1h5emEzXc/J6OYthWYKROwlW4u7OtieoUzmqp
 Zhrg==
X-Gm-Message-State: AOJu0YxI8PHGpgqzaV9SDpOFkkDlYUPD883GVllXFLbe5Gt/T5yZkSKa
 OZqoRu6vzKCeWxelXcO2f9IW82A4BDsLBoOjMI2H+jpMHO5JSEzmB6Wbv7dK0wQ9pk0WEatI0WG
 H
X-Gm-Gg: ASbGnctoTsXBnjqtNykw4LV5yUXUhP7WVdT8/4fSTW1mnGxaStp4+jC+41649xYgugY
 FfoQUuvAzcXYp51HRqGDu/5iW3XG+Mbjlr2hTVQkr8fDVTWb5wmqA2Z8NMtkFaOODZ5YpuivaMB
 0u/H43Pk6zc8cLnU+bAVGmKowC3Rkv6XITwiA0a0NSmJKUAO74kf+UuziGaH2w9CVDzHBVZyP03
 XhErYZSKys7/85o+jl54DCg0p2/QeVgNxE6l2qrl9g6WLT39rt0bMm/dg2Ga9eS2oaLdBSVdumm
 BHpip43+GtnkUzn/r7b6MXvkJg8PBPfLgEv0j8jO
X-Google-Smtp-Source: AGHT+IH6J99jOhsc8o7g3sHqxpYwWEy99wbbi+relVHRPmsGkWpcQW3abDuw0wKNrlva7C0fJ5MztQ==
X-Received: by 2002:a05:6a20:d046:b0:1f5:520d:fb93 with SMTP id
 adf61e73a8af0-20bd6f4545cmr1904279637.24.1746080637671; 
 Wed, 30 Apr 2025 23:23:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/33] accel/hvf: add hvf_enabled() for common code
Date: Wed, 30 Apr 2025 23:23:18 -0700
Message-ID: <20250501062344.2526061-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h  | 14 +++++++++-----
 accel/hvf/hvf-stub.c  |  5 +++++
 accel/hvf/meson.build |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)
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
index 00000000000..7f8eaa59099
--- /dev/null
+++ b/accel/hvf/hvf-stub.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
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


