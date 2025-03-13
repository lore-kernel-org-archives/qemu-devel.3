Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB39C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 13:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsieu-00023B-R0; Thu, 13 Mar 2025 09:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsied-00021s-GO
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:31:19 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsiea-000106-F5
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:31:18 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 30A1E45953;
 Thu, 13 Mar 2025 14:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741872673;
 bh=bBUjnTRyyqPc8CVFTfn+Vi/TQK9CA6qYCHj5K+/GOA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pfrm+mcNZo4ueS3tAn70uAnnHty7WDiRZd8Sp24h52kGtu/nBFI34CgiwzCNlEv9l
 e7M4GyzsX8rj41Mq1RkpaYfwzk82mTrpmHHk4/ZI5fyCCeIc1BLvFwjAUgxy+bV6wc
 gJlcI54fcB7MRvaKQYnL65eOcoaXjfxNokHPQCvLbUJcxYG3bz66i4SJBLStx9yFzE
 72TAdBAmp1ub9GfJr3cxyUZUXjE66Hz8KNVEWgA0ZpRY2RylUv44vMXo5Ys4iGsO+T
 BCuFxyYFbj5sMrsqY6EQHtnnJl66KjJIThzHKIcz218TwoJLBqmjb48B3IB6E3CPa1
 I1kVY6ibKSN5A==
Date: Thu, 13 Mar 2025 14:31:12 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9LeILiEU5GfEHrl@8bytes.org>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Gerd,

On Thu, Mar 13, 2025 at 01:05:13PM +0100, Gerd Hoffman wrote:
> // regions_addr points to an array of this structure
> struct vmfwupdate_regions {
>     uint64_t size;
>     uint64_t src_addr;       // source address (before update)
>     uint64_t dst_addr;       // destination address (after update)
>     uint64_t flags;          // control bits
> };
> 
> // flags
> #define VMFWUPDATE_REGION_FLAG_COPY     // data must be copied
> #define VMFWUPDATE_REGION_FLAG_ZERO     // dest must be cleared
> #define VMFWUPDATE_REGION_FLAG_MEASURE  // data must be measured
> 
> (1)   is still not covered.
> (2+3) can be handled with FLAG_ZERO regions, with and without
>       FLAG_MEASURE.
> (4)   Alex already pointed that the cpuid page is special, guess we
>       need additional flags for those oages.

That looks better, when the host VMM guarantees the order in which it
translates these regions into VM setup calls, then it is a step
forward. Although there more things to keep in mind, like the guest
policy and SEV status parameters.

> Open question is what we do about IGVM.
> 
> One option would be the guest vmfwupdate tool loading and parsing igvm,
> preparing the region list, then invoke the update.  Problem is that some
> igvm feaures such as initial register state can not be easily supported
> that way.
> 
> We could also expect the hypervisor support igvm, so the guest can
> simply load the file into memory and pass address and size to the
> hypervisor.  Either as option, say via VMFWUPDATE_REGION_FLAG_IGVM, or
> mandatory, i.e. scratch the region list and use IGVM exclusively.

This is of course up to the QEMU maintainers to decide, but I want to
highlight that IGVM already solves all the problems mentioned above,
including setting multiple memory regions of different type, special
data pages (cpuid, secrets, id-blob, vmsa) and more. It defines the
order of setup calls the VMM has to invoke for the new context and also
works for multiple platforms like TDX, SNP, non-coco, and in the future
ARM as well.

Regards,

	Joerg

