Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A7ACF07A8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym0q-0005Vz-06; Thu, 10 Oct 2024 01:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sym0d-0005PF-B6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sym0b-0005TL-22
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728539199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8cqlvRpTD5SxWt+ULyo4+JQ3tB4VhuKqYYk9b+WRZ54=;
 b=A4CPHOZmvtDy/2wndTAF+Hgvw8oII6Ylt323xzi+NBqSldhqOi0J0ueEgHzoC30qdVuDah
 w786Ry8Na0u/kOs858dPfFEagSV7GTBHwY36ciEsF0ZWiGXzsuSUUgUTYPJPl5zPrwZhu5
 Fb1nnbh7Bk9W3X1953xRV23g6/IPLls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-c7AT7mCFNvCNXPTKnrKUlw-1; Thu, 10 Oct 2024 01:46:37 -0400
X-MC-Unique: c7AT7mCFNvCNXPTKnrKUlw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c9127ea1c4so304229a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 22:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728539196; x=1729143996;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cqlvRpTD5SxWt+ULyo4+JQ3tB4VhuKqYYk9b+WRZ54=;
 b=EKEPJ/Z3US9DZu2MAALPuPgQc5G2q+33oSnhZTch+eT98b8dE+COsjwyvUOQIrkUsw
 cCdXBpG2Eu7+1kot4/59XQAAq8JgNrGfteyccBvndnua4scXpLQF1WDpGtXAy1NXchoX
 MkvXjBtp1AetsZ02QwnfixiVdunkjW1p2lWwcb+MF2TFwAg7QxsAVOZyb1O6T6zc2S2n
 vegBTFC0tCcveAv4UiQSGM4kWjGk95eGiDRpBn6Bc6f8ffO8UUpySTDa+fTlb6z7PPaA
 eFlztVAfBgUff9frR2xh3G9lafq6G/PDOlwFJcxj6QegMq5jmBl7NZ0hYI2V8y+hQjCS
 usBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMtSYIsWhC195o+ZhnO7m47rZ8XhYbyapBu3wK6H5li2/0wMEEF9bgwdy5GsVt+YC4+EfYJ00EKfzz@nongnu.org
X-Gm-Message-State: AOJu0Yzcf/XuKjgXdhnNrCafxSwDu/IAiZ3fskJmwfbTZcJSz32fXbJ8
 4AAH9/N2JxT62fxaIgsDvjgsp+SZ/RmZYJbPs56CDUnqN/z7W5aHFx6Bp32AjqJ8KL62x5216cM
 sB5dizyL2vsDHnarjpC1q8l8iskPUnvgQt5JHN/5npS70cTIAYZvdpI5LOkG/3Xc=
X-Received: by 2002:a05:6402:35c5:b0:5c9:2a18:9814 with SMTP id
 4fb4d7f45d1cf-5c92a189dbdmr2351214a12.1.1728539196199; 
 Wed, 09 Oct 2024 22:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMJ8TOcvoZMBiFRO26eauz4482PgLWtnzbgPMqakBYVNNOra0CNMKuSoQoE6EaGmo/aH4Mvw==
X-Received: by 2002:a05:6402:35c5:b0:5c9:2a18:9814 with SMTP id
 4fb4d7f45d1cf-5c92a189dbdmr2351205a12.1.1728539195768; 
 Wed, 09 Oct 2024 22:46:35 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9371533c4sm293282a12.54.2024.10.09.22.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 22:46:34 -0700 (PDT)
Message-ID: <4007e335-9305-4668-be63-f7d455016971@redhat.com>
Date: Thu, 10 Oct 2024 07:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] tests/qtest: Add s390x boot order tests to
 cdrom-test.c
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-20-jrossi@linux.ibm.com>
 <f483f958-5b42-42f6-9bd6-c4b1f8fe8d7a@redhat.com>
 <95a53006-7a91-4f9c-a421-a11796af134d@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <95a53006-7a91-4f9c-a421-a11796af134d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/2024 03.37, Jared Rossi wrote:
> 
> 
> On 10/9/24 8:48 AM, Thomas Huth wrote:
>> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Add two new qtests to verify that a valid IPL device can successfully 
>>> boot after
>>> failed IPL attempts from one or more invalid devices.
>>>
>>> cdrom-test/as-fallback-device: Defines the primary boot target as a 
>>> device that
>>> is invalid for IPL and a second boot target that is valid for IPL. 
>>> Ensures that
>>> the valid device will be selected after the initial failed IPL.
>>>
>>> cdrom-test/as-last-option: Defines the maximum number of boot devices (8)
>>> where only the final entry in the boot order is valid. Ensures that a valid
>>> device will be selected even after multiple failed IPL attempts from both
>>> virtio-blk and virtio-scsi device types.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   tests/qtest/cdrom-test.c | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>>> index 9d72b24e4b..123c067589 100644
>>> --- a/tests/qtest/cdrom-test.c
>>> +++ b/tests/qtest/cdrom-test.c
>>> @@ -213,6 +213,30 @@ static void add_s390x_tests(void)
>>>                           "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d1 "
>>>                           "-device virtio-blk,drive=d2,bootindex=1 "
>>>                           "-drive if=none,id=d2,media=cdrom,file=", 
>>> test_cdboot);
>>> +    qtest_add_data_func("cdrom/boot/as-fallback-device",
>>> +                        "-device virtio-serial -device virtio-scsi "
>>> +                        "-device virtio-blk,drive=d1,bootindex=1 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d1 "
>>> +                        "-device virtio-blk,drive=d2,bootindex=2 "
>>> +                        "-drive if=none,id=d2,media=cdrom,file=", 
>>> test_cdboot);
>>> +    qtest_add_data_func("cdrom/boot/as-last-option",
>>> +                        "-device virtio-serial -device virtio-scsi "
>>> +                        "-device virtio-blk,drive=d1,bootindex=1 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d1 "
>>> +                        "-device virtio-blk,drive=d2,bootindex=2 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d2 "
>>> +                        "-device virtio-blk,drive=d3,bootindex=3 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d3 "
>>> +                        "-device scsi-hd,drive=d4,bootindex=4 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d4 "
>>> +                        "-device scsi-hd,drive=d5,bootindex=5 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d5 "
>>> +                        "-device virtio-blk,drive=d6,bootindex=6 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d6 "
>>> +                        "-device scsi-hd,drive=d7,bootindex=7 "
>>> +                        "-drive driver=null-co,read- 
>>> zeroes=on,if=none,id=d7 "
>>> +                        "-device virtio-blk,drive=d8,bootindex=8 "
>>> +                        "-drive if=none,id=d8,media=cdrom,file=", 
>>> test_cdboot);
>>
>> Could you please use a scsi-hd for the good device here in the second 
>> test, too? ... so we make sure that the good drive detection also works 
>> with virtio-scsi devices and not only with virtio-blk devices.
>>
>>  Thanks,
>>   Thomas
>>
> 
> Do you mean use "scsi-cd" instead?

Oh, right, sorry for the confusion!

  Thomas


