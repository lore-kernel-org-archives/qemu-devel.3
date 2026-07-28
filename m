Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C28CC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofnj-0001V6-NE; Tue, 28 Jul 2026 07:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofnc-0001S3-A5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:16:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofnZ-0005dn-Mp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:16:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4956869750eso28097785e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785237395; x=1785842195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+VC5XlZjOD0If4uBQba9NfUJ8lBSE0okGvUEe+SC8+M=;
 b=sQT+3ouVbvuv6tj5giuRpBKDmh+T8Tu5aWeGFzulT3mA7L2kMVh2y2/nipk8ftsMIk
 dSPtr7nmEN8IeiQeDuH2T5E+9TmF4KPIrTFu6AgMJU+6q06TGpkSnYKG/yZK8U2bDobJ
 n0NNgYjsGecf2VwNVKw6b0uJzddHyZxNFlkms+e6yk+guE/tOReNHkFEbhd7dab6AcCN
 n9dLeb8nDohr08r6fS0bt9KMoX/X1TqCw9jzUBdTshnofAMJlEmsZ38Iz3jD5ZzAx4Eu
 QiaUb0zTgUqexqGKMI0zLZbVZ+QZR4SwQ+2jpf/m+uLEsT8OeF+58GqFbp9Rsg711/Ge
 DktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237395; x=1785842195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+VC5XlZjOD0If4uBQba9NfUJ8lBSE0okGvUEe+SC8+M=;
 b=NcRXOg84Ftn2rBJS9AbdK9akntQh4eajnKzToYo45Uhdoxya/edtwpmHmxtMrGQi0T
 c2l4mRmlCJ5zCD7aVYQkqFemwyvnRkDFyk7sgIfA+ffkh665hF/K7cjD9ORgd3uUYb3k
 eWypolbfEi4ir3imBZ1CYoNopZ83TXNOGrmpENzEi7h4X8E6Y0F5VCl8T83YbpTX1SGK
 4IXLRwyA4nfA2Ar1WFqgUwuJ1xdWH50KK6Y5w7Ft3SMmNjVZVm4qABPZHpX0E0GbhHLm
 wZSGQIlKQFvuF35Dgi+S79dwGggtpraBx4u3mbJfEeFO+5awxFJrjGyjhlpUJ17FgY0w
 cCHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRGk4rA7KRwOch/IG1TYopARFGodVdAhmYZQP4v/OIADsZ0i2up4K1xn6DdsdaFKv6v74AnBFK3diL@nongnu.org
X-Gm-Message-State: AOJu0YzCmgdS0LCBFm4zHXjChS8ar0c9r6PYMOPH6W+f0aFOfvLlAxyf
 eKgynQVqC6+pZyOJnvQu1hd9+8Ys06fvwt+Slf8heyvAqPMBAUirQlm68kvywwJcoKVkPVrKxed
 wqpjW
X-Gm-Gg: AR+sD11Y2wh8ohMathd6NALi/S7uF380RnGGhsTk1gPDVQWnB89n+4QilLwwEqgqMR8
 OWmau9I2acUrBh/NdxcTTnOW3RMyeZ6f8mVAyIWvUiOpUhTzB7oank5lnWdTUF2/h19T9fLCTcV
 w93jy6rMtBe1ZZsnzZEEYltLUn1LGaGYenunhGx80yj0vUxmIYyzJXebgGb3iprgvl/vxkCahim
 Hp8LFu2GTBDKKE/pd1q6tcBACyz4BIpQIYOBszEPuh17fJmaUZGYonrq+/MoPBMyxZG0TaOveQ8
 qUfIt3CnnMA0FGt9ecUgQrcCx2lTW1dw4QQPE95np9uflS99OHMt2FtQiuCrmly0MQg6KoyEJzv
 vt4WEusqXAQQQYeGg/cDMbggHyMOX9EU/sdkogy7rwRJSGAEGSMixSxI2vVuOcdID+wafmYvulU
 LbqcueXgPTQCrjoEukuwNS4WfdjUwNGJpACkG2256RHZd67hLj+4Jf0amRDn88alzsb914VVzy3
 176TsoMyNU=
X-Received: by 2002:a05:600d:844e:20b0:495:5375:2510 with SMTP id
 5b1f17b1804b1-496c6568a37mr15038315e9.24.1785237395488; 
 Tue, 28 Jul 2026 04:16:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5ed646sm284546255e9.0.2026.07.28.04.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:16:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH for-11.1 3/3] target/arm: Remove stale comment about WFE/SEV
 implementation
Date: Tue, 28 Jul 2026 12:16:29 +0100
Message-ID: <20260728111629.1705308-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111629.1705308-1-peter.maydell@linaro.org>
References: <20260728111629.1705308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

We forgot to remove a comment about WFE/SEV only being implemented
for M-profile when we added the A-profile support for this; delete
the stale text.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a30afcbed..c0492c8dfbc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -766,7 +766,6 @@ typedef struct CPUArchState {
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
-     * WFE/SEV handling is currently implemented only for M-profile.
      */
     bool event_register;
 
-- 
2.43.0


