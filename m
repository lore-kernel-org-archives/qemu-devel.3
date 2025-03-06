Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D3C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5F7-0000TT-Hv; Thu, 06 Mar 2025 02:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5Ep-0000RU-4Z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5En-0008Rf-F7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741244503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WieLpeoZ1sLfik+qjKxFRib/hxSsMUqzrinlObF1Wuw=;
 b=TiuPvPJUV8EmEjYZ+/U1g983N6HpsQVFthAo/vYsuJXwRzo4wTTPH2SURzmgtzmck4THOl
 6NtP9Ov5juHfU+VyRZ4MccrqotZbpBXbL2bM5dcfPT50sgBIobhMHb3qK3qeno628My2pN
 CrpJimR3EUAuuyQDvdvqb4kocHM1qxM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-_OkWhRTJM4SaJwdVY4I_Xw-1; Thu,
 06 Mar 2025 02:01:25 -0500
X-MC-Unique: _OkWhRTJM4SaJwdVY4I_Xw-1
X-Mimecast-MFC-AGG-ID: _OkWhRTJM4SaJwdVY4I_Xw_1741244484
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 496B11956050; Thu,  6 Mar 2025 07:01:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0C8B1956095; Thu,  6 Mar 2025 07:01:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6790521E66C1; Thu, 06 Mar 2025 08:01:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 39/57] qapi/source: allow multi-line QAPISourceInfo
 advancing
In-Reply-To: <CAFn=p-ZngFzWDyKgkKzxs1Uv_rnn2RVtVeFMJUb_BkFCDCe1Rw@mail.gmail.com>
 (John Snow's message of "Wed, 5 Mar 2025 22:13:53 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-40-jsnow@redhat.com>
 <871pvbojdc.fsf@pond.sub.org>
 <CAFn=p-ZngFzWDyKgkKzxs1Uv_rnn2RVtVeFMJUb_BkFCDCe1Rw@mail.gmail.com>
Date: Thu, 06 Mar 2025 08:01:21 +0100
Message-ID: <87r03afxry.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

> On Wed, Mar 5, 2025 at 5:35=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This is for the sake of the new rST generator (the "transmogrifier") so
>> > we can advance multiple lines on occasion while keeping the
>> > generated<-->source mappings accurate.
>> >
>> > next_line now simply takes an optional n parameter which chooses the
>> > number of lines to advance.
>> >
>> > RFC: Here's the exorbitant detail on why I want this:
>> >
>> > This is used mainly when converting section syntax in free-form
>> > documentation to more traditional rST section header syntax, which
>> > does not always line up 1:1 for line counts.
>>
>> Obvious way to resolve the RFC:
>>
>>   The next patch will use this when converting ...
>>
>> >
>> > For example:
>> >
>> > ```
>> >  ##
>> >  # =3D Section     <-- Info is pointing here, "L1"
>> >  #
>> >  # Lorem Ipsum
>> >  ##
>> > ```
>> >
>> > would be transformed to rST as:
>> >
>> > ```
>> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
>> > Section        <-- L1
>> > =3D=3D=3D=3D=3D=3D=3D        <-- L1
>> >                <-- L2
>> > Lorem Ipsum    <-- L3
>> > ```
>>
>> Not a demand, just wondering: could we drop our headings syntax and just
>> use rST?
>>
>
> Yes, once we drop the old qapidoc fully, which I am not sure I can do
> before freeze ... So we have some goofy stuff in the meantime.

No need to do it before the freeze.  Trying to do it before might be
self-sabotage ;)

> You suggested before I can rewrite the freeform generator to avoid needing
> this; I wrote the freeform generator to be as close to the old one as I
> could, but we could kerjiggle it if needed.
>
> ... On the other hand, this is a patch for a +=3D n, so... eh.
>
> --js


