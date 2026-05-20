Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DF0CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZA-0001W2-E0; Wed, 20 May 2026 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ8-0001Tb-RX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ3-0001ya-6A
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-366330b6751so4100909a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297516; x=1779902316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2TQZHGKVgc2bDrawkrfHaeofSO+VDdLDbwQhXEPuBw=;
 b=Hka0hQj2x7QktpB3K7gwYBg7OFJw8WzFkKwQ2Whcs9seU/5GWeyEW6whi+5m3yHHLv
 uKQiiUN5kM5J5xJvT/F2NJsJGrChOagrr8hsvldZEqmwTChPsqf7+9l0x/3aXCSyKm9p
 4oOLYLr4RgbxcadOL3SNz8IGp8gja/BIwP5195znQ0sX68pB6ekwRuF9vYftGmXMB4iQ
 UppM9DJkrhwf/Br3py99uY1wQ4V1xqaJUZQ8zPGvOJEFtR/5NebnqWALU799O/J3aGBU
 Ut2WiKnxiCQw7tqc3YukXw2CLTwYjVt5GhClQ6ovkv/j9cM/lHV90+CQwZe9gyoykoMV
 EUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297516; x=1779902316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2TQZHGKVgc2bDrawkrfHaeofSO+VDdLDbwQhXEPuBw=;
 b=VOJcfF2ge0jl6T47bcVjUuBPIgaLc9lfKapDsabgzQ9f+zw+00QBZpaaVRVvUyjXyK
 iiNv61bQsbPzQh5cHDIywxTJ0gLNYlXsYp5yeg0DWS9aATX4FHNQ2SQLM9MmKUfwF46P
 ajVnBrX0bbpzaOX4Rct5RWogooPynKCfY9UNylM2cIap8rKfpFm9YFGUhNO3vSfUDcUm
 zPWqIg5SmyQwbQvw4JL3pEJJz6UKmEtYG+m7jX+bTk5Fx5+wUJskWRJhhowZFwqbLbqP
 hnu4/Wup46Rcqu+RWNhsWHIj41rbeK9Vg2wHas79dQ++Ga7LY/JRwCVUQ1g+utzRLWi1
 nalQ==
X-Gm-Message-State: AOJu0Yz1t0vHyfC3GbOUt7Yju0GAMOWOjKcW7JpsVGv2rF3rYBZuhq6X
 0KWBwpQZXQmd2xJ2hTKPsOLy6gF4nBtLbI5yZPBTdxSgnEiWWo9hd05gB5/l4WVkMHjEj14G6bS
 G75MwgTQ=
X-Gm-Gg: Acq92OF1sQizT8aB8F1uPLWnVU46qcNEBI1haNQlgprBhreoKvqNfTvVTKKKIfGdIxi
 B9TeGSXrfHos+410tlQcKoGfvKYhCn8Uey8ixde28I3q/F21c65vRGeVMOGf91+QCBkmxmL0Ogr
 tS1eRInkRhjs0b/9ZLvGMjVo1Dc/3Z+b3DhekQiiFJVUxQ1nQRHARWHLY8pB4u0OdPSKw5wF+jU
 /l6WY8HzY7BWzl6rkwKD7c3FzgxKy43iPQcx2X4H4uutq56SlPpPT8brU6fafzEPEJ4vttqVQWY
 HeXHAXJzzhxZkYtWdLILsyuyWFZq/h65cJBs5CzldUxDx58qaMbp7bsAKFEZ1zhuOb8FWXn5tsn
 EFWd9vbCwdH9fLmqZ6f50slgzOMY+t/M5WSny+JzdMsHzB0MnNo955oOFukBNa8zlqu8EOVEqfB
 J2nREYN4JQgiHvp9/aMqfSzOcHcbK1neGV30UTCQw=
X-Received: by 2002:a17:90b:560b:b0:369:f48a:f245 with SMTP id
 98e67ed59e1d1-369f48af48emr9846534a91.4.1779297515713; 
 Wed, 20 May 2026 10:18:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 19/30] fpu: Use get_float_infzeronan_rule in
 partsN_pick_nan_muladd
Date: Wed, 20 May 2026 10:18:09 -0700
Message-ID: <20260520171820.848839-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Deduplicate the uses to a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7781e16122..1e92251761 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -122,14 +122,14 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
+    FloatInfZeroNaNRule izn_rule = get_float_infzeronan_rule(s);
     const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    if (infzero &&
-        !(s->float_infzeronan_rule & float_infzeronan_suppress_invalid)) {
+    if (infzero && !(izn_rule & float_infzeronan_suppress_invalid)) {
         /* This is (0 * inf) + NaN or (inf * 0) + NaN */
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
@@ -147,7 +147,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
          * Inf * 0 + NaN -- some implementations return the
          * default NaN here, and some return the input NaN.
          */
-        switch (s->float_infzeronan_rule & ~float_infzeronan_suppress_invalid) {
+        switch (izn_rule & ~float_infzeronan_suppress_invalid) {
         case float_infzeronan_dnan_never:
             break;
         case float_infzeronan_dnan_always:
-- 
2.43.0


