Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0CFC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5Ot-0001Wc-V5; Thu, 22 May 2025 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uI5Or-0001W8-Ih
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:51:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uI5On-0003F2-80
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:51:51 -0400
Received: from example.com (unknown [167.220.208.38])
 by linux.microsoft.com (Postfix) with ESMTPSA id 98A09211CF86;
 Thu, 22 May 2025 05:51:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98A09211CF86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747918305;
 bh=eINPUPvgDVlDrBT6Dkpv3woGPkLJ0JeZzjI1lgPBINo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bNnQWSvcmgog7THi91QdiwK35n3OiNKLXduILflpWtDN0g4h+idmosbmjCB0Qv6Jd
 rNayfCbsSArmcryPHM1dF/vY6dYkQDo1iHK+jiJOUK9a+3yc/yPoIU83JlTOGJ/upt
 Z3Jv8tI5SYJwStjsGVV5GG+f8LRB5RBlltl+vtGs=
Date: Thu, 22 May 2025 14:51:39 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 25/25] accel/mshv: Add memory remapping workaround
Message-ID: <aC8d2/B54ro/uT3Q@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-26-magnuskulke@linux.microsoft.com>
 <2b3b3e89-a471-4245-af63-d7ed8ab1c843@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3b3e89-a471-4245-af63-d7ed8ab1c843@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 03:53:10PM +0200, Paolo Bonzini wrote:
> On 5/20/25 13:30, Magnus Kulke wrote:
> > Qemu maps regions of userland multiple times into the guest. The MSHV
> > kernel driver detects those overlapping regions and rejects those
> > mappings.
> 
> Can you explain what you see?  QEMU doesn't do that, just look at KVM code:

Hey Paolo, I appreciate that you took a look so swiftly, we'll try to
accomodate and post a fixed series up soon.

I think what I am referring to is a "memory region alias", e.g. in this
mtree output (machine q35 + seabios):

00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
...
00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios

parts of the bios are mapped into different regions on the guest. a
code path for such a mapping that is refused by the MSHV kernel driver
would start in hw/i386/pc.c:894

memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
                         0, x86ms->below_4g_mem_size);
memory_region_add_subregion(system_memory, 0, ram_below_4g);

eventually that ends up in a hv call that registers a region, but the
userspace_addr of pc.bios is already registered, so the mapping of an alias
slice is rejected by the kernel driver.

best,

magnus

> 
> static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
>                                       gfn_t start, gfn_t end)
> {
>         struct kvm_memslot_iter iter;
> 
>         kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
>                 if (iter.slot->id != id)
>                         return true;
>         }
> 
>         return false;
> }
> 
> ...
> 
>         if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
>             kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
>                 return -EEXIST;
> 
> 
> Paolo
> 

