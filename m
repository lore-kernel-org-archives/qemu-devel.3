Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE4CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHcb-0004LG-QG; Thu, 04 Jun 2026 19:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wVHca-0004L1-Ol
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:37:08 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wVHcY-0004u5-FD
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:37:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWJfSlWFPxD2uNDtneDWbjc/vFj+lzdhHui0XTRz4gdejXj5kz/lgkqe6GYj3r4fgKIM+nPwyfVmDy5ZP+JHDqpf6GEsvslvwOHwkRNHYXvSTviDX1pQ3H4v5TJKqRU9v+n8lsZAb661Ot7tUqYFn2XPndzC/7mxl/llCGLJ+BqMkskA+1+OXnKIV/9VaI8uPRGZJCoeKlSyANOnNHuJyxkVE9pJJzbSdRMw+557VTDB9bZHHtNh6T5wSkJUfm1elpqZc637dIy2Mi8Wcwr01lDabHLJiDFv3d/w69nuuhsDRv2nGN4Gvx36x145cLAaH607FrYoeEB7Ohbz/3C7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haDnhOtNsg00SxRX6xmtqKWvwOkJM14sKSwtQz8GGM0=;
 b=zWBQp5EyqaTmNZ5O7nM4w8XKLOiNL1AEE1QtTUbTPIvutkjDs3naiFhpcgpcJs9oprdFnZ0d8ZLGESTyQfSzLL7Fq/aGYeVThfiwkZvW8Yb4Uab+4M/l7k8wfaH4FnfUcxj1vkcPLj3zrVUQH6o5n4UPRYDOUnJoLsWLZBsrsmgxsbWbbP91WmbxT4a4pAySdytGddKiD6LsOvocXOf8qrQ9nFxQclSXuLaDnRc9P81ggEDHFPC+I63BCtoj2XzthFnFpjxTmsIJt03H/DCR7wQZ8CiqMBEUNtP1aANui5de63BQRvR4PSDYopPGEByyeuJajEUkyrNIT6njzuveRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haDnhOtNsg00SxRX6xmtqKWvwOkJM14sKSwtQz8GGM0=;
 b=33lwsfCULD6pZlVIUopriIAJ74cChAmRI5qNDaTlWXx/D0q19T7w+2L5r77mQSjSQ8LbcgZJWwqZ+CKFwaotXjUKJA+uMLSZyl9mR4imksqA7pBD30Fiy9uOC6BgP7QNccDDAEhximm8P5Z/XBrn1ZhPio3IIqzbXXLgcTWhfNU=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 23:36:57 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::13) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 23:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 23:36:56 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 18:36:56 -0500
Date: Thu, 4 Jun 2026 18:36:41 -0500
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
 <berrange@redhat.com>, <armbru@redhat.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: Re: [PATCH RFC 09/12] accel/kvm: Support shared/private conversions
 via guest_memfd ioctls
Message-ID: <du65mzfertgaxvvzqbozgbnn7fasfinc67atbfhy5hjzaqpasx@2bmm2ol6tm52>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-10-michael.roth@amd.com>
 <22bda2bc-97ba-4b08-ac75-a8807293441f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22bda2bc-97ba-4b08-ac75-a8807293441f@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 82718f29-4c1f-42c3-0ea9-08dec2922a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: eOHAQ6MZFuLSjT9A1rzQB+7qHlN+dxadssUl5UABlIR6qse2EzsyZJcSVDt4mA3tCjBFkXWLNCm2zorkRwFKwMInNU/V1TQD+IprGvDs0UJ9AetgWXM63gZgdkEwUVTOAg5MwZpJ0xUBJXCKaqlSf7Ww6hGSmP7P9Xc4RGFh9H1mpprqKE7P+xurCYKyJFIoRa53aiZjMbBOhgKso9PdFaH3i0OmOOKhUE+9tJvKh5f96mgQ7NQwmEWhKv7YDIkMHyndwiXNoxJLY9cqgLinOumMgqdEcfCLJHW50ONGq342lFoJH4TaZsylciINVqP2VZ4FNdLXQvGYMYTYW3C879BGNiYR4sMUaZVqb699wYkgSIpIHLqNibM1FWq1Pc9DzRyEiBlAerjZ07RiVskCVfAd5YC8XrjEyOH/N7fVQT2X7cc8/SDpP6QSjgXftxMb2KHnUx7MzHBIzp5qCXtrwJINZ55RBnDTHj0QUJM+9R4g1GAkR1582tDUpV0hxY+P1AQxrsnRpYa63O/hpXDKfLog/Q4kU+HXbn8ZV4VxmaESuTvF/WKYpeWM5DC1ug7cDMZ+GSjpkQye17al5NTvd+Z0XIb5ev/gKy1kulzyyAARHluLC0g52CHUOvcxic5CiIcqc5SJkdthuKmPGIFHdDvTXOHb/6vkhzBsIf6U+uiGYIIiHmHZjLAVVtwovcOpdlXjHJhMrw1QJEYGiQVwjHMPZUSe/R19NRhcskHdCDA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CgKVT4vVC+b3KC/KXYIJFFXEIUJvgujsbJz4RIT1cAQypjNQ6u2wCQPnnxVegayMTiXEQuBZQdMKEJJmn4seu8v3zXhsV/raVS+tRCtEIEBUQNh0PHi0upbySKsujOSplFteemvBQ5YlznvNRYurJ9dZZBHiqkSDVvEsvByS3gohG7iKIAwwqjuvBi7GY5bRHwnYdh7Ifv9ZgW4tAesoz6WMSTbdwntAtaje2d594E/TYFIDaHcxLQnA/gc5JrH7JzgS8kNQWfbxR/rLjljjCs5AwzkUGFOQ7llVSgZDRnEONGkXXGw4bckAefVCkl4CjuzrinADTxteqcl7kut3fSvwYHhs+zrclrsNBc0UD+qXi8s1xxtKX1vWLtY6getvwMxJn94rLHODxpOo/PjF05NmMzNvNTvv7waf+MbK0yfk0326UkCdUOiFxhqBijyo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:36:56.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82718f29-4c1f-42c3-0ea9-08dec2922a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Michael.Roth@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 03:19:17PM +0200, Gupta, Pankaj wrote:
> 
> > When using guest_memfd with support for shared memory / in-place
> > conversion, it is necessary to use the guest_memfd ioctls to handle
> > conversions instead of KVM ioctls. Implement support for this by looping
> > through all the sections within a converison range. Implement everything
> > in terms of the kvm_convert_memory() loop, which already deals with some
> > special considerations regarding various holes / region types that might
> > be encountered.
> > 
> > Also update kvm_set_memory_attributes_*() to use the same common path
> > when convert-in-place=false. This potentially results in a small change
> > in behavior due to the additional MMIO checks/skips now being applied in
> > that case (generally qemu-triggered during setup) rather than only for
> > kvm_convert_memory() (generally guest-triggered), but this is arguably
> > safer, and it provides similar behavior between convert-in-place=false
> > vs. convert-in-place=true, the latter of which *must* skip MMIO holes
> > because the regions (and associated guest_memfds) themselves track
> > shared/private state internally and passing the whole conversion range
> > through to KVM is not an option in that case.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >   accel/kvm/kvm-all.c | 131 ++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 114 insertions(+), 17 deletions(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 62f2e8aa15..fd01435a0f 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1626,14 +1626,78 @@ static int kvm_set_memory_attributes(hwaddr start, uint64_t size, uint64_t attr)
> >       return r;
> >   }
> > -int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
> > +static int kvm_gmem_ioctl(int guest_memfd, unsigned long type, ...)
> >   {
> > -    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > +    int ret;
> > +    void *arg;
> > +    va_list ap;
> > +
> > +    va_start(ap, type);
> > +    arg = va_arg(ap, void *);
> > +    va_end(ap);
> > +
> > +    ret = ioctl(guest_memfd, type, arg);
> > +    if (ret == -1) {
> > +        ret = -errno;
> > +    }
> > +    return ret;
> >   }
> > -int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> > +static int guest_memfd_set_memory_attributes_fd(int guest_memfd, hwaddr offset,
> > +                                                uint64_t size, uint64_t attr)
> >   {
> > -    return kvm_set_memory_attributes(start, size, 0);
> > +    struct kvm_memory_attributes2 attrs;
> 
> -    struct kvm_memory_attributes2 attrs;
> +    struct kvm_memory_attributes2 attrs = {0};
> 
> Zero initializing 'attrs' fixed a '-EINVAL' error, caused because of kernel
> 'attrs.reserved' check failed in 'kvm_gmem_set_attributes()'.

Indeed, thanks for the catch!

-Mike

> 
> Thanks,
> 
> Pankaj
> 
> > +    int r;
> > +
> > +    assert((attr & kvm_supported_memory_attributes) == attr);
> > +    attrs.attributes = attr;
> > +    attrs.offset = offset;
> > +    attrs.size = size;
> > +    attrs.flags = 0;
> > +
> > +    /*
> > +     * guest_memfd may need to delay conversion requests due to
> > +     * the memory being in-use by the kernel. In most cases these
> > +     * will be transient uses. In some cases, userspace itself may
> > +     * be the cause of the memory being considered in-use, though
> > +     * QEMU currently takes steps to avoid this (e.g. via
> > +     * RamBlockAttributes). On that basis, this code loops
> > +     * indefinitely with the assumption that only transient cases
> > +     * will block, and that those will be for relatively short
> > +     * periods vs. the overall conversion path.
> > +     * If those assumptions at some point prove false, most likely
> > +     * this will manifest as guest-side lockups on their conversion
> > +     * path, which seems like the appropriate way to surface this
> > +     * situation to the guest owner rather than some hard timeout.
> > +     */
> > +    do {
> > +        r = kvm_gmem_ioctl(guest_memfd, KVM_SET_MEMORY_ATTRIBUTES2, &attrs);
> > +    } while (r == -EAGAIN);
> > +
> > +    if (r) {
> > +        error_report("failed to set memory (0x%" HWADDR_PRIx "+0x%" PRIx64 ") "
> > +                     "with attr 0x%" PRIx64 " error '%s'",
> > +                     offset, size, attr, strerror(-r));
> > +    }
> > +    return r;
> > +}
> > +
> > +static int guest_memfd_set_memory_section_attributes(MemoryRegionSection *section, uint64_t attr)
> > +{
> > +    hwaddr convert_offset, convert_size;
> > +    MemoryRegion *mr = section->mr;
> > +    RAMBlock *rb;
> > +
> > +    assert(mr);
> > +    rb = mr->ram_block;
> > +    assert(rb->guest_memfd);
> > +    convert_offset = section->offset_within_region;
> > +    convert_size = int128_get64(section->size);
> > +
> > +    return guest_memfd_set_memory_attributes_fd(rb->guest_memfd,
> > +                                                convert_offset,
> > +                                                convert_size,
> > +                                                attr);
> >   }
> >   /* Called with KVMMemoryListener.slots_lock held */
> > @@ -3447,10 +3511,18 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
> >       hwaddr size = int128_get64(section->size);
> >       int ret;
> > -    if (to_private) {
> > -        ret = kvm_set_memory_attributes_private(start, size);
> > +    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
> > +        ret = guest_memfd_set_memory_section_attributes(section,
> > +                                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
> > +                                                                   : 0);
> >       } else {
> > -        ret = kvm_set_memory_attributes_shared(start, size);
> > +        /*
> > +         * Without in-place conversion, attribute-tracking is handled by KVM
> > +         * across all guest memory rather than on a per-section/slot basis.
> > +         */
> > +        ret = kvm_set_memory_attributes(start, size,
> > +                                        to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE
> > +                                                   : 0);
> >       }
> >       return ret;
> > @@ -3544,7 +3616,8 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
> >       return 0;
> >   }
> > -int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> > +static int kvm_convert_memory_full(hwaddr start, hwaddr size, bool to_private,
> > +                                   bool pre_hooks, bool post_hooks)
> >   {
> >       int ret = -EINVAL;
> > @@ -3588,10 +3661,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> >               continue;
> >           }
> > -        ret = kvm_pre_convert_section(&section, to_private);
> > -        if (ret) {
> > -            memory_region_unref(section.mr);
> > -            break;
> > +        if (pre_hooks) {
> > +            ret = kvm_pre_convert_section(&section, to_private);
> > +            if (ret) {
> > +                memory_region_unref(section.mr);
> > +                break;
> > +            }
> >           }
> >           ret = kvm_convert_section(&section, to_private);
> > @@ -3600,13 +3675,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> >               break;
> >           }
> > -        ret = kvm_post_convert_section(&section, to_private);
> > -        memory_region_unref(section.mr);
> > -
> > -        if (ret) {
> > -            break;
> > +        if (post_hooks) {
> > +            ret = kvm_post_convert_section(&section, to_private);
> > +            if (ret) {
> > +                memory_region_unref(section.mr);
> > +                break;
> > +            }
> >           }
> > +        memory_region_unref(section.mr);
> >           size -= section_end - start;
> >           start = section_end;
> >       }
> > @@ -3614,6 +3691,26 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> >       return ret;
> >   }
> > +int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> > +{
> > +    return kvm_convert_memory_full(start, size, to_private, true, true);
> > +}
> > +
> > +static int kvm_convert_memory_attributes(hwaddr start, hwaddr size, bool to_private)
> > +{
> > +    return kvm_convert_memory_full(start, size, to_private, false, false);
> > +}
> > +
> > +int kvm_set_memory_attributes_private(hwaddr start, uint64_t size)
> > +{
> > +    return kvm_convert_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > +}
> > +
> > +int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
> > +{
> > +    return kvm_convert_memory_attributes(start, size, 0);
> > +}
> > +
> >   int kvm_cpu_exec(CPUState *cpu)
> >   {
> >       struct kvm_run *run = cpu->kvm_run;

