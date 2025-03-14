Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB6C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uL-0005DR-JW; Fri, 14 Mar 2025 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uJ-0005CO-1r
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uH-00019M-Bj
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1668434f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958216; x=1742563016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qF7NqSa5lV0sZZKHA8ojvh+EUzwVOc8Mo3QSd+ZWM7U=;
 b=Z5GLj+RbKF/NqsvsgTLm0NlNaI8X77Wl3M9dfnZX3cQRRojQuMvm2o+bVkEm5V34RI
 lbuwTsExS5dKbZRkeTLeBeQ2BpdcYF2wZ76vi/yOvEASu/N1PbWblWloyeTj0MqDjd3E
 KBkMl8dSvGQGsFzcg3amOMwo7nhEGP2J+Uy5t9UJwKuE/KJ26vlemyngok90wnCEEuGS
 ORRglJakTjP5CdMXLgQpNfQhYiYtlwN6gsYU8D/V/D3iYbPnQEDAjqOqqFt3wjgeX0LP
 oo9tnFFe531TIGZ1n+vjlaQxP/fUUOAilVfBuvYJSCR57Fkb5slQmzMN375dMIdMfv40
 s1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958216; x=1742563016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qF7NqSa5lV0sZZKHA8ojvh+EUzwVOc8Mo3QSd+ZWM7U=;
 b=gjjwf+FHFNnpN08QPqRCDHAK02i0R0LyiocaFrpQsanKB+jxjtzy6mKBEBjDE4kyXE
 W4xoPaF54Fn4yqk9U+QYUJVL+hHV64gdigpyh8io7nALz9BXmDU/0hjemWtj8yiOI0AA
 zWr3ko4i2dwF/eu3gTq+AVPcAaTGwcnAuEjWalU/K050Si7TH/AMHBjkatYn5iwawtOX
 l9n2ZQfSO2fQsglMYf5mpe2DN3rnobEwc5m4r92VfPGHm4o+TPtHQ4IX5dzbWq+RTVkR
 vCVY9qZExCgnY3AEGgs/he5UszIctoysTglSCzKAD/25W5uPLKdrKwIBHhFligtQaLCZ
 DUjQ==
X-Gm-Message-State: AOJu0YxTtRyTfyHgxI/1u3O0QSdZ4s3Zrica+q+0bf/mBH/R2RkixQag
 jGaJ0wtZL/rZW5XZBScIu8YXK6Vh7okBsLPwkOB1uOPnsK5IkX2NlAGhl1hXFZzpp9ogrnm7scO
 Q
X-Gm-Gg: ASbGncv6fuH6YTHuwQ7Td437s+6go0hI9eF6WHcNtxHmPUzoFRqXE5HsymGXuRe0FT4
 uyNbH6XNzUjueQvlpqCaeiQjxgzmLyqvv1Q+P9tG4JIJZdEGOKCLCghkRH0rmJwsJK/g0VF/5Kk
 n5XJrQOQbqNCU7KJxFCgfd5YYkScUIkcXnYJ0xiOlt2o/z8K9ctjdupoM3s858RIo1dNbuOpjjU
 NN2r3HW+3eJslAA+DLAPzmqNFNRd+yBPmvIVWuBGteEeSbXIMqq/NxPqRSfG2prokNzXloJAnT0
 r+bakGUKmDaI5AuNpiSd4dHE/ghc81M9i51DEsCx4fCXL4h4NgzSuTI2Nu8V0w==
X-Google-Smtp-Source: AGHT+IE31Uty6oqbl2uhHeRSn61r6HcMoaiY9NiNtXNitPcAKLEWUlTLxCsopAtzJ44seJ9csGrBMA==
X-Received: by 2002:a5d:5f47:0:b0:390:f9d0:5e7 with SMTP id
 ffacd0b85a97d-3971c3b0c29mr3683343f8f.13.1741958215718; 
 Fri, 14 Mar 2025 06:16:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] target/arm: Simplify pstate_sm check in sve_access_check
Date: Fri, 14 Mar 2025 13:16:36 +0000
Message-ID: <20250314131637.371866-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

In StreamingMode, fp_access_checked is handled already.
We cannot fall through to fp_access_check lest we fall
foul of the double-check assertion.

Cc: qemu-stable@nongnu.org
Fixes: 285b1d5fcef ("target/arm: Handle SME in sve_access_check")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250307190415.982049-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: move declaration of 'ret' to top of block]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 48e0ac75b11..39014325df1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1456,23 +1456,23 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
 bool sve_access_check(DisasContext *s)
 {
     if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+        bool ret;
+
         assert(dc_isar_feature(aa64_sme, s));
-        if (!sme_sm_enabled_check(s)) {
-            goto fail_exit;
-        }
-    } else if (s->sve_excp_el) {
+        ret = sme_sm_enabled_check(s);
+        s->sve_access_checked = (ret ? 1 : -1);
+        return ret;
+    }
+    if (s->sve_excp_el) {
+        /* Assert that we only raise one exception per instruction. */
+        assert(!s->sve_access_checked);
         gen_exception_insn_el(s, 0, EXCP_UDEF,
                               syn_sve_access_trap(), s->sve_excp_el);
-        goto fail_exit;
+        s->sve_access_checked = -1;
+        return false;
     }
     s->sve_access_checked = 1;
     return fp_access_check(s);
-
- fail_exit:
-    /* Assert that we only raise one exception per instruction. */
-    assert(!s->sve_access_checked);
-    s->sve_access_checked = -1;
-    return false;
 }
 
 /*
-- 
2.43.0


