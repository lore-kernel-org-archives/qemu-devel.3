Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C0DC54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHtR-0003Kr-0X; Wed, 28 Aug 2024 08:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjHtJ-0003DV-JL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sjHtG-00032x-Hs
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724848509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bktHROW/eeK6KIiYmxl5H0JjE5rD5n4UGGYZUC/j2c=;
 b=ez3KnWqK94dEPa0h6C/hU4SrAQ1+lr1aVAdgBn21+83ZVFSQ8dxaLVgg0UgbuPkCb4OixF
 aJrZE8KarVOgHVvOBU0i73AHgZLKeLWZiqpD0404lvcJGOjAaoTCzJXvIZGUaevhGpi4v+
 O9rx1f7yBad6iE2Pgc9h2q9Q5dolfRc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-KCplZAxvNNOyxasYsT1oLg-1; Wed, 28 Aug 2024 08:35:05 -0400
X-MC-Unique: KCplZAxvNNOyxasYsT1oLg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4567535a819so4716031cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 05:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724848505; x=1725453305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0bktHROW/eeK6KIiYmxl5H0JjE5rD5n4UGGYZUC/j2c=;
 b=L7ywmh+VXRAtDTADtvqfAu6h0jMIg0Uv2pQrY9SI07TNkFLAtcV/o+FSDEa7MMvIW2
 870mH8Pof280Eg/1dQ2ZfG8CrlkcZhm1qORRMex2Dsp4S8EClvQxG88vAvargAK4QrFs
 Kr9t2P1sLWe+4z5SdMiRdLaJ7ayLfHA+KllbAJez6o47NMLWR7WrFI4lbG6Pt+JDVyE9
 +dWv4gOiW5eBhHtmxzvcrCMsHBYr61UIM9Kqz4+LqbuLv+4gLjvN+D42VMzETCPCZMO2
 99I32MM5qTrjGHS/6xsMbA8iEFItejRw8xEog0CBGTDZVqcEojukCH5hYLVeeuzrHwPJ
 iOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMvHql3j0Sh0DvVpu8QyxonG9n9reQvfhaqLxda6ZmbEM+HNlkH7rV3gbF5JYXZuEpO664Dq23kci1@nongnu.org
X-Gm-Message-State: AOJu0YwJL3PPNI7uMs+F1UTmSdDHSQ46/EkweAToJWlAbTB0HVLmw9Lk
 mzuit35xP/pfaeHsCw5HN4ocrMwviasKP7VwFPBEwXzuRCka2NNYnvyHkZ/QD9gewCcG/dFX5Td
 nB9A+n2gr7D7dq5Gt+KfIXOragklR6FL17zlNEI9RkETzUoiR3uT0
X-Received: by 2002:a05:622a:4895:b0:453:7706:759a with SMTP id
 d75a77b69052e-4566e59da5dmr23124631cf.3.1724848504845; 
 Wed, 28 Aug 2024 05:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP4btYNq6zSqsot+ke9/Q6qBa/Zo1x+K4Z1yJzCo+Ij99rBa/bcfsr3r0TBWKE2ow4wLLrEw==
X-Received: by 2002:a05:622a:4895:b0:453:7706:759a with SMTP id
 d75a77b69052e-4566e59da5dmr23124271cf.3.1724848504409; 
 Wed, 28 Aug 2024 05:35:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4567d226c35sm428161cf.31.2024.08.28.05.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 05:35:04 -0700 (PDT)
Message-ID: <8d1fd867-647b-4827-a2b2-a239618a7743@redhat.com>
Date: Wed, 28 Aug 2024 14:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aspeed: Deprecate the tacoma-bmc machine
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240625070830.492251-1-clg@redhat.com>
 <4e04f930-e7af-4084-99a8-2a3139e2bf43@roeck-us.net>
 <5fb7342b-fa67-4cb2-b6fd-2241b7b76d03@redhat.com>
 <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f70cb39f-3567-4322-b1c4-1bc5991d91fa@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/26/24 20:50, Guenter Roeck wrote:
> Hi,
> 
> On 8/26/24 02:58, Cédric Le Goater wrote:
>> Hello Guenter,
>>
>> On 8/9/24 00:05, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Tue, Jun 25, 2024 at 09:08:30AM +0200, Cédric Le Goater wrote:
>>>> The tacoma-bmc machine was a board including an AST2600 SoC based BMC
>>>> and a witherspoon like OpenPOWER system. It was used for bring up of
>>>> the AST2600 SoC in labs. It can be easily replaced by the rainier-bmc
>>>> machine which is part of a real product offering.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>
>>> I have been using tacoma-bmc to test tcg,tpm-tis-i2c functionality
>>> on arm. rainier-bmc doesn't support that, and other IBM BMCs which
>>> do support it (bonnell, everest, system1) are not supported in qemu.
>>>
>>> Do you have a suggested alternative ?
>>
>> Could you use the ast2600-evb machine instead ? as done in
>> machine_aspeed.py, see routine test_arm_ast2600_evb_buildroot_tpm.
>>
> 
> Unfortunately, that does not work for me because that requires instantiating
> the tpm chip from the CLI by writing into the new_device sysfs attribute,
> and I can not do that in my test environment.

Ah. too bad.

>> We can't add a "tpm-tis-i2c" device to the tacoma-bmc machine init
>> routine because a TPM backend is required.
>>
> 
> Not sure I understand; tacoma-bmc instantiates the TPM chip through its
> devicetree file which is what I was looking for.

I meant at the "HW" board level in QEMU.

We can not instantiate the TPM I2C chip device model in the tacoma-bmc
machine init routine and attach it to the I2C bus because of the required
TPM backend. This means that the device is necessarily defined on the QEMU
command line and this makes the ast2600-evb and tacoma-bmc machine very
similar in terms of HW definitions.
  
> I solved the problem by adding support for IBM Bonnell (which instantiates
> the TPM chip through its devicetree file, similar to tacoma-bmc) to my local
> copy of qemu. 

Hmm, did you copy the rainier-bmc machine definition ?

> It isn't perfect since I don't know the correct HW pin strapping
> and reused the strapping from Rainier, but it works for me.

Keeping the tacoma-bmc machine is fine if there is a use for it. Testing
the TPM I2C device driver is certainly a good use but we should reflect
that in QEMU also (so that we don't forget). Could we change the test in
machine_aspeed.py to use the tacoma-bmc machine instead ? and revert the
deprecation patch of course.

Thanks,

C.




