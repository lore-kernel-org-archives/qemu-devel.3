Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF77CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHyW-0008FS-4N; Wed, 10 Jun 2026 08:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1wXHyU-00089n-RT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1wXHyS-0006zl-Si
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDvJXTncnIKlXCZX6pqrNuhjcrFGzDHai7cw2yadke8=;
 b=islnVF3rUN7VtWi/3jjuSHsfu1l3GZF+yQdEiQuIdHUuSE5NBa+QjFHogn7+a/Ksbyrruw
 T/9R73bB0UhgXqDdEfChmAQggl9RfR3kwbE+PDwenyzdvZcga3DZ6/10WUTkTo2TjROf/x
 lYgoJd3Isluq8LDteFPCz/N96Ob1iAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-e1iKrnymMr20ERg3XoaZ8A-1; Wed,
 10 Jun 2026 08:23:58 -0400
X-MC-Unique: e1iKrnymMr20ERg3XoaZ8A-1
X-Mimecast-MFC-AGG-ID: e1iKrnymMr20ERg3XoaZ8A_1781094237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F95218DB42C; Wed, 10 Jun 2026 12:23:57 +0000 (UTC)
Received: from phrdina-thinkpadt14gen4.rmtcz.csb
 (headnet01.pony-001.prod.rdu2.dc.redhat.com [10.11.142.86])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72FD91954B09; Wed, 10 Jun 2026 12:23:54 +0000 (UTC)
Date: Wed, 10 Jun 2026 14:23:51 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <ailU5beAUVJ1Fdpt@phrdina-thinkpadt14gen4.rmtcz.csb>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> Hi Pavel,
> 
> On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
> > > Hi Daniel,
> > > 
> > > On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> > > > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > > > as reported by Julia.
> > > > 
> > > > snip
> > > > 
> > > 
> > > Thanks for looking into this.
> > > 
> > > > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > > > than one page when the guest page is 64KB. This tries to fix the issue
> > > > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > > > size is a larger one. With this applied, no guest system hang is seen
> > > > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > > > 
> > > > "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> > > > 
> > > > We really shouldn't be expecting users to have to set this in a production
> > > > deployment in order to stop a guest from hanging.  Even if we dropped the
> > > > experimental marker from this property, users would still need to know to
> > > > provide this magic setting, so it would still be broken out of the box.
> > > > 
> > > > How can we  get a solution that "just works" out of the box, which is
> > > > fully supported, not relying on experimental properties ?
> > > > 
> > > 
> > > How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
> > > property? I guess the properties whose names start with "x-" are all treated as
> > > experimental and unsupported?
> > > 
> > > For this case, the bounce buffer is inevitable as the memory region can't be
> > > directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
> > > in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
> > > bounce buffer size can be specified by users, and it's why the existing property
> > > "x-max-bounce-buffer-size" is reused.
> > > 
> > > I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
> > > which is set to on by default, following the existing behavior. When it's set to
> > > off by users, the max (allowed) buffer size won't be checked at all. However, I'm
> > > not sure if this makes sense at all.
> > 
> > Hi Gavin,
> > 
> > You did not answer the question that Daniel was asking, how will user
> > know that max-bounce-buffer-size should be used if it's necessary to fix
> > guest system hangs and how will user know what magic value should be set?
> > 
> 
> Sorry that I missed to answer Daniel's questions. For this specific case,
> user need to enlarge the bounce buffer size when seeing the following error
> message. We can add an explicit one in address_space_map() if the existing
> error message isn't obvious.
> 
>   qemu-system-aarch64: virtio: bogus descriptor or out of resources
> 
>   void *address_space_map(AddressSpace *as,
>                         hwaddr addr,
>                         hwaddr *plen,
>                         bool is_write,
>                         MemTxAttrs attrs)
>   {
>       if (!memory_access_is_direct(mr, is_write, attrs)) {
>           if (l == 0) {
>               error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
>               *plen = 0;
>               return NULL;
>           }
>       }

This may work when using qemu directly but users will not see this error
when using libvirt or management tools like kubevirt.

> As to the value user should take for max-bounce-buffer-size, it is really case by case
> and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> smallest value works for them. The worst case is to set 0xFFFFFFFF.

Doesn't sound like pleasant user experience playing guessing game to
figure out how to make a VM work and again will most likely not work for
kubevirt where users are usually not exposed to these low level properties.

I'm not familiar with the internals but isn't there a better way how to
solve it without requiring users to figure out by guessing what value works?

Pavel

> > Pavel
> > 
> 
> Thanks,
> Gavin
> 


