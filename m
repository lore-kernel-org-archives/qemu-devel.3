Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606ADC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguZi-0000UO-Vl; Tue, 29 Jul 2025 20:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJQ-0004zL-9Z
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJO-0004hl-A1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso2362195b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833889; x=1754438689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BRAZx2uDN1mem6V9ZwYcKBEKSI/7pCLC129eqDEE/rE=;
 b=HVXANgszimjV1icv9cyObScynvBq9tq6h8atyTcSRhKiGl4MbQzAKg/UmAnOc/9C7g
 yEJjjikHav8pvtq2rHedl+yIX96p8jHYZiwag9CypBJA5mGfw/CTWJHEzI6vKOFD3/tR
 +LxW+x65zvq8nSAb5dToT6Eldmqp2X+oCxPAUxdlSmc2w2INmLkaPj0prDMqvvv1mKu7
 0JAVMxwmZ083aGHhH6U8D1h3gBJF51IQHn8hdZt1iQ8H7VYPTX6/LgTczweCsPQr35e2
 0GSzA+OPYwYKxX8ljY796Xqra6+Vniz1ea9A8+jtMypeJ8G/Ed36KmapbzKG3BId1z5d
 oNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833889; x=1754438689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRAZx2uDN1mem6V9ZwYcKBEKSI/7pCLC129eqDEE/rE=;
 b=waJ0xONX2EZ9XpPpIsyUnFi6lBKffON1g3CICIl7bpY5KqBSOuAOt4nyCX5tZpqWUt
 hx+vgFHXaCjekk7V4Jl5n9plMmAJE8df9LYPd4GbuZAnL2D4tLrLA0zoSA5IxsqnTiuQ
 kVMzhifnvVqG5xWTpQtZAbTXIaDqNXgtXhRhfX3uCBpLLnxStAWXFhrI4ez/VKO64xFm
 oZ1L/iH0wKTwP2VnHSkio6YuUG0E2Dk06j6oXNxGupHsAhyYD9dlLXJ2N1HMQ+RZU/+/
 R7svsN0BPhB22Q1xrjAUKaDDYMtq7kTV6Vdi7lxcxT0MenK7RLMYwApzR6FzwDm7ZzpW
 0U9A==
X-Gm-Message-State: AOJu0YyaNMqhp+bcMSDNAImIBDyKAWxZ1B5+JXGE5+Ntl/NRRuIDfOmz
 Y0+em5AEYbQH6IuxOCxSgJ897CtosHeg+0QTpvqBDlr9JCdh1LQiMr+/gxllk0RYr6G723SHt6Q
 0LG/+
X-Gm-Gg: ASbGncvdyb5Ug3OnYQQQchAiavd3JEkAhWxd9Nv3qcriBQEJV/sAB/noZc7mUFK34+9
 xoQxMaMiMSHgRfy6GM8bhnIuVRz4KcJ+9KBaMdsNw7hkeP7yRUGSz21UdZYoJDhu+IpVdR36CTa
 +Q9vB1gjyzcvkBEMaEJSyb/5TRzSKOQ5eMmh7QZxd+vxIaLfJp1/oLUSc83lGQkir7EGnUF85qx
 M8mC/0HQOI4KyqJywsXS8jNjKIeZMZFiCh8YL5RuxqRlfUkXPG6CWLuaqsBUGbA45+1Ph+cynru
 ykPv/m2D8Q85PBXpPH1a0HTFmbAhGDTFF+LP8zKBwQh8NtJujHBa4k95iB0O8Pe5UuIOolsb+IA
 um4d3xV+epYa6sF/oLYOuQ7LixJs8yBxIf2UIXahSqD5ZDfvqKtWKO4p6+fYzr93hay7xZA03rV
 dRT9yBI8dBFg==
X-Google-Smtp-Source: AGHT+IEZWe+wNj31XbuZYcLXcxPtZGa+esQh2OLCiXgYlz/BqgyG2NV7F5O7EcuWt4mQVZDnk+EiaQ==
X-Received: by 2002:a05:6a20:9392:b0:21f:39c9:2122 with SMTP id
 adf61e73a8af0-23dc0d84dacmr1919869637.2.1753833888607; 
 Tue, 29 Jul 2025 17:04:48 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/89] linux-user: Move elf parameters to m68k/target_elf.h
Date: Tue, 29 Jul 2025 13:59:45 -1000
Message-ID: <20250730000003.599084-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 4 ++++
 linux-user/elfload.c         | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 62ff9d38d4..baabc1c040 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,4 +8,8 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_68K
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 38c5f2c4e9..c88fbdebb0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,15 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_M68K
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_68K
-
-#define USE_ELF_CORE_DUMP
-
-#endif
-
 #ifdef TARGET_ALPHA
 
 #define ELF_CLASS      ELFCLASS64
-- 
2.43.0


