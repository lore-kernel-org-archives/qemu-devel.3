Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46080D6B6B3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 17:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Cxq-00084o-HD; Wed, 30 Oct 2024 13:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6Cxp-00084f-9g
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6Cxm-00074d-Oe
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 13:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730311112;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yRY9Hy4yEeV2BpKTp3Zmo0SPoh783Z7PmWuiHqbKsw=;
 b=c/E9272wPNorhOfWO7Tr1Fh1qP85UWF39G345oqure6C+Gpj0uk5yQp9UNt8OYVMELZADL
 vZf8NM2LC+8vffWgzOk0T9wfGliOrIlchtxFFUDaqgYr1V1cUop8fOFr/Z8DyIfGZCq0tk
 nDOGI0tPbmBqfpO5x4iHosXcjskhb5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-NXplRCQfMR-CcaV_KexWQA-1; Wed,
 30 Oct 2024 13:58:27 -0400
X-MC-Unique: NXplRCQfMR-CcaV_KexWQA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 933D219560AB; Wed, 30 Oct 2024 17:58:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172931956054; Wed, 30 Oct 2024 17:58:19 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:58:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyJzt2gxWLPOE9fe@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyIA1zruTAxHfGcn@redhat.com> <ZyIw6Rt8kgrFRtXs@x1n>
 <ZyJbRZ02wX4XM-iR@redhat.com> <ZyJyOnHidTsPAXrR@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJyOnHidTsPAXrR@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 30, 2024 at 01:51:54PM -0400, Peter Xu wrote:
> On Wed, Oct 30, 2024 at 04:13:57PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Oct 30, 2024 at 09:13:13AM -0400, Peter Xu wrote:
> > > On Wed, Oct 30, 2024 at 09:48:07AM +0000, Daniel P. Berrangé wrote:
> > > > On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> > > > > v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> > > > 
> > > > > Meanwhile, migration has a long standing issue on current_migration
> > > > > pointer, where it can point to freed data after the migration object is
> > > > > finalized.  It is debatable that the pointer can be cleared after the main
> > > > > thread (1) join() the migration thread first, then (2) release the last
> > > > > refcount for the migration object and clear the pointer.  However there's
> > > > > still major challenges [1].  With singleton, we could have a slightly but
> > > > > hopefully working workaround to clear the pointer during finalize().
> > > > 
> > > > I'm still not entirely convinced that this singleton proposal is
> > > > fixing the migration problem correctly.
> > > > 
> > > > Based on discussions in v1, IIUC, the situation is that we have
> > > > migration_shutdown() being called from qemu_cleanup(). The former
> > > > will call object_unref(current_migration), but there may still
> > > > be background migration threads running that access 'current_migration',
> > > > and thus a potential use-after-free.
> > > 
> > > migration thread is fine, it takes a refcount at the entry.
> > > 
> > > And btw, taking it at the entry is racy, we've just fixed it, see (in my
> > > next migration pull):
> > > 
> > > https://lore.kernel.org/qemu-devel/20241024213056.1395400-2-peterx@redhat.com/
> > 
> > Yep, acquiring the refcount immediately before thread-create
> > is what I meant.
> > 
> > > The access reported was, IIUC, outside migration code, but after both
> > > main/migration threads released the refcount, hence after finalize().  It
> > > could be a random migration_is_running() call very late in device code, for
> > > example.
> > 
> > 
> > 
> > > 
> > > > 
> > > > Based on what the 7th patch here does, the key difference is that
> > > > the finalize() method for MigrationState will set 'current_migration'
> > > > to NULL after free'ing it.
> > > 
> > > Yes.  But this show case series isn't complete.  We need a migration-side
> > > lock finally to make it safe to access.  For that, see:
> > > 
> > > https://lore.kernel.org/qemu-devel/20241024213056.1395400-9-peterx@redhat.com/
> > > 
> > > > 
> > > > I don't believe that is safe.
> > > 
> > > I hope after the other series applied it will be 100% safe, even though I
> > > agree it's tricky.  But hopefully QOM is very clean, the trickly part is
> > > still within migration, and it should be less tricky than migration
> > > implement a refcount on top of Object..
> > 
> > Ok, so with the other series applied, this does look safe, but
> > it also doesn't seem to really have any dependancy on the
> > single interface code.  Patch 7 here looks sufficient, in combo
> > with the other 2 series to avoid the use-after-free flaws.
> 
> Patch 7, when applied without patch 6 and prior, will crash in
> device-introspect-test, trying to create yet another migration object when
> processing the "device-list-properties" QMP command.  And it turns out
> that's also not the only way QEMU can crash by that.
> 
> Fundamentally it's because patch 7 has global operations within
> init()/finalize() to fix the migration dangling pointer, hence it must not
> be instanciated more than once.

That's a result from moving the "assert()" into the constructor.
The assert(!current_migration) can be kept in migration_object_init,
the constructor could conditionally set current_migration only if it
is NULL, and the finalizer could conditionally clear current_migration
only if it matches the current object. There's no conceptual dependancy
on having a singleton interface in the patch.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


