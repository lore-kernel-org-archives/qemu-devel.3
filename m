Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A708E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mb-0007CJ-1e; Thu, 19 Feb 2026 05:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MT-00075f-J1
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MM-00062n-5u
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48069a48629so7844705e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497251; x=1772102051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qB0g51eHPIGsbFIfbn6u6D25SBHy9hNdGol0ul1NVHo=;
 b=UoS8GPVoLJmcrGU9NYTEDmLdDFRxPWxgn+UueTzlVzZqcvr6DemkFLiTSgycndDX02
 9wb2AzhLgf/pMMGOfNornCi3sOix2qFzW8tdoQOLPhZl9XBHR8maGCJeMkZnbH+wUQiW
 HrIdBB76q/KI9opTZhtpdDzTfxqqNHdCWBKioablk/rLJW9bG0ZMhpjwv6zowga9vV8D
 SyoEfUZVyxbe+wKRad4NhpDhe4iyDPEPDfjx+WHRW/Zl+r0Au7Zw2eBOJF9ZxG2C3ytJ
 XX0NJ2vy2yk79eFgehKnjAOiau2QsIA/2Ma1Dh1Y7flaMKRhw+1SWtefyt8P0Yp+K7qC
 B+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497251; x=1772102051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qB0g51eHPIGsbFIfbn6u6D25SBHy9hNdGol0ul1NVHo=;
 b=fhAEK22nCD6h37ztT5QkiEeV8A9bhGb1IE2cD0EuPyZNtMxH9gFPKr/SMpLjSN5nNg
 RKC73NGXC6u4Qqf/kxvCnWG8Us7Qbvq29qSDUpRTrEqYniPrspPn/sodIdLX758TtCE3
 y5nCD4kFdZqf8KKzB6OtUuxmb+xvaAickngkmERzQZ1D9JhC+vw+wYrypUY2q3qJ86Kz
 ZkaG/xDuh9A8/S+ntClCSRyrbxHMgCPBpzvbX2jWgZzgvbbg6CIxgE0OYdJH8Fuq5BBB
 yyMfbhdhVxU/Ro+Pp+m2diC0auVpjN6PYPZwu+82Fcn06elbf+KIdHe07BShzV9TNXb8
 i9zg==
X-Gm-Message-State: AOJu0YwW7O8fd4dGSSOAAUsXn7gV0ATAEtxVM+hL4GZw8FcM004Mpx8Z
 br31Cvlgk9yF840fnDeBExEYMyMVibh8gFZeN7HgPsfDSEqcGWm9T8pec/Fi1aCDLPPbsMlTiF7
 7t04R
X-Gm-Gg: AZuq6aLWXPCdWS3Fa6/dzHMjvtZqWtdjaQmFDrzJoRYGSXaqKry5Z1QlmNO0qsNbvuJ
 DP+x8bbsx5/KBATusoySpV7WR0YCywkm1iyhZaZ2hJn/US4Yu87KdneHWcCM6amXINfEObQGwaK
 tAig9V7EcSshFjYEJapn49fw5UtEWiWXZJDFbmZkDEXKNYZcap/jaUW3CAUqebILpJqZ5q0v6EP
 4Pqqkg+v4vgMhoiEg/u0uHEIyoPoeyq9MbsdmCZmdv68P+awyUuoPiL7WkTSRYVeTFYM7aona5l
 XTYcjf39ux425WvAl0SDU2m45dHTWGE1SuR54u8Jit+hg3r9WH9h4lST+0pfUSmV0OsqbG5KPKt
 fddAECxF2GRENW2sWjd1SA90/wwsiakQhB+/KdC6wekb5PeHVLK0VBG8uNCSxDwXUW9xLVwv2lZ
 KwUC1umZ9q17mkinphzLSxESzzwrhyk21WUG3j4DecJbOabX1arr7uYBDFpfzFMcm7y4lmx4Eja
 7CvGf9jlFhxYf7AQ1sqgRdvgBSl6sLzD+4EQ3/8IA==
X-Received: by 2002:a05:600c:8b2f:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-483739ff865mr299370645e9.4.1771497251352; 
 Thu, 19 Feb 2026 02:34:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
Date: Thu, 19 Feb 2026 10:33:37 +0000
Message-ID: <20260219103405.3793357-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The SVE RAX1 instruction is permitted in SME streaming mode starting
from SME2p1.  We forgot to allow this relaxation when we implemented
SME2p1.

Cc: qemu-stable@nongnu.org
Fixes: 7b1613a1020d2 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-5-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 81f487152c..e853b4dd0a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7803,8 +7803,17 @@ TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
 TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4ekey, a, 0)
 
-TRANS_FEAT_NONSTREAMING(RAX1, aa64_sve2_sha3, gen_gvec_fn_arg_zzz,
-                        gen_gvec_rax1, a)
+static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
+        return false;
+    }
+    if (!dc_isar_feature(aa64_sme2p1, s)) {
+        /* SME2p1 adds this as valid in streaming SVE mode */
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
+}
 
 TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.43.0


