Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917A6CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1RS-0002AB-0W; Tue, 09 Jun 2026 14:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1RJ-00029i-9h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1RG-00027o-QM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781030677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AByx2FtauF+8eI0JWwoZcYoW1uS/7f+DmdO9izDp8ZI=;
 b=YG9MsLm39+bAlGdtVs/cESnsl6HBWvqLV014FRnOH3oGLLN12ABwBaigrtO8hRdOkWwc45
 LDnEYWC41gg5tqjfIF1ROpaad5BrneBxltr0v2UQz8yJvZOgmPxalJHv5oJMJum04RF+2g
 hYcpG7KeIhiA4XQvwfLV7PQCcl/jogc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-pAJJJ2eNPS-85DVfOugV1w-1; Tue, 09 Jun 2026 14:44:35 -0400
X-MC-Unique: pAJJJ2eNPS-85DVfOugV1w-1
X-Mimecast-MFC-AGG-ID: pAJJJ2eNPS-85DVfOugV1w_1781030675
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5176d949c58so147274551cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781030675; cv=none;
 d=google.com; s=arc-20240605;
 b=QPPzTWvSyjZ41tsr157uNfj2ovw4Yw1CI0OO7BFZEEVtYTBzVvQim/Tr+eTR76L5bk
 mAfzSLyRZdEGCFuHVP2tGBEUtzBfCz4beABdmtE1QlLZ9RpCwcMGRVEhG0ou7uouk0lk
 GemYIFw3SXii/p9aX37pKRDRE9S095NRRuSrEtTAEvne4PNmOhW6R7GpfzRG3wJiXnJ6
 jqU25PW3wOToO1Epe010XZeiRHas8U71qtyM91+PvOLgjh8KK9n0ZS/gHDfgUB4hcDbl
 cCOnAuI3hM1uNBWTGsGNzFFUDsFQIYOyCMBrOiQiFywFEJnFkiBbEEUdODZF24cwmIWm
 m1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AByx2FtauF+8eI0JWwoZcYoW1uS/7f+DmdO9izDp8ZI=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=LbTLn0kq/ixgpJX7lSmH2eBm4FBTbEhjGH6XX6dDiYnURVRY7Al9kt1EMCf++TU4Lx
 ZvXkfiGdhg8ozA10FTnNG+ytljeKorEHYPlJeCApBPfkL4McWOK17hgzsinvO6NQtbJU
 /w6ywOhgl6NdsOW0XBZFCM8LWtZBxbsacNZmbLin+kU5dYgk0n7EElNEesQuaDr2cJpX
 o2DhbplMfOL75do6R6wCdkkN8EqXCMfL+nZoaGnW6nUfefio+4BVdTHK3UyZ12wNgRC2
 Uvm48uDD013s2SR0CRjC6XfnE4KHGVzKRDxYNbswj1t/mJ4AHHzIRDmCTe+tcK/dhZps
 BFfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781030675; x=1781635475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AByx2FtauF+8eI0JWwoZcYoW1uS/7f+DmdO9izDp8ZI=;
 b=EYsSDw6pGi7jB4lmtMxLoUQbKdsxOOnWdgHTbr1CDVw8otsSk5UE2Bc8eSfzqj850U
 yWYlYZE2aIdcZkT0NXMMmSJd21ZEBoC/0vZ4qUIFpNSRLN9gkr6tOFNt43dgB5AlVynf
 zQxt6ha3Amzu/Zn/xTo53En+bg/aDc45rxLSr556WEQFNVcuxbaYE4z1QpeQgzeVKME8
 jaky/sDzqZxNQcyAz0C0oxTb7HO57683iqCdCm0b4chdS70a7WzSI8+LjiMBGxqym/9I
 XhngFOEuwk3L1ApglUGZpT48+W96JWspb5CEP8Uez430XmIvS0+dD/iP/sOrP7/yZ/We
 y0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781030675; x=1781635475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AByx2FtauF+8eI0JWwoZcYoW1uS/7f+DmdO9izDp8ZI=;
 b=kcRIoGl3PY0/2+lpcJpl2Z1HWg5mIh3mGjkQkjCaukXu5FLIWuTsBOezvJqo5C/b8H
 nDJtIv9MjzQXebSF1QTJyufw+OftfVDoJ9P/0aZmI/ZACFtGAs8F6WNXkO3PiPLqpy2n
 +20P0uncnhSDgkFylYqAT1v/m1haUp0vQb18+VRUTqStGYHtQBAb/NHS1dnDwvQNh+fb
 zZ7HSpOvYT1gSezD2VF7PKQaeXxrgDjIWZYFB1D6w/RTTISUgnb35JtkeROQnUQYmzp5
 kHgMTR29GXZplzoQge893VB8eb51Ss5XhIJUUC6w3W7oI1B5CEJMugDHQ/fcxheRjQT3
 leLA==
X-Gm-Message-State: AOJu0YwUUrygYejnm5152TGCXFYEF5V+lGkjUGXbTAd3zYZqT5qsEY3w
 015NYPZHR5fw+L6mFD12YcMWD3qkp0vR/YeZKOLT3Vm0FTK7prrCik827SaRWeIS5k4Aj181XBI
 dZzCZ5KwYhHow42tC1SncQY7CdUHql6jXI2JZDdAF9KNDi8qqNtmBH3m/Kux+Sf+wHbuqoa+SCc
 1Aw169YiK6v0WjNevSz6QR8voH65Fq5sI=
X-Gm-Gg: Acq92OEZR/lwEjqVGy4aeqJPekfotSOFWcerxKJ88TRjEWvCF+Ot7cgHi4VdmDHm+/1
 DGNnNhw6tt8QDLj7LktVHj094gItpWgmcG8qGr8NtYR06dOgMBJ2/sZtenaw9/Ar9KUA95kRWqv
 zFqQyRviabLtOkcWOzyCOah1AseCqQ9bl3WMRIrLb8Y78svE0nfA2IMZKaloT3rvVaSHjmSvUwV
 s94/0co/ZocUaABFQEcpNqJhMF6x/XO64mEJTyah+ZaldGF
X-Received: by 2002:ac8:5788:0:b0:517:29c1:2b58 with SMTP id
 d75a77b69052e-51795b674c4mr311254401cf.48.1781030674818; 
 Tue, 09 Jun 2026 11:44:34 -0700 (PDT)
X-Received: by 2002:ac8:5788:0:b0:517:29c1:2b58 with SMTP id
 d75a77b69052e-51795b674c4mr311253601cf.48.1781030674294; Tue, 09 Jun 2026
 11:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-10-jsnow@redhat.com>
 <87ecinkgnv.fsf@pond.sub.org>
 <CAFn=p-aXcHomC4r=Gh9yQhoQzFDqxqTc2YTpaE-NOgiYDQRx_g@mail.gmail.com>
 <87h5nbon3y.fsf@pond.sub.org>
In-Reply-To: <87h5nbon3y.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jun 2026 14:44:22 -0400
X-Gm-Features: AVVi8CdTfPyMB5qd05xDjln5PEzohNNuyuVLB_fgaO3XbOny2JH-azy36Gfo3p0
Message-ID: <CAFn=p-a8hhJ7AQpCJZ=C_P8SNdYuv0Hp301DeFLKg8mhkiRCyA@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] qapi/docs: adjust stub member insertion algorithm
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Tue, Jun 9, 2026 at 9:33=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Jun 3, 2026 at 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Quick first pass...
> >>
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > A forthcoming patch removes the implicit PLAIN section that always
> >> > starts a QAPIDoc section list. Further future changes begin converti=
ng
> >> > "PLAIN" sections to "INTRO" sections. To accommodate this, the
> >> > insertion algorithm that places stub and dummy members must be
> >> > adjusted to cope with not only the finished state, but temporary
> >> > intermediate states while the series is merged.
> >>
> >> Perhaps:
> >>
> >>   A forthcoming patch removes the implicit PLAIN section that always
> >>   starts a QAPIDoc section list. Further future changes begin converti=
ng
> >>   "PLAIN" sections to "INTRO" sections.
> >>
> >>   This will affect the code that inserts "Not documented" descriptions
> >>   for undocumented members ("stub sections") and the dummy section tha=
t
> >>   marks the spot for "The members of ..." references.
> >>
> >>   Adjust the algorithm to cope with not only the finished state, but
> >>   temporary intermediate states while the series is merged.
> >
> > Sure.
> >
> >>
> >> > This algorithm can handle zero-or-more PLAIN *or* INTRO sections at
> >> > the beginning of a QAPIDoc object, in contrast to the previous
> >> > algorithm which assumed and relied upon there being always one PLAIN
> >> > section at the beginning of every QAPIDoc section list.
> >> >
> >> > In other words: (PLAIN | INTRO)* <EverythingElse>
> >> >
> >> > This does not impact what the parser itself will actually produce. A=
s
> >> > of this patch, the parser will still always generate QAPIDoc section
> >> > lists that start with precisely one PLAIN section (whether or not it
> >> > is empty), followed by the remaining sections. Those remaining
> >> > sections may or may not include additional PLAIN sections, but never
> >> > two such sections contiguously as the parser will always treat that
> >> > layout as one PLAIN section consisting of multiple paragraph(s).
> >> >
> >> > In other other words: This insertion algorithm is more lenient than
> >> > the parser, but this is on purpose for flexibility mid-stream as we
> >> > convert QAPI to using explicit introductory sections. The allowed
> >> > order of sections will eventually become strictly enforced in the
> >> > parser, which will in turn allow dramatic simplifications to the
> >> > insertion algorithm. This only exists as transitory code until we ar=
e
> >> > able to enforce that order.
> >> >
> >> > Fear not: the intermediate rest output before and after this patch
> >>
> >> "ReST output"?
> >
> > Sure
> >
> >>
> >> > are byte identical, so failing all else, we at least know it doesn't
> >> > make anything worse.
> >> >
> >> > Lastly, because we have three places in the code that need to insert
> >> > stub/dummy sections, we take the opportunity to consolidate this cod=
e
> >> > to handle all three cases with one function. This winds up
> >> > necessitating the qapidoc.py generator actually modify the section
> >> > list to insert a "dummy" member that acts as a placeholder for "The
> >> > members of ..." text. While it looks like a code smell to modify the
> >> > caller's argument, it is ultimately safe because the QAPI Schema
> >> > object is re-parsed and re-constructed in memory for each individual
> >> > process that needs to operate on it. In other words, the Sphinx
> >> > document generator already does have "its own copy" of the section
> >> > lists, so it is "safe" to modify here without regards to other
> >> > consumers of the QAPIDoc objects. It only *looks* like it smells
> >> > bad. Ultimately, this code will also be removed once the inliner is
> >> > merged, so it is only a temporary aesthetic issue regardless.
> >>
> >> Such trickery, even when safe, risks making attentive readers go
> >> "WAT?!?"  I find it tolerable only because we plan to replace it fairl=
y
> >> soon.
> >>
> >> The code finding the spot to insert stub/dummy sections is more
> >> complicated than it has any right to be, both before and after your
> >> patch.  It reconstructs information the doc parser has, but doesn't pa=
ss
> >> on in usable form.  Passing that info on would likely be simpler and
> >> cleaner.  However, you tell me your inliner patches also simplify
> >> things, and they already exist.  So let's go with those.
> >
> > Right, the basic idea is this:
> >
> > - Differentiate INTRO with new syntax
> > - Convert "PLAIN" into "DETAILS"
> > - Enforce strict section ordering: INTRO only at the beginning,
> > DETAILS only at or quite near to the end
> >
> > Once that is cemented, the insertion algorithm can become much simpler
> > and dumber; e.g. using a map of regions where we can append to the end
> > of a region without having to iterate through to find our sweet spot.
> >
> > Since that's the plan for the inliner anyway, some temporary ugliness
> > here in order to ensure that we do not regress even one byte seems
> > acceptable.
> >
> > Additionally, once the inliner is merged, we won't need the "dummy"
> > sections at all, so those go away entirely, and all of the ugliness of
> > that particular part of the hack with it - i.e. no more modifying the
> > caller's argument to insert a bookmark.
> >
> > So, it's a little gross, but it's just a band-aid to get to where we
> > want to be; and it isn't as gross as it looks.
> >
> > With your suggested commentary changes, do I have your blessing to
> > push forward? In the interim, please review the rest of the series so
> > I can send you a new version.
>
> Yes, you do.
>
> In addition to the commit message changes, I'd like to have a comment in
> the code.
>
> Perhaps as separate patch before your series:

It's easy enough to add it as a separate patch right before this one
instead of in a separate series. Added in with no rebasing issues, so
I'm going to do it that way just to avoid any potential merging
issues.

>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index c3cf33904e..844afc6e0e 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -852,6 +852,12 @@ def connect_feature(self, feature: 'QAPISchemaFeatur=
e') -> None:
>
>      def ensure_returns(self, info: QAPISourceInfo) -> None:
>
> +        # This is more complicated than it ought to be.  The doc
> +        # parser should already know where a generated RETURNS section
> +        # should go.  It currently doesn't, mostly because it accepts
> +        # tagged sections in any order.
> +        # TODO Tighten doc syntax and simplify.
> +
>          def _insert_near_kind(
>              kind: QAPIDoc.Kind,
>              new_sect: QAPIDoc.Section,
> --
> 2.54.0
>
> We could adjust the comment within your series to also cover the new
> uses of _insert_near_kind(), but I don't think that's necessary.  It
> should serve as a reminder as is.
>
> If that works for you, I'll post the patch.
>
> >
> > --js
> >
> >>
> >> > That's my story and I'm sticking to it.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >>
>


