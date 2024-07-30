Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1E1C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYrrm-0006rK-Ry; Tue, 30 Jul 2024 14:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYrrl-0006pi-Dm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYrri-0004cG-NP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722365189;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhdkLaCFVE43vsYLjFgMcHHxYaz1sdB8Cy44Q/hw71M=;
 b=HYl8UbdZq6wNEZnHhwwEVDyAzxAyIUUr9HLpl6HHUqMK2TLYcIeaFNBkbhGQXM/fGyWL7o
 S+jfzTw4tlnYyH4aG28z5A/8eayxDIhFnpcMUy3mkvuy5NZ3T1SXJveamSa9UR1HFikYWl
 qpIFeeN63yBL7qNJyCjXrRGkGfPWYqY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-75qLKNDgPsCiQyML4joC-w-1; Tue,
 30 Jul 2024 14:46:26 -0400
X-MC-Unique: 75qLKNDgPsCiQyML4joC-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F17B1955BED; Tue, 30 Jul 2024 18:46:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D83301955D42; Tue, 30 Jul 2024 18:46:15 +0000 (UTC)
Date: Tue, 30 Jul 2024 19:46:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zqk09BGxlpdxMBMx@redhat.com>
References: <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqktXwxBWjuAgGxZ@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
> On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
> > > On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
> > > > 
> > > > We've got two mutually conflicting goals with the machine type
> > > > definitions.
> > > > 
> > > > Primarily we use them to ensure stable ABI, but an important
> > > > secondary goal is to enable new tunables to have new defaults
> > > > set, without having to update every mgmt app.  The latter
> > > > works very well when the defaults have no dependancy on the
> > > > platform kernel/OS, but breaks migration when they do have a
> > > > platform dependancy.
> > > > 
> > > > >   - Firstly, never quietly flipping any bit that affects the ABI...
> > > > > 
> > > > >   - Have a default value of off, then QEMU will always allow the VM to boot
> > > > >     by default, while advanced users can opt-in on new features.  We can't
> > > > >     make this ON by default otherwise some VMs can already fail to boot,
> > > > > 
> > > > >   - If the host doesn't support the feature while the cmdline enabled it,
> > > > >     it needs to fail QEMU boot rather than flipping, so that it says "hey,
> > > > >     this host does not support running such VM specified, due to XXX
> > > > >     feature missing".
> > > > > 
> > > > > That's the only way an user could understand what happened, and IMHO that's
> > > > > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > > > > while in which the machine type is the fundation of such definition, as the
> > > > > machine type can decides many of the rest compat properties.  And that's
> > > > > the whole point of the compat properties too (to make sure the guest ABI is
> > > > > stable).
> > > > > 
> > > > > If kernel breaks it easily, all compat property things that we maintain can
> > > > > already stop making sense in general, because it didn't define the whole
> > > > > guest ABI..
> > > > > 
> > > > > So AFAIU that's really what we used for years, I hope I didn't overlook
> > > > > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > > > > keep up with this rule?
> > > > 
> > > > We've failed at this for years wrt enabling use of new defaults that have
> > > > a platform depedancy, so historical practice isn't a good reference.
> > > > 
> > > > There are 100's (possibly 1000's) of tunables set implicitly as part of
> > > > the machine type, and of those, libvirt likely only exposes a few 10's
> > > > of tunables. The vast majority are low level details that no mgmt app
> > > > wants to know about, they just want to accept QEMU's new defaults,
> > > > while preserving machine ABI. This is a good thing. No one wants the
> > > > burden of wiring up every single tunable into libvirt and mgmt apps.
> > > > 
> > > > This is what the "-platform" concept would be intended to preserve. It
> > > > would allow a way to enable groups of settings that have a platform level
> > > > dependancy, without ever having to teach either libvirt or the mgmt apps
> > > > about the individual tunables.
> > > 
> > > Do you think we can achieve similar goal by simply turning the feature to
> > > ON only after a few QEMU releases?  I also mentioned that idea below.
> > > 
> > > https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
> > > 
> > > So far it really sounds like the right thing to do to me to fix all similar
> > > issues, even without introducing anything new we need to maintain.
> > 
> > Turning a feature with a platform dependency to "on" implies that
> > the machine type will cease to work out of the box for platforms
> > which lack the feature. IMHO that's not acceptable behaviour for
> > any of our supported platforms.
> 
> Right, that's why I was thinking whether we should just always be on the
> safe side, even if I just replied in the other email to Akihiko, that we do
> have the option to make this more aggresive by turning those to ON after
> even 1-2 years or even less.. and we have control of how aggressive this
> can be.
> 
> > 
> > IOW, "after a few QEMU releases" implies a delay of as much as
> > 5 years, while we wait for platforms which don't support the
> > feature to drop out of our supported targets list.  I don't
> > think that'll satisfy the desire to get the new feature
> > available to users as soon as practical for their particular
> > platform.
> 
> The feature is always available since the 1st day, right?  We just need the
> user to opt-in, by specifying ON in the cmdline.
> 
> That'll be my take on this that QEMU's default VM setup should be always
> bootable, migratable, and so on.  Then user opt-in on stuff like this one,
> where there's implication on the ABIs.  The "user" can also include
> Libvirt.  I mean when something is really important, Libvirt should, IMHO,
> opt-in by treating that similarly like many cpu properties, and by probing
> the host first.
> 
> IIUC there aren't a lot of things like that (part of guest ABI & host
> kernel / HW dependent), am I right?  Otherwise I would expect more failures
> like this one, but it isn't as much as that yet.  IIUC it means the efforts
> to make Libvirt get involved should be hopefully under control too.  The
> worst case is Libvirt doesn't auto-on it, but again the user should always
> have the option to turn it on when it's necessary.

If it is left to libvirt, then it would very likely end up being a user
opt-in, not auto-enabled.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


