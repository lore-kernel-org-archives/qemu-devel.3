Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A55CD1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CMH-0004GB-Pw; Tue, 22 Oct 2024 06:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3CMG-0004Fi-9J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3CME-0000E8-1A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729593799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzmFgnfcJCKD/QUjCpKPKqWn7TfqTfDgVOKPyUIAqTI=;
 b=guZOAhJM3yYy3kMt+e5pGCmDcmDtRqzqsYoAauueF4/Urk1x0WwDEau5UCCGYnZNX3qnrA
 8sdN//9GFEtR7nGkMQE1bnk4VGYCLo61uWtGeGVcmxAVKwbThzqlffijPQtHjrY75GDdfX
 8afh3PZnGIeVcUQeQO8g2vACOvjP36o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-kr0HzEp6O0CbgfwM22T7Zw-1; Tue,
 22 Oct 2024 06:43:13 -0400
X-MC-Unique: kr0HzEp6O0CbgfwM22T7Zw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BA111955F3F; Tue, 22 Oct 2024 10:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3108A30001A3; Tue, 22 Oct 2024 10:43:08 +0000 (UTC)
Date: Tue, 22 Oct 2024 11:43:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
Message-ID: <ZxeBuXQB3hd2avUh@redhat.com>
References: <20241021215220.982325-1-peterx@redhat.com>
 <87froo34xy.fsf@pond.sub.org> <ZxdujhRo_kSkdkbX@redhat.com>
 <87jze01kzp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jze01kzp.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Tue, Oct 22, 2024 at 12:37:46PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 22, 2024 at 10:41:29AM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Per previous discussion [1,2], this patch deprecates query-migrationthreads
> >> > command.
> >> >
> >> > To summarize, the major reason of the deprecation is due to no sensible way
> >> > to consume the API properly:
> >> >
> >> >   (1) The reported list of threads are incomplete (ignoring destination
> >> >       threads and non-multifd threads).
> >> >
> >> >   (2) For CPU pinning, there's no way to properly pin the threads with
> >> >       the API if the threads will start running right away after migration
> >> >       threads can be queried, so the threads will always run on the default
> >> >       cores for a short window.
> >> >
> >> >   (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
> >> >       which will provide proper names for all migration threads.
> >> >
> >> > [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
> >> > [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> [...]
> 
> >> > diff --git a/migration/threadinfo.c b/migration/threadinfo.c
> >> > index 262990dd75..2867413420 100644
> >> > --- a/migration/threadinfo.c
> >> > +++ b/migration/threadinfo.c
> >> > @@ -13,6 +13,7 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "qemu/queue.h"
> >> >  #include "qemu/lockable.h"
> >> > +#include "qemu/error-report.h"
> >> >  #include "threadinfo.h"
> >> >  
> >> >  QemuMutex migration_threads_lock;
> >> > @@ -52,6 +53,9 @@ MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
> >> >      MigrationThread *thread = NULL;
> >> >  
> >> >      QEMU_LOCK_GUARD(&migration_threads_lock);
> >> > +
> >> > +    warn_report("Command 'query-migrationthreads' is deprecated");
> >> 
> >> We don't normally do this for QMP commands.
> >> 
> >> Management applications can use -compat deprecated-input=reject to check
> >> they're not sending deprecated commands or arguments.
> >> 
> >> Suggest to drop.
> >
> > They could, but in practice I don't believe anything is doing this, so
> > the warning message is a practical way to alert people to the usage.
> 
> Again, we not normally do this.  What makes this one different?

Do we not ? My expectation is that everything we record in deprecated.rst
also has a corresponding warn_report / warn_report_once in the code.
We know users may not read the docs, so we have a multi-pronged approach
to alerting them.

> Stepping onto my soapbox: if stuff going away surprisingly would cause
> you enough inconvenience to make early warning desirable, testing with
> suitable -compat is a lot more reliable than relying on warnings.
> *Especially* when your automated testing files warnings unexamined
> together with any other crap that may go to stderr, so your best chance
> to notice the warning is in ad hoc manual testing of QEMU.  Nobody does
> that until after things broke.

I don't see it as an either or choice. We try to surface the deprecation
info in as many different ways as is practical, as no single approach is
going to hit all bases.

 * Document it (deprecated.rst)
 * Warn on QEMU stderr if used at runtime (warn_report)
 * Enable apps to validate their usage in tests (-compat)
 * Mark guests as tainted (libvirt API & VM log file, for certain asepts)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


