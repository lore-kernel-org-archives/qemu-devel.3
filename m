Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7F0C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQuK-0005SE-D5; Tue, 04 Jun 2024 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuI-0005RJ-Jf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuH-00023Y-0L
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4214aa43a66so6415555e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494999; x=1718099799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIOW1O9+X9Zn3nRI+K8vVtjj1gMTn5Z9TMOA7fC7V5E=;
 b=TWdj9g5FinwiyYHMKRkUXc9R2VgTXTVUZ54qGpr1sRmbASXQUUdQ20fkGJ/dDSzaxU
 F0gL49nyPulyQSDlUIkRf0PVjB0+kr7kV/IQIFVdbugwVxJAvvDkyzfObY/8xqQ4xdXw
 CbEEbpH2mDRJiEcUNudDtLlNt0bSgHAtxjocIzafUWvjk0dkxZ1bffJLvgk5Y1BY43Jz
 7Iqp0cBx5YsAjEUFB5VUz0d3L5FBf34/yP7NAPS/k7HIBsyYJPB4gGkxD+OZ8xE1Or+7
 JWMdnfSywzBB47Fy2sq3IEHThPSj9EnO6VCIFQ24pb85fUcJsSIm56TdQAOUZkPR1LTv
 qzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494999; x=1718099799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIOW1O9+X9Zn3nRI+K8vVtjj1gMTn5Z9TMOA7fC7V5E=;
 b=sz1lh7IwC+9pl8dM/jFDtBliWbq8ZnUvJKoxPM/ZSYMo2o5aZ0l30hyuBJDys7msXh
 5ERCCULIpdkvDUosHOifWy5LNf/AoVVitK4Kc1NfVW9PXopKymb47TYkJEAmgkZ0uDEg
 VLHKNN0Dy9b4UPrbGA9ggTg5ZulTvBYHhrGJA6d6GphpembjYSpytyJ+7/qu698+L5QW
 vC44CtPD1UanJupDRqcBlRMxfQLHVLBBBwEcQRHGuwULpwhdveDrZLrEGqWzwsLqbWLm
 oFkNbQiUCtjZsg1RAgDl3K2aRRsztkUQRRKWdpcum6NTHrLeKlSQnRkvxIvL4RcG9Ds0
 kWjA==
X-Gm-Message-State: AOJu0YyPTXV0fRP+jfN3mZXdzsOAMtJHW77CKNuCDAdDdMNRJUjmLM5F
 HzBeIJ5yQBj/WbPsMKv5/CNkHRNR2/7mVzO0ci6U/iUM0dwKTT17X8ydXjOoCyY0DH5R3rgUTia
 U
X-Google-Smtp-Source: AGHT+IHYIfssMgJyQViH/PG6SUuqwghodOPEqtXUG+smjvs7TA/ME23+Z4ueQBHBUjHOhSPJBe1V9Q==
X-Received: by 2002:a05:600c:45cb:b0:41a:c92:d323 with SMTP id
 5b1f17b1804b1-4212e04a1famr109906945e9.10.1717494998765; 
 Tue, 04 Jun 2024 02:56:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138c41becsm95838805e9.30.2024.06.04.02.56.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/32] target/arm: Replace sprintf() by snprintf()
Date: Tue,  4 Jun 2024 11:55:41 +0200
Message-ID: <20240604095609.12285-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 862d2b92fa..262a1d6c0b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -437,7 +437,7 @@ void aarch64_add_sve_properties(Object *obj)
 
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
-        sprintf(name, "sve%d", vq * 128);
+        snprintf(name, sizeof(name), "sve%d", vq * 128);
         object_property_add(obj, name, "bool", cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sve_vq);
     }
@@ -462,7 +462,7 @@ void aarch64_add_sme_properties(Object *obj)
 
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
-        sprintf(name, "sme%d", vq * 128);
+        snprintf(name, sizeof(name), "sme%d", vq * 128);
         object_property_add(obj, name, "bool", cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sme_vq);
     }
-- 
2.41.0


