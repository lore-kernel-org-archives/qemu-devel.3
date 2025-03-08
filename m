Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EEDC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 09:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqqMU-0006o3-28; Sat, 08 Mar 2025 04:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqqMS-0006nY-K7
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 04:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqqMR-0003Ym-2U
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 04:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741425644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+a2/MdED3U1Ns91jE3+n9Mm/wmTgbAYLFt3qbRZYlw=;
 b=TJil88hqHVFLAjSWKaFMOSFsJvlKtP3VVt5nd1IMbkJHe1DPNavsw8i5fXM0mUNShbhtiy
 mwqJ81RkKmC4Pz/M7rQyrGauADF2MaOHr2Dd5IWRRFG4xEJA6zTeUUeEWZO1jyT5jDSNE+
 I6vU/CvIWPHpWXLa0mqNKXipDupJbqw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-PoRarZQyN-evQMXROGEXlg-1; Sat,
 08 Mar 2025 04:20:40 -0500
X-MC-Unique: PoRarZQyN-evQMXROGEXlg-1
X-Mimecast-MFC-AGG-ID: PoRarZQyN-evQMXROGEXlg_1741425639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84AA019560BB; Sat,  8 Mar 2025 09:20:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F5C21828A8D; Sat,  8 Mar 2025 09:20:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F86F21E675F; Sat, 08 Mar 2025 10:20:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 50/57] docs/qapidoc: add visit_sections() method
In-Reply-To: <CAFn=p-YEM+DKhmi5h59EUSC9sWLMvAe3S4ibzV=1sN5z9gE7Gg@mail.gmail.com>
 (John Snow's message of "Sat, 8 Mar 2025 03:10:03 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-51-jsnow@redhat.com>
 <87wmd1hvse.fsf@pond.sub.org>
 <CAFn=p-YEM+DKhmi5h59EUSC9sWLMvAe3S4ibzV=1sN5z9gE7Gg@mail.gmail.com>
Date: Sat, 08 Mar 2025 10:20:35 +0100
Message-ID: <87ikojanfg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Mar 7, 2025 at 7:26=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Implement the actual main dispatch method that processes and handles t=
he
>> > list of doc sections for a given QAPI entity.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
>> >  1 file changed, 25 insertions(+)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index ed0269af27d..7308fa0a767 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -288,6 +288,31 @@ def preamble(self, ent: QAPISchemaDefinition) ->
>> None:
>> >
>> >          self.ensure_blank_line()
>> >
>> > +    def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>> > +        sections =3D ent.doc.all_sections if ent.doc else []
>> > +
>> > +        # Add sections *in the order they are documented*:
>>
>> Is the order important, or just a matter of style?
>>
>
> I meant to emphasize the fact that the transmogrifier works "dumbly" on a
> sequence of sections and nothing else; so the output is strictly in source
> order.

Would

              # Add sections in source order

be clearer?

> The order does wind up mattering a *little*; if you randomized the section
> order you'd not get good field list grouping, and/or the grouping
> mechanisms would re-order the documentation so that it wasn't source order
> anymore.
>
> Not that this would happen with our parser, but, you asked.

[...]


