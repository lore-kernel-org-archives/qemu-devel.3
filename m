Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD1CEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdWq-0004lS-4Z; Tue, 01 Oct 2024 10:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdWk-0004fE-2r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdW7-00019f-12
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IxOJMBIhZ7BYPRZOylCZ/kHwLgaQnlhkUTGdAmBCh2g=;
 b=QlLdWdaN/1IyJyoKnm6tI7lgdXCLyQ54zQZU151jWb/p9mpg3X1RJFGvADmfTxg0EXhWcw
 etdRP3JZGyfzv/LH5MHv52yY6xd2OhUPFEmpRPSSfPanS9lxDUSSp/8KL5HomiTnnjwVO6
 O5rrVX83hMncGkJFRlqdv1p4EAQ5XIY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-0nBAxJsmNAe8PgOa5xIqhQ-1; Tue,
 01 Oct 2024 09:33:39 -0400
X-MC-Unique: 0nBAxJsmNAe8PgOa5xIqhQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C58121944DF4; Tue,  1 Oct 2024 13:33:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D85018CC1BE; Tue,  1 Oct 2024 13:33:28 +0000 (UTC)
Date: Tue, 1 Oct 2024 14:33:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sandesh Patel <sandesh.patel@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Rob Scheepens <rob.scheepens@nutanix.com>,
 Prerna Saxena <confluence@nutanix.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
Message-ID: <Zvv6JOiyyQZp39pI@redhat.com>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <a80c99b0e10e71a5a301c884d699eeaff3893349.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a80c99b0e10e71a5a301c884d699eeaff3893349.camel@infradead.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 28, 2024 at 03:59:32PM +0100, David Woodhouse wrote:
> On Tue, 2024-07-02 at 05:17 +0000, Sandesh Patel wrote:
> > 
> > The error is due to invalid MSIX routing entry passed to KVM.
> > 
> > The VM boots fine if we attach a vIOMMU but adding a vIOMMU can
> > potentially result in IO performance loss in guest.
> > I was interested to know if someone could boot a large Windows VM by
> > some other means like kvm-msi-ext-dest-id.
> 
> I think I may (with Alex Graf's suggestion) have found the Windows bug
> with Intel IOMMU.
> 
> It looks like when interrupt remapping is enabled with an AMD CPU,
> Windows *assumes* it can generate AMD-style MSI messages even if the
> IOMMU is an Intel one. If we put a little hack into the IOMMU interrupt
> remapping to make it interpret an AMD-style message, Windows seems to
> boot at least a little bit further than it did before...

Rather than filling the intel IOMMU impl with hacks to make Windows
boot on AMD virtualized CPUs, shouldn't we steer people to use the
amd-iommu that QEMU already ships [1] ?

Even if we hack the intel iommu, so current Windows boots, can we
have confidence that future Windows releases will correctly boot
on an intel iommu with AMD CPUs virtualized ?

> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3550,9 +3550,14 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>  
>      /* This is compatible mode. */
>      if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
> -        memcpy(translated, origin, sizeof(*origin));
> -        goto out;
> -    }
> +        if (0) {
> +            memcpy(translated, origin, sizeof(*origin));
> +            goto out;
> +        }
> +        /* Pretend it's an AMD-format remappable MSI (Yay Windows!) */
> +        index = origin->data & 0x7ff;
> +        printf("Compat mode index 0x%x\n", index);
> +    } else
>  
>      index = addr.addr.index_h << 15 | addr.addr.index_l;


With regards,
Daniel

[1] the AMD IOMMU is not perfect, because currently it has a significant
    QEMU impl flaw in that it secretly creates an extra PCI device behind
    the scenes. This makes it impossible for libvirt to manage the PCI
    resources from the AMD IOMMU. I feel like this ought to be solvable
    though, as it is just a QEMU impl decison that can be corrected.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


