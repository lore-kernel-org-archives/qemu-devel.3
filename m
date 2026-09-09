Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7A4C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FkR-0001qp-Hu; Wed, 09 Sep 2026 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4FkQ-0001qO-2U
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4FkO-0002Rl-Iz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788950503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zaOUwy1a6as5Flcg2yEZa5MseELqYhBAEHnIpjVOMQ=;
 b=HuCBGnTGEBrReEN0mJM+HUgWMI5AJP+oMN9wcPyT2jLXJ8u8SvKD0KDoa3X3OOnkdIJSSk
 CFSO9exztxdcdrNqPA3y+jUSGaXZlgb/C0iWikBnRbZYUHOyc0LNlT5YwwhqVhuW+yfoiP
 QInYBQ0QmSHfZMlL5Ob85VCVWdDL87A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-NoKrpFgCMtiGfQv35-N4Xw-1; Wed,
 09 Sep 2026 06:41:42 -0400
X-MC-Unique: NoKrpFgCMtiGfQv35-N4Xw-1
X-Mimecast-MFC-AGG-ID: NoKrpFgCMtiGfQv35-N4Xw_1788950501
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFB551955E7B; Wed,  9 Sep 2026 10:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 890A130001BB; Wed,  9 Sep 2026 10:41:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4493621E6A04; Wed, 09 Sep 2026 12:41:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V15 13/14] iothread: make legacy AioContext getter
 explicitly unsafe
In-Reply-To: <CAK3tnvJALU_i6OzrCb-t20un=AALTySuRamkmyqrbS8Zumk2Tg@mail.gmail.com>
 (Zhang Chen's message of "Wed, 9 Sep 2026 14:24:03 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-14-zhangckid@gmail.com>
 <87zextw78o.fsf@pond.sub.org>
 <CAK3tnvJALU_i6OzrCb-t20un=AALTySuRamkmyqrbS8Zumk2Tg@mail.gmail.com>
Date: Wed, 09 Sep 2026 12:41:38 +0200
Message-ID: <87bja6n1ul.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> On Mon, Sep 7, 2026 at 8:55=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Now that holder-aware callers have been converted, rename
>> > iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
>> > update qmp_x_blockdev_set_iothread(). This avoids adding a duplicate
>> > accessor only to remove the old one later.
>>
>> The last sentence appears to justify the change since v14.  If that's
>> the intent, drop it, please.  If not, what is the intent?
>
> Thanks. Yes, that sentence was about the changes since v14; I'll
> drop it from the commit message.
>
>>
>> > The block graph retains only the AioContext, while detachment happens
>> > outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
>> > a matching holder lifecycle. The new name makes its existing lifetime
>> > assumption explicit.
>>
>> Suggest to start like "The only remaining user is
>> qmp_x_blockdev_set_iothread()" and then explain why this caller cannot
>> use iothread_ref_and_get_aio_context().
>>
>> > New code should use iothread_ref_and_get_aio_context().
>> >
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > ---
>> >  blockdev.c                |  7 ++++++-
>> >  include/system/iothread.h | 11 ++++++++++-
>> >  iothread.c                |  2 +-
>> >  3 files changed, 17 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/blockdev.c b/blockdev.c
>> > index 6e86c6262f..97d161079a 100644
>> > --- a/blockdev.c
>> > +++ b/blockdev.c
>> > @@ -3683,7 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *no=
de_name, StrOrNull *iothread,
>> >              goto out;
>> >          }
>> >
>> > -        new_context =3D iothread_get_aio_context(obj);
>> > +        /*
>> > +         * The block graph retains only the AioContext, not the IOThr=
ead.
>> > +         * Context detachment happens outside this command, so there =
is no
>> > +         * point here where a matching IOThread holder can be release=
d.
>> > +         */
>>
>> This is fine for readers who already know what this is about: why we
>> can't use iothread_ref_and_get_aio_context() /
>> iothread_unsafe_get_aio_context() here.  Others will lack context.
>>
>> Suggest to start like
>>
>>            /*
>>             * We cannot use iothread_ref_and_get_aio_context() /
>>             * iothread_unref_and_put_aio_context() here.
>>
>> then explain why.
>
> OK, will change it  to:
> /*
>  * We cannot use iothread_ref_and_get_aio_context() /
>  * iothread_unref_and_put_aio_context() here. The block graph stores
>  * the AioContext but not the IOThread, and continues using the
>  * context after this command returns. A matching put would need
>  * to be tied to the block graph's context lifecycle.
>  */

Works for me, thanks!


