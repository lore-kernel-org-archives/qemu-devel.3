Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A60CD41C09
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTdI6-0008WR-Rh; Thu, 11 Dec 2025 04:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTdI5-0008WI-Jx
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTdI3-0007A4-43
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765446529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMgXW69WnfeZ0yRIze2LSBUQ0JYmeH+uQZhkZU/1Fv0=;
 b=e9Whb61Wp6O+30xGqDu6sPMSgY/obHvZrrz99gbch79bZSmOv52CEwbdFfIwK2JhQ1exVV
 Dcvn37y4/ITpto2Y2axEDVex4n7DE9Gf0MYaUhIhEPvhKqcV5itdLpRXyo+nS8oMBnl3Dw
 Am6O7lB+1j1hJp9PNskmGaM0JW0tQEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-55WFxFi-M5itfX9gHRcI0g-1; Thu,
 11 Dec 2025 04:48:45 -0500
X-MC-Unique: 55WFxFi-M5itfX9gHRcI0g-1
X-Mimecast-MFC-AGG-ID: 55WFxFi-M5itfX9gHRcI0g_1765446524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 206E2180060D; Thu, 11 Dec 2025 09:48:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7205F1953984; Thu, 11 Dec 2025 09:48:35 +0000 (UTC)
Date: Thu, 11 Dec 2025 09:48:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTqTcM9zsGpW-F45@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTmdJ5H67mk8qmSC@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 11:17:43AM -0500, Peter Xu wrote:
> Maybe I emphasized too much on "guest ABI" in the cover letter, so it can
> be confusing when not reading into the details of the patchset (I did
> mention all the existing users in patch 1, then converted all existing
> users in patch 2-5).
> 
> Besides SEV, I can also quickly go over the rest ones if that wasn't clear
> we're already using this feature.. in a open-coded way.  Maybe that'll make
> it slightly easier to grasp for reviewers.
> 
> The current use case for hostmem (2nd example) on compat properties, see:
> 
>     commit fa0cb34d2210cc749b9a70db99bb41c56ad20831
>     Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>     Date:   Wed Sep 12 16:18:00 2018 +0400
> 
>     hostmem: use object id for memory region name with >= 4.0
> 
> So that's not strictly "guest ABI", but the goal was to persist the name of
> MRs so that migration is not broken.  It's not strictly "guest ABI" but
> more like "guest ABI for migration" - even if the guest OS cannot see the
> names of MRs, migration can see (via ramblocks).  So it can be more than
> the guest HWs.

I'm more amenable to this example being in scope of machine types. The
most important use case for machine types, by a mile, is to ensure that
live migration works between 2 QEMUs. Having a stable guest ABI does
have other use cases like ensuring Windows doesn't trigger license
(re-)activation, but live migration is the important one. It is
unfortunate that the object id leaked into the migration stream but
this was a reasonable (hack) workaround to address it.


> 3rd example in accel:
> 
>     commit fe174132478b4e7b0086f2305a511fd94c9aca8b
>     Author: Paolo Bonzini <pbonzini@redhat.com>
>     Date:   Wed Nov 13 15:16:44 2019 +0100
> 
>     tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
> 
> That was trying to keep some old behavior for accel cmdlines.  It's not
> even a migration ABI, but cmdline ABI.
>
> Hence OBJECT_COMPAT might be useful whenever we want to persist some ABI.
> It can be machine compat properties, it can be something else that has
> nothing to do with machine types.  The accel example used a separate entry
> in object_compat_props[] (index 0) for the same purpose, out of three:

Ok, yes, this compat props usage that's independent of machine
type is fine.

> 
> /*
>  * Global property defaults
>  * Slot 0: accelerator's global property defaults
>  * Slot 1: machine's global property defaults
>  * Slot 2: global properties from legacy command line option
>  * Each is a GPtrArray of GlobalProperty.
>  * Applied in order, later entries override earlier ones.
>  */
> static GPtrArray *object_compat_props[3];

> > I've suggested in the past that IMHO we're missing a concept of a
> > "versioned platform", to complement the "versioned machine" concept.
> > 
> > That would let mgmt apps decide what platform compatibility level
> > they required, independantly of choosing machine types, and so avoid
> > creating runability constraints on machine types.
> 
> Yes, I agree some kind of "versioned platform" would be nice.  In practise,
> I wonder if it needs to be versioned at all, or something like a
> query-platform QMP API that will return the capabilities of the host in
> QEMU's view.  Maybe versioning isn't needed here.
> 
> Taking USO* feature for virtio-net as example, it should report what kind
> of USO* features are supported on this host.

The appealing thing about machine types is that it is an opaque
collection of properties. The mgmt app does not need to know about
any of the properties being set, it can just let the machine type
do its magic.

Probing values for individual features which are supported on a host
means mgmt apps need to be made aware of all the properties that are
affected, and keep track of them for the life of the VM. This is a
significantly higher burden for the mgmt app to deal with that the
opaque collection machine types define, especially because apps won't
know ahead of time which objects/properties might need this facility
in future.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


