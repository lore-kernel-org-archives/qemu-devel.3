Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86068D6DDD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 06:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBpsI-0006rt-62; Fri, 15 Nov 2024 01:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBpsG-0006rg-65
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBpsE-0004lh-IM
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731652325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N9KqYcUXvEhmp5rv66FRqom7FwsygkngudKGIxsVQLE=;
 b=X5aYA+yPguC2VpC52t78IUi98NLzuv5ojQAOJrJOKocRXxdPr1NkVRF7p8WiDnaGMZp/BF
 mtPMBO4yHIriaQ8Jj2dVI5MA8zVm0a3sRzOi3htr6v7Qw5yBkzZ56yks3rvPIB/FyDQDP5
 exz68T2HFGRh/gRu2X/4XoSonOQCP7M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0HSCkefAMcO4WI3ksdVJ-Q-1; Fri, 15 Nov 2024 01:30:40 -0500
X-MC-Unique: 0HSCkefAMcO4WI3ksdVJ-Q-1
X-Mimecast-MFC-AGG-ID: 0HSCkefAMcO4WI3ksdVJ-Q
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so25480106d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 22:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731652239; x=1732257039;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9KqYcUXvEhmp5rv66FRqom7FwsygkngudKGIxsVQLE=;
 b=NWzRX//nB6a7WAXP8+T92hHTzie6ZPR1Q0hgWCISLQGiNeKUxYHPQZIT8AOR29tlxW
 l5zVcYEox6TIe/BwrXZ5oKEcr0DKxC560GOQ04CJyGHVnNm1U5oEl+zZ0rtuYGncdgQs
 KWu5xPVIRORweZPmrPGTsWxzX9lMVjbcDHoogQ0HCS1ygMUwQ4FREwlwVsS2Okh9TMYd
 UMccYcKp13aQoBaqC3opkO4x2Hx/rHHPj4S6cRRRoiRCUNUVqL+8RE/dZA8UTvNiMENL
 gjWBvQBj6JtfG/fG1z8LmFoFn5FCE7ad8ogyFeQSAKpFt0hfPcoYSJzmadRncaFpBESy
 zaCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrpEcnMECOmKk6FY8uEQFfsd9Ghi5/pvTXTPFiOLBpLOF/anxCXTFuEuojkX2j6hfpXBz5colqlOKC@nongnu.org
X-Gm-Message-State: AOJu0Yz/U2eggIFEd0cvhrPu84d3y62nkphXEoNbKENFV1tBIG5B1p8h
 ZExejAWiNATs4SNZPrryUFXjnoSVz/LHMoMtjJtJUhc+EKBNyUy5deKWC/s87WOy2b2pa5wqIef
 dV3EHjewuXh5zneTUZwh5TPVrEgD/nHnoSm51yJl5aTH3fu9jc62B
X-Received: by 2002:a05:6214:4d84:b0:6d3:eb38:c128 with SMTP id
 6a1803df08f44-6d3eb38c5f5mr90681376d6.16.1731652239497; 
 Thu, 14 Nov 2024 22:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFas0sU3SeT1CmYCin2tG4CxmThP8yPwCMLIdsEQXUZLNPJeup8//JH+Ed//fsBAuT64kb9Rg==
X-Received: by 2002:a05:6214:4d84:b0:6d3:eb38:c128 with SMTP id
 6a1803df08f44-6d3eb38c5f5mr90681176d6.16.1731652239178; 
 Thu, 14 Nov 2024 22:30:39 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca842fcsm129574985a.127.2024.11.14.22.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 22:30:38 -0800 (PST)
Message-ID: <0e9b5272-2aa9-41a4-b0bb-43f0c89751e7@redhat.com>
Date: Fri, 15 Nov 2024 07:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241114122919.973930-1-thuth@redhat.com>
 <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
 <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
 <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/11/2024 00.30, Jared Rossi wrote:
> 
> 
> On 11/14/24 12:47 PM, Thomas Huth wrote:
>> On 14/11/2024 16.55, Jared Rossi wrote:
>>>
>>>
>>> On 11/14/24 7:29 AM, Thomas Huth wrote:
>>>> While adding the new flexible boot order feature on s390x recently,
>>>> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
>>>> devices. This property is required on s390x to pass the information
>>>> to the boot loader about which kernel should be started or whether
>>>> the boot menu should be shown. But even more serious: The missing
>>>> property is now causing trouble with the corresponding libvirt patches
>>>> that assume that the "loadparm" property is either settable for all
>>>> bootable devices (when the "boot order" feature is implemented in
>>>> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
>>>> one "loadparm" at the machine level). To fix this broken situation,
>>>> let's implement the "loadparm" property for the SCSI devices, too.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   NB: Unlike the ccw_device_set_loadparm() logic that we use for CCW
>>>>       devices, I've decided to use a string property for the "loadparm"
>>>>       in the SCSI devices to avoid spoiling the common code with too much
>>>>       s390x logic. So the check for valid characters is now done after the
>>>>       property has been set, i.e. we only print out an error instead of
>>>>       forbidding the setting (like we do it with the CCW devices), which
>>>>       is IMHO still perfectly acceptable. Or are there other opinions?
>>>
>>> I wasn't able to think of a way to abuse passing invalid characters, but 
>>> I did
>>> find two additional differences about the string approach:
>>>
>>> a) it is not possible to override the machine loadparm by assigning an empty
>>>   string (loadparm="") to the device
>>
>> Agreed, that's a (small) problem. There does not seem to be a way to 
>> distinguish between "property has not been set" and "property has been set 
>> to a string with zero length" with object_property_get_str() ...
>>
>>> I don't think that the inability to pass the empty string is a significant
>>> problem because passing a single space will have the same effect.
>>
>> That sounds like a good work-around, indeed.
>>
>> > b) it is possible to assign a loadparm value to a non-boot device
>> >
>>> Assigning a loadparm to a non-boot device generally does nothing, but in the
>>> case of device probing (i.e. no boot devices assigned at all), the device 
>>> with
>>> the loadparm assigned could be selected for IPL, but it will not use the
>>> assigned loadparm (because no IPLB was generated for the device). This 
>>> check is
>>> normally handled by ccw_device_set_loadparm(), but I'm not sure if there 
>>> is a
>>> way to do the validation without having a setter function for the property.
>>
>> Hmmm, that could be confusing for the users, indeed. But maybe it would be 
>> sufficient
>> to properly document that loadparm is only working for devices with a 
>> bootindex?
>> What do you think?
>>
>> By the way, the loadparm section in docs/system/s390x/bootdevices.rst 
>> looks like it should get an update, too ... if you have some spare 
>> minutes, could you maybe look at it?
>>
> 
> Yes, I suppose I would agree that documenting the behavior is sufficient in 
> this case.  I will update bootdevices.rst to include per-device loadparm 
> support and also indicate that that per-device loadparm values are only used 
> for devices that have an assigned bootindex.

Ok, great! Sounds like we have a passable solution for QEMU 9.2. We still 
can refine the loadparm handling of the scsi devices in future QEMU 
releases, but this will now at least solve the present problem that Boris 
reported from the libvirt side.

  Thomas


