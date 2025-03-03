Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A60C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9hQ-0002Fi-IK; Mon, 03 Mar 2025 12:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp9gr-0002AA-TB
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp9gn-0005FM-9Y
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741023287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dv1pn2iFyltDTzEOO/CKAtHTBwpyZGIIm+w3dpZ8KJw=;
 b=BT0MafjrNDN5GN9NXMffH1hX9wy5usTj0E86ZNUL8hwOPzXowujgCKHwIuPTzY44pNwJPC
 24pMXvY4afImcGe9RiIrAuDdaAv6nnbY6EixxxrS9Hn/CwWBWM54aLGZ1Epj7UV1N2aRxu
 eWdcMF/96mYsW2rOWP+mvvA6XCvnmsY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-DwcrxH4POdSQ_Iv6VGygoA-1; Mon, 03 Mar 2025 12:34:41 -0500
X-MC-Unique: DwcrxH4POdSQ_Iv6VGygoA-1
X-Mimecast-MFC-AGG-ID: DwcrxH4POdSQ_Iv6VGygoA_1741023280
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935e09897so34477265e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741023280; x=1741628080;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dv1pn2iFyltDTzEOO/CKAtHTBwpyZGIIm+w3dpZ8KJw=;
 b=oLfRaE5HUOUKaMwEnb5Uvj6+905EEEf0dZh4R7MOsrfzh+jt/9yX9of5OjQiDO7kzB
 Eu4rQtXbIaPlR1h+UhP1KmJFuPdjLnVtNFvnzRRfq1tF0KPtRY93EUByR6FUy3BOt4BG
 VsRjJwB5PKrUoCiD0fCZNwfnCCWPjeMQoV18EwRpeJlW1ygg9VsfpRfF5cZuz8cWcUQK
 qyJULS5NtqajcxgXeGZvyZ1+eurIm6v0F/mcFLP5FCwcGQGB2hwT44HuSxpJNoI45167
 UtMD5G+/8ZP1XFaKOTq1L2xsCUBMKr7Nlb5ygpTnEjxySQa0R0KnpU6cPC4BXPYEHeuo
 DO7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0nivIFIfruLHwxxyYFmGvn8oVxSS/lsILqXvBNxJFG+FfokTkukLC1wjwJ+VDKNWm+GRfTCsos50b@nongnu.org
X-Gm-Message-State: AOJu0YzUvvmcxBjQb/KQCDxjyOSPHd/Uq+V7A+Jchii7A/7cyQkn3sIF
 51w7YcMZvbk7KYSlw5A6lTGhzqX7fYMWklzbmvWTBsNMepIC2Po9W3P5reZ2mT+ne5gPdVvdLg/
 yKfyIijfUVzQ/6vUOZR25K7f3i1vJi1SjvImOxP5eR3zYqukpqgDc
X-Gm-Gg: ASbGncsQDOF3QhrYtcphoqj5dOVs+rMx19E+bHxqiA3LA/Jrsp9h9Asui9yYueybgFX
 mwaeNK77aE9llr5DJg+eC56rHCoEGBBvE6eYcsM54sPXzphFgemonBk/WLAErD6WhG8dtdxl4y1
 tPpZbpZ5B4Dkwz0i+WY7bjgQVr72GG8ujLEvmDj3zlWOdhZQGHFblYeBQ83s1YzdG2GMyRxx78r
 SpQm+CIIghwulTwVGvq5pNJQfYUTCiRS7rlF4QKZzbnAKe4kbEiFIBwGdKf4cdAyDwKvx0OZwaY
 oSmnK8vtTep/78YFOXiS4SQRTns6FhNz2hLQhGb2vp+N9vZaGnZGkg==
X-Received: by 2002:a5d:47c3:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-390ec7ca2d8mr11793612f8f.2.1741023280032; 
 Mon, 03 Mar 2025 09:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBwbseDwVZ6dcu3Bv1UdWZGSYLkFN9s0puwS1SxevT6BxZ8URlpGicWBfmTOOJ/iHMHhlzuA==
X-Received: by 2002:a5d:47c3:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-390ec7ca2d8mr11793594f8f.2.1741023279685; 
 Mon, 03 Mar 2025 09:34:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844ac6sm14939997f8f.71.2025.03.03.09.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:34:39 -0800 (PST)
Message-ID: <4a89a4b1-d60c-4cc4-b6c1-b2b3c473f18c@redhat.com>
Date: Mon, 3 Mar 2025 18:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
 <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/3/25 17:57, Peter Maydell wrote:
> On Mon, 3 Mar 2025 at 15:49, Cédric Le Goater <clg@redhat.com> wrote:
>> Why are we keeping qemu-system-ppc and qemu-system-i386, and arm,
>> since qemu-system-ppc64 and qemu-system-x86_64 should be able to
>> run the same machines ?
> 
> They're not identical -- for example "-cpu max" on
> qemu-system-arm is a 32-bit CPU but on qemu-system-aarch64
> it is a 64-bit CPU.

OK.

> There's definitely a lot of overlap but we can't just drop
> the -arm executable until/unless we figure out what to do
> about the corner cases where they are different. Plus there's
> a lot of users out there with existing command lines and
> configs that assume the existence of a qemu-system-arm
> executable.

We could have symlinks. Anyway, given the issue described
above, we need to keep a build for the 32-bit targets.

I see that qemu-system-arm supports virt machines. Would
you know if there is a supported userspace that I could use ?


Thanks,

C.

  



