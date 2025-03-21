Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B265AC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZIh-0008VA-K5; Fri, 21 Mar 2025 06:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvZIf-0008T5-1k
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tvZId-0006rN-79
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742551701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j75yqdIFQvwpSDhl+a54wJT/+mD+keE+bKKiRvrBVpo=;
 b=NUe65QxSmqqBdwcaVWS+rFYH97d89cqpZ6aNu6O/BV6Wr/wWkhkwL+LFWNbUml+oZOukOV
 gOP3Lzkr0vZXfRAOwV8gjT4Bc7My2eMxFWaew3TiHGCuv3cEBYg/9/dheXhSP24qfrb5A9
 Ym70y0tsM3xKi4oQtWYXci9xAWU+vHA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-AXp_vIBBPbSofe5tLmrd7w-1; Fri,
 21 Mar 2025 06:08:17 -0400
X-MC-Unique: AXp_vIBBPbSofe5tLmrd7w-1
X-Mimecast-MFC-AGG-ID: AXp_vIBBPbSofe5tLmrd7w_1742551695
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AE0F1800265; Fri, 21 Mar 2025 10:08:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0251180175B; Fri, 21 Mar 2025 10:08:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3DE171800390; Fri, 21 Mar 2025 11:08:11 +0100 (CET)
Date: Fri, 21 Mar 2025 11:08:11 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vSeF67fNazkxBh@8bytes.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

  Hi,

> >      While digging around in the igvm spec I've seen there is the
> >      concept of 'parameters'.  Can this be used to pass on the memory
> >      location of kernel + initrd + cmdline?  Maybe the kernel hashes too?
> 
> The find the locations of the kernel, initrd, cmdline, ... I think IGVM
> parameters, either directly or (preferably indirectly) are a good
> solution. By "indirectly" I mean to put these regions on a separate and
> measured page which also contains the region hashes.

regions and hashes should be separate I think.  The regions are not
necessarily fixed, the physical memory location where things have been
loaded to can change.

But also see my other reply.  I'm not convinced any more carrying
forward the hashes logic makes much sense.

> >  (2) Will the igvm be generated on the fly from FUKI data?  Or should
> >      the distros ship igvm images with firmware + kernel + initrd?
> 
> My preference would be that distros ship the tooling and components to
> build IGVM files and build them during kernel update. If a distro comes
> up with a generic initrd+cmdline it can also ship pre-built IGVM files.

Working with the (F)UKI instead has the advantage that we can make use
of the secure boot signature, with a workflow along these lines:

(distro) build:
 * Embed the firmware as igvm inside the UKI.
 * Sign the UKI.

first vm launch:
 * Load the complete UKI.
 * Pass on (a) the igvm section and (b) the UKI (including signature)
   to the vmfwupdate device.

vmwupdate device:
 * loads the igvm image.
 * passes on the UKI location (as igvm parameter?).

second vm launch:
 * firmware checks UKI signature.
 * firmware (optionally) measures UKI into vTPM.
 * firmware launches UKI.

Going ship the distro kernel as igvm image would work too.  Will
simplify the measurement pre-calculation.  Also there is no need to pass
around any parameters, everything (how the firmware finds the UKI etc)
can be arranged at igvm build time then.  Disadvantage: This introduces
a completely new boot workflow.  Will probably need a new set of cloud
images exclusively for the BYOF case.

take care,
  Gerd


