Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E69C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC571-0006I7-OM; Mon, 05 May 2025 19:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56u-0006Az-Jr
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:32 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56r-0003W8-DN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af28bc68846so4709982a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487227; x=1747092027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=oLTdqNPkbUQFNlA5c0DWuSievCjjsSA70yutx+9C27ocpT6UCmL0DA1gUEJRtHwfOY
 Yh418Mlft+GmIorBkBHO3PUdidod/W7Tpy+2miTi5mYrf2wtZ8gyi3gt9jUsgOcDON18
 4XOzrW3vIL4rK6ZeU6ziUZP5m20UKL98ivNaX8pshgWamRtGjvnjC9IR2/JP8Xu8mP+f
 KEuzl7u0yBJUhtxGAtlNySYmbtC3cipRyXApdJAPn0cXdvjF9XLdEW2W+A7ZV1zViHGx
 XE4sLZLI+Xne7G+8/u/IlNggLUEIEH/hzM7QaIVvCfzmoehUJMEts9gs5oOQQEjJ1Cqd
 wvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487227; x=1747092027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=pJTeAlQzQxyvA88emV0eGC9Z3vQKSuvVXfKlqesrpBhYwieNDBlDZoSER/JdmdkeXC
 XnCgMuaCiSFrV1Wy787HKYyVO4MdOs17hqrqYvQchKcaY0fN1Aqn2+AZEdqeAWV4LmuP
 65JtoDdA4/Mx8FKTI8cCVCSA51Op37VCDwvy4iRaSks/bp6XxZMZyudXTEGrrFYDFlpn
 f49y++5B7do9SC4KzfJujCtROYdrHUxSH5aBk2ORCcw+4chCMlnCQ2Kdks7299y9QYtU
 mSTPaGQwSuNaq4fRwE4Ezc0WfQrJh8eIuQBsMorR+b/50P3gyHicS5wwsuxVwzEYqfJe
 bZjg==
X-Gm-Message-State: AOJu0YyfniL+ZZlJb6/wVwI24LmAMfvt2ateVf8yOAiyKscl80keIHbg
 lYxf2f/pTKC3TOKsFsSRDuq8yy19DROb7X+wE39E7ejvFnv+naNBa3JwAyBgF1ceEKHJPE9E313
 w6os=
X-Gm-Gg: ASbGncvNYi2xZZHPkym+mgHLfsw/LHRDjQJnhT1bvdUX4Ty2dKEOtxXDBKISP2xeU5w
 L3tOj7m72i66I5cmcci+95MnYkSl8pBRseZhfcPqBrX/JiviIzv0HyDQT2/DDIDKTUYWS+Sz1pZ
 BfnoV5LlvemNev+x/TQFQjAFPgSNlRTDEOHAgg36u7BVRSHCBp3KwfEPgEytQxoGXwM8P88xfRV
 B+ae0AEM3Ze99OF8PrSfxJKhoGqQObmGghRrYbZTmeXd5o3G9qKZWebw3FT75DtbIIGVL30Q04w
 FUEDX1BLv5CIYAIhhWqqeaHEuKA3HWC+SssMIJYi
X-Google-Smtp-Source: AGHT+IGzyc/8Sb9h770V9rBwJkj1A3Giv8Wxa9MDiPTqoA6+WmVYt/2QSnM+Kx0pqTa/ImdxPtTbSQ==
X-Received: by 2002:a17:902:cf42:b0:227:e709:f71 with SMTP id
 d9443c01a7336-22e1ea822aemr155051315ad.29.1746487227703; 
 Mon, 05 May 2025 16:20:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 08/50] accel/hvf: add hvf_enabled() for common code
Date: Mon,  5 May 2025 16:19:33 -0700
Message-ID: <20250505232015.130990-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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


