Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B8108B8EA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Wo1-0003Dd-1t; Fri, 20 Mar 2026 06:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Wny-0003D4-NK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Wnt-0004LF-SC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774001403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5/6Gzlc4l2GMtH9GlSHy8lR/1yM0z9Lby0gWXF4vB4=;
 b=YHzo4jjEoSD7e8S4vbCR5O32A06BOsEUJLQyVGGNrZX8cCKjg/csnuZha8sMgCL3vxr3Ak
 af92lt7EQFAgSEeiALof3eTC1KuKLK45oUpwf1XaNn2swDugXQyR7NoweWT0k6TPGbtUve
 KRzRbkFZNUZsYP1zGjQhC2vH9uXPi1s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-LkXKkK65Mo2cDyeLn33iTw-1; Fri,
 20 Mar 2026 06:09:59 -0400
X-MC-Unique: LkXKkK65Mo2cDyeLn33iTw-1
X-Mimecast-MFC-AGG-ID: LkXKkK65Mo2cDyeLn33iTw_1774001397
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8988F1800610; Fri, 20 Mar 2026 10:09:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D31E1953944; Fri, 20 Mar 2026 10:09:50 +0000 (UTC)
Date: Fri, 20 Mar 2026 10:09:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
 devel@lists.libvirt.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <ab0c6rA4RhjasILy@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
 <87tsufpyo5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsufpyo5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 16, 2026 at 04:43:54PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Mar 11, 2026 at 02:05:24PM +0100, Markus Armbruster wrote:
> >> I can't find a good spot in the existing discussion where the following
> >> would fit neatly as a reply, so I'm starting at the top again.
> >> 
> >> Fact: a huge part of our external interface is *accidental* and
> >> virtually undocumented.
> >> 
> >> The sane way to do an external interface is to layer it on top of more
> >> powerful internal interfaces.  The external interface exposes just the
> >> functionality that's wanted there.  The internal interfaces can evolve
> >> without affecting the external one.
> >> 
> >> QMP works that way.  QEMU code uses internal C interfaces.  QEMU doesn't
> >> send QMP commands to itself.  If we need something internally, we add it
> >> to a suitable internal interface.  There's no need to add it to the
> >> external interface just for that.
> >> 
> >> QOM does not work that way.  The internal and the external object
> >> configuration interface is one and the same.  So, if we add a property
> >> for internal use, we can't *not* add it to the external interface.
> >> 
> >> This has led to an external interface that is frickin' huge: I count
> >> ~1000 device types with ~16000 properties in qemu-system-aarch64 alone.
> >> The vast majority is undocumented.
> >> 
> >> Time and again we've found ourselves unsure whether certain properties
> >> have external uses, or are even meant for external use.
> >> 
> >> We have been unable / unwilling to isolate the external interface from
> >> internal detail.  This is madness.
> >> 
> >> As long as we persist in this madness, a sane, properly documented
> >> external interface will remain impossible.
> >> 
> >> Do we care?  If yes, we should discuss how to isolate external and
> >> internal interfaces.
> >> 
> >> This series attempts to create a bit of infrastructure for such
> >> isolation: means to mark properties as internal.  Is it the right
> >> infrastructure?  Is it enough to be a useful step?  Maybe not, but then
> >> I'd like to hear better ideas.
> >
> > For -object / object_add  we introduced formal QAPI modelling of
> > all Object subclasses which implement the UserCreatable interface.
> > IIUC, that gives us the desired separation between internal and
> > external views, as only properties declared in qapi/qom.json are
> > publically settable.
> 
> Correct.  Kevin Wolf's work.
>
> > This work did not apply to the Device classes because the historical
> > baggage with qdev being grafted onto qom, means we don't have that
> > working via the UserCreatable inteface or -object/object_add.
> >
> > Can we bring Device into the same world though ?
> 
> Kevin Wolf took a stab at it.  I had a hard time understanding it back
> then.  Various pennies finally dropped when he patiently explained it to
> me in person.  I disliked certain aspects of its design, and wanted to
> explore a bit more.  Never found the time.  Perhaps we should just take
> it despite my design misgivings.

Yep, I vaguely recall that, but never had a chance to look at it
at the time.

> 
> > Adding 1000 device types to QAPI is a huge job, so it would need to
> > be a long incremental job, unless perhaps we auto-generate QAPI
> > descriptions for everything that already exists ?
> 
> Interesting idea.
> 
> QAPI is declarative: types and their properties are declared in a
> schema.
> 
> QOM is imperative: we execute C code to create types and their
> properties.
> 
> Extracting a QAPI schema from the C code is impossible in the completely
> general case (halting problem), and merely impractical (I believe) in
> the special cases we have.
> 
> We could start with QOM introspection instead: qom-list-types and
> qom-list-properties.  These are only mostly complete, but should be good
> enough.
> 
> Mapping QOM types to QAPI types would involve guesswork, because QOM
> doesn't have a type system, it has strings and bailing wire.
> 
> Schema documentation would be placeholders at best.  We could try to
> extract documentation from -device T,help.  Most properties have nothing
> there, and the remainder likely needs to be rewritten completely to be
> fit for purpose.

Yep, in case it wasn't obvious, when I said "auto-generate QAPI
descriptions", I meant generate the skeleton of the QAPI json
structure with whatever partial data we have, and a human would
then have to fill in the blanks to bring it upto par with QAPI
expectations. The docs descriptions do seem like a big part
of the manual work that would be involved here.


Perhaps another oddity is the distinction between devices which
can actually be created with -device, vs devices that are only
internally created but can none the less be set via -global.
I presume we would need to expose all devices in QAPI, regardless
of being user creatable or not.

> 
> > More generally anything we can do to bring qdev & qom closer together
> > feels desirable. I dream of a future where -device/device_add are
> > obsolete....
> 
> That would be lovely.
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


