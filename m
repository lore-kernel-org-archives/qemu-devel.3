Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99FBEC1447
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPrS-0000E9-Gf; Tue, 03 Mar 2026 08:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vxPrP-0000BD-Mj
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:32:27 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vxPrE-0003yM-Rf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:32:27 -0500
Received: from example.com (unknown [167.220.208.51])
 by linux.microsoft.com (Postfix) with ESMTPSA id 959B020B6F02;
 Tue,  3 Mar 2026 05:31:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 959B020B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772544664;
 bh=vNMoT/eLtNUXa02L15wldysIojZ3k6yNfHIQxXhpz5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XtR8jB8Cbz3pWa1gNK3hA42G6r7oQdKQTNwJNA28OnSbL7hSJLfxb7JpWKFLt1lA+
 71vXA4VeVa5osEmCrMz+AFl73GEReE2F7KNC9r+xduh52srK4ZL2tHGEtNQ/PrZLCD
 y5Y5+W8bSer7gJtFHAL5rDcmU6RojusEV0HXZ1EQ=
Date: Tue, 3 Mar 2026 14:30:59 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 00/10] Support QEMU cpu models in MSHV accelerator
Message-ID: <aabik4j+PseewLz3@example.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <aa442c69-5dd5-4a3a-b42a-299a30aab881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa442c69-5dd5-4a3a-b42a-299a30aab881@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 07:34:21PM +0100, Paolo Bonzini wrote:
> Hi Magnus,
> 
> I went back to reviewing this series.
> 
> More or less, using "-cpu host" should work because MSHV already runs in a
> partition.  Therefore, it should be safe to assume that whatever bits were
> allowed in the current partition's CPUID will also be allowed in the nested
> guest.
> 
> However, you still need to mask the features corresponding to MSRs that you
> do not save/restore; this includes for example TSC deadline timer, AMX
> (XFD), FRED, PMU, UMWAIT are the first few that came to mind.  Or
> alternatively, just add them to get/put_msrs.
> 

Hey Paolo,

thanks for taking a look at this. I am currently staging follow up
patch-sets in which the MSR handling is reworked as part of the live
migration support. In those there will be more MSRs that are being
covered in a migration, using a hardcoded list in rust-vmm/mshv as
base, with some additional ones added:

https://docs.rs/crate/mshv-ioctls/0.6.7/source/src/ioctls/system.rs#363

in the future I think we want to have a MSHV_GET_SUPPORTED_MSRS ioctl
that we can query, similar to what's available for KVM.

There are "hv_partition_processor_features" that we query from the
hypervisor to filter out MSRs that are not available for a given
partition, e.g.

		uint64_t tsc_adjust_support:1;

> Later on, we probably want to share some of the code to handle MSRs between
> Hyper-V and KVM.  Please add some comments about the hypercalls, since they
> are poorly documented, explaining how to find out which MSRs are supported
> by the hypervisor.
> 

If the hypercalls are not documented, we probably want to fix it either
in the rust-vmm/mshv create (which at the moment provides authorative
headers (until we have moved everything to the mshv uapi headers), but
i'll double check.

> With respect to live migration, here are a few bits of states that should be
> migrated:
> 
> - the FPU registers (MshvFPU is dead code and can be removed; I missed it
> during my initial review).

yup, the FPU registers handling has also been reworked a bit to
accomodate XSAVE migration.

> 
> - the PDPTRs.  That is probably okay (because you never set nor read
> env->pdptrs_valid) but please check if Hyper-V supports reading them.
> 

I'll try to find that out. Haven't stumbled over this so far, but I
understand it's relevant for 32bit PAE guest, which we probably haven't
tested thoroughly yet.

> - KVM also has support for migrating in the middle of an exception being
> delivered (for example if an EPT violation happens due to a write to the
> stack); this is handled with fields such as these:
> 
>         VMSTATE_UINT8(env.exception_pending, X86CPU),
>         VMSTATE_UINT8(env.exception_injected, X86CPU),
>         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
>         VMSTATE_UINT64(env.exception_payload, X86CPU),
>         VMSTATE_INT32(env.exception_nr, X86CPU),
>         VMSTATE_INT32(env.interrupt_injected, X86CPU),
>         VMSTATE_UINT8(env.soft_interrupt, X86CPU),
>         VMSTATE_UINT8(env.nmi_injected, X86CPU),
>         VMSTATE_UINT8(env.nmi_pending, X86CPU),
> 
> please check how Hyper-V handles this situation so that it can be
> implemented in QEMU as well.
> 

Those are covered in MSHV's "vCPU Events", I think they map quite
cleanly to the QEMU representation:

https://docs.rs/mshv-bindings/0.6.7/src/mshv_bindings/x86_64/regs.rs.html#404

thanks,

magnus

