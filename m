Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B7FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJpvG-00064j-Ci; Mon, 04 May 2026 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJpvE-00064E-T4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJpvD-00024N-D3
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777888142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KDncqbVrPskIFOSH/qGR+4I+Mluz3ZMS5cXHG+Xm8t4=;
 b=EFibhtbbN5h5rIZhI7oFw3fAicbKStzp89u6T3BF4p6Yxtuz/vma3IVTs77sLqPyMylf4C
 03PQR6u2wV+p6fyiarP5+ssHPf3v2zHlXFs/ZYFDvy0QEnAOoMcnMXtmEsHWmwTFvEThK2
 lXFlfj/uLK73vfx6CyY65F/OvCs5fMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-JNmayw5CMNegk85VvwHRYA-1; Mon, 04 May 2026 05:49:00 -0400
X-MC-Unique: JNmayw5CMNegk85VvwHRYA-1
X-Mimecast-MFC-AGG-ID: JNmayw5CMNegk85VvwHRYA_1777888140
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486fa07f2bbso29574005e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777888139; x=1778492939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KDncqbVrPskIFOSH/qGR+4I+Mluz3ZMS5cXHG+Xm8t4=;
 b=YdNxdtqhiadLP6SyS5zIC2ir1t6DCGbax343KzLX/9kmcJLInWzLOpryT0wt6bHbl5
 4OwtSGs0GdjOm0VId6cmd/nfpwj5HNd4gO6semKbYwzjBh9YeWlzTNOlKYan9cXC7RAL
 1pz/SMJaJWfaf+/uFgppxQLZfjPBIS62d8EpcG51o2rprOh8I9xygtlNmbQvf/KyDEXM
 DR2x9aOSltVFHYa9iUitEG8zeYP/aLayn+w6lNwUucf91XLRfeJ5+jK55LrKBA4C7432
 DcugYCSI4QDZyEcvhs2G54SIZDtTAs1+Z396pSYKafpqHWjbEZgSZGeehx8DZB0xEx8y
 M/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777888139; x=1778492939;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDncqbVrPskIFOSH/qGR+4I+Mluz3ZMS5cXHG+Xm8t4=;
 b=jT/4vrirmGQeyLWjAL8wZ9BuN/y6jrNkMoBr56L41/bNFrUXS7dUmgM2vyksnW0ooP
 FMGXZRLlW8+exLZZ2e4+5Tk1Ah8+L6mlFsCjtAb735bZAGkGSi+SjbRMywoCzcyAbxDf
 M1at7IKEmBRfKXiv7d0qE61R/LNo/3ZJNWi4Rp3wn13rT9hCRUhVzFBPN24jvn9z2rez
 PDeBR86O+IeOclnEhh/plZwR5crKWxC9R8hjMDnZC3mZ8uRm2OGRDJN0li2B1tdZGe+o
 jSLL3uukb5owhr7e9yuzWvxp5eXLv8pTgxgsG7dA9NUF5shbWd+HWmBBeyI1RDqKGOI7
 +rUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8Bih39xtwm23Iq0tRvY3fCYGLWuFAC4VnHur/hNq71F8uvBoaR/7Tqiu7g87u0olAAQQ9yX3Mum6e@nongnu.org
X-Gm-Message-State: AOJu0YynZM19q7bdg9k4SmsvFlkKmWBuyTploRAt0MPtiKyMomhP4shi
 pFuC/9uFxujSvuIV4xthxqiotyGLJKMm+dggs4obOJsCbW3Ne+MEf7LvCEme0r9pNoaB+keIV8g
 qCs34CZ7PyLw1AUR+dtYYjGKNIcp8PcDsNa39/02tFbHMnv3Yc7lzz3YZ
X-Gm-Gg: AeBDietFgvTc4ApZmleHovAWbvC6MZMTEvFK/GkEhRGBw6etXoSkO/m/78CNcQIHzqg
 1fegKwTluCfd51UdQaX6ZhvLreOlcVJWRdZWlGhO9Ptk18pUtJr2hWVbMcaZxIV3jIcNj+JtV5j
 FfL8R+d2TrLX5FGBltG2BLX2CZ6aHkjbKdSL0MxrCuLmbEmcRuDXH4zwmBLdHqivzCNhRtcB/ot
 uDFGShZoBbiz19E6syqYPvg7pXuDL/cdaBSzyBKh9f7dM94JAo6B6g38dbitfkJPWGXOYVldo0N
 S51y2oVRTDak9jEMhgG/f/rmvD21KCD5P4tFadB6SVmV1tkK9asv05a/Ff8T0MYp+apxuSWB8Gp
 jT5GnC5Yfn+ytkIeoQOMd0wspTGSsWb6iBn0xCapusNpJlnTixXD7A7ErCvG79UOllFiCIJQ=
X-Received: by 2002:a05:600c:a316:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48a9853e4f8mr106300375e9.9.1777888139630; 
 Mon, 04 May 2026 02:48:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a316:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48a9853e4f8mr106300055e9.9.1777888139201; 
 Mon, 04 May 2026 02:48:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8bf18c9bsm24421667f8f.0.2026.05.04.02.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 02:48:58 -0700 (PDT)
Message-ID: <1bf864b8-0dcf-45d6-a2fc-fc34b1bafe97@redhat.com>
Date: Mon, 4 May 2026 11:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
To: milesg@linux.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
 <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
 <52d11eed-751c-4272-b31c-c14f13a5c829@linaro.org>
 <7629e08d-7d9e-496b-8310-27a075d52430@linux.ibm.com>
 <06e2bccb-975e-418a-a3d8-210be3a337c0@linaro.org>
 <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4def4bcbfe241bcd8437a195757dd753ce09a32e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Glenn,


On 4/30/26 17:43, Miles Glenn wrote:
> On Thu, 2026-04-30 at 17:15 +0200, Philippe Mathieu-Daudé wrote:
>> Hi Harsh,
>>
>> On 30/4/26 08:54, Harsh Prateek Bora wrote:
>>> Adding Glenn (since PPE42 seems to make use of CONFIG_PPC405)
>>>
>>> Glenn,
>>> Please take a look and let us know your thoughts.
>>
>> Glenn can have a look, but I think we are good to remove them now,
>> they have been deprecated for more than 1 year, enough time for
>> any reaction ;) Otherwise that'd defeat the point of deprecating
>> and the pain for us to schedule and wait for months.
> 
> Philippe,
> 
> Sorry, I thought it had been made clear back in August of last year
> that we would need the PPC405 CPU to hang around.  The topic was
> brought up by Cedric when I added support for the PPE42 processor.  Is
> there some formal process I need to go through to have it removed from
> the deprecated list?

I don't know of any un-deprecation process. I suggest sending a patch
to revert commit 52f0b59ec6b7 ("hw/ppc: Deprecate 405 CPUs"). The commit
log should mention the PPE42 processor which is a stripped down version
of the IBM PowerPC 405 processor.

Thanks,

C.

https://lore.kernel.org/all/20250925201758.652077-1-milesg@linux.ibm.com/


