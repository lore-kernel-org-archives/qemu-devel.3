Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20245FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLO-00007g-7W; Wed, 29 Apr 2026 18:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLJ-00006l-JE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:17 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLI-0004nC-41
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:17 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so142740a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501515; x=1778106315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FtnIdI9pw6cJ7qbwPdimy6vNdGRmRCr1/CjHQQ42OQ=;
 b=JzUGKwiJWwaW0WriRvv9kjDx7iYfEF1DCkPNqc9vCDsenskPFsl0G6DFYYfULy+AFv
 d+uGbBjAvpKzS9Sy45vUi2H2yRRxGTWFcvAIhasUJwx1GlpCczm6HC1HTS+s0nIF06HT
 4r8wpFioxOxD5YNBG0MPmLioYGEwyH5LpCl7nWFdPYDrby9ptZi3995OHreJSJiM4QRc
 T2mCk/8bEStjT97GqMOMVYqtfv7OySig+07AF7eiNFRIwN3o0tud34RGUp5RGaD2rvb1
 Mgdo/5oV+RLJRG9MGZvDmi2E8sGc7bzv9ZrPXYr46vHzb8qo7N0XE3wwSVmipN7DVBOl
 6Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501515; x=1778106315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5FtnIdI9pw6cJ7qbwPdimy6vNdGRmRCr1/CjHQQ42OQ=;
 b=EETRPegBJddCJx7kJ9rCs0OMlfrv2FovNVBG1dLevti/81W0lexh/DiyFlE9M7NYdk
 RXPDlSmxexLDYZI3NpUMoqg//cdd5twxYJ6kgp03t7d8IzPEQYBKlXPs7D1880XVHQcQ
 JNwu+0bF77sQWaI4riwjJFgckxlAreo/QFFzNr1UFcSNgCei7kv70YFJQvUhT+lJ0M3B
 Lgk73PQLR09HFkKfbrO4Ws55ORpFb95iQcZQ3N1vt6SZLNmpDDTHKscBzbAUfZVD0/aE
 Lp0TZkADd/TgLKrHU+gZdVbvjRXA8NRaOORsEkoUzAb9p4rJ14Z5qK/V3X38bfd0Iqsx
 uxKA==
X-Gm-Message-State: AOJu0Yw0j9r+uuakqVmKLFnmxqObnY6r1DJnGK0R8jdpiRikGWFp9B91
 C7a9EDXKfZHvK7Wn/QkDMBHFcorTPIYjP++n/KYXOkunDIbcFLd4QoqDuj74BHzcGmMn00tNxH1
 m2CiAtFg=
X-Gm-Gg: AeBDievZfle99FjClOGL8Ry9DOrB8dBYrQ6/T+GpJZREZ1647xSqZOS1kf8fyDUqMZ1
 nr8Mwu8HD5D3CZWJ8h6ZFYYEegfgA0p8OISmMbpBZTbVcDS88SpB2L6L0Q1IwAo+jGH7uvqF7JV
 lHv8ipETC/3YbcXbv2EhcyIIogh0n0K76VUPSzacg0QexoHJGOLdYjqXS7ZEk6Hnv2w5f1JJPvl
 VGVBFO12nD84mU611YBLK6slzpaq5TIl3D3Hk+Z0Pbj/3R2nyY/AvM+KGl4pt1TMz3Hw69Op2RP
 WOMWX54rbXgGIPX2gs+BB5VkIdZUMLSafsSLlDayax2+zAOqLG58nfuSFNlZw51EFyl9FopI0mS
 4KAfjefL5QSGfJP+v7GgIw8e+gSglmKxVMZD31yEKhbPpULQhM6VaApSMwiud3YyaAd92o6NXxT
 SO0flXZ7PudnYahMRbu0AleH/+fshcRG8SKqHZf5Ko
X-Received: by 2002:a17:90b:5890:b0:35f:b5df:449 with SMTP id
 98e67ed59e1d1-364c30e18f0mr183144a91.21.1777501514530; 
 Wed, 29 Apr 2026 15:25:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/48] fpu: Reverse the order of softfloat-parts* inclusions
Date: Thu, 30 Apr 2026 08:24:06 +1000
Message-ID: <20260429222445.26301-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Define the widest addition primitives first, so that
they're already defined before being used by the
narrower muladd primitive.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e5d8b9573a..aa96ac530d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1638,14 +1638,11 @@ static const uint16_t rsqrt_tab[128] = {
 #define FloatPartsN    glue(FloatParts,N)
 #define FloatPartsW    glue(FloatParts,W)
 
-#define N 64
-#define W 128
+#define N 256
 
 #include "softfloat-parts-addsub.c.inc"
-#include "softfloat-parts.c.inc"
 
 #undef  N
-#undef  W
 #define N 128
 #define W 256
 
@@ -1654,9 +1651,11 @@ static const uint16_t rsqrt_tab[128] = {
 
 #undef  N
 #undef  W
-#define N            256
+#define N 64
+#define W 128
 
 #include "softfloat-parts-addsub.c.inc"
+#include "softfloat-parts.c.inc"
 
 #undef  N
 #undef  W
-- 
2.43.0


