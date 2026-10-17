Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E9CC6B2A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 07:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHz7u-0007xV-8g; Sat, 17 Oct 2026 03:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xHz7r-0007wu-EU; Sat, 17 Oct 2026 03:46:43 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xHz7o-0000xE-1B; Sat, 17 Oct 2026 03:46:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 444024139E;
 Sat, 17 Oct 2026 07:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667E01F000C4;
 Sat, 17 Oct 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792223196;
 bh=HmX3jzMkFY0zwkJ48oK1hoCmfL54tnoQ+urHGzunEpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ekbWevkSwqtKGYlH5/47qX+XYYb4ifs+7YHczo2FbLZJrMI9AxXMz9obCuUYUyz3C
 vwSFmRTyB4QTET5xLYNAi+uFtlmEyH5jaNzdpjUmmqLDtBGLSMPTPTYyYIjsuwEIaS
 ZUwvZaiJjQtC5SGyby4C35rLf1eb7bjDW0XlS2i3TdYxs4aqr8AWy70/iRVGPRToBc
 mYFg7Px6yqE1++W+97KXY9qlnUGrzmbhBG4gJmU1REg82CV4r3RyDpdFRI/A/rUKhI
 KLhARIZCtjdcUcnTJCtC9v1XLJqNtRcAqryITOJgIs9ZGUihX7/mrYntDVki7pXPD+
 teVuMeyYBjdMQ==
Date: Sat, 17 Oct 2026 09:46:29 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atMn1R9ye4F34G1I@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atKEWmnXA-Gu1Y9T@p14s>
 <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=lpieralisi@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Sat, Oct 17, 2026 at 11:06:49AM +1000, Gavin Shan wrote:
> On 10/17/26 6:08 AM, Mathieu Poirier wrote:
> > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 76 insertions(+)
> > > > 
> > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > --- a/target/arm/kvm-rme.c
> > > > +++ b/target/arm/kvm-rme.c
> > > > @@ -15,6 +15,7 @@
> > > >    #include "migration/blocker.h"
> > > >    #include "qapi/error.h"
> > > >    #include "qemu/error-report.h"
> > > > +#include "qemu/memalign.h"
> > > >    #include "qom/object_interfaces.h"
> > > >    #include "system/confidential-guest-support.h"
> > > >    #include "system/kvm.h"
> > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > >    static RmeGuest *rme_guest;
> > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > +                              Error **errp)
> > > > +{
> > > > +    int ret;
> > > > +    void *buffer;
> > > > +    hwaddr size = region->size;
> > > > +    hwaddr base = region->base;
> > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > 
> > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > 
> > I refactored this function in V5 [1], along with the above declarations.
> > 
> > [1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/
> > 
> > > 
> > > > +
> > > > +    if (!region->data) {
> > > > +        return -ENODEV;
> > > > +    }
> > > > +
> > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > +    if (ret) {
> > > > +        error_report("RME: failed to configure initial"
> > > > +                     "private guest memory");
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    /* Allocate page-aligned memory */
> > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > +
> > > > +    if (!buffer) {
> > > > +        return -ENOMEM;
> > > > +    }
> > > > +
> > > > +    memset(buffer, 0, aligned_size);
> > > > +    memcpy(buffer, region->data, region->size);
> > > > +
> > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > +        .base = start,
> > > > +        .size = end - start,
> > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > +    };
> > > > +
> > > > +    while (populate_args.size > 0) {
> > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > +        if (ret) {
> > > > +            error_setg_errno(errp, -ret,
> > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > +                start, end);
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    qemu_vfree(buffer);
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > 
> > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > is 64KB. The question is how do we know the added regions due to the alignment
> > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > > I guess we probably just reject unaligned regions if they're not expected.
> > 
> > To make sure I understand your point, please expand on what would be an
> > unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries.
> > 
> > > 
> > > Even if the unaligned regions are allowed, they seem not well handled.
> > > 
> > > - @aligned_size is still 64KB instead of the 128KB ?
> > 
> > I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?
> > 
> 
> ROUND_UP(64KB+4KB, 64KB) corresponds to ROUND_UP(size+base, 64KB) for local
> variable @end instead of @aligned_size. @aligned_size is calculated as
> ROUND_UP(64KB, 64KB) and the output is still 64KB.
> 
> > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > >    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > 
> > I agree with you.  That part was refactored in V5 [1]:
> > 
> >          memcpy(buffer + (base - start), region->data, region->size);

I misunderstood Gavin's comment on this, so the issue isn't the memcpy per-se
(that was the impression I had) but rather in relation to using the buffer in

kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);

with populate_args.base = start (that was aligned down).

Thanks,
Lorenzo

> > > 
> > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > +{
> > > > +    Error **errp = err;
> > > > +    const RmeRamRegion *region = data;
> > > > +
> > > > +    if (*errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > +}
> > > > +
> > > >    static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > >    {
> > > > +    Error *errp = NULL;
> > > > +
> > > >        if (!running) {
> > > >            return;
> > > >        }
> > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > +    if (errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >        kvm_mark_guest_state_protected();
> > > >    }
> > > 
> 
> Thanks,
> Gavin
> 

