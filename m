Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA43F513E4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGtc-0002HQ-6Q; Thu, 05 Mar 2026 17:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGtL-0001ef-DZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:10:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGtI-0002Kk-Ko
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so3508861f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772748590; x=1773353390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1QKRnEbmgre9i4rUGoRLkZOsFrhJM4Cj3PoaKHxHVWQ=;
 b=HOVpzcYHh+7pJ2//SVXiEFG+cTC6NVQYf9H6DdW4A/zsEL9XdwSUzD2HDJg6pnLIA2
 Uyck9FXhZwxBJg6GIxHHUyiiwHsxHMZUHG5UpOWlvb9/QOwXhtcz+AK/j1vl+eKu+q2B
 C/iBqL09sF7ZpFaPeFQfOAWXLJedkZiw96y+6ch1PPJRdAdtPH7c8Zk513FWzKjcejD7
 8ft2JrixVZif98GkpOu6qU4fsaiqRjaHbc7vgA/9CjCHU1UzlvnRP0puMIbRb1Eapx8g
 zds7L6p6BExURmGCn0Dq+1yXc4K7InCu+osdXowmVS49kBwx+Bkhh9oIPsh6MWiAXw9H
 nuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748590; x=1773353390;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QKRnEbmgre9i4rUGoRLkZOsFrhJM4Cj3PoaKHxHVWQ=;
 b=JoUXU6WYptAyzmAIzAzsB+4VaZtX+m28HCx1A+5nBfjjHjt4DtsWbD1piw/4MvMOEw
 jFF1wudnT51iJqEZEImmJOVJM6m9PY9bNomFEoIdoCFKL3Ru/ICtDxic8issAXsh8GI0
 FPUmlyx7otblv5/hf5NgtoF8V2dMRP1DuzrFiSkZICEpTDdWeMh3WxXzv893iApqrgmT
 KLU2uKroluEZDLnGeqEF76WkrOMdYsJTMz6n/u8DNwqqu3NNpwqLUhGPRpeOxqkKHxtc
 /T9UCKvw2cruEFCGBy4q7ZL6hCFj5/BCA9XbuReEVHHgVKD222OY9iNiZ4TP2ukF8mAh
 /AkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNA8ZuFlxKxduQpBRUq4qChofGg+uWEqlztFZ+CH4tN5L/nPmeqY/gae6dwzk+k8MZZqwfKYi5xeyI@nongnu.org
X-Gm-Message-State: AOJu0YxtdbRggCTQ6QdZdSlqN/rvPLt8K7SViVxPlPdozuCWMxtR2kwS
 35w089JRttJrQE9/jx7xL4qUAz2+50qB4uIZi3GBC/ZVhDL8Ztt3Ts4dLLjKjoYnR+c=
X-Gm-Gg: ATEYQzzT4USXovK7DDT1pB1WkwESi4U+S4azFrCJT244DUHbERyJtsa4zqUpvPMxfp0
 eBS90cAZrk2Yxb8J/VqsWyau0QGefc5hHQokvYffl1baXMuijfIL5OFwHGjojCZONtVpz305fSo
 cwr9O/1jB5wgqo6tbu59JKlFiji9KPIsi8bjvsAjDzON9qYjSkeqhJzQKE1YP+AUtedtGaayyvy
 10Mg2I4rKxrtTsAJBDSRmnhzabSl/Lh6CjijWN2C0b93/ybckWKb/YG1qQaTKp8OwmUq50IZ1io
 JYNZ1rNNER2QcZXj2DaTtm6LKp4UfpU7km34eCuEawCyYu1F0iu0u+y+ByVDGBZOl0qJ4dORm28
 KacTFlfA5p+2IhgPlWp7gqq5F9TIUGlTTFjkjBpLcN+cN3RKtIm8OJgADwrIRr5eWCJ+AIVFDrz
 g27c8qoUUlZJepkjIffimMBWVQUN8NrGqE1VRu3tLIMLcDvTBs/4jEbXht1JJCgFP4rw==
X-Received: by 2002:a05:6000:24c1:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-439d00638d9mr6972537f8f.30.1772748590036; 
 Thu, 05 Mar 2026 14:09:50 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c1fc577bsm22486424f8f.19.2026.03.05.14.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:09:49 -0800 (PST)
Message-ID: <adbc2d78-bb8f-4ec8-a6de-29ac5617ebb0@linaro.org>
Date: Thu, 5 Mar 2026 23:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <0BFFD4B5-6B69-4F75-B329-5C429E65532C@unpredictable.fr>
 <1a23f69f-fba4-4f7c-9679-d06ad65be1d0@linaro.org>
In-Reply-To: <1a23f69f-fba4-4f7c-9679-d06ad65be1d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/3/26 17:48, Philippe Mathieu-Daudé wrote:
> On 1/3/26 02:34, Mohamed Mediouni wrote:
>>
>>> On 28. Feb 2026, at 23:08, Mohamed Mediouni 
>>> <mohamed@unpredictable.fr> wrote:
>>>
>>> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and- 
>>> nested
>>> (tag for this submission: hvf-irqchip-and-nested-v11)
>>>
>>> This series adds supports for nested virtualisation when using HVF on 
>>> arm64 Macs.
>>>
>>> Reviews would be very welcome :-) It's maybe a bit unlikely that this 
>>> will make
>>> it to QEMU 11.0 I might as well try.
>>>
>>
>> The patches remaining for review:
>>
>> 1, 2, 3, 4, 5, 8, 10, 12

Series fully reviewed! Hopefully it still applies on /master.

