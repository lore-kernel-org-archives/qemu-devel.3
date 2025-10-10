Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D0BCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DOv-0002EK-EJ; Fri, 10 Oct 2025 09:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOo-0002Al-81
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOU-0007ry-LR
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4257aafab98so1829870f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103758; x=1760708558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OSShypqbaYu7gg2JRcaPkTQFiWcjkliGca982i75nQ=;
 b=J0vCIJG7y/kA8FgU9elcsWyEwAYXIQUKlcLT4IXuXZOMdl69a61Kt/0Iiy7U2wwSfj
 LqkmapS+gEGhpdIKRUZVjMMMhZn11ciYJtDmndsT1FGk/itLPG6FSxdq/CS31OUW4rrh
 53IgeQYEYuGmJzGARc1lYItwippXBHgn+4AH//hyXYpcIEfA+rfrLW3hLoKn1ux3ZsYD
 jXUmH3ojX+CcLMeysslGCfTtMrkCjkWzqfyrakPS2XrYxBWoFlFtJTmJ2nqQ5KOQL3MW
 VBxs7uHvKd+3H0UqCL2KrkkhphHUAM58PdiMEXsXqi0FIhF9M707HVh/IGqSjAzQj15x
 15Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103758; x=1760708558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OSShypqbaYu7gg2JRcaPkTQFiWcjkliGca982i75nQ=;
 b=ud8D3fLBWg4/4X9Dx87/eRVkthsjYxNOkaBeIVbJBL/0HHLSGZfuQcj6KDNh4hqZND
 f7nFYKDTgxRaRVZ+bxBYzO/fgh6rUobjn1aFkOlC5q+kW/Ox0Cu1K0SCl0VRVD7wWPUY
 GkfjFbTGp4kbv/OALg5XokSBct8ZI/8Cv5Xr5ZhM0HHyIuNqOeF2PABcfodI0TYWArJY
 G961B+Ws03IKKtAA7uy8clkjComrtveRN/BbCfOLPHAAn85/Eip7+ItkE1/oFuq21FlW
 f/nD/mRLe80d1xlfeVtrjpdQHrdPD1Kg7M54dtLNHbtewvpp18h0YVNQ6wGoveNG0XiY
 45ig==
X-Gm-Message-State: AOJu0YyBVmwUsEMe36IoDVijKEocqogtexxRmmWd+QuqEgs8isBUWSNA
 aA0gUhjCAQ8lEtNPPThYgMywn8iQ/rXfpdCtJKrl/r04/S+7cfDEc1Ad4LyutFJ8ZnmrSwkpZSe
 BWesnx6wo5g==
X-Gm-Gg: ASbGncsWHWViCofTGLfeCcjdUL2g2/dw+iio3qnRMA4KH9/lfrzIfqieoD+vmfiEyKM
 Oxvg4FYRnYJRhAFHmUuNaVf/UzcaSICEhZ/LSSfyGM/jNFe5578wfxPdnI8QxNoIKZEnhv/W8zO
 3h+G3FiRT0gSFkwwE5JYQRyBg3Aou5VjhiWXX4u+rbTow/JvkLX5UsAu1Ejkp/kV+lrT565Z3oC
 pdsO4egX4MxO67YVT3v7vM4IEQ01C7nzqdHNnKLCOL7+K4Lpa70lRIIoIbKs64Av8TPcrISf03N
 ey5Lj/adwhn7dsp5SpljhDaFScAIA7HGz8busJu+LieMtaWh+UUl53s59Ca6twZc7co46WDRjzM
 +Hh93yysXR4Q80aWKS9G6shmwFgkFn2Cut5gValtYQ5dfE++0nOvbpUODmUK6vwfXAuFGgLhG/9
 hWiav2XXzj+RdBIMSlFtY=
X-Google-Smtp-Source: AGHT+IGji93i+SOihun7JFXHhG4hGqXkH4wmT2Nj3yjUj0PvGZai8kOCJcP8uw/NluQ56SyBGkWf3Q==
X-Received: by 2002:a05:6000:4023:b0:3ec:e277:288c with SMTP id
 ffacd0b85a97d-4266e7d90e2mr7334892f8f.31.1760103758528; 
 Fri, 10 Oct 2025 06:42:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm4140481f8f.35.2025.10.10.06.42.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:42:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 02/16] linux-user/arm: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
Date: Fri, 10 Oct 2025 15:42:11 +0200
Message-ID: <20251010134226.72221-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/arm/nwfpe/double_cpdo.c | 12 ++----------
 linux-user/arm/nwfpe/fpa11_cpdt.c  | 29 ++++++++++++++---------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/linux-user/arm/nwfpe/double_cpdo.c b/linux-user/arm/nwfpe/double_cpdo.c
index d45ece2e2fe..e29b38aada0 100644
--- a/linux-user/arm/nwfpe/double_cpdo.c
+++ b/linux-user/arm/nwfpe/double_cpdo.c
@@ -150,11 +150,7 @@ unsigned int DoubleCPDO(const unsigned int opcode)
       case MNF_CODE:
       {
          unsigned int *p = (unsigned int*)&rFm;
-#if HOST_BIG_ENDIAN
-         p[0] ^= 0x80000000;
-#else
-         p[1] ^= 0x80000000;
-#endif
+         p[!HOST_BIG_ENDIAN] ^= 0x80000000;
          fpa11->fpreg[Fd].fDouble = rFm;
       }
       break;
@@ -162,11 +158,7 @@ unsigned int DoubleCPDO(const unsigned int opcode)
       case ABS_CODE:
       {
          unsigned int *p = (unsigned int*)&rFm;
-#if HOST_BIG_ENDIAN
-         p[0] &= 0x7fffffff;
-#else
-         p[1] &= 0x7fffffff;
-#endif
+         p[!HOST_BIG_ENDIAN] &= 0x7fffffff;
          fpa11->fpreg[Fd].fDouble = rFm;
       }
       break;
diff --git a/linux-user/arm/nwfpe/fpa11_cpdt.c b/linux-user/arm/nwfpe/fpa11_cpdt.c
index 6b0317883a7..7b0a715d403 100644
--- a/linux-user/arm/nwfpe/fpa11_cpdt.c
+++ b/linux-user/arm/nwfpe/fpa11_cpdt.c
@@ -44,15 +44,14 @@ void loadDouble(const unsigned int Fn, target_ulong addr)
     unsigned int *p;
     p = (unsigned int *)&fpa11->fpreg[Fn].fDouble;
     fpa11->fType[Fn] = typeDouble;
-#if HOST_BIG_ENDIAN
     /* FIXME - handle failure of get_user() */
-    get_user_u32(p[0], addr);       /* sign & exponent */
-    get_user_u32(p[1], addr + 4);
-#else
-    /* FIXME - handle failure of get_user() */
-    get_user_u32(p[0], addr + 4);
-    get_user_u32(p[1], addr);       /* sign & exponent */
-#endif
+    if (HOST_BIG_ENDIAN) {
+        get_user_u32(p[0], addr);   /* sign & exponent */
+        get_user_u32(p[1], addr + 4);
+    } else {
+        get_user_u32(p[0], addr + 4);
+        get_user_u32(p[1], addr);   /* sign & exponent */
+    }
 }
 
 static inline
@@ -151,13 +150,13 @@ void storeDouble(const unsigned int Fn, target_ulong addr)
         val = fpa11->fpreg[Fn].fDouble;
     }
     /* FIXME - handle put_user() failures */
-#if HOST_BIG_ENDIAN
-    put_user_u32(p[0], addr);           /* msw */
-    put_user_u32(p[1], addr + 4);       /* lsw */
-#else
-    put_user_u32(p[1], addr);           /* msw */
-    put_user_u32(p[0], addr + 4);       /* lsw */
-#endif
+    if (HOST_BIG_ENDIAN) {
+        put_user_u32(p[0], addr);       /* msw */
+        put_user_u32(p[1], addr + 4);   /* lsw */
+    } else {
+        put_user_u32(p[1], addr);       /* msw */
+        put_user_u32(p[0], addr + 4);   /* lsw */
+    }
 }
 
 static inline
-- 
2.51.0


