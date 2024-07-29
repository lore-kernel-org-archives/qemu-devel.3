Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AF6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSlW-0004i0-VQ; Mon, 29 Jul 2024 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYSlU-0004cs-Ig
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYSlR-00076q-M8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722268699;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPAZDZhSxp/9eiZU4KM7jsKwtRfdy/fVbgEZz1WdEHs=;
 b=XCfM7gxSnHRI9wGnxmoIL7ldFWLRBTpWrC+1ljfppzdHAfAGjMhdJXv0P1tLT7afAJ3HUs
 TszLkT9n/EpKhXNXtsdHF8dZnM5ghGPiFPXJdxS1ouFjQ/trPS20ReA+suqP+IuEC5/A4i
 AaeAbF/lkmcc38ciTWGIaslH53RQ5qY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-QuHHjF_jP02gJ8wrQlcMzg-1; Mon,
 29 Jul 2024 11:58:16 -0400
X-MC-Unique: QuHHjF_jP02gJ8wrQlcMzg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C71D1955D48; Mon, 29 Jul 2024 15:58:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7C8819560AE; Mon, 29 Jul 2024 15:58:06 +0000 (UTC)
Date: Mon, 29 Jul 2024 16:58:03 +0100
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
Message-ID: <Zqe8C9AfaojKHM8A@redhat.com>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqQLbGxEW3XT7qL-@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 26, 2024 at 04:47:40PM -0400, Peter Xu wrote:
> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
> > 
> > In terms of launching QEMU I'd imagine:
> > 
> >   $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> > 
> > Any virtual machine HW features which are tied to host kernel features
> > would have their defaults set based on the requested -platform. The
> > -machine will be fully invariant wrt the host kernel.
> > 
> > You would have -platform hlep to list available platforms, and
> > corresonding QMP "query-platforms" command to list what platforms
> > are supported on a given host OS.
> > 
> > Downstream distros can provide their own platforms definitions
> > (eg "linux-rhel-9.5") if they have kernels whose feature set
> > diverges from upstream due to backports.
> > 
> > Mgmt apps won't need to be taught about every single little QEMU
> > setting whose default is derived from the kernel. Individual
> > defaults are opaque and controlled by the requested platform.
> > 
> > Live migration has clearly defined semantics, and mgmt app can
> > use query-platforms to validate two hosts are compatible.
> > 
> > Omitting -platform should pick the very latest platform that is
> > cmpatible with the current host (not neccessarily the latest
> > platform built-in to QEMU).
> 
> This seems to add one more layer to maintain, and so far I don't know
> whether it's a must.
> 
> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
> thought it was mostly the case already, except some extremely rare
> outliers.
> 
> When we have one host that boots up a VM using:
> 
>   $QEMU1 $cmdline
> 
> Then another host boots up:
> 
>   $QEMU2 $cmdline -incoming XXX
> 
> Then migration should succeed if $cmdline is exactly the same, and the VM
> can boot up all fine without errors on both sides.
> 
> AFAICT this has nothing to do with what kernel is underneath, even not
> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> didn't, I thought the ABI should be guaranteed.

We've got two mutually conflicting goals with the machine type
definitions.

Primarily we use them to ensure stable ABI, but an important
secondary goal is to enable new tunables to have new defaults
set, without having to update every mgmt app.  The latter
works very well when the defaults have no dependancy on the
platform kernel/OS, but breaks migration when they do have a
platform dependancy.

>   - Firstly, never quietly flipping any bit that affects the ABI...
> 
>   - Have a default value of off, then QEMU will always allow the VM to boot
>     by default, while advanced users can opt-in on new features.  We can't
>     make this ON by default otherwise some VMs can already fail to boot,
> 
>   - If the host doesn't support the feature while the cmdline enabled it,
>     it needs to fail QEMU boot rather than flipping, so that it says "hey,
>     this host does not support running such VM specified, due to XXX
>     feature missing".
> 
> That's the only way an user could understand what happened, and IMHO that's
> a clean way that we stick with QEMU cmdline on defining the guest ABI,
> while in which the machine type is the fundation of such definition, as the
> machine type can decides many of the rest compat properties.  And that's
> the whole point of the compat properties too (to make sure the guest ABI is
> stable).
> 
> If kernel breaks it easily, all compat property things that we maintain can
> already stop making sense in general, because it didn't define the whole
> guest ABI..
> 
> So AFAIU that's really what we used for years, I hope I didn't overlook
> somehting.  And maybe we don't yet need the "-platform" layer if we can
> keep up with this rule?

We've failed at this for years wrt enabling use of new defaults that have
a platform depedancy, so historical practice isn't a good reference.

There are 100's (possibly 1000's) of tunables set implicitly as part of
the machine type, and of those, libvirt likely only exposes a few 10's
of tunables. The vast majority are low level details that no mgmt app
wants to know about, they just want to accept QEMU's new defaults,
while preserving machine ABI. This is a good thing. No one wants the
burden of wiring up every single tunable into libvirt and mgmt apps.

This is what the "-platform" concept would be intended to preserve. It
would allow a way to enable groups of settings that have a platform level
dependancy, without ever having to teach either libvirt or the mgmt apps
about the individual tunables.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


