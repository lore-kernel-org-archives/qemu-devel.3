Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B53C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 06:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trsnO-00008Y-CI; Tue, 11 Mar 2025 02:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trsnK-000089-Ni
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trsnI-0002zu-Sh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 02:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741673326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rs/58uLG2GM6qma7K0sz22eOBMPgYakwfFQHLSUcEQo=;
 b=Omhm3l23aj57FN2Po6DR6LJ+vrYLiEjOyP6IxQomxy0cizjN/PV2iKokUKHh5+zjKGSrrl
 AxKk8GVjLrXqjn0Fvn2VHbxqLhNCtja637nrEJC8WRe0BAFsV+PCZPdqxalBwSRSld8L4y
 njKue3cJjmrkVBFBd2nbB7blkpfvy0Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-YibbGfMWOmSWzxpyofY23w-1; Tue,
 11 Mar 2025 02:08:41 -0400
X-MC-Unique: YibbGfMWOmSWzxpyofY23w-1
X-Mimecast-MFC-AGG-ID: YibbGfMWOmSWzxpyofY23w_1741673320
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4FE0180882E; Tue, 11 Mar 2025 06:08:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 217581955BCB; Tue, 11 Mar 2025 06:08:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F6B621E66C4; Tue, 11 Mar 2025 07:08:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 45/62] docs/qapidoc: add visit_errors() method
In-Reply-To: <CAFn=p-ZER5NtaHvgVS+sOj=Hnki2pnrqGGDc-m2qFgYx0+vosw@mail.gmail.com>
 (John Snow's message of "Mon, 10 Mar 2025 17:17:20 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-46-jsnow@redhat.com>
 <87tt81ykwh.fsf@pond.sub.org>
 <CAFn=p-ZER5NtaHvgVS+sOj=Hnki2pnrqGGDc-m2qFgYx0+vosw@mail.gmail.com>
Date: Tue, 11 Mar 2025 07:08:35 +0100
Message-ID: <87ikog9k0s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Sun, Mar 9, 2025 at 5:05=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Notably, this method does not currently address the formatting issues
>> > present with the "errors" section in QAPIDoc and just vomits the text
>> > verbatim into the rST doc, with somewhat inconsistent results.
>> >
>> > To be addressed in a future revision.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/sphinx/qapidoc.py | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> > index b96445f0802..14feafe866e 100644
>> > --- a/docs/sphinx/qapidoc.py
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -139,6 +139,12 @@ def visit_paragraph(self, section: QAPIDoc.Sectio=
n) -> None:
>> >          self.add_lines(section.text, section.info)
>> >          self.ensure_blank_line()
>> >
>> > +    def visit_errors(self, section: QAPIDoc.Section) -> None:
>> > +        # FIXME: the formatting for errors may be inconsistent and may
>>
>> If I remember correctly, you wanted to mention this FIXME in the commit
>> message.
>>
>
> Well, that's what the entire commit message is already about! Both of the=
se
> places are talking about the visual misalignment and enforcing the source
> formatting of errors to fix the visual alignment problems.

Alright.  If the patch was larger, I'd ask you to replace

    To be addressed in a future revision.

by something like

    Marked FIXME in the code.

Both tell me there's something in need of fixing, but only the latter
tells me how to find the spot in need.

[...]


