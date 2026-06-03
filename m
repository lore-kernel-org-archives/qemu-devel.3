Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7447CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpCV-00005W-1n; Wed, 03 Jun 2026 13:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUpCR-0008W4-MA
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUpCP-0006Bm-4h
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780506971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+bq0CaMYt7tHmdYI9bIrzKoRjv74q4Q1koF9CvivuU=;
 b=FwEc6bIdV7Qg49WVipN8wY5USr7ykIS+8/FUioDzUbZWqTgVslhwqQRSX9f8zMGd4fqo+O
 Cb3jXAI9bHtVyFJBIfM3L5EPXUg4bVInghdUPZo4hQ8r5C7KWYjMFVC0JN5WgazBj7agXU
 ccPHadcHOogZ9DS8NgTu6dJrsbPpLk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-jc_0t80CMb2XowCdWLp6KQ-1; Wed,
 03 Jun 2026 13:16:07 -0400
X-MC-Unique: jc_0t80CMb2XowCdWLp6KQ-1
X-Mimecast-MFC-AGG-ID: jc_0t80CMb2XowCdWLp6KQ_1780506966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 074771800345; Wed,  3 Jun 2026 17:16:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9087E30001A1; Wed,  3 Jun 2026 17:16:01 +0000 (UTC)
Date: Wed, 3 Jun 2026 18:15:57 +0100
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
Message-ID: <aiBhTTqSctU9lFsS@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiBNXUU0xcT_UbKO@x1.local>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, Jun 03, 2026 at 11:50:53AM -0400, Peter Xu wrote:
> On Wed, Jun 03, 2026 at 10:48:54AM +0100, Daniel P. Berrangé wrote:
> > On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
> > > On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
> > > > Peter Xu <peterx@redhat.com> writes:
> > > > 
> > > > > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
> > > > >
> > > > > This series introduces a generic way to specify migration parameters that
> > > > > can be used even during the early boot phase of QEMU.
> > > > >
> > > > > One example use case that already existed is CPR-transfer / CPR-exec.
> > > > > currently QEMU has a temporary global variable (incoming_mode) to achieve
> > > > > this, but it's hard to understand and this hack bleeded into quite a few
> > > > > places that we could have avoided.  The lines in patch 2 touched may
> > > > > provide some idea.
> > > > >
> > > > > With a generic approach of setting migration parameters with cmdlines, we
> > > > > can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> > > > > as before.  To CPR maintainers and reviewers: please have a closer look,
> > > > > even better if it can be smoke tested, to see if this works for Oracle's
> > > > > environment, TIA.
> > > > >
> > > > > The 1st patch implemented that new semantics.  It is straightforward: now
> > > > > we can setup any migration parameter using an extra line of:
> > > > >
> > > > >   -incoming config:key1=value1,key2=value2,...

snip

> > > > - using "config:"
> > > > 
> > > > This makes it non-uniform with uri and channels which don't have a
> > > > keyword in front of them. I guess I could live with it, but it seems
> > > > odd. I see that it makes parsing way easier.
> > > 
> > > Yeah, having some identifier would be nice.  I wished channels also have
> > > identifiers if we don't need to keep compatibility.
> > 
> > IMHO having a magic "config:" prefix is an anti-pattern because it
> > involves custom command line parsing logic.
> 
> Yes, it's not elegant.  I wished we had something like this though when
> introducing the cpr channels; right now anything wasn't "defer" or URI
> implies it's a "channel"..
> 
> I also wanted to avoid introducing new cmdline parameters, so migration
> incoming cmdlines can stick with the same option.  If there's better
> suggestion please shoot.
> 
> > 
> > Does "-incoming config" imply '-incoming defer' semantics or is it
> > independent ?  
> 
> They're independent.  Examples:
> 
>  a) "-incoming config:* -incoming tcp:*", setup parameters for TCP incoming
>     migration without further deferral
> 
>  b) "-incoming config:*" only, setup global parameters for a possible
>     upcoming outgoing migration

In that case they should definitely be independent command line
options. The old "-incoming" design is already broken / limited
in the non-'defer' case because it is hardcoded to use URI syntax
which can't express all the address formats we accept in QAPI
syntax. Adding more special cases onto -incoming just makes the
bad situation even worse and is not a forward looking design.

If we need the ability to specify migration parameters on the
CLI, then as a starting point for the design, we should assume that
-incoming does not exist, and design a complete solution from scratch
that uses QAPI exclusively, both for addresses and configuration.

As discussed before, IMHO the "migrate" and "migrate-incoming"
commands need to accept both the address(s) and parameters/capabilities
as inline data items rather than relying on pre-configured global state
from the 'migrate-parameter' / 'migrate-capability' commands.

If we did that modelling for 'migrate-incoming' then that modelling of
command parmaeters could map directly to a new '-migrate-incoming'
command line argument that accepted exactly the same data model.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


