Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFDDC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOQ6-0005zH-Du; Tue, 05 Mar 2024 01:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rhOPt-0005yg-CS
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:36:46 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rhOPp-0003n5-BB
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709620602; x=1741156602;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=fsK+f7bh6SaYyPN7/YyJPG+tUPYKxJnt+4ogSrVq56o=;
 b=QSd7V8NxtxH1LrnAbtiynFuT3BTjs6gLdfwI5+0wxGlH81lnJxhMEKXP
 O4eKMELATuBY3G5Oxh07GrkjxjFG4mVpY21C4DfkCAA7F5yOVer4apKUj
 dF8wYnt/O9N8oNd7FrwHqsuqVOFBXrIgh5/hiPtu9UMT2EdZZrlYNtyRb
 hyMGp7tyglKYR8hklrHf8kWqPkVUdjt9ULcV0JhLtjNF2ES1SbDTY+NVW
 YfDReETXIb7qd4tLeNscd2Y70Z9m1izEsAIZDF/8VTlw6Yd+xpd7yIoeW
 8h+WehXlN68o4OVxWho8wlJ9kzym8N1pItIuFE1mUp23nVtt3Hn9eMJmi g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4076919"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4076919"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 22:36:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="46795681"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 22:36:31 -0800
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
In-Reply-To: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
 (Ho-Ren Chuang's message of "Mon, 4 Mar 2024 22:22:59 -0800")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
Date: Tue, 05 Mar 2024 14:34:36 +0800
Message-ID: <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.175.65.21; envelope-from=ying.huang@intel.com;
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

> On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > The memory tiering component in the kernel is functionally useless for
>> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the n=
odes
>> > are lumped together in the DRAM tier.
>> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860=
A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>>
>> I think that it's unfair to call it "useless".  Yes, it doesn't work if
>> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
>> please be specific about in which cases it doesn't work instead of too
>> general "useless".
>>
>
> Thank you and I didn't mean anything specific. I simply reused phrases
> we discussed
> earlier in the previous patchset. I will change them to the following in =
v2:
> "At boot time, current memory tiering assigns all detected memory nodes
> to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
> such as CXL1.1 type3 memory, being unable to be assigned to the
> correct memory tier,
> leading to the inability to migrate pages between different types of memo=
ry."
>
> Please see if this looks more specific.

I don't think that the description above is accurate.  In fact, there
are 2 ways to enumerate the memory device,

1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
   table or something similar.

2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
   similar

For 1, the memory device (including CXL memory) is onlined via
drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
memory device is indistinguishable with normal DRAM with current
implementation.  And this is what this patch is working on.

Right?

--
Best Regards,
Huang, Ying

>> > This patchset automatically resolves the issues. It delays the initial=
ization
>> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informat=
ion
>> > at boot time, eliminating the need for user intervention.
>> > If no HMAT specified, it falls back to using `default_dram_type`.
>> >
>> > Example usecase:
>> > We have CXL memory on the host, and we create VMs with a new system me=
mory
>> > device backed by host CXL memory. We inject CXL memory performance att=
ributes
>> > through QEMU, and the guest now sees memory nodes with performance att=
ributes
>> > in HMAT. With this change, we enable the guest kernel to construct
>> > the correct memory tiering for the memory nodes.
>> >
>> > Ho-Ren (Jack) Chuang (1):
>> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>> >     HMAT info
>> >
>> >  drivers/acpi/numa/hmat.c     |  3 ++
>> >  include/linux/memory-tiers.h |  6 +++
>> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>> >  3 files changed, 77 insertions(+), 8 deletions(-)
>>
>> --
>> Best Regards,
>> Huang, Ying

