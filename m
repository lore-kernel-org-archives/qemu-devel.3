Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38625CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 20:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Jab-0000U2-5M; Fri, 10 Oct 2025 16:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaO-0000RP-4j
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7JaJ-0002mw-KL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:19:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7833765433cso3351471b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760127564; x=1760732364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpOqxN2RJLucJYrBCL4XiSbhJrK5bcbpor4bzH0LpBQ=;
 b=T8WyIIOYRJXkT2gDCNmBLMKKbzLBQS5ru2gYkoruCabWa41um6EjFNb0OjJ2J41YHb
 xaet3RQhL+LKneoHifX8TvFuVFaKqHH7YeMI4pAhG4v935TFqXFcM1N4Y+InY6z2H05Q
 s6KmRbzw2pDqEKQT7lNe21/+0zhoNaohgrExJU1MaJ6kej/cCTv4MX9Yjh3/IwkO6wmt
 9oGSvmUAZaQviOKmMFtuU7L4ps3pD6RHErYwHIqYH9xSvfJTFDfqJGhsfSGe4+qMl1SA
 uwEtwvnEbPc3W2V2m5ULWP52yUbBJJDUu9bfRV0Zm++4O824J7Nv2QNsZvidJPafGg8k
 Fecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760127564; x=1760732364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpOqxN2RJLucJYrBCL4XiSbhJrK5bcbpor4bzH0LpBQ=;
 b=G53ypoqq+trd8/8P+crtD4y8XUm173DEY4BfbbpbXikHDj+FOboGO/ONM5vLabszBA
 KuikM2YhiC2aRBAGTRthqSzNoNRswIk7pl8iOrbY5KPsnRIoYfYQxV3tc1vC4L3+0bxd
 Bwg1s2lACvjonvfVi+JY+0S3T+xJaZJ5/aEhyM0eJRspNfCm2pO69uW/4Z6rVdal60AU
 a5BNXftz7wGdmnRaNnMEte+FiCE9UtTqiu02Toa7D2Fhoe60exoDE9/i9p3D9I2G/7R4
 OtiS45K5jY4Rf2AvnGNY/wX6N3IruEm4p7Rvup3+R7Prx2MjkysJ97p8W4RBKH32ZvPc
 w3fw==
X-Gm-Message-State: AOJu0YylM3wiI5dSGX++2y3SL4g/WMYAEYhF5scS44mieF2unf/xvfD2
 5+VsdCHD0L3KEfhMGVV0dp/WvYDBigXJqOFHpugWertIXTdtgRqixfdOhsCoTTtb/MEsraIaepI
 ojbleU9c=
X-Gm-Gg: ASbGnct9TXSniVV28mvo/NUnvu6BjhvUq7M7QtS6AuUa7EObbFr3qbNB8pEhDLyEEsW
 VDP9S0kugULkxUchRcpgMvp8WDITH1k1+TIDP4CwXkGq82a8NZ/XMLGUeiN/glMZi5cAcFW+xbb
 JHbeEwKCBxFGdYSv8+V4uK9+grqaU0h8msypzocAjlgXJtIyTDubgT9gGAXn2aRyrhUI7PaDwLv
 KDmGK4VC5gbISZFvRsGPXh1TmO2Ap0dggCKJbAex+yCJx3GSj58LkiyxLbv1hMt6s3bEQQ/oGlS
 +f1czWv7iqp3RqavVTqsDtvIqTtDyaeeSVVN1njc+3OJsEamMXrPnfMTR66SP0jzqf199UHKAsm
 9NhdUiy7h7w+ESMJ84vSYbRwuVHsnZ18sn+GKSrbqDx0ibY+8DEddcNu3Eux6cQ==
X-Google-Smtp-Source: AGHT+IERgO1YZ3zhuCSh3EAsVBiDjqNgb+8RNcVYpvDRtvEUbDfCNofpBkwNYfbKDoigoxDkBbHMtA==
X-Received: by 2002:a05:6a00:39aa:b0:793:11fc:783f with SMTP id
 d2e1a72fcca58-79387a21bd2mr16797144b3a.29.1760127563790; 
 Fri, 10 Oct 2025 13:19:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd7ee5bsm3764830b3a.85.2025.10.10.13.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 7/7] target/arm: Enable FEAT_AIE for -cpu max
Date: Fri, 10 Oct 2025 13:19:17 -0700
Message-ID: <20251010201917.685716-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010201917.685716-1-richard.henderson@linaro.org>
References: <20251010201917.685716-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1bffe66e81..6871956382 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1331,6 +1331,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bf81da124a..31a5878a8f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -21,6 +21,7 @@ the following architecture extensions:
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
 - FEAT_AFP (Alternate floating-point behavior)
+- FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
-- 
2.43.0


