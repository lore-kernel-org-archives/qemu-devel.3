Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8FEC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcA-00055v-Jv; Fri, 24 Jan 2025 11:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYj-0004cN-HH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYh-0005dO-Vm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43626213fffso22181515e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736166; x=1738340966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nKR8uPNYLhAGe3FarqfGbfg+8VB5fh6HLYBVmEiiDLE=;
 b=W48Sto+0FSdiavBnRQW+/ZwOx+g8Xrm+itB2+ym76WWu11GI6awFBCohIpdLiBIHKZ
 E9EOZeTcXr0BKqmRNe51yntg/3QAUPyDljIbODaqwDILGM97Z+3N3YudIfJyTHADKWCz
 bZZJIZUHhpAwL/+kqm0BM35ht+C+G01tiDl3V9iaPMlhVJlvmT9L/HsR96GbYsR4T9ww
 bt29/uN1x5T8W+mtDlYOUaxfHHr9xvRXF1l5QAAqsRQTkrcJePpS08YDa+0AF12XsKTO
 jYeQLqSnfl6Eq3DvKMt3kAr9OK04D7i3b0YRZzJYx1HrOHa0BCchD7Uetg983ZC0SVWw
 yEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736166; x=1738340966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKR8uPNYLhAGe3FarqfGbfg+8VB5fh6HLYBVmEiiDLE=;
 b=blCRcMqUHu6WWj9n5cbH8Rq11eSacaBkyq56JKrL/uxFF+1gVPaiVGgoAG9mQqjTaE
 LJxSJa8uEjLnPQlsDazSqYbt0JZqI+UM0IzNhh58lsf/SLYdd2kYRXv5f+UiSnOJy3oA
 DKcwWaW/JJ5t89CAmTI91oRPoe2mmqcMnTQhemRRwlrNfXE6zu10XB8gu659aDU3oF8E
 YIxvhA1a8Lc/qMEwzYHrLRw7OU7NiXl//BMCRnIBZ/vbbW+tQBcl89ZOl+YTgWb+oYkW
 Hw3Kr3xWa35iFustVXHZwO+58JBSEfq1NlKUW0BXcdYMudlyCWWLvYy8CpV7i62SwvWM
 baNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtx3tVjgXL/yBd78PCG8fIx0VXW6H+0IH0AIL51RDKjqq1hk7+T57uk/tTsOlW98oXtyKf7sd4Avu@nongnu.org
X-Gm-Message-State: AOJu0Yw5cB8qSYKK2YV600GaB9TLnCjbWfmC8KqnVQzvQQIXwO9umwKC
 6XdVtB7Ns0Tlq4EwXVqRrTXtfjHwbrhV/FOK1DnMIzoj8ViIBWGjxwE9qwex2xkJCKJYUFaLyPf
 K
X-Gm-Gg: ASbGnctchbk55B9YGaY88H6YISEsK/Jadx/TiM6Psni6IodeGrbgz9GHpm+J4+lMjzf
 7GbVaLZjGaE3FuX4Q7hUbcAgyl2/7xwZeFt9TXU5KeGE+On2EmpRlUO3RDIr7Dy0dO8D82osf57
 vyum2SlXXCDnXFQBdNneZahMP34SFH0Uq1q4fMIvrc4+sJV//6pThrvMk8zgCv3miagf+4kButn
 keox39maHesjNUXXd5Hdh6V/+GjITs0rnS5TGdkC3T3g4p4D0LgsWXzmIx+oZjKv7Yb6ydCQIVJ
 +gifZP5Oq9g=
X-Google-Smtp-Source: AGHT+IG6Mttva2ZJdU/FCypjf3E6xFnEn7bAD3qOtpX+tYHcl2/SoZ1fzRwbZZobC/Fs1LYYidHusg==
X-Received: by 2002:a05:600c:5110:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-438b885b8c1mr76525055e9.10.1737736166524; 
 Fri, 24 Jan 2025 08:29:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 39/76] target/arm: Handle FPCR.NEP for BFCVT scalar
Date: Fri, 24 Jan 2025 16:27:59 +0000
Message-Id: <20250124162836.2332150-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently we implement BFCVT scalar via do_fp1_scalar().  This works
even though BFCVT is a narrowing operation from 32 to 16 bits,
because we can use write_fp_sreg() for float16. However, FPCR.NEP
support requires that we use write_fp_hreg_merging() for float16
outputs, so we can't continue to borrow the non-narrowing
do_fp1_scalar() function for this. Split out trans_BFCVT_s()
into its own implementation that honours FPCR.NEP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 66c214ed278..944bdf8cafe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8582,10 +8582,27 @@ static const FPScalar1 f_scalar_frintx = {
 };
 TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
-static const FPScalar1 f_scalar_bfcvt = {
-    .gen_s = gen_helper_bfcvt,
-};
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
+static bool trans_BFCVT_s(DisasContext *s, arg_rr_e *a)
+{
+    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64;
+    TCGv_i32 t32;
+    int check;
+
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+
+    check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    t32 = read_fp_sreg(s, a->rn);
+    gen_helper_bfcvt(t32, t32, fpstatus_ptr(fpsttype));
+    write_fp_hreg_merging(s, a->rd, a->rd, t32);
+    return true;
+}
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
-- 
2.34.1


