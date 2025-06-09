Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E15FC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOf7c-0005uj-FN; Mon, 09 Jun 2025 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOf7b-0005uV-25
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOf7Y-0003Yz-OK
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NB8XkSMKTZYaq07pbA9uNpsI/DUKVEqCUQsO1Xw9X1Y=;
 b=WQwDzDz/xZ2GTuQZoYOSiVAyi69AJ6YwSdjgNOk4UA0TfOsrOCYgRBwimC1tRbleE7r4Pg
 ZraBda8FzSxryqPQK5MJ8LMAtA5QAVPq1TPJHEsK0XdFspKMdbdR+RguYCiNT79tDhypGI
 G1H0LQJeYa58X+xgWdoiExjsqWSCuoU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-lq27zrGUMdObL-tmHYh9Pw-1; Mon,
 09 Jun 2025 12:13:08 -0400
X-MC-Unique: lq27zrGUMdObL-tmHYh9Pw-1
X-Mimecast-MFC-AGG-ID: lq27zrGUMdObL-tmHYh9Pw_1749485587
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D88C1956096; Mon,  9 Jun 2025 16:13:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2830F18003FC; Mon,  9 Jun 2025 16:13:04 +0000 (UTC)
Date: Mon, 9 Jun 2025 17:13:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcIDNpXJHGAhwmK@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <87y0u1ugkx.fsf@suse.de>
 <aEcC9X5i6eV4N7An@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEcC9X5i6eV4N7An@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 09, 2025 at 11:51:17AM -0400, Peter Xu wrote:
> On Mon, Jun 09, 2025 at 11:37:02AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> > >> Peter Xu <peterx@redhat.com> writes:
> > >> 
> > >> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> > >> >> Allow the migrate and migrate_incoming commands to pass the migration
> > >> >> configuration options all at once, dispensing the use of
> > >> >> migrate-set-parameters and migrate-set-capabilities.
> > >> >> 
> > >> >> The motivation of this is to simplify the interface with the
> > >> >> management layer and avoid the usage of several command invocations to
> > >> >> configure a migration. It also avoids stale parameters from a previous
> > >> >> migration to influence the current migration.
> > >> >> 
> > >> >> The options that are changed during the migration can still be set
> > >> >> with the existing commands.
> > >> >> 
> > >> >> The order of precedence is:
> > >> >> 
> > >> >> 'config' argument > -global cmdline > defaults (migration_properties)
> > >> >
> > >> > Could we still keep the QMP migrate-set-parameters values?
> > >> >
> > >> >   'config' argument > QMP setups using migrate-set-parameters >
> > >> >     -global cmdline > defaults (migration_properties)
> > >> >
> > >> 
> > >> That's the case. I failed to mention it in the commit message. IOW it
> > >> behaves just like today, but the new 'config' way takes precedence over
> > >> all.
> > >
> > > Referring to below chunk of code:
> > >
> > > [...]
> > >
> > >> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> > >> >> +                             Error **errp)
> > >> >> +{
> > >> >> +    ERRP_GUARD();
> > >> >> +
> > >> >> +    assert(bql_locked());
> > >> >> +
> > >> >> +    /* reset to default parameters */
> > >> >> +    migrate_params_apply(&s->defaults);
> > >
> > > IIUC here it'll reset all global parameters using the initial defaults
> > > first, then apply the "config" specified in "migrate" QMP command?
> > >
> > 
> > Yes, this is so any previously set parameter via migrate-set-parameter
> > gets erased. I think what we want (but feel free to disagree) is to have
> > the migrate-set-parameter _eventually_ only handle parameters that need
> > to be modifed during migration runtime. Anything else can be done via
> > passing config to qmp_migrate.
> > 
> > For -global, I don't have a preference. Having -global take precedence
> > over all would require a way to know which options were present in the
> > command-line and which are just the defaults seet in
> > migration_properties. I currently don't know how to do that. If it is at
> > all possible (within reason) we could make the change, no worries.
> > 
> > > I think there're actually two separate questions to be asked, to make it
> > > clearer, they are:
> > 
> > Here it got ambiguous when you say "global", I've been using -global to
> > refer to the cmdline -global migration.foo, but others have used global
> > to mean s->parameters (which has an extended lifetime). Could you
> > clarify?
> 
> I meant the -global, and the global setups via migrate-set-parameters.
> 
> As replied to Dan in the other email, I changed my mind on question (1); I
> think it makes sense to have it YES.  I left my pure question on (2) there
> too.
> 
> Do we really want to disable migrate-set-parameters setting most of the
> parameters, and only allow it to be set during migration on a few things
> like bandwidth or so?

Yes, that's the whole point of the exercise IMHO. 

> I just don't really see the major benefit of that yet.  I would think it
> make more sense if we don't need to change any parameters in migration,
> then provide that in one shot in QMP migrate "config".  Maybe making more
> sense if migration is not heavily thread-based but having its aiocontext so
> we could even move to Jobs.

The benefit is that it brings 'migrate' into line with all other
QMP commands, such that the data provided with the command is
precisely what controls behaviour, giving predictable behaviour. 

> One step back, on this "allow migrate to specify 'config'" request: I think
> we can definitely do that as it still provides some kind of atomicity.  But
> frankly speaking I never see it a "real problem" - do we really have report
> or use case showing that Libvirt can trigger "migrate" with some global
> settings touched by other apps at all?

atomicity is only one of the goals - being free from side effects
of externally set global state is the more important aspect.

> To me, it was yet an illutionary problem, I never know the answer of that.
> If Libvirt is still the owner of QEMU instance via the QMP channel, I
> actually don't really see why the atomicity would even help, even though we
> can still provide that as it's pretty easy as something optional; like what
> this patch does without too much hassle.

Even if only a single mgmt app is involved this is still beneficial
because the migration infrastructure is used for distinct use cases
inside QEMU - live migration, CPR, save/restore, and savevm/loadvm.
Any time code any one of those uses cases starts using a new parameter,
apps have to make sure they don't inadvertantly have its effects apply
to the other use cases.

> Then if to move one step further to remove all global settings, we face
> breaking debugging scripts, and breaking of any old libvirt and non-libvirt
> mgmt apps.  Frankly I really don't yet know whether it's a good idea.  I
> could miss some important reasoning of why we want to do it - it needs to
> be something not relevant to "making the code cleaner", IMHO..

Again, it makes the behaviour predictable as the QMP command fully expresses
what action is going to be peformed, free with side effets of any previously
set state.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


