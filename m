Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C938BE7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4M-0007If-7R; Mon, 02 Feb 2026 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4G-00076t-SA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4D-0002i3-IT
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f2599980so15948935e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039252; x=1770644052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrzRKxM+gUNzaRlAaieIAxkZQfBhxlc5kLCyWkeZ6Cg=;
 b=YmlB/lR6fk/ca056Bi9O/mpmY6lx91CUMbYjntz1VgBmHiwGhaBZeOF9gHiQrhRzjm
 2zRqxAPUBetMYGK7vY3Qat2Ncdmvh05Buft3DrAaINb1kS2UgWUuwCDeCmFfE9BRVVjQ
 GeYOWK8LWhd+F9YtEntmm+wGRlcxTci2WRxMd439vCCDfHNPCHOoCblaKfGMkNcMr+ZF
 RbfExgSMInmJJiSP7tevfALGymXsvPEDGXzbM6YoHChoCsF0J+FbHItSvqyQJSOolLQR
 F8wBuhuHMfNUE4I8nubAJtxQ8+z/mjkpy7SRSeyx1U4+FJtD/l2Nx5OsBjnPF5p/+bjG
 U2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039252; x=1770644052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yrzRKxM+gUNzaRlAaieIAxkZQfBhxlc5kLCyWkeZ6Cg=;
 b=HOytPkCk0LjkD52EwMP79lN5shp9gf0rrUjGyom6pBRG12kUalVjIYjPHYyNg0Lcd+
 rIl4WzQi+8Ao/g05psE8zF2Ynt6kactbb0n2XKqaNj73se06Qq7mSsstzgStQ6SDMiR+
 1n31WdZofq8MZrqfzDKqnktizDhp+Fb+7eozYRbmH72HehD6NmJ3WyxUkLAVrk1Bocl+
 K9yReBrKhvONY2u9gI/NqxUAlhUXfSY/Q6VPRa7fgW/VnWKGDuDS3jSxBDrL+G/2RDEP
 vwoL7l7S5SDEadzHhMy8mtVmrazCcKKJv0wRakDv6iBUKwnCxXIvSBlVI0MdfzRGHZwt
 fBkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTtN4GhiGMnk5v3MEogiYqdrUe83736gkS5s0ripxHtOZ71noKdOIVJtn3SvqGTUC+LzUuimNFGzWV@nongnu.org
X-Gm-Message-State: AOJu0YwdLL/7JDIXQyFLs2Py+h2t+yD2GY+irvwwwKamyWOovHrePvNZ
 m/sK1qTIyI2Iq0FzMfyNt8MK6deVH+ZFyID+t8UYVPMjgo8ezKCF04La0C4NVUQS6zw=
X-Gm-Gg: AZuq6aKHPq4zUHzc8L1uuz2t2lRUFbqRrnGpYEQT4q2x14Mi5drQSOeEtjncUEGi6Qz
 NRJniLPBzn1kVPiNYzn1rCQZ49LaL17yS+vQ7wJCEt6g+4W0fJVhb128WtqUclK6QUTZ9geUOJ1
 44iRgaCD0b3rTxy8QVYr7SWr6VgtlYYPfbwMW7hWw5vhOgprRwWVgKWkiQoeYVBs14YWxSdV0Hq
 ObiVrlgZUKG0uWEqRMw9ERto2+ZIfRfSzZhw9PTTlmHWR8DKzhPNnrYuv82escwaEUMY7WQFYgN
 QAe/WCNE1yXLq7t0Y2gLym0HyzwTiPDadCVmudBlUe2zHnnkM38NpGqg4LIXWCh3Ei1NCYLL/Tj
 HQqvABPChPOdXuySiEgDDxZ9UvYic1tLdzTBQroeKulBb4MkNrt+gesWDvRTdv64uxuhFv0EtPr
 15uG3TtqJAZ7FeaxwuCOtkX+1ToRyrGw==
X-Received: by 2002:a05:600c:6214:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-482db49dbd5mr136827055e9.34.1770039252023; 
 Mon, 02 Feb 2026 05:34:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 14/15] target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not
 present
Date: Mon,  2 Feb 2026 13:33:52 +0000
Message-ID: <20260202133353.2231685-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FEAT_SME_FA64 allows Streaming SVE code to access the whole
SVE instruction set; it requires FEAT_SVE to be present. If
we have a CPU with SME but not SVE, squash the FA64 bit in
arm_cpu_sme_finalize().

This doesn't have any effect at the moment because we don't
let the user create an SME-without-SVE CPU, but we are about
to lift that restriction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a9c1e60c95..c0447c8d54 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -385,6 +385,11 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
         /* SME2 or better */
         FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, 2);
     }
+
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        /* FEAT_SME_FA64 requires SVE, not just SME */
+        FIELD_DP64_IDREG(&cpu->isar, ID_AA64SMFR0, FA64, 0);
+    }
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0


