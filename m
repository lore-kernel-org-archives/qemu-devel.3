Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A9EFD216
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBGa-0002BO-Rh; Wed, 25 Feb 2026 04:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvBGX-0002BB-EX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvBGP-0005BB-Tr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fz7DUIMZhSyLpmz8iR9M49jdiPuZ5ipIS81yAb06D2s=;
 b=d9LFAFU2sOAl7XL2B3IP+1hLgC+vvd6KtgHM/3rM+rEVfW8NvhsxvEFkQqg2k7bubGVnNp
 90saWP7ZxhbQ8aGTcIHhbbZv0lL+xmj4Lz1PvK2JOfMCJeohltBTx6cLC3aBX3K2cH4Mf2
 mwpw41mXeFp8jbmnHp3rmtFi/fi2vH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-_rIOraWVMdGgjZ0TBded_w-1; Wed,
 25 Feb 2026 04:32:55 -0500
X-MC-Unique: _rIOraWVMdGgjZ0TBded_w-1
X-Mimecast-MFC-AGG-ID: _rIOraWVMdGgjZ0TBded_w_1772011974
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 921D61800473; Wed, 25 Feb 2026 09:32:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48F2A1800352; Wed, 25 Feb 2026 09:32:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAB4C21E692D; Wed, 25 Feb 2026 10:32:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 kraxel@redhat.com,  pbonzini@redhat.com,  ani@anisinha.ca,  Prasad Pandit
 <pjp@fedoraproject.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add
 the same migration blocker
In-Reply-To: <aZ670CAG40j1r2PJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 25 Feb 2026 09:07:28 +0000")
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <CAE8KmOyjB1NEtBVQ2QDiDZrPoem3eTWEi-Ht_mJZQNa-H=5iNQ@mail.gmail.com>
 <aZ670CAG40j1r2PJ@redhat.com>
Date: Wed, 25 Feb 2026 10:32:51 +0100
Message-ID: <87342pw4l8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Wed, Feb 25, 2026 at 11:35:15AM +0530, Prasad Pandit wrote:
>> On Wed, 25 Feb 2026 at 09:23, Ani Sinha <anisinha@redhat.com> wrote:
>> > Currently the code that adds a migration blocker does not check if the=
 same
>> > blocker already exists. Return an EEXIST error code if there is an att=
empt to
>> > add the same migration blocker again. This way the same migration bloc=
ker will
>> > not get added twice.
>> >
>> > Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
>> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> > ---
>> >  migration/migration.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index a5b0465ed3..1eb75fb7fb 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, unsign=
ed modes, Error **errp)
>
> This method has an  '**errp' parameter.....
>
>> >  {
>> >      for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
>> >          if (modes & BIT(mode)) {
>> > +            if (g_slist_index(migration_blockers[mode],
>> > +                                 *reasonp) >=3D 0) {
>> > +                return -EEXIST;
>
> .... so using  -errno for return values is not appropriate - it must
> set 'errp' and return -1.

Yes, it must set @errp on failure.  Returning -1 would be wrong,
because:

    int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **=
errp)
    {
        if (is_only_migratable(reasonp, modes, errp)) {
            return -EACCES;
        } else if (is_busy(reasonp, errp)) {
            return -EBUSY;
        }
        return add_blockers(reasonp, modes, errp);
    }

If callers don't actually care for error codes, the entire nest of
functions could be simplified to return 0/-1 or true/false.

>> > +            }
>> >              migration_blockers[mode] =3D g_slist_prepend(migration_bl=
ockers[mode],
>> >                                                         *reasonp);
>> >          }
>>=20
>> * Looks okay.
>> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>>=20
>> Thank you.
>> ---
>>   - Prasad
>>=20
>>=20
>
> With regards,
> Daniel


