Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435DFC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPH2-0007fA-04; Mon, 10 Feb 2025 03:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPGy-0007dx-Gd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:36:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPGw-0002z9-2n
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0Yf4vUrtTQeJBsgoxiejCdM1aG3EmufqlPIvbidQ14=;
 b=hkX3RvD2gHHediXfsJAhDj92YhrUO8ekeU2dU2Q36nOhLd2zgwf7NEWYvlDNvo1Kx1JIfP
 jkcT0A/M1nIBz5Z8OB3HCNWrl5yfjOGFmFuQbWynQQA6TYCnRdWcp0zl0xc9a1w7yYDHzo
 E/o3lxIjOa4lWltXuyiqzTN6B+X+b3w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-hHwzuftTOx6QhExNAwknEA-1; Mon, 10 Feb 2025 03:35:57 -0500
X-MC-Unique: hHwzuftTOx6QhExNAwknEA-1
X-Mimecast-MFC-AGG-ID: hHwzuftTOx6QhExNAwknEA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso30621555e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739176556; x=1739781356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0Yf4vUrtTQeJBsgoxiejCdM1aG3EmufqlPIvbidQ14=;
 b=p1zIcyGzzKNRQikdLkCJBaqzU08th36XtPXhQWt/9jIJKdJ5t9xLGdEZi8L79PuTsl
 EBK15M6KNgq0RD9tNieq/q1uY+0pBbRZdqtlNj2bmNlFwRIEZLqmzgS2Npsy5fuPjMtm
 zoFqANWmthXJLX1vf/5QNA+CY9+WbOy5RL1wmCULfnd4dm6CNJUf8kYFDWe93kS4OSfN
 yQKdFo3Qgx9IuR4jbHE68DOFZIOCuddkd0MGopLv9MnE+1m58XybKkr3c+x9TrQ1V+zT
 3DH/q4MjmG5tzrQCvFuhYqKC/v9O4uE7uLx/ICITERuOcWIyjw/57lN5scjr0OU+NGNv
 JErQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJMZfnXXzyC7z6ESAZyQzSsiXdjLRcEKwG1ULC3UjKDP7BU/+2UO8jFPAGW9Hd8LAA04mEKaYnMN0B@nongnu.org
X-Gm-Message-State: AOJu0YygR6HfeAqayOG5JkaQvhdKszyK8IDlREQfjQf2dQSc+xLiRjOG
 zQK9FvTs6lG6MYOFx8yJDRClNyml2f8bzQJWxrmaA3HCJzzTi+yGm6V9Bgah88wv0/V6dVGVvnF
 w60h+81B+46kkFMgIrDGl98NqZAqgYg7ZkW0sUOnEkMCkypJ8IxuH
X-Gm-Gg: ASbGncvrFA3NbtOXPJaAW182CGeF7r4xlkwn371SyuKMVp85Ik8belXtXnXqIzhsYXN
 9hwkY3gd3jYcZ1KzdD9gVN/Xf5zKT/+lw0JI0oajCv1aQDxHbzmJ3Q15N9wrX2oVEurtMrMQp6W
 iDzRpuM9b+zspkP0Eb2f6uj49hFia+WHg0xmJj3Jc4+bNbRRea3J0+UiS02p+wjg0O9/mFBgFry
 y9C7VIYC8U3J2Em30O0juKmyIjJVIg0tqbp//jE5t4g/EnYDftr+6YIVl9icnjLljZM/phQPrTk
 7mmYS+1ayWaM5vYIuAl9ip7Kq6EGF6dn7kwQ/kWgcSLvkodYp8nX
X-Received: by 2002:a05:600c:3b9c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-43924991f68mr103303245e9.12.1739176556251; 
 Mon, 10 Feb 2025 00:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7gVQ3SN4WtrFkaji3Ppn1vfqr6bhrCNrgLhh8A+yrr453K5qg7FgEM21Sq8vxdQ8Dqf2kXA==
X-Received: by 2002:a05:600c:3b9c:b0:436:ed33:1535 with SMTP id
 5b1f17b1804b1-43924991f68mr103302845e9.12.1739176555839; 
 Mon, 10 Feb 2025 00:35:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439429c0790sm30383195e9.2.2025.02.10.00.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:35:54 -0800 (PST)
Message-ID: <3db2e0a7-0f38-4c6a-a9a4-d44e0c6af436@redhat.com>
Date: Mon, 10 Feb 2025 09:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
 <Z6ZHTStx_S9ALdxt@x1.local>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z6ZHTStx_S9ALdxt@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,


On 2/7/25 6:47 PM, Peter Xu wrote:
> On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
>> (I wonder if we ought to suggest quiescing outstanding
>> DMA in the enter phase? But it's probably easier to fix
>> the iommus like this series does than try to get every
>> dma-capable pci device to do something different.)
> I wonder if we should provide some generic helper to register vIOMMU reset
> callbacks, so that we'll be sure any vIOMMU model impl that will register
> at exit() phase only, and do nothing during the initial two phases.  Then
> we can put some rich comment on that helper on why.
As discussed with Cédric, I think it shall think about having eventually
a base class for vIOMMU. Maybe this is something we can handle
afterwards though.
>
> Looks like it means the qemu reset model in the future can be a combination
> of device tree (which resets depth-first) and the three phases model.  We
> will start to use different approach to solve different problems.
>
> Maybe after we settle our mind, we should update the reset document,
> e.g. for device emulation developers, we need to be clear on where to
> quiesce the DMAs, and it must not happen at exit().  Both all devices and
> all iommu impls need to follow the rules to make it work like the plan.
The 3 phase documentation already states that you shouldn't do anything
in enter phase that can have side-effect on other devices. However I
agree we can add another example besides the qemu_irq line one.

Eric
>
> Thanks,
>


