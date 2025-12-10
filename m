Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6782BD3B9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 10:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTHmk-0007ZU-GI; Wed, 10 Dec 2025 05:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTHmh-0007YP-PQ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:51:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTHmf-000168-MU
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765363860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aoHiCtfW6rhKisfUPMhhja77pg/afoNuvCcZQ3I2JCE=;
 b=Hiwlt6rVUoxJ3WDu9ZLJe9FCa9RxaeOesKLXh8bh0uqKGdaW7SdHtinTUZQPTvi1EFmxFZ
 eYOE6wj3HRqfcSAKka5W/CczoP32InAQpqS6EsAQl2jljfzvZPsLMpKL1CJCoLecY6/FdM
 U8J8If71jJr0T4duwhrBcRKlbTXiA+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-idmyb9JiNUqyX3A5LDJ3xw-1; Wed, 10 Dec 2025 05:50:59 -0500
X-MC-Unique: idmyb9JiNUqyX3A5LDJ3xw-1
X-Mimecast-MFC-AGG-ID: idmyb9JiNUqyX3A5LDJ3xw_1765363858
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so42487015e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 02:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765363858; x=1765968658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aoHiCtfW6rhKisfUPMhhja77pg/afoNuvCcZQ3I2JCE=;
 b=OtcsfMHng8FeoPkNbR/CdbHJ4v4MXQSaGDqQCvlmhVyTnEW/bkhs9zZjG19H0/MVPA
 scxaM0n4tkz/+Y5H/4Az2YsRmj5o/lq/pspgr6SXFVSoIoMkNv1k8yqlpeUhoERJHvNg
 CmSBfFzKqmKIHotpJSwH2eeCzNM1Aj6ecITWywL9v2NJJAcczG0xEwDVTirtV6M8/BYU
 CeapLxr7CNcIfjCMVtOiw1GBW230LWG5WvGzfsUVu6eTFmDqM2QbU5X5zDTMr3J4Vlhc
 X9+nl/Ex3RIO1+9Socz2KXlyX9gIybFEQcJ9y41NoMMANvyo1mLEG2bQQmT1YX4A/mVE
 6I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765363858; x=1765968658;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoHiCtfW6rhKisfUPMhhja77pg/afoNuvCcZQ3I2JCE=;
 b=eyfeX1w9g8sf8N7n/7es/B7EP1qV+6URD2Et8Nmw9BYkzAXGsj+NSYmXA2C6e9BZ/h
 Pyuoacp/ykV/DCJa462HbDDM5eGXBn7SmMD3tDkirTVppIyXj/49v31s7vLisxrWhvsl
 pWku6dWDqvW/C3MXGxmoRuadtiKAMeTcC22ggCa1lUIYM2tF9oqg55RUDRDph/mONrO7
 QkQS29GjFrYVM3PjAI7Utix18flcFwf0S+h1tpfyL6w3kyr71TpFehUEQ/+OFNcd0gY9
 wT2VA8+YoTgjrLA5FYUhlTBcWy8cXSGQ3n1Buk7gtGkFCHSeotgp9GfiOZXYD7+UPBlF
 65oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8C5PnrzeWUyr0FeUcKno3FZij6tQWshg2DygHF8qa/SPyxP0hmXs10ayBuVNRun7naNolp759Gitz@nongnu.org
X-Gm-Message-State: AOJu0YzsLnkbilP0+xEg1qz6Bxct46omHMDgBO6tvaAZ4KLfnlbUebUz
 bpwOUUKHdcHCHnWjyFvitt6PvddjuX9+qhGTpn4JGrkjs/ijUBi5VOXSEjNx9vaXduWcJglLn7Q
 G0e4Gjn/nlH+OuWX558A3NZcyMSOCvSZQggDID7yfIU90WuXLvKOTtdla
X-Gm-Gg: ASbGncujNqxPV9uKVJJjmkaCytdrB2ZRcyy4mnICloPJBBnMHEaDI4UjFFKjnd8QiIm
 gEjdFJCMQeW5lxo8+Z6xzhfn+wctDfA/lIKEM6TosPy21vIX0KA0a2eJ01o/TmobJgNxhniWcml
 yHgHUPUgibofysYmTbDHO30S9kAh/Fjx9YEOUvteHt3tgNbKZtBlZSEVw+j4+6bQyCk5Fc/JoXd
 e1ua1iVpQ86B2b+Ppwdza9lONVDUOw1JyXYLuqPvXPxFuGratP6ScN5Qtp7UCIu47AMYejiZneW
 aUgs5MVRNRNX40ydxPNAxq4syv393iqjnIVlOLaqb2L+nxO9iwWfyb5x+s9dzD2MPW8IxyY1mXT
 CMIbvHS9bRxmULzsttA0Wu5C/wfkG4bCGcjwSyXdT8VFdP756
X-Received: by 2002:a05:600c:3111:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47a8374ce60mr19233525e9.1.1765363858213; 
 Wed, 10 Dec 2025 02:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUfP3PLk/Ks/7zf3IrZ9j/1r5lxcPTiS7d8pgHwL0Z7HCUXGwpZw7ZcLB0vIBGtOhc3lufgQ==
X-Received: by 2002:a05:600c:3111:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47a8374ce60mr19233335e9.1.1765363857793; 
 Wed, 10 Dec 2025 02:50:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7da4885esm36809645e9.20.2025.12.10.02.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 02:50:56 -0800 (PST)
Message-ID: <0fc6d169-918e-4065-a112-9a07d9af1365@redhat.com>
Date: Wed, 10 Dec 2025 11:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update reviewers for CPR
To: Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 qemu-devel@nongnu.org
References: <20251209183412.3903519-1-bchaney@akamai.com>
 <b6caf9a7-f0b4-41ef-8841-d8aca5c97607@oracle.com>
Content-Language: en-US, fr
Cc: 'Peter Xu' <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b6caf9a7-f0b4-41ef-8841-d8aca5c97607@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+Peter, + Fabiano,

On 12/9/25 20:02, Mark Kanda wrote:
> On 12/9/25 12:34 PM, Ben Chaney wrote:
>> Signed-off-by: Ben Chaney<bchaney@akamai.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 63e9ba521b..812c86fab3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3116,8 +3116,8 @@ T: githttps://gitlab.com/jsnow/qemu.git jobs
>>   T: githttps://gitlab.com/vsementsov/qemu.git block
>>   
>>   CheckPoint and Restart (CPR)
>> -R: Peter Xu<peterx@redhat.com>
>> -R: Fabiano Rosas<farosas@suse.de>
> 
> IMO, Peter and Fabiano should continue to be Reviewers.
> 
> Thanks/regards,
> -Mark
> 
>> +R: Mark Kanda<mark.kanda@oracle.com>
>> +R: Ben Chaney<bchaney@akamai.com>
>>   S: Supported
>>   F: hw/vfio/cpr*
>>   F: include/hw/vfio/vfio-cpr.h
> 


