Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D68FCD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgaQ-0006vo-Es; Thu, 11 Jun 2026 10:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXgaP-0006vQ-2N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXgaN-0004ml-3Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781188845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEMuqITMRnonbxZfVVuHpn72mlrZTUq47IZKLZXnhwM=;
 b=cJwvOk45vt7/0OMc0skwuvQlHOPS/ESjPBkRZkxmhxs3KbBnLnwJg1qsaj0iLORirpD8yB
 xTxQHEeP4I1DysiyBjqkETFVDKoCbN+GIzGPlbGA3mxCKf6uBevCatFtEY8wqXT9n2Va0D
 TvXUD0cuzLF3hHQZWyL/Js17us5dhQA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Q-owXLSvOq-mZDY45WX6Zw-1; Thu,
 11 Jun 2026 10:40:42 -0400
X-MC-Unique: Q-owXLSvOq-mZDY45WX6Zw-1
X-Mimecast-MFC-AGG-ID: Q-owXLSvOq-mZDY45WX6Zw_1781188840
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABFA6180A8EB; Thu, 11 Jun 2026 14:40:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9FE51955BE0; Thu, 11 Jun 2026 14:40:32 +0000 (UTC)
Date: Thu, 11 Jun 2026 15:40:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Message-ID: <airI3UKeVVRUdQHq@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
 <aimNv51iMZ_yEgDG@redhat.com> <aimvTYDsv_-Xsboy@x1.local>
 <aiq9g60bOnvsOQOy@redhat.com> <87h5n94001.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5n94001.fsf@suse.de>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 11:36:46AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jun 10, 2026 at 02:39:09PM -0400, Peter Xu wrote:
> >> On Wed, Jun 10, 2026 at 05:15:59PM +0100, Daniel P. Berrangé wrote:
> >> > On Tue, Jun 09, 2026 at 01:25:09PM -0400, Peter Xu wrote:
> >> > > Create object-property-ptr.[ch] files to include all the helpers for
> >> > > object_property_add*_ptr().
> >> > > 
> >> > > These set of helpers are handy because they look extremely familiar with
> >> > > qdev-properties, allowing the caller to provide a pointer and it will
> >> > > manage all the setters and getters.
> >> > > 
> >> > > The follow up patches may introduce more of such helpers.  Since object.c
> >> > > has been already too big, split that part out.
> >> > 
> >> > The "ptr" helpers are all instance level properties which is a concept
> >> > we discourage from new usage, in favour of class level properties.
> >> > 
> >> > I don't think we should be adding more "ptr" helpers, but rather
> >> > planning to eliminiate the (surprisingly little) usage of the
> >> > existing ones.
> >> 
> >> The other way to do similar thing is qdev's offset way, but IMHO that's
> >> more awkward to remember an offset of a pointer then do math everytime.
> >> Essentially, from technical pov we need at least one uintptr_t to store
> >> either (1) offset, or (2) field pointer when there's a field that is bound
> >> to a prop.  IMHO (2) can be better otherwise we'll need to do all the maths
> >> to calculate offsets then when access we add the offset back and do a force
> >> cast.  It seems not necessary.
> >
> > There shouldn't be any need to play with field offsets either. Just
> > define the setters & getters to directly access the fields.
> >
> > Take some samples from the "machine_class_init" in hw/core/machine.c
> > as an example of the normal design pattern:
> >
> >     object_class_property_add_str(oc, "dumpdtb",
> >         machine_get_dumpdtb, machine_set_dumpdtb);
> >     object_class_property_set_description(oc, "dumpdtb",
> >         "Dump current dtb to a file and quit");
> >
> >    ..snip..
> >
> >     object_class_property_add_bool(oc, "dump-guest-core",
> >         machine_get_dump_guest_core, machine_set_dump_guest_core);
> >     object_class_property_set_description(oc, "dump-guest-core",
> >         "Include guest memory in a core dump");
> >
> > These are paired with:
> >
> >   static char *machine_get_dumpdtb(Object *obj, Error **errp)
> >   {
> >       MachineState *ms = MACHINE(obj);
> >
> >       return g_strdup(ms->dumpdtb);
> >   }
> >
> >   static void machine_set_dumpdtb(Object *obj, const char *value, Error **errp)
> >   {
> >       MachineState *ms = MACHINE(obj);
> >
> >       g_free(ms->dumpdtb);
> >       ms->dumpdtb = g_strdup(value);
> >   }
> >
> > and
> >
> >   static bool machine_get_dump_guest_core(Object *obj, Error **errp)
> >   {
> >       MachineState *ms = MACHINE(obj);
> >
> >       return ms->dump_guest_core;
> >   }
> >
> >   static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
> >   {
> >       MachineState *ms = MACHINE(obj);
> >
> >       if (!value && QEMU_MADV_DONTDUMP == QEMU_MADV_INVALID) {
> >           error_setg(errp, "Dumping guest memory cannot be disabled on this host");
> >           return;
> >       }
> >       ms->dump_guest_core = value;
> >   }
> >
> >
> > and defaults (if needed) are set in  the instance init method:
> >
> >   static void machine_initfn(Object *obj)
> >   {
> >       MachineState *ms = MACHINE(obj);
> >       MachineClass *mc = MACHINE_GET_CLASS(obj);
> >
> >       ms->dump_guest_core = true;
> >       ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
> >       ...
> >   }
> >
> 
> Thanks for the practical example. In this usage, do you think there
> would be a way to avoid having 53 getters and setters? We often run into
> this issue of the rest of QEMU having just a handful of options and
> migration having a ton. Anything we can do to streamline this would be
> good.

There's nothing standard in QOM, but in patch 10 in this series
Peter has a DEFINE_TLS_PROP_HELPERS() which macro-ized the
repetitive getters/setters for the TLS string properties. The
duplicate code still exists in the binary of course, just hidden
from the source.


> >> Is there any pointer I can read about the discussion previously on this?
> >
> > I don't know that there's a particular thread in recent times
> > that I'd point to, just my ancient series from when I introduced
> > class properties for QOM back in 2015 and started the effort to
> > convert away from instances properties.
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2015-08/msg03112.html
> >
> 
> Anything we can do to avoid stumbling into this again? Should we add
> some words to object_property_add() discouraging instance properties?

Yeah, it is probably worth adding some guidance to the docs there.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


