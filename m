Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7D1C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 20:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbR0k-0000oY-0g; Tue, 06 Aug 2024 16:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbR0d-0000nr-4l
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sbR0Y-0008BR-Uj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722976931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DhCNNcF3Fj+cRZ4IZmusNhI6TMMDRpZqUDObeYIpi0=;
 b=OCmkGfKOy5jyu8vU1lwh/jSmubKdXdVn6Fv3fs5GSgRvHDdwpS13DDsDiagkXy656tNATC
 l2EEEmNYXc5nbt08xcfFsEUKRAplH1JDZcqbmvNxyMaMuFSS/Y0brL7SxnyW/09gVBcfAl
 bLOXsBK7Q0miT+YGogqfK7vT15iA1h0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-GrziHadqP9KBB9NiG0b6Dw-1; Tue, 06 Aug 2024 16:42:09 -0400
X-MC-Unique: GrziHadqP9KBB9NiG0b6Dw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b95c005dbcso3129976d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 13:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722976923; x=1723581723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DhCNNcF3Fj+cRZ4IZmusNhI6TMMDRpZqUDObeYIpi0=;
 b=hcwYtonkKWkI6f7ApJjpGfjnKD1PU/4K+HGVq2tsTHi/f/FOh1j6PHL9CC6jIn2weg
 wNcwPR5u1Uk8aFa1Ze/KxMgPlaMjXqDNixkIvan3p8I1SvXndfySvFmwJLCUio3uAaNn
 9jo1vwXZ7IUL4+WmC6F6nmiFgQp9pfB7+xDsQDSpcDUJc+D/ZJtcY+yNzPh+0hMZn8s2
 owpTr3KW7733SWugZM2R/OY/yokq2ISDHJkrCcLuT20gT9lhiH/oVN0UE75vR8TekLBb
 S9TWfzupEmfxoaA/bJYH0EI4HSVSUdXZJoN+EL1k5Ejc9vO3byiz8j+YQWVLyXfiftvz
 CPjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe9rLWAlQjvqlmGCZfc5V7u46U5q7wq7kX+TMR1ILfvCZ5DHLYaU4KHjpdRLNk7mreHTQ9Mcc8VESJ@nongnu.org
X-Gm-Message-State: AOJu0Yx7B0jZn7MLv9UERovVh7ZU1pnvdGJptuxf+9aUiTSyFNgIfWtK
 CuAKYGz6x8Awlu/Rg2JXnFsOi5PDNDI19h2jTFWgw/IYnARCX2LoQUGNUntfS1YjO7PTLx4wa/4
 LCZ1jqAzIZqZWy8lYBXgqJSrYkO71g46sVRCOkIcc5mlF+ArTfhlB
X-Received: by 2002:a05:620a:2981:b0:79f:190a:8ad0 with SMTP id
 af79cd13be357-7a34ef42e81mr1083621385a.3.1722976923434; 
 Tue, 06 Aug 2024 13:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcYAFjh2j6cEDIvNaM6USlIvFelX27i45yav+HkBZk40fuA5YvUZulG+CdyJyV/ZRVtPQfIA==
X-Received: by 2002:a05:620a:2981:b0:79f:190a:8ad0 with SMTP id
 af79cd13be357-7a34ef42e81mr1083619685a.3.1722976922982; 
 Tue, 06 Aug 2024 13:42:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a34f6dcf20sm490103685a.20.2024.08.06.13.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 13:42:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:41:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZrKKl2uxzGfl6SEA@x1n>
References: <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <Zq99NcMkDMkDKBLv@x1n>
 <d94e8fda-23bb-4905-b656-3e1cb247079d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d94e8fda-23bb-4905-b656-3e1cb247079d@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 05, 2024 at 04:27:43PM +0900, Akihiko Odaki wrote:
> On 2024/08/04 22:08, Peter Xu wrote:
> > On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/03 1:26, Peter Xu wrote:
> > > > On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
> > > > > > > > I'm not sure if I read it right.  Perhaps you meant something more generic
> > > > > > > > than -platform but similar?
> > > > > > > > 
> > > > > > > > For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
> > > > > > > > "perf" or "compat", while by default to "compat"?
> > > > > > > 
> > > > > > > "perf" would cover 4) and "compat" will cover 1). However neither of them
> > > > > > > will cover 2) because an enum is not enough to know about all hosts. I
> > > > > > > presented a design that will cover 2) in:
> > > > > > > https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
> > > > > > 
> > > > > > "-merge-platform" shouldn't be a QEMU parameter, but should be something
> > > > > > separate.
> > > > > 
> > > > > Do you mean merging platform dumps should be done with another command? I
> > > > > think we will want to know the QOM tree is in use when implementing
> > > > > -merge-platform. For example, you cannot define a "platform" when e.g., you
> > > > > don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
> > > > > connected to virtio-net devices. Of course we can include those information
> > > > > in dumps, but we don't do so for VMState.
> > > > 
> > > > What I was thinking is the generated platform dump shouldn't care about
> > > > what is used as backend: it should try to probe whatever is specified in
> > > > the qemu cmdline, and it's the user's job to make sure the exact same qemu
> > > > cmdline is used in other hosts to dump this information.
> > > > 
> > > > IOW, the dump will only contain the information that was based on the qemu
> > > > cmdline.  E.g., if it doesn't include virtio device at all, and if we only
> > > > support such dump for virtio, it should dump nothing.
> > > > 
> > > > Then the -merge-platform will expect all dumps to look the same too,
> > > > merging them with AND on each field.
> > > 
> > > I think we will still need the QOM tree in that case. I think the platform
> > > information will look somewhat similar to VMState, which requires the QOM
> > > tree to interpret.
> > 
> > Ah yes, I assume you meant when multiple devices can report different thing
> > even if with the same frontend / device type.  QOM should work, or anything
> > that can identify a device, e.g. with id / instance_id attached along with
> > the device class.
> > 
> > One thing that I still don't know how it works is how it interacts with new
> > hosts being added.
> > 
> > This idea is based on the fact that the cluster is known before starting
> > any VM.  However in reality I think it can happen when VMs started with a
> > small cluster but then cluster extended, when the -merge-platform has been
> > done on the smaller set.
> > 
> > > 
> > > > 
> > > > Said that, I actually am still not clear on how / whether it should work at
> > > > last.  At least my previous concern (1) didn't has a good answer yet, on
> > > > what we do when profile collisions with qemu cmdlines.  So far I actually
> > > > still think it more straightforward that in migration we handshake on these
> > > > capabilities if possible.
> > > > 
> > > > And that's why I was thinking (where I totally agree with you on this) that
> > > > whether we should settle a short term plan first to be on the safe side
> > > > that we start with migration always being compatible, then we figure the
> > > > other approach.  That seems easier to me, and it's also a matter of whether
> > > > we want to do something for 9.1, or leaving that for 9.2 for USO*.
> > > 
> > > I suggest disabling all offload features of virtio-net with 9.2.
> > > 
> > > I want to keep things consistent so I want to disable all at once. This
> > > change will be very uncomfortable for us, who are implementing offload
> > > features, but I hope it will motivate us to implement a proper solution.
> > > 
> > > That said, it will be surely a breaking change so we should wait for 9.1
> > > before making such a change.
> > 
> > Personally I don't worry too much on other offload bits besides USO* so far
> > if we have them ON for longer time.  My wish was that they're old good
> > kernel features mostly supported everywhere who runs QEMU, then we're good.
> 
> Unfortunately, we cannot expect everyone runs Linux, and the offload
> features are provided by Linux. However, QEMU can run on other platforms,
> and offload features may be provided by vhost-user or vhost-vdpa.

I see.  I am not familiar with the status quo there, so I'll leave that to
you and other experts that know better on this..

Personally I do care more on Linux, as that's what we ship within RH..

> 
> > 
> > And I definitely worry about future offload features, or any feature that
> > may probe host like this and auto-OFF: I hope we can do them on the safe
> > side starting from day1.
> > 
> > So I don't know whether we should do that to USO* only or all.  But I agree
> > with you that'll definitely be cleaner.
> > 
> > On the details of how to turn them off properly..  Taking an example if we
> > want to turn off all the offload features by default (or simply we replace
> > that with USO-only)..
> > 
> > Upstream machine type is flexible to all kinds of kernels, so we may not
> > want to regress anyone using an existing machine type even on perf,
> > especially if we want to turn off all.
> > 
> > In that case we may need one more knob (I'm assuming this is virtio-net
> > specific issue, but maybe not; using it as an example) to make sure the old
> > machine types perfs as well, with:
> > 
> >    - x-virtio-net-offload-enforce
> > 
> >      When set, the offload features with value ON are enforced, so when
> >      the host doesn't support a offload feature it will fail to boot,
> >      showing the error that specific offload feature is not supported by the
> >      virtio backend.
> > 
> >      When clear, the offload features with value ON are not enforced, so
> >      these features can be automatically turned OFF when it's detected the
> >      backend doesn't support them.  This may bring best perf but has the
> >      risk of breaking migration.
> 
> "[PATCH v3 0/5] virtio-net: Convert feature properties to OnOffAuto" adds
> "x-force-features-auto" compatibility property to virtio-net for this
> purpose:
> https://lore.kernel.org/r/20240714-auto-v3-0-e27401aabab3@daynix.com

Ah ok.  But note that there's still a slight difference: we need to avoid
AUTO being an option, at all, IMHO.

It's about making qemu cmdline the ABI: when with AUTO it's still possible
the user uses AUTO on both sides, then ABI may not be guaranteed.

AUTO would be fine if: (1) the property doesn't affect guest ABI, or (2)
the AUTO bit will always generate the same thing on both hosts.  However
USO* isn't such case.. so the AUTO option is IMHO not wanted.

What I mentioned above "x-virtio-net-offload-enforce" shouldn't add
anything new to "uso"; it still can only be ON/OFF.  However it should
affect "flip that to OFF automatically" or "fail the boot" behavior on
missing features.

> 
> > 
> > With that,
> > 
> >    - On old machine types (compat properties):
> > 
> >      - set "x-virtio-net-offload-enforce" OFF
> >      - set all offload features ON
> > 
> >    - On new machine types (the default values):
> > 
> >      - set "x-virtio-net-offload-enforce" ON
> >      - set all offload features OFF
> > 
> > And yes, we can do that until 9.2, but with above even 9.1 should be safe
> > to do.  9.2 might be still easier just to think everything through again,
> > after all at least USO was introduced in 8.2 so not a regress in 9.1.
> > 
> > > 
> > > By the way, I am wondering perhaps the "no-cross-migrate" scenario can be
> > > implemented relatively easy in a way similar to compatibility properties.
> > > The idea is to add the "no-cross-migrate" property to machines. If the
> > > property is set to "on", all offload features of virtio-net will be set to
> > > "auto". virtio-net will then probe the offload features and enable available
> > > offloading features.
> > 
> > If it'll become a device property, there's still the trick / concern where
> > no-cross-migrate could conflict with the other offload feature that was
> > selected explicilty by an user (e.g. no-cross-migrate=ON + uso=OFF).
> With no-cross-migrate=ON + uso=OFF, no-cross-migrate will set uso=auto, but
> the user overrides with uso=off. As the consequence, USO will be disabled
> but all other available offload features will be enabled.

Basically you're saying that no-cross-migrate has lower priority than
specific feature bits.  That's OK to me.

Thanks,

-- 
Peter Xu


