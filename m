Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E46CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1eO-0007fO-MI; Tue, 09 Jun 2026 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1eN-0007fD-GT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wX1eL-000088-Dt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781031487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUz4z9xJm0sVo+7VV1gF6jdAjVdm+QQcpxU667lJY5w=;
 b=HoTaI0ddgyIZsGq4WdedeGUDFHIkIti1E3eFjJW3Nic+YK86bUTfT7B3cIRXdfHPosY0p2
 8S/+FxW7PDUssD2r45rXZYE1m7akj5PFMzsC/ZwkzZZVj09866TbWaEaNqhGT5RkJHzUlB
 a3NOjlU/6ir1InOkry+Y53wSl9H9asU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-MTeGtQqAM-Cl3J9dUq23Dg-1; Tue, 09 Jun 2026 14:58:04 -0400
X-MC-Unique: MTeGtQqAM-Cl3J9dUq23Dg-1
X-Mimecast-MFC-AGG-ID: MTeGtQqAM-Cl3J9dUq23Dg_1781031482
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517c65c019bso36505111cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031482; cv=none;
 d=google.com; s=arc-20240605;
 b=QQ27BzPpYvb7HhshKR57qSvUOdbL9afmmF239jETlnogbO0MDAMyF53ZW2GTqcnGUY
 FJ6STuFq18o7ETqZ2UKE8oxEFYL+zfBYMSStKPnIGGJGD0f0EFdRkzzcVKYUUdOxR/t1
 asMDhKKKEbN5y1jrVxGTAMFbFjQADsiVVAxEa5eJ49YnF7WBFJzKT/fJ9mhi3BJMFOCE
 cFCwVloMYSDc6HhGTdlVmy0QSJ2WY2Kv/Mgtsu7E0ZXybe/gT/Saqwgu7teVViwjNDe5
 YzdMzesnBbQ+W6+E9TeMniSj1TWm/p+B0BBKPqoqTsaoJDgrVDZLVLSI9aeTG00OvYmW
 nhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bUz4z9xJm0sVo+7VV1gF6jdAjVdm+QQcpxU667lJY5w=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=aPfa7Tk0rOPyULDaz5/d4WGIUkDGa5u+dHY+tohFuwc6wtei9mpmBINfAGr6ZAAWyR
 cTCkpveAGOa7qFFKcmx/wc1zauTfcw0UggbNEO0F0KyvKKcmCke0gjXuxLI9zmFKw8zv
 3GueFDYMtk/U5O/DVYYXl3RHSXdwK73rIzKhkB8Ow8suo+Zvm6zjMe7dScOP46EzzqYN
 XFaA1DKosUgIigrLe0NQ7IeL35lN8GaJ9HXY1e3gwokIy9dojiObHrgTagVMdMPVG3qT
 y/DtChhBvacgtEi7iF8f3lXWJhIlN2nucg99BHueNIaS6CE91Jk2+fDojSePfZtdeH99
 auMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781031482; x=1781636282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUz4z9xJm0sVo+7VV1gF6jdAjVdm+QQcpxU667lJY5w=;
 b=ZadTtLF9070uG2YE+S9AfW3+8JTwucNOQvgXFI8r9Z/IaBGYXsfEZOQHf2MYeKosdo
 CTFyPobyPqr6IWpv9Z2EimvU9nGwv/Lgt1mtVd2+8O6NyApHRaSUUPBDo4+27uwzKDwl
 ScZjo1rgnSpXtOAJyk2oeLMckMYxEcAdUJEfbUBtIQv7ATCrHHGdr1AtqBAkyqMjAwnS
 kQmKlvEuvvUsQLd5FndLIubIGKPeU3dadGi6NoQIMo9tiYhu6bjWKB7mUee3w5SWRt60
 Otd8Y59EnxIFLZ1CR9mMklJogtzTS8iH2O/dNlmSWeI38JlNI2k3ODFzrKnBaP1yinzq
 xnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031482; x=1781636282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bUz4z9xJm0sVo+7VV1gF6jdAjVdm+QQcpxU667lJY5w=;
 b=kpUY9pFpV65tMA45ZW2SDzRSyBPgpDw5ntIdTRZ/QeJJ+8BiWDvROcE99WgJ8wEnhF
 R5uA3wuibaH+6iqhiwgJYfFhKEPoEQHp2bV7N8pS+IritciWDw7P+okVH/Q3ppFPFCAD
 xoatteSldXu1QhBoZwoi+zDA6F2l1Nty/aKFZ2rqLP9SE4OxhHksKUi9/sSwrX0I+GiR
 2Eof9ze16Db8ZTotXisB/eQ8pDamKnw57kaOAeVHqGowZfxvUlTMgIns0a9O/5nc+WaQ
 tUL/ERYxdYhA/tc50J5eGcVUNE7ZAwOlXsKr+ldCOzR++h+G2xo3/nQ4yAqdTqD/ZStT
 humg==
X-Gm-Message-State: AOJu0YxEOiKvOCe7lbeyYOKkxEPty5okkLrFkukqePE6EO8csUYG6O37
 UOYd9Hv3jxE4pf1FGDT+MfnwDZtxQQwAqdKY6XprHJAfz9Mw7DuiH9o8zBQ/y6ol1dCUJv3KwfF
 lN1jm50AUIOtOU8Bf5PeSob10XMUYzgKSmVumNoiAKOuCKOz8CPAJHPKH228j0op+hZCAQ/d7Fv
 o5guBjcR6+OwKVE2US3UgVOKWyqZSia0k=
X-Gm-Gg: Acq92OEuwOUaZyK/A1aFwQx47/ZkA3jw3NDFxVPEy5ICVBhAB7YsLu9yDHHZYoca+EV
 c65SoGeVe6QRc0FlNKmnxjCwXUeqG4EL+/Q3lma21DGKJshJoDDTevLy7dmSB0GFFxOmgHq8URH
 BF6apq0iS7vwbcOubEc1/pu/05kmKR/sqJI+BZvN5JrtqXj5eHfUHe/rA4aJx5gftqozEEvD28T
 IyAWwIB9w+SpAM5RhYBvlVPNPk0rhmYdTX2Y7z0ed4+fkXu
X-Received: by 2002:ac8:598d:0:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-517959957a0mr324623001cf.0.1781031482325; 
 Tue, 09 Jun 2026 11:58:02 -0700 (PDT)
X-Received: by 2002:ac8:598d:0:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-517959957a0mr324622421cf.0.1781031481868; Tue, 09 Jun 2026
 11:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-13-jsnow@redhat.com>
 <874ijboms6.fsf@pond.sub.org>
In-Reply-To: <874ijboms6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jun 2026 14:57:51 -0400
X-Gm-Features: AVVi8CcmL5RcjMHoqmKCDwgyIh7PYamDdMOzM2lSQJRccGXaYGBtPFhkdtejFOs
Message-ID: <CAFn=p-YJg_KhMf3vHZYP-4F1FVsA-MOE=ydRAmUv5srdVteuwQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] qapi/docs: add "Intro" section parsing
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 9, 2026 at 9:39=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Add parsing for explicit Intro section syntax.
> >
> > A side effect of this patch is that we will (currently) always create
> > an empty Intro section, similar to how we used to have an empty Plain
> > section. The tests are adjusted accordingly, rendered document output
> > does not change at all.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst   | 16 +++++++---------
> >  scripts/qapi/parser.py         |  4 ++--
> >  tests/qapi-schema/doc-good.out | 18 ++++++++++++++++++
> >  3 files changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index 3a632b4a648..b1cc5b5f0db 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -984,11 +984,11 @@ definition it documents.
> >  When documentation is required (see pragma_ 'doc-required'), every
> >  definition must have documentation.
> >
> > -Definition documentation starts with a line naming the definition,
> > -followed by an optional overview, a description of each argument (for
> > -commands and events), member (for structs and unions), branch (for
> > -alternates), or value (for enums), a description of each feature (if
> > -any), and finally optional tagged sections.
> > +Definition documentation starts with a description naming the
> > +definition with an optional indented overview, a description of each
> > +argument (for commands and events), member (for structs and unions),
> > +branch (for alternates), or value (for enums), a description of each
> > +feature (if any), and finally optional tagged sections.
> >
> >  Descriptions start with '\@name:'.  The description text must be
> >  indented like this::
>
> This works if we convert the entire schema in the same series.  I guess
> that's the plan.  Is it?

I still plan to do it piecemeal: I will probably send everything out
in a big series, but you will be able to cherry-pick and stage those
patches individually as you feel they are ready. This way, modules
that need further revisions don't hold up the entire series and v2,
v3, etc won't email bomb all of creation just to fix an indent in a
single module somewhere.

I think this documentation still covers it just fine: "an optional
indented overview". Technically the things we haven't converted just
omit that indented overview. Those overviews just remain as
"plaintext".

It's not perfect documentation, but the expected window where we have
two competing systems should be quite small in the grand scheme, so I
don't think it's worth writing docs to cover the technicalities of the
transition.

--js

>
> > @@ -1093,8 +1093,7 @@ Examples of complete definition documentation::
> >
> >   ##
> >   # @BlockStats:
> > - #
> > - # Statistics of a virtual block device or a block backing device.
> > + #     Statistics of a virtual block device or a block backing device.
> >   #
> >   # @device: If the stats are for a virtual block device, the name
> >   #     corresponding to the virtual block device.
> > @@ -1111,8 +1110,7 @@ Examples of complete definition documentation::
> >
> >   ##
> >   # @query-blockstats:
> > - #
> > - # Query the @BlockStats for all virtual block devices.
> > + #     Query the @BlockStats for all virtual block devices.
> >   #
> >   # @query-nodes: If true, the command will query all the block nodes
> >   #     ... explain, explain ...
>
> [...]
>


