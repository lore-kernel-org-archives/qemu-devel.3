Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 16:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqa6G-0007j8-Ts; Mon, 25 Aug 2025 12:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqa6B-0007iv-QW
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 12:31:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqa63-00008J-OJ
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 12:31:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4a25ccceso26522155e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756139454; x=1756744254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D7n52OUoycyDYyz3JmkfICoLFIsQBsVNwixqccS4z2g=;
 b=uHCClfwx4ZaLSIry34qHHybH5Tvfn8+P6d64w7XVBwN4jl3fJu/jb0zQpirEJxBTdT
 GTcbft736gAMh7/aPw6WrqDBClnNIdqbF0mYX8KS8tDNJH8ZIpdwoU4rlOEjVWqd+pn5
 OTB+gZqS/TSsuqjjcfJWi4J5XwPt8w8PJIysrVvE973ZGo+qeBcw4iqFKyvP1ElkfCV1
 geB1MKIwZMj99KQd1tNmmdMIwMuLxBJtxeUmBL/OwxIAUrmdH+4oStQCAnFXY4vUBCEI
 IJMjCtDbBEHjvpsZLGM7WIveofqpJB2ntsF1gIJ+0oriTHT/M/LcNfvy1VT/FyI7Lbiv
 ddng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756139454; x=1756744254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7n52OUoycyDYyz3JmkfICoLFIsQBsVNwixqccS4z2g=;
 b=ECBO8ymggiHps/repz0c70h1qea8xFRWObDJcouB/yPQ20EgVF+TFnsDcoOmZMSRBA
 J+Odtq9X15PJIutaj91sk7nADuIFkH664Ql44E9wlEraKyw90rch5avHwDAFun5i2CdB
 4SIoUwcshG4vGWhCkYTv25Dz7/+LDYMLOOyMFYWSmIpv/XJ+9o5iKoQj8ufUO46YKhjZ
 5qimyzq6/mpvbLX9YPPOHnlDIgKR7IwVfjT7Lxo7PHKh4S2b20Kh2flsDvH1KcJehIL5
 e4L9tl0T6dPa34NKnE9bi3MqTtj5zpu/BglsfvOFtNcMSFdggph7TkHp8dJjns7QhHD9
 9XIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVETjlIvAMwAlK3tpUR1jYtQsmriXYVUTTQod1trkRXiK2WhRaiK4uSN1HFxczRfl9rd+T24dJO7bG@nongnu.org
X-Gm-Message-State: AOJu0YwUuTEbRWJKNZOHWFb/cqufULs1InGvcr3WFddANHs1aYLmYGkk
 Ym8njRpCGqAOBH2aev9haA2T1/B0FC0ui3O9ygL0AxZXnwhBdp8e38dUFtn0FvHJTPQ=
X-Gm-Gg: ASbGncuQHfIZWDiuZM7TgpxDErz3fh9hECnfAIo4NWYKlKPWOPsVuoIQnihM7A5VQCv
 zB+l+OmdLLdFoOVzp3h8aLSJI4j4IDT/9jfOEjMfWcf6jGb8TjR6gO2vD2Tjg+rJzfu1iDsRDGv
 V4AFxwvjPirp3TaWyujArNE6Uqk1npELIhJWvWsAddr9yxRQ+jt8UzrXFjm14Y2WKyJ/mtbonrj
 kRs3k7DCCGxPG4RRnbaQMnbNVPOIn5bLZxUxsGmCk+q+JJfnx+gddjF8egl8XrkSO3n7MpwBrMe
 YS1lxMCl9wnvTlpB4kpm/7JGRLc/jeuoY7b4oRpoa84g6aYLYVDMUhCsKiRrfM+UZBdbHRNJXyw
 SDKdQwNeiSLLIgYwQWjDJ1yBmldylT5wizTp7tB6SqnRq8owMhEw5wLYxco2Q57QlEw==
X-Google-Smtp-Source: AGHT+IGD5/MYK6XDJswRPzsEa8LkZiskw+tiMFTsDPLyroRuWYDtl1yVpt1osD3vOO4SeEJWCExyzw==
X-Received: by 2002:a05:600c:35c9:b0:458:b7d1:99f9 with SMTP id
 5b1f17b1804b1-45b517a0655mr109217665e9.11.1756139454365; 
 Mon, 25 Aug 2025 09:30:54 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e1d77e0sm114894105e9.0.2025.08.25.09.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 09:30:53 -0700 (PDT)
Message-ID: <c9f0e2e0-d533-4aa5-944e-cc5f0da30645@linaro.org>
Date: Mon, 25 Aug 2025 18:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/sd/sdcard: Handle RPMB MAC field
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <8ea56ae040ef1037e44fc864c159e2f96f23f059.1756019920.git.jan.kiszka@siemens.com>
 <51a9f857-69ff-43f6-8f3d-c7e5d5870c99@linaro.org>
 <97fce5d7-eb6d-4698-950e-94d5468d5696@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <97fce5d7-eb6d-4698-950e-94d5468d5696@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

+Dan

On 25/8/25 18:12, Jan Kiszka wrote:
> On 25.08.25 11:47, Philippe Mathieu-Daudé wrote:
>> Hi Jan,
>>
>> On 24/8/25 09:18, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Implement correct setting of the MAC field when passing RPMB frames back
>>> to the guest. Also check the MAC on authenticated write requests.
>>>
>>> As this depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256, only
>>> register the eMMC class if that is available.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    hw/sd/sd.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 89 insertions(+), 1 deletion(-)
>>
>>
>>> @@ -3122,6 +3201,7 @@ static const TypeInfo sd_types[] = {
>>>            .parent         = TYPE_SD_CARD,
>>>            .class_init     = sd_spi_class_init,
>>>        },
>>> +    /* must be last element */
>>>        {
>>>            .name           = TYPE_EMMC,
>>>            .parent         = TYPE_SDMMC_COMMON,
>>> @@ -3129,4 +3209,12 @@ static const TypeInfo sd_types[] = {
>>>        },
>>>    };
>>>    -DEFINE_TYPES(sd_types)
>>> +static void sd_register_types(void)
>>> +{
>>> +    int num = ARRAY_SIZE(sd_types);
>>> +    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>>> +        num--;
>>
>> Instead, expose RPMB feature in CSD when HMAC supported?
>>
>> Something in emmc_set_ext_csd() in the lines of:
>>
>>    if (qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256)) {
>>        sd->ext_csd[EXT_CSD_REV] = 5;
>>        sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
>>        sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
>>    } else {
>>        sd->ext_csd[EXT_CSD_REV] = 3;
>>    }
> 
> I need to check if revision 5 still had RPMB as optional (current ones
> definitely require it), but I don't think rolling back to revision 3
> would be good idea. If start to add more features from newer revisions,
> that may cause even more weird results from the user perspective. I'm
> not saying we are fully compliant in one or the other version, rather
> that we need to work towards becoming so. Have to support multiple
> versions along that will not make it easier.

Daniel, do you have a rough idea how many of our build config do
not support QCRYPTO_HASH_ALGO_SHA256?
(looking about making the SD device unconditional to it).

>>> +    }
>>> +    type_register_static_array(sd_types, num);
>>> +}
>>> +type_init(sd_register_types);
>>
> 


