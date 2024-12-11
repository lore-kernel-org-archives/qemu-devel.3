Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF80E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSp-0001Wm-E5; Wed, 11 Dec 2024 11:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSi-0001IE-2e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSf-0007sn-Qw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so5144678f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934075; x=1734538875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+m7UpkWXOD0kaMSleyeT/gE67bFfwBTpfKeuDgBDdb8=;
 b=HFBgsITz8lrQ7HgtPeEsRx8aXiJZdJGA/DaNzap5B/mQO01xx6FyuFEt7rOQK8KNtG
 7T+zTQmbETUZjMRjWNyVw7oOw9DRO/jbU2uke5at99ZTuVf6NOl1dtoSvB5w0TKCPou7
 PQC2WXPCEHFTYiIe9dxFUMMi5J4kv196Od2EPrAvCOrzSxtFxkpAkZZYQZsCDdd2tODj
 ooZA+nrEA+PUHqm976+G46fjPWrBE0vOWeArSV5o4CYoQuhaoeE44twb6p0FYXC3DACe
 Ncw9pF4tFJeZ4bsRrUZVDbMwc0Tg/EvmZbcaedYyuqfpeVStLpc3NWCctqxjNcK/6jaO
 dzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934075; x=1734538875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m7UpkWXOD0kaMSleyeT/gE67bFfwBTpfKeuDgBDdb8=;
 b=HfdmrxjgH8hEjHgNduCc8wB6Vg4cT9lTvXTdI40NnH7rnJ0gQLR0hxHp/ArHXm/ue0
 TGvCPvQnEKaqLMRnH0oT0Qo7Q0cX23KA4jLTzjXi2kzJdBhxm5LFLrsedgLc9lrAfkei
 Tj4cLLrb9CeD69ALzWHJmKcLNhDd4nVhrWHJ8fmA7I4xe3iFQbYLzoEd24fkhfcMUbti
 dZuUxbW3ma0Na4QWiml5IJU4ZMR0NNC3kg6FDI2Pur7G0veudRGKHXUeWWshsQtbUHmr
 gondn5sAYlo/c8z5WwbPdJVGIKnru0AA2ide7yhdtDS+HKdaRG6f9mELmsBOtPq1u3xL
 GH6A==
X-Gm-Message-State: AOJu0YyC7hwWZGW5rM2+ndZeDNKLhghUdWg2gkUgBPrrCkDjzOgmuJhj
 W1SCW7xIKws9KZqaY/nddY3+i+iNYAgZxNhjtmUksqn+lpFDP8fEc2tPMfGnOtGCAGQeRC9ufXB
 c
X-Gm-Gg: ASbGncuI7/bthH1AooEFMA8W+vMhR6rXLkFnfy9Zsma7i5w3cKunEdcBbyUeTtrliGV
 dkHCiOZN2ijBkvWL+hGyhm/bt0DsjDcLkUPqHKU48xtH98NWzTJlR6XCqOFttxSV6y6R5TncAuj
 6dW28wY6BqEN/gj1M1i7n7FIi/QK6XesXVweX+V9+TsiHrOyy1xafRjXi4BGmhAMSRm04Dgb6cz
 5N68esho8aAqB83LjLi0FdSvQtPHvWBB8ZkP2kQC1o3LVyrsGZiAp+Lajus
X-Google-Smtp-Source: AGHT+IEMfZL6b5VV69W+JW/c0lvj4LORiteHdoaWiUeafzKSnSELulH5iEbr7d9LOvHB+4DkGx9cgg==
X-Received: by 2002:a5d:6f16:0:b0:385:ee59:4510 with SMTP id
 ffacd0b85a97d-38787688638mr208420f8f.9.1733934074780; 
 Wed, 11 Dec 2024 08:21:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/72] fpu: Remove default handling for dnan_pattern
Date: Wed, 11 Dec 2024 16:19:52 +0000
Message-Id: <20241211162004.2795499-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Now that all our targets have bene converted to explicitly specify
their pattern for the default NaN value we can remove the remaining
fallback code in parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-55-peter.maydell@linaro.org
---
 fpu/softfloat-specialize.c.inc | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 5954a6213b9..e075c47889a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -135,20 +135,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint64_t frac;
     uint8_t dnan_pattern = status->default_nan_pattern;
 
-    if (dnan_pattern == 0) {
-        /*
-         * This case is true for Alpha, ARM, MIPS, OpenRISC, PPC, RISC-V,
-         * S390, SH4, TriCore, and Xtensa.  Our other supported targets
-         * do not have floating-point.
-         */
-        if (snan_bit_is_one(status)) {
-            /* sign bit clear, set all frac bits other than msb */
-            dnan_pattern = 0b00111111;
-        } else {
-            /* sign bit clear, set frac msb */
-            dnan_pattern = 0b01000000;
-        }
-    }
     assert(dnan_pattern != 0);
 
     sign = dnan_pattern >> 7;
-- 
2.34.1


