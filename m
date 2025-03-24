Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03EFC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkkT-0003Xe-I3; Mon, 24 Mar 2025 12:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkkM-0003Vv-F6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:33:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkkK-0007rV-TN
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:33:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so43990305e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834031; x=1743438831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ni17WLNyRxHvjALvzv0+sW3O+5csiCZzL9eUnAd8axY=;
 b=yFFydk+6O2X/eQTQJIBoXWU6Z1O2mT+cjUD4gdGoA+apvP2ZKWaEelD/6y5fWC0XOA
 A5k9qPKceBHYPFaKGZ3b1hufzjgrkLM09IQxCH2JZoJr+zny2NMwJTxDUZePkknK8dPE
 k/ner1GepX/LpRNjSAxXRkEP6ujMkUllF3l3EpuDd96VrNWHd7eFVI0nWndiGOZ3YBB1
 ao/rCfi7boF1cuP0cvmhhoSCLAPg1mLdDPJghGlA7uDxMLM7u8iKaJDp1n8ncocDcv28
 KD9pzwfVUZlzV1QPXrbDUVeHeEZyaa/oRnwc2SzuaQS7m3Njt0zTcPv/sdvXOTVz179G
 VJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834031; x=1743438831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ni17WLNyRxHvjALvzv0+sW3O+5csiCZzL9eUnAd8axY=;
 b=wIii9MMl+U4gEb3QO0WxVsobqR3SDfQ09IZ6AqOeTJgl9ayqbEe+FOp0ecyGIwV5W/
 Rn1cFggiFRz3t9zG6DswDmZIFVPrM78Z9qxJoCVWflggn8zr774AUmlIL3yos2vMMs6z
 WML9nZAcJqd8lrClBeV6qj6rk+Zdj6XplO6ocUbgy5B7MUqRxQvb1psY9aPX/c87gNZX
 nLI0arczOFPlGKiRXqtGrtTKWXUaDGW9O4ECeIXEUib1pUOeioCxcHtQrt1OkHa03eVg
 StbvGNvlcN7ZsEHPWVrQq6o14tLg8qJnnTMlYFaGpWqx09RqTC5pSiQbUDNt1YP8JqQj
 0a5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWveXKFgFBSxaVddZYP7I8H6/aGcyPTemdzr6LWBd4oUZRZdUBv83SiUnViH0sEkO/ugU008we36IPu@nongnu.org
X-Gm-Message-State: AOJu0YyFodaTrPi8BFRzpTRKhPbd9Vzq5GJyEmhDaUPt29C+sucCyy2F
 0LowFM1twZt4B+ThE+Dvn8kALfIUDfEWsV8sNEowKr7lrd0Bpe1csjBvWc7ih9I=
X-Gm-Gg: ASbGncsBQJGQSZaDdmHmEqboXOGmr8+h6f3zPpFrUkJuJ1F6DZv8cilcnJow2V85dar
 158pGRe+xijKrfurmXxRMlDHsmpgC4Xl2lR90Q63fe9EfLpMZ18UcKYsoXM8nGKHVOuE9E39HJ1
 0T6kG2LihjHcEpHcX3B64Y2u25tfXgnHeHu6gcxPRdkyjtw5WY5ivVamOMyVA8rc9eH5rH8TeoT
 +Y66fCyF3USvhWRToT+oE0QicarZZeWkwHm8B9u8KyBUClkkMNpcx4rGFiV1sDQEht2RL99lt00
 +TbD5e0eFCUvfgy0PeSUpdPE5l/LOI+mhxC/WcsmtcCjVLkVGWxXc6C690W6xf9DxSiBlOrUTqn
 BHAlgoh1g+V+BSFm3fQ==
X-Google-Smtp-Source: AGHT+IEG160alGuLKDPFDqgbj0jHUUI5dvsagMTQntdv5HPWBiHMj6dZVtWAfXzp9cXgNKgs8odJZw==
X-Received: by 2002:a05:600c:1547:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d509ec734mr120573405e9.8.1742834031075; 
 Mon, 24 Mar 2025 09:33:51 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdac92sm176234735e9.26.2025.03.24.09.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:33:50 -0700 (PDT)
Message-ID: <dbc4ae7f-a217-40bb-9c24-0d8a292774c4@linaro.org>
Date: Mon, 24 Mar 2025 17:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Fix a typo in s390_cpu_class_init()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org
References: <20250323153018.73491-1-philmd@linaro.org>
 <b2a99dd6-3d19-46b1-9ef6-ee799ac7e021@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b2a99dd6-3d19-46b1-9ef6-ee799ac7e021@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/3/25 07:05, Thomas Huth wrote:
> On 23/03/2025 16.30, Philippe Mathieu-Daudé wrote:
>> Fixes: 41868f846d2 ("s390x/cpumodel: "host" and "qemu" as CPU 
>> subclasses")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index d73142600bf..1f75629ddc2 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -377,7 +377,7 @@ static void s390_cpu_class_init(ObjectClass *oc, 
>> void *data)
>>       resettable_class_set_parent_phases(rc, NULL, 
>> s390_cpu_reset_hold, NULL,
>>                                          &scc->parent_phases);
>> -    cc->class_by_name = s390_cpu_class_by_name,
>> +    cc->class_by_name = s390_cpu_class_by_name;
> 
> Please add a proper patch description next time. I spent dozens of 
> seconds to spot the typo in one of the words 'til I realized that it is 
> the comma at the end ;-)

Sorry I thought it was trivial, but since it got unnoticed during
8 years, maybe not.

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


