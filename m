Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE235EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDwB-0002y4-Ip; Tue, 10 Sep 2024 23:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDw8-0002bL-K2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:22:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDw6-0000a0-Ux
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:22:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2059112f0a7so57645695ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024949; x=1726629749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mvds3EgTjHfNOxfCoA0/GpsDUSIsCk/FIhoWAwFOHSY=;
 b=pdI1mY2pbRo+i6wckK0fakkQD1flUGGTtmBbCe/bhOwyCOusjIy2lLBPPNGMGuCGKY
 kmyMql9OCnukRidgDKhBJ7Eb75yY88HL65gNSj4Rx0s72C1iL5PjTwLu93xhMbpSThmT
 8CaiOCqr0eeap6bXOI/Xzq5sjLJWyHSHuM+EdjyccQhlLPNhwU+TcdPJ86kDJOO/vQaS
 AMKUL0ESEj2/ppSs+dC5IgYW6G25vVw7/z3ZUp0dT32jJlI2lQ1o+n8o2cgE/7UUR7yz
 eCUo+2UYKQd+VlXvKy9myaZ7HgIdy0RfO/+kezSBW9gKaqc55Do+7ilkbq+PVy00xDCB
 GQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024949; x=1726629749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mvds3EgTjHfNOxfCoA0/GpsDUSIsCk/FIhoWAwFOHSY=;
 b=Lva/MZoQU0gCr8vXe6VZnAsOTbR3nBb59xJMmlwvDo8NWEJYLEENstx0T5PlHxcvTc
 YoLb7zwibc3JvslGVj5LwHd84bfD8fHCdlLU2J/FbfnVxDihr3IjbMCVzJD+tO+8CHIT
 z3wz4EythnzjPOo4GtA3b3xDhdGDoO93OxZSlPmNW/NJ4mxFPQw9XyeBndPZ9stB56VC
 51sC9XarZmXOHm7dPsXIPFGt0+ekdhrFrl0gZlQ+93bIJeXY58etgMFpEG1Y+oD4hl2e
 iI0m8oi2jqf74KPJ0JUg6Z6IHmylZrfm7ifhsGyw8n3mNZj8mOF2mF7iFmbbViuTzrj6
 AEQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+3CKLA3+HFlMfzuSp4KoyYBCkzw9YQ0uk9QiRdBpeL9NaT3Yhhrm5I55Do5L0zrtZ/VDzq1nAL48G@nongnu.org
X-Gm-Message-State: AOJu0YzuvfhSdprXEUTL+2M1X+xIk70rR3AvNmfTYOVHbmCRnjajCDwe
 z1xNtHwDvzmD4pzXyKrmLVZecDl7ISKIHIIPf+wTllmEWYJ+cBC7BWwfAGEPjZs=
X-Google-Smtp-Source: AGHT+IGjKk2+qJPR11papAKO//Gut5yr6+4trh4RyHGmVZCXOFYipy+XLKi7uAJkuUzzMywIjWtoaA==
X-Received: by 2002:a17:902:d492:b0:206:9caf:1e00 with SMTP id
 d9443c01a7336-2074c5e11c5mr44138015ad.25.1726024949479; 
 Tue, 10 Sep 2024 20:22:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eeaa1esm54873145ad.170.2024.09.10.20.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:22:29 -0700 (PDT)
Message-ID: <7a7a26d8-0d03-49ea-8572-2e15ccef3505@linaro.org>
Date: Tue, 10 Sep 2024 20:22:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/39] hw/pci: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-20-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/pci/pci-stub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index f0508682d2b..c6950e21bd4 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -46,13 +46,13 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>   /* kvm-all wants this */
>   MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
>   {
> -    g_assert(false);
> +    g_assert_not_reached();
>       return (MSIMessage){};
>   }
>   
>   uint16_t pci_requester_id(PCIDevice *dev)
>   {
> -    g_assert(false);
> +    g_assert_not_reached();
>       return 0;
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

