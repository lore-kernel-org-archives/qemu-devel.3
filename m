Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA02CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkM-0001tf-26; Sat, 30 Aug 2025 11:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c3-0004wJ-6H
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c0-0003ya-Dj
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so956499b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506623; x=1757111423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1To9kj0NUReaVQ1Qmnz3yHyScg57OYykVcZq9vtj4w=;
 b=Ux3B7Z5iB8RCKOxfAoMcqbx3uNyPTxIHWSTWR0D0Q3qAaVxeSd8tmI9YGAcB2DJlI2
 hGj+tin9jRzAYJPAfCeLWHU6u4UYqkO4p3oUiD6pl1/am4hZH/29uw+brNBoj+2ItCTr
 FLAqy+ikvG4CQlE0vj0MKqPAPFhjajHXLDdh/Pai0xb4aFwn2mz3mhivn4PEvsLLzXA9
 pvbF1YXK8x4bgnuA5hkeErUYO+HThFRd5s1o/9nNamCEJSwJ63Nk1FCDFEwgvVXH1xcF
 1fGU/iQGYIsgYmWxY1q2bbgA7A9duDEKAsmzv/lKo4q5yrSo2MPEt6mOapiPRSPp6Ymv
 VSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506623; x=1757111423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1To9kj0NUReaVQ1Qmnz3yHyScg57OYykVcZq9vtj4w=;
 b=hC0oD4iGtQFSWFLsE2kw8owWzsWDk7LEuzwVOVYLzttF8Q5sMzRyf6ojozgZinD6JA
 IdY88m4qZ0G8EgojQ9JyhjPBU7CyphX4WQF5bYlOZ5XyKSIVbtrVQcsIgrMx0Mz9kKsb
 QZNMS408xuF30woqHLXdS8o0NHb28iZW9YmXx9WhfstMPF1sPxadVeNMdM8pKJxM1ir3
 kAeYJO3KlqtBUD1rq7aSUq3pAhj30ek7jdWrV6w594DjrAfmoQtWv9g5pMsy6bEH+LRW
 tcr80vbrM7R9CRAxgcBSecPQrfj6PKQRyrSxkdNpatpnDooPeo3XnGluF01i/dTT5Pag
 OmBQ==
X-Gm-Message-State: AOJu0Ywpxj0ZQi8AIfvVrmvfK7+WD8vocw+OCb25+afkTv+ewuQtSF1S
 HPolFYgZYH3dignC/QETE9DGzMRTH2ig8LmvGCJs+nQPnIsQdsIhufS4slTsq+0XQhc7lAU35CH
 Z96JYmGI=
X-Gm-Gg: ASbGncvOJRQUtH4AUJco02pxGg++GZp/SWa77Q1g7bHGDZl07VeoDQtt1Cjlcabegke
 JEsGMYUoiWsq2+mNHe/28FFFtwkYzrYbbSfu+gColGB7CwqlJR2Y3vnmcjAR58L1LTGm2ouzPlI
 W/GJdUMnq74wYwfQKc2nKAp6m8ZSl2J/hWdHE6czqyf6Uy+Ttdr9Q2h9M29zkheT+1OUQO4WlUY
 DLQo772fkh715aYoB6+dQDnw3rbVlrIBgMJ0Dv1VEghGMqFBjwY4G1PTDQVrx+aWFK4Se/tQNt1
 ICFgEc4NW6LDeKGPn1+NbDG87J0Rg1EbKtGsVoKQPo7xCTzejSh3bS6XN2OSDca/zogPOq2raHa
 Bdr87r5nr6wVhnur3pUUeNAeOvStTiMBRsHvJ3mocn98/U6DiT79fuW6ZYFo3yjqjocJWLc7WgA
 ==
X-Google-Smtp-Source: AGHT+IHFw8y/4ANnMi6XjLjNZnxowhfDVKAfeOHfDlt0B18sX62Okf6hpzZCVw2CrNmbtiGZ/Uyj8A==
X-Received: by 2002:a05:6a00:178f:b0:771:ea9d:119b with SMTP id
 d2e1a72fcca58-7723e39f658mr290934b3a.29.1756506622878; 
 Fri, 29 Aug 2025 15:30:22 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 70/91] linux-user: Move elf parameters to sparc/target_elf.h
Date: Sat, 30 Aug 2025 08:24:06 +1000
Message-ID: <20250829222427.289668-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_elf.h | 11 +++++++++++
 linux-user/elfload.c          | 15 ---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index b7544db0a1..f89c708c46 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,6 +8,17 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#ifndef TARGET_SPARC64
+# define ELF_CLASS              ELFCLASS32
+# define ELF_ARCH               EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS              ELFCLASS32
+# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+#else
+# define ELF_CLASS              ELFCLASS64
+# define ELF_ARCH               EM_SPARCV9
+#endif
+
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 838d7199a6..ccdd87aa12 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,21 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SPARC
-
-#ifndef TARGET_SPARC64
-# define ELF_CLASS  ELFCLASS32
-# define ELF_ARCH   EM_SPARC
-#elif defined(TARGET_ABI32)
-# define ELF_CLASS  ELFCLASS32
-# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
-#else
-# define ELF_CLASS  ELFCLASS64
-# define ELF_ARCH   EM_SPARCV9
-#endif
-
-#endif /* TARGET_SPARC */
-
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-- 
2.43.0


