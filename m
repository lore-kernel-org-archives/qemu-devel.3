Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84DFC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz7U3-000650-Oe; Wed, 26 Aug 2026 02:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wz7U1-00064s-Cb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wz7Tz-0000DW-KH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787727094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgPm9jSR+mQX8cCodBAjyTmKYIDhZ/I1V+riNvmqwjY=;
 b=D9fD78sb56PCNfRLNfYBrdPgNQNU5ruM2tE5w0f4RlI2LkjLGHvhmy73MFT1ezWiOZtKY9
 qvs49oqdW8nYtuu3OVRX7MtzvhIH0rgyO15aT4UUVhhkXAkJzmTVnS+2JQD84DVm4OfVDH
 qkWY23UljC0Oj/k8FLtWJiUElduflFc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-93JndsYmMkKDwnCxRs-61Q-1; Wed,
 26 Aug 2026 02:51:31 -0400
X-MC-Unique: 93JndsYmMkKDwnCxRs-61Q-1
X-Mimecast-MFC-AGG-ID: 93JndsYmMkKDwnCxRs-61Q_1787727090
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 594A818C1062; Wed, 26 Aug 2026 06:51:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB0E91803A4D; Wed, 26 Aug 2026 06:51:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74B1821E6920; Wed, 26 Aug 2026 08:51:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V13 02/15] iothread: introduce holder tracking
In-Reply-To: <CAK3tnv+YRY3F5kfWC_4qh5WY9TGxP7wPCPN6fbEq1_yoWsfpCw@mail.gmail.com>
 (Zhang Chen's message of "Tue, 25 Aug 2026 21:50:43 +0800")
References: <20260822213343.661939-1-zhangckid@gmail.com>
 <20260822213343.661939-3-zhangckid@gmail.com>
 <874igipqbu.fsf@pond.sub.org>
 <CAK3tnv+YRY3F5kfWC_4qh5WY9TGxP7wPCPN6fbEq1_yoWsfpCw@mail.gmail.com>
Date: Wed, 26 Aug 2026 08:51:27 +0200
Message-ID: <87wltdidcg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> On Tue, Aug 25, 2026 at 4:17=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > IOThreads do not record the QOM objects and block exports that use
>> > them, making runtime introspection and hotplug debugging difficult.
>> >
>> > Add:
>> >
>> > - holders: a list describing what is holding an iothread
>> > - iothread_ref(): add a holder to the list
>> > - iothread_unref(): remove a holder from the list
>> >
>> > A holder can identify either a QOM object or a block export. A later
>> > patch will expose this information through query-iothreads.
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> I'm suspending my R-by, see below why.

I'm now reinstating it.

>> [...]
>>
>> > diff --git a/iothread.c b/iothread.c
>> > index 3558535b40..66dfde626e 100644
>> > --- a/iothread.c
>> > +++ b/iothread.c
>> > @@ -21,10 +21,71 @@
>> >  #include "system/iothread.h"
>> >  #include "qapi/error.h"
>> >  #include "qapi/qapi-commands-misc.h"
>> > +#include "qapi/clone-visitor.h"
>> > +#include "qapi/qapi-visit-misc.h"
>> >  #include "qemu/error-report.h"
>> >  #include "qemu/rcu.h"
>> >  #include "qemu/main-loop.h"
>> >
>> > +/* Add a deep copy of @holder to @iothread's list of holders. */
>> > +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
>> > +{
>> > +    assert(holder);
>> > +
>> > +    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, h=
older));
>> > +}
>> > +
>> > +static int iothread_holder_compare(const IOThreadHolder *holder_a,
>> > +                                   const IOThreadHolder *holder_b)
>> > +{
>> > +    const char *name_a, *name_b;
>> > +
>> > +    if (holder_a->type !=3D holder_b->type) {
>> > +        return holder_a->type - holder_b->type;
>>
>> Why did you swap the operands in v13?  Not mentioned in the cover
>> letter's change log.  I requested the other order in review of v8[*] and
>> v9, and you complied in v10.  Unless you have a compelling reason, swap
>> them right back, please.
>>
>> In general, rocking the boat like this when you're at v13 is
>> inadvisable.  It risks delaying the series even more and annoying
>> reviewers.
>
> Please allow me to explain the details, I have always respected the
> opinions of the community.
> Yes, I remember your comments in V9 and I fixed it. This change wasn't
> something I made secretly or accidentally.
> However, Stefan gave the opposite opinion in the V12, and I see you
> didn't object,

I didn't see it.  Sadly, I can't follow the entire discussion of every
version of every series I comment on.

When reviewer A asks you to change something, and reviewer B later asks
you to change it again, there's a conflict.  If A is aware and remains
silent, that may be taken as assent.  But is A aware?  Better ask to
make sure.

> so it was changed according to his suggestion. This might be a misunderst=
anding.

It is.  Go with your current version.

> https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05089.html
>
> I look forward to your reply so we can discuss this issue clearly.
>
> Thanks
> Chen

[...]


