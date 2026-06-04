Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90116CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV3Ht-0006T2-SL; Thu, 04 Jun 2026 04:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV3Hp-0006SV-GJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV3Hm-0002da-WC
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780561119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbUQ8XEVFls/F0FVjl04klnmXCcEvGbRPy/2ONr5eGg=;
 b=CcDY4SNr4HvpeT087PPnGzc6jmNe2sKBFrpLz3iP/4XADULtCiyrSLVKn2lY27hVUyfYU/
 9mjJhGUS+2rkgJcsf8YDFxGcvTx+FZ3hMfmGYp7Qt3813w6bvIHQKBrwFxUOpEutjx5Rp5
 KgpleDPPWK38NJpiIWpUxwTN1I3RP10=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-reBsLNRrO8ufoQt6I8AUzw-1; Thu,
 04 Jun 2026 04:18:36 -0400
X-MC-Unique: reBsLNRrO8ufoQt6I8AUzw-1
X-Mimecast-MFC-AGG-ID: reBsLNRrO8ufoQt6I8AUzw_1780561115
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53B21956053; Thu,  4 Jun 2026 08:18:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AC141955BC0; Thu,  4 Jun 2026 08:18:29 +0000 (UTC)
Date: Thu, 4 Jun 2026 09:18:26 +0100
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
Message-ID: <aiE00jn-z-o_WlRo@redhat.com>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com> <aiB2nA5bmtBRWras@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiB2nA5bmtBRWras@x1.local>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Jun 03, 2026 at 02:46:52PM -0400, Peter Xu wrote:
> On Wed, Jun 03, 2026 at 07:00:07PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Jun 03, 2026 at 02:51:30PM -0300, Fabiano Rosas wrote:
> > > Daniel P. Berrangé <berrange@redhat.com> writes:
> > > 
> > > > In that case they should definitely be independent command line
> > > > options. The old "-incoming" design is already broken / limited
> > > > in the non-'defer' case because it is hardcoded to use URI syntax
> > > > which can't express all the address formats we accept in QAPI
> > > > syntax. Adding more special cases onto -incoming just makes the
> > > > bad situation even worse and is not a forward looking design.
> > > >
> > > > If we need the ability to specify migration parameters on the
> > > > CLI, then as a starting point for the design, we should assume that
> > > > -incoming does not exist, and design a complete solution from scratch
> > > > that uses QAPI exclusively, both for addresses and configuration.
> > > >
> > > > As discussed before, IMHO the "migrate" and "migrate-incoming"
> > > > commands need to accept both the address(s) and parameters/capabilities
> > > > as inline data items rather than relying on pre-configured global state
> > > > from the 'migrate-parameter' / 'migrate-capability' commands.
> > > >
> > > > If we did that modelling for 'migrate-incoming' then that modelling of
> > > > command parmaeters could map directly to a new '-migrate-incoming'
> > > > command line argument that accepted exactly the same data model.
> > > >
> > > 
> > > Maybe a user creatable object would better fit this use case instead of
> > > a new command. We could expose what is today MigrationParameters plus
> > > the few compat options from migration_properties. It could work more or
> > > less the same for the QMP migration commands, QMP set/get commands,
> > > source and destination command lines, the compatibility use-case and the
> > > debugging use-case.
> > 
> > If we can do something using "-object" that is useful both at command
> > line time and in QMP runtime, then that would be interesting too.
> > 
> > My general feeling wrt changes to the current command line is that
> > any suggestion should be desgined with a nod towards a future scenario
> > where QEMU is 100% configured with QMP. ie the full command line is
> > 
> >    qemu-system-x86_64 -qmp <address>
> > 
> > In this world, the current -incoming argument is already largely
> > unsatisfactory for anything other than "defer".  A model that uses
> > -object would fit in well, as would a hypothetical -migrate-incoming
> > that directly mapped to 'migrate-incoming' QMP including capabilities
> > and parameters.
> 
> I don't think even the current -incoming config:* is a blocker or add too
> much complexity to the full-QMP-based solution.
> 
> When it comes, we can simply map all -incoming config:* (JSON or not) to
> QMP command migrate-set-parameters, what we need is teaching that QMP
> handler to apply parameters to the temporary MigrationParameters rather
> than migration object when the latter hasn't been initialized.
> 
> I was talking to Fabiano and he suggested me to mention one more thing I
> said on the list.  It's a matter of whether we should still invest time on
> supporting migration caps/parameters in QMP migrate/migrate-incoming
> commands.
> 
> Requirements like this (allow migration parameters to be accessible during
> early stage of QEMU) is going towards the other direction of the that idea.
> That means even if we put all configs (caps/params) into QMP command
> migrate[-incoming], libvirt will still need to manage these global setup
> and making sure when invoking migrate[-incoming] QMP commands they match
> with the globals.  Say, if one start QEMU with -incoming config:local=on
> but then invoke "migrate-incoming,local=off" it's illegal.
> 
> Considering that it looks like there're solid use cases that we want to
> support (after CPR's "mode" parameter, now "local"), I want to discuss
> again whether we want to still spend effort supporting "allow migrate QMP
> command to specify capabilities/parameters".  Ultimately, we still seem to
> need these global parameters.

This is saying that incoming migration is a multi phase/stage task.

There is a "prepare" phase which sets up QEMU ready to receive an
incoming migration.

There is a "running" phase where we are waiting for incoming connection
and/or handling the migration data stream.

The current "migrate_incoming" overloads both tasks into the same QMP
command such that they always happen at the same point in time.
"-incoming defer" was a crude hack to partially separate them, allowing
parameters/capabilities to be set before the real migrate_incoming
QMP command is invoked.

We can address that by separating the tasks explicitly with a
"migrate_prepare" command / -migrate-prepare CLI arg that sets all
the parameters/capabilities atomically, and a "migrate_run" command
that initiates the processing.

The "jobs" QAPI design has this explicit concept of different phases
that a job can be in, and provides commands for lifecycle handling.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


