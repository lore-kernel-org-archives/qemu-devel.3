Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE10D1CDD3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CHC-0002Df-PG; Tue, 22 Oct 2024 06:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3CH1-0002Cf-3z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t3CGy-00086D-Hc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729593475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQbfnoRjuUDJBAQYMXMPL4SHHvqmT7MbWbJYU/7FTz8=;
 b=V/+InuaYDRpmCk/hwQyk0oe/Q0bqM0LAXpQNcZRhmdWN/HpNgOGeeQIL+l/ghuzzi5L80M
 zJogB01PdpmlXLaKh0up1wnaUo+HBRFAzHnR4MQKnBkySKj/CoyafL2Ky6Uq4zZvblOTn5
 WXUpoz2YOM73J7lKsf2/OjDeCYjmyCM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-hShFNzyoMaKnURVWoERVOQ-1; Tue,
 22 Oct 2024 06:37:51 -0400
X-MC-Unique: hShFNzyoMaKnURVWoERVOQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E4BA19560A1; Tue, 22 Oct 2024 10:37:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236BE1956056; Tue, 22 Oct 2024 10:37:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF0EE21E6A28; Tue, 22 Oct 2024 12:37:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Juraj Marcin <jmarcin@redhat.com>,  Prasad
 Pandit <ppandit@redhat.com>,  Julia Suvorova <jusual@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
In-Reply-To: <ZxdujhRo_kSkdkbX@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 22 Oct 2024 10:21:18 +0100")
References: <20241021215220.982325-1-peterx@redhat.com>
 <87froo34xy.fsf@pond.sub.org> <ZxdujhRo_kSkdkbX@redhat.com>
Date: Tue, 22 Oct 2024 12:37:46 +0200
Message-ID: <87jze01kzp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 22, 2024 at 10:41:29AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > Per previous discussion [1,2], this patch deprecates query-migrationth=
reads
>> > command.
>> >
>> > To summarize, the major reason of the deprecation is due to no sensibl=
e way
>> > to consume the API properly:
>> >
>> >   (1) The reported list of threads are incomplete (ignoring destination
>> >       threads and non-multifd threads).
>> >
>> >   (2) For CPU pinning, there's no way to properly pin the threads with
>> >       the API if the threads will start running right away after migra=
tion
>> >       threads can be queried, so the threads will always run on the de=
fault
>> >       cores for a short window.
>> >
>> >   (3) For VM debugging, one can use "-name $VM,debug-threads=3Don" ins=
tead,
>> >       which will provide proper names for all migration threads.
>> >
>> > [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
>> > [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>

[...]

>> > diff --git a/migration/threadinfo.c b/migration/threadinfo.c
>> > index 262990dd75..2867413420 100644
>> > --- a/migration/threadinfo.c
>> > +++ b/migration/threadinfo.c
>> > @@ -13,6 +13,7 @@
>> >  #include "qemu/osdep.h"
>> >  #include "qemu/queue.h"
>> >  #include "qemu/lockable.h"
>> > +#include "qemu/error-report.h"
>> >  #include "threadinfo.h"
>> >=20=20
>> >  QemuMutex migration_threads_lock;
>> > @@ -52,6 +53,9 @@ MigrationThreadInfoList *qmp_query_migrationthreads(=
Error **errp)
>> >      MigrationThread *thread =3D NULL;
>> >=20=20
>> >      QEMU_LOCK_GUARD(&migration_threads_lock);
>> > +
>> > +    warn_report("Command 'query-migrationthreads' is deprecated");
>>=20
>> We don't normally do this for QMP commands.
>>=20
>> Management applications can use -compat deprecated-input=3Dreject to che=
ck
>> they're not sending deprecated commands or arguments.
>>=20
>> Suggest to drop.
>
> They could, but in practice I don't believe anything is doing this, so
> the warning message is a practical way to alert people to the usage.

Again, we not normally do this.  What makes this one different?

Stepping onto my soapbox: if stuff going away surprisingly would cause
you enough inconvenience to make early warning desirable, testing with
suitable -compat is a lot more reliable than relying on warnings.
*Especially* when your automated testing files warnings unexamined
together with any other crap that may go to stderr, so your best chance
to notice the warning is in ad hoc manual testing of QEMU.  Nobody does
that until after things broke.

[...]


