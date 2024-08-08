Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C574CC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4Ol-00051Z-OO; Thu, 08 Aug 2024 10:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4Od-0004s6-PU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4Ob-00086J-It
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723128339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I7ei5NnffqSzlhOD/OD2Kh6yCpxgLXmKH1+2mOmOMdE=;
 b=DEq8WeKKS4bWR2mBPOzlbqgjpRwpn+DSyGMkKNfwrdgMf+cPEJYu4i5/HXnXKnMMrNVy9H
 j9qVWDDc4ZgoCk9wAtf2+DhbyrEwHBvYp9kQbVzj/9BOD9idClPZXBLy6So3pEtlVLmegD
 EcNjtvDm69e38VA5xghnmctgpPG+WBo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-mA-CTxKzM82vFmDdJSeeXA-1; Thu, 08 Aug 2024 10:45:36 -0400
X-MC-Unique: mA-CTxKzM82vFmDdJSeeXA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7abaf0aecdso72134766b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723128335; x=1723733135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7ei5NnffqSzlhOD/OD2Kh6yCpxgLXmKH1+2mOmOMdE=;
 b=wnA7Ka5FAFbHzKItFhGwbVExTEdMs/IFIDDWLNQP3QvdSicUZsE4eN6FVfF/Ya+ruS
 cjkU0rHf2VidvAtZV+aL18GfPySaebKjNmlA5VQq/7diRRpAWbOTxkxABOsGhAua4lHb
 47o164NHUC5+1rxfFd2eBQFjiZYRDiXB2DNIUvSf9e73ItV7ibHrc4gj3gUfXku9ZL9j
 JMo9U7KI8zLZGZ6WwAtjwWbG1RhHnLk3uxn1Kh0lisbTWhtUN9PE8T+E4QLeKRsDbhJU
 U/sUQv/me2af33qe+ufQLDOFuAQCN75Q4VDDm/tHPH2UhH9eyg2xOsLrzniuchmOMIVo
 WwAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm2EHX54JmtjSM9RXdH2VbjMabTErAIFL4Cy+3YrTNdWyXMdmIyTIdOtGHNHB9uRJBH6Pz4YFO9AvJSh7FR8KJU1Q0kx0=
X-Gm-Message-State: AOJu0YwUOZajLb2FYdrmB1aq+Xbc15zf44XWHZTBm4gCjJTjhh3MmkyU
 V4bmRZoVUGWMcsWG5Tg8HbLp72qQm0WxrvYUiCqLriNBpjYbhgm49WTZ0uTd5CmJLPijbajXNG6
 GYxGwrs3LO04ZnWqukqMZDlypwhwb+B12ZEIeNAI95b1+B9WveHZN
X-Received: by 2002:a17:907:6d17:b0:a7a:bece:621d with SMTP id
 a640c23a62f3a-a8090c2598dmr156012466b.3.1723128335051; 
 Thu, 08 Aug 2024 07:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwkK7ZwZmL9pH+2kMpu75d6zyZBpIH68AB2t+IhiA0LMNpUGuyuDefbSPg4U6joIxzX07q/A==
X-Received: by 2002:a17:907:6d17:b0:a7a:bece:621d with SMTP id
 a640c23a62f3a-a8090c2598dmr156009166b.3.1723128334095; 
 Thu, 08 Aug 2024 07:45:34 -0700 (PDT)
Received: from redhat.com ([2.55.34.111]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec7173sm743255566b.204.2024.08.08.07.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:45:32 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:45:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240808104449-mutt-send-email-mst@kernel.org>
References: <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <Zq99NcMkDMkDKBLv@x1n>
 <d94e8fda-23bb-4905-b656-3e1cb247079d@daynix.com>
 <ZrKKl2uxzGfl6SEA@x1n>
 <830e10d4-594b-40ec-a405-0f04988b7d4d@daynix.com>
 <ZrTOZbYisrcljFU4@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTOZbYisrcljFU4@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 09:55:49AM -0400, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 08:43:22PM +0900, Akihiko Odaki wrote:
> > On 2024/08/07 5:41, Peter Xu wrote:
> > > On Mon, Aug 05, 2024 at 04:27:43PM +0900, Akihiko Odaki wrote:
> > > > On 2024/08/04 22:08, Peter Xu wrote:
> > > > > On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
> > > > > > On 2024/08/03 1:26, Peter Xu wrote:
> > > > > > > On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
> > > > > > > > > > > I'm not sure if I read it right.  Perhaps you meant something more generic
> > > > > > > > > > > than -platform but similar?
> > > > > > > > > > > 
> > > > > > > > > > > For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
> > > > > > > > > > > "perf" or "compat", while by default to "compat"?
> > > > > > > > > > 
> > > > > > > > > > "perf" would cover 4) and "compat" will cover 1). However neither of them
> > > > > > > > > > will cover 2) because an enum is not enough to know about all hosts. I
> > > > > > > > > > presented a design that will cover 2) in:
> > > > > > > > > > https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
> > > > > > > > > 
> > > > > > > > > "-merge-platform" shouldn't be a QEMU parameter, but should be something
> > > > > > > > > separate.
> > > > > > > > 
> > > > > > > > Do you mean merging platform dumps should be done with another command? I
> > > > > > > > think we will want to know the QOM tree is in use when implementing
> > > > > > > > -merge-platform. For example, you cannot define a "platform" when e.g., you
> > > > > > > > don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
> > > > > > > > connected to virtio-net devices. Of course we can include those information
> > > > > > > > in dumps, but we don't do so for VMState.
> > > > > > > 
> > > > > > > What I was thinking is the generated platform dump shouldn't care about
> > > > > > > what is used as backend: it should try to probe whatever is specified in
> > > > > > > the qemu cmdline, and it's the user's job to make sure the exact same qemu
> > > > > > > cmdline is used in other hosts to dump this information.
> > > > > > > 
> > > > > > > IOW, the dump will only contain the information that was based on the qemu
> > > > > > > cmdline.  E.g., if it doesn't include virtio device at all, and if we only
> > > > > > > support such dump for virtio, it should dump nothing.
> > > > > > > 
> > > > > > > Then the -merge-platform will expect all dumps to look the same too,
> > > > > > > merging them with AND on each field.
> > > > > > 
> > > > > > I think we will still need the QOM tree in that case. I think the platform
> > > > > > information will look somewhat similar to VMState, which requires the QOM
> > > > > > tree to interpret.
> > > > > 
> > > > > Ah yes, I assume you meant when multiple devices can report different thing
> > > > > even if with the same frontend / device type.  QOM should work, or anything
> > > > > that can identify a device, e.g. with id / instance_id attached along with
> > > > > the device class.
> > > > > 
> > > > > One thing that I still don't know how it works is how it interacts with new
> > > > > hosts being added.
> > > > > 
> > > > > This idea is based on the fact that the cluster is known before starting
> > > > > any VM.  However in reality I think it can happen when VMs started with a
> > > > > small cluster but then cluster extended, when the -merge-platform has been
> > > > > done on the smaller set.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Said that, I actually am still not clear on how / whether it should work at
> > > > > > > last.  At least my previous concern (1) didn't has a good answer yet, on
> > > > > > > what we do when profile collisions with qemu cmdlines.  So far I actually
> > > > > > > still think it more straightforward that in migration we handshake on these
> > > > > > > capabilities if possible.
> > > > > > > 
> > > > > > > And that's why I was thinking (where I totally agree with you on this) that
> > > > > > > whether we should settle a short term plan first to be on the safe side
> > > > > > > that we start with migration always being compatible, then we figure the
> > > > > > > other approach.  That seems easier to me, and it's also a matter of whether
> > > > > > > we want to do something for 9.1, or leaving that for 9.2 for USO*.
> > > > > > 
> > > > > > I suggest disabling all offload features of virtio-net with 9.2.
> > > > > > 
> > > > > > I want to keep things consistent so I want to disable all at once. This
> > > > > > change will be very uncomfortable for us, who are implementing offload
> > > > > > features, but I hope it will motivate us to implement a proper solution.
> > > > > > 
> > > > > > That said, it will be surely a breaking change so we should wait for 9.1
> > > > > > before making such a change.
> > > > > 
> > > > > Personally I don't worry too much on other offload bits besides USO* so far
> > > > > if we have them ON for longer time.  My wish was that they're old good
> > > > > kernel features mostly supported everywhere who runs QEMU, then we're good.
> > > > 
> > > > Unfortunately, we cannot expect everyone runs Linux, and the offload
> > > > features are provided by Linux. However, QEMU can run on other platforms,
> > > > and offload features may be provided by vhost-user or vhost-vdpa.
> > > 
> > > I see.  I am not familiar with the status quo there, so I'll leave that to
> > > you and other experts that know better on this..
> > > 
> > > Personally I do care more on Linux, as that's what we ship within RH..
> > > 
> > > > 
> > > > > 
> > > > > And I definitely worry about future offload features, or any feature that
> > > > > may probe host like this and auto-OFF: I hope we can do them on the safe
> > > > > side starting from day1.
> > > > > 
> > > > > So I don't know whether we should do that to USO* only or all.  But I agree
> > > > > with you that'll definitely be cleaner.
> > > > > 
> > > > > On the details of how to turn them off properly..  Taking an example if we
> > > > > want to turn off all the offload features by default (or simply we replace
> > > > > that with USO-only)..
> > > > > 
> > > > > Upstream machine type is flexible to all kinds of kernels, so we may not
> > > > > want to regress anyone using an existing machine type even on perf,
> > > > > especially if we want to turn off all.
> > > > > 
> > > > > In that case we may need one more knob (I'm assuming this is virtio-net
> > > > > specific issue, but maybe not; using it as an example) to make sure the old
> > > > > machine types perfs as well, with:
> > > > > 
> > > > >     - x-virtio-net-offload-enforce
> > > > > 
> > > > >       When set, the offload features with value ON are enforced, so when
> > > > >       the host doesn't support a offload feature it will fail to boot,
> > > > >       showing the error that specific offload feature is not supported by the
> > > > >       virtio backend.
> > > > > 
> > > > >       When clear, the offload features with value ON are not enforced, so
> > > > >       these features can be automatically turned OFF when it's detected the
> > > > >       backend doesn't support them.  This may bring best perf but has the
> > > > >       risk of breaking migration.
> > > > 
> > > > "[PATCH v3 0/5] virtio-net: Convert feature properties to OnOffAuto" adds
> > > > "x-force-features-auto" compatibility property to virtio-net for this
> > > > purpose:
> > > > https://lore.kernel.org/r/20240714-auto-v3-0-e27401aabab3@daynix.com
> > > 
> > > Ah ok.  But note that there's still a slight difference: we need to avoid
> > > AUTO being an option, at all, IMHO.
> > > 
> > > It's about making qemu cmdline the ABI: when with AUTO it's still possible
> > > the user uses AUTO on both sides, then ABI may not be guaranteed.
> > > 
> > > AUTO would be fine if: (1) the property doesn't affect guest ABI, or (2)
> > > the AUTO bit will always generate the same thing on both hosts.  However
> > > USO* isn't such case.. so the AUTO option is IMHO not wanted.
> > > 
> > > What I mentioned above "x-virtio-net-offload-enforce" shouldn't add
> > > anything new to "uso"; it still can only be ON/OFF.  However it should
> > > affect "flip that to OFF automatically" or "fail the boot" behavior on
> > > missing features.
> > 
> > My rationale for the OnOffAuto change is that "flipping ON to OFF
> > automatically" is more confusing than making users specify AUTO to allow
> > QEMU making the feature OFF. "ON" will always make the boot fail.
> > 
> > The ABI guarantee will be gone anyway if x-virtio-net-offload-enforce=off.
> > AUTO is no different in that sense.
> 
> Hmm yes; I wished we can have device properties that user can never
> specify, but only set from internals.


I think prefixing with "x-" is good enough.

>  It's just that applying a compat
> property so far require a generic device property.  Or say, it'll be nice
> that compat property can tweak a class variable too then no property to
> introduce.
> 
> We could even add a migration blocker for x-virtio-net-offload-enforce=ON,
> but again it could be too aggresive.  I think it might be better we bet
> nobody will even know there's the parameter, so it won't be used in manual
> setup.  OTOH, "guest_uso4" can be too easiy to find there's the AUTO
> option: I normally use ",guest_uso4=?" to just dump the possible values.
> 
> Thanks,
> 
> -- 
> Peter Xu


