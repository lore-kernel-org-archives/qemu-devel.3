Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C17C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMlXJ-0005vV-FK; Wed, 04 Jun 2025 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMlXH-0005v1-ET
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:39:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMlXF-0007Hk-Uh
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:39:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so51588895e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749033592; x=1749638392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kskc/8nOyq7cZXIXOCzBhyqZtTwDOINldLWOS/GQx9g=;
 b=UUYuCgzgWv4VenU3NRRH9WqdZfyNUp2f4Nja5SOGTQsc22YCgrWLP9hfxt4unj9fwh
 meSOOfv0EFXoAn8NvJqH22gpi5RIKbHs8hsMPBpq8jcsTFtHvuJcop6Fk6ZZLBM78ntu
 JQo1k+Dd2G7g5362XmOgcpjaxc8AWzporOA2yRlE48/rLPymce8VnCrMa3eaUM7TrieJ
 mkLwdkg1M3MzqZifov7xrrOg4LacTL/vTujrmJZ716F9AgGY5G5TArC31Xe3ndE9YnFv
 460X16xt7EKoLYRQwTbuuBzp47OIv5nfvZ8UKiBYVaMzOKX9Privtc/OPG5w6kTkmYKm
 10Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749033592; x=1749638392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kskc/8nOyq7cZXIXOCzBhyqZtTwDOINldLWOS/GQx9g=;
 b=bXDBlmTJ9GIcZJM2Sgg2fHn0hIfCMiiIR6EDmduSR3tSr46bjXRPTo459j9ZLkVQfK
 4DL4lORWhQrIXQQ3a1OSsXjG32XicSLiu+yHuLLLB87JdhpYRIv1nitGU404P434OJ2G
 0NewL+3QI7O1qrkkn4/nDxHWilSxd84lknLOwwXaKzeBltrJc/3Ca8pGYlZscAo1q3T4
 dMvAgQNGNdW08tWysH/qfKjh8W3wlpv/kH+A1HvDWBxONG8sMWgwqM7Nrc6TVVnBuL9W
 nceZZShZ/4DbF6gihgdRAqmoPH6QoSDyg22M/x4ah0lMpGFPS5hrGCopLqyAIU/SoPm2
 LAYA==
X-Gm-Message-State: AOJu0Ywvod1z+nsIFZ/sw0B72/YAX7nb9W3cuYLNAtZUmLkImQMUdhR6
 TkYeKMSagpwoBQTWroDjrjHx55c8RLxADgUcPY1NXYnVSQXNTrnxCVIV7c8URe12568=
X-Gm-Gg: ASbGncvBAG3GXIVI+VC1r3nu1QbMa6KUGm0A80ztHsMewi7vijosvlSij9P043z1aLY
 5yk96wOx9V50EIqW2++iToKQZKAG7pZv8YEtm0uIvPOwEzmrnRDn/h9RX2XJIf4ce9bebuEMqRs
 QqNWHVlre5H6l+r92I/DSoV/JjK/owNj4QKMjAKhSieSf6IqLqK8kg8VpK9Un3pjJC242L4PSfQ
 hPWs4HwJVDsm7jnh07NxuKer0OBI9HJVr6pfv+vqxVtfvR0GucJKZw7NFl9pTJXMKllWN+YMxw5
 Dp8CgUClRfGY7ecdAPkF154Qu2yl9VRjRsqcFIV/Brnk7B0X13UlkF+eP/kEvBa1e5EBgemgjkH
 aX1uj95f/+Y4MKhG73J5ZnHY3+1mIog==
X-Google-Smtp-Source: AGHT+IFeoFQYDoejexqIYywDFExu9ZnODiMlQ5yGatCXbAGKlP7ued2N1/u8u9wrCXRKUP5LoGVM7A==
X-Received: by 2002:a05:6000:288c:b0:3a4:d0fe:428a with SMTP id
 ffacd0b85a97d-3a51d9691f8mr1878814f8f.28.1749033592146; 
 Wed, 04 Jun 2025 03:39:52 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012b09sm192462605e9.37.2025.06.04.03.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 03:39:51 -0700 (PDT)
Message-ID: <a4665454-5116-4cbb-8a1e-766467f33116@linaro.org>
Date: Wed, 4 Jun 2025 12:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] hw/pci-host/raven: Do not map regions in init method
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <1e85cddcd56f2431e349d21fcf6e539a663a64c3.1746374076.git.balaton@eik.bme.hu>
 <bfd1359d-2a25-4c53-9eee-cec527197f8e@linaro.org>
 <alpine.LMD.2.03.2506031547560.13449@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <alpine.LMD.2.03.2506031547560.13449@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

(+Mark for Grackle)

On 3/6/25 15:50, BALATON Zoltan wrote:
> On Tue, 3 Jun 2025, Philippe Mathieu-Daudé wrote:
>> On 4/5/25 18:01, BALATON Zoltan wrote:
>>> Export memory regions as sysbus mmio regions and let the board code
>>> map them.
>>>
>>
>> Why? The mapping belong to the host bridge, not the board...
> 
> I took inspiration from grackle that does it the same way.

Well, this is a very old model, looking at commit 426f17bb0b8 in
2009 (then updated in commit a773e64a8fd in 2018).

Today I'd model PCI host bridges as keeping their PCI functions
local (since they can not exist otherwise without the PHB),
instanciated / wired / mapped within the PHB DeviceRealize, like
mv64361_pcihost_realize(), the various ones in hw/pci-host/uninorth.c
or the more complex i440fx_pcihost_realize().

Anyway I can understand your frustration after waiting to get reviewed
for over a month (I am experiencing the same). I was just trying to
help.

Regards,

Phil.


