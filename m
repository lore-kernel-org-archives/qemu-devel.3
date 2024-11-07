Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5812D43375
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Cd-0003iF-K3; Thu, 07 Nov 2024 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95Cc-0003i4-0v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95CZ-0001GW-Fq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730996261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=haVDPp1GVPGUd407cI/A+FgaBqQ9n1tI7rCm2rZ0hOU=;
 b=A7AjXV62tdRqVRyRcCyKWDWWZADPdP13ZehcbGYLm9j9gmX/qjm3e17YtTG6C0CZVInoXa
 Y9K734JeUkvkE68F3SODYAMIwImy43cAA2rZTBraJ5hWO67qCnZyYFMBJPzXQwoXFTXt6J
 WI6L+CHfrI4YpMn71pACEpnkICZU3rA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-LnArycUbNl2CafkSa7WROg-1; Thu, 07 Nov 2024 11:17:37 -0500
X-MC-Unique: LnArycUbNl2CafkSa7WROg-1
X-Mimecast-MFC-AGG-ID: LnArycUbNl2CafkSa7WROg
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-71800d88b27so1487778a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730996256; x=1731601056;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haVDPp1GVPGUd407cI/A+FgaBqQ9n1tI7rCm2rZ0hOU=;
 b=MwO2uCQBJtIKCt6ocgSrwfLmjCZ1Sv47Z+H88Tf6cQlzcBbqeU4+112pSLtdsKEFvA
 jxfRDI4m7pSxalS1+tIJXbWlI0dQYs6YSvVkdx5MfVL1gv7F2LVXR27D+tc1spm3jeql
 KG1xooC0usuOqQRZf6AlDGcg8t1zSSE111jXCrkYqVCO9y/GekIFzrtCp7E/U/7vxKLj
 UmLydiGufxRiP6iFy1c3Nifbe+D+n1h8rU9CWXA5dUmKl3yU8KrDS8YcWf4qqBpdlMPs
 LSiZ6F9cKVsLkriDFpvAWBeId4HHniHfxJY/fijfyIKGFiChCkivD78beGzJB+rZfpRK
 +OxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbDrlagb+Mq+c+1zxx7H47fdw4bNXzLfo+RN5Zo4MmPwNo/o3Xy+KhN4g+UMaDrL3szp0wGKUNGHgq@nongnu.org
X-Gm-Message-State: AOJu0YyV85X2ZPsiQ6fho6V9UpV1W1lkocs+FLYBgWQyTukbKIfIYkuY
 pr9IIxuYkXmhcHFlitC7jeGjCB5Y1oFD7clLNuhahw4fA4++7Jum6f3Ds1GIktn8JCmK1FjYyDq
 jvvSB9yWZO9SegzmDpidJwBX0PryJgmc/WsoSSqCttRIrmJ5wfdn6
X-Received: by 2002:a05:6830:638b:b0:718:b83:8f7e with SMTP id
 46e09a7af769-71a19590079mr765583a34.24.1730996256314; 
 Thu, 07 Nov 2024 08:17:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3hIwTEARUhep6SPDp5wYp9IWkdfpy+DUlSgtImM+sPL8NDaMqGravMu/0MozfCfaI2pMGDA==
X-Received: by 2002:a05:6830:638b:b0:718:b83:8f7e with SMTP id
 46e09a7af769-71a19590079mr765530a34.24.1730996255809; 
 Thu, 07 Nov 2024 08:17:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a1092110asm308516a34.70.2024.11.07.08.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:17:33 -0800 (PST)
Date: Thu, 7 Nov 2024 11:17:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <ZyzoGvOaybHs4uMl@x1n>
References: <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
 <ZyyzjWY-1nPpPgSW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyyzjWY-1nPpPgSW@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 07, 2024 at 12:33:17PM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 07, 2024 at 05:35:06PM +0530, Prasad Pandit wrote:
> > On Wed, 6 Nov 2024 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
> > > What we're thinking is having an initial exchange of information between
> > > src & dst as soon as migration starts and that would sync the
> > > capabilities and parameters between both sides. Which would then be
> > > followed by a channel establishment phase that would open each necessary
> > > channel (according to caps) in order, removing the current ambiguity.
> > >
> > 
> > * Isn't that how it works? IIUC, libvirtd(8) sends migration command
> > options to the destination and based on that the destination prepares
> > for the multifd and/or postcopy migration. In case of 'Postcopy' the
> > source sends 'postcopy advise' to the destination to indicate that
> > postcopy might follow at the end of precopy. Also, in the discussion
> > above Peter mentioned that libvirtd(8) may exchange list of features
> > between source and destination to facilitate QMP clients.
> > 
> > * What is the handshake doing differently? (just trying to understand)
> 
> Libvirt does what it does because it has had no other choice,
> not because it was good or desirable.
> 
> This kind of handshake really does not belong in libvirt. A number
> of exposed migration protocol feature knobs should be considered
> private to QEMU only.
> 
> It has the very negative consequence that every time QEMU wants to
> provide a new feature in migration, it needs to be plumbed up through
> libvirt, and often applications above, and those 3rd party projects
> need to be told when & where to use the new features. The 3rd party
> developers have their own project dev priorities so may not get
> around to enable the new migration features for years, if ever,
> undermining the work of QEMU's migration maintainers.
> 
> As examples...
> 
> If we had QEMU self-negotiation of features 10 years ago, everywhere
> would already be using multifd out of the box. QEMU would have been
> able to self-negotiate use of the new "multifd" protocol, and QEMU
> would be well on its way to being able to delete the old single-
> threaded migration code.
> 
> Similarly post-copy would have been way easier for apps, QEMU would
> auto-negotiate a channel for the post-copy async page fetching. All
> migrations would be running with the post-copy feature available.
> All that libvirt & apps would have needed was a API to initiate the
> switch to post-copy mode.
> 
> Or the hacks QEMU has put in place where we peek at incoming data
> on some channels  to identify the channel type would not exist.
> 
> 
> TL;DR: once QEMU can self-negotiate features for migration itself,
> the implementation burden for libvirt & applications is greatly
> reduced. QEMU migration maintainers will control their own destiny,
> able to deliver improvements to users much more quickly, be able
> to delete obsolete features more quickly, and be able to make
> migration *automatically* enable new features & pick the optimal
> defaults on their own expert knowledge, not waitnig for 3rd parties
> to pay attention years later.
> 
> Some things will still need work & decisions in libvirt & apps,
> but this burden should be reduced compared over the long term.
> Ultimately everyone will win.

I'll comment on a few examples above, which I think some of them, even if
handshake is ready, may still need mgmt layers to involve..

Multifd and postcopy are the two major features, and they, IMHO, all better
need user involvements..

Multifd needs it because it relies on the channel being able to provide >1
channels.  It means "| nc XXX > file" can stop working if we turn it on by
default silently.

We also see generic use case in containers now that when there're dedicated
cores for vcpus and "no dedicate" / "one" core setup for qemu hypervisor
threads, it means anything like multifd or even block layer iothreads can
be pure overheads comparing to one thread / one channel does the job.. in
those cases they're better disabled.

Postcopy, when enabled manually like right now, has one benefit I can think
of: when the user will 100% use postcopy, the failure can happen earlier if
dest host doesn't even support it!

So it'll generate an error upfront saying "postcopy not supported" before
migration starts, comparing to fail later at migrate_start_postcopy, then
fail that command, but maybe if so the user may not even start the
migration at all, knowing workload too busy to converge.

It's pretty common that postcopy is not supported on dest due to the fact
that people are over cautious on what userfault could do (which I kind of
agree.. it's a tricky but powerful feature), so unprivileged_userfaultfd=0
knob alone can disable it for many hosts, afaiu.. simply because kvm will
be the default accel, and qemu needs kernel fault trapping capability to
make postcopy work.. which requires unprivileged userfaults that qemu
process may not have.

Maybe the postcopy-preempt mode is the one closest to what we can enable by
default, so if it's not a capability we could auto-enalbe it with/without
handshake being there.  However there's still the tricky part where it
starts to require >1 channels, so if it's the default it could break anyone
who has a proxy after the socket, for example, iff the proxy only supports
one channel.. similar to multifd, but not completely the same.

Mapped-ram, definitely needs user involvements, because it will change the
image layout.

So.. just to say, maybe we'll still need some mgmt help to explicitly
enable many of the features after the handshake work, as the mgmt knows
better on what is the context of the VM, rather than risking qemu default
configs to fail on some existing but working setups.  Though at least
libvirt will only need to set caps/params only once for each migration.

Thanks,

-- 
Peter Xu


