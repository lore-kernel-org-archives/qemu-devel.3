Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D878ED2E018
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VNi-0001fo-VJ; Wed, 23 Oct 2024 03:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3VNh-0001fQ-HG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3VNe-0003aO-BK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729666923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RKqvuzrfiJLsatAfIvO2x7uz9AGbTj56hrFl0WcV8bE=;
 b=ikHF2rFhIGV3mX6hZWgy+8IWXq+oolrH0djclUI5seDZvD/et5yORPobKRdDd4Wc6S6IpO
 IQdhiS4fzYUFuyPrVHC2ZC9+KwTgTsSRPYfEn6MsjxmGznixvKHKdjBMK/n2vudL1bZ3Zx
 vNfxEM4AfYojbMgmISf2DiLjiSbR3pw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-Cah0ti24MsufzVOuD8GoCA-1; Wed, 23 Oct 2024 03:02:01 -0400
X-MC-Unique: Cah0ti24MsufzVOuD8GoCA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d533a484aso236057f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729666920; x=1730271720;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKqvuzrfiJLsatAfIvO2x7uz9AGbTj56hrFl0WcV8bE=;
 b=ZlIy7P4EnFMLb2Nnr406NYSGOdYPqC2L7gtgerjBBt5l7j2EpF9zRXxQNnFsszi4AK
 lQr4ft0bEqqAyEdVO0MqeyjfsCOaFOUI7KddWZFFdGL2P8XPFMdLuw/UUdnZ1fkn1tr4
 K74sJVIxURR5V+xul+/VGCX2EnIDEY1f3ZYHbS9hgEI2IFJY7GAO/jhuRxNshviczRRc
 fT4xeUQ6i35dXeZ9ct/Hul6mW5bhv5eXwBmXrMlyO82aGfib6GTlRqx1xdtISRuFdy6e
 9GyhvSQO9xrvnMb/4x4ArOMZ65OVe08i29XzJwQBj0lvaXwwqcMZzCw3dWg9fNSx7lSl
 1LYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9EVfXq/z2QqW1xjy5ggcODm7jl8AO0FsKHMbjvxnrlQO37dZbdM6H4eSvoEgWBRpze9SQNdhM1vrO@nongnu.org
X-Gm-Message-State: AOJu0Yx06OYVDMmmYipIBkKScw+GKrxWtgtD0kv1/i3Lbi+5hTS7Y0mk
 8qR5gJcO/Aan52SwpwlmTTKOmXd81mB3CQ73kMHS0smz07FfjtwiJiYqq/ddZPgsE1oCu/Qoznm
 f0/xDclBQshHKMCBODhOLbAcHffQDCRdN0sj7x/0hO0IvboQwtCEs
X-Received: by 2002:a5d:6dd1:0:b0:37d:34e7:6d24 with SMTP id
 ffacd0b85a97d-37ef14da610mr3223726f8f.18.1729666920531; 
 Wed, 23 Oct 2024 00:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENbnBpAkJKr+6Vs6T20vW6XRLZydkhkjowYWZudLDQEOTMN6kiIKQRNzsW8QMhDACE6WbNmA==
X-Received: by 2002:a5d:6dd1:0:b0:37d:34e7:6d24 with SMTP id
 ffacd0b85a97d-37ef14da610mr3223697f8f.18.1729666920101; 
 Wed, 23 Oct 2024 00:02:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c0e06dsm7666185e9.33.2024.10.23.00.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 00:01:59 -0700 (PDT)
Message-ID: <b54e4ef3-2619-4c5a-960b-f57c4028e72c@redhat.com>
Date: Wed, 23 Oct 2024 09:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Joel Stanley <joel@jms.id.au>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "kris.conklin@seagate.com" <kris.conklin@seagate.com>,
 "jonathan.henze@seagate.com" <jonathan.henze@seagate.com>,
 "evan.burgess@seagate.com" <evan.burgess@seagate.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
 <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CACPK8XfB=tfSBnPVUjJgAR23W3GXS_hxMiamPJT=7qL5Pgw8zQ@mail.gmail.com>
 <f7a8c0ed-27d2-4a0b-af2a-30f427812896@redhat.com>
 <CACPK8XdM-RrT4wJFEokD+mbYU_vus_Pwoq9kiUwpQbdM9WLVWA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CACPK8XdM-RrT4wJFEokD+mbYU_vus_Pwoq9kiUwpQbdM9WLVWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On 10/23/24 08:52, Joel Stanley wrote:
> On Wed, 23 Oct 2024 at 02:35, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On 10/22/24 13:54, Joel Stanley wrote:
>>> On Wed, 16 Oct 2024 at 01:23, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>>>
>>>> 3. Test HACE model with u-boot hash command
>>>> a. load test file to address 83000000 via tftp
>>>> ast# tftp 83000000 jamin_lin/32MB
>>>> b. get sha256
>>>> ast# hash sha256 83000000 2000000
>>>> sha256 for 83000000 ... 84ffffff ==> 1ddcccdba742d762e2b8da0bceaf4778727c5eba54a24d7ae0c573c65414f736
>>>> c. get sha384
>>>> ast# hash sha384 83000000 2000000
>>>> sha384 for 83000000 ... 84ffffff ==> 825d9b24bb797695545b3cbd2f373b9738627c7a1878e620415570a57c7faed77916d47084c954254f101fc0f10c0591
>>>> d. get sha512
>>>> ast# hash sha512 83000000 2000000
>>>> sha512 for 83000000 ... 84ffffff ==> b5ae725b2dc1e521f48eae37dd82c3d5fc94f7acb5fff3dabf1caa4bb4b5bcfb498e7cc1fbaa97dda2664bff99f9f8e778f823e95afaf76fbf0985181522e478
>>>
>>> I attempted this same test and noticed that the 'hash' command was not
>>> using the hardware. You can see this by putting some printf or
>>> breakpoint in eg hw/misc/aspeed_hace.c do_hash_operation. There's some
>>> missing work on the u-boot side to move the "hash" command over to the
>>> hash uclass, so it can be used to test this code path (or add support
>>> for the old API to the hace driver).
>>>
>>> Separately, I attempted to test with u-boot by enabling hash
>>> verification of the FIT image, and it fails to calculate the correct
>>> SHA.
>>>
>>> I think to have any confidence that this model works, we need to add
>>> some testing to qemu. I did this for the initial version of the model
>>> in tests/qtest/aspeed_hace-test.c.
>>
>> There are "accumulative mode" tests in QEMU, which were added by commit
>> e0c371a0d23b ("tests/qtest: Add test for Aspeed HACE accumulative mode")
>> They pass today with this patch. Are you suggesting we should add more?
> 
> I was trying to find a test case that showed the behaviour was broken
> before (segfault?) and fixed after, but haven't had any luck so far.
> 
> The tests pass before this patch, and they pass after it. By that
> logic there's no problem merging this one:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks,

> 
> Someone (aspeed?) should take a todo to resolve the HACE situation in u-boot.

I will build a br2 image with upstream u-boot. The ones we use for
tests have an OpenBMC u-boot IIRC.

Cheers,

C.


