Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054C0ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniiy-0007fl-Jr; Mon, 09 Sep 2024 14:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniiq-00079w-OZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:02:46 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniio-0001Kg-UG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:02:44 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso3189205e87.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904961; x=1726509761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekos1C05kXz4BX7E2oaErKrr3DrBSiu9SoQ/HQodfdI=;
 b=yrJ2vzA6bEv+gNIJOpKfG+q9Phr8K/0y4+qGeLN43CYU5O0Q7FAN86NygWxsK3zehD
 0+DkLAM+Wa70/5NwCwiCrM7AaSzaMslcnFYg0OvGrYkgB8vTOZtTscKOFwFQAab4XQif
 asGpBRXWJ9XO7Ew/LZFJsSAmihf7cLEIFFWKQJw0pw03sFXc7R7mXFS94R1ys/7b7r+t
 s+a3yDNkltjhSo8EP9DCxE1u2Ik/skLTov6Yt2UW9YFqkoIEUao5Ics3aHHAh9rqnAK5
 52mF47ICeuqLxHcMPqrhdUL6m7Uvv32/R4J+z1qR9AqrlxDb0Wfajzf5+BOMHPLJ61KZ
 LHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904961; x=1726509761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ekos1C05kXz4BX7E2oaErKrr3DrBSiu9SoQ/HQodfdI=;
 b=QBJQieoQZt30TtRsStcJE4s1TjDn6ZmTdtFdowVVKfqczDJw2+xy1MoFGm0d2KmhgB
 PvgjLjtm2h88rz1nzy5x5ij0iMNL5l4nVociKAMtwowPSuGalK24Rx4Xi1Ix4dZkEoWZ
 PQQeLCs8Hmwm4Vjos1hSDgxlhfy2nI+GKg+fD1H13HsBYuoLaG988Pb4lsWUKH3P07DO
 pKYu2hXbYNKvfFflCy6BB3oElPlTHf7lEY+J73SVU5W8/VF3/5/noDAx6jec0puD//Z2
 hPAAV4W1KZfbBC6F4+gdTk4ZrzJbMHm8ov9imH+zDtKMZhA4hJrw/yosIBFwzSZH6wTX
 CB3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp+x3mlzDJdSXyOWu02SkabVG56FutPa6s0an4YswOnOPcyKje3oLYkqnBaW3gazl8EcDf3hv2q059@nongnu.org
X-Gm-Message-State: AOJu0Yw2rV8Wsi2l1q6BcbqYbd33Chc+yuVqoGeaoe1E4m9eroJF08E5
 1ZYk1yC1HuNVkNsqJlOd6G8nacGrclSjzVtF14widB3vcuvEBjHiqnP6M2j4OOU=
X-Google-Smtp-Source: AGHT+IFmQMgkLcEagoxRF5u7xWo+9/xAnhtNSbfpVfEZHL2CpDMqE4lYVM134ARsDrKcD/upR61flg==
X-Received: by 2002:a05:6512:104f:b0:533:482f:afb7 with SMTP id
 2adb3069b0e04-536587fce37mr7659606e87.39.1725904960615; 
 Mon, 09 Sep 2024 11:02:40 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c74286sm371479966b.123.2024.09.09.11.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 11:02:38 -0700 (PDT)
Message-ID: <f7f03006-9c7e-41a1-a683-db19378928b4@linaro.org>
Date: Mon, 9 Sep 2024 20:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 40/53] hw/intc: Remove omap2-intc device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-41-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the OMAP2 specific code from omap_intc.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/omap_intc.c | 276 --------------------------------------------
>   1 file changed, 276 deletions(-)


> -static const TypeInfo omap2_intc_info = {
> -    .name          = "omap2-intc",
> -    .parent        = TYPE_OMAP_INTC,
> -    .instance_init = omap2_intc_init,
> -    .class_init    = omap2_intc_class_init,
> -};
> -
>   static const TypeInfo omap_intc_type_info = {
>       .name          = TYPE_OMAP_INTC,
>       .parent        = TYPE_SYS_BUS_DEVICE,
> @@ -684,7 +409,6 @@ static void omap_intc_register_types(void)
>   {
>       type_register_static(&omap_intc_type_info);
>       type_register_static(&omap_intc_info);
> -    type_register_static(&omap2_intc_info);
>   }
>   
>   type_init(omap_intc_register_types)

I'd squash in the same commit the abstract parent removal:

-- >8 --
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 67bb83dff5..43a1a9ebe7 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -68,7 +68,7 @@ int64_t omap_clk_getrate(omap_clk clk);
  void omap_clk_reparent(omap_clk clk, omap_clk parent);

  /* omap_intc.c */
-#define TYPE_OMAP_INTC "common-omap-intc"
+#define TYPE_OMAP_INTC "omap-intc"
  typedef struct OMAPIntcState OMAPIntcState;
  DECLARE_INSTANCE_CHECKER(OMAPIntcState, OMAP_INTC, TYPE_OMAP_INTC)

diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index c14b22d381..f4f5f8455b 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -392,22 +392,15 @@ static void omap_intc_class_init(ObjectClass 
*klass, void *data)
  }

  static const TypeInfo omap_intc_info = {
-    .name          = "omap-intc",
-    .parent        = TYPE_OMAP_INTC,
+    .name          = TYPE_OMAP_INTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OMAPIntcState),
      .instance_init = omap_intc_init,
      .class_init    = omap_intc_class_init,
  };

-static const TypeInfo omap_intc_type_info = {
-    .name          = TYPE_OMAP_INTC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(OMAPIntcState),
-    .abstract      = true,
-};
-
  static void omap_intc_register_types(void)
  {
-    type_register_static(&omap_intc_type_info);
      type_register_static(&omap_intc_info);
  }

---

But this can be done on top, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


