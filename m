Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8502CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFfb-0003JM-BN; Wed, 10 Jun 2026 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1wXFfa-0003JA-0b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1wXFfY-0007K9-4T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781085377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yv1PkYDqywETEW2h714WlId5xNqfFerD9mNpqjdIjw=;
 b=YCPgJ3dK5BxPKhO0DfR9qshDJ9DC/I/zD6aoC2Fe7mBmWXJzQliGdkbQ+oIQyF4/fFcDo0
 7Q1OVs45IvgtZen+jzr3Zk1TfBS2ALhWUyqEroIfNOtmJujM+ehJipjlT+9GHR5v4Yq9rk
 go13s+29d1JZcuBbpoGXF+t681jOiPE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Qa5qFfOGOv-V-m5iPIDAxA-1; Wed,
 10 Jun 2026 05:55:06 -0400
X-MC-Unique: Qa5qFfOGOv-V-m5iPIDAxA-1
X-Mimecast-MFC-AGG-ID: Qa5qFfOGOv-V-m5iPIDAxA_1781085305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C55D1944D25; Wed, 10 Jun 2026 09:55:05 +0000 (UTC)
Received: from phrdina-thinkpadt14gen4.rmtcz.csb
 (headnet01.pony-001.prod.rdu2.dc.redhat.com [10.11.142.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61DA3000203; Wed, 10 Jun 2026 09:55:01 +0000 (UTC)
Date: Wed, 10 Jun 2026 11:54:58 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
> Hi Daniel,
> 
> On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > as reported by Julia.
> > 
> > snip
> > 
> 
> Thanks for looking into this.
> 
> > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > than one page when the guest page is 64KB. This tries to fix the issue
> > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > size is a larger one. With this applied, no guest system hang is seen
> > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > 
> > "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> > 
> > We really shouldn't be expecting users to have to set this in a production
> > deployment in order to stop a guest from hanging.  Even if we dropped the
> > experimental marker from this property, users would still need to know to
> > provide this magic setting, so it would still be broken out of the box.
> > 
> > How can we  get a solution that "just works" out of the box, which is
> > fully supported, not relying on experimental properties ?
> > 
> 
> How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
> property? I guess the properties whose names start with "x-" are all treated as
> experimental and unsupported?
> 
> For this case, the bounce buffer is inevitable as the memory region can't be
> directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
> in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
> bounce buffer size can be specified by users, and it's why the existing property
> "x-max-bounce-buffer-size" is reused.
> 
> I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
> which is set to on by default, following the existing behavior. When it's set to
> off by users, the max (allowed) buffer size won't be checked at all. However, I'm
> not sure if this makes sense at all.

Hi Gavin,

You did not answer the question that Daniel was asking, how will user
know that max-bounce-buffer-size should be used if it's necessary to fix
guest system hangs and how will user know what magic value should be set?

Pavel


