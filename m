Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997D5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFPB-0001AS-Rx; Wed, 14 May 2025 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFP5-0000yk-Jo
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:56:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFFP4-0006Pj-39
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:56:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so9350885e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241780; x=1747846580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03NFeFkvcXV/SgZYdV+cqawldxX/MyngMFRKwJtWSm4=;
 b=kTAsxUdYi84EZ+r/fevA0SHrMZtRPhUBaFNAlgyqSZalbF/uISppj8rzinAq6J59Ms
 JI5fWXbUOfQsS9Jy4WY5XjSSpIr2QnMwc/6p+EE4AIvJ6GScihFbgv/hmMynT74NPakK
 +CQjghL1SuFn/lqK2rAfkjqCfehQDpZe9h5UzjMXe5EkIP7OixhyggO6atqG26gAEG9U
 O/Vxje5M2CmgBz83zk+gX9VIAMZApPIaFLthe+OXWO6/T/fCEPrGigUyCwct6Kltf9ID
 KyMcHZL9N+KBdU12toHgJB04C9NaPyQ/mSQKZZkF3ZjqvwaEDmUZu7MdaATbhQrVNzsJ
 SWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241780; x=1747846580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03NFeFkvcXV/SgZYdV+cqawldxX/MyngMFRKwJtWSm4=;
 b=m0XhWMqO+IpfgCFo+NawuhoNRvVgyF+bBOJxqTbV5c5hi04AIUAAj/CLGsTcOYoz09
 l8TFHM14GKJJ2TXIm9c4IS/lvMbJrzs6HH3KYW52vsMsiFWWRU0VEd/SfeJn93JCKhyg
 Xs5wgqQrnPf0WIZd3X9xBIl1lN6DhacQHcmqZ/iLzVGrplN+kbRtpnVKJPQ7tp0glmt6
 tqAyL5OP+Lr3H4GBHMUapDBW8ROkgUNqtLrObb2HnAymFpNSWLWq73NZ8TuRn9dDLKWn
 QToMcngh3Uybg0biIntJuxObc3kegbsbxQGVcBPMpWbqgoL5kmmcwJNsWQxAQ4cvPSwZ
 EVxQ==
X-Gm-Message-State: AOJu0Yyw0/R28H7Dk43B8u+VaNDZiXUD3if7RG4qGI1ryg+OuBLu07pb
 P+62w3vqnrETIWPAZtcX2t8qyxYhchnnL51aY4Eos7CirhQHpZtXFSoi0nvi/HPvROk=
X-Gm-Gg: ASbGncul4J0eArBm4VCcWwZYZyVohzN1eiQB3FoPJAYDmutDm9yjQiX8lquNBvpI0QM
 OyFzBx0BYVCCfvhoD8PSMxJhTrZFMEQN7yH5+7/Xj9am7tuuHSnjJ8Ee2lKSDBgnBhEXBlm4SJf
 w6k0hVXis0c5wuIGNrEVWvzTzVl2JHR/wE1F8+cVAQ/G5Lj+5AH8n61B9DrWRdSlz0lBxiBDGIt
 kCnwA1/w1non6KyPeXZ7g6oXKUWj9DxYF5aficS6bEgXpAmTl7ikXEAv7J9AwB22oyHX9yOHFs7
 Dvx94ihHYjyjFp5pBS9+P9H8M2CLmaB78y+Igzbyb1CdcFQk7/MklFOMdmb2lgCcBL809LZ/BSM
 HsWdgBsbdZs2lMMaSXw==
X-Google-Smtp-Source: AGHT+IEvbjZbi3iIDArt0denYQx7gUSNbKnEiElozTf2rkIceCHHXVn790DEM4FVrwhycONy6GF8dw==
X-Received: by 2002:a05:600c:3507:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-442f8524653mr3130535e9.15.1747241780377; 
 Wed, 14 May 2025 09:56:20 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf0esm20347840f8f.79.2025.05.14.09.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:56:19 -0700 (PDT)
Message-ID: <17188f61-b225-466c-8ccd-f4d633797bb7@linaro.org>
Date: Wed, 14 May 2025 17:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/core/resetcontainer: Consolidate
 OBJECT_DECLARE_SIMPLE_TYPE
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-8-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514084957.2221975-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/5/25 10:49, Zhao Liu wrote:
> The QOM type of ResettableContainer is defined by
> OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES, which means it doesn't need
> the class!
> 
> Therefore, use OBJECT_DECLARE_SIMPLE_TYPE to declare the type, then
> there's no need for class definition.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   include/hw/core/resetcontainer.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


