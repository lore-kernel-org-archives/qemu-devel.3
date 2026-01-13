Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F90BD0C85A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcg5-0000p9-GF; Tue, 13 Jan 2026 06:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfcfw-0000kb-Ph
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:35:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfcft-0003Od-Bu
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768304100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTFy/IoVZe2kxyS+ivUTKln3VOq2vjSKTT+JujGruFY=;
 b=hO9ySOyZhlvdI3wWBJbHsN3fXmkEqhBr1tWspcj98scKsOGK4jztMHstH3KoN86NFFuL82
 J2lJES6oabZon3yp8OnQUJAWn9mhKdcF+YcSvkrNe1DWOse/T6JVnvM/KVkpkuwI8QLiSH
 N5QXTbP+TRYnXY2QdBJiupNo492fczY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-jiamC1ddMeqyfYxtTZLWLA-1; Tue,
 13 Jan 2026 06:34:58 -0500
X-MC-Unique: jiamC1ddMeqyfYxtTZLWLA-1
X-Mimecast-MFC-AGG-ID: jiamC1ddMeqyfYxtTZLWLA_1768304097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15E82180045C; Tue, 13 Jan 2026 11:34:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C27AD30001A2; Tue, 13 Jan 2026 11:34:51 +0000 (UTC)
Date: Tue, 13 Jan 2026 11:34:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH] ui/vdagent: add migration blocker when machine version <
 10.1
Message-ID: <aWYt1yoET2Z60Rkp@redhat.com>
References: <20260112104454.54225-1-f.ebner@proxmox.com>
 <CAMxuvaz0AKCcO=nWUc_U39wcdHn0w_3N8WDncT0Fbc7aWM=nAQ@mail.gmail.com>
 <bf18287e-0f32-4138-95cd-5a7517ec7854@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf18287e-0f32-4138-95cd-5a7517ec7854@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 12:20:12PM +0100, Fiona Ebner wrote:
> Hi Marc-André,
> 
> Am 13.01.26 um 8:39 AM schrieb Marc-André Lureau:
> > Hi Fiona
> > 
> > On Mon, Jan 12, 2026 at 2:51 PM Fiona Ebner <f.ebner@proxmox.com
> > <mailto:f.ebner@proxmox.com>> wrote:
> > 
> >     In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
> >     added migration support for the vdagent chardev and commit 42000e0013
> >     ("ui/vdagent: remove migration blocker") removed the migration
> >     blocker. No compat for older machine versions was added, so migration
> >     with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
> >     will result in a failure when loading the VM state in the target
> >     instance:
> > 
> > 
> > But you can migrate a pre-10.1 machine with the new binary.
> 
> True, but I think it violates what a machine version is supposed to
> encapsulate. If a QEMU binary supports a given machine version, it
> should be able to load migration streams originating from other, newer
> QEMU binaries when the same machine version and commandline is used, or?

I guess it gets fuzzy because the general concept of machine types
is

  "what previously worked must still work in future, given an
   identical machine config".

Marc-andre's patch took something which was previously broken, and
made it work, for both new and pre-existing machine types, but only
if both sides used the new QEMU binary. This is somewhat unusual,
but probably not without precedent wrt other places where we have
removed historical blockers.

In this case, the patch is proposing to extend the above concept to
include "what was previously broken must remain broken", wrt pre-
existing machine types.

I have some sympathy for the latter proposal, because the way that
failures loading vmstate present themselves is very user hostile.

At least with migration you'll see the error after migration
completes, which is still "in the moment". If you're using a
save/restore workflow, as you might only discover this config
is not restorable on your desired older QEMU weeks or months
later.

IOW using an old machine type and the user config sometimes be
migratable and sometimes not migratable is poor user experiance
IMHO.


> 
> >  
> > 
> >     > Unknown savevm section or instance 'vdagent' 0. Make sure that your
> >     > current VM setup matches your saved VM setup, including any
> >     > hotplugged devices
> > 
> >     Add a compat flag to block migration when the machine version is less
> >     than 10.1 to avoid this.
> > 
> > 
> > I am not sure this is the right way to handle this. There is already
> > this error when migrating to an older qemu, I am not sure we have to
> > block earlier and prevent the above case.
> 
> I would consider this an internal/unexpected error. I feel like it
> should not occur if the VM was started with the exact same commandline
> on source and target, but currently, it can. It happens at the very end
> of migration when the source is already in post-migrate state, which is
> not nice for users/management layer.
> 
> > 
> >  
> > 
> >     Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>
> >     Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
> >     Signed-off-by: Fiona Ebner <f.ebner@proxmox.com
> >     <mailto:f.ebner@proxmox.com>>
> >     ---
> >      hw/core/machine.c |  1 +
> >      ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >      2 files changed, 47 insertions(+)
> > 
> >     diff --git a/hw/core/machine.c b/hw/core/machine.c
> >     index 6411e68856..9a5241ce17 100644
> >     --- a/hw/core/machine.c
> >     +++ b/hw/core/machine.c
> >     @@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] = {
> >          { "vfio-pci", "x-migration-load-config-after-iter", "off" },
> >          { "ramfb", "use-legacy-x86-rom", "true"},
> >          { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
> >     +    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
> > 
> > 
> > Is there a precedent where such compat property was added to block
> > migration?
> 
> There are several ones where migration is turned off for a device or
> certain properties, e.g.
> { "ramfb", "x-migrate", "off" } for 8.1
> { "pl011", "migrate-clk", "off" } for 5.1
> which is not quite the same, but I'd still argue:
> 
> I guess those properties were not migrated, so compatibility means still
> not migrating those for older machine version. For the vdagent chardev,
> the previous behavior was blocking migration, so compatibility means
> still blocking migration for older machine versions. Or does that not
> make sense?
> 
> Best Regards,
> Fiona
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


