Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA41D1715A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3DG1-0005Vf-QF; Tue, 22 Oct 2024 07:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3DFp-0005V6-AJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3DFm-0001MI-4e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729597242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yad+DJ0KMg1UVDaPOPSn50ccXv492VIADa7NYMqPs1I=;
 b=Jwk3g/1PMVRI+qt9+VkNUgLS/cFXzqi05cMgmUWYoD22DqTavhsG4K1Ss+Wq5ouIfH7NxO
 hVZFHSWteJWuJuiUM2QPoOtfPSr/R8vuuQzNysl7U+qQ4a7+psa3n6s5yGrP1CfzeG/90G
 7+BIkSzgX/BOD1oOxMKZdCwqFo9/nEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-DHOrHpXbPTiaKRbDHFl3RQ-1; Tue,
 22 Oct 2024 07:40:41 -0400
X-MC-Unique: DHOrHpXbPTiaKRbDHFl3RQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07595195608D; Tue, 22 Oct 2024 11:40:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3B619560AE; Tue, 22 Oct 2024 11:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1209D21E6A28; Tue, 22 Oct 2024 13:40:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Juraj Marcin <jmarcin@redhat.com>,  Prasad
 Pandit <ppandit@redhat.com>,  Julia Suvorova <jusual@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
In-Reply-To: <ZxeBuXQB3hd2avUh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 22 Oct 2024 11:43:05 +0100")
References: <20241021215220.982325-1-peterx@redhat.com>
 <87froo34xy.fsf@pond.sub.org> <ZxdujhRo_kSkdkbX@redhat.com>
 <87jze01kzp.fsf@pond.sub.org> <ZxeBuXQB3hd2avUh@redhat.com>
Date: Tue, 22 Oct 2024 13:40:37 +0200
Message-ID: <87plnsz7pm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 22, 2024 at 12:37:46PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Oct 22, 2024 at 10:41:29AM +0200, Markus Armbruster wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >>=20
>> >> > Per previous discussion [1,2], this patch deprecates query-migratio=
nthreads
>> >> > command.
>> >> >
>> >> > To summarize, the major reason of the deprecation is due to no sens=
ible way
>> >> > to consume the API properly:
>> >> >
>> >> >   (1) The reported list of threads are incomplete (ignoring destina=
tion
>> >> >       threads and non-multifd threads).
>> >> >
>> >> >   (2) For CPU pinning, there's no way to properly pin the threads w=
ith
>> >> >       the API if the threads will start running right away after mi=
gration
>> >> >       threads can be queried, so the threads will always run on the=
 default
>> >> >       cores for a short window.
>> >> >
>> >> >   (3) For VM debugging, one can use "-name $VM,debug-threads=3Don" =
instead,
>> >> >       which will provide proper names for all migration threads.
>> >> >
>> >> > [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat=
.com
>> >> > [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat=
.com
>> >> >
>> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>=20
>> [...]
>>=20
>> >> > diff --git a/migration/threadinfo.c b/migration/threadinfo.c
>> >> > index 262990dd75..2867413420 100644
>> >> > --- a/migration/threadinfo.c
>> >> > +++ b/migration/threadinfo.c
>> >> > @@ -13,6 +13,7 @@
>> >> >  #include "qemu/osdep.h"
>> >> >  #include "qemu/queue.h"
>> >> >  #include "qemu/lockable.h"
>> >> > +#include "qemu/error-report.h"
>> >> >  #include "threadinfo.h"
>> >> >=20=20
>> >> >  QemuMutex migration_threads_lock;
>> >> > @@ -52,6 +53,9 @@ MigrationThreadInfoList *qmp_query_migrationthrea=
ds(Error **errp)
>> >> >      MigrationThread *thread =3D NULL;
>> >> >=20=20
>> >> >      QEMU_LOCK_GUARD(&migration_threads_lock);
>> >> > +
>> >> > +    warn_report("Command 'query-migrationthreads' is deprecated");
>> >>=20
>> >> We don't normally do this for QMP commands.
>> >>=20
>> >> Management applications can use -compat deprecated-input=3Dreject to =
check
>> >> they're not sending deprecated commands or arguments.
>> >>=20
>> >> Suggest to drop.
>> >
>> > They could, but in practice I don't believe anything is doing this, so
>> > the warning message is a practical way to alert people to the usage.
>>=20
>> Again, we not normally do this.  What makes this one different?
>
> Do we not ? My expectation is that everything we record in deprecated.rst
> also has a corresponding warn_report / warn_report_once in the code.
> We know users may not read the docs, so we have a multi-pronged approach
> to alerting them.

We definitely do not.

>> Stepping onto my soapbox: if stuff going away surprisingly would cause
>> you enough inconvenience to make early warning desirable, testing with
>> suitable -compat is a lot more reliable than relying on warnings.
>> *Especially* when your automated testing files warnings unexamined
>> together with any other crap that may go to stderr, so your best chance
>> to notice the warning is in ad hoc manual testing of QEMU.  Nobody does
>> that until after things broke.
>
> I don't see it as an either or choice. We try to surface the deprecation
> info in as many different ways as is practical, as no single approach is
> going to hit all bases.
>
>  * Document it (deprecated.rst)
>  * Warn on QEMU stderr if used at runtime (warn_report)
>  * Enable apps to validate their usage in tests (-compat)
>  * Mark guests as tainted (libvirt API & VM log file, for certain asepts)

To deprecate a QMP command, event, argument or result, we add the
feature flag.  One-liner, basically impossible to screw up.

Review should then catch a missing update to deprecated.rst.

Same for un-deprecating something.

So far, this is as simple as it could possibly be.  That's a feature.

A warning requires additional handwritten code.  Which *can* be screwed
up.  Moreover, missing warning (add or delete) is easy to miss in
review.

If we want such warnings for QMP, they should be automated just like the
-compat actions.  Any existing warnings rendered redundant should then
be taken out.  I considered that when I did -compat, and rejected it as
not worth the effort.


