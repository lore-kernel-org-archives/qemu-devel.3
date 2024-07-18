Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45396C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR42-00011e-F6; Thu, 18 Jul 2024 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3l-0007tZ-4i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3h-0004Sz-JD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so2811195e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308832; x=1721913632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRKxvd6QDFtj0h8zygsVf3aO3dQYQl8x7QbADWP6Qss=;
 b=EuGQ7zxgEZvNmgRmQi9XtzdcytVB1aVVs2j8fM4J7pzjrsp6EkOlQV+S22guKOWnOw
 nt9BKtsC+Cfh1eKb9CYM71i3RYcmm8eTP2+5uxQkoS+7obYY8z16j5W3W/nGO8JR+2DZ
 sFnRpW25odVfclcyWD/I+WNpm1LBnFr9EjEwlOn3ANG+R0l/bKRztzhUUXmNdOQOGgJJ
 YlfOQt8GbGIcmJMz82qPBEXLsMvUBySAeGnrFH8SHyW7rRKuu90ZlCdfV3TklLXIa1nV
 Dot02H06OWZROauNNORtNjwkMrA8JlUYPzIC7L2A+3JMtf4lbaEEmsHf4KlqUYk3/FhK
 Jpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308832; x=1721913632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRKxvd6QDFtj0h8zygsVf3aO3dQYQl8x7QbADWP6Qss=;
 b=mK6Hx49XzOY5GpqSDDXOKBOofa2QOmBRtXp8ccz9DYwzRdo4eqUpNLI1Zwn94u+0hr
 nhsRJuGadTt1enARDNPSwu5iHlhPkpJKOZJqURGXnHGJo1sbj23gs4oHgZA2BdzgN5dB
 x1LCIspO5gs9pqWvxTjtV6UfRI+a0AVcnLLCd9EYffjHjfccuhnuSfgojphDK4AQbYnL
 dtY13qNTaahA7v4g2YfnI/+na82fCFT0d6D7JZUVeKYaFJvxtF0AON0F/bhot2qqFfiG
 Vnbvj25WHDWzb9vbKwizw6h6DQwsUTLQ9idd6Y9OF4c85vMPbmBrPupcCtYobScWlINg
 kflA==
X-Gm-Message-State: AOJu0YwXAEmCGa+SwHp7rdOkFJSeDY0enz12hthJT30UKHc3BoUntbcB
 H6KXcpIcBvdGF5ccjS0Sw3tqFuYOkxXuUw5XlG0LHTeec9dCqODYK9IHTzRNe9d9AqdXUD4o7Fe
 S
X-Google-Smtp-Source: AGHT+IFK/uLh2Il3j2JaBwRdA+EgpU9JpU3GDyx9GRGTeteoYsJlyyydbdllWNGQpXceIfGKewqbKQ==
X-Received: by 2002:a05:600c:34d0:b0:426:54c9:dfe5 with SMTP id
 5b1f17b1804b1-427c2cb8c45mr35891495e9.10.1721308832049; 
 Thu, 18 Jul 2024 06:20:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] hw/arm/smmu-common: Add missing size check for stage-1
Date: Thu, 18 Jul 2024 14:20:06 +0100
Message-Id: <20240718132028.697927-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Mostafa Saleh <smostafa@google.com>

According to the SMMU architecture specification (ARM IHI 0070 F.b),
in “3.4 Address sizes”
    The address output from the translation causes a stage 1 Address Size
    fault if it exceeds the range of the effective IPA size for the given CD.

However, this check was missing.

There is already a similar check for stage-2 against effective PA.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Message-id: 20240715084519.1189624-2-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index b6601cc102e..e81b684d06c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -381,6 +381,16 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
             goto error;
         }
 
+        /*
+         * The address output from the translation causes a stage 1 Address
+         * Size fault if it exceeds the range of the effective IPA size for
+         * the given CD.
+         */
+        if (gpa >= (1ULL << cfg->oas)) {
+            info->type = SMMU_PTW_ERR_ADDR_SIZE;
+            goto error;
+        }
+
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = iova & ~mask;
         tlbe->entry.addr_mask = mask;
-- 
2.34.1


