Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E5C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPOZ-0003wV-L7; Tue, 05 Mar 2024 02:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rhPOO-0003hp-CA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:39:18 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rhPOK-0006I6-TI
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709624353; x=1741160353;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=A28suRbme1QZpr/dRcM4LmjGdNPiTUN8DUTSDscbeIQ=;
 b=ThUFjH6k0O2cgg3CQYOCffV/kggmNRGSy7pvS6PQJTzpk33BvHGdCvJx
 brkyRr6I25hKWMaWCAA66JPMPTFEQ9Ph9Gy8gzgs08tavY3KZrbg1zNdP
 9Dt9j0u1DvS8m6scMkmb6avR6tBBNNQS/L/IEIPKLD/xEVbXSvV0hajuE
 tHAcaiEn14Kh1SeDVWPf3dngsLYa4GYMHxqfppyxULtgRkNHhBi5dbkkq
 /0V1yCZ7sIlZ9HxBC5bP+lqs5F+T9+utmYtyhUOCETGnNH+G9jH98MsPI
 xyjkBMhwd/EMIrZ9tN5R0Z6npykr2ZWkND/Vs7Gg4o7HW/fOXkoKSQMTv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4742120"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4742120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 23:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9185248"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 23:39:05 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
 mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
 Alistair Popple <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
In-Reply-To: <CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
 (Ho-Ren Chuang's message of "Mon, 4 Mar 2024 23:10:39 -0800")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
 <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
Date: Tue, 05 Mar 2024 15:37:10 +0800
Message-ID: <87zfvd86zd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=192.198.163.16; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> On Mon, Mar 4, 2024 at 10:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>> >>
>> >> > The memory tiering component in the kernel is functionally useless =
for
>> >> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because th=
e nodes
>> >> > are lumped together in the DRAM tier.
>> >> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A=
860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>> >>
>> >> I think that it's unfair to call it "useless".  Yes, it doesn't work =
if
>> >> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
>> >> please be specific about in which cases it doesn't work instead of too
>> >> general "useless".
>> >>
>> >
>> > Thank you and I didn't mean anything specific. I simply reused phrases
>> > we discussed
>> > earlier in the previous patchset. I will change them to the following =
in v2:
>> > "At boot time, current memory tiering assigns all detected memory nodes
>> > to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
>> > such as CXL1.1 type3 memory, being unable to be assigned to the
>> > correct memory tier,
>> > leading to the inability to migrate pages between different types of m=
emory."
>> >
>> > Please see if this looks more specific.
>>
>> I don't think that the description above is accurate.  In fact, there
>> are 2 ways to enumerate the memory device,
>>
>> 1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
>>    table or something similar.
>>
>> 2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
>>    similar
>>
>> For 1, the memory device (including CXL memory) is onlined via
>> drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
>> memory device is indistinguishable with normal DRAM with current
>> implementation.  And this is what this patch is working on.
>>
>> Right?
>
> Good point! How about this?:
> "
> When a memory device, such as CXL1.1 type3 memory, is emulated as
> normal memory (E820_TYPE_RAM), the memory device is indistinguishable
> from normal DRAM in terms of memory tiering with the current implementati=
on.
> The current memory tiering assigns all detected normal memory nodes
> to the same DRAM tier. This results in normal memory devices with
> different attributions being unable to be assigned to the correct memory =
tier,
> leading to the inability to migrate pages between different types of memo=
ry.
> "

Looks good me!  Thanks!

--
Best Regards,
Huang, Ying

