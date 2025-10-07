Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D33BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R3-00068r-FK; Tue, 07 Oct 2025 10:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qu-00061k-SY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qe-0002Pk-Il
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so32553755e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846351; x=1760451151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=atUnk8Przy2b+arpo+tXXmWSEKJkyumG1wRWNZoP8OE=;
 b=fIrQMsZ7B+VWI8aiq7Jz7vfsuAZ/NdZ4TsrhKCz+GQKLr50B4Sc1AOV230GZJ3W/ya
 AbP0EWHe/uvH/jedfSEmIPOq12i6BIgOnFpObj2vaTgAGh5sY/O1jZjtDF42wCWhOwgd
 yA0wFGuAYyVykRhbLoHgulBqVyawTfHokgl1WZbPnU7IYr9n40PW6C1NYMoxRK0Qd6c8
 mhvW6mELK+ehyZKcr43b7sajHMLT2JJKg7aHUxdCzFNxt/5wv9++bithByeD/TyALc4V
 1biP3LjIhMcmL4jTN/BI+4mRYoipk9WpIZpB2xI7DXxa6VctZUrLbYae6eTHhFHVQnlA
 kgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846351; x=1760451151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atUnk8Przy2b+arpo+tXXmWSEKJkyumG1wRWNZoP8OE=;
 b=p00vqHY8AftTXHPBueuOm5vfNr2Cz4aaJZFGUPLJBlr5rxXinbQfAnbog4diJ0Wirv
 3AbYlJrVqqKikBDbkoB32AzKr1SDEyIT8SK1c3V8vubNkP0cnADJrwDPXWrsaLVuITbu
 UB1vxeHhWIC50reqVag2Eu/OKl4WDfqgLACi/+lXyTl6ShdU3wcJd2vITJZRj6TSz2u6
 DGzgwO/R1revTCSVZLqkZM1oY4gUoPuz4LF7rVsbyo01GkcptiE0Ap/EcQvAzRSYpIg/
 MdMtG7vTVUuP2IGFnqb04+rgrNds2bzEFBDukS/YNHR5vr0I17Gt6Qmnt12hTV8qB6vQ
 wKhQ==
X-Gm-Message-State: AOJu0YxTjN+WhXefqTxmTb6ZuS5PQe/qf8YgPcWQD/B3sP4grZ/kDaK/
 lGtqWpPdaGCGU6cV49StTUReqOdMYsra5tbUcMvDE/p41rMPe37gaQmWroKgxWu3d6NZY3Q9gAd
 DAKhZ
X-Gm-Gg: ASbGncsxPYBtdnp6duppBLajKCNBoMzcBsORg2q1pQGoquz9ptniFwxlnmT/q2lwktI
 ftLNSQojw363KTQE7yejaqIU7qxL3GstYScAb+u5zZAaxje6wxQ/VGvcvzWZp42Ou9fTK+Y+TFM
 B37mrMxj/g7GzGmM92qQc6lMYjcmQU9NMQkjkOhvv3fy0bRAW/3xSs1rihAROyRdUc6Sl7C6XI6
 CUj3LsT+9ynUSpgd0ztaHRdVxM5NBD3zW54a2cq6t83vWxidNY/KQdcTNXxjmHoHQ2fOm+iCpJC
 9W6ZRIAk9YtIvP+KbAdRNPs1zer7EP2CddwbB7HjczGFE6SGlpaMzLLKajx6b9CnITP0+1YI+pz
 2mMpF1iYN8PiXdgiQJ+7PAyTQH81pakD9p6kGUBz3fQqe9jTaUG3RUbCu
X-Google-Smtp-Source: AGHT+IEOPWv3oJj22F8on6skrvRXwY16CItP4EJDC6+qlZMFzk/44Z5dotgiF37NjRo8b7xl6Neyzg==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id
 5b1f17b1804b1-46fa296e763mr16273705e9.8.1759846351428; 
 Tue, 07 Oct 2025 07:12:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/62] target/arm: Implement APPSAA
Date: Tue,  7 Oct 2025 15:11:21 +0100
Message-ID: <20251007141123.3239867-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This bit allows all spaces to access memory above PPS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 236c3a9569b..e03657f309e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -408,9 +408,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
      * GPC Priority 3: Secure, Realm or Root address exceeds PPS.
      * R_CPDSB: A NonSecure physical address input exceeding PPS
      * does not experience any fault.
+     * R_PBPSH: Other address spaces have fault suppressed by APPSAA.
      */
     if (paddress & ~pps_mask) {
-        if (pspace == ARMSS_NonSecure) {
+        if (pspace == ARMSS_NonSecure || FIELD_EX64(gpccr, GPCCR, APPSAA)) {
             return true;
         }
         goto fault_fail;
-- 
2.43.0


