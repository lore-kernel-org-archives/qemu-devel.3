Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D74C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbli-0004KZ-R3; Fri, 21 Mar 2025 08:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tvblG-0004AS-R4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tvblF-0006V4-2M
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742561164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=82wE7nZ1yarYIxypEDNLJWzDvSoFOAKz+O7c/69pmHA=;
 b=K837F8Syc/+vhu/8LZJmwn/A7TvtQ+uzLzwtQUZNH33brPNdtArJIh7fV4ok2+6KoOkqiD
 V2bAjiR6piU/TnybbkFqaDSINhifG1JcnA8jzflIG7Pj9pDrFCNLEvla9aJwpikKXOHjNw
 X4QgYj3TQ/+J+i5ylD7gGIbdrPfoTAI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-vL6ldYQhOf-6aNzhyiQ5Ug-1; Fri,
 21 Mar 2025 08:46:00 -0400
X-MC-Unique: vL6ldYQhOf-6aNzhyiQ5Ug-1
X-Mimecast-MFC-AGG-ID: vL6ldYQhOf-6aNzhyiQ5Ug_1742561159
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99BB618DB6D3; Fri, 21 Mar 2025 12:45:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECE47192ED65; Fri, 21 Mar 2025 12:45:52 +0000 (UTC)
Date: Fri, 21 Mar 2025 12:45:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z91ffa53yRxXkJop@redhat.com>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 21, 2025 at 11:08:11AM +0100, Gerd Hoffman wrote:
>   Hi,
> 
> > >      While digging around in the igvm spec I've seen there is the
> > >      concept of 'parameters'.  Can this be used to pass on the memory
> > >      location of kernel + initrd + cmdline?  Maybe the kernel hashes too?
> > 
> > The find the locations of the kernel, initrd, cmdline, ... I think IGVM
> > parameters, either directly or (preferably indirectly) are a good
> > solution. By "indirectly" I mean to put these regions on a separate and
> > measured page which also contains the region hashes.
> 
> regions and hashes should be separate I think.  The regions are not
> necessarily fixed, the physical memory location where things have been
> loaded to can change.
> 
> But also see my other reply.  I'm not convinced any more carrying
> forward the hashes logic makes much sense.
> 
> > >  (2) Will the igvm be generated on the fly from FUKI data?  Or should
> > >      the distros ship igvm images with firmware + kernel + initrd?
> > 
> > My preference would be that distros ship the tooling and components to
> > build IGVM files and build them during kernel update. If a distro comes
> > up with a generic initrd+cmdline it can also ship pre-built IGVM files.
> 
> Working with the (F)UKI instead has the advantage that we can make use
> of the secure boot signature, with a workflow along these lines:
> 
> (distro) build:
>  * Embed the firmware as igvm inside the UKI.
>  * Sign the UKI.
> 
> first vm launch:
>  * Load the complete UKI.
>  * Pass on (a) the igvm section and (b) the UKI (including signature)
>    to the vmfwupdate device.
> 
> vmwupdate device:
>  * loads the igvm image.
>  * passes on the UKI location (as igvm parameter?).
> 
> second vm launch:
>  * firmware checks UKI signature.
>  * firmware (optionally) measures UKI into vTPM.
>  * firmware launches UKI.

> 
> Going ship the distro kernel as igvm image would work too.  Will
> simplify the measurement pre-calculation.  Also there is no need to pass
> around any parameters, everything (how the firmware finds the UKI etc)
> can be arranged at igvm build time then.  Disadvantage: This introduces
> a completely new boot workflow.  Will probably need a new set of cloud
> images exclusively for the BYOF case.

Having a completely different boot workflow & images for CVM BYOF that
does not involve/consume existing UKIs & addons feels pretty undesirable
to me.

If the baseline is that the distro/user is using UKIs for everything,
and then they want to do BYOF, that change should involve as little
difference as possible to pull firmware into the mix. Your first
workflow example with FUKI looks like it would satisfy that, but
switching to bundle the kernel/initrd/cmdline directly in the IGVM
would not.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


