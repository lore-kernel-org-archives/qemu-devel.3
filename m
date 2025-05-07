Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C51C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPh-0008Hm-MQ; Wed, 07 May 2025 19:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPd-00088W-8R
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPa-0002Rn-RA
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e4d235811so6440145ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661369; x=1747266169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=CBsJ3j+2QyuNivehi+xB9P43lk8g5PotT8KJAxCgXTh8AguqIx5InrLLJxgzLr+Pa3
 5Hk/4Uq87RZ1DQHhRmrg81ByYnKEam/uQawAdbGBfUxFT+dsdJfEQUpsWj9HvuRayzEr
 9ZsPHjcDHTTgLuJwJo6MnwWM4Nhm0dYs3qw2N/s6Pe37kRW6IZZAuFtRO4nvsIRhrffQ
 WNAeGMQtMVGI14hRY9WQECw1OIPABOuSATsWZomUueDYyZdee119V8nPYaKnnNA95p+P
 AX/po2M7UOFH5PD277F9WxO5NKlh+1TDd9ygdG3jCNvZU6QQqRSjIf1lA/CqCKkn2Iln
 Pltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661369; x=1747266169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=oJAN6QGSu8zztvdmSXPytkfvmozAR1LxsoVJiFNWV6jRM7IfjKVZHtEqG/0mWoc4qN
 kr+OUUOU192uc6nDVgF3Flw8YrI07WB2uodsW3VQVEplZsIwzI05F/AsYW50/LxhQE1v
 1sRYpZkvTiL/5YAs0BSx2oJPv5XZ8QtABdpSvyNMTYMAEETyQ2VpRzJ1Yiw34JXZEFi8
 B9zWjs3RZqsQuYrMsIeVfN0tXvys76e7T+DfYiXIfIRTsgKF/6s2eQPwmtNi9UzLFBTC
 /iY4MwzBkOzec8rwLlTyVMClbe4pFb1sN+4LkdL/26nWChrae4GtRLLmdjpZ2vG3bTXR
 tqzw==
X-Gm-Message-State: AOJu0Ywu2OFox2uAj5llP6Lbt/xubHNDePjojkBSZmccV6kfQDSRnmjL
 W6aIHIvWOp2+M6eLx7F9th9WaiZqj0CkRKOenSa+DxJ3SXZYdkE7Ez8gq41GpgU/d+2Dw8Nki+J
 sKzY5rQ==
X-Gm-Gg: ASbGnctVt94hvcJp/7ssxHaBEYyxEBg4kfz/T3snpPgaQZy9G490JUZGufVFwT1mfBi
 09p/q2w+5zs0WPcWhRkihDRKXPBoBUJ7Nw29J+jEkBFTd5wZWc1rf7HFxhTAvkN/AHVGMvLPBYl
 +s8IsS/nc+kr8YTNrnEPLAyPmgAFAh8CmyI89T26Gnsyp3tvybRxLR7nkUYNR+uMicvvowd9PIi
 Z1F3gbRLtvXIiEp37lDltZxippDT80Nv171ONApQETM62NCC3Y94nBD5XlGXfNntS9pdnEdHQ76
 atOHa2yrRbUmCWW2/KmcCoY36njESlBcEphDNm2M
X-Google-Smtp-Source: AGHT+IHHvc0EvNKRFKpNtmu7GMOzbaEWqTdnUSZ8fl16d0tlW8oALJDg56XL2EyLWt0yNIiyINpabA==
X-Received: by 2002:a17:903:fab:b0:227:e709:f71 with SMTP id
 d9443c01a7336-22e8660497fmr17618375ad.29.1746661369557; 
 Wed, 07 May 2025 16:42:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 07/49] accel/hvf: add hvf_enabled() for common code
Date: Wed,  7 May 2025 16:41:58 -0700
Message-ID: <20250507234241.957746-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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


