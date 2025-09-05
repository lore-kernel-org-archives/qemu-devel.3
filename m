Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E7ECA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRDr-0003AH-AC; Fri, 05 Sep 2025 03:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDn-000371-3k
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDj-0008Rx-JD
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:50:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b8b2712d8so16832355e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757058653; x=1757663453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/kPH6riYNOweQhnmn/RRL6i17iJqnbvBitGNZ3+s7oE=;
 b=tEXVu5efiORQH4oek/vXebAjYKEFve1q+lgSR68RgSGhwDHzrDZQ7ydpjoDIFk0bd5
 R57IatKhTP452n3z0kxY1ETXXTdXPurYB4dwX9Ltorpth/QlyrLedy1yKq3qseczRml+
 Zeln100fhIHLQLFgyg6roKWqSIEIwm0Tb1mcw5kiNmRL/CriAVzf2cIgEsg1H5r0JR/f
 k58j2haR5Dv/DO8StIl9HgXuH8lB7oQITUq7AInYs8dsJIFAjkmN3m//iOs32XHAcQRT
 lbRN8elndCNtLVJb/E8aKx/8tgdIc22nGPFf2w4tLLbt2/ehw2s+W/gS1oj2cQrusRWD
 L6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058653; x=1757663453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kPH6riYNOweQhnmn/RRL6i17iJqnbvBitGNZ3+s7oE=;
 b=tfyuBgTpAKxLAVK48HhUa8Fqx8YT0zxJHLexELKgCJrr5If1bM9v8l7hU9+YMWXg7o
 kQqOsJw5Q3/UMpTWFk4Y8kSTiDkHm7nv+QRI/DHKmdM0epxutnXkOSNcHo2XrY6YH+2q
 DqZoMi0MMR8tWxl6pT5wJ5q7PfmGzATFEIWADqxngO+PFS00nIt6IDdnboFoiM4+o6Db
 YVdLZdhZJGaS2yTba4B/6sUvxJ7zuk8+R7MA+dlrgFkhelJiOFWgex0NI0BtS/uY4fQX
 smRoF03zyUgmG0J8xZ8ngvw2H7lwQetoq3P+PzzIUtoy6sBXFQCfnH6qAs+6vPvAJ5xE
 Wfuw==
X-Gm-Message-State: AOJu0Yx2PNzsGnsERMXmb4/pJb9Ef4koS3AhDCECzWPEP9NJgqp+iAmD
 ZBU3m8gDEjRzyxomh+jNdiggkgQCU9suxMm+0JuqOKuZ47aK9AMGJZNqac+O92mCLHjlJDQZSmU
 iO9XhPjw=
X-Gm-Gg: ASbGncvfwOD3Rpo2tjlsL+GK2D0FooNdt4YLu6eC7A8aJuN2GdAy0NAI7HP0iH23oJL
 Oi4E5d2apWYfC2MTwfe7rgk2d2hyWecPHShFJ7PS63pl/rGXQ+QuFXliN0vDbdw96tgwGp9ZlZI
 4YASVvtVhykxb8QxDRV+mobM0O0dmM9O8YWyI831HtoGa6mcGBd4+efjvOmagcajwUYwnYXpFME
 NaQR+UFIlNzJ0w/pLm65YQi4Eci7WVzTEwmszJTcKMeq8npNA+JECun7v23lIPbtlG+m5fgXeT6
 cWCoYv8HqwW84tZSxnVAJ41FjLX7IWFUobv+9/U0nowA/CzPn38EqonImqo9jOkzJnEmN2RKgxb
 9fpcf8kqSSlrnn0VtVGMGZdtSjn/dJkU9WG/qf773iNVP0PsIY4/hME/s
X-Google-Smtp-Source: AGHT+IE5bNGk/JSOmX6isdb84wkO6QveawwcpFq6DtwiL/KX+dGVftynlvmZiv9yTbq2iVRcbsxptA==
X-Received: by 2002:a05:600c:1c15:b0:45d:db2a:ce4a with SMTP id
 5b1f17b1804b1-45ddb2acfa8mr3374115e9.9.1757058653430; 
 Fri, 05 Sep 2025 00:50:53 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm143760715e9.12.2025.09.05.00.50.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] cpuinfo/i386: Detect GFNI as an AVX extension
Date: Fri,  5 Sep 2025 09:50:43 +0200
Message-ID: <20250905075048.100496-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905075048.100496-1-richard.henderson@linaro.org>
References: <20250905075048.100496-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

We won't use the SSE GFNI instructions, so delay
detection until we know AVX is present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h | 1 +
 include/qemu/cpuid.h             | 3 +++
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 5 insertions(+)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 9541a64da6..93d029d499 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
 #define CPUINFO_PCLMUL          (1u << 19)
+#define CPUINFO_GFNI            (1u << 20)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index b11161555b..de7a900509 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -68,6 +68,9 @@
 #ifndef bit_AVX512VBMI2
 #define bit_AVX512VBMI2 (1 << 6)
 #endif
+#ifndef bit_GFNI
+#define bit_GFNI        (1 << 8)
+#endif
 
 /* Leaf 0x80000001, %ecx */
 #ifndef bit_LZCNT
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index c8c8a1b370..f4c5b6ff40 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -50,6 +50,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             if ((bv & 6) == 6) {
                 info |= CPUINFO_AVX1;
                 info |= (b7 & bit_AVX2 ? CPUINFO_AVX2 : 0);
+                info |= (c7 & bit_GFNI ? CPUINFO_GFNI : 0);
 
                 if ((bv & 0xe0) == 0xe0) {
                     info |= (b7 & bit_AVX512F ? CPUINFO_AVX512F : 0);
-- 
2.43.0


