Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543BCC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truWo-0001xm-80; Tue, 11 Mar 2025 03:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truWf-0001su-QL
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:59:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truWd-0004xJ-Lu
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:59:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso23883335e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741679982; x=1742284782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lsAXkVU4PqTyZV4VExPcU6clrv2gU9fj+UlA7H1nc24=;
 b=mACvpSkVPcFzTRlOx0QcphTXziIAL5VIwwx/yAbYdMN3LgoGSZDn/iOCegEjfsXGpS
 AL1mQJ97sVUsq8NnwnQMeasJ1QGeqXdnBOr7l6h8HHH6yVXl2/Fbvebuolq2xpXCTswG
 tnQPx5Rtm3EwTaN+hy1nit/ZlSYL79VtZvdx0KS5zf/Uay8SVy9RBL72waX/VdW6np1v
 8yUZDPf4BFTsQsbn63tKJBu+QcX6Y9PRDhZp6lCjwHovUcPyBwsGFhoZimgYb84umZLk
 NSG2AoYsUcQEsBUwifj1+/8VhpZKSyNOrLwoshFJcXVRXbWnKdcbJQ2Wjk9C+tonauo6
 xKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741679982; x=1742284782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lsAXkVU4PqTyZV4VExPcU6clrv2gU9fj+UlA7H1nc24=;
 b=G+LrUCEu0wTUDrVbZNl9phz9042IEj7iXDGwX4z1CGxv6Mj8Bt7NigOasu0OQOHGOS
 g1uuH5oDECajSKX4aD0lJBk+7xLF0PV7tKlbt4o+FYUEjs+CH+PdewJuIF2LDhKqL/6y
 C7z9OkfPFBI3og0WvrwdpUYMLyK8b3Px1FOQdGM7ooLc3f5+gw/cwhOvuSmHSfiwgslB
 lUm+dLGQiu3TXK25dSWjA/aWgDQQGh7EUtaSXouX/Eewk9XoR9tRSJNI3oD1/qnLuCax
 YHe27NkwHOKNJQ/QuCLx0dFVsYty/XS+w7pFQbgPI93gGsrvojMEapfUOxCZTtni9hW9
 4LCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5WLUbRuoTBGzRMnlHQurw5HJxRbPVqlR8YRkeBwiWPn89SHAYVBsl596iqa+jJsEq50ppv/mVcSkl@nongnu.org
X-Gm-Message-State: AOJu0YxiiDAq+caCt2oyNy2CTH6LjDls2NczifZzQGTgy+5jWU6/5ucW
 IcprNflTdkVtWZ2UnPoIOnIc93arLOOsNfqtKUxyypjMAqITZ7bwKZGMpRZrE2g=
X-Gm-Gg: ASbGnct+tpTLMWjIIzrBflu35eBtzFmW9Z0oglS54J1Lay7yv2QaEuHr0V1k7WZ4aWm
 OQLDIpNF+GLP0z15R0KOjA76pZgC71tHt/JNe8zrIBCW5GjUSV3j0cXSTz76+0HFj8VHvEGnKmk
 L5h9Xo76ImXUDOFQVTMYzZvNAIgQY0/z7LPKm8oUmJxXKWqA9Pxf1tIib95cfSnsy9gVHR9DVf/
 ZHiFt0YWzIlqYhhq1dWTuXZSwQ4GlC/WG8LmWfkylE2HmFuNRgL9SBdDjQM0XQMOeL4ZsBM/DE0
 A7wfpnU4bPot4zhSK0PoVHIgy5yVTbVE3b3GF6CLb2FGUgUI/w6wrRGpwZW4QeUFW7an3CQ5sAF
 vb0Vt7gECYM79PM6p/7CZQA4=
X-Google-Smtp-Source: AGHT+IHAof4Y+bkZ51mQq87Y93ORYobyB/yGBuCcElPfmW8AaqrNkteOv8IfLzFgjeKg/HLBuSc8KQ==
X-Received: by 2002:a05:600c:45c4:b0:43d:1f1:8cd with SMTP id
 5b1f17b1804b1-43d01f10c46mr25744805e9.24.1741679982087; 
 Tue, 11 Mar 2025 00:59:42 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015d2bsm16877067f8f.43.2025.03.11.00.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:59:41 -0700 (PDT)
Message-ID: <8a6e833b-a5a3-4c87-942d-488d1a5d9fe1@linaro.org>
Date: Tue, 11 Mar 2025 08:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness'
 property
To: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-15-philmd@linaro.org>
 <D6E3A7E5-7FF3-49AC-910F-02214E8E15AF@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D6E3A7E5-7FF3-49AC-910F-02214E8E15AF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/3/25 08:31, Bernhard Beschow wrote:
> 
> 
> Am 10. März 2025 00:06:20 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> The previous commit removed the single use of instance
>> setting the "endianness" property.
>>
>> Since classes can register their io_ops with correct
>> endianness, no need to support different ones.
>>
>> Remove the code related to SDHCIState::endianess field.
>>
>> Remove the now unused SDHCIState::io_ops field, since we
>> directly use the class one.
>>
>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/sd/sdhci-internal.h |  1 -
>> include/hw/sd/sdhci.h  |  2 --
>> hw/sd/sdhci.c          | 33 +++------------------------------
>> 3 files changed, 3 insertions(+), 33 deletions(-)
> 
> I don't have the code in front of me right now. IIRC, the PCI subclass sets the "endianness" property as well, but doesn't need to. This has to be removed, otherwise creation of the PCI device will fail.

There was a patch in v4 doing that, but I dropped it in v5 :)


