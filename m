Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7DFCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jL-00043b-Bb; Tue, 26 Aug 2025 21:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hs-0001ff-LB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hk-0000IX-QO
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso5482724b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257116; x=1756861916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQHHk+GzKEpRVqMmwJWOgMPUrj9GLRl3kw24x6qPa5c=;
 b=l6H6DCB1ZqctJlSdZTVutlUn4Jd7udBbxXEgSnjfQKCJu9wBt/B/oBZPz4DQBmZOLO
 M/+AlxdoXInfXfe8XDArplhXGoY82evgfr+RAWFH/tDdo2FaT0onnw0rEosPlfyXSQHr
 V0Hc0OcCmO4eo+Sb7oXu4hQE+QVjycdPJJJ2MS/5EbGeNP6sslBlehz0Nl91vz2CW2pa
 8URtsnwBV+pV+KsNYb+CX2JZaL7mIVU1kkRkdMf+WlF6+6vUEwnIav99wzMQ+6+i6OwO
 liZVSB8z9m65I+ibH+ZrPf48FPRGrjHupFP7ZGfLpkCYoxzlY+wbbdOB/NE2CaPMd3z5
 emFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257116; x=1756861916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQHHk+GzKEpRVqMmwJWOgMPUrj9GLRl3kw24x6qPa5c=;
 b=wp1fdYlz/1gQmHBLTxWuZRpd819/8SVsdbBxpbUvhKWsrw22nM9nJxph8EfpF1C9Oc
 U+MulHevHuwPOiBVexy66TgdxOP7vHVObmLH3NZDj33hnthDumvUoqX8L1NzDddf7CRk
 5aI8dIQ7U9oHyHul7HDTA8OuigZk2N+Ugk4Ep6ipqQImcSij3dWvzUa5qtt23sjJdtwl
 FeyRjuugxam0ZYzb4tZPXuUhZNj6odj4duyKqTyt/aFy1I4vabSg1Cg3oYNlrB2RMHcF
 EThIfIL1tWBpxHyMh/kSKZz9V3oN3us3YJlVccg6VlqbYvHKF6RLmekIG2jHXhCz4kkA
 DlzA==
X-Gm-Message-State: AOJu0Yy4+z5cq5u12Zap3Lw2J8hK1rKnW9MvAP7pDPhAHFdKJfTI0iY1
 MdtIopIFkAQRg+Rq1rmGRsZe1wuEIRj9rNnIvsVxxoOC/ya4lBV1z8zx13rpF8Yzgbp/wLqVh/D
 eHf4iXmk=
X-Gm-Gg: ASbGncsW1ZAQm39DIW+gEeEciR3yZBE6svnNAyLz/V8Xo7maz7Qb+bdjpbpgePu4GfI
 gezB6x/ofLCLWMPVWeOvbeKd8Ye2VYB82xL0xobSWroWnD88FFjvY8aO9Rd0s6eWlDJe3TFd01z
 GmHAyUEdSDL38Qop4Szpx2fIG8LNv+VOTsEpntIaDqVnjL8QDbtA0d6/KqwdxTI8k5IeMQsVrVp
 rnqsaSE56enkz/aHan/6xSnwJ96A/9TeEuWfG4a98PsQbZnctbhpIqwn6I7wShssw8ISjttiBNF
 BPuSqxRHEV5lsxtRaAZYd/Re8VvLuQqtn1wK+IlZ4O9GbGsGh1pOoq6gh8QG4tEt41p45WLzq0p
 1PMKui/K7kr072NL3VAAl1Eg1ncVPO6u1iiY+
X-Google-Smtp-Source: AGHT+IHIw1Rz5hAiaIfneDm2QDOaWkvGkeAaLtDGisvoniNCCIS80pgix2OB+9IsM6qSjsfVnfvnog==
X-Received: by 2002:a05:6a00:4b4e:b0:771:ed83:557c with SMTP id
 d2e1a72fcca58-771ed835a5dmr8661681b3a.2.1756257116210; 
 Tue, 26 Aug 2025 18:11:56 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 55/61] target/arm: Use HOST_ENDIAN_FIELDS in CPUARMState
Date: Wed, 27 Aug 2025 11:04:46 +1000
Message-ID: <20250827010453.4059782-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a5a8779aba..f7b861c6d6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -407,17 +407,8 @@ typedef struct CPUArchState {
         union { /* Fault address registers. */
             struct {
                 uint64_t _unused_far0;
-#if HOST_BIG_ENDIAN
-                uint32_t ifar_ns;
-                uint32_t dfar_ns;
-                uint32_t ifar_s;
-                uint32_t dfar_s;
-#else
-                uint32_t dfar_ns;
-                uint32_t ifar_ns;
-                uint32_t dfar_s;
-                uint32_t ifar_s;
-#endif
+                uint32_t HOST_ENDIAN_FIELDS(dfar_ns, ifar_ns);
+                uint32_t HOST_ENDIAN_FIELDS(dfar_s, ifar_s);
                 uint64_t _unused_far3;
             };
             uint64_t far_el[4];
@@ -444,21 +435,10 @@ typedef struct CPUArchState {
         uint64_t c9_pminten; /* perf monitor interrupt enables */
         union { /* Memory attribute redirection */
             struct {
-#if HOST_BIG_ENDIAN
                 uint64_t _unused_mair_0;
-                uint32_t mair1_ns;
-                uint32_t mair0_ns;
+                uint32_t HOST_ENDIAN_FIELDS(mair0_ns, mair1_ns);
                 uint64_t _unused_mair_1;
-                uint32_t mair1_s;
-                uint32_t mair0_s;
-#else
-                uint64_t _unused_mair_0;
-                uint32_t mair0_ns;
-                uint32_t mair1_ns;
-                uint64_t _unused_mair_1;
-                uint32_t mair0_s;
-                uint32_t mair1_s;
-#endif
+                uint32_t HOST_ENDIAN_FIELDS(mair0_s, mair1_s);
             };
             uint64_t mair_el[4];
         };
-- 
2.43.0


