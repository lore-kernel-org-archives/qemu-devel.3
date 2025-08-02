Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F91C87FDA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLuN-0008Ab-3A; Sat, 02 Aug 2025 19:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoO-0005xp-BJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:00 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoM-0006QG-HQ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741a905439eso355688a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177925; x=1754782725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTzILFxOh9VPP18+18G2a8oDIZLGKqGhECeVoAfm6S8=;
 b=icmaofe8UF45dVB16S7oCRIwyioDB6Izi660iSe1r7XF40Dq2Z/sdEY47KlD9KpQqv
 Kll8PB8494RitGB7kr7mijlwQaWPhEzInyapBFll1mep/U/TyFtTOSP/YaDCCvWivFOV
 C3EwqUbb1j8+SFXEV9zY9t2tZGFHiFE3x9jnY9drHGqAVJ56yEMbmSbhg4X4mabTOOJQ
 arBlZ02NPNGku+m2PSgnSHsl1vMnv5WDwqmSItqOq8kpF4y2Jvo+g1jrfVT+JIGIzQWp
 1hDxQDf0HLRgrE4PwVYq3uQIKLi1YFiCjYywSFNn66BNShCJcJ/ZcpGiFiUTsFoveEfV
 YiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177925; x=1754782725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTzILFxOh9VPP18+18G2a8oDIZLGKqGhECeVoAfm6S8=;
 b=durooslD4HK9NyafEP7SruBaVf5Qn4yc6S66wWqdk/TrvfFBjtMgsV4Tel+1L8ecia
 klDIVOxTb3TqrEUMQrRVcdRl+l0ElXB6joOpsaoqGhAadRynK6w045LHj1Y/kZQRJ+IU
 xH/seQ70HPDUn3VgASe91i9AGcbPBSfgeaM5WGXgUqFiG+VwICCoj9PNA0e7rvpn9TQY
 DnhV2JAcvv8Ha89jDP9w2THyPKhwXdCTZnrLUw1pvEj/7AuI/T75pWHmGqxEyomQSOUs
 5su5TNh/t6M2HOiNxbo8Oq9qGwHw0XV8yBvFwGGuoh3HgL6HDr1zujhv0nIQsYVc2kzU
 W69w==
X-Gm-Message-State: AOJu0YxtTTUN0BqtxFR3rBBgHyVbkgKkgpGMmjisH1uVG4PoCiqzZjL7
 cK+/aM/+iOQiFOhvTzghPdYp8wUGTyWfkQoo1jT0xBteLQRSThfctZLX1NnjuMIZZ50AnMsy87e
 gkLG4w5M=
X-Gm-Gg: ASbGncvXiOSE3VUL9qWKT0VRIieHm6C9FJcNWCHVRYsx8jjqn6Azxl8B86g79nywVD2
 rlM/aRAoatVABzzACluSvWGX7LeRuqr/ioE5hpPLUdRB+HTc1+l85Xfu+HrFKSu6Ob/GKrrEf3m
 5dVZ1l7MMCU3p+C9xxjytJpcK1oh5v1gpSKT1wCVV6JmS5omGXjIsjyDFadS8iJScNULHvErS5m
 RRAlkpLbEOEU5F5ZjZI8ChXfkeIvJorQEDvIQLoNIe9RKn7OKYZ75HvnMj0tvrSlM1Ai+6kdKzb
 4NeFvryAKpPQVRXW1BlGu8O0dkCeevoDNew6iOd9G77xz7L9k43FTCOfO+vnAIbX4LCSww1ED/9
 FvdkC42wtqOXPW7ouXFIyya3J1JL80oFI+A9Hz+1stLQpIXrEpaP2
X-Google-Smtp-Source: AGHT+IHv6Tll2VlaRQZobRCYQXySwVjiTgz0KMfDFVfvDsK/j/LnBUag0Bs6BjwToIeFGRXP6lDEeg==
X-Received: by 2002:a05:6830:3345:b0:741:a4a2:88bc with SMTP id
 46e09a7af769-741a4a28c5bmr1528275a34.8.1754177925504; 
 Sat, 02 Aug 2025 16:38:45 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 73/85] target/arm: Enable FEAT_GCS with -cpu max
Date: Sun,  3 Aug 2025 09:29:41 +1000
Message-ID: <20250802232953.413294-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f4a41c854f..0c3408c0a0 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1205,6 +1205,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b894aced89..9e3df48e00 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -72,6 +72,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


