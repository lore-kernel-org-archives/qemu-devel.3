Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6224C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjwdS-0004rH-VY; Tue, 12 Mar 2024 03:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjwdP-0004p5-S4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjwdK-0008UY-P6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710228789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBJbLgXBoXLAEQv/QWpxuAKF3ihikf9XZLw6grnfFlg=;
 b=VrBiJ5yXCbYI3XrP8OQXkjxSBt7EBAlRKpW1U2iIacPcRP8Cz5+vHxXZSzcuBsKeoztDr5
 Tpx/+ImFBtNVtVOKKkXs9YVPsXiyKKc8yXFQMjQPl2AJR8jTCquDzG2/4XBL62/7TVjBW9
 SverpiHkhpOpeCq25NJ1aOPRyY7Z9GI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-y7D44nroNVyjI_zBsVvy3g-1; Tue, 12 Mar 2024 03:33:05 -0400
X-MC-Unique: y7D44nroNVyjI_zBsVvy3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4484D8007BA;
 Tue, 12 Mar 2024 07:33:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C9E62166AE4;
 Tue, 12 Mar 2024 07:32:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E65C21E6A24; Tue, 12 Mar 2024 08:33:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 09/20] qapi/schema: assert resolve_type has 'info'
 and 'what' args on error
In-Reply-To: <CAFn=p-aCvfk_6kjhn8W02_Wjn+nSjP1KmFQ7dfFgRAvqKx0j8A@mail.gmail.com>
 (John Snow's message of "Mon, 11 Mar 2024 14:37:17 -0400")
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-10-jsnow@redhat.com>
 <87v86jbee6.fsf@pond.sub.org>
 <CAFn=p-aCvfk_6kjhn8W02_Wjn+nSjP1KmFQ7dfFgRAvqKx0j8A@mail.gmail.com>
Date: Tue, 12 Mar 2024 08:33:04 +0100
Message-ID: <87o7bjoqfj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Feb 20, 2024 at 5:48=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > resolve_type() is generally used to resolve configuration-provided type
>> > names into type objects, and generally requires valid 'info' and 'what'
>> > parameters.
>> >
>> > In some cases, such as with QAPISchemaArrayType.check(), resolve_type
>> > may be used to resolve built-in types and as such will not have an
>> > 'info' argument, but also must not fail in this scenario.
>> >
>> > Use an assertion to sate mypy that we will indeed have 'info' and 'wha=
t'
>> > parameters for the error pathway in resolve_type.
>> >
>> > Note: there are only three callsites to resolve_type at present where
>> > "info" is perceived to be possibly None:
>>
>> Who is the perceiver?  mypy?
>
> Deep.
>
> Yes.

Recommend active voice: "where mypy preceives @info to be possibly None".

>>
>> >
>> >     1) QAPISchemaArrayType.check()
>> >     2) QAPISchemaObjectTypeMember.check()
>> >     3) QAPISchemaEvent.check()
>> >
>> >     Of those three, only the first actually ever passes None; the othe=
r two
>> >     are limited by their base class initializers which accept info=3DN=
one, but
>> >     neither subclass actually use a None value in practice, currently.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index e617abb03af..573be7275a6 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -1004,6 +1004,7 @@ def lookup_type(self, name):
>> >      def resolve_type(self, name, info, what):
>> >          typ =3D self.lookup_type(name)
>> >          if not typ:
>> > +            assert info and what  # built-in types must not fail look=
up
>> >              if callable(what):
>> >                  what =3D what(info)
>> >              raise QAPISemError(
>> <
>>


