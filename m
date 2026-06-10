Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68176CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJcF-0006Fx-0W; Wed, 10 Jun 2026 10:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXJcD-0006Ff-IR
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXJcC-0002Kh-0u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781100547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWTVaoYMJmdERmtojDznqQmznXAobReZC50iW7TpeBA=;
 b=IEm1t0OiqItQcRKO9o5lvjvBmh2HjXmq6gLCx87kkRsWetPYsGwguj8OUdEIPpZ7OsU7WL
 p6jH2hrEvCunqH82D3cn5gYFwt6/7e24b1aNn97McXQ1z2rQocym5xs/yOEpOUYVnJ5vf8
 WOPtrgRCZ7kW6zGW95d4betvKoMfFVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-13cP_lPRNYad1IPnsPi6gw-1; Wed, 10 Jun 2026 10:08:59 -0400
X-MC-Unique: 13cP_lPRNYad1IPnsPi6gw-1
X-Mimecast-MFC-AGG-ID: 13cP_lPRNYad1IPnsPi6gw_1781100534
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef2bd566bso3832561f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781100534; x=1781705334; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yWTVaoYMJmdERmtojDznqQmznXAobReZC50iW7TpeBA=;
 b=JFwGQcQQ3GofNGQvkfA0qAU3TF6KCZH11UpHU7qWjX9w6Qz9yog87U9e5/HqNewmHR
 WR4bz4qFPlH424DINLwHd2BNovMmwI4im9z36M8qpfzqQ/0iXspcs8M6hG/DVVLfpVQS
 1hKyM+fwT0l+uNCLZ1DhT90lwGzzoxI/N3z/oqwlK+gXu9oYJOt/rLSymU3ht8o4kYqV
 MlXoQBwTI5WdeY16ghaOmJ6DUniatJScJtOqZVyIc6PRn7nqN4nRiefzkF3TxXRtvrRO
 bfy9GpEobkDpZ7KuXoNCb9cOTmERQ8T5m2pNV6wl9ws2+HDHDp6LF9fA4c7Xi6EuKb30
 kO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781100534; x=1781705334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yWTVaoYMJmdERmtojDznqQmznXAobReZC50iW7TpeBA=;
 b=DtrpMdqLPOOZMRbJLewJ5nbssYgT6NyWCEwQ9pKwA75kRP8Lf4Ka5xDwiId502do3j
 792kqEfXQVp/TruPcl2gNiU34Q12gr6dwxE19X7zstXAvkFwLYs+QFHBhe3h3jGLlb6Z
 qyZWOxKUHDcaZ7DzDfLcxWxdbQKGmjC+y/y4673Tchg24xHdQLd5VBQVOSfehl319Nah
 vfi5Sm8eB7hFTzA/GX10PETtRlgtcZFveI/tPuK3IudK8u9iES60YM/hmf13/k4jHqTO
 R5+Vhm+WGDJG49HAV79z7Wwj9APlASSOmSTfVhTQBv4cSJbLZ4zRG4yIsBPn6r4MlkUS
 +Pkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xkXrLeVX4hydGscKRLZfPEiZFmLCCvrU7VOSgVSO6WvpAJAttyTabg5Fmz/VYxzhEcoPMd3uoVtfe@nongnu.org
X-Gm-Message-State: AOJu0YzP0QoTSO5w7/NqyHd/ET9TPsggHCRBE6oztFzkibttpWHX82E2
 a18MtUHwQmIPDXK6FvhLfD+wjU9I62JP43iJXu41FEFi8Lfw0dEA+4bhUWlu/0KjBjPsdv62WaI
 41jlkqZEXcz9H2YdxBmAZ0EuLeT2+LXYohxqj+WXN7hK8ejvJjpKqWm5M
X-Gm-Gg: Acq92OGqia9Ia3IMkYnYGlWH/oTQe8S+wU+ugESiOHdRlSifQXJ0GV2NDAw49MvpNDN
 cFyfjjz4tJa5EZff4DQjTwDW3n9t8mffwA4nEmvbm4BfyJG1Il3jzJZuVdh3rUphhfvBkz8LT1O
 Rj5j3+PBAKiJ1pQ8D/+wpRdn8gzsm71xfivXSaOUIzIZcEixg6RAfgZ/P6M9uvveDQNs4rCiASp
 YUNklBlx42uSuDg4p4EH/d3D7a7HRTWPPpT8juL1VnMy0wBqRkx91QBZzancEH2YamNax1CvIme
 pLD/aaxEHdNUsp92NKmE9O5O06QAKj4d03gwAn7QXLYiwnXTVVanfmLIDC/YAX+0y699RzTue8F
 mp2wvdahMBJBR2HMFF5uzK3+qRvPE+KEUiTECoGVrDyJcBYg3LCGJCQ==
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490c2616e16mr413213975e9.28.1781100533697; 
 Wed, 10 Jun 2026 07:08:53 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490c2616e16mr413213125e9.28.1781100532987; 
 Wed, 10 Jun 2026 07:08:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4b18sm56718439f8f.10.2026.06.10.07.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 07:08:52 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:08:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610100721-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <ailU5beAUVJ1Fdpt@phrdina-thinkpadt14gen4.rmtcz.csb>
 <7cdbbf7b-e245-4d62-9461-a18a680e1719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cdbbf7b-e245-4d62-9461-a18a680e1719@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 12:04:52AM +1000, Gavin Shan wrote:
> On 6/10/26 10:23 PM, Pavel Hrdina wrote:
> > On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> > > Hi Pavel,
> > > 
> > > On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > > > On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
> > > > > Hi Daniel,
> > > > > 
> > > > > On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> > > > > > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > > > > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > > > > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > > > > > as reported by Julia.
> > > > > > 
> > > > > > snip
> > > > > > 
> > > > > 
> > > > > Thanks for looking into this.
> > > > > 
> > > > > > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > > > > > than one page when the guest page is 64KB. This tries to fix the issue
> > > > > > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > > > > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > > > > > size is a larger one. With this applied, no guest system hang is seen
> > > > > > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > > > > > 
> > > > > > "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> > > > > > 
> > > > > > We really shouldn't be expecting users to have to set this in a production
> > > > > > deployment in order to stop a guest from hanging.  Even if we dropped the
> > > > > > experimental marker from this property, users would still need to know to
> > > > > > provide this magic setting, so it would still be broken out of the box.
> > > > > > 
> > > > > > How can we  get a solution that "just works" out of the box, which is
> > > > > > fully supported, not relying on experimental properties ?
> > > > > > 
> > > > > 
> > > > > How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
> > > > > property? I guess the properties whose names start with "x-" are all treated as
> > > > > experimental and unsupported?
> > > > > 
> > > > > For this case, the bounce buffer is inevitable as the memory region can't be
> > > > > directly accessed. The memory region is initialized by memory_region_init_ram_device_ptr()
> > > > > in hw/vfio/region.c::vfio_region_mmap(). So the question is how the allowed
> > > > > bounce buffer size can be specified by users, and it's why the existing property
> > > > > "x-max-bounce-buffer-size" is reused.
> > > > > 
> > > > > I even thought of a new property for MachineState (e.g. "limited-bounce-buffer"),
> > > > > which is set to on by default, following the existing behavior. When it's set to
> > > > > off by users, the max (allowed) buffer size won't be checked at all. However, I'm
> > > > > not sure if this makes sense at all.
> > > > 
> > > > Hi Gavin,
> > > > 
> > > > You did not answer the question that Daniel was asking, how will user
> > > > know that max-bounce-buffer-size should be used if it's necessary to fix
> > > > guest system hangs and how will user know what magic value should be set?
> > > > 
> > > 
> > > Sorry that I missed to answer Daniel's questions. For this specific case,
> > > user need to enlarge the bounce buffer size when seeing the following error
> > > message. We can add an explicit one in address_space_map() if the existing
> > > error message isn't obvious.
> > > 
> > >    qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > 
> > >    void *address_space_map(AddressSpace *as,
> > >                          hwaddr addr,
> > >                          hwaddr *plen,
> > >                          bool is_write,
> > >                          MemTxAttrs attrs)
> > >    {
> > >        if (!memory_access_is_direct(mr, is_write, attrs)) {
> > >            if (l == 0) {
> > >                error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
> > >                *plen = 0;
> > >                return NULL;
> > >            }
> > >        }
> > 
> > This may work when using qemu directly but users will not see this error
> > when using libvirt or management tools like kubevirt.
> > 
> 
> Ok, then an error message raised by error_report() won't help.
> 
> > > As to the value user should take for max-bounce-buffer-size, it is really case by case
> > > and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> > > smallest value works for them. The worst case is to set 0xFFFFFFFF.
> > 
> > Doesn't sound like pleasant user experience playing guessing game to
> > figure out how to make a VM work and again will most likely not work for
> > kubevirt where users are usually not exposed to these low level properties.
> > 
> > I'm not familiar with the internals but isn't there a better way how to
> > solve it without requiring users to figure out by guessing what value works?
> > 
> 
> Not really. The worst case is to have 'max-bounce-buffer-size=0xFFFFFFFF',
> which is to disable the check against the max bounce buffer size :-)
> 
> Peter and Michael already lead the direction to bypass the bounce buffer
> for this specific case. It worked for me and no guest hang isn't seen when
> the bounce buffer is bypassed in address_space_map().
> 
> Thanks,
> Gavin

Mind, I am not against additionally switching virtio to support popping
bufs into QEMUSGList and not iovecs.

But the performance is gonnu be bad for this one.


-- 
MST


