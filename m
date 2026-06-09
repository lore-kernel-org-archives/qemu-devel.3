Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B6CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwZm-0006kL-RV; Tue, 09 Jun 2026 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwZf-0006ga-Mm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWwZd-0002lZ-K7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781011976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0ZIy5Z/bad00vxyXWqY5myYg5Ll0WT2xWmXzi7net0=;
 b=PJMP7Fqq6ytHuERMA8uBvtxRuaW6WgYBNnANcmCnGYFvUodrSj5TiDPKxxz86Z66JY29S8
 QZrvVjY2QGx9rJ4i+xh9k/lOgUaWl1crcQ8JhLVgvJMrQKEo22yZYkKTCEaldw5AowfdBW
 lAQIGgPmVnnaHsswG+xmJxexxZD1c9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-xY9pr3bGMiiB8jOVQGYFMg-1; Tue,
 09 Jun 2026 09:32:54 -0400
X-MC-Unique: xY9pr3bGMiiB8jOVQGYFMg-1
X-Mimecast-MFC-AGG-ID: xY9pr3bGMiiB8jOVQGYFMg_1781011973
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5AD718501F2; Tue,  9 Jun 2026 13:32:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D63619560AB; Tue,  9 Jun 2026 13:32:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F80321E6A01; Tue, 09 Jun 2026 15:32:49 +0200 (CEST)
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
Subject: Re: [PATCH v3 09/16] qapi/docs: adjust stub member insertion algorithm
In-Reply-To: <CAFn=p-aXcHomC4r=Gh9yQhoQzFDqxqTc2YTpaE-NOgiYDQRx_g@mail.gmail.com>
 (John Snow's message of "Thu, 4 Jun 2026 15:07:46 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-10-jsnow@redhat.com>
 <87ecinkgnv.fsf@pond.sub.org>
 <CAFn=p-aXcHomC4r=Gh9yQhoQzFDqxqTc2YTpaE-NOgiYDQRx_g@mail.gmail.com>
Date: Tue, 09 Jun 2026 15:32:49 +0200
Message-ID: <87h5nbon3y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Jun 3, 2026 at 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Quick first pass...
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > A forthcoming patch removes the implicit PLAIN section that always
>> > starts a QAPIDoc section list. Further future changes begin converting
>> > "PLAIN" sections to "INTRO" sections. To accommodate this, the
>> > insertion algorithm that places stub and dummy members must be
>> > adjusted to cope with not only the finished state, but temporary
>> > intermediate states while the series is merged.
>>
>> Perhaps:
>>
>>   A forthcoming patch removes the implicit PLAIN section that always
>>   starts a QAPIDoc section list. Further future changes begin converting
>>   "PLAIN" sections to "INTRO" sections.
>>
>>   This will affect the code that inserts "Not documented" descriptions
>>   for undocumented members ("stub sections") and the dummy section that
>>   marks the spot for "The members of ..." references.
>>
>>   Adjust the algorithm to cope with not only the finished state, but
>>   temporary intermediate states while the series is merged.
>
> Sure.
>
>>
>> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at
>> > the beginning of a QAPIDoc object, in contrast to the previous
>> > algorithm which assumed and relied upon there being always one PLAIN
>> > section at the beginning of every QAPIDoc section list.
>> >
>> > In other words: (PLAIN | INTRO)* <EverythingElse>
>> >
>> > This does not impact what the parser itself will actually produce. As
>> > of this patch, the parser will still always generate QAPIDoc section
>> > lists that start with precisely one PLAIN section (whether or not it
>> > is empty), followed by the remaining sections. Those remaining
>> > sections may or may not include additional PLAIN sections, but never
>> > two such sections contiguously as the parser will always treat that
>> > layout as one PLAIN section consisting of multiple paragraph(s).
>> >
>> > In other other words: This insertion algorithm is more lenient than
>> > the parser, but this is on purpose for flexibility mid-stream as we
>> > convert QAPI to using explicit introductory sections. The allowed
>> > order of sections will eventually become strictly enforced in the
>> > parser, which will in turn allow dramatic simplifications to the
>> > insertion algorithm. This only exists as transitory code until we are
>> > able to enforce that order.
>> >
>> > Fear not: the intermediate rest output before and after this patch
>>
>> "ReST output"?
>
> Sure
>
>>
>> > are byte identical, so failing all else, we at least know it doesn't
>> > make anything worse.
>> >
>> > Lastly, because we have three places in the code that need to insert
>> > stub/dummy sections, we take the opportunity to consolidate this code
>> > to handle all three cases with one function. This winds up
>> > necessitating the qapidoc.py generator actually modify the section
>> > list to insert a "dummy" member that acts as a placeholder for "The
>> > members of ..." text. While it looks like a code smell to modify the
>> > caller's argument, it is ultimately safe because the QAPI Schema
>> > object is re-parsed and re-constructed in memory for each individual
>> > process that needs to operate on it. In other words, the Sphinx
>> > document generator already does have "its own copy" of the section
>> > lists, so it is "safe" to modify here without regards to other
>> > consumers of the QAPIDoc objects. It only *looks* like it smells
>> > bad. Ultimately, this code will also be removed once the inliner is
>> > merged, so it is only a temporary aesthetic issue regardless.
>>
>> Such trickery, even when safe, risks making attentive readers go
>> "WAT?!?"  I find it tolerable only because we plan to replace it fairly
>> soon.
>>
>> The code finding the spot to insert stub/dummy sections is more
>> complicated than it has any right to be, both before and after your
>> patch.  It reconstructs information the doc parser has, but doesn't pass
>> on in usable form.  Passing that info on would likely be simpler and
>> cleaner.  However, you tell me your inliner patches also simplify
>> things, and they already exist.  So let's go with those.
>
> Right, the basic idea is this:
>
> - Differentiate INTRO with new syntax
> - Convert "PLAIN" into "DETAILS"
> - Enforce strict section ordering: INTRO only at the beginning,
> DETAILS only at or quite near to the end
>
> Once that is cemented, the insertion algorithm can become much simpler
> and dumber; e.g. using a map of regions where we can append to the end
> of a region without having to iterate through to find our sweet spot.
>
> Since that's the plan for the inliner anyway, some temporary ugliness
> here in order to ensure that we do not regress even one byte seems
> acceptable.
>
> Additionally, once the inliner is merged, we won't need the "dummy"
> sections at all, so those go away entirely, and all of the ugliness of
> that particular part of the hack with it - i.e. no more modifying the
> caller's argument to insert a bookmark.
>
> So, it's a little gross, but it's just a band-aid to get to where we
> want to be; and it isn't as gross as it looks.
>
> With your suggested commentary changes, do I have your blessing to
> push forward? In the interim, please review the rest of the series so
> I can send you a new version.

Yes, you do.

In addition to the commit message changes, I'd like to have a comment in
the code.

Perhaps as separate patch before your series:

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c3cf33904e..844afc6e0e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -852,6 +852,12 @@ def connect_feature(self, feature: 'QAPISchemaFeature'=
) -> None:
=20
     def ensure_returns(self, info: QAPISourceInfo) -> None:
=20
+        # This is more complicated than it ought to be.  The doc
+        # parser should already know where a generated RETURNS section
+        # should go.  It currently doesn't, mostly because it accepts
+        # tagged sections in any order.
+        # TODO Tighten doc syntax and simplify.
+
         def _insert_near_kind(
             kind: QAPIDoc.Kind,
             new_sect: QAPIDoc.Section,
--=20
2.54.0

We could adjust the comment within your series to also cover the new
uses of _insert_near_kind(), but I don't think that's necessary.  It
should serve as a reminder as is.

If that works for you, I'll post the patch.

>
> --js
>
>>
>> > That's my story and I'm sticking to it.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>


