Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C0CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUiDr-0001HZ-DH; Wed, 03 Jun 2026 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUiDn-0001Eo-Bn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUiDk-0007IJ-V9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780480148;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8prmQhO7B0BFBbtF40Zkp/DeFSN1F0XTB83PqnOZcU0=;
 b=dm6enNBh1RyIMGlSb2R303tqMaLuEpitD6z/7MAotkl+a3UUiomX9OjRCxo2nM1XHC1vWE
 XfbZkwHaESXrFutfmbm73En7/3mrdqaPsGAkAufYXLVY2USN76+5vByoAf8PQHZdpiv7+u
 l48UlCq7i2F/Cl+mGdlQOh2PqSSixBk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-k-zW2pg0P4G9bTabsrnofw-1; Wed,
 03 Jun 2026 05:49:04 -0400
X-MC-Unique: k-zW2pg0P4G9bTabsrnofw-1
X-Mimecast-MFC-AGG-ID: k-zW2pg0P4G9bTabsrnofw_1780480143
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5441956080; Wed,  3 Jun 2026 09:49:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BCCE180049F; Wed,  3 Jun 2026 09:48:58 +0000 (UTC)
Date: Wed, 3 Jun 2026 10:48:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <ah_4hixGcNv-CLfv@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahmfh2s7CLFLoZKN@x1.local>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
> On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
> > >
> > > This series introduces a generic way to specify migration parameters that
> > > can be used even during the early boot phase of QEMU.
> > >
> > > One example use case that already existed is CPR-transfer / CPR-exec.
> > > currently QEMU has a temporary global variable (incoming_mode) to achieve
> > > this, but it's hard to understand and this hack bleeded into quite a few
> > > places that we could have avoided.  The lines in patch 2 touched may
> > > provide some idea.
> > >
> > > With a generic approach of setting migration parameters with cmdlines, we
> > > can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> > > as before.  To CPR maintainers and reviewers: please have a closer look,
> > > even better if it can be smoke tested, to see if this works for Oracle's
> > > environment, TIA.
> > >
> > > The 1st patch implemented that new semantics.  It is straightforward: now
> > > we can setup any migration parameter using an extra line of:
> > >
> > >   -incoming config:key1=value1,key2=value2,...
> > 
> > Just merge my code mate.
> > https://lore.kernel.org/r/20251215220041.12657-25-farosas@suse.de
> 
> Heh, I apologize. I totally forgot it even if I seem to have read it..
> 
> The goal is differnent, though, which is to make it available before
> migration object initialization.  Say, I wished -global would work too but
> it doesn't, and it just can't.  So it's not "something good to have"
> anymore, but functionally required for either CPR and TAP in the future if
> we adopt this, they'll all read them early.
> 
> > 
> > A couple of differences from my patch:
> > 
> > - old-style keyval vs. json;
> > 
> > Isn't json preferred nowadays?
> 
> I didn't mention it in doc, but yeah this series also supports JSON due to
> the same qapi helper used.  I don't suggest json though for this entry (and
> that's also why I didn't mention it..) because 99% of migration parameters
> are scalars and I don't see why we should use JSON here.. the only one not
> scalar is block-bitmap-mapping but it's not intended to be used in
> -incoming at all (even if it'll work..).

99% of **todays** parameters are scalars.

The reason we are actively moving to CLI args which are modelled with QAPI
and expressable using JSON is because that future proofs the command line
for any kind of parameters we might need.

We should actively document and promote the use of JSON.

> > - using "config:"
> > 
> > This makes it non-uniform with uri and channels which don't have a
> > keyword in front of them. I guess I could live with it, but it seems
> > odd. I see that it makes parsing way easier.
> 
> Yeah, having some identifier would be nice.  I wished channels also have
> identifiers if we don't need to keep compatibility.

IMHO having a magic "config:" prefix is an anti-pattern because it
involves custom command line parsing logic.

Does "-incoming config" imply '-incoming defer' semantics or is it
independent ?  



> 
> > 
> > >
> > > So far only one such instance is allowed for simplicity, but it should be
> > > enough.  We still allow multiple -incoming for specifying channels, used
> > > together with one "-incoming config:*".
> > >
> > > Then parameters set this way will be visible almost anytime for QEMU, for
> > > example, during initialization of device backends (which is before
> > > migration object created).
> > >
> > > I posted this series majorly because I want to see if this will make a
> > > possible new user for the new "local" migration parameter proposed in
> > > Vladimir's series:
> > >
> > >   https://lore.kernel.org/r/20260522120534.77653-1-vsementsov@yandex-team.ru
> > >
> > > Especially, there're some context on this idea too in this email:
> > >
> > >   https://lore.kernel.org/all/ahdI7Vl5KraK566D@x1.local/
> > >
> > 
> > I like the idea overall.
> > 
> > > With this series, we should be able to drop "incoming-fds" TAP property
> > > from the other series, instead relying on the existing "local" parameters
> > > both in migration core and in TAP's property should suffice.
> > >
> > > One thing to mention is I didn't further make only-migratable into a
> > > migration parameter.  Logically it will also work now with only-migratable,
> > > but it then also means I'll need to convert it to a parameter, which will
> > > be mutable even after VM started.  It will change how only-migratable used
> > > to work, hence I skipped.
> > >
> > > After this, we also almost have no reason to use -global for migration
> > > parameters.  Capabilities are still not supported in -incoming cmdline,
> > > though.
> > >
> > 
> > Will we still merge capabilities and parameters? Then it would be a free
> > upgrade.
> 
> Yes!  /me waiting for your patches.
> 
> -- 
> Peter Xu
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


