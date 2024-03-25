Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83954C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYV-0002IO-3p; Mon, 25 Mar 2024 08:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYS-0002HF-QL
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYR-0005dS-3G
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-414866f92beso7280345e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370153; x=1711974953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GCgvA2TmnxeKrt9Gh3RGTnMyC9ymehvv7sEyBNeOPwc=;
 b=Ub7n9wCgEPxRGmiMrvQ2/W+mRBsbiep1zU7SyHmLQd5rNW2bRSFT8oMIdZembEUPpr
 J22gx1Z8ZoDFebmlambCthYinal5rwel6TwcoAfMIG1gug9pQ8/HHZ6cG1/cYBkIs6aX
 v3ERejN0jlCI1DYRw8tBWkz0yq9ED7BbeE3eNyE7pIZt7L/1NSuoXXwOok/AwIYxfEk9
 daE/kOScckGyIWLx8+WMu+zZRupIs5mMDI2ESfX6UAsW3dAqdqrEGoAT5xYG3t3Ks5Hw
 rNt0E/A+U2Ug51l1pDkShFomabHStQZ9B4NQurinSJvcx/A9K0JfdMw5PVA1g1PmX08E
 CVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370153; x=1711974953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCgvA2TmnxeKrt9Gh3RGTnMyC9ymehvv7sEyBNeOPwc=;
 b=G+DwC84WGYoHjV95nC+b+gwG6POg+eh6s+MtwmfPU3EhcobWah81CH5aMrQr0plghA
 6IwjC8zYqrgqBOjd3aeqFQg7753eLGGfoWJsw3Dp1W4jtm1L0coi8ZG6KNf80wxGd6zv
 sR89GEilw3jd8Dcm7viw1nAURForX+v+EwWzzXP/BVz/OApJI7AuQmLJQFc3WwH5zHnu
 HO0i0IOXC6akDuOK6thaKZLAHRiRSBBrjCibuwLp1RFVnLgpddrpB6EdeY/RouOorU1+
 KQuveu5Wp2b+j37EjUpqQzRHeNBe/bCybqaTxtwesmgLSREWW4rAUAxh1RfVVE54xj4I
 rsvw==
X-Gm-Message-State: AOJu0YzkEqu3QcNyZSkdEUO0TGtiFu3KIke65agehSui0eIlGKeWPeeJ
 htkVQBHeEdcAbTD64mLMe643d1dQcR1yzpkCVzYNgUoDyMYjxh+UVpdKSDxFv2JfWrOVowbOik8
 K
X-Google-Smtp-Source: AGHT+IGau3cTAVloogSc3fTcgbX5s68SHA6tDLec6kZKBI0K4E+wqI+Kcr8FEtTwgeSdspxpDLN5KQ==
X-Received: by 2002:a05:600c:45d5:b0:414:869b:dbd9 with SMTP id
 s21-20020a05600c45d500b00414869bdbd9mr3072410wmo.9.1711370153770; 
 Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] hw/misc/pca9554: Correct error check bounds in get/set pin
 functions
Date: Mon, 25 Mar 2024 12:35:47 +0000
Message-Id: <20240325123550.1991693-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
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

In pca9554_get_pin() and pca9554_set_pin(), we try to detect an
incorrect pin value, but we get the condition wrong, using ">"
when ">=" was intended.

This has no actual effect, because in pca9554_initfn() we
use the correct test when creating the properties and so
we'll never be called with an out of range value. However,
Coverity complains about the mismatch between the check and
the later use of the pin value in a shift operation.

Use the correct condition.

Resolves: Coverity CID 1534917
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240312183810.557768-5-peter.maydell@linaro.org
---
 hw/misc/pca9554.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
index 778b32e4430..5e31696797d 100644
--- a/hw/misc/pca9554.c
+++ b/hw/misc/pca9554.c
@@ -160,7 +160,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
@@ -187,7 +187,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
-- 
2.34.1


