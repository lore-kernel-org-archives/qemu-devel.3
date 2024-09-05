Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E085CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAAD-0005PO-3z; Thu, 05 Sep 2024 06:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAA7-0005O0-GC
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:56:28 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAA5-0005ei-Dw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:56:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374cacf18b1so405509f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725533783; x=1726138583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=907bO3fuFFO2itYxiTRu2TEqp3PJna+vWuaQNYIdISQ=;
 b=EeqBqhan8+1BaUS6L68yhf0p0Wv+C1lyW29agugk58/JOL1AXJRymO6nnQxhDk7sxB
 ByPr1lmcySGGa3mo19tUBLxffwrA8YjHGesWprwYcZPoMutDVFeoeDRphZJh0jtO2oXH
 vjTPFb8ctw7iM4ls7iFxhQtekpxAUqTzC8T+a6KKDCCczI2lOAfwwlDcyAz3Cr0EhxQo
 b2LeUWL+kkehsZUxgxK3lIiVefZYkSYKu7XK0tU7f9V32PMc9rsl+GORpyza8ZrPMh8M
 mySKsBhbCaHNFxQYMgxbJkyX1t06fpOjbFMoio2FL4ePTrslJ4KZBk+IvYvK2QCahTph
 6h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725533783; x=1726138583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=907bO3fuFFO2itYxiTRu2TEqp3PJna+vWuaQNYIdISQ=;
 b=YipVkNTUizEdZ/8BrehXTMhIDoNNb0Jx5nI0oM0kOt7NsVsg96sbt/SWgPfeVB5uAf
 zFcUs4vPn8hfNYq54+2DyJBNAFRZGsfY0BcpKF+KmxTXWYnmVfHikg4FXVVjmyND6qcB
 kKNBOR7EJmbDfojRNt0Iinmxj11bjwt/FQmn5zyjoG9bB8RPt017DoMo9z6popoditUS
 tt28qaQz8Yab4C1PnqE1YmC5104B+9GF3psSdr9Gc2WDWpLMr0m+yz5FJ/9W0J3zpZ7G
 ppe9TKSXYyH+xiFOq8oRDCz2+ePkaIkSfiDOr0gAlkd2sJBw1xY2rEZctEsJHwJ2wGUj
 iieQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHo+NOQQKTKt+Oyj94SVAVd46p+hNEkW0Mv+GcKbyFrwupzqfTjcH95SZNh9jhTNFEggDGcgFYbT1h@nongnu.org
X-Gm-Message-State: AOJu0YzrszK1hzTHe5CIe/IDRqwnQMTe4MQUJ0G6We4BB5wtVkUK+hZE
 R5LCPZOeHqff35CIVfi7e8e2+KdIS2fAbkZsCirISYt5Lw5/uP3zAsDL87a8bI8=
X-Google-Smtp-Source: AGHT+IHCC3Q/ZV0Q01eqFHMtYgvtj3nDyubwteIzEqUVfWc2150vB4gu3pQuiE3YoVlPRDOHKznhUw==
X-Received: by 2002:a05:6000:105:b0:374:c3a3:1f54 with SMTP id
 ffacd0b85a97d-374c3a320cfmr10057028f8f.18.1725533783414; 
 Thu, 05 Sep 2024 03:56:23 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbf15b9b1sm189046895e9.10.2024.09.05.03.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:56:22 -0700 (PDT)
Message-ID: <1ad65475-171a-4be7-a929-6499eda135b4@linaro.org>
Date: Thu, 5 Sep 2024 12:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: Document QCryptodevBackendServiceType
To: Markus Armbruster <armbru@redhat.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>, eblake@redhat.com,
 qemu-devel@nongnu.org, arei.gonglei@huawei.com
References: <20240812014252.1398754-1-pizhenwei@bytedance.com>
 <6d6d5d2c-3696-45eb-b9ba-fb5a754fefba@linaro.org>
 <87tteu2xah.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87tteu2xah.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/9/24 12:46, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 12/8/24 03:42, zhenwei pi wrote:
>>> QCryptodevBackendServiceType was introduced by
>>> bc304a6442e (cryptodev: Introduce server type in QAPI). However there
>>> is a lack of member description. Thanks to Markus for pointing out
>>> this.
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>    qapi/cryptodev.json | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
>>> index 68289f4984..9622c6d92b 100644
>>> --- a/qapi/cryptodev.json
>>> +++ b/qapi/cryptodev.json
>>> @@ -28,6 +28,16 @@
>>>    #
>>>    # The supported service types of a crypto device.
>>>    #
>>> +# @cipher: Symmetric Key Cipher service
>>> +#
>>> +# @hash: Hash service
>>> +#
>>> +# @mac: Message Authentication Codes service
>>> +#
>>> +# @aead: Authenticated Encryption with Associated Data service
>>> +#
>>> +# @akcipher: Asymmetric Key Cipher service
>>
>> Can we drop all trailing "service"s?
> 
> No opinion myself.  Eric, what do you think?

Not really giving any useful value, noise, but
I don't mind, no need to bike shed on this ;)

> 
>>> +#
>>>    # Since: 8.0
>>>    ##
>>>    { 'enum': 'QCryptodevBackendServiceType',
> 


