Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31723D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdwZ-0007N5-JJ; Thu, 14 Nov 2024 12:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBdwY-0007Lh-27
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBdwV-0007fm-MC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731606463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t/opWIIb3n7KwmQr8OFPE2skjKlYb1+5DClf5sVKDac=;
 b=afmseTfzdKxUIJ6Q4ByKORR+GVVgDvsMLlxHSFyjTQN0Du1pIHzyRYgi31SD9YI/hHbWX1
 TfiVeqBjCCOx6Cr3lLe74RQdGOT/266rLJp3EvwiNVnnxOc2UbyVCGctjimnhfE2M3Vmbg
 AnS+eot6X5I27w+ZHUW3u3jgRCtVZUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-l0f5Q4NLOrqMk6TxpxJEhQ-1; Thu, 14 Nov 2024 12:47:40 -0500
X-MC-Unique: l0f5Q4NLOrqMk6TxpxJEhQ-1
X-Mimecast-MFC-AGG-ID: l0f5Q4NLOrqMk6TxpxJEhQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so6620165e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731606458; x=1732211258;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/opWIIb3n7KwmQr8OFPE2skjKlYb1+5DClf5sVKDac=;
 b=H/LlDBMboLOLtzjIhjovuaIFR4gFmdWaYl2H75KGh8zOXYGbpQXmBPt3rHkStBsqDG
 suCIwVtVgmDy8x4CLFINnZw1yfA4SpNWgfGybiFMxOaXRj1PRcNoDrerpQH61Bu3AxUr
 fHIvYnBVCYJ462swGtBaA68n1c9lBhRPf1PN0NSe3NHUYfPK+hEsb1vitrRh1aQMZCHy
 5W7aqOomh/KIBxe9e46EuSDBs0ZkRjUTztj7z+8e/tQF5QsQBtAxLhrn7rS+msUagLOa
 9xMum4MNALN0BhsYsb3Qdbq12UQayAOBk+xBQyZ0IKypF0V2HQJl385wJNH4In6bUaTD
 YE9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRNab3BQcMF1MtGeeusJcGfYVhiPR5rU8lxi/hqsPua8I/c6zRK+Qdxd4RYf8w6zIkXdm8n6yo/Cn1@nongnu.org
X-Gm-Message-State: AOJu0YyJDIxV0fJF7sRA0JF1THapBghEmzTQMvHK82oV+7FRU7rgGKkF
 HLk75AtYumtgj4lHY+Tt7/CLduI3uHVGN6Gq7gQp/Q5J7bXQOODaw4JAIRkdCOmTUb9odMMm49Z
 0gZYjNIOMYCsmgWPk5h3EUoWXcVAPNpKefkJdbnRyFmk5k+bfxtNI
X-Received: by 2002:a05:600c:4689:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-432d4aaa129mr72670045e9.5.1731606458499; 
 Thu, 14 Nov 2024 09:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNOIi/vqeteiimXbBtl/akE6CkeE3UtiTmuzzKi7J2sW04csk7v5ENsabt2gyfBUp8BnGxIw==
X-Received: by 2002:a05:600c:4689:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-432d4aaa129mr72669915e9.5.1731606458147; 
 Thu, 14 Nov 2024 09:47:38 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80869sm27386135e9.22.2024.11.14.09.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:47:37 -0800 (PST)
Message-ID: <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
Date: Thu, 14 Nov 2024 18:47:34 +0100
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
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

On 14/11/2024 16.55, Jared Rossi wrote:
> 
> 
> On 11/14/24 7:29 AM, Thomas Huth wrote:
>> While adding the new flexible boot order feature on s390x recently,
>> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
>> devices. This property is required on s390x to pass the information
>> to the boot loader about which kernel should be started or whether
>> the boot menu should be shown. But even more serious: The missing
>> property is now causing trouble with the corresponding libvirt patches
>> that assume that the "loadparm" property is either settable for all
>> bootable devices (when the "boot order" feature is implemented in
>> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
>> one "loadparm" at the machine level). To fix this broken situation,
>> let's implement the "loadparm" property for the SCSI devices, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   NB: Unlike the ccw_device_set_loadparm() logic that we use for CCW
>>       devices, I've decided to use a string property for the "loadparm"
>>       in the SCSI devices to avoid spoiling the common code with too much
>>       s390x logic. So the check for valid characters is now done after the
>>       property has been set, i.e. we only print out an error instead of
>>       forbidding the setting (like we do it with the CCW devices), which
>>       is IMHO still perfectly acceptable. Or are there other opinions?
> 
> I wasn't able to think of a way to abuse passing invalid characters, but I did
> find two additional differences about the string approach:
> 
> a) it is not possible to override the machine loadparm by assigning an empty
>   string (loadparm="") to the device

Agreed, that's a (small) problem. There does not seem to be a way to 
distinguish between "property has not been set" and "property has been set 
to a string with zero length" with object_property_get_str() ...

> I don't think that the inability to pass the empty string is a significant
> problem because passing a single space will have the same effect.

That sounds like a good work-around, indeed.

 > b) it is possible to assign a loadparm value to a non-boot device
 >
> Assigning a loadparm to a non-boot device generally does nothing, but in the
> case of device probing (i.e. no boot devices assigned at all), the device with
> the loadparm assigned could be selected for IPL, but it will not use the
> assigned loadparm (because no IPLB was generated for the device). This check is
> normally handled by ccw_device_set_loadparm(), but I'm not sure if there is a
> way to do the validation without having a setter function for the property.

Hmmm, that could be confusing for the users, indeed. But maybe it would be 
sufficient
to properly document that loadparm is only working for devices with a bootindex?
What do you think?

By the way, the loadparm section in docs/system/s390x/bootdevices.rst looks 
like it should get an update, too ... if you have some spare minutes, could 
you maybe look at it?

  Thanks,
   Thomas



