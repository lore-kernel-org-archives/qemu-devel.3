Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6B0D3C52D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 19:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1W0z-0005ux-17; Thu, 17 Oct 2024 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1W0w-0005to-0p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:18:26 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1W0u-0006wj-9C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:18:25 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e1543ab8so2365174e87.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729192702; x=1729797502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/NETH2CrDKwiZrM1jQK1ymEX1iv8quNwaR7MPB+BVBY=;
 b=RyEEImA/I4Px37pPIOG/7OfV3HRn1WYNLWPwLAF4xjLPZa3icqcBgli1dhmeDOMisg
 AOsEEhgPShy4L16siRmA1SveDkkgAP3FUEyOp/ZclwoLTmbwqNtC6O8NOzmOOekl/cSv
 bbsDIGPWjn8i7smJJI/LEx1JZw6tFJrPkpC2jkLA1wOXXcNyne7YxPZUjaOoaVa/fI+s
 CVmoY/sksJF5tt6nI+kdSQv7ShsZk9IEddMSubD94MAOSqfj4zWBiei5saoD6nyCEucf
 tsLh0d2J9UeNonSZsIo0GFONK0QLtPfmBidQuKj910G1nt8C06TavTuVA8W2eOU1F0Za
 +XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729192702; x=1729797502;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NETH2CrDKwiZrM1jQK1ymEX1iv8quNwaR7MPB+BVBY=;
 b=MLkJ/NTZ2c92Uj/zjMniS9rlVRl+IL+HMGmuleNCYYZF8+dfzEZtQ3eLlF3KHBEHFh
 I4g4Ogx8B4UFfWUNQBkwtfTUrMJypMs7cFg8ChJ/w873aMpEsv221Fe0FnokNArmEuc1
 PSTrseUkByWkwjCtblKcH7d3obF2sxB6ONEOq0Jnav3biYS7JbdTBcHkp8z1eQQsHiJZ
 BLiuE1kzYDPuK40N9Bj+CJNdaKypqiXyBhm4BWxmNP5InNPxmrmnCYc4miyoKbFSgDU7
 Fh224a5S62YVjdAbrU1xXfHmCOZSXKs1QHgIkq2bJf6zqWhSUCXU3hjOWAn9zk6Qu6oR
 8B1g==
X-Gm-Message-State: AOJu0YxCIDwHYpWmgLIkm9CRb+6KI+hp/EjpDKufHM1FxbguGjEJTKFs
 MnpI5z1rhc43Cn6+aBc9lBMIa8jdyarctQ46CShm5J9rJxoUjCCKDMufBid84KY=
X-Google-Smtp-Source: AGHT+IGXBNDQRfhDmvwOm/78fr2SwqtRD8C8/v4sotwwPJJcpL3C+0frFyqEo/2+h1Yf6tgA4bXgkA==
X-Received: by 2002:a05:6512:3989:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-53a154d857fmr12794e87.50.1729192702024; 
 Thu, 17 Oct 2024 12:18:22 -0700 (PDT)
Received: from [192.168.210.26] (83.11.13.124.ipv4.supernova.orange.pl.
 [83.11.13.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68bc452asm1576866b.137.2024.10.17.12.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 12:18:20 -0700 (PDT)
Message-ID: <d3f61522-afcf-404d-b5d7-ab94c18b59c2@linaro.org>
Date: Thu, 17 Oct 2024 21:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie: enable Extended tag field capability
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
 <20241017125724-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241017125724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x135.google.com
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

W dniu 17.10.2024 o 18:58, Michael S. Tsirkin pisze:
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 4b2f0805c6..54c0f1ec67 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -86,7 +86,8 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>>        * Specification, Revision 1.1., or subsequent PCI Express Base
>>        * Specification revisions.
>>        */
>> -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
>> +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER |
>> +                 PCI_EXP_DEVCAP_EXT_TAG);
>>   
>>       pci_set_long(exp_cap + PCI_EXP_LNKCAP,
>>                    (port << PCI_EXP_LNKCAP_PN_SHIFT) |
> 
> We can't change capabilities unconditionally.
> It needs at least a machine type compat thing.

Thanks for review. Will look how to handle it better then.

