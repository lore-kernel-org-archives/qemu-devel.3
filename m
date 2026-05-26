Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1835DCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmf-0000gC-Ko; Tue, 26 May 2026 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsma-0000PJ-PO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmZ-0001LY-3F
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so6390606f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805761; x=1780410561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Qq+AFeXrq38eYO+wKoYXxQJ7Nf8N6PWvBk9ykPre4Q=;
 b=RjLbq3ANI/aGqkWaeXgOdoVy0NS0wEyH3n2jp56yi3x/7r63ZnTXSXg0iR9KosS5Az
 3NK6nOTjm8UPMEPEy9lwP3abXhgkT4pWJMkgZxYacuS6OGZ4UIqdq/aZMReB7P0yaiw/
 3UuT4vVmas5gcuv85MH3Bpsg9OE2e2qDNkv+H2gJP53cKVNT1Btz0MtMKn1Vnp73JdlX
 jh9NhnU2SQma6GOkmPU3dcLGdc9EbfPxV8+oXhhFMgzq5QGJTiGh6cE4AowpFbm1wayc
 TOgMiwUkQQCGLnrRd2Jsvkaa9zjmXqMbfrFmSoGcpPyyC5/Zfqpl40OcnpO0kOhX7ey4
 P+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805761; x=1780410561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/Qq+AFeXrq38eYO+wKoYXxQJ7Nf8N6PWvBk9ykPre4Q=;
 b=TsOOaF6S7Wg8ddOUtghkcy1ObEnXDp+SQo0GuMDIMF8Oh10Mv0jmEQ6qzHPETHbCAp
 mXokgZd/Af3sxdbiHellftA+uu88vDcz+lDl0ImfGUC4Yh32xK2fTNLKzpwseG+dzCit
 tlq78T0exjJw9Rj7NBF+1dhWErOMBZWlV3VFAUzaViq6ptNtgqmYXBdJzSRb/8ryfgK0
 Pkt0o7itVLSZ5CUoRxXV3hUpWcnYeh0fuFzpJNC0Cl8Y8htL+vC4tMDZM0DEhjt2MRx4
 syFP0M6FZ7xMZxo7YF+Mtva/QOdk/cah/IqTr4putCHK7L9rodZszdt5mZiFALnRItto
 U4RA==
X-Gm-Message-State: AOJu0YxSZ7Yk5zmNdX43nzi2ZW36kIu9eZBc9f6MU97a1m2XljN0B7P4
 10s6nbz0JYFh0rB15veMeOohT7VSJym0xiHAFn59Qi2fo4lxukCR2KgCeLo4OYUFo2sap3D1by2
 dKJjJ
X-Gm-Gg: Acq92OGQHbyAQNykMKsqxtOOO0Xkk0MwdVHEaKqyYw+yCQLfm1WgwRyy4jrDLK5ydOe
 gv6FIBWnWv9qGadlSHMLCiKjNWA0WRkgjCYqrw9z70dM8tHWRiPFJ7ZhdYpsAi3LspGjSd+iONX
 keFX3FFL4bQ62QpDWrw45H5kcUyZqIFWvzPjoOOuTSCGOZAR12OQKgOXbGbnwYdg+PZsUkOA/26
 QoYCFtXHVDiNDts0tyIf89SGs4D7QHi4FnM6QRJkVRvenM+huuioHHmVrQwvHP0HsRHihMMD0dv
 VDVJpVXagAUDZVPWb42NoQoIBLXKwiMv5s2GGiUEBo0Pi19eEtKn8cTJFW0ijjW1AD4wCGgyrx+
 ii8u7HK9QmeeLOATAn0meDf2dl8px0IL9ZK7oVXjwTNnTzWS1ONjArAHcuzC7eyoRpjKk/DLeId
 ZopuMpreGYvMq99fMBJmpvIkyYz3A+sKZRN1KgS5dscfT/piILFpQxs8RPHjYOfhniGOqVF+tpY
 T8CMvrH6pWU9XO5aneOlkFXak6kOtRx+Ympnet0Og==
X-Received: by 2002:a05:6000:2688:b0:45e:88f5:ccfb with SMTP id
 ffacd0b85a97d-45eb367320cmr35519308f8f.2.1779805761487; 
 Tue, 26 May 2026 07:29:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/54] target/arm: Set correct fp flags for FLOGB when FPCR.AH
 = 1
Date: Tue, 26 May 2026 15:28:27 +0100
Message-ID: <20260526142850.2326589-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Our implementation of the FLOGB insn does the operations entirely
in the helper function, without needing to use fpu functions.
This means it needs to handle all the fp status flags itself.
We aren't setting float_flag_input_denormal_used when we
use (i.e. do not flush to zero) an input denormal, which means
that FPCR.IDC isn't set when it should be for FPCR.AH=1.
We missed this when we added float_flag_input_denormal_used
and made the fpu/ code set it.

Add the missing float_raise().

Cc: qemu-stable@nongnu.org
Fixes: d38a57a3f ("target/arm: Enable FEAT_AFP for '-cpu max'")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260521122913.1565011-4-peter.maydell@linaro.org
---
 target/arm/tcg/sve_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 179cbd74fb..d884ba474f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5036,6 +5036,7 @@ static int16_t do_float16_logb_as_int(float16 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -15 - clz32(frac);
             }
             /* flush to zero */
@@ -5064,6 +5065,7 @@ static int32_t do_float32_logb_as_int(float32 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -127 - clz32(frac);
             }
             /* flush to zero */
@@ -5092,6 +5094,7 @@ static int64_t do_float64_logb_as_int(float64 a, float_status *s)
         if (frac != 0) {
             if (!get_flush_inputs_to_zero(s)) {
                 /* denormal: bias - fractional_zeros */
+                float_raise(float_flag_input_denormal_used, s);
                 return -1023 - clz64(frac);
             }
             /* flush to zero */
-- 
2.43.0


