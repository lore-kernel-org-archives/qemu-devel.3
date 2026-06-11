Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E6CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYNV-00052W-4e; Thu, 11 Jun 2026 01:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXYNT-00052O-Mf
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXYNR-0003Nq-Li
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781157291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1L573xuZLWoLLxhd+5lpmTNV0e6QxbN5IXb7+RwwK8=;
 b=Kq9yXDRaB8FoE6A1GMfR4OzYZd45Lha03xfSoi2EXlsjWKO/EV2siVKLi2KeUqvljA9N9T
 MsfuryX7uCrDvdGgj40cgkxbGBhNBa1pwhq8YL6oNos7O8vXrs4OA1I8IGKgz9BSr6CRE8
 xek9rYzaoP233gLTHt4jDeylifP+Dh8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-9yp-fdasNdq8lazfAN3pTg-1; Thu,
 11 Jun 2026 01:54:49 -0400
X-MC-Unique: 9yp-fdasNdq8lazfAN3pTg-1
X-Mimecast-MFC-AGG-ID: 9yp-fdasNdq8lazfAN3pTg_1781157288
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB0E91956080; Thu, 11 Jun 2026 05:54:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E47DC1954B0B; Thu, 11 Jun 2026 05:54:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EAA921E6A01; Thu, 11 Jun 2026 07:54:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 12/16] qapi/docs: add "Intro" section parsing
In-Reply-To: <CAFn=p-YJg_KhMf3vHZYP-4F1FVsA-MOE=ydRAmUv5srdVteuwQ@mail.gmail.com>
 (John Snow's message of "Tue, 9 Jun 2026 14:57:51 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-13-jsnow@redhat.com>
 <874ijboms6.fsf@pond.sub.org>
 <CAFn=p-YJg_KhMf3vHZYP-4F1FVsA-MOE=ydRAmUv5srdVteuwQ@mail.gmail.com>
Date: Thu, 11 Jun 2026 07:54:44 +0200
Message-ID: <87se6tfwpn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jun 9, 2026 at 9:39=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Add parsing for explicit Intro section syntax.
>> >
>> > A side effect of this patch is that we will (currently) always create
>> > an empty Intro section, similar to how we used to have an empty Plain
>> > section. The tests are adjusted accordingly, rendered document output
>> > does not change at all.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  docs/devel/qapi-code-gen.rst   | 16 +++++++---------
>> >  scripts/qapi/parser.py         |  4 ++--
>> >  tests/qapi-schema/doc-good.out | 18 ++++++++++++++++++
>> >  3 files changed, 27 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st
>> > index 3a632b4a648..b1cc5b5f0db 100644
>> > --- a/docs/devel/qapi-code-gen.rst
>> > +++ b/docs/devel/qapi-code-gen.rst
>> > @@ -984,11 +984,11 @@ definition it documents.
>> >  When documentation is required (see pragma_ 'doc-required'), every
>> >  definition must have documentation.
>> >
>> > -Definition documentation starts with a line naming the definition,
>> > -followed by an optional overview, a description of each argument (for
>> > -commands and events), member (for structs and unions), branch (for
>> > -alternates), or value (for enums), a description of each feature (if
>> > -any), and finally optional tagged sections.
>> > +Definition documentation starts with a description naming the
>> > +definition with an optional indented overview, a description of each
>> > +argument (for commands and events), member (for structs and unions),
>> > +branch (for alternates), or value (for enums), a description of each
>> > +feature (if any), and finally optional tagged sections.
>> >
>> >  Descriptions start with '\@name:'.  The description text must be
>> >  indented like this::
>>
>> This works if we convert the entire schema in the same series.  I guess
>> that's the plan.  Is it?
>
> I still plan to do it piecemeal: I will probably send everything out
> in a big series, but you will be able to cherry-pick and stage those
> patches individually as you feel they are ready. This way, modules
> that need further revisions don't hold up the entire series and v2,
> v3, etc won't email bomb all of creation just to fix an indent in a
> single module somewhere.

We'll see.

The important bit is separating "split the initial part into intro (to
be discarded by the inliner) and non-intro (to be kept)" from purely
mechanical "make the entire initial part syntactically intro".

The transition to intro syntax will likely be bothersome for
contributors, and I feel kind of bad about it.  But I also feel we do
need to make intro syntactically obvious.  We could try to ease the pain
by silently accepting old-style patches (not using intro syntax) for a
while, then have another bulk conversion.

> I think this documentation still covers it just fine: "an optional
> indented overview". Technically the things we haven't converted just
> omit that indented overview. Those overviews just remain as
> "plaintext".

You're right.  "Optional" carries even more weight here than I thought.

> It's not perfect documentation, but the expected window where we have
> two competing systems should be quite small in the grand scheme, so I
> don't think it's worth writing docs to cover the technicalities of the
> transition.

Okay.

[...]


