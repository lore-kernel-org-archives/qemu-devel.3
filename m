Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413C5CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysZg-0001Z5-Ii; Wed, 17 Sep 2025 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uysZf-0001Yj-FV
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uysZc-0005Hw-QW
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758117108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cvROPxFzU5xuQgS3BZPqtW0MKo3iLf5nbftd50VRhqI=;
 b=E3z1qlVJX6o2i64448s7sOjEXCxyskAu8kR43rbMAz8UTYlP4HPuIWP+DZ71MsO3jWtPOM
 lWLpasy+gFPuYzdx792KCHyGrzGXLeV8SyjCZGTzVE5CMxUvDeB5luj9cRFd2+vOXMy0+O
 Nrrc8hQGVtqkX1psvJE+xI4iGNsUc4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-6SuqBo8sOKOeMeFSgxgAmA-1; Wed,
 17 Sep 2025 09:51:44 -0400
X-MC-Unique: 6SuqBo8sOKOeMeFSgxgAmA-1
X-Mimecast-MFC-AGG-ID: 6SuqBo8sOKOeMeFSgxgAmA_1758117101
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D61180057A; Wed, 17 Sep 2025 13:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11296180044F; Wed, 17 Sep 2025 13:51:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6090721E6A27; Wed, 17 Sep 2025 15:51:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Peter Xu
 <peterx@redhat.com>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,
 leiyang@redhat.com,  marcandre.lureau@redhat.com,  Michael Roth
 <michael.roth@amd.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v3 04/13] util/error: add &error_reporter
In-Reply-To: <aMhbFcvItNMBtQhN@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Sep 2025 19:29:41 +0100")
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
 <20250915132211.135095-5-vsementsov@yandex-team.ru>
 <aMg0l0xgq3hdiDnh@x1.local>
 <c1907e57-d279-40fa-b181-3b54441c49d7@yandex-team.ru>
 <aMhbFcvItNMBtQhN@redhat.com>
Date: Wed, 17 Sep 2025 15:51:37 +0200
Message-ID: <87jz1x426u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Mon, Sep 15, 2025 at 09:14:18PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> On 15.09.25 18:45, Peter Xu wrote:
>> > On Mon, Sep 15, 2025 at 04:22:01PM +0300, Vladimir Sementsov-Ogievskiy=
 wrote:
>> > > Add a pair to &error_warn helper, to reduce the pattern like
>> > >=20
>> > >      Error *local_err =3D NULL;
>> > >=20
>> > >      ...
>> > >=20
>> > >      if (!foo(..., &local_err)) {
>> > >          error_report_err(local_err);
>> > >          return false;
>> > >      }
>> > >=20
>> > > to simply
>> > >=20
>> > >      if (!foo(..., &error_reporter)) {
>> > >          return false;
>> > >      }
>> > >=20
>> > > Of course, for new interfaces, it's better to always support and han=
dle
>> > > errp argument. But when have to rework the old ones, it's not always
>> > > feasible to convert everything to support/handle errp.
>> > >=20
>> > > The new helper is used in following commits.
>> >=20
>> > Could we add some explanation of why we need this if we already have
>> > error_warn?
>> >=20
>> > I don't see much difference except error_warn will prepend it with
>> > "warning: ", but that doesn't sound like a real problem..
>>=20
>> Yes, seems it's the only difference.
>>=20
>> For me it seems strange to call it "warning", when we actually go to fai=
lure branch of the code logic.
>> Finally, we do have error_report() and warn_report(). Seems not a proble=
m to have corresponding "magic" variables.
>>=20
>> If have only one special error variable to simply report the error, I'd =
prefer it not have "warning: " prefix.
>> I.e. drop error_warn, and keep only error_reporter (or some better name?=
).
>
> FWIW, this whole debate is liable to be a bit of a can of worms that
> will delay your series from getting merged.
>
> Can I suggest you repost this without &error_reporter usage, and then
> have a separate standalone series that proposes error_report, and
> converts a handful of files to demonstrate its usage.

Seconded.

Please note the killing of &error_warn is in progress:

    Subject: [PATCH v2 00/12] Error reporting cleanup, a fix, and &error_wa=
rn removal
    Date: Wed, 17 Sep 2025 13:51:55 +0200
    Message-ID: <20250917115207.1730186-1-armbru@redhat.com>
    https://lore.kernel.org/qemu-devel/20250917115207.1730186-1-armbru@redh=
at.com/

Rationale in PATCH 12.

I doubt additional special error destinations are a good idea.
&error_abort definitely is a good idea.  &error_fatal is problematic,
but widely used.

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> suggested to add one that
at a glance looks just like yours.  Please see my reply at

    Message-ID: <87a548sgjl.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87a548sgjl.fsf@pond.sub.org/


