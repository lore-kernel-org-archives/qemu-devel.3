Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009C5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 05:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6iHS-0005ob-2Z; Wed, 16 Sep 2026 01:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x6iHN-0005oN-Ub
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 01:33:58 -0400
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x6iHL-0005yh-R2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 01:33:57 -0400
Received: by mail-pj2-x08.google.com with SMTP id
 d9443c01a7336-2d8fcda61c8so24216085ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789536834; x=1790141634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sNqg7J+HTVazLnMpF5ccDwRj62f/ba6Yt5iVRXyVEMs=;
 b=RKy34YuttyqOfWuD3LQ7anfbqEAak7ZPV5Ov8NxRKdCWj9upUraQ6PqklwZLM0PXoa
 q1Tya+XFK0b126HNxHT9125dTjykQtwp3UmB/QF7AuSfTSRmT0AEcBwAB38nzAf17bSe
 P5ZcAJE5ZoyDWv9+7GOWD2YzHtFaUjnOvBD8c/cEwe9l5Uhamkdbshpk4Aca9o1zZoXb
 59tb9n8e+bO1x7y853usBRHTEZ5qAPWU6gFJGdKVLzAXS6xGdyxZbMviRvy1vWtRnO+A
 34JAwA0t0sjwxa/MZhpUfOnib8//9idlCIIQPZ0YBzR1LuDTUn+hjLMNNAYG/Tb8Tjr4
 WN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789536834; x=1790141634;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sNqg7J+HTVazLnMpF5ccDwRj62f/ba6Yt5iVRXyVEMs=;
 b=XANbBodja8h/0PnvCBWAW+cpLL+r0zvzfZsBE8qYE72idon46qCoK/+Po4FFos6NJd
 cKyeWs6vtGxRSg/aYeD1lVPGCJ9YdmHSOvMpQ55ho7sn1yBQodVY8JYJLbPKS3YdYsEr
 deYOdK46OXCfMa1v4WIYk4BtRDm8SCAAET0CHsR8L3vEqV02O/A9Fh8I3tNa+ntdS/36
 ErNKZl3n4tZZ/OYJXvRkYPOvlcyasGx/tV4xbNOt91AcptsNhgg01mDIx81jYzZhRlHs
 EmN64XqlmKuPORFFKEnQqBap0uFFgIBZB90dD+8bw5fRIH2YnOP0z0e5++1J6wc60QLP
 sxNg==
X-Gm-Message-State: AFuF++kP/rUWsLOxMA0PHz7y1tlf9WEVjWvh8u+VV01hfsHf+UMMr27a
 MU69Atr2xUasDa4ucaUKKpFYAZU508RaMOQcLRG4SAHbzq/0LnfKOwE=
X-Gm-Gg: AYBFou1JwK4Ntkr0oXQ5GgXUi4kVf7CEZGwtKFvd6ZGn0aHkIhaV84ueZcO9rvCNb7i
 atOjgG4vhnyzK6cpwhEeird8ZDld5L1VPwQ/zfcTjqP8kip8EVoVsWiP8GjsSzjIcJuDUSb+L7X
 QUd83VHoRqN4N3evTjog1zWcUFaL9X/cpeaHL8/k9JCWgqWE6z+2R2+nsxWLygVg08Qob5eiXj7
 4VuphjWD7i+gPOBa30by82brgQmE2L18XfhLsz1vFdSh+7GijOyJk1xh/LWiR5E+dz3n2fD7E2H
 yaaPQ9CQarCNw0+M4pH67i2QjPGqZho51Gzz9wcNq4wnWfKI4/t6007oCREoKDJfQKaCo+MH8kX
 sitdl/flXNdlTBNnqUUyL/R2d/3S+MhAX+YPrTjxDu33X2sPsN3pJ8S5msx9pbd11cxvSSvBdh/
 t2jbrCP0C4rxNejIFLlo1Y/LBvQ9k1GyBxzkw6YpC7+04qpkMu9knb5NB9bYspP7CSMMxt+oJKe
 2HvqIV29lORO9n9bv/MKj5SMEk5qnvXK6Bfcf012mTBCbSJqdWQ8us=
X-Received: by 2002:a05:6a20:4306:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3dd5f092a60mr3314323637.0.1789536833732; 
 Tue, 15 Sep 2026 22:33:53 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:b0aa:8f70:be80:3f60?
 ([2408:820c:8ffa:c0f0:b0aa:8f70:be80:3f60])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm4478887eec.16.2026.09.15.22.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 22:33:53 -0700 (PDT)
Message-ID: <948e2399-1c85-4b51-9964-892750f7ce68@gmail.com>
Date: Wed, 16 Sep 2026 13:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: Junjie Cao <junjie.cao@intel.com>, Yuan Wang <yuan1.wang@intel.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Cedric Le Goater <clg@redhat.com>, bosheng.xue@intel.com
References: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
 <20260915013037.648161-1-junjie.cao@intel.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260915013037.648161-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::8;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x08.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026-09-15 09:30, Junjie Cao wrote:
> On Mon, 14 Sep 2026 16:41:58 +0800, Tomita Moeko wrote:
>> Just curious, on host side, does the value of 0x1080C0 equals (BAR2 + 8M)
>> on Meteor and Arrow Lake?
> 
> No.  Measured on Meteor Lake-P (8086:7d55, host i915):
> 
>   BAR2 (LMEMBAR)            0x4000000000, 256MB
>   MMIO 0x108100 GSMBASE     0x70000000
>   MMIO 0x1080C0 DSMBASE     0x70800000      (GSMBASE + 8MB)
>   MMIO 0x108040 GGC         0x4c0           (GGMS=3, GMS=4 -> 128MB)
>   config 0x50 GGC           0x4c0
>   config 0x5C               0
>   config 0xC0-0xC3          MSI Pending Bits (MSI cap at 0xac, 64-bit + PVM)
>   config 0xC4-0xC7          0
>   MMIO 0x138914             1
>   /proc/iomem               64000000-787fffff : Reserved
> 
> DSMBASE is a system physical address inside the BIOS reserved range, and
> DSMBASE + 128MB is exactly the end of that range.  BAR2 + 8M is the
> aperture onto the same memory: i915_gem_stolen.c and xe_ttm_stolen_mgr.c
> use either DSMBASE or LMEMBAR + 8M as the io base of the same stolen
> region.
> 
> So with igd_gen() == -1, where no BAR0 quirk is installed, a guest reads
> the host physical DSMBASE from 0x1080C0.  Given Yuan's point that the
> GOP reads this register for its stolen base, that is a host address
> handed to guest firmware, and something QEMU should fix.
> 
>> My concern is that if guest driver still uses (BAR2 + 8M) as DSM base, while
>> 0x1080C0 pointing to the mocked region, will this bring any inconsistency?
> 
> The drivers map stolen on MTL+ with DM-flagged PTEs as offsets from
> GSMBASE (xe_ttm_stolen_mgr.c; i915 sets PTE_LM for stolen-local), which
> a region in guest RAM cannot satisfy.  Whether the GOP maps its frame
> buffer the same way I cannot check from here.  Yuan, if the display has
> come up for you with v2 and the stock GOP, that answers it; the variant
> below does not depend on the answer.
> 
So on MTL+ BAR2 is mapped to the physical memory at GSMBASE, with first 8M
for GTT. PTE addresses are relative addresses so that accessing indirectly
from BAR or directly works. That makes sense. 

Meteor and later IGDs are supposed to access DSM from BAR2 instead of directly
from DSMBASE, but there is some hardware issues in Meteor Lake and Arrow Lake's
BAR2, software workarounds it to by falling back to DSMBASE. i915 won't read
DSMBASE register if the WA is not enabled (and it's always disabled when
virtualization enabled), while it's possible for GOP driver (and maybe windows
driver) to read it. Is my understanding correct?


>> Having the register pointing to guest's (BAR2 + 8M) sounds more reasonable,
>> but it would require more efforts, monitoring config space writes to BAR2 and
>> changing the emulated value in QEMU.
> 
> Agree with the direction, and it is cheaper than that: a read-only BAR0
> quirk can take pci_get_bar_addr(pdev, 2) at read time, returning BAR2 at
> 0x108100 and BAR2 + 8M at 0x1080C0.  Then the CPU-side address resolves
> to real stolen memory through the aperture instead of guest RAM,
> bdsm-size stays 0 as documented, and nothing in config space is
> invented.

Yes hooking on 0x1080C0 register read is easier and more straightforward.

>> Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914) to
>> disallowed in QEMU, if the GOP driver code checks it, to enforce the access
>> via BAR2 in guest.
> 
> 0x138914 reads 1 on the host and is not quirked, so a guest sees 1 too.
> Returning 0 there is a small addition and covers a GOP that checks it;
> the DSMBASE quirk covers one that does not.  On the Wa itself: i915
> already takes the BAR path in guests (i915_run_as_guest() short-circuits
> i915_direct_stolen_access()), so that path has upstream precedent; we
> have not measured whether the hang reproduces there.
> 

Quirking 0x138914 prevents driver applying that WA, but we are not sure
if driver checks it before WA. While hooking read to 0x1080C0 fakes the
DSMBASE to (BAR2 + 8M) in guest address space. Both tries to enforce
guest accesses to DSM via BAR2. I personally prefers hooking 0x1080C0
as it's driver-independent.

Btw, this quirk seems only necessary for Meteor and Arrow lake. That WA
is not applied in Xe driver. I'm not sure if it still presents in GOP or
windows driver for later generations.

> The firmware still has to program ASLS.  The IgdAssignmentDxe build the
> v2 commit message describes aborts on bdsm-size=0 before doing so;
> VfioIgdPkg has no such check and programs ASLS for MTL+ as is.
> 
> I'll write the quirk.  It can go into Yuan's v3 or on top of it as a
> separate patch -- Yuan, your call.  Either way it needs a run with the
> stock GOP build on your setup.
> 
> Junjie

Yes OpRegion is needed for display to work. In the "hooking 0x1080C0 read"
approach above, allocating DSM in guest is not needed. It sounds better to
make your IgdAssignmentDxe not aborting if bdsm-size=0.

Best Regards,
Moeko



