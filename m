Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED50C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLvG-0000PS-K1; Tue, 20 Feb 2024 03:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcLvF-0000Ci-2r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcLv1-0000S8-Ga
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gxt5ZYw2h95J0F7OawIZiKr2hLJwNBBaXxLoUe7n10w=;
 b=EuZVfJWyn7D4uzRVjYMhYXPUj9I/c38mc2KGx+8ykbP4CbJAraSO/zZ0zWHitjQPRrh2tX
 aI2WXq9JDI2kXs16fhmY+Y7VPGDz6+XSbI3eIQyijr8uiKQs3J4uOIpRH4rz383IZl96e4
 CyYU/34DbnqMlZCxzd8eEpHkIjy7eRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-r12Rug4zM1i7AU-5g2OCtw-1; Tue, 20 Feb 2024 03:55:56 -0500
X-MC-Unique: r12Rug4zM1i7AU-5g2OCtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73BC5185A786;
 Tue, 20 Feb 2024 08:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 125CC107CCE0;
 Tue, 20 Feb 2024 08:55:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8AED21E66D5; Tue, 20 Feb 2024 09:55:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH v4 2/7] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
In-Reply-To: <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
 (Yong Huang's message of "Tue, 20 Feb 2024 15:31:54 +0800")
References: <cover.1706586786.git.yong.huang@smartx.com>
 <af7253711254128efbc37b25fb5c47b851367ce7.1706586786.git.yong.huang@smartx.com>
 <87zfvwjzzd.fsf@pond.sub.org>
 <CAK9dgmY0rExYg+hfTY_okNvTTArZdn60jsWjCABgbbAG6XZiDw@mail.gmail.com>
Date: Tue, 20 Feb 2024 09:55:54 +0100
Message-ID: <87wmqzcy5h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Yong Huang <yong.huang@smartx.com> writes:

> On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> yong.huang@smartx.com writes:
>>
>> > From: Hyman Huang <yong.huang@smartx.com>
>> >
>> > To support detached LUKS header creation, make the existing 'file'
>> > field in BlockdevCreateOptionsLUKS optional.
>> >
>> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> [...]
>>
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index ae604c6019..69a88d613d 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -4957,7 +4957,8 @@
>> >  #
>> >  # Driver specific image creation options for LUKS.
>> >  #
>> > -# @file: Node to create the image format on
>> > +# @file: Node to create the image format on, mandatory except when
>> > +#        'preallocation' is not requested
>>
>> You mean when @preallocation is "off"?
>>
>> Cases:
>>
>> 1. @file is mandatory
>>
>
> When @preallocation is specified to PREALLOC_MODE_ON, file
> is mandatory because preallocation aims to act on payload data that
> @file holds.
>
>
>> 2. @file is optional and present
>>
>
> When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> @file if optional.
> If @file present=EF=BC=8Cthere are two cases:
> 1. @header is absent,  the creation process degenerate to the origin acti=
on.
> 2. @header is present,  the creation process would trunk the payload data
> image that @file holds and do the LUKS formatting on the image that
> @header refers;
>
>
>>
>> 3. @file is optional and absent
>>
>
> When @preallocation is not specified or equals to PREALLOC_MODE_OFF,
> @file if optional.
> If @file is absent, do the LUKS formatting only.
> Note that Either the parameter 'header' or 'file' must be specified.
>
> Here's my interpretation; do let me know if any of the points are off or
> need to be refactored.
>
>
>>
>> Ignorant question: behavior in each case?

Thanks!  Would it make sense to work the above into the documentation?

[...]


