Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A376C54E55
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOxP-0003bF-5R; Tue, 05 Mar 2024 02:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhOwx-0003Or-LB
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:10:58 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhOwv-0001c7-34
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:10:55 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7db241b1e0cso1136158241.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709622650; x=1710227450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y36f7posl7ZMNySYHsTNdos9pSPjUErfBNricXfxXss=;
 b=B1bQ911OE0C0ddXUzOEFQkR5PQ66NLB6cLW3fkReZWYWBBkvKgTtEfGGwUfMMATi4W
 tinG4R7fCs63jgUNd/nimD1BWRMikisHqtGEx32zQ7XSg3yZDEw5Mo0uHlP2b7Ve26EB
 gKUbzstcdYg3uIf7TWdAE5E1ghj900s3MC7Aqp0v6IVOoFKODElelJMneY9WxuuIj1/C
 Z8u8qjYGHkJ417bfp/VdA+25mGLVFljjofvVm8LZJnknf89H+1HqZqMyw2ArBd0J4gGu
 IiPfczDAI0+xHIVrSJNEXrk6SsAAfdlLfDPwEg3tbv1+iipqtxDGr7VzOj1GmXoZkXRV
 yRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709622650; x=1710227450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y36f7posl7ZMNySYHsTNdos9pSPjUErfBNricXfxXss=;
 b=ca7WRKnmjT4jAUx8kOae7UoJxQpDXyhgYl5oIHvz7bkSNEj9oWklHsWitsLIqBwAKJ
 DrrnPMoJ8l2yNgGYO2jJnkeG5Finc+TdWpKoS7i8Zu8fkGxi0XYh0G1cxiSfYrT1UIm4
 rDz4qazlwXcrGoVVkbx2cy0CQ2cDEAlWeYXK9i0+0x/VQW5pr84raabNR3xqWhJ4RgPa
 xqPlr01Sv19aovfh+1bo7eLW7gLpTwwELGbhWmR40zXLcccRUiigyiYfBIAi/2ihk4iZ
 KOsYAX3tmsvuwrxMqzaQN9ZDe7OVOf7DT+QyFYeckiwhRGnfpQJ7t4LfuHIVMKPNcea1
 GYDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNMZz64sLC1ZJ+QOjVBsz0dM6ivxLA89MPrJQPZ69xWYFEOkug8OHt/o1zea97i5HNSqm9QFL4ByzukptfZJJBnLuTAYQ=
X-Gm-Message-State: AOJu0YxhDN7ls8HbC/jHl8q9TdDNsMtefi8Ufr75Sg15vhR2jMZaqx0a
 geZZKuCH0BPJ2UHNOj0ehtnORvEzZMKyyJ4pCYKmR1GgzKE9zNFIUwaArP3oKRnGCF8rp2A/97Y
 xfS/MtolO4wH7lg9OaqM8eTYHFHJGFtQkWdxD8w==
X-Google-Smtp-Source: AGHT+IE7ZWEURNC7vMd05rp6rJaZD8Db0t4zZRyqV8oa+Hv15rpZuLuTzski8EfVy0sAWkUwbXcMNnQVkDKF9+6ak1A=
X-Received: by 2002:a05:6102:160b:b0:471:c414:83b5 with SMTP id
 cu11-20020a056102160b00b00471c41483b5mr1203643vsb.18.1709622650347; Mon, 04
 Mar 2024 23:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
 <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 23:10:39 -0800
Message-ID: <CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=horenchuang@bytedance.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 4, 2024 at 10:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
> >>
> >> > The memory tiering component in the kernel is functionally useless f=
or
> >> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the=
 nodes
> >> > are lumped together in the DRAM tier.
> >> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A8=
60A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
> >>
> >> I think that it's unfair to call it "useless".  Yes, it doesn't work i=
f
> >> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> >> please be specific about in which cases it doesn't work instead of too
> >> general "useless".
> >>
> >
> > Thank you and I didn't mean anything specific. I simply reused phrases
> > we discussed
> > earlier in the previous patchset. I will change them to the following i=
n v2:
> > "At boot time, current memory tiering assigns all detected memory nodes
> > to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
> > such as CXL1.1 type3 memory, being unable to be assigned to the
> > correct memory tier,
> > leading to the inability to migrate pages between different types of me=
mory."
> >
> > Please see if this looks more specific.
>
> I don't think that the description above is accurate.  In fact, there
> are 2 ways to enumerate the memory device,
>
> 1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
>    table or something similar.
>
> 2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
>    similar
>
> For 1, the memory device (including CXL memory) is onlined via
> drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
> memory device is indistinguishable with normal DRAM with current
> implementation.  And this is what this patch is working on.
>
> Right?

Good point! How about this?:
"
When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation=
.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory ti=
er,
leading to the inability to migrate pages between different types of memory=
.
"

--
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

