Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC795D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbG-0004Te-Fq; Tue, 05 Nov 2024 06:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbD-0004SZ-Gu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-000759-Kj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so47251965e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805581; x=1731410381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PnNrin2zutii5G605GsXXECDkzBjAbg43NyhdUJVqpQ=;
 b=XAbjdke6kd1zmQT8+fvcuF3dLAIrSBw9XCpotNbN97JLwg2wWsspix9QuAPkS5m7f3
 mkzmITX0tTCA5DhJP8cPXQje47fSu967HfRR3xEbJtYZXivco13IP9OFNYYCwfXCtK39
 OfIiRntEJd3uPWyHbbrH+H5VS0SzOH6WNqXHpBThDf+9HmaU01Kr71/x+20k1addmYY0
 QbqioYOclQj6VaKCqWaHK8DiPxhQyM1tr405W4LjpJF3CRiwifdRsMUUZiukmWmmnlEy
 Sol+3ld54r/d2UrsHaxXMcj2AG1Ax26/cK0OJWorNowBkGCTGK38klv+bQ+RRtZU3fqX
 rmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805581; x=1731410381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnNrin2zutii5G605GsXXECDkzBjAbg43NyhdUJVqpQ=;
 b=elbIyzxHokx3rCLn0RRibdUXeIHgfFeuJhkpd1wDFrepqe9Ng4cV1RE8QU1aLzCn+U
 japc6GcT73vqGHgrBubAHhiDuNSKeFl/K8FYkU6znExlHmukWJUQVR3LdrMhY93JCg3z
 xmm9qB9mSNADNLAsUL0t3eEOC5rah7WM7sxf965ngXgS+trhuhKEkwyntfQ9IDEcW0xC
 CHu1shp2bJI8RgmFMNx4bE+p3GRvxqFcq8eQ60beiI4SLaAYdR56zy+vdQQl1CFxUsYi
 tNTDlOQVoLUKbH/3OBitUoraXeRWIJAzWj3+xhlA0eDzUL4XH2UZ2Lkb8ILhBh3Vx6Oy
 MRyQ==
X-Gm-Message-State: AOJu0Yy8mvfb1CUN6OZCwUWFu9S1tQ/hmy0r4FsYyIL9M1wrDKkPGu4s
 jogunaSwI58kIHfDV86444Uyw155AkqvgYZ/Ql1H6/OSkeIrSgnzwjcILqkhkZRT2g9f9FmuDWg
 T
X-Google-Smtp-Source: AGHT+IGz8KtdkPcB9JvJDxk72SqC0aDPmSwsRWDu5LgB8DxXwL1qEentDV1eNNXTDUKh4PLCqSLA2w==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr164576825e9.2.1730805580619; 
 Tue, 05 Nov 2024 03:19:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/31] target/loongarch: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:09 +0000
Message-Id: <20241105111935.2747034-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Set the 2-NaN propagation rule explicitly in the float_status word we
use.

(There are a couple of places in fpu_helper.c where we create a
dummy float_status word with "float_status *s = { };", but these
are only used for calling float*_is_quiet_nan() so it doesn't
matter that we don't set a 2-NaN propagation rule there.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-6-peter.maydell@linaro.org
---
 target/loongarch/tcg/fpu_helper.c | 1 +
 fpu/softfloat-specialize.c.inc    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index f6753c5875b..21bc3b04a96 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env)
     set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
                             &env->fp_status);
     set_flush_to_zero(0, &env->fp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c60b999aa3d..bbc3b70fa9d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -402,10 +402,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
         /* target didn't set the rule: fall back to old ifdef choices */
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS)
+    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
+    || defined(TARGET_LOONGARCH64)
         g_assert_not_reached();
-#elif defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
+#elif defined(TARGET_HPPA) || defined(TARGET_S390X)
         rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
-- 
2.34.1


