Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2660C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZum-0008HL-Sk; Tue, 01 Jul 2025 08:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWZuW-0008Ef-Oo
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWZuT-0005ZP-Vd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IT54fb49QFa52bwH+4XrMmNP1NuhdZHVopLmv3GZ9zk=;
 b=g+bWrrIG06fGUhHq/49zf9tvEbjIlw9vQHvFhtNm5C8nnHuj4rSbOng8mw12zljywrZsY3
 IM8w3TwV/4Uo19keYeDGpNAfwOxKCjxn3sapoa/2OUGAexkLC/GxZrCBFh+rsGJA4hh4Hv
 wjJ+9iL5vtoEPs2H/Yz+5+izx4uW6/4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-hnnDs5MGPouJNxlR5vBqbQ-1; Tue, 01 Jul 2025 08:16:20 -0400
X-MC-Unique: hnnDs5MGPouJNxlR5vBqbQ-1
X-Mimecast-MFC-AGG-ID: hnnDs5MGPouJNxlR5vBqbQ_1751372178
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4537f56ab74so22724145e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 05:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751372178; x=1751976978;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IT54fb49QFa52bwH+4XrMmNP1NuhdZHVopLmv3GZ9zk=;
 b=a+uwOiCo9QKSJyAlsZ/C7WMrm+b+Pjd+4KlIXcpI+MhVJhs934ZsA7hnUFldErfp9w
 9sLkRd7dDLYi46jtDTvWtCLIb/akc93hV8a7DOWz3oP4WMElckk/ZPrQ0g5v9eF6wlAN
 hXpBHH54sUmpKOebnWCtq9UzB9fo15KX/QFfbi+uG2brjCR8yKsyflSpBfEuhB1wV6Hq
 dQ5/y3NRZB7j2BehxM7nXgQSR174In09A7hTaAdieiOMwAxo8q/xaJ1onyaxMK0l6PCP
 9k0WgmfakNX2nmx/LIOQqC9Bu+wRbV580yQD8lESOSZcAsbt9Zu7w9rjNIVCqiL2BWK1
 OPpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTNrdVFnJlrW6OFpS95dbGYgK05Rc92MW4YqmCT26UvPqhLvrhrxqfs47A5DHZfnj6qf7tWxuPDp4M@nongnu.org
X-Gm-Message-State: AOJu0YyEhpDeD4SuLKu01INkNHDhshp+erjZ6VpzB94TEPOOAP5SVHQN
 qxG3qJO6+JBgDfo1tyzBZI1rRYY9w2r559k+iNmSitbqJw/wdTsLCW4I3wnPGfcONnhITo22l2Y
 T6Wfab67CDAKE+SRHJ4UV9xC5WNuiKnwWv1l7E4rshARshDv/GFDBmiS0
X-Gm-Gg: ASbGncstCtIqMhZcTfF5SvZjvefWbE7hKpYJ/apGotLEh0E6taBL6ieqjO34nI9GZ2X
 sU0u9ObFLC3mEUDcwY+mTdu5p5DipY5W9Ecgg6in1jQ+J7eqqfzXoiBeuY6bw0GHZKAsuqTbR1f
 KOWewvZA0ZXiGfU4eaHz0qkppTxft9qFRGgN2T3bUV9a7/hIVgOFvtJtzeHKcs2WRkugRHys3L0
 zjrRHiJ5bn8HPZryyHI6rypluIJj7PY4C1d6YA1QVXbDowvedwkaY5Ise4LUFUUq4+Wy0B4qExG
 VyN/etlFjiPwJET5++/uEh8qY/tBTgrrhkS59x7ufQ5RvnSEB8BOgtWUsvRM
X-Received: by 2002:a05:600c:450e:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-4538ee6edc1mr166802545e9.29.1751372177762; 
 Tue, 01 Jul 2025 05:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98SnJI0AbNJpjT1Q048MgCEMFWyF+15kAgFflqvRHegdYobqR0rXyM5dOPwtEa8cv+w0pQw==
X-Received: by 2002:a05:600c:450e:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-4538ee6edc1mr166802185e9.29.1751372177238; 
 Tue, 01 Jul 2025 05:16:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233bd14sm197395185e9.2.2025.07.01.05.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 05:16:16 -0700 (PDT)
Message-ID: <257986c3-54b6-4ae7-8176-8c4c74e0b8db@redhat.com>
Date: Tue, 1 Jul 2025 14:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4: Drop linktrailermask
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250630172301.519848-1-clg@redhat.com>
 <23065936-513e-4240-afaf-3d25de747dcd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <23065936-513e-4240-afaf-3d25de747dcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/1/25 12:04, Philippe Mathieu-Daudé wrote:
> On 30/6/25 19:23, Cédric Le Goater wrote:
>>
>> When grabbing a patch series, the link trailer is replaced with a
>> Message-ID, which is not useful compared to an URL. Fix that by
>> dropping the linktrailermask config.
>>
>> Cc: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Hmm :)
  
Copy&paste error from 838cf72b5d2c. Sorry ...

Who maintains .b4-config  ?

C.


> 
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Fixes: 838cf72b5d2c ("Add a b4 configuration file")
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   .b4-config | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/.b4-config b/.b4-config
>> index 4b9b2fe290f9..126f503ded74 100644
>> --- a/.b4-config
>> +++ b/.b4-config
>> @@ -11,4 +11,3 @@
>>       prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
>>       searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
>>       linkmask = https://lore.kernel.org/qemu-devel/%s
>> -    linktrailermask = Message-ID: <%s>
> 


