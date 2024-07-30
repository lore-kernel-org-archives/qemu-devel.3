Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C883C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYrBk-0003LU-6h; Tue, 30 Jul 2024 14:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYrBh-0003Ko-Jm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYrBf-0005lo-8D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722362582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7m4wfwgcgqEJZ4XmAvWfsfbIe7ZbK5ITnWvg70bYOo=;
 b=QYPBIV4NGkUMgXqVnoaH7NQENq+O6X4Vf328xVJ9IzUEW2arLri/je9agB+KnN62SemZzj
 XC4r82ePHJGvio+FK/4CJxfgpdXI+k8ihAPFSQ0rMQLKIhBEQLZqR0pnGJ6cBUQuMZw6IW
 8b2s3zc8XGrlpEMynRnFC7yx48ZNCx4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-Q0eBscu8NyOErWChdXqoeg-1; Tue, 30 Jul 2024 14:03:00 -0400
X-MC-Unique: Q0eBscu8NyOErWChdXqoeg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d38c7ccbso2937285a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 11:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722362577; x=1722967377;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7m4wfwgcgqEJZ4XmAvWfsfbIe7ZbK5ITnWvg70bYOo=;
 b=v1indGZlC/nINI7XnGJ2CZbXx+576ODpBdBqZbwnkq+BSt2jVqdhtm7Ng/8gdwtqvc
 6vjbOjjxAhhkj154bv+W0uYb91RPU0E4l4fIOE/4I7mnVEO4e+nZSKQTrQBs55DOffUf
 KXgadO2BdX9/b7AYdmThHFGs1XA8VLcUCZk7k1Pf/RffQUp4tKMT4X6D9cXcanMeXU6H
 foGXVctEFj1c1PoGwefwCCMV/oxvAnc1WRshjKL6lHk1eW+EdIc0ulHggTE1NJch1lEm
 bs0IVTQPaMLyFaTPoHiGWcjWWGuU5SbrJQ7AVfw5uNCdPQmJBXXHbkmbuNTtqJq+0FkT
 lCAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWi1a8PQKNtPXWv2pEAtZ4V39raaeNiSSKrFtX5tjjvr3W3hdIldoKGh2b43QI++oq+LJ1RVSkLcNi9wR8upUpw7yFEig=
X-Gm-Message-State: AOJu0Yy49bcfbch9foYsoZZQmL5YKhS34Zdb0rZ6oIuu/6evTbCOB25t
 afQMIRJzbvEvKtnPgABwRDn6A9qGh5ixZ2DMoUTdyJcdu1DDfl2GUXI6+RvMntYpT+8dDmfBg/6
 0AvEuNokqwKVO34DQXS7oQVipA9JM5T7+ejIc12fFwHC99PJfr6KE
X-Received: by 2002:a05:620a:4249:b0:79b:eca2:b807 with SMTP id
 af79cd13be357-7a1d6909b71mr1360669385a.3.1722362577080; 
 Tue, 30 Jul 2024 11:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH78atJzCkMm64TLKS4x2F3Lh427lkHg2d8c3LPDWbawaaf2JeveQjKvKcV+cEne/4eAcgfKw==
X-Received: by 2002:a05:620a:4249:b0:79b:eca2:b807 with SMTP id
 af79cd13be357-7a1d6909b71mr1360665885a.3.1722362576489; 
 Tue, 30 Jul 2024 11:02:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1ee464348sm337738385a.90.2024.07.30.11.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 11:02:55 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:02:53 -0400
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
Message-ID: <ZqkqzQVYHa6TpF0x@x1n>
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <e66cb5d6-e74d-4f8a-a2c1-c10763acf12b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66cb5d6-e74d-4f8a-a2c1-c10763acf12b@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 02:23:46AM +0900, Akihiko Odaki wrote:
> On 2024/07/30 2:00, Peter Xu wrote:
> > On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Jul 26, 2024 at 04:47:40PM -0400, Peter Xu wrote:
> > > > On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
> > > > > 
> > > > > In terms of launching QEMU I'd imagine:
> > > > > 
> > > > >    $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> > > > > 
> > > > > Any virtual machine HW features which are tied to host kernel features
> > > > > would have their defaults set based on the requested -platform. The
> > > > > -machine will be fully invariant wrt the host kernel.
> > > > > 
> > > > > You would have -platform hlep to list available platforms, and
> > > > > corresonding QMP "query-platforms" command to list what platforms
> > > > > are supported on a given host OS.
> > > > > 
> > > > > Downstream distros can provide their own platforms definitions
> > > > > (eg "linux-rhel-9.5") if they have kernels whose feature set
> > > > > diverges from upstream due to backports.
> > > > > 
> > > > > Mgmt apps won't need to be taught about every single little QEMU
> > > > > setting whose default is derived from the kernel. Individual
> > > > > defaults are opaque and controlled by the requested platform.
> > > > > 
> > > > > Live migration has clearly defined semantics, and mgmt app can
> > > > > use query-platforms to validate two hosts are compatible.
> > > > > 
> > > > > Omitting -platform should pick the very latest platform that is
> > > > > cmpatible with the current host (not neccessarily the latest
> > > > > platform built-in to QEMU).
> > > > 
> > > > This seems to add one more layer to maintain, and so far I don't know
> > > > whether it's a must.
> > > > 
> > > > To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
> > > > thought it was mostly the case already, except some extremely rare
> > > > outliers.
> > > > 
> > > > When we have one host that boots up a VM using:
> > > > 
> > > >    $QEMU1 $cmdline
> > > > 
> > > > Then another host boots up:
> > > > 
> > > >    $QEMU2 $cmdline -incoming XXX
> > > > 
> > > > Then migration should succeed if $cmdline is exactly the same, and the VM
> > > > can boot up all fine without errors on both sides.
> > > > 
> > > > AFAICT this has nothing to do with what kernel is underneath, even not
> > > > Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> > > > didn't, I thought the ABI should be guaranteed.
> > > 
> > > We've got two mutually conflicting goals with the machine type
> > > definitions.
> > > 
> > > Primarily we use them to ensure stable ABI, but an important
> > > secondary goal is to enable new tunables to have new defaults
> > > set, without having to update every mgmt app.  The latter
> > > works very well when the defaults have no dependancy on the
> > > platform kernel/OS, but breaks migration when they do have a
> > > platform dependancy.
> > > 
> > > >    - Firstly, never quietly flipping any bit that affects the ABI...
> > > > 
> > > >    - Have a default value of off, then QEMU will always allow the VM to boot
> > > >      by default, while advanced users can opt-in on new features.  We can't
> > > >      make this ON by default otherwise some VMs can already fail to boot,
> > > > 
> > > >    - If the host doesn't support the feature while the cmdline enabled it,
> > > >      it needs to fail QEMU boot rather than flipping, so that it says "hey,
> > > >      this host does not support running such VM specified, due to XXX
> > > >      feature missing".
> > > > 
> > > > That's the only way an user could understand what happened, and IMHO that's
> > > > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > > > while in which the machine type is the fundation of such definition, as the
> > > > machine type can decides many of the rest compat properties.  And that's
> > > > the whole point of the compat properties too (to make sure the guest ABI is
> > > > stable).
> > > > 
> > > > If kernel breaks it easily, all compat property things that we maintain can
> > > > already stop making sense in general, because it didn't define the whole
> > > > guest ABI..
> > > > 
> > > > So AFAIU that's really what we used for years, I hope I didn't overlook
> > > > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > > > keep up with this rule?
> > > 
> > > We've failed at this for years wrt enabling use of new defaults that have
> > > a platform depedancy, so historical practice isn't a good reference.
> > > 
> > > There are 100's (possibly 1000's) of tunables set implicitly as part of
> > > the machine type, and of those, libvirt likely only exposes a few 10's
> > > of tunables. The vast majority are low level details that no mgmt app
> > > wants to know about, they just want to accept QEMU's new defaults,
> > > while preserving machine ABI. This is a good thing. No one wants the
> > > burden of wiring up every single tunable into libvirt and mgmt apps.
> > > 
> > > This is what the "-platform" concept would be intended to preserve. It
> > > would allow a way to enable groups of settings that have a platform level
> > > dependancy, without ever having to teach either libvirt or the mgmt apps
> > > about the individual tunables.
> > 
> > Do you think we can achieve similar goal by simply turning the feature to
> > ON only after a few QEMU releases?  I also mentioned that idea below.
> > 
> > https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
> > 
> > So far it really sounds like the right thing to do to me to fix all similar
> > issues, even without introducing anything new we need to maintain.
> > 
> > To put that again, what we need to do is this:
> > 
> >    - To start: we should NEVER turn any guest ABI relevant bits
> >      automatically by QEMU, for sure..
> > 
> >    - When introducing any new device feature that may both (1) affects guest
> >      ABI, and (2) depends on host kernel features, we set those default
> >      values to OFF always at start. So this already covers old machine
> >      types, no compat property needed so far.
> > 
> >    - We always fail hard on QEMU boot whenever we detected such property is
> >      not supported by the current host when with ON (and since it's OFF by
> >      default it must be that the user specified that ON).
> > 
> >    - When after a stablized period of time for that new feature to land most
> >      kernels (we may consider to look at how major Linux distros updates the
> >      kernel versions) when we're pretty sure the new feature should be
> >      available on most of the QEMU modern users, we add a patch to make the
> >      property default ON on the new machine type, add a compat property for
> >      old machines.
> > 
> > The last bullet also means we'll start to fail new machine type from
> > booting when running that very new QEMU on a very old kernel, but that's
> > the trade-off, and when doing it right on "stablizing the feature in the
> > kernel world", it should really be corner case.  The user should simply
> > invoke an old machine type on that old kernel, even if the qemu is new.
> 
> docs/about/build-platforms.rst already defines supported platforms. One of
> the supported platforms is Debian 11 (bullseye), and it carries Linux 5.10,
> which was released December 2020. If we follow this platform support, a new
> feature added to upstream Linux may take about 4 years before it gets
> enabled by default on QEMU.
> 
> As an upstream developer, I feel it is too long, but I'm sure there are
> different opinions from different perspectives.

Above rule won't stop the supported platforms to still run the QEMU
binaries, am I right?  Especially if it's a serious user the VMs should
always be invoked with an old machine type, and that shouldn't be impacted,
as the old machines should simply don't support such new kernel feature.

The payoff here is only about when the user tries to start the VM using the
default / latest machine type.  Then with above rule it should fail clearly
on what is required to turn OFF so as to boot that VM.

Then the user has two options: turn that feature OFF manually, or switch to
an old machine type.

This is all still based on the fact that we do plan to keep that OFF for a
while.  So if we think "a few years" is too long, one option is we set it
to ON after e.g. 1-2 years so it's in the middle ground where some such
new users will fail booting the VM on old hosts, but it'll start to benefit
whoever runs the same on a new host.

So far I think it's not a major deal, especially considering that this so
far looks like the easiest and (still looks to me..) workable solution to
make migration always work, IMHO more important to serious VM users.

I'm definitely open to other options or suggestions if there is.  I just
don't see anything yet that is easily applicable..

Thanks,

-- 
Peter Xu


