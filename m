Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A93E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mk-0007Mb-Jn; Thu, 19 Feb 2026 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00078U-7J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:25 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MS-000644-RX
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso6185985e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497256; x=1772102056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L1ctnhdXePTfsqLLCfBe5tFGjQ3Y/lUw+bu7pneikjI=;
 b=tolIJJiAUkaEmFdsm0rpWtzgR3r/TTIwF7EqXYWuZsoIRf6Zd4OsVE1//WJCIuk7kN
 FONdgEFgYpRaV9fD1nLi2qu3GNjerSF1U2c1EREIFdXd1/ruXa/lYB03ZKWUxYy42I1p
 vJCKMHAm8NoFz9mIgyMRm5WY9FxACxXZWqzChEpUqmLeEPbR/ynxr0yJ1fsr/gNsxxQr
 HiiqOvBgkPDTbNy8hmsM9699mCWPJgkf5zSw/D7ctBWqBFnp4qEydSUPQ1Nz8Hgo5UcL
 eVExzxbsckf8Okgw2NXDhVHmO19FkqFY0Jrnwp1shF1SmgBr42HNijQ9rNNRXocJ7wJF
 CyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497256; x=1772102056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L1ctnhdXePTfsqLLCfBe5tFGjQ3Y/lUw+bu7pneikjI=;
 b=cLXxCNcptDi4RCe0+EuB9x/xLCHuO2mOknXDYB725Eo569XC3Z9lzwS5ZuyOip1baF
 Otd32oHH2EGkb/h7okY/wbj+6qQM54oAg6UoOvRpRoCojpXTv/uTmBNEGi5CXzr+r4Bl
 o0QR6Lg0s9/X8LmoBMCKTbNc96hq6b6ZHBPdE6oForHN4BSFCKaJRHt7/HtWRIQGe+hX
 exArFPtnRqqBwIZUsUFJay8yb/xShAZ++2KCFY8WM4LRdjwnjUKEiyo5gNaWlPWzkhJQ
 sQ+mrDGUxuEQiLdqp+sBHIpSdv+7PXoEaXpCZVjUvBPNtwyr2dr58dXLhyph7d1EAyOW
 +Gtw==
X-Gm-Message-State: AOJu0YwtndntiAPEJCsWeYRUclLbfO0n1nNPBY/g4verUiALvUQJ2LpF
 5kZfx455O0dOvzZBbGlHlqB9DlHGRdw2M4MDtZFhfGhF5tVIvroX/FO+PUegt9helsFy4wTCuhU
 ORuLA
X-Gm-Gg: AZuq6aI9VlS6vO82M+70VHMyrE5FWaVetfAR5HtJT1lIcPUWsEykmAHd71+eFxSB8iv
 NF/Iqy5AGqpEKnyrOLyn1C0k4xO67GXniEbP1C5aXvocFwWpCidNPQRyT6uU/gOvAlVj7AQJdgC
 jIof+nM+bbXOGG/KthZL49nB5JkJmIIUdlCFg1S9fgGYZZmvBZspxPtwK5VPxO0K0Yohw2Ne4K6
 RW02uNvmh9uTQbYKfaapJWsXKuuXMsQncunXn6A02LMO4+XPP0ercZwINpXbT7Lg2HFsP+gQ3N3
 8/eUAMfwSIDGbJm4QONm+96DXu1yy7X4UUht/dXdBWvJI0JZZz0yJChx0yEEDV3ZMy7YwzzaA/D
 OWPCUwNNrG6myQBQun7PnQApJKWwLIDD7K7xv1PqYm7S+nE5KvL0w7kpipCMlP6q0c6kh06L9xg
 KmYGouNhO5d+GrBQdutcIWGFO8q556WSOGYRjmR+oBZtMmJ9DQzBrJE/319DUY8uUuyOn77xil8
 ZDb3vLj97RTx4aklzcCXcOr2ujh/pE=
X-Received: by 2002:a05:600c:3b11:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-48398a52be1mr97974545e9.9.1771497255666; 
 Thu, 19 Feb 2026 02:34:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] target/arm/tcg: Drop unnecessary aa64_sve check from
 do_trans_pmull()
Date: Thu, 19 Feb 2026 10:33:42 +0000
Message-ID: <20260219103405.3793357-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
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

Part of the logic inside do_trans_pmull() applies the aa64_sve
feature check for the non-128-bit-element versions of these insns
(PMULLB and PMULLT).  This is currently a redundant check because we
only invoke this function via the macro invocation
 TRANS_FEAT(..., aa64_sve2, do_trans_pmull, ...)
and it's actively wrong for an SME-only CPU, because these insns
are also available via SME. Remove the unnecessary logic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-10-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e853b4dd0a..fe59126d2b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6782,8 +6782,6 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
             return false;
         }
         s->is_nonstreaming = true;
-    } else if (!dc_isar_feature(aa64_sve, s)) {
-        return false;
     }
     return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
 }
-- 
2.43.0


