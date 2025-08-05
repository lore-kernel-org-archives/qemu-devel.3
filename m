Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C96DC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujO6m-0000y4-0r; Tue, 05 Aug 2025 16:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujO61-0000rM-1y
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujO5z-00079O-EZ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754425033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wCNa/6ajBjqzm+k3lIJ8R79rK0nC5j+tBBN7OUmInm0=;
 b=HKrhy5VPgr19m0iV68xY89FJKP4h+r/VkCbCXQpEQ8Sp3Jl+DKng6v8JgSFogak6KJtULa
 nVUhADGthZXZ0DKifT7QVQIL6Vv+I9ncCL5/6H+mXFS9pc4PXIfnyr6Ve0KeP/r/NVH7Fh
 vZJFWfHcaLvDPiz/Ei67b9TMiWYzVe0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-V901WhIhP0GJ_3xm7CU5bg-1; Tue, 05 Aug 2025 16:17:12 -0400
X-MC-Unique: V901WhIhP0GJ_3xm7CU5bg-1
X-Mimecast-MFC-AGG-ID: V901WhIhP0GJ_3xm7CU5bg_1754425032
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e7ff9e2738so457163385a.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 13:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754425032; x=1755029832;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCNa/6ajBjqzm+k3lIJ8R79rK0nC5j+tBBN7OUmInm0=;
 b=YD0e7R0WMJbFXbXeVJEzR72WqFkvIAzUSt7j/yGHzX7xVUoHnsEQ+R7jJ1a+62Pgaf
 YQBemDEG85kk/q4zU/aEAVlpkmn1aXkUANLdlus2wTWN8gbTTcVpSC0aGOsp8pZJnpzB
 8QGQXZYPXngwfTK6/Iaqi2t21pms3kGe3ajqxUuwCn7ozNe3+uOxOFs5VB28lEqWbNRH
 hwJ8CIp1DmJSFKq6So5OWoNos+7BIVRaq4yj9ieOQ3qEuJfAIsr//4MXlc3H38SEsnsJ
 dV0UP3bjfC+VurZ57f6GtOJSLaQ2yeM/XfAnRKOop88QGsfYR/p8ORowX//LY/qgCpoG
 fO6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/LaeL7nDLg+ujJNaHHTmd1ngcCGtkIylKPc6pD7gVvsp6P1mu0Y3yXWBPVOYAomNW8+hYaHl0u9N@nongnu.org
X-Gm-Message-State: AOJu0YxpOk3TSm/ua77SAcm+b9qSP74qJq5Ecee6KhpoYcVtHAjVW0BF
 rUf7MPiKHG9g8Iug6KAoRJuZPahcyrqQoJNUqQIZu2iuXsZ9J40jgRZdDz4n6I2GlrypZ+M8xPJ
 Za76+K72LyhyqBn+ldkGkxh5A9xOSui8AssBDpjo2P6rjWgci9P2Q8bdP
X-Gm-Gg: ASbGncvNbCWxo+ulLfS9oAOT4rMGRJGZvKfmc0CFG9LAvkl1ItqPPSXPdFXLJyS3fRF
 PmbVjXyfqeQCFGMxNIZ8oSmZ7eDMwRqL1jLwPW4VXC4lrTmOxpFmAqpBMfme5XALY32gnNqN6fq
 xpWX4K+aYPfjrkTvNZKQ58HCpofRVFPrYsmN5htlbYnQn1fZw4VirwVMRumnKCMwI8mIkL8wX7a
 KrhrjSilQOkF9FWb1+UP+KePYdg34vs1c4HfT2gO64eC2tyyLF+os3jn0j5n2T8S7QJxB0amiIf
 eGXT57ew4JxKmf5Zf5TSJ0TKgKJM8a6h0LDuUCIZWK3D4QAY5uXP8RdiU/CEZ6Y+6f/5xXpKeQI
 =
X-Received: by 2002:a05:620a:7293:b0:7e6:5f1c:4d7c with SMTP id
 af79cd13be357-7e814f3f15emr86597085a.66.1754425031806; 
 Tue, 05 Aug 2025 13:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOJyQmu+eVDzW8fSUT650t3i7HXMZ8+1nA6Rl41z3m6IP1F4vsNggGPfaqQ8YcTecty2d5Kg==
X-Received: by 2002:a05:620a:7293:b0:7e6:5f1c:4d7c with SMTP id
 af79cd13be357-7e814f3f15emr86593785a.66.1754425031376; 
 Tue, 05 Aug 2025 13:17:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e8091a0dc9sm193069585a.19.2025.08.05.13.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 13:17:10 -0700 (PDT)
Message-ID: <e3692d99-2bd2-4fa2-8e9c-ba26ef864860@redhat.com>
Date: Tue, 5 Aug 2025 22:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>, milesg@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>, Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <6b8af831-71e7-4a37-b3fc-af8e85fb25e6@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6b8af831-71e7-4a37-b3fc-af8e85fb25e6@tls.msk.ru>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/5/25 18:33, Michael Tokarev wrote:
> On 05.08.2025 19:26, Miles Glenn wrote:
>> On Tue, 2025-07-22 at 17:25 +03..00, Michael Tokarev wrote:
> ...
>>> There are currently 2 active stable branches, 7.2 and 10.0.
>>> Both are supposed to be long-term maintenance.  I think 7.2
>>> can be left behind already.
>>>
>>> Thanks,
>>>
>>> /mjt
>>
>> Michael T.,
>>
>> All of the XIVE fixes/changes originating from myself were made in an
>> effort to get PowerVM firmware running on PowerNV with minimal testing
>> of OPAL firmware.  However, even with those fixes, running PowerVM on
>> PowerNV is still pretty unstable.  While backporting these fixes would
>> likely increase the stability of running PowerVM on PowerNV, I do think
>> it could pose significant risk to the stability of running OPAL on
>> PowerNV.  With that in mind, I think it's probably best if we did not
>> backport any of my own XIVE changes.
> 
> My view on this, - having in mind 10.0 most likely will be a long-term
> support branch - we can pick the PowerVM changes, and if a breakage with
> the case you mentioned is found (which will be the same breakage as with
> master branch, hopefully), we can pick fixes for these too.
> 
> Especially as we have more time now after release of 10.1 and before the
> next stable series.
> 
> So to me, breakage in stable series is not a good thing, but we can as
> well fix it there, - so there might be some balance between known bugs,
> possible breakage and future fixes.

We have a large set of functional tests for powernv, even checking
emulated nested virtualization IIRC. I still have some scripts running
16 sockets powernv machines with a bunch of pci devices to stress
emulation a bit more.

The upstream target is OPAL firmware, not PowerVM. Patches for PowerVM
may be proposed later, if deemed appropriate by the IBM simulation team.

Cheers,

C.


> But it's definitely your call, you know this area much better.
> 
> Thanks,
> 
> /mjt
> 


