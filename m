Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1571C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDCu-0007Zr-M7; Mon, 29 Jun 2026 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weDCj-0007U0-7V
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weDCh-0003we-FR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782744193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
 b=ddl9Ag5gqeUIINpv2HxTKNLYpX3bbeJmcFPM6mDTURea0s0d7qSFPi/slfRxnIrbx72siq
 MBO3kkUrOHt7Yo4sigoznJQ6LOuwozAWKI5dFK5lpmmssUCnNwerGOweGbsSfd+AXHSNiK
 2UKEJStQBRX/V5/jJddfdqFKwx3KnQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-k-tMIiEePOuQfOZhLllndQ-1; Mon, 29 Jun 2026 10:43:09 -0400
X-MC-Unique: k-tMIiEePOuQfOZhLllndQ-1
X-Mimecast-MFC-AGG-ID: k-tMIiEePOuQfOZhLllndQ_1782744188
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493a6fe9ebdso8803545e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782744188; x=1783348988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
 b=bJof6+2oBsA8oEBIBqHfaxFooA7IZ8HhFuH5oY4llvz3xU9uu0BxGWKqpyCGN/HDfT
 WqJegrkOccxGht8swq3ADG9AE5LF30RslWowPvbfi601gJMqqnCQet9eWz60sr5euQA9
 JBgJF8wAXwyAiYqJLYSz7Bh3BR2j2rh1jBC3ZWmw66IihDLbn2mWGMNSysZ6UPwSa9ET
 U36BKsUEzayILDrEZEAzPGSbim0PteaLbCVFiugI6PHc/ZvUq5t68v1gyyyQGxh7wzAH
 84FSFm0kpUoB5/V18mZiHSctSIm21py6NZe6DUxpr78yAn0vBdJcslrR2oO2Bu/8OgOf
 fpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744188; x=1783348988;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/BA1zbHhuuh8CjmEucVuFCUPw5lNOCIU8iLZzA+0W0=;
 b=YfaEYuUKgBD76dgJyrlgTAXbS7RmQ7iIoI8ZzdK1zVReKaPtfxKfqJ9dltmB9C8OZP
 PrljLabpO13aGas0VoLDgDSoJLYKph5ePnmjN82XNQ5KfdRH7MKbuKXGAYrPF/IhBsqI
 znsSfu7FpbcI5jqwgKBmX3UMZIXJWDR62fSQr48owaGOQbiiH8KE/4C+zeEg3Sb4dpq1
 I8zVFTM1yVfDgg+44nAZQvGewiR5HjefgXVXr2ty3wi5lRI2sBq9VVqdJgYNgORXgfpD
 PKzt+NhgEEaToxMSq4RMYqB6r0+ngoPiw3d0Rg65Y/a1nA0TnzMbU8tshNFYodC26yEU
 8DMg==
X-Gm-Message-State: AOJu0YzdQ61VbjMmblxmM6ZLH3G3CseZcUoZML0JD8yp93lrOOq//QlU
 FOkqjvLY1HiUABhwIixBWLP2hX6oCPIL5RsYQ68ngLyNPyoQi45yBdijwSMGY8QR7ohhdbSP695
 nKDGqI3zKNWyuVBk5CXQaiFimQc2DAVt3UZiD0Ah4NjHm1e7d2XqhS8iL
X-Gm-Gg: AfdE7cnENiiS+uYCAnYoYPLKaFZoKOcbTqT8dvKPiSfn9CE6rb6H7qwsPm7bS4wTBtd
 wpiYKolb++VN3QIwcOXKnA96LGhj3VhKSWyKgelAegugryw0FGBNP5mLSmRHplXle/kfkw75L59
 2HljsxceuXqoLtMS8um8Te/AqnQqGS8l2xryoidjszTWClKApG8Qyyk+3cWxPGIoVofzbZueXy1
 qReAa03X6SFWbvA56Crx8Ft1qB03HtAUcIEE+TGh1Ae+UiWts5goxCEp38EqlCUNe8N6CC0tIHz
 upw3UOFyHjA25yzMOiROTJrO7I7RI/pFxy4xpBeVyJN2GftPMwbJkTLw5NxXTMELMcqspRxZSY0
 IoFcVxbyEjbbsWEKY1Q/jiy2f54iuGfQvNQARJ4q2fs4UWfIryA==
X-Received: by 2002:a7b:c7c5:0:b0:492:63c3:8eeb with SMTP id
 5b1f17b1804b1-4926fca4ce5mr138791145e9.35.1782744188336; 
 Mon, 29 Jun 2026 07:43:08 -0700 (PDT)
X-Received: by 2002:a7b:c7c5:0:b0:492:63c3:8eeb with SMTP id
 5b1f17b1804b1-4926fca4ce5mr138790685e9.35.1782744187831; 
 Mon, 29 Jun 2026 07:43:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493a7fd1b0fsm123655815e9.1.2026.06.29.07.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 07:43:07 -0700 (PDT)
Message-ID: <99726741-229a-4230-b19e-63a7f27ba9f0@redhat.com>
Date: Mon, 29 Jun 2026 16:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
 <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/29/26 13:39, Aditya Gupta wrote:
> On 26/06/29 01:20PM, Cédric Le Goater wrote:
>> On 6/29/26 13:04, Aditya Gupta wrote:
>>> In the past there have been hard to recreate issues where XIVE changes
>>> cause qemu crashes due to multi-socket interrupts such as in [1].
>>>
>>> Add a functional test explicitly to test whether remote interrupts work.
>>>
>>> The test can also work as additional boot test for multi-socket boot,
>>> initrd boot test, as well as a check for e1000e to be working in powernv,
>>
>> you should consider moving to a more modern nic model: igb, which
>> has sr-iov support too.
> 
> yes, can do. with igb i see multiple irqs, so test will have to take sum
> of all rx irqs, and compare:
> 
> 	2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
> 	2026-06-29 17:00:46,391: 135:          0          0          0  PNV-PCI-MSI 2416443392 Edge      eth0
> 	2026-06-29 17:00:46,393: 136:          0          6          0  PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
> 	2026-06-29 17:00:46,394: 137:          0         14          0  PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
> 	2026-06-29 17:00:46,395: 138:          0          4          0  PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
> 	2026-06-29 17:00:46,397: 139:          0          4          0  PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
> 	2026-06-29 17:00:46,398: 140:          0         16          0  PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
> 	2026-06-29 17:00:46,399: 141:          0          6          0  PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
> 	2026-06-29 17:00:46,399: 142:          0          6          0  PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
> 	2026-06-29 17:00:46,400: 143:          0          4          0  PNV-PCI-MSI 2416443400 Edge      eth0-tx-3
> 
> I feel e1000e suffices for this test, should i stay with e1000e or use
> igb here ?

or use a single cpu per socket config. Which seems better for the test.

Thanks,

C.



