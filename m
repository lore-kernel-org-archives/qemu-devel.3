Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D71E9E2E2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8Ey-0003pL-JO; Wed, 11 Feb 2026 06:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vq8Ew-0003pC-Li
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vq8Et-0003bZ-Qg
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770808714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PCz/BoB1TAf7RqiaH3v3Rc0bL5Hi1utmmjz64oT671Q=;
 b=S2xOllydO763T4y6mDJm6dn0/Sa3+PtWwfjw5m0PZv+9dVOJw5NqCIpZvuOk+BqUs2C13p
 Lurflbj6ScsvhZtlOmVCzofAHVtXmLueRO81wK8E7CnF8Ua1fEMsoLm1dmNEkYxFKcaE6d
 mPSQ+PSfSn6H4mWTpntXyrloncEEjus=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-LccfrIm4OIeXqS_uf4AXcQ-1; Wed,
 11 Feb 2026 06:18:30 -0500
X-MC-Unique: LccfrIm4OIeXqS_uf4AXcQ-1
X-Mimecast-MFC-AGG-ID: LccfrIm4OIeXqS_uf4AXcQ_1770808709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 452CA180061C; Wed, 11 Feb 2026 11:18:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.227.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE8D618003F6; Wed, 11 Feb 2026 11:18:22 +0000 (UTC)
Date: Wed, 11 Feb 2026 11:18:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <aYxle5JnDWob3Lke@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <aYtRooiYCc8LzUUJ@redhat.com> <aYwqb2MR+CjFfDtg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYwqb2MR+CjFfDtg@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 11, 2026 at 03:06:23PM +0800, Zhao Liu wrote:
> > So the main thing that pushes us into using QOM for internal properties
> > is the machine type compatibility code. eg where we bulk set stuff using
> > 
> >     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
> >     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
> > 
> > That logic is all QOM based. Using QOM isn't our exclusive approach, as
> > we have machine types sometimes setting object fields directly. eg
> > 
> >   static void pc_i440fx_machine_7_0_options(MachineClass *m)
> >   {
> >     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >     pc_i440fx_machine_7_1_options(m);
> >     pcmc->enforce_amd_1tb_hole = false;
> >     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
> >     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
> >   }
> > 
> > but that only works for properties against the machine type, not compat
> > properties against devices, since we have no direct access to the other
> > classes/instances.
> 
> Right, and setting fields directly is only possible for machine-level
> state, not for device properties created dynamically during
> realize/init. So QOM-based compat properties are indeed inescapable
> for devices.
> 
> > If we want to be able to control hardware compat, without exposing
> > something as a user facing tunable, then internal-only QOM props seems
> > inescapable.
> 
> Agreed.
> 
> > I do still wonder if we genuinely need internal-only QOM props for
> > machine type compat ?
> > 
> > Whether using a public 'x-' prefixed property or an internal only
> > property, we're constrained by the need to retain the behaviour
> > semantics for as long as the machine type exists. I don't see an
> > internal only property giving us significantly more freedom here.
> > We can already rename a 'x-' property however we want with no
> > notice, as long as the machine type doesn't change behaviour.
> 
> Hmm, I think x- prefix is already semantically overloaded. Looking at
> the current codebase, x- carries two very different meanings:
> 
>  - "unstable but user-facing feature" - e.g. x-vga, x-igd-opregion
>    (documented in docs/igd-assign.rst with user-facing examples),
>    x-migration-multifd-transfer (documented in
>    docs/devel/vfio-migration.rst).
> 
>  - "internal compat switch to fix bug" - e.g. x-buggy-eim,
>    x-pci-express-writeable-slt-bug.
> 
> These two categories have fundamentally different contracts - the
> former should be settable by users, the latter should not. But today,
> nothing prevents a user from writing something like:
> 
> "-device intel-iommu,x-buggy-eim=false"
> 
> QEMU will happily accept it.

I don't see that as a bug neccessarily, but rather a feature. It
has let users enable bug fixes, without changing their machine
type. It has been useful when users report that a guest OS is
broken after a given machine type version, to be able to toggle
fixes individually.


> > I don't think it does. Code evolution is painful as long as the machine
> > type using the prop needs to exist with fixed semantics, whether it is
> > internal or public with x- prefix.
> 
> I agree the machine type lifetime constraint doesn't change.
> 
> But experimental x- or normal (external) properties are by default
> exposed to users, allowing them to set values via -device or other
> entry points. This effectively treats the property as an API.
> 
> Once it becomes an API, any modification to the property must consider
> whether there are external dependencies.

When a property is exposed with a "x-" prefix, that is saying we
do *NOT*  need to consider external dependencies.  We can remove
it at all any time, if QEMU has no internal usage left. We might
*choose* to consider external usage, but that is not requird.

Our only hard constraint is that the machine type version must
remain with the fixed behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


