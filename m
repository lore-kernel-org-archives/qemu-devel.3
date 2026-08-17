Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AA5C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwyi-0005FR-04; Mon, 17 Aug 2026 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvwyb-0005CQ-FT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvwyZ-0007Ac-0e
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786971721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OLVz3yfHsEbCFv/qiFQMxVMffLxnFEidkOUubR6Ojo=;
 b=InLbJ1EGtmGy10nw0UcnT3uLB2cyg73yUFORaBn7Bl15f0/r6njw5lp8tLbpeGJ2o9+Iat
 r40W8BXxPIVUloYK0txS2g8RP9NGTaFcR2fvwF4KsUv4rdVNvhGSYDmaq+dD/vJnWNOhsZ
 BFyp53ZeUhw100IGCE55sVUps4uC7MQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-PFLslkFAPYCbHSdKFiiTHw-1; Mon, 17 Aug 2026 09:02:00 -0400
X-MC-Unique: PFLslkFAPYCbHSdKFiiTHw-1
X-Mimecast-MFC-AGG-ID: PFLslkFAPYCbHSdKFiiTHw_1786971719
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7475c666b20so2997771137.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786971719; x=1787576519; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2OLVz3yfHsEbCFv/qiFQMxVMffLxnFEidkOUubR6Ojo=;
 b=EH7icMd7TyCceRDEjyF+ReTdLpW+QJrUHFfDtx36HawNsN0bnaM8HJR0WAzihSCD7h
 dpH9hxjwOpyIshSRbnFQbVkMsA0Y4C2K0tr+gCZcCuOi8/wYxKKY6TieKmOpysayDBSQ
 DAkqWQrZE3lmLrnO4sWugiB7tBygq4ZLDz1GE+7TyrnxHr+by0kFvB9bWbbnvm7TciIO
 /LiruzZIR6FswCiq5QyXCPCEpQ+IGFNcKqdgvhlcTziqRRZSyJzaugspky8i2B5zHWCb
 fWdQhk9E7GjK2br2G3ktsPrAySZ6+5wlZSCgEsgZMm1FiHc/h2ErbLiE7EK9rMUbAwla
 Odbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971719; x=1787576519;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2OLVz3yfHsEbCFv/qiFQMxVMffLxnFEidkOUubR6Ojo=;
 b=fLrsCD1EHIjy4AeNejUeCXzY6PEHlVGOrQ6TSfxXC+a7QcuCrSCB2ZBuHUt3bRFzSy
 iCIdP8bzT+k9qwmDnBCG2UuG32AK7TVu2p6nNGy6R5LYvUoTsvyUEFNUdETRAn2fFFWT
 wS0lcfkzQbrIl3nmpt3YXlxBqIL8zeyTDpubNcckWqWisfWRrdeRGRbW1CsaDsppUQ3m
 6jhEJpSu8Aa8M9KwhjE+CakqZdBpj2YSq1XiMPy5s1PZ1zgNBtlMvUxB6l9wN2f1wgE4
 648fUNE8RUdwAU6X5z4odjtKCgREkQVFL4g1YjpbrvF+AbM5o+uIvkgBV/bdOhwQYdLe
 Sovg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhpItxVSgw9IoK+aWYjJx73nWLa3ju12LfEdYZV7IxUAOFeMebCLCBuby9X/ZH0hFNA0xX5zZWJg5a@nongnu.org
X-Gm-Message-State: AOJu0Yy4E4Whlo8loTGNSD8A7GNKKRNtfOx8aRQkLj32xrWoYZ+ofKi2
 KcLKeioKVk7xhNYmMAxcBJXpL1abmMF8infiKcjofXrl72HWbBmV++ueCRH9EzZAez1gA7QaVgj
 /IEgTJs3CvB9gnbGxo4uHQLav/GkEYQf3nzmO10Lldzoj4pALIQPy6Ke+
X-Gm-Gg: AR+sD13Tx/iM/R3ehR5D0TQAlHkpurm722xk28koNZGBFfvhQmyMNUaiJhCBSl3sMbX
 EKtq++oMgX8+S7+HgAoOyK+BadYGzvcX/heu+WCfuQXMCSIMMv0naMAJY0QFhzlYQE+G6GVHG1x
 Wy+JiAU1yfeqAf17eM2zpjW1ohv6BEYmhLnGKDezJ3NA5kCAYAm1ddVQYjZwNp23YA4sn7Huo8Z
 CHHlEf49kV6vhpiHeUjjMbYt38HvJa9ZNY+dSBpkCNxjfKuPD15hBJ7uBqBUL3wv0ZE1uBK7+0o
 gQtVGxJTaD7Lbvx+KZOhfLK+3dOwcTICWsp36HSC2tIgEhnxjakY0uor/kQ2PLkA786m
X-Received: by 2002:a05:6102:1621:b0:772:9fee:5681 with SMTP id
 ada2fe7eead31-7729fee56edmr1680583137.12.1786971719216; 
 Mon, 17 Aug 2026 06:01:59 -0700 (PDT)
X-Received: by 2002:a05:6102:1621:b0:772:9fee:5681 with SMTP id
 ada2fe7eead31-7729fee56edmr1680530137.12.1786971717183; 
 Mon, 17 Aug 2026 06:01:57 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97c2c2fbcc9sm1063165241.7.2026.08.17.06.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:01:56 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:01:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <aoMGNz9AdOnDQkKE@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com> <an3PWdPIdb6afDsS@x1.local>
 <an8yCp9qZ498aLu2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an8yCp9qZ498aLu2@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 14, 2026 at 04:19:38PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 13, 2026 at 10:06:17AM -0400, Peter Xu wrote:
> > On Thu, Aug 13, 2026 at 01:48:21PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Aug 13, 2026 at 08:28:24AM -0400, Peter Xu wrote:
> > > > On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> > > > > On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > > > > > From: Peter Xu <peterx@redhat.com>
> > > > > > 
> > > > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > > > > need two layers of memory backends, while the guest-memfd only provides the
> > > > > > private set of pages.
> > > > > > 
> > > > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > > > only source of memory to back the object (aka, fully shared).
> > > > > > 
> > > > > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > > > > 
> > > > > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > > > > 
> > > > > > Note that share=on is required with fully shared guest_memfd.
> > > > > > 
> > > > > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > > > > guest-memfd may return negative but not -1.
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > > > ---
> > > > > >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> > > > > >  qapi/qom.json            |  6 ++++-
> > > > > >  2 files changed, 56 insertions(+), 6 deletions(-)
> 
> snip
> 
> > > > > "memory-backend-memfd,guest-memfd=on|off" is switching between two
> > > > > separate implementations of the class.
> > > > > 
> > > > > This whole thing is just shouting "use a different class".
> > > > > 
> > > > > There is no meaningful sharing of code here, and the sharing of the
> > > > > public interface is offering apps no value as the impl prevents them
> > > > > from choosing the value of the properties - they have to be set of
> > > > > certain values which are not introspectable.
> > > > > 
> > > > > Please introduce a "memory-backend-guest-memfd" backend instead.
> > > > 
> > > > This is indeed what Michael used to suggest, and we were discussing in
> > > > previous version on which is better,
> > > > 
> > > > https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk
> > > > 
> > > > The hope is this is also easier for either libvirt or most users, but
> > > > please correct me if it's not the case, especially for libvirt.  The plan
> > > > is when CoCo flags are provided, all things will automatically switch to a
> > > > CoCo-friendly implementation within QEMU.
> > > > 
> > > > It also means here the guest-memfd= parameter shouldn't be needed in real
> > > > CoCo contexts because they'll simply be implied (no cmdline change needed
> > > > for the same "-object memory-backend-memfd" one used to use without CoCo).
> > > > It's only needed for only special use of guest-memfd, in this case
> > > > init-shared is the special case where CoCo doesn't use.
> > > 
> > > Reading all this, IMHO reusing memory-backend-memfd for the current
> > > Coco support was a design mistake, it should have have a
> > > memory-backend-guest-memfd object from the start.
> > > 
> > > Given that we need to be able to control memfd vs guest-memfd for
> > > the non-Coco case, it is still worth introducing the new object
> > > class today.
> > > 
> > > Even if the two classes shared all their properties (which they
> > > don't given the comment about 'seal' being always on), then a
> > > "foo=on|off" that toggles two separate impls is still creating
> > > a pair of sub-classes by the backdoor. 
> > 
> > The idea of that, at least in my mind.. is an user shouldn't need to worry
> > about differences of guest-memfd and memfd, QEMU should just do it for the
> > users, based on the machine configurations.  Memfd is a concept more widely
> > spread, the hope is anyone using guest-memfd should simply treat it as one
> > memfd, no matter it is shared, in-place converted, two-layer-backed, or
> > whatever is happening underneath.
> > 
> > Now we do create guest-memfd via a separate ioctl, what if we can create it
> > via memfd_create() syscall too?  Then do we need to do the separation from
> > QEMU layer?
> 
> If QEMU automatically did "the right thing" choosing between traditional
> memfd and guest-memfd, then I wouldn't have even started this thread :-)
> 
> The "guest-memfd=on|off" is the trigger that made me think the design
> was wrong from a public interface POV, as that explicitly says that the
> memfd vs guest-memfd distinction is not automatic - it requires the
> mgmt app to understand it and choose between them.
> 
> > IMHO that is now an ioctl is not required; it really can be part of
> > memfd_create() syscall, it's just easier to manage, e.g. it's completely
> > KVM alone, and it also has attached to the KVM instance.  The idea is still
> > similar, and we can see that from possibly shared properties here on huge
> > pages and so.  I don't treat seal= a block just to introduce a new object
> > for that, and I expect as gmemfd evolves it will gradually get most
> > features memfd supports.. like folio migration and so.. but I could be
> > wrong.
> > 
> > IMHO one major question to ask is, is it more convenient for libvirt to
> > have that new object?  Please keep in mind that after we introduce this as
> > a new object, we may start to introduce even more *-guest-memfd in the
> > future, we roughly talked about DAX in the previous discussion.  My goal is
> > to make it most convenient for either user or libvirt to maintain the
> > cmdlines for QEMU, but if you think that makes libvirt live harder instead,
> > I've no strong feeling to go back to what Michael initially suggested.
> 
> It is no more or less difficult for libvirt to use different object
> types vs using different guest-memfd=bool values.
> 
> What makes a difference for libvirt is understanding whether QEMU
> implements a given feature or not.
> 
> If we have the situation with
> 
>   memory-backend-memfd,hugetlb=bool,guest-memfd=bool
> 
> with this series, IIUC,  libvirt can introspect to see the new
> guest-memfd property, but it has no way of knowing that it can't
> use the hugetlb proeprty when guest-memfd=on
> 
> If the next QEMU release now permits hugetlb=on at the same time
> as guest-memfd=on, then libvirt has no way to know the restriction
> was relaxed.
> 
> The QAPI introspection data for memory-backend-memfd is identical
> in both cases.
> 
> To deal with this, you need to introduce a workaround to QAPI
> by declaring a feature flag like
> 
>    features: ['hugetlb-with-guest-memfd-works']
> 
> that libvirt can probe for to determine the functional improvement
> in QEMU.
> 
> By comparison, if we introduce a memory-backend-guest-memfd
> object today, then it will omit the hugetlb property entirely.
> 
> If the next QEMU release adds a hugetlb property to the
> memory-backend-guest-memfd object, this change is now visible
> in the introspection data, and thus libvirt knows that combo
> is possible with QEMU
> 
> (yes, there is the issue that this might have kernel dependancy
> that is not visible from QEMU's introspection, so not perfect,
> but at least libvirt can determine what QEMU is capable of)

Yes. Due to that, I was expecting Libvirt will always need to query host
capabilities on its own.  In this case Libvirt, if preferred, should also
be able to probe standalone with KVM_CAP_GUEST_MEMFD_FLAGS.

It's also more involved for sure when hugetlb is involved, if it will share
the same hugetlb reservation with hugetlbfs, it'll also somehow need to
make sure there're available pages later for allocations.  Also IIUC not
all default users are accessible to huge pages..

From QEMU's POV, personally I still prefer sticking with the memfd object
with guest-memfd=on, then expose the "features" in QAPI, that seems cleaner
to me.

> 
> 
> > For example, if libvirt wants to detect hugetlb supports for an object, it
> > can still pass in the parameters and test-boot a QEMU and then IIUC it'll
> > still correctly capture an error for gmemfd case.  It might be that I
> > didn't really get what will make libvirt complex by reusing the object, but
> > I'll definitely follow your judgement on that.
> 
> Trying parameters to see if they fail and then boot again with different
> options is not a viable approach. That is an indication that QEMU's
> design and/or introspection is flawed.

It'll be the same when introducing the new -guest-memfd object per above
complications, IMHO.  I'm not sure how hugetlbfs pages were managed now
with Libvirt, maybe that can help us understand how guest-memfd (when
hugetlb pages will be supported) will affect Libvirt's mgmt.  For now, it
doesn't seem to me that the new object will help in anyway, if we have
QEMU's "features" option.

Thanks,

-- 
Peter Xu


