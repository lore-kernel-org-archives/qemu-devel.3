Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD43C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uktCp-0005iB-GS; Sat, 09 Aug 2025 19:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCk-0005h3-Aj
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:26 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCi-0005gt-RI
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:26 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-7094f298dc3so27924406d6.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754782943; x=1755387743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iwsN5KKKv0HfyrR92BG0UgTuRe26Xxcui2WMmMpb4O0=;
 b=ECURkT34G8gsySlA6CAvYc872jdOBscjpr/dxjYcoW0k44Qvd3mJZ+Gv/8JhNMXkro
 52jJ8Yu+fgImBHDOt4isV+F/IPFRSBtTEi6N+1JEsi8vRZwN37KcFC9IZ0Xaj9yTqKOI
 inlmujxBVQpP2wFR+zpLT3PN+gachfAfUhKeLgJcQDcqgWbPA9TuhwcaCzNfDfPH6Q07
 sjt0WTBjDIYj16ZUzY2X8JmHG3aXTce7S5PAwZWTcM3KRiBVQ7jn20b5tZELvyGLdMJ/
 dEuJsipMnMPmSO/3TFwZDO1dAwOb6msTA/Cskv4bx0z3E82J/xQczVYmrK4g19dlN5kT
 ZDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754782943; x=1755387743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwsN5KKKv0HfyrR92BG0UgTuRe26Xxcui2WMmMpb4O0=;
 b=s1nhWXISEQadRMIfpQZ5V8qImGrRB4+kNwQMMcpSYGgmX2pEqNdgqpYDJBGw/Ze+Q+
 PLNJgV2igU9HpIa/g6h9E0vD0VwEtNgAdQfrMzI7QTXIeduOOp958v03Lkpi7rpt1u9Q
 Dj1rAuJxTn47Ju0Avip2P1LTUjuDCSSbcNRCg1g52sUSzETJT3WdwUCRcLnezwXHqB+g
 CwIC9Uwth8Jv0gHTsq6IJvfaQfxhSzlz+ozZLQ+C1DSpJmaJWCNlCX+nQNUTjpRBUnwo
 42rbR4+WEYCiu6h0hlaYL16jF2A/Py3sa7RFDfTSVIlTk45wsvVyBB2YeFxPnKqDykoI
 HiIw==
X-Gm-Message-State: AOJu0YyZ1rpLwCbLvjMZYTG+YjymUSMHIF/gOA1SEylGVFFuKZdnkziJ
 K4m7ZqjXPI9jaSJKnEfLlpAArGiBzAal2sya6Ho14hveVVhykdziNpHxancbAafriCywtx2ZvSm
 YtTLo
X-Gm-Gg: ASbGnctwLGeZZdlM6aK4xpk048WswixFRlAvjODZRCr73xW0lSNHns2uRP/jwTuBvEU
 VYtsSt/rr5yks7cZrON2qxgDQX/KRoX5rBRWuFQabj43MAwFuqBkMMGC5Kp81V9ea2N48EIcAKE
 BOIzynbszZCc0sTHFKO7aL4Xq/yK/hR2rAJlX6G3SbbgiV3iG01GsvWx0c9tnlxTQyei1as3HqE
 K8kp+s6nystnCBn3mY1TUOJDWZt98tf3eQGYeg6ftHtW/jSCPXu1EgFP1HW6bjCztcWjoRwdQfN
 GmTpU409RS3IJ/Wyvt4FMPH74m6t1XRj5XQ3hwzbxlbeRblbXcEEq2c5FmcJQtqQvEQPn4xv+y2
 IZFR1CglNAzwq+VT6k5+YBPakdpBr7JqMvSnU98PvMBsO8QNi7Cu13AtN0y93FNlgXFsFo9dHNh
 O8xMf+KIfG34/6ab0=
X-Google-Smtp-Source: AGHT+IEDT9my3k7p3+s9VlUZP8ek3Wp2kTzFZbJd9EiA4WAFO/DPf3W5DSjPA7sAu+S+llN1hhxmGg==
X-Received: by 2002:a05:6214:c62:b0:709:262d:6f64 with SMTP id
 6a1803df08f44-7099a52094dmr96464016d6.46.1754782943464; 
 Sat, 09 Aug 2025 16:42:23 -0700 (PDT)
Received: from stoup.. ([172.58.166.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cd56226sm132135636d6.44.2025.08.09.16.42.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 16:42:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] cpuinfo/i386: Detect GFNI as an AVX extension
Date: Sun, 10 Aug 2025 09:42:06 +1000
Message-ID: <20250809234208.12158-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809234208.12158-1-richard.henderson@linaro.org>
References: <20250809234208.12158-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index b11161555b..f8351b80b0 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -68,6 +68,9 @@
 #ifndef bit_AVX512VBMI2
 #define bit_AVX512VBMI2 (1 << 6)
 #endif
+#ifndef bit_GNFI
+#define bit_GNFI        (1 << 8)
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


