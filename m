Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5B4D0E6DB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 13:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNseM-0002Vs-Bh; Tue, 25 Nov 2025 08:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNseL-0002Ug-3x
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:00:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNseJ-0005T0-8d
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764075602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PbC6lixeLfrowSwo4UiR1ssKgCsAWbmrWLbBnzpTCQ=;
 b=N5P0m11ANPBGG3/o8SV3fSsD52jLrjyBHdVodb7gAZl9F/+8IXGzrFXe75LuZvUExJ9wlX
 ZfHswYa7E+qefX8plcYpAccNFBmSyauQ7DHBc53ERIWQXj6XnMKWRPIu2pi0K6LYfNL/13
 YuVYLpddFNnIYgcw744xqY84kUV6vpU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-JiDaWN2XPnaB0i2KFTj8SA-1; Tue,
 25 Nov 2025 07:59:58 -0500
X-MC-Unique: JiDaWN2XPnaB0i2KFTj8SA-1
X-Mimecast-MFC-AGG-ID: JiDaWN2XPnaB0i2KFTj8SA_1764075597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DD691956052; Tue, 25 Nov 2025 12:59:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6263195608E; Tue, 25 Nov 2025 12:59:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89EA821E6A27; Tue, 25 Nov 2025 13:59:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 peter.maydell@linaro.org
Subject: Re: [PATCH] migration: Fix double-free on error path
In-Reply-To: <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 25 Nov 2025
 11:12:33 +0400")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
Date: Tue, 25 Nov 2025 13:59:54 +0100
Message-ID: <875xayxo6t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Nov 25, 2025 at 11:06=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
>> Resolves: Coverity CID 1643463
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>> ---
>>  migration/multifd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 6210454838..3203dc98e1 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
>>   */
>>  static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
>>  {
>> -    g_autoptr(Error) local_err =3D NULL;
>> +    Error *local_err =3D NULL;
>>
>>      if (!migration_has_failed(migrate_get_current()) &&
>>          object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
>> --
>> 2.49.0
>>
>
> Maybe warn_reportf_err() should take a Error **err instead, and clear
> it (and accept NULL values)

Our deallocating functions don't work that way.

Having them take a pointer by reference and clear it gets rid of *one*
dangling reference.  There may be more.

Coverity is fairly good at finding the kind of use after free this could
avoid.

Error ** parameters are almost always for returning errors.  Not having
to wonder what such a parameter is for makes code easier to read.

Thanks for your review!


