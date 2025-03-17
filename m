Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD34C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu7Cp-00016g-4v; Mon, 17 Mar 2025 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tu7Cl-00015w-U2
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tu7Ck-0000Ji-0J
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742205374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owhvDCMRzMyIcGNEkUsHGgyRSRubwpu7Eakvhy31Lts=;
 b=ClsVFr8ICst3fTN6vMu+FHRWSs1TW2adImGIGdp0gkzIaMSNzGx6XBH1tJm38MPxPOg6th
 Bd0SQWN1a4Ktci+/LwmSjBACSthaZv517kd1vK7BpnjEwzMMSZ9IgltL6kgSfJ2ogHdIe8
 NWCpaj4fn0NQ0tEDDYPVnl2GFFlf3ko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-nPk-xugjNFW9t4Kcn_EdSw-1; Mon,
 17 Mar 2025 05:56:10 -0400
X-MC-Unique: nPk-xugjNFW9t4Kcn_EdSw-1
X-Mimecast-MFC-AGG-ID: nPk-xugjNFW9t4Kcn_EdSw_1742205368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DE461800258; Mon, 17 Mar 2025 09:56:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E3F180175F; Mon, 17 Mar 2025 09:56:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7CF9518000BB; Mon, 17 Mar 2025 10:56:04 +0100 (CET)
Date: Mon, 17 Mar 2025 10:56:04 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, Mar 14, 2025 at 03:50:19PM +0100, Alexander Graf wrote:
> 
> On 14.03.25 15:08, Gerd Hoffman wrote:
> >    Hi,
> > 
> > > > Ok, assuming we allow the guest submit a IGVM image (which makes sense
> > > > indeed, otherwise we'll probably end up re-inventing IGVM).  How will
> > > > the kernel hashes be handled then?  I assume they will not be part of
> > > > the igvm image, but they must be part of the launch measurement ...
> > > The kernel hashes must be embedded in the IGVM image by the time you invoke
> > > vmfwupdate. That means when you generate the FUKI, you take 4 inputs:
> > > Generic firmware image, kernel, initramfs, cmdline. Out of those, you
> > > generate and embed an IGVM image that consists of the firmware image as well
> > > as the kernel hash page.
> > If your input firmware image already is an IGVM (say coconut), what is
> > supposed to happen?
> 
> I'll leave the details to Jörg on how he envisions it, but IIUC the flow for
> a "readily assembled IGVM" is different. In case of a COCONUT-SVSM IGVM, you
> expect chaining of trust. So the SVSM implements a TPM which then the OS
> would use with measured boot etc etc.

Well, I don't consider igvm being useful for svsm only.  Shipping
standard edk2 as igvm looks useful to me.  Main benefit: pre-calculate
launch measurements without having to know qemu internals.

> It's a fundamentally different concept from FUKI.

Hmm?  IGVM is just a different way to ship the firmware (and optionally
more).

> But it could share the same vmfwupdate mechanism to load.

Yep.  But we have to sort the details.

 (1) How we are going to load kernel + initrd in case the firmware is
     igvm?  Just update the igvm to also include linux kernel and
     initrd (see parallel reply from Jörg)?  If so, how does the
     launched firmware find the kernel + initrd?
     While digging around in the igvm spec I've seen there is the
     concept of 'parameters'.  Can this be used to pass on the memory
     location of kernel + initrd + cmdline?  Maybe the kernel hashes too?

 (2) Will the igvm be generated on the fly from FUKI data?  Or should
     the distros ship igvm images with firmware + kernel + initrd?

 (3) How we are going to handle uki add-ons?

 (4) Do we want keep the region list?  Or declare that igvm should be
     used in case a single region is not enough?  Or even go all-in and
     use IGVM exclusively?

take care,
  Gerd


