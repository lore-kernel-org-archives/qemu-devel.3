Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A771D0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 18:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNy61-0005IN-4D; Tue, 25 Nov 2025 13:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNy5z-0005H3-6z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNy5w-0004uE-98
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764096534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nnqcact2EdIgjSTgUOjubS6o/GHm23dxPYUw0puhoe0=;
 b=J2dgh/lG1Ky5Do80AIwIAEwCLvyLpH+Ig9mgMYSm1nJUO5VBQDpYczYynsmRvSg+MwzoP6
 wjjr6SfhRL86858cwzRUa5welcMWFSaGUMzy/xgEw8ZCwEh1C/dtOiM6XzSjDv7y+sOKzs
 4S9EgGZqHpwJ5Zex6/ai6dgULmU6PTU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-nPHI7yhNOqy91EHCqn3ilQ-1; Tue,
 25 Nov 2025 13:48:48 -0500
X-MC-Unique: nPHI7yhNOqy91EHCqn3ilQ-1
X-Mimecast-MFC-AGG-ID: nPHI7yhNOqy91EHCqn3ilQ_1764096527
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32C63180035F; Tue, 25 Nov 2025 18:48:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4C918004D8; Tue, 25 Nov 2025 18:48:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E36221E6A27; Tue, 25 Nov 2025 19:48:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, farosas@suse.de,  peter.maydell@linaro.org
Subject: Re: [PATCH] migration: Fix double-free on error path
In-Reply-To: <aSXPhOV86fyaY53_@x1.local> (Peter Xu's message of "Tue, 25 Nov
 2025 10:47:16 -0500")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 <875xayxo6t.fsf@pond.sub.org> <aSXPhOV86fyaY53_@x1.local>
Date: Tue, 25 Nov 2025 19:48:44 +0100
Message-ID: <87ikeygd83.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 25, 2025 at 01:59:54PM +0100, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>=20
>> > Hi
>> >
>> > On Tue, Nov 25, 2025 at 11:06=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >>
>> >> Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropri=
ate)
>> >> Resolves: Coverity CID 1643463
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> >> ---
>> >>  migration/multifd.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/migration/multifd.c b/migration/multifd.c
>> >> index 6210454838..3203dc98e1 100644
>> >> --- a/migration/multifd.c
>> >> +++ b/migration/multifd.c
>> >> @@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
>> >>   */
>> >>  static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
>> >>  {
>> >> -    g_autoptr(Error) local_err =3D NULL;
>> >> +    Error *local_err =3D NULL;
>> >>
>> >>      if (!migration_has_failed(migrate_get_current()) &&
>> >>          object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
>> >> --
>> >> 2.49.0
>> >>
>> >
>> > Maybe warn_reportf_err() should take a Error **err instead, and clear
>> > it (and accept NULL values)
>>=20
>> Our deallocating functions don't work that way.

g_free(), g_realloc(), freeaddrinfo(), qapi_free_T(), visit_free(),
qcrypto_FOO_free(), aio_task_pool_free(), qemu_opts_free(),
timer_free(), ...

>> Having them take a pointer by reference and clear it gets rid of *one*
>> dangling reference.  There may be more.
>
> True.  However I need to confess I like Marc-Andr=C3=A9's proposal.. Norm=
ally we
> only have one Error object, or >1 objects.
>
> The only thing I'm not sure is such design doesn't match with the error A=
PI
> (e.g. current form matches the more famous error_report_err(), and likely
> others that I'm not familiar).  So at least this will need some more
> thoughts before all the code churns.

The error.h functions and macros that free an Error object are:

* error_free(), error_free_or_abort()

  These take a single Error * argument.

* error_report_err(), warn_report_err(), error_reportf_err(),
  warn_reportf_err(). warn_report_err_once_cond(),
  warn_report_err_once()

  These take also a single Error * argument.

* error_propagate(), error_propagate_prepend()

  These take an Error ** destination, and an Error * object to be
  propagated.  They take ownership of the latter.  They either store it
  in the destination, or free it.

  Changing the latter to Error ** makes these functions vulnerable to
  swapped arguments.  See "Error ** parameters are almost always for
  returning errors" below.

* ERRP_GUARD()

  Includes automatic error_propagate() on return, immune to use after
  free.

>
> Thanks,
>
>>=20
>> Coverity is fairly good at finding the kind of use after free this could
>> avoid.
>>=20
>> Error ** parameters are almost always for returning errors.  Not having
>> to wonder what such a parameter is for makes code easier to read.

My main argument remains this one: our deallocating functions don't work
that way.  For better or worse.

I don't want the Error API free differently.


