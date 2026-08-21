Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A8C5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPFx-00023V-NJ; Fri, 21 Aug 2026 09:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFw-00022p-Du
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFu-0006Ow-Rn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:00 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495590dde14so8831635e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787318757; x=1787923557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p6lp+O4D/eE65qwxUb9w0dpA/8vp/oVveOpJwUREnbw=;
 b=eMabaMLj0xnnWMd6467caD9SyPUTYJ+9X1eXy9V0p735CnMS6308ITasLNt2iFqMYD
 dZHTDvJsEYrV/khY+Ac90OMbALcgAJjTxgeR8QKjtWNYANkMLGwW8b/NcMHR+ndo+z1N
 D+eZROF+CHs5uete21cYjyyUaV70tUfjfdz6gMMEoE4deSEfbpa4VaPOD0WL+OcOq9Gb
 CZKBh43XWbMvJ9LUBjyykf8PavSqUx07ATBNDL0846zU+2HzsxpTQps0m0bhFjBqEQMf
 R7pjxtU6l9DjyfyYSGTclOCk6wIhunkhA1yKtneVIoQez6jl88Xrpc6QpNv/NbcSkig3
 XCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787318757; x=1787923557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p6lp+O4D/eE65qwxUb9w0dpA/8vp/oVveOpJwUREnbw=;
 b=hK05rTs+NP+CCt0nZvjCL0RaCXCPqf5KXjhcCh7d5ynnVMrhJ11kLaUJo2DWu68obm
 B4KQsMSuByIyg/8VfLAyI1CGehhebOSk1rNEUrjMLMVpBoWQrTwo2at1DMa4QfwTDlmj
 h2rHHra/od/phdfaQLrWFd8Jvdu2Pj5K3llF2bEUL5zygmIaCWAd5VaxaXJXpNmCl+wo
 Kvzs7umxELvGYbw7Lzyv0OR6L8fFIK9U/6MIdzScRc5pk0BzLDuGHRuD2T1p3OEUkA2r
 +bA1A6bkeHib5Q0yzl4H4pe3bowGtya6WGYerCsZI+RNy8KUepo09Ht0NHKEGQqmPCpL
 lgnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTTWs6W/4oDk+o50uOaRJjrLGNulVV2VlpAid+3riBdfLHuov/ah2w3Ck3tfGioNabSygO53wLjpYY@nongnu.org
X-Gm-Message-State: AOJu0Ywyh2GFbSY7Qi+US3Jg16nrwCG3+hwot9QBDl05H3H6iT9fDnao
 zebof+r6GMRRBbH8SIs83c3FgRaFqMAc/eb0Yk0QE8sRlr7dBZTUhPxjbmSbLAwBWog=
X-Gm-Gg: AR+sD10E8fwDFEu1cVRZ+t9GPtp5UkjsBAhXahBJwuCbLFZ13av3Y1L2n9dzsQXud0T
 /deoNQ6f5k5H3SuJ8WdzCcAW+k2OKX57J40Ajb8NtAYriNmGbTCWfydZWxEEc1vpoyyASm6Yh8K
 S7e1RoinTKIFFrDazkxWLvna2FYmIyQ6ZGDgvi6pWLoJ5BQK26vQbE/Ae6US1VAVXoIIx0srJ/V
 ZTSLbLtIUZ6/unys06+Uo9xo4TjgYfPa0xkhGPQJBvZCVDLyNvanpH25KAXb2DwZ2XImwAfryXN
 /XsAgzx5NxScCHGjbvi2PqUoHeElRurZXca08EUNn7Y8HbMUsy2rRaer4/fR9GxeSd7d5Gh4Gjt
 2VVlN78yWrKy/EGnWFyy9I0B4YS2aQSOYFk+ak5c1/3UeJ6UJBCOWQ+CztdO5mmAhbGmM/k5aGr
 LoYCSRjUSmJ8vXV7F6w+bHEDsSHDuhVxo9/dxwj4NPZU9ydbFV7NE8EJUm+2CBrE8pEl/DvtGGP
 FRIUIWdcZePgIJFvL2zCV8ybqGtrgUJ34lr3gNWhK3mblAtUNwYGDJr34oYdzjQpSPexA==
X-Received: by 2002:a05:600c:c168:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499b8327af5mr109630155e9.8.1787318757213; 
 Fri, 21 Aug 2026 06:25:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm18770327f8f.11.2026.08.21.06.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 06:25:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Make CBZ/CBNZ UNDEF before v6T2
Date: Fri, 21 Aug 2026 14:25:48 +0100
Message-ID: <20260821132550.168896-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821132550.168896-1-peter.maydell@linaro.org>
References: <20260821132550.168896-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The Thumb CBZ/CBNZ encodings are only introduced in v6T2 (for
A-profile) and v7M (for M-profile).  We missed out the feature-check
in trans_CBZ(), so don't UNDEF on v5T or v6M.  Add the missing check:
conveniently, the ARM_FEATURE_THUMB2 feature is true for exactly the
cases where CBZ is implemented.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 055f3c5b403..df98dc2e34d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5783,7 +5783,14 @@ static bool trans_TBH(DisasContext *s, arg_tbranch *a)
 
 static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 {
-    TCGv_i32 tmp = load_reg(s, a->rn);
+    TCGv_i32 tmp;
+
+    /* CBZ was introduced in v6T2 and v7M */
+    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rn);
 
     arm_gen_condlabel(s);
     tcg_gen_brcondi_i32(a->nz ? TCG_COND_EQ : TCG_COND_NE,
-- 
2.43.0


