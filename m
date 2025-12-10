Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC03FD3C52A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 11:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTIk6-0003WR-HW; Wed, 10 Dec 2025 06:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTIk4-0003W5-Uw
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTIk2-0006fo-Se
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 06:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765367541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Vhtzy8GXNP6pd8FFKdH9r/DiZLahJTr3mXXz/Yg9nlc=;
 b=f0eCl6N+QgLph9DsR08ECcNL2Ly1Zjbq6bv1Td6DYmcyca06KRv6F158fLrEdzeC6lEorP
 NyeyDQQ1/lf1pMssjJCddcmL0cyXqVky6kDQ02QsiwpAazvbIVe2E5wIR0XJConi9mHtx7
 8WkdQIl+9/89TFq+KQShq6jCdxDXoRs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-X0ZMWIjtNqa08D3EEGA5BA-1; Wed,
 10 Dec 2025 06:52:17 -0500
X-MC-Unique: X0ZMWIjtNqa08D3EEGA5BA-1
X-Mimecast-MFC-AGG-ID: X0ZMWIjtNqa08D3EEGA5BA_1765367536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EF791956095; Wed, 10 Dec 2025 11:52:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD801956095; Wed, 10 Dec 2025 11:52:07 +0000 (UTC)
Date: Wed, 10 Dec 2025 11:52:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
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
Message-ID: <aTle5C2pN8ZslZX7@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTlZIlgB20OpdSEl@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Dec 10, 2025 at 12:27:30PM +0100, Kevin Wolf wrote:
> Am 09.12.2025 um 17:28 hat Peter Xu geschrieben:
> > [This is an RFC series, as being marked out.  It is trying to collect
> >  opinions.  It's not for merging yet]
> > 
> > Background
> > ==========
> > 
> > It all starts with machine compat properties..
> > 
> > Machine compat properties are the major weapon we use currently in QEMU to
> > define a proper guest ABI, so that whenever we migration a VM instance from
> > whatever QEMU version1 to another QEMU version2, as long as the machine
> > type is the same, logically the ABI is guaranteed, and migration should
> > succeed.  If it didn't, it's a bug.
> > 
> > These compat properties are only attached to qdev for now.  It almost
> > worked.
> > 
> > Said that, it's also not true - we already have non-qdev users of such, by
> > explicitly code it up to apply the compat fields.  Please refer to the
> > first patch commit message for details (meanwhile latter patches will
> > convert them into a generic model).
> > 
> > Obviously, we have demands to leverage machine compat properties even
> > outside of qdev.  It can be a network backend, it can be an object (for
> > example, memory backends), it can be a migration object, and more.
> 
> This doesn't feel obvious to me at all. A machine type defines what
> hardware the guest sees. Guest hardware is essentially qdev.
> 
> I don't see any reasons why a backend should be interested in what guest
> hardware looks like, that would seem like a bad layering violation. Many
> backends can even exist without a guest at all, and are also used in
> tools like qemu-storage-daemon. Having a machine type in a tool that
> doesn't run a guest doesn't make any sense.

The sev-guest compat property for 'legacy-vm-type' is an interesting
example.

This property ultimately controls which of two different kernel ioctls
for KVM are used for initializing the SEV guest. It can casue guest
VM measurement changes, but none the less this is not really a guest
ABI knob, it is a host kernel compatibility knob.  You need a newer
host kernel version if this is set to 'off'.

So by associating this legacy-vm-type type with the machine type,
we don't affect the guest hardware, but we *do* impact the ability
to use that machine type depedning on what kernel version you have.

IOW, QEMU machine types version 9.1 or later are no longer runnable
on many old kernels.

Over the years we've had a good number of occassions where we want
defaults changes, or worse, where we auto-negotiate features, which
depend on host kernel version.

I've suggested in the past that IMHO we're missing a concept of a
"versioned platform", to complement the "versioned machine" concept.

That would let mgmt apps decide what platform compatibility level
they required, independantly of choosing machine types, and so avoid
creating runability constraints on machine types.

> So if we do introduce some mechanism to provide different defaults for
> compatibility with older versions, it has to be separate from machine
> types.
> 
> Maybe it would make most sense to address this on the QAPI level then
> and finally fully QAPIfy the command line. Adding defaults to the QAPI
> schema is something that has come up again and again, so maybe we could
> introduce that and do it in a versioned way from the start.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


