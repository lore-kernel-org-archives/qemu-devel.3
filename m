Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38517D609DB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 11:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGG90-0001lN-7m; Wed, 27 Nov 2024 06:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGG8z-0001kt-77
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:23:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGG8x-0004hD-Hj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:23:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so33541775e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732706618; x=1733311418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D85e/9sSN7VtTqiuPNUfHF2+WXR3ZSp+4nYaf+WMPLA=;
 b=qqyP8FHeRtw9NXM+JP7mWE3kNHDqdXnp6a2cfR4/ALPLUh4BBasVvPvOFZrGViyEP4
 EuwGFPEUWPlRK1Ap966/tkjyMau6iviRU2ZOfYPYtOsy/viGx23VfHwKD0kcgSmybmk4
 4g7DnX8TSwqBWjV+tcFI+R+YteJTSRmQZe5DtmVSTmHBthiophc/C9Cga347iRv3xUt9
 ZhY9vjxMsajGdXY9fIBBS6OaXNtttEo0rznwA3MmFJZO5+OX7SCkI1BA2p1xuU2YdZl+
 kbbam7jYgkWcJhTMkXMzvCL7Frd/dW/aA4p2Kkr6DihA7lt/xL0HgNOHpjdWrwEXKTmj
 m0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732706618; x=1733311418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D85e/9sSN7VtTqiuPNUfHF2+WXR3ZSp+4nYaf+WMPLA=;
 b=c3COgOCsLbIl8MC32dEPyKSCAvOwA2JhLHj6qykj4/QE/ZMmSVu+/GO23e6iS/db7r
 v1Ww7hDo7zrjGE0qM5m0tX2voWkpAN7/Q15nune3ZEtCdRMOXCj773+v2FXERaJq7p3g
 R8QFiNvlkFvt9rgbWIc2ALDA4pqUAysoUrK9wRHxBzgpTjyFCRNr7nnfjk4TWfiBud91
 dK3ly0UyVumtQA/x0vNZnNuO/S2EBDfG0SFhzYQFtjQxncNjS0XkCXmS359YFI0Q6N36
 cnhSsbo7+VTvUvXSslZlsLA87eCFdb4z70cdK0smQk3yqX8ZvSvqMLYJ++Z3weN+JAVp
 nYoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV4RYDITnezZ866W3IkGntEaWxs/C6GbsERKGuPnwN6t8lAIEFop805yu00ygRdTIBLaOHy8TywInB@nongnu.org
X-Gm-Message-State: AOJu0YwWBxj5sOA79QLjFU3HSNqu4BYMSHCX+xb14lNO/0+RPrDvmldB
 PizMjl1VhvWAuBl+4O/sPLKJg8CBQkgYuEt7/VtVLEq40RJV7zj9pCOiAFMxEac=
X-Gm-Gg: ASbGncukLNtWbL7UIvqP0EN9bHKP+Iulb/QE5LAvYpLng75jxJpcDl/iVcQ9Ogvs8YS
 5CQi5x8allLtJCd9i66ZqGCeSqP1hMIiDkjBy9CyiPE38KWHqz6Ao9NDiJ2m1cccap9IUIFOd38
 RqV54L7yrVakGqTiC+h1LylN5vGMs5y0xThFSR1dWy+GJ3VZ2670KuNZVBOTRUk+iG7yODerscJ
 EmZGIHHe0iEJtUWeqzvz0gB3u+6IcEXvEzqIzg5kLwvisuRFlGIYwPvXJStoldsgYSG90oQ7lu6
 48+FlaNsrextEOcJ440o5PwMydDS22rVrnuo
X-Google-Smtp-Source: AGHT+IHV3++2Z6NO8qxuM07KOrgEs7fits6xKbeI5gZeEoPpM1Tz8NzbAabe7EEYRCHTppeXj8MfjQ==
X-Received: by 2002:a05:600c:4747:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-434a9dfbb21mr28528965e9.30.1732706617659; 
 Wed, 27 Nov 2024 03:23:37 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7a4e85sm18253945e9.5.2024.11.27.03.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 03:23:37 -0800 (PST)
Message-ID: <b520adf4-12f1-4261-a48f-bb74589bb31d@linaro.org>
Date: Wed, 27 Nov 2024 12:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Introduce a new Write Protected pin inverted
 property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <2e956389-289a-4806-8985-ab846d808736@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2e956389-289a-4806-8985-ab846d808736@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 27/11/24 10:44, Cédric Le Goater wrote:
> On 11/14/24 10:48, Jamin Lin wrote:
>> change from v1:
>> 1. Support RTC for AST2700.
>> 2. Support SDHCI write protected pin inverted for AST2500 and AST2600.
>> 3. Introduce Capabilities Register 2 for SD slot 0 and 1.
>> 4. Support create flash devices via command line for AST1030.
>>
>> change from v2:
>> replace wp-invert with wp-inverted and fix review issues.
>>
>> change from v3:
>> 1. add reviewer suggestion about wp_inverted comment
>> 2. AST2500 EVB does not need to set wp-inverted property of sdhci model
>>     
>> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dts#L110
>>
>> Jamin Lin (3):
>>    hw/sd/sdhci: Fix coding style
>>    hw/sd/sdhci: Introduce a new Write Protected pin inverted property
>>    hw/arm/aspeed: Invert sdhci write protected pin for AST2600 EVB
>>
>>   hw/arm/aspeed.c         |  7 +++++
>>   hw/sd/sdhci.c           | 70 ++++++++++++++++++++++++++++-------------
>>   include/hw/arm/aspeed.h |  1 +
>>   include/hw/sd/sdhci.h   |  5 +++
>>   4 files changed, 61 insertions(+), 22 deletions(-)
>>
> 
> Philippe,
> 
> I plan to queue patch 2-3 for QEMU 10.0. Is that ok for you ?

Having to modify sdhci.c internals is dubious, since inversion
occurs out of this block. If this is the soc/board layer, isn't
better to model at this level? Smth like:

-- >8 --
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index be3eb70cdd7..aad9be66b75 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -559,8 +559,9 @@ static void aspeed_soc_ast2600_realize(DeviceState 
*dev, Error **errp)
      }
      aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
                      sc->memmap[ASPEED_DEV_SDHCI]);
+    irq = aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI);
      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       sc->sdhci_wp_inverted ? qemu_irq_invert(irq) : irq);

      /* eMMC */
      if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
---

