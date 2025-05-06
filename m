Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74138C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJR7-0002YS-PY; Tue, 06 May 2025 10:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPq-0000ZL-FD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPo-0001Bj-8g
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso50541455e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542213; x=1747147013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnVo6371DEPrytU8kx25CXSpirHbOP00q7cKwrtXgKA=;
 b=Vdz6zTRub9tTfKDVVsMlnQp3hpAc7iYvasRr7yYj6YwhNBCGp/FJQ1eAXmvklP8jJe
 Rmo4eL7lJNHriVOuwCGeix/srtVO3Sm8D1GF4YrwgRvUXlISquBhTBSFqClD5OXk2IjR
 Qu1gzy4mSxaW9PpOWzJFxO9LyfuRsZT5uHB7n5W944xyw6XCZk/nsiOf3usFtLvVqa9E
 FslsrP9g1n7U2Y96g5PbPB8O9lvS/bB2WQmS/IUDOM33vnf+0OtmNQPb8pFrVajzY7UJ
 JFPfV60xWY5hAKCjPWG58+0EthSvEsRj/ZOc7NMJHxtSfIKVwGlf0nHRJzDTBjbMkF0w
 YF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542213; x=1747147013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnVo6371DEPrytU8kx25CXSpirHbOP00q7cKwrtXgKA=;
 b=M32Y2jFMWiRZC91mck9Z9pOuXMN74KMJb76wd3eNuTmCLrr8MaTRpRSmxJubNnb+Cq
 OgoSshKuZ9N23FT4MnbZuH9o0QU/6Ar5zvxU3X1oEg9D0hcLQgRh66PHcunGvK/JQaJx
 ROwBdH9lyViuXzUtDiO6F5OCT3LailxZVaFBvvzR4NmR4nter5STEg1aGNK1ZEW4MYYc
 SvUDdw1IoGDc4j47U4rATErRGREwEOdrQUHoYN845VnojOaJ87Rpj6NHr+48sTRgJZuc
 QkcSjEXOSxhjH61njiWe5Z+RsVQsD9Xj5xBbTAQZK7kQ9/uNJjWE8LlIBtdj3LJ5aKp2
 amGw==
X-Gm-Message-State: AOJu0YynrF3W16GIAiSgMdtemXGcI2FHCwBnZkJwy815116QVV8ZpcdQ
 dyItNxgZ75ABbuLNgu7WrHHpY0S505NymVVGLUdgIJ8l2nYYARiA4rCuMbZ0BVfrofinlC/3JH9
 V
X-Gm-Gg: ASbGncujVI8L941J5S3n983Ibjw8err90H9c/NGr/gQ109UMsSajAuyZ+ePmdGOkZFp
 eOEwkmvBITAlpdeb/d0YEejzKf7njrHuYHRFoOkq57FQsxNQmBouWnrST8k8oLkto+DhP6tN5MF
 zhmud8MyeFNxSHFSBVA8QvxCSlKQn2SIPjFbT+L9VH4E6dy0hmqxvqLpYilQAzuWpP7ezGw3Rjz
 s7oLmKJYGFedamxRz8ULhTt0B9Ng87tSFMpBqCkO63sGTmXJfHtmzi3EjkbP7lsn0QiyS0sb3GO
 xvaKrDqH0URSxK2BIxYVRfCA9o/JIiA7tm2mAEmgBtJOy9xgAoHIGrk1eqjj+yZb56i7b18aIJk
 2C/4nr/OlPpgoUD2vu1ax
X-Google-Smtp-Source: AGHT+IElwh4UdDcxM+twwQGLXhct3ipMFO/TMI+GnliXr+6bWrUW8Q2tbD5ZPpBseyjgOK25AwKA2g==
X-Received: by 2002:a05:600c:83cd:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-441c48aa481mr112043395e9.6.1746542212983; 
 Tue, 06 May 2025 07:36:52 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a285c2sm171131645e9.32.2025.05.06.07.36.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/22] hw/i386/acpi-build: Fix typo and grammar in comment
Date: Tue,  6 May 2025 16:35:09 +0200
Message-ID: <20250506143512.4315-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix typo and verb conjugation in a comment about FADT initialization.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250504215639.54860-7-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 85c8a8566be..f40ad062f97 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -139,7 +139,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
     /*
      * "ICH9-LPC" or "PIIX4_PM" has "smm-compat" property to keep the old
      * behavior for compatibility irrelevant to smm_enabled, which doesn't
-     * comforms to ACPI spec.
+     * conform to the ACPI spec.
      */
     bool smm_enabled = object_property_get_bool(o, "smm-compat", NULL) ?
         true : x86_machine_is_smm_enabled(x86ms);
-- 
2.47.1


