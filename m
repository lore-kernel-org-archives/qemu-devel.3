Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0B9CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUptB-0003vK-9N; Wed, 03 Jun 2026 14:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUptA-0003v7-7l
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUpt7-0003q8-K8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780509620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+FuTOR9j62DEgDMUr7OIxQWH0JCq+35t/TfTNWJW1Q=;
 b=IbskmlbMraoeW+lE5b5AYRewkres8rcpzuzpT/C9Npj5U0+yMMDnV/F2VedN6nEQBsBQUO
 ntrFBv8MwmIA2qsv/gcdxs5eZrNt5WI3mBJ+sk0kaUgs4qoxPm0xwgkzufcZum33ITBHim
 hlnNPih728F87m52vyKaogp2xn7AsHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-U8t9l8HMNRigmA4wTJHPnw-1; Wed,
 03 Jun 2026 14:00:18 -0400
X-MC-Unique: U8t9l8HMNRigmA4wTJHPnw-1
X-Mimecast-MFC-AGG-ID: U8t9l8HMNRigmA4wTJHPnw_1780509615
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FCB219560A3; Wed,  3 Jun 2026 18:00:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF11B30001A1; Wed,  3 Jun 2026 18:00:10 +0000 (UTC)
Date: Wed, 3 Jun 2026 19:00:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiBrp1UJZjmC1aI1@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6hr7brx.fsf@suse.de>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, Jun 03, 2026 at 02:51:30PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > In that case they should definitely be independent command line
> > options. The old "-incoming" design is already broken / limited
> > in the non-'defer' case because it is hardcoded to use URI syntax
> > which can't express all the address formats we accept in QAPI
> > syntax. Adding more special cases onto -incoming just makes the
> > bad situation even worse and is not a forward looking design.
> >
> > If we need the ability to specify migration parameters on the
> > CLI, then as a starting point for the design, we should assume that
> > -incoming does not exist, and design a complete solution from scratch
> > that uses QAPI exclusively, both for addresses and configuration.
> >
> > As discussed before, IMHO the "migrate" and "migrate-incoming"
> > commands need to accept both the address(s) and parameters/capabilities
> > as inline data items rather than relying on pre-configured global state
> > from the 'migrate-parameter' / 'migrate-capability' commands.
> >
> > If we did that modelling for 'migrate-incoming' then that modelling of
> > command parmaeters could map directly to a new '-migrate-incoming'
> > command line argument that accepted exactly the same data model.
> >
> 
> Maybe a user creatable object would better fit this use case instead of
> a new command. We could expose what is today MigrationParameters plus
> the few compat options from migration_properties. It could work more or
> less the same for the QMP migration commands, QMP set/get commands,
> source and destination command lines, the compatibility use-case and the
> debugging use-case.

If we can do something using "-object" that is useful both at command
line time and in QMP runtime, then that would be interesting too.

My general feeling wrt changes to the current command line is that
any suggestion should be desgined with a nod towards a future scenario
where QEMU is 100% configured with QMP. ie the full command line is

   qemu-system-x86_64 -qmp <address>

In this world, the current -incoming argument is already largely
unsatisfactory for anything other than "defer".  A model that uses
-object would fit in well, as would a hypothetical -migrate-incoming
that directly mapped to 'migrate-incoming' QMP including capabilities
and parameters.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


