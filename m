Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D8D6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxS-0007QS-DR; Tue, 26 Nov 2024 12:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxQ-0007N1-Ix
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxO-00020o-Kj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382456c6597so4109029f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640552; x=1733245352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7IwpV5E0XRDCMVWuelKluQa8UT2nyGMUY4zNcoWVPWc=;
 b=gKWSEkSLt0JiI39bdCYY9LIzCz87q9zqh61Zb5OLVGYELMJFFLxHQ+D75SYBglB0qx
 tFdiZ88LfmAM7e55hoUDFCvqXD720yj9KQEguyNVFYjAH0q/KdfYENh7rg9CbA5cySCm
 OYnsDubkwF1STYZnF4zrc2owfST2gGudnzlT1dpNUNZHU5t+LJPqdcARmZppqrP97tQu
 JjHi6F1Ybfi9KI5eWenslJdElUl2VMFD1FjkbrlOeQUxjI4VVJhHrsUpDJcQi7GefUho
 RrIqSPzXsW3upHikUoIdGeFNq5z2XMASoqL/qH3HifljZN6RVN7BUFWC0+YPiKATfpgj
 hwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640552; x=1733245352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IwpV5E0XRDCMVWuelKluQa8UT2nyGMUY4zNcoWVPWc=;
 b=tDnXY+T0Lh8V2lDOTFRYK0uC14QsEVObOGPL+d3aBaz3VvKVZxFQTn7P71BQvzvGL1
 FFgRfsUqEZQX/2S9BaLVelaz3jkU22TvcZ0pKp+m+GeLwHoKTt1JdF2fqt2lEqD1NxnP
 D8w35dOurKubTa/3av2uH8S1JwR2QVNaWp7a58UWjIO/3BoGr6wvIkHoXSdtVRXJrCBQ
 +HORSOtPup6kcjNBgX+2O2qeNIsx41KUwBUo2yS4XgFw+4AeuzsBwaIsvVEJ6yT8OMtG
 qK0grlSmmJsyd8vxq3tdDQrPt52GS3pVd7+IeW/b60UlMbOsczNzOBDRI3V6RQWrZzAu
 GZgA==
X-Gm-Message-State: AOJu0YzIJWv9DU8ciAPvN3r3DuogGEkHJovK3w30REsKwQCDY7ofteJm
 jBqPN7qxhq2z+XghUoAQoNdgS+8obgZfaTsVrtGjpUo9csPQ3wKPZO2Xr72FnEwqN15aARbesf0
 0
X-Gm-Gg: ASbGncv8t7jBbW9YioQBgr3AaJvJIKPCfEBeWKpsBuaxO+EhmSkGz1uY5xpLOGwyrvn
 iVNFjTYD0H96VrSnnq5kvSAL9d/VCKwmOIb+2OvMauTW98MzWVJ0EaK08MHOe39XOyL+geZIeyf
 Nob03CIOrOr3I+uDgS5Ig1rT4lMEKaWhZa16wRMGnWCeFJT7PDfaFkZi3CjvKUvIi+qbptrhAWH
 vU2n+aOErwFCOZI11rrkEoZBArv5lfK2WqUVf4cOPX1TIv8rH91jF9t
X-Google-Smtp-Source: AGHT+IF7V0FPJ3IPk2TwVevJvGbZMIjqbYaVlyrCbz1zVs1X0NHnu6fd/Hx5EW128zrXhhNtBBFTNQ==
X-Received: by 2002:a05:6000:402b:b0:382:5141:f631 with SMTP id
 ffacd0b85a97d-38260b8631fmr12818651f8f.29.1732640550112; 
 Tue, 26 Nov 2024 09:02:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] docs/system/arm/emulation: mention armv9
Date: Tue, 26 Nov 2024 17:02:17 +0000
Message-Id: <20241126170224.2926917-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241122225049.1617774-2-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a2a388f0919..2956c22a1b7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -3,8 +3,8 @@
 A-profile CPU architecture support
 ==================================
 
-QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7 and
-Armv8 versions of the A-profile architecture. It also has support for
+QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
+Armv8 and Armv9 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
@@ -153,7 +153,7 @@ the following architecture extensions:
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
 
 For information on the specifics of these extensions, please refer
-to the `Armv8-A Arm Architecture Reference Manual
+to the `Arm Architecture Reference Manual for A-profile architecture
 <https://developer.arm.com/documentation/ddi0487/latest>`_.
 
 When a specific named CPU is being emulated, only those features which
-- 
2.34.1


