Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A28C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOe1x-0006Nh-AO; Mon, 09 Jun 2025 11:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOe1o-0006NS-Hw
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOe1m-0002uR-Cb
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749481389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vmPLKClueFFZvZQRbmobTeF2DRgYUjAoBYW2pKQxMMU=;
 b=AUT9Uws2ihLE8IdOtGozhIXkpe5mDPrJKSCb5qfYhALCnVFwasnz7INy4oDGcPC9nJhKNu
 3nnODwOV+jORdGkME0xQdK+pRSs/1iECr1pCXrGdycpPlDwGkvMjdl+E3Rf4ZQAKDwRaMx
 TO/LNwlaP4PNtsO8K/R7IR0SvYwzgD4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-FXltjgjBNLGlePD7d-Vyzg-1; Mon,
 09 Jun 2025 11:03:07 -0400
X-MC-Unique: FXltjgjBNLGlePD7d-Vyzg-1
X-Mimecast-MFC-AGG-ID: FXltjgjBNLGlePD7d-Vyzg_1749481387
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C994318001D1; Mon,  9 Jun 2025 15:03:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14D5919560A3; Mon,  9 Jun 2025 15:03:04 +0000 (UTC)
Date: Mon, 9 Jun 2025 16:03:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEb3pRkQK30JBf04@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aENUrociiqlFuPpz@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Jun 06, 2025 at 04:50:54PM -0400, Peter Xu wrote:
> On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> > >> Allow the migrate and migrate_incoming commands to pass the migration
> > >> configuration options all at once, dispensing the use of
> > >> migrate-set-parameters and migrate-set-capabilities.
> > >> 
> > >> The motivation of this is to simplify the interface with the
> > >> management layer and avoid the usage of several command invocations to
> > >> configure a migration. It also avoids stale parameters from a previous
> > >> migration to influence the current migration.
> > >> 
> > >> The options that are changed during the migration can still be set
> > >> with the existing commands.
> > >> 
> > >> The order of precedence is:
> > >> 
> > >> 'config' argument > -global cmdline > defaults (migration_properties)
> > >
> > > Could we still keep the QMP migrate-set-parameters values?
> > >
> > >   'config' argument > QMP setups using migrate-set-parameters >
> > >     -global cmdline > defaults (migration_properties)
> > >
> > 
> > That's the case. I failed to mention it in the commit message. IOW it
> > behaves just like today, but the new 'config' way takes precedence over
> > all.
> 
> Referring to below chunk of code:
> 
> [...]
> 
> > >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> > >> +                             Error **errp)
> > >> +{
> > >> +    ERRP_GUARD();
> > >> +
> > >> +    assert(bql_locked());
> > >> +
> > >> +    /* reset to default parameters */
> > >> +    migrate_params_apply(&s->defaults);
> 
> IIUC here it'll reset all global parameters using the initial defaults
> first, then apply the "config" specified in "migrate" QMP command?
> 
> I think there're actually two separate questions to be asked, to make it
> clearer, they are:
> 
>   (1) Whether we should allow QMP "migrate" 'config' parameter to overwrite
>       global setup?
> 
>   (2) Whether we should allow previous QMP global setup to be used even if
>       QMP "migrate" provided 'config' parameter?
> 
> So IIUC the patch does (1) YES (2) NO, while what I think might be more
> intuitive is (1) NO (2) YES.

The point of the 'config' parameter to the 'migrate' command is to
enable the mgmt app to fully specify what it wants the configuration
to be, such that there is no previously set state will will cause
it surprises. Allowing -global to have an effect undermines the
predictibility in the same way that migrate-set-parameter undermines
the predictibility.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


