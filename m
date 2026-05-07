Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44DCCD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Om-0000lQ-MP; Thu, 07 May 2026 19:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ok-0000jA-KX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:54 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Oj-0001Dw-0U
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:54 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dea1272943so885989a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197491; x=1778802291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=mK01Swc+dorVWbFbg+aLhNTIn1Li/x6rFxB+Y6ZyJDuExjF3QEm4sPcWoA4VWGZRdK
 efrNeSdhmqc1z6JI1imafFTl1qbwWiLKZrHobLTFsL8nptEH0pWZtLYPt55BVBPTU8mE
 TKorS8F/Lzb2UEgUueA60Ipj/mDr8/8Fhfb5onsH8VGsuyTUyoaNUZ0SGY1ycV+pDfyN
 G2CgdjzNrwbUVFEhDp/qJ8eXDW+e1L8dag6lYOqR9m+KZEixhO+jf2IHxKuEkXrP+VuQ
 repuXGVRsEqFwaKwB/m7mNoLVHm9YIPnHmdV1xLwxVDwrP6sZRjNH0LRlYrQ+DW6UoSr
 wwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197491; x=1778802291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=KEMA6k1qiK/wLmoUfL7gVOZYaJnRKc5bIhZ9jLwKc+bLqV8x8suYbVuqNfXFhuvMMc
 iuYUtIqHDQ5xRKB8NQJnD6MEMkKI75LIJTELFXQxezTfisVy7g6s2qBfnI1EtGXGq3UW
 b5nK7pf+6hVkktz85Zhb7wHIrNcvDBzVWyMhbnOp0O/+VuCF6Gb+bXbZeC/NOf1f/pxK
 p0i4A425LOIxAUvptAkvGFQQ7IMj2mKQKS4zfTYvMug7nqMOgJYSEClFo1cy9nqrAiZk
 iyVJwzfQvfMi5Q+78TAWrfcEbPWdV12QIolfhWwoBPLt3aZWOTPp1mY4GNHA1i1d9yZi
 2gXw==
X-Gm-Message-State: AOJu0YwuzhsXTbvg4yOGqtVAtDHom2MS0NgDV5xxbwA68gpHhMh31KQi
 4buRdKz4fj0mAV9zKVXYJWw5XV7PnjBrj8+yz4gCKeiKFnnU2Q4sgp9SuYeka+F5FYyJCW4IRjI
 zYAjS
X-Gm-Gg: AeBDieu/OByAYTcuu1+YaU1tWsXg5nK7wpZ6S4HUjjtxtmFoyNTjU3Thg0Pm51CAGRo
 scsQefVybdNsEdtepnmNbxIIq1fCTtg9U1RmgnQvPQDE2DoVRLwxjx9l4YAtbTMUTem2b24/iff
 AJki4Qsv7aMR4mAhHvfChObR3WqzEzB9SsRFEH7ZuNRyVOK+f00sfd83FWVtJdCpqxRec6cgFgS
 qaate5c2jdCrCLeIAeoZEs4xpFk9bYIMbfJtxJNvdj163sVuQ8NwWtTinUGPAuE9b6C1RG6G2FV
 cdSqlOn2VjJQ8jofLS6cciDjv+yTRDIYCq/InklijTNPlrwdng/xirzs2kExBql8opf72Ksjms5
 ud4EmLL+ZrxBNeISUaIb88n+mU3JQk7anEkbuY0Iwb5cz0/90t01BnCT4ZvCxoXJV6j1HepL4MH
 EHtDWQhIhRiKwbV8xxkFFcWJx4vjyguLn5u/7P90eem0wxcg==
X-Received: by 2002:a05:6830:81c5:b0:7db:a8b7:c565 with SMTP id
 46e09a7af769-7e1df04b7d2mr5808004a34.20.1778197491451; 
 Thu, 07 May 2026 16:44:51 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 38/60] target/arm: Enable FEAT_LUT for -cpu max
Date: Thu,  7 May 2026 18:43:51 -0500
Message-ID: <20260507234413.643512-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
index a377f67b9c..bc866c5a67 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 44c7196d09..cf8771d541 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -101,6 +101,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
-- 
2.43.0


