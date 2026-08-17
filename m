Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE72C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsDz-0003Nq-5P; Mon, 17 Aug 2026 03:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wvsDy-0003Ne-4N
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wvsDw-0004eC-AU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786953454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVdedIG3dICHHST3i1ISNXU0ZvrFNTAnyIKTWWED3vA=;
 b=S14PZmHlAzaG3uFS8rf5QCCukXnxdRu9ZCusXvzBzNHGS+kRJ2qadOag/1P2OTnaQoMRna
 WvDADAuTucliWekNfmnrFPOJXdAfIJpJ9m7LX6jIyek1FeepRnek4tHTmW1VUj/KylIrsL
 gie4S+Nc/nhF/5FKif60XyaG9pcgeYY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Oqb9yyFFOBqH0PikZoU3uA-1; Mon, 17 Aug 2026 03:57:32 -0400
X-MC-Unique: Oqb9yyFFOBqH0PikZoU3uA-1
X-Mimecast-MFC-AGG-ID: Oqb9yyFFOBqH0PikZoU3uA_1786953452
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so33088385ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 00:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786953452; cv=none;
 d=google.com; s=arc-20260327;
 b=jLE5aYfTXJJUDQUESNhW2HW8QNJCsRAVu92gUqVMJtP3b6AUJbT9WezEtgluG2wm/A
 NrynTdh4ctVkKRaTIkOpQFe05uFK5X2aBY7a0HweBnIb+RavnYWa2b3fUtipD1DwpXo/
 /lrO2+J4A7MLUvgLYSWrUOA52fJluWW6eMDwWAxW5jVYw7nzBaVyMGM2HD8Vx5dGqcxC
 7GYSJNZ1tX5XLYE8fCL2nXPyJnr8cp8qYFEYWfJxY+Uvbajon1+6Bz2BCfVbpLWOMVUO
 NAmCnXHLASlsc+sMXlTAGwyVvfxKnToKvM56uCQOGK3GAIBvSOTYSVYRHgVKMbdOHYWS
 UTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pVdedIG3dICHHST3i1ISNXU0ZvrFNTAnyIKTWWED3vA=;
 fh=yzuPFCXn95f7Fhvrva6X/+0hsZsG4fiyHsfM9iTNouY=;
 b=LCfXLz8QXGfor2jrgsPEoEIXQH68N+RkXY3sVmzKtYdITM2o4bW5/mh6bFfWxnmJ3y
 UOVIlm/iqHK/zcpKfH+k12fnZTW8ZCVnTEb5cyGmlf2zaoIMr862dKdOqg1TZ56HBtoY
 TUml0hkocU9swNoaqqYcP4rdhfPzqmIOHsP8IN4IzHyUvSja/kmPrs63cpP0IrAC7ZZq
 FJkQiP3u+qrzk5Qje2JNQYa7zVsnCD6yiFSySjrLU9WV19yMn9hAQSrv/iaOGEFwpSll
 jvfimZ5IdyPYN+0QuVELTivAhmVMPGukrxocjgt3OCp9ByuI+h1H/2AkG3RqwiP16oQA
 KFVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786953452; x=1787558252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pVdedIG3dICHHST3i1ISNXU0ZvrFNTAnyIKTWWED3vA=;
 b=OUc+R17mQHT/FamCSQsLa75E1a5SmfnLZMcTSLk6vX5dbYQXLAHCLLUUhwTrVLfAB6
 VdkyD+5zoD+faJ6RK/dDkCbklfKxlARywiC3ly7BVIyVqnNyTgHGAQw0bK+QgTZac3Rl
 wr22A6v62etu9LN6XTFD9rvp4M468RRVc//nTyqutprGYW9Od4eVMvky6C4fe0fdL4Hw
 BGXjqq+3ksNkA7JyUrCCBl2xEQBjunkv1GkrFoGDjKS9UkI4RZOLOzavX2brpu9ddo1P
 vRvgLR9GaVvX4Cvt6UgRt3MIcC1+9fAFLL8b5YM06KYZtLC3Kzct8zvqhIFz8iY33C9v
 pErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953452; x=1787558252;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pVdedIG3dICHHST3i1ISNXU0ZvrFNTAnyIKTWWED3vA=;
 b=TGJr0mTCmxb9wRQrXx+Xy7m+5tlHCD2CwN6KkOrv068TW+eG/h0yCACeykjvZq1Q+f
 t4W68NALkRdyuUNo7FgkOFhSEJzOG9h14jEF4RCW79D1sA0UkG/dDCPL45TCoRfzWNdb
 CLD7FzdriKIm8LfmWUS+z0bxe7qp2Hw+eKPtKo9UbPDAAP1VZY368T9iwQDy/FysGquE
 uRHhDh6jOldB78rivIVbjp9VicIbylFO6KDPqbLBIbiBgG4I/AKGyLgZv6NXpU3Oiaip
 p007XHYrS8U5GSwAViPNN2UxyByPa5niT+KHiPW+G0wYtuKNxz4rRjcFY9iKBaTOGVoJ
 kP7Q==
X-Gm-Message-State: AOJu0Yy4rgqs5e7Bn4xihyY+pqMfQysWfjUj+XVDXnT8PvW/ugrKP3h7
 /ZM+3VT4pUVYL5apMU87MXr7v1CzapOc3Sfu26t+GQNkAI41i/chB5D52laEre/NasJ1d/ErCJe
 xAJ1FUZs/lgreJkpHEp7oHJO/sFe58h+eOBWrl+HRzNk7X/JBbBoRS23W8hfHyYPbkkiGOH2tX7
 oH4bLnA/p/qForO13gAxawalTzOk/IjCU=
X-Gm-Gg: AR+sD13RbbHaSx/wuylHyEhxuhG6+salxH6fYLUByaL43nYb/sRbrtJZfrOtXiFXIvn
 14xgXO6omQcFMad+37xEbR5r445eJVrWxpB0Uj4Ln+gZ0wUYPo8yEjHyv/Wj/sG8det4G/wmOZM
 I+h143mSs3A/1vfRVcNfhVzoyUa3AA7nn5+729fLAn3YaS8Kr8I6flqHJosT8TKoSC+YgN/MoL6
 UtMpOHjv+sBdPPQmbMOxi1aoRCMHyyKOZKh6kxlyr+PoUws7jiRFdV3PwTEa95qtujY2ojKMqFZ
 fA==
X-Received: by 2002:a17:90b:35c6:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3933b95d5e1mr23463445a91.13.1786953451519; 
 Mon, 17 Aug 2026 00:57:31 -0700 (PDT)
X-Received: by 2002:a17:90b:35c6:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3933b95d5e1mr23463425a91.13.1786953450979; Mon, 17 Aug 2026
 00:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
 <54495516-9f01-4077-860a-a4c9cc612a73@redhat.com>
In-Reply-To: <54495516-9f01-4077-860a-a4c9cc612a73@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Aug 2026 11:57:18 +0400
X-Gm-Features: AcwNN1VqGmAo0yJrOb_5TJhjnJnTATkGVc70pa7gOLx5PD55OOJppmxUK2Zqbng
Message-ID: <CAMxuvaz3yrNkTnYOHtDcqGgKjW=9B-v82dGHpvSYUjzgrBYmDg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: fix pylint false positives for cv2
 module
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Aug 17, 2026 at 11:19=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 15/08/2026 09.24, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add generated-members=3Dcv2.* to pylintrc so pylint skips member
> > checking on the cv2 C extension module, whose members are not
> > visible to static analysis.
> >
> > Silence:
> > 2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files in=
 /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
> > 2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco/s=
rc/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Modul=
e 'cv2' has no 'imread' member (no-member)"
>
> Alex recently already sent a patch for that error here:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/dd14a21b9dc1
>
> Didn't that help to silence the message in your case, too?

Ah I missed that, but it doesn't help:

pylint --rcfile ../tests/functional/pylintrc ../tests/functional/arm/
************* Module test_integratorcp
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:83:2=
5:
E1101: Module 'cv2' has no 'imread' member (no-member)
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:84:2=
6:
E1101: Module 'cv2' has no 'cvtColor' member (no-member)
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:84:5=
5:
E1101: Module 'cv2' has no 'COLOR_BGR2GRAY' member (no-member)
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:85:1=
7:
E1101: Module 'cv2' has no 'matchTemplate' member (no-member)
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:85:5=
2:
E1101: Module 'cv2' has no 'imread' member (no-member)
/home/elmarco/src/qemu.nohmp/tests/functional/arm/test_integratorcp.py:86:3=
5:
E1101: Module 'cv2' has no 'TM_CCOEFF_NORMED' member (no-member)

My understanding:

I1101 (c-extension-no-member) - disable: silence if pylint can't
introspect the module

E1101 (no-member) - but we need to tell pylint to trust any member
access on cv2 if it can

>
>   Thomas
>
>
>
> > Note: I also tried with extension-pkg-allow-list, but that didn't work
> > for some reason.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   tests/functional/pylintrc | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
> > index 949bea611fe4..373aabd6ca3f 100644
> > --- a/tests/functional/pylintrc
> > +++ b/tests/functional/pylintrc
> > @@ -79,6 +79,12 @@ disable=3Dbad-inline-option,
> >           useless-suppression,
> >
> >
> > +[TYPECHECK]
> > +
> > +# cv2 is a C extension module whose members are not visible to pylint
> > +generated-members=3Dcv2.*
> > +
> > +
> >   [SIMILARITIES]
> >
> >   # Minimum lines number of a similarity.
>


