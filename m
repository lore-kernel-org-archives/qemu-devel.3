Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8454ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEu-0002nh-NI; Wed, 08 Oct 2025 18:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDU-0001Oq-AL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCZ-0007R0-Va
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so388115b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960800; x=1760565600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gclATv708qJLJB/SCyo2oWtJwkQ64mZdma6VCmxYGoI=;
 b=glyo/OPv0HQAKkOVu8l/q9TNtiFqF7FyD5ni5HuApkq8lxf47Em238dDPI9i17jU1N
 Mz3S8nMsha8iA1chbkqf65W6JO8leCoPgZwYmUjw5YX0r+Bma1I5MkHsKuzhYNTCk8v4
 MCDMZG3A45SMXbiwayyR84OeB4WdWMuHnP9+U0o7hXFE4Q1R7ZPXl/nWDDlD+VqAWnj/
 nDawtxOnKkqdIOBsCzN1m4eotjmvkO3L+5+YeXo8N2zxC9Y/zgCBRAmBwemlMoU4jrLK
 EBKrKw6OU1s6rVPJdFOHINlAlwO18kFr8xDBuV5hhsYPEoSi9QDePS5KSq0tEf5VuTrC
 H2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960800; x=1760565600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gclATv708qJLJB/SCyo2oWtJwkQ64mZdma6VCmxYGoI=;
 b=d9LeYVZ93cWmjuw9kkYI47wDIG47g6ecbL28PYXlqKWFDOZlFizZlX+eOgg7h3DfVT
 5bigc7ZzuCspl+HiXH7fK6pnJG5b9sCjA7LyBDvg7JZkmSXc2RjumNBesjBmPRbHPQNs
 e+ucUqsmBeMv3KdSf6l8ol3pMoSQwNk6Fp8mMYIg2zQx7VPqSVvUGZXb5IUHmouh0MSS
 bRg8P8Km9Srpwmv2UtVsSyrEnYn6hioTwc7P6tCoGYyPPIa+llowUVSahcdjnFvrQRf9
 WIZBzTUVXc1j/JS1/J3gb4IT7vyiG/hE2Sehl+0wF/O5FVChtGBQ4VhWhAavP9Ux8fvB
 zGtg==
X-Gm-Message-State: AOJu0YxeyT3HKSI6nABFUp3xJ2rkPhFAhj095IATmggJoIFI0TG0EWZk
 L1nXZO8DLXkDoDn0zyEcCIC3EYHqjSAcE0VM1YxL2J8TlRR+F4SDd1dswdVbQcTOBw/vxDSAkug
 qxxMAHYk=
X-Gm-Gg: ASbGncsQxuS28Q5bFit8rqScyTuHmJ35k4/EfraZ4hPqbdFMQzRMv2Ux/y5/PLbZJqF
 qf/BnHNrwSeQlUVg7fTXmYjkJKYAkK9E3Bf3w2COaAd/rrJ2mynt4vbra5SWCfEDV4aUf8whW6R
 r92j+JXl2vG50YNt5K7LeLvw4TKQadFr5em9U3Q+0qjfUMkeVDH+Ek3I6Pnge2lZVWPfHV65FkW
 gcITjIAgVagYsxd+/k28MJHoNWmaf2KttLn0g2QRtLC8wk3NDRA/+hIvQ6x6CONdSpiWMFEiZOJ
 QUr/ROT/U8ixpeczdX6nS31Bbp1JDfKTghcSnVgWDf+1QjX2aAiBD1dlflKx9yMchjS5VjmDyBc
 V26ve/J6/b6fawfjQAoyrACqyYSZ+vQSyixeCdIkfSnYJ6v2yTnmoPJIR
X-Google-Smtp-Source: AGHT+IE9NJmhfn5ox8y9wKFZDBD4qS0zmwY6LdO+/QAGFkuQSgBgXBPbfhS2H+EXyoIROxFXpoI7vA==
X-Received: by 2002:a05:6a00:1406:b0:78a:f70d:b80c with SMTP id
 d2e1a72fcca58-79387826a86mr5410572b3a.22.1759960799894; 
 Wed, 08 Oct 2025 14:59:59 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 68/73] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Wed,  8 Oct 2025 14:56:08 -0700
Message-ID: <20251008215613.300150-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 50a4c99535..7f66a879ea 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0


