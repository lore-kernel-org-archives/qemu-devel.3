Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DFFC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 16:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdXP4-0007ol-GP; Thu, 30 Jan 2025 11:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdXOy-0007jQ-LR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdXOw-00034O-QM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 11:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738254499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXhPYxXivfpAUmoL63eWbkQQipXOPxccSSUSI/QcRPA=;
 b=WzPFPRuyoLYby3kusW1MXqOOBu4ouRRgi0kYz3sU4vrbM/3ozP7b4M8i7VK8M7V6vfFowH
 L5+DP5zOyxGZHvJnp18woVbTH3wbCUfgD/qTdFLg11HiiooayvBNuKWXCe72WeF45Adxjs
 trDhkkOk4Wy/eeHhAcIYq/gQIu06Q98=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-blV_mPZ0Mw-USNQhngJW4Q-1; Thu, 30 Jan 2025 11:28:16 -0500
X-MC-Unique: blV_mPZ0Mw-USNQhngJW4Q-1
X-Mimecast-MFC-AGG-ID: blV_mPZ0Mw-USNQhngJW4Q
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e2378169a4so21864906d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 08:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738254495; x=1738859295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXhPYxXivfpAUmoL63eWbkQQipXOPxccSSUSI/QcRPA=;
 b=UaTWM6qSk+QJPWN/zS953+zx6luiFrbdzcA5TpaSIDI5p76kRrVv5+7teGbrRxyvoG
 CFCAxRS3nub4B7bQ0ebsD+Nn8RpcDDDs6Lnjc3DcEpZH1HPu6ZgaxLOXv2KXfHF7Gyyb
 FwwExAvEfgWiIojXxsUAwIE1ZmAbgufDm/kIUOaW/4L6k4ODoAVOmwIFLAqm72nG2R0V
 uT50LOpWXGvjT1AELbFc1ijnnasHUGQnccUvIZSxKrm13wOarA80Ch+1CEbzxzjsF2Nx
 owAdlJ5mZgvu4rmRPLjLa7u/me49GmNaueEYNxvVLY5kSY+nXl2fUv2ryeQeKNB1IK0Y
 MgVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9RUACSWwDxAVwS1DqO3309gHFpt2fbja+O0hN8CEv3dE2R1cW/vIxBxnalae5xkiBpq6rhysnB5n@nongnu.org
X-Gm-Message-State: AOJu0YyGEI8d0oKil2bdV44FdggVF6tfBVNMmcLQk5A0hd8c/LOWv7lj
 XbprmzTxTHg3wh7kfO+rraNhKZ+4CNV7KyWzjMXTDmI4+NL1JB0/YzWZbLTDoKfk3bBxWTYN8Lb
 EBro2AzhVAza/PZbgyC2SboA4wh+qvWkPmV5d2qJDdwxRaMozKloI
X-Gm-Gg: ASbGncvRkno3jxCDffQGfo0RAEd85V/QbrSp6AxHwdlFw5jtkTeuQ4Ou5wVIDGZX5nY
 ULepaDlJcIcQL+KzdrxEZcoBHeuftv4M/4331UN8GuQAv8md2yEI7VNGWcLApWDlRHxUAiVSgUy
 2u3lH9Aeg1dETSbl5QgUHT8Xdf78WPtmIpGzC+zL5bm8U5WVd3ihTTzA1LnfczT4sHVJI+zuXqm
 OZvgFW0ig8+V3AlCmovOfJ8qRzxIFBwy3H5JHY75WBx1jtqUMVCG2PdzpK7ifTmONM4HS9B6VQ9
 a+Y0Mh2s9DDK0arJ4aaA35ybXok/pGZukM+Ju4tWHXpu/u2+
X-Received: by 2002:a05:6214:428f:b0:6e2:4940:400b with SMTP id
 6a1803df08f44-6e249404305mr100836296d6.16.1738254495457; 
 Thu, 30 Jan 2025 08:28:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHezdPdrcB465gv5HhXBH/dzV/lCJAFc7ts3XsdTfdwi+8v24sDD4NLRKI5jZWu3JiarcHE6Q==
X-Received: by 2002:a05:6214:428f:b0:6e2:4940:400b with SMTP id
 6a1803df08f44-6e249404305mr100835876d6.16.1738254495132; 
 Thu, 30 Jan 2025 08:28:15 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f43f7sm7724526d6.9.2025.01.30.08.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 08:28:14 -0800 (PST)
Date: Thu, 30 Jan 2025 11:28:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z5uom-NTtekV9Crd@x1.local>
References: <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050> <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
 <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050> <Z5O4BSCjlhhu4rrw@x1n>
 <Z5WtRYSf7cjqITXH@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5WtRYSf7cjqITXH@yilunxu-OptiPlex-7050>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 26, 2025 at 11:34:29AM +0800, Xu Yilun wrote:
> > Definitely not suggesting to install an invalid pointer anywhere.  The
> > mapped pointer will still be valid for gmem for example, but the fault
> > isn't.  We need to differenciate two things (1) virtual address mapping,
> > then (2) permission and accesses on the folios / pages of the mapping.
> > Here I think it's okay if the host pointer is correctly mapped.
> > 
> > For your private MMIO use case, my question is if there's no host pointer
> > to be mapped anyway, then what's the benefit to make the MR to be ram=on?
> > Can we simply make it a normal IO memory region?  The only benefit of a
> 
> The guest access to normal IO memory region would be emulated by QEMU,
> while private assigned MMIO requires guest direct access via Secure EPT.
> 
> Seems the existing code doesn't support guest direct access if
> mr->ram == false:

Ah it's about this, ok.

I am not sure what's the best approach, but IMHO it's still better we stick
with host pointer always available when ram=on.  OTOH, VFIO private regions
may be able to provide a special mark somewhere, just like when romd_mode
was done previously as below (qemu 235e8982ad39), so that KVM should still
apply these MRs even if they're not RAM.

> 
> static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                              MemoryRegionSection *section, bool add)
> {
>     [...]
> 
>     if (!memory_region_is_ram(mr)) {
>         if (writable || !kvm_readonly_mem_allowed) {
>             return;
>         } else if (!mr->romd_mode) {
>             /* If the memory device is not in romd_mode, then we actually want
>              * to remove the kvm memory slot so all accesses will trap. */
>             add = false;
>         }
>     }
> 
>     [...]
> 
>     /* register the new slot */
>     do {
> 
>         [...]
> 
>         err = kvm_set_user_memory_region(kml, mem, true);
>     }
> }
> 
> > ram=on MR is, IMHO, being able to be accessed as RAM-like.  If there's no
> > host pointer at all, I don't yet understand how that helps private MMIO
> > from working.
> 
> I expect private MMIO not accessible from host, but accessible from
> guest so has kvm_userspace_memory_region2 set. That means the resolving
> of its PFN during EPT fault cannot depends on host pointer.
> 
> https://lore.kernel.org/all/20250107142719.179636-1-yilun.xu@linux.intel.com/

I'll leave this to KVM experts, but I actually didn't follow exactly on why
mmu notifier is an issue to make , as I thought that was per-mm anyway, and KVM
should logically be able to skip all VFIO private MMIO regions if affected.
This is a comment to this part of your commit message:

        Rely on userspace mapping also means private MMIO mapping should
        follow userspace mapping change via mmu_notifier. This conflicts
        with the current design that mmu_notifier never impacts private
        mapping. It also makes no sense to support mmu_notifier just for
        private MMIO, private MMIO mapping should be fixed when CoCo-VM
        accepts the private MMIO, any following mapping change without
        guest permission should be invalid.

So I don't yet see a hard-no of reusing userspace mapping even if they're
not faultable as of now - what if they can be faultable in the future?  I
am not sure..

OTOH, I also don't think we need KVM_SET_USER_MEMORY_REGION3 anyway.. The
_REGION2 API is already smart enough to leave some reserved fields:

/* for KVM_SET_USER_MEMORY_REGION2 */
struct kvm_userspace_memory_region2 {
	__u32 slot;
	__u32 flags;
	__u64 guest_phys_addr;
	__u64 memory_size;
	__u64 userspace_addr;
	__u64 guest_memfd_offset;
	__u32 guest_memfd;
	__u32 pad1;
	__u64 pad2[14];
};

I think we _could_ reuse some pad*?  Reusing guest_memfd field sounds error
prone to me.

Not sure it could be easier if it's not guest_memfd* but fd + fd_offset
since the start.  But I guess when introducing _REGION2 we didn't expect
MMIO private regions come so soon..

Thanks,

-- 
Peter Xu


