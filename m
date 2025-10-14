Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D6ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kLQ-0003Pw-Is; Tue, 14 Oct 2025 15:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8kLM-0003PU-G5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1v8kLF-0005wF-I1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760468746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7wvFlPZOn9U7lh627mrQAiJW109mwkpJvUl3YrNsbY=;
 b=ipQn5CrU63kaK57cR9E9LYfruwLBDATB8IlEaU8v4Mm3ahSTKbrTtnpTpiVzZTWnG/u97l
 tjn5kq5BPDbOaqZQbiy/NmLhbecIzSbuOXm5+hhtjr3+yohKLYkFCKmnRjTzk7QC2lKftz
 85cARTREvZIqMprYu1w2ok5M/DRl0aA=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-7DDCyaorPkyuR2gG5_MZ7Q-1; Tue, 14 Oct 2025 15:05:44 -0400
X-MC-Unique: 7DDCyaorPkyuR2gG5_MZ7Q-1
X-Mimecast-MFC-AGG-ID: 7DDCyaorPkyuR2gG5_MZ7Q_1760468744
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-633af2adc21so10730313d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760468744; x=1761073544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7wvFlPZOn9U7lh627mrQAiJW109mwkpJvUl3YrNsbY=;
 b=Vx6zDcONFIGoAVqIi7V7XyEWCUTP74JvBJHzgrvLAduBkToCoOfm2TYE74HVigJ3OW
 1wInvzHiZxilgV5QGlTECQPSq/FkvFij4mh4dZ2NOOfEMgrDYxkNuUQQFud5q21aW0wM
 5qgQLAz2ysPhixaklgvqOLJR7x2J0OtYPbQ7C0jxGJU+eRbjnwduXBWg/n4fyOKlWVE0
 1+fenGnH7SztLnpxtIEYalK0/gizToSCHKiHd22mjy6mDPJj0rXitf3DntiBTtj2XsM9
 jdj8GNS8wZyn156h1N/tLROGEzEMqN9AjT/pUR7hZPzRFTm2OzQsXmOfH8uFwHzlIPlI
 vOzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzkhyUGsyQMHaLDkUhsM87EZf1PfI8jZD5Xs2kQTxR0Eh1fBEJQEvJU6cUZitZeZH9qoCn5vcnL9y5@nongnu.org
X-Gm-Message-State: AOJu0Yx5coraRkuVCIW9glRZQIOfn5g0F8d6aUoCrWYzDS/vnxjWo+OV
 j4EccFxappKASpNedlmO0f131wcryk+eS6M8u7kvVSfMaZsYod9PXSlnSlH+m+OTCNy8+jpW8D4
 8eawWMS018IeqIgkIqcsUNZwJFkBwBB5y67/6mbJOnAcqv1HPyRDpR/idTEpjDIajAyfxtzSkiu
 H4Jbnd8D8wIT3CKyPvKQ/i2Quap3DyE6o=
X-Gm-Gg: ASbGnct0eV5+Du4l2hKOT9EgKA0kMPljtPp7P2lYHVWQbSb4vvmtvMgBHRyr5dR7Nxm
 gbbLz1ih+3qgR1gTnBFBYJUKC3JQUnXArIOY78ojNtmgnNw0EoGrGguNgBKb4z8Kruq1EblkXDc
 PFPLkt6hRr8m2fql91iaGRsuzFYD+nrK+hNBHDlLuJ0LMxVbyeQXtL
X-Received: by 2002:a53:c805:0:b0:636:d3c9:b9e3 with SMTP id
 956f58d0204a3-63ccb823f87mr17495125d50.17.1760468743688; 
 Tue, 14 Oct 2025 12:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pQCsiivoVpojPgR6cL/ws+yNX79rk+6XcRyu5zsP3+Vg9HKTCQBh+sVOtuNTNgO4hZEjaPs3RQNX8AcN++M=
X-Received: by 2002:a53:c805:0:b0:636:d3c9:b9e3 with SMTP id
 956f58d0204a3-63ccb823f87mr17495113d50.17.1760468743115; Tue, 14 Oct 2025
 12:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-3-gustavo.romero@linaro.org>
 <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
 <a0d4ba3d-f799-4ec3-8d3b-efdc33527242@redhat.com>
 <CAFn=p-awbF01tQr9xnRX8EqPBNoafGP+N2W-hoMwc68cmwQzLA@mail.gmail.com>
 <701600e9-651c-405a-b076-57883878bdef@redhat.com>
In-Reply-To: <701600e9-651c-405a-b076-57883878bdef@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 14 Oct 2025 15:05:30 -0400
X-Gm-Features: AS18NWBO-BxYRfhu8woX6AoNQrzAECq5Nty_E8joeEdc4TaDHZBKFCoMBU5rGOE
Message-ID: <CAFn=p-aYSo15pW+wBKsAOFdf9PyniZf4R2TcvMNJaRPULxVL9w@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, berrange@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 14, 2025 at 2:59=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 14/10/2025 20.55, John Snow wrote:
> > On Tue, Oct 14, 2025 at 2:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
> >>
> >> On 14/10/2025 19.39, John Snow wrote:
> >>> On Wed, Oct 1, 2025 at 10:09=E2=80=AFPM Gustavo Romero
> >>> <gustavo.romero@linaro.org> wrote:
> >>>>
> >>>> The upcoming changes in the reverse_debugging functional test to rem=
ove
> >>>> Avocado as a dependency will require pygdbmi for interacting with GD=
B,
> >>>> so install it in meson's venv (located in the build dir's pyvenv/).
> >>>>
> >>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> >>>> ---
> >>>>    pythondeps.toml | 1 +
> >>>>    1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/pythondeps.toml b/pythondeps.toml
> >>>> index 16fb2a989c..98e99e7900 100644
> >>>> --- a/pythondeps.toml
> >>>> +++ b/pythondeps.toml
> >>>> @@ -33,3 +33,4 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", ins=
talled =3D "1.2.2" }
> >>>>
> >>>>    [testdeps]
> >>>>    qemu.qmp =3D { accepted =3D ">=3D0.0.3", installed =3D "0.0.3" }
> >>>> +pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0"=
 }
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >>> Do we need to vendor pygdbmi? Currently, mkvenv does not consult
> >>> online sources and so if this package is missing, pulling in testdeps
> >>> will fail.
> >>
> >> This is handled by the "check-venv" target which is called now when yo=
u do a
> >> "make check-functional". See:
> >>
> >>    https://gitlab.com/qemu-project/qemu/-/commit/75b1786996c422878d09b=
d12f166004a7d32e459
> >>
> >> Works fine for me, did you hit any issues here?
> >>
> >>    Thomas
> >
> > Ah-ha. I am working on dropping qemu.qmp from the tree and had moved
> > this machinery into mkvenv.py - I didn't realize that the Makefile
> > invocation here passes `--online`. The core groups for mkvenv still
> > operate offline only, I didn't realize we let it go online for tests.
> >
> > Before these dependencies get more numerous: do we accept that "make
> > check" might only work if you are online, or do we want to enforce the
> > idea that "make check" should always work offline only?
> >
> > (like "make check" works offline and "make check-extras" may require
> > internet for deps?)
>
> "make check" works offline (it does not include "check-functional"). It's
> only "make check-functional" that requires an internet connection. It
> required this for downloading the assets for the functional tests already=
,
> so adding "check-venv" here did not hurt.
>
>   Thomas

OK, got it. For *my* purposes (and this has nothing to do with this
patch anymore, I see that it's fine as-is) I need to pull qemu.qmp
into the testing venv /offline/ for the default "make check"
invocation and I intended to vendor qemu.qmp to accomplish that.

With this dep here, installing "testdeps" offline now fails, so either:

(1) I vendor pygdbmi so it can be installed offline, or
(2) I split the test deps into two groups; offline and online.


