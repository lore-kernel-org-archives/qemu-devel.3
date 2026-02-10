Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91D0EA8130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpps0-00081M-ME; Tue, 10 Feb 2026 10:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vppry-00080q-Mt
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpprw-0002v7-B4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770738098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3Dj6tNbcQE5SqbyLTPfFbVf4P7MD1C6T7QJxf5vI18=;
 b=bHX9aRCP/Zcf9kYU/8V6GL0xySVrj6mEUDDRDlesO5FSaGGCOxt4zYu7QnmLu5L0Gq6GVJ
 VJxKX0lY/7BTamN2SSYiYTVz+KvA23RqSn2F0EDklqpZLnSn+0+Ep9tFD/zzoUXd5ILnXm
 bmMRJPpVDxtIiywAwSiwbICmAO/sVVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-9k97TCOWMB-q_0tStQw3QQ-1; Tue,
 10 Feb 2026 10:41:34 -0500
X-MC-Unique: 9k97TCOWMB-q_0tStQw3QQ-1
X-Mimecast-MFC-AGG-ID: 9k97TCOWMB-q_0tStQw3QQ_1770738093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F31831955E77; Tue, 10 Feb 2026 15:41:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4569830001A5; Tue, 10 Feb 2026 15:41:25 +0000 (UTC)
Date: Tue, 10 Feb 2026 15:41:22 +0000
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
Message-ID: <aYtRooiYCc8LzUUJ@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYtOh9guoiQocdjk@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Feb 10, 2026 at 11:28:07PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
> > Date: Tue, 10 Feb 2026 10:12:38 +0000
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
> >  external user input
> > 
> > On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
> > > Hi,
> > > 
> > > This is the v2 trying to introduce property flags to detect user's
> > > property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
> > > RFC v1 [1].
> > 
> > This says what the series is proposing, but IMHO what is more important
> > here is explaining why this either desirable or appropriate to add as
> > general facility in QOM.
> 
> Yes, sorry this cover letter I wrote is overly simplified.
> 
> This series tries to control the property access against external user.
> USER_SET is the base to track external user's behavior, and DEPRECATED &
> INTERNAL flags provide different levels of access control.
> 
> Though the DEPRECATED flag does not inherently restrict access, I think
> such a warning also serves as a form of control.
> 
> The idea of restricting external access to properties is from previous
> discussions [*] about internal properties.
> 
> [*]: How to mark internal properties:
>      https://lore.kernel.org/qemu-devel/2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com/
> 
> Since that disscussion, currently all properties expected to be
> "internal" have an “x-” prefix — while this approach can work, it clearly
> confuses the original meaning of “x-”, which actually means "unstable".
> 
> Therefore, I think the optimal approach is to provide the capability to
> restrict external access to the property — that is, to implement the
> "true" internal property.
> 
> Based on this, it seems impossible to implement an internal property
> without tracking user input in the QOM?

So the main thing that pushes us into using QOM for internal properties
is the machine type compatibility code. eg where we bulk set stuff using

    compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
    compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);

That logic is all QOM based. Using QOM isn't our exclusive approach, as
we have machine types sometimes setting object fields directly. eg

  static void pc_i440fx_machine_7_0_options(MachineClass *m)
  {
    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
    pc_i440fx_machine_7_1_options(m);
    pcmc->enforce_amd_1tb_hole = false;
    compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
    compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
  }

but that only works for properties against the machine type, not compat
properties against devices, since we have no direct access to the other
classes/instances.


If we want to be able to control hardware compat, without exposing
something as a user facing tunable, then internal-only QOM props seems
inescapable.

I do still wonder if we genuinely need internal-only QOM props for
machine type compat ?

Whether using a public 'x-' prefixed property or an internal only
property, we're constrained by the need to retain the behaviour
semantics for as long as the machine type exists. I don't see an
internal only property giving us significantly more freedom here.
We can already rename a 'x-' property however we want with no
notice, as long as the machine type doesn't change behaviour.




> > The idea that code should take different action for a given fixed value,
> > based on whether the value was set by the user, or left on the default,
> > makes me very uncomfortable.
> > 
> > There have been a number of situations where something that was initially 
> > a boolean flag, actually needed to be a tri-state instead, to provide
> > semantics like "On", "Off", "Auto".
> > 
> > This "user set" flag could support such behaviour indirectly, but since
> > "user set" is an internal concept we'd still be only exposing a boolean
> > externally, while using a tri-state internally. That does not give the
> > full flexibility of a tri-state, because internally if we wanted to
> > have the default to be "yes", it offers no way for the mgmt app to
> > put it back to "auto".
> > 
> > For properties that are not booleans, it is much less obvious to me
> > whether we actually need a distinct "not set" concept at all.
> 
> USER_SET primarily serves the INTERNAL and DEPRECATED flags. However,
> its another function is to indicates whether the external user has
> touched the property.
> 
> But, Hmm, I think "auto" and USER_SET don't have conflict?
> 
> IIUC, "auto" means the user requests that QEMU make the decision itself.
> However, just like my patch 19 cleanup of “lbr-fmt”, that property
> explicitly requires users to provide a valid value. Even we have "auto"
> for uint64, "auto" can't address this case.

I just meant "auto" as one possible "default" behaviour where a traditional
boolean was in use, not for all possible types. The right answer for a
default is  contextually dependent.

For a uint64, a default value would involve some  sentinal value, or it
could involve a pair of related properties. For example, we have

  host-phys-bits=on
  phys-bits=NNN

as a pair that work together, so you don't need a magic phys-bits value
to represent "use host value".

> Similarly, the x86 CPU's topology IDs (used for hotplug) - "thread-id"/
> "core-id"/"module-id"..., also require the user to set valid and accurate
> values; they cannot be replaced with "auto".

Again I wasn't suggestnig an "auto" value for every scenario, that was
just an example in a "bool" context. An ID value of "0" is a traditional
default for numeric values, which is fine assuming you don't need to
dinstinguish 0 as a valid value, from 0 as an invalid value needing user
input.

> I also think the ideal situation is not to distinguish between external
> and internal - however, exposing properties to external users makes code
> evolution painful...

I don't think it does. Code evolution is painful as long as the machine
type using the prop needs to exist with fixed semantics, whether it is
internal or public with x- prefix.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


