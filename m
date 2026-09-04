Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFCC79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PMY-0001Pf-7K; Fri, 04 Sep 2026 04:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PMW-0001PS-48
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PMU-0004YB-AD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788510804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcId/ZUjTR6Q5fAC0GzuMYX+7iRvLcLcmQvuL+lRc2g=;
 b=F5ZeeZCs+iF6tJ+MCvSZyEmNAjd/O+AX97E7/YBt8VMZ82uHD7NpbVPbpKcKFZswRCZmUO
 oxWVNSyFWJoNAZWGxYQ/W5LIRlR6VOqhVkCLmi9FtJRWy7TAlWx5zQ9yYhRwqMTzmX7m4X
 xVTyhf8sz5TNm4C8AaUxQL842+xe0/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-2ZCRg9WBNDCQjNI-nInS5g-1; Fri,
 04 Sep 2026 04:33:22 -0400
X-MC-Unique: 2ZCRg9WBNDCQjNI-nInS5g-1
X-Mimecast-MFC-AGG-ID: 2ZCRg9WBNDCQjNI-nInS5g_1788510801
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4310A1953976; Fri,  4 Sep 2026 08:33:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF3C30001A2; Fri,  4 Sep 2026 08:33:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C18521E6A04; Fri, 04 Sep 2026 10:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <aphL_rrAVYq8D7ie@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 2 Sep 2026 17:17:02 +0100")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <8733vtbk16.fsf@pond.sub.org>
 <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
 <87qzjb3nf6.fsf@pond.sub.org> <apgONqZ4sWaenjVG@redhat.com>
 <87jyp31zyf.fsf@pond.sub.org> <aphL_rrAVYq8D7ie@redhat.com>
Date: Fri, 04 Sep 2026 10:33:18 +0200
Message-ID: <8733vph0vl.fsf@pond.sub.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 02, 2026 at 04:37:44PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Sep 02, 2026 at 01:25:33PM +0200, Markus Armbruster wrote:
>> >> Zhang Chen <zhangckid@gmail.com> writes:
>> >>=20
>> >> > On Tue, Sep 1, 2026 at 1:47=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com> wrote:
>> >> >>
>> >> >> Zhang Chen <zhangckid@gmail.com> writes:
>> >> >>
>> >> >> > Monitors that require an IOThread share the internal mon_iothrea=
d.
>> >> >> > Account for each monitor explicitly in IOThread holder tracking,=
 using
>> >> >> > the monitor's canonical QOM path to distinguish holders.
>> >> >> >
>> >> >> > Acquire the shared monitor IOThread AioContext once, using the m=
onitor
>> >> >> > QOM path as the holder, and reuse the stored context for later
>> >> >> > operations.
>> >> >> >
>> >> >> > Release the holder from the Monitor ObjectClass::unparent callba=
ck,
>> >> >> > while the canonical QOM path is still available. This covers eve=
ry
>> >> >> > object_unparent() path and avoids duplicating the cleanup in
>> >> >> > monitor_cleanup() and monitor_qmp_prepare_delete().
>> >> >> >
>> >> >> > The internal mon_iothread remains hidden from query-iothreads, a=
s before.
>> >> >> > Management applications therefore cannot use it to determine whi=
ch
>> >> >> > monitors are using the IOThread. Nevertheless, track the monitor
>> >> >> > holders so that they follow the same explicit holder and
>> >> >> > IOThread reference lifecycle as other AioContext users.
>> >> >> >
>> >> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> >> >>
>> >> >> I have a question for our QOM experts (Paolo and Daniel).
>> >> >>
>> >> >> This patch takes a reference in its UserCreatableClass method
>> >> >> complete(), and relinquishes it in its ObjectClass unparent() meth=
od.
>> >> >> Is that correct and clean?  Or should complete() pair with
>> >> >> prepare_delete()?
>> >> >
>> >> >
>> >> > Add some background information in previous reviews for here:
>> >> > https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05318.html
>> >>=20
>> >> Aha, Stefan asked for monitor_finalize(), which doesn't exist.  You t=
hen
>> >> moved it to the unparent() method.
>> >
>> > monitor_finalize() does exist as of about a month ago. It was
>> > introduced as part of my series that turned Monitor into a QOM
>> > object.
>>=20
>> I was on an old branch.  Sorry for the noise!
>>=20
>> >> My question for the QOM maintainers remains: is it okay to pair
>> >> complete() with unparent(), or should it pair with prepare_delete()?
>> >
>> > In general most things done in complete() can/should be undone in the
>> > finalize() callback IMHO.
>>=20
>> I can't see a finalize() callback, and I *am* on current master now.  Do
>> you mean unparent(), or do you mean monitor_finalize()?
>
> Sorry for the ambiguity. The latter.
>
> When I wrote "finalize()" I meant to say "instance_finalize()", as the
> generic name of the callback field in the Type, which is
> "monitor_finalize()" in the specific Monitor implementation.

If I understand you correctly, the code this patch puts in
monitor_unparent() should instead go into monitor_finalize().  Fair?


