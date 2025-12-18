Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7421D6D232
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGKb-00057V-Dn; Thu, 18 Dec 2025 10:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWGKX-00057I-Lx
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWGKW-0006dC-3E
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766073254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kBGANo2ZNKucPhmTG5OJEf/t1XnHcv8obKKiUkZNXBU=;
 b=Ep3nXHr7dSdhU5rucTiD/OhlWbnFQ88aGZc9/J+qOsefCo04Nixp/4wXdGYYLZ2cdYH9kf
 8A3tlLkwbI0K52JbFb3rE2OIvliUTSFuDSTtHr1Dcj7Pf2l9ToWVpW4y4Pq6vriKwUAmE7
 Maqz+8TiDrB5Ufsf8yigZ5eGy4Go77Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rGaD402XNT6lPe5jJ2CxfA-1; Thu, 18 Dec 2025 10:54:13 -0500
X-MC-Unique: rGaD402XNT6lPe5jJ2CxfA-1
X-Mimecast-MFC-AGG-ID: rGaD402XNT6lPe5jJ2CxfA_1766073252
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so6394195e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766073252; x=1766678052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kBGANo2ZNKucPhmTG5OJEf/t1XnHcv8obKKiUkZNXBU=;
 b=DgkLmagOMMBR5C4SKginesHFEk0z0mvcXgIjSy1GD3e7JFUN22MPK+u5BPJRx72/yt
 gSNPooMM6/L0xMFWxHFhs2jNBMnmIVcMRYrCXPYo1gNIs/Ztju3wJGqMLorXiU15J7uD
 zJPVoknD1aiy4RJ886FFRTuMRaUFNF0RwtUbeQ5+za4h/CqvKryfXBRxsYx/L4Plu8xn
 4A0rfU/O5rsZoKRYd0QTSsUV3gLr5seDcAUcCWCvS6TzMhDA156Qm/xp5EwIkSmZBXci
 TbXhgWB3HDp0CHoK2kSGWY86LLSlpL4Kj5d0Rb+2gVCDfxWkN4NLsG5IXDKfOYghD70b
 X8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766073252; x=1766678052;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBGANo2ZNKucPhmTG5OJEf/t1XnHcv8obKKiUkZNXBU=;
 b=YZ3zHz2sybjZc7VZaNWg1qB6/jDsTxEx+nGiHGlX8IqIhrBsN5YmP7JC87SQS8Ikt+
 WzxauFF1ajhaYsZKmgkwzb75EjUtR/hhorQ2Wn29Vsa6mZ+f298n9vJiKiz7OrJZsrlF
 QQBU4LUs8DvGb4zUE3cUJ6+DJ3DBCerHXxn0Dn3X52RM3n6F8m3jSx4IQBUFxr9rjnOT
 cZ83xcLntrHMe3xxoqQPeiLTfjb5A9ihREJjJ/PSfkJMHADmup+SYKz9Si/2EziR9FHP
 6YPoaVxggh7LJ6wUfVdYFHReAs6ng+MW6zLPEHQ7rSSJq5zOVtWVHFZae/61gEt5BrQm
 bbcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVedHXaCMl/m2ApQDRQdvrpPWnPTjzz2+j6d61Eyzowx/0VEqjKKIdH3EafKTYLf6FAXfSjhcMXz+8e@nongnu.org
X-Gm-Message-State: AOJu0YzPraFuRMZ6NkYu56CFYnZFBgF2j4dvE8FGbh2saGvaV2O4RF0z
 dW/6SYANpeTrYf2rYfppnEx2okgFzIZh76Uy1UvMuZ0FZhSYrLbgTmUGKV7MxhV7jkntXb3UN5f
 UStcWzdPp9bpcHk3s80IRkh9c2PLn95gCnt1vmpTx6E98N2Hs6AV+Hn+W
X-Gm-Gg: AY/fxX7FKjo3cBXRFXl1Tza3qa/FEzIFwYh+IfTE6akeTSZcpFPzuRtH1Lfhqe+HWa5
 NF4Bkpi8sH4aiGqpxjmUp5lMLuqPiq7LxzyoKaF5fQOF6dY9ESYN0RDEHuhF0mOzFpZABZs2VBa
 hTo7XbIeMqD0PRX96iAlTCEMFOW9z8pNkD/GiQ6aZxA4hRve+2s4bGLvU0fy525j4sC3AkAaIJN
 mGkZ4ErpfkQs9PVOJ3kTXO8q3JUv86IQQRuNmTX1PUOfAtwo3P2ptB7fpD3zen4Iz2tRSeC5uE7
 K13myLSIt27oSxcpPCxhptZjFbE6474OzSWHR71ZAqqvOc6XTbXINj6sDn38+3V/J4k9AWIFJ/5
 aVxCy4W7g0o+TbRB6iWD3v2XRkR+KSfsih2L78JWftxUUVDMj
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d18be144fmr628955e9.14.1766073251906; 
 Thu, 18 Dec 2025 07:54:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDzMcqT28FpczQqFbtYAfBybWbXiyTMuU9njUx7cXSTctVhryAdlS081PUxySteC0h+sudFw==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d18be144fmr628845e9.14.1766073251534; 
 Thu, 18 Dec 2025 07:54:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a40c5dsm16442685e9.6.2025.12.18.07.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 07:54:11 -0800 (PST)
Message-ID: <95b68a9c-0627-4903-93c1-fd8a8aebc612@redhat.com>
Date: Thu, 18 Dec 2025 16:54:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Remove stale comments related to iommufd
 dirty tracking
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
References: <20251218065042.639777-1-zhenzhong.duan@intel.com>
 <80397b14-160b-4a87-a0cf-d828f2974c85@linaro.org>
 <IA3PR11MB9136FEFC7DD10A5AECEEF40292A8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <6e850467-490e-4a32-b60f-2c91efb3efa1@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6e850467-490e-4a32-b60f-2c91efb3efa1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/18/25 12:23, Philippe Mathieu-Daudé wrote:
> On 18/12/25 12:07, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Subject: Re: [PATCH] docs/devel: Remove stale comments related to
>>> iommufd dirty tracking
>>>
>>> On 18/12/25 07:50, Zhenzhong Duan wrote:
>>>> IOMMUFD dirty tracking support had be merged
>>>
>>> [in merge commit dd4bc5f1cfe?]
>>
>> Yes, or you want me to add [in merge commit dd4bc5f1cfe] to commit log?
> 
> Maybe Cédric can directly add that when taking the patch ;)

I'd prefer a v2 please.

Thanks,

C.


