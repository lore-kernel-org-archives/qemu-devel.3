Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B92CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlfz-0004Rt-HQ; Mon, 08 Apr 2024 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlfx-0004QZ-I4
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlfw-0006MB-2x
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so592263766b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712569945; x=1713174745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4JOGeyk5Il5mqTCfLsLzu8RX0JVQXq+A+QA9fciUu0=;
 b=TM52845524jWjlnRBakbvN0Hn9ZKgWByVTXME3aFau1ijlitIZsJ8qTFGGlf+zlAe9
 HNPYaaiqnxPz7OrTyCwouxXabidz0uSjh+zrIMUgpOTG9WOHv+8Q3BXW5hYnXN4lcxWW
 OOEUA+eCYcSMFZSVbcMA/qY6R38X99TskbYpm04izBbNf8cAorIUvPta3ox9aOYZxqrI
 4KgC9AVsrl/Vu9NsrWwiGI6hit/zAwYKAYq49uT3i7r3jsKepmObwfHwLQKDYpxcSkoy
 GqRnfCz5rSfw1jVvrDn+64f0brgV0CSKIlIka+acYqvFJsNjM3n9NNn69odrt6xNzH0z
 ev4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569945; x=1713174745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4JOGeyk5Il5mqTCfLsLzu8RX0JVQXq+A+QA9fciUu0=;
 b=UPz8cB0QBj9vaWaUhO9rIk+H8nTkAzka+OfK3oO5/XUDhWOMvzVAdeBlJ6xVjM3hkW
 t6Ad83CYMj5Tr5Y/aedJXI5e9LTTJwylW1rk2wjJ6zt81M4IvNpkBOpv54PQOEHe5kuD
 UZJEr7tH4T+7UnPXNM/RQCjj7UHMvCi63SoSXIxk3HBybD9izYklBILVsrho+Gtcdt+F
 GH4/ihzPNKRFewhZVGIL5QKjbLtp19Z9rApCeohREqNafoFNwtqMdTiiALv7RKkdWlR4
 +pEjN5bO6xqaqXIoUq8XRfBiYusPa0MsHL25ioh1g1FblKItnc9Fak97iWGMsu1+RwFW
 /yoA==
X-Gm-Message-State: AOJu0YxCxFFRMPf7m41CYnTeKdE2Qa4yoc0gl+4LY3j9sh4gRlOtyAGk
 1B8HWevoWGIAhTKou7Il3Skq65Quua1EQ7WjeL4QydWI+9He2CWcR3VwPm0ptBH6NKu6sbhsJo/
 x
X-Google-Smtp-Source: AGHT+IG+f9Fn93QtWqqaJemFcWRSpxGYywb81KX3iIBxGkLMFKLTS9QJhI2w4/Im1sD3UNb14a31QQ==
X-Received: by 2002:a17:906:c109:b0:a51:b36e:61c7 with SMTP id
 do9-20020a170906c10900b00a51b36e61c7mr5234689ejc.13.1712569945094; 
 Mon, 08 Apr 2024 02:52:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a170906448f00b00a51d250a1a4sm1479813ejo.80.2024.04.08.02.52.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 02:52:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 1/2] hw/misc/applesmc: Do not call DeviceReset() from
 DeviceRealize()
Date: Mon,  8 Apr 2024 11:52:15 +0200
Message-ID: <20240408095217.57239-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408095217.57239-1-philmd@linaro.org>
References: <20240408095217.57239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

QDev core layer always call DeviceReset() after DeviceRealize(),
no need to do it manually. Remove the extra call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/applesmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 72300d0cbc..8e65816da6 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -342,7 +342,6 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
-    qdev_applesmc_isa_reset(dev);
 }
 
 static Property applesmc_isa_properties[] = {
-- 
2.41.0


