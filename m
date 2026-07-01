Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41FAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weyiE-0007BI-Bt; Wed, 01 Jul 2026 13:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weyi9-00078w-L8
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 13:27:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weyi4-0005Wu-Lq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 13:26:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so141372a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 10:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782926811; cv=none;
 d=google.com; s=arc-20260327;
 b=idBqO+n4SzbPkivu5Tw39mMVe/ywMGF+MHEPZlDEwlrfAtenxs4UJaVyNusAfsIacn
 JGxKYXg1rp8lqEbzErKf/0osQGJIzFNGy+Ob4ywpf7LRCWZdjr5bXVeSSzvjMg/KmZ2J
 a8/q5cXcP6ct3OGmZJBjuoR2x02IFA4yCLPhG+wiTmGefoYrstliZ7qe47cKqqiBuJZa
 /+mL1/e3jtmtYN9uKt4GYrTamlKkPOiCaQwRbXvxvjBPmFkmW2K+t4wfxsJ3XTFO7btd
 8hWuypa6ccTJ/ObnIY5BrtTuGDP5JCs35TZllWYCDDePctSnUf4xSYUeKuQuajs8tee0
 t9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7WsURWJe9uxWG47CZIwngS2A51dx86IsoPkM3dOTnBQ=;
 fh=9M4Rrx4PG6fhLBXemMJVt4ZBC7wQ3uYWN3BPfe40nTo=;
 b=p7kDD3uX2wmE5svMvItp5JC7kwTFL8YML8jn0qR8QA3PT90wAJtDRe42s7RumVc2ro
 G65ce8Bif3F0cyQ/PERwWb4nYfX0xq6uuyZ0i4D3ADXmyaKxpRf530Wa66qvWWl7OHts
 DEHDA4qAgnW2Z++4nwglbXghKlSMniFf6lRCK0l6C+Pljdd+mBle+U1NCd0mH6d7JXI2
 xSoe0lbRSKB3j8aEt0yQptGGRIjau+Pw2wTu+p+4s6xZCmPgbUe90NJg0zb1X6DvLfPM
 8mG76G2WPI5OjKDXlvMu3/TiH+4f1Jpm0BiXFvyht9y3r7pnO3qGd05xuKNwJzZn4AkB
 t+gA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782926811; x=1783531611; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7WsURWJe9uxWG47CZIwngS2A51dx86IsoPkM3dOTnBQ=;
 b=dbOp8TaRVLB1ucFSrrph340ExhnOTeSgskqnWKu8nEaoKtSvKuJ6boS8uor1Ak7KAC
 Kw2myxWRVhZcb9xY5bX0X4j9GIK5tE0Ces4mhCf1x6/OFm9p2B7yQ5lWTomYPsZrjQGt
 oPFecJovhLK3oj0sBmCVSujqCTHxS2A/exXSsIZD6t2wgvUk6k3XySX1eGlGAxi/Z5DM
 Cmb+StC7jUODnsHCXVjMAMsLYFYXbJEQayrvpZgD11otYjSSOGdqaW+iAA4xPpEhT0AV
 sqNVLK5m9zuAi5NQoyyFb/mT0zFEyVPBCgV3wQX4Q7G4vNd85KcNcV3JPnngMxgL0RqB
 hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926811; x=1783531611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WsURWJe9uxWG47CZIwngS2A51dx86IsoPkM3dOTnBQ=;
 b=YT7H1M4aGXCg/D87ofeYS9YrU7BFskIbAY1DMfeB2emG2XXeVcx436qQ0xcr6QFKX5
 hPPegb3RDwAybd6++LiFSJuzZz2h9uyl82vDqXhM2gQc3QEmqKU/Mc5CtDpHa6/R45JS
 3OEDj0LZqIgmvVv8oj6rxXmSE0NgvGRXw1Fn0GayWS+cjZdQW4XyvJs/6lZxxtREJX3k
 gp8ec4lR7D4shgKZwXR7/MNag1C6mYRl1CUFoNQ6q6afT5U9prZxqj1xQNjGDYMBFChD
 kQhoDFxhhta2ac2swOYdMtXWTdvE4qaBULhvNCzqsmVrr3hZvTdAufskaRztdQpxMBVF
 DMJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqnq7XPsavChF9P7rcDBUoUeFH6CJLs0evX4O3R5JAfVshTrFK4MRNlhvQ+fZXkbQmPHink9iJBF9AA@nongnu.org
X-Gm-Message-State: AOJu0YyNz9N7MoodM3/wLan2s4lXTdJ6J95HmGtyPJpF8Yx8Niie2Ccy
 1KUanszmQFO+WsSxamTJBStBkJT4IkU9uk8I8b0zn0SL3SuStAms+L24I0WQ3pAFAaocF1Lqver
 FEoSGzbdHOipAbFTWaXHBaeZmd08/04U=
X-Gm-Gg: AfdE7ckFFfMXfc8+Dsu8nb9ux+yR4cpHXK0CS7urDpqgpRCv5ip1znIbfJGwhZB0ppf
 Bmhg6P9tDsEZs6KGkwHWi8kLO3Vtn+GvLpSFQFXMwMeH4nDVVQa/UwpWNoSoPdEiLIx3tvqlbb2
 72zSBi9PpnFCdl5q9wh2TrNO7KYhQTxkkBDIUFD0bvQBrhh6Npw7Qqq4zQO8Avb8mtXRzZR9ioJ
 E2j5uR+AmuwS8uW6l5SaL9KC6YKMxY37h3x2H2zeFSQA5tgQaWjmi0aSKDdeDD4RmYJXsgBfu4m
 mY7P1dP0yVzuXZQ0Z8CoQ2tyWQ3gTAfEwwm20OXUrgV3IxFNMYorjk4l0eUufPsUYdBk
X-Received: by 2002:a05:6402:a503:10b0:698:f7d:4e11 with SMTP id
 4fb4d7f45d1cf-698a2c60221mr587990a12.1.1782926810820; Wed, 01 Jul 2026
 10:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
 <CAJSP0QWBpXN-=iu_13y3k_4z4uZJX7NPTgFH16CSBn30EYTrAg@mail.gmail.com>
 <CAJSP0QWtZUKQC5d23+tJi896H6sndwL+bD2cvSkQhC67mBjbkw@mail.gmail.com>
In-Reply-To: <CAJSP0QWtZUKQC5d23+tJi896H6sndwL+bD2cvSkQhC67mBjbkw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 1 Jul 2026 19:26:38 +0200
X-Gm-Features: AVVi8CdzwaHUJ-R416UrMM65wM6xltb9CU5RtLe3-Mb53MD0nc_DOOGs_eCKI6E
Message-ID: <CAJSP0QWgS5wN1rnMw_xx5DwDDfpkGyB5fJEHdCGbK3mG7Xdqag@mail.gmail.com>
Subject: Re: macOS builds broken in CI
To: Mohamed Mediouni <mohamed@unpredictable.fr>, Emmanuel Blot <eblot@meta.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

(Update Philippe's email address.)

On Wed, Jul 1, 2026 at 7:23=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Thu, Jun 25, 2026 at 9:53=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Thu, Jun 25, 2026 at 3:15=E2=80=AFPM Mohamed Mediouni
> > <mohamed@unpredictable.fr> wrote:
> > >
> > >
> > >
> > > > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.=
fr> wrote:
> > > >
> > > >
> > > >
> > > >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > > >>
> > > >> Hi Alex,
> > > >> tests/tcg/multiarch/system/Makefile.softmmu-target's
> > > >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runner=
s. 5
> > > >> days ago it still passed, but now rerunning the pipeline on the sa=
me
> > > >> commit ID fails:
> > > >>
> > > >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipeli=
nes/2615134022
> > > >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/26=
29704018
> > > >>
> > > >> I've tried many CI runs with different pull requests applied on to=
p of
> > > >> qemu.git/master and they fail in the same way. Maybe it's an
> > > >> environmental thing with the macOS runners?
> > > >>
> > > >> It's unclear where the SIGKILL (Error 137) comes from. Could it be=
 an
> > > >> out-of-memory condition on macOS runners?
> > > >
> > > > Hi,
> > > >
> > > > SIGKILL is the known symptom for failure during signature verificat=
ion
> > > > by AMFI.
> > > >
> > > > Now that we don=E2=80=99t have separate -unsigned binaries anymore =
but relying
> > > > on in-place ad-hoc (w/o certificate) signing with entitlements we m=
ight
> > > > have issues linked to that.
> > > >
> > > > In the past file modification had issues with verification tied to =
the
> > > > inode and the workaround being a reboot or a cat binary > new_binar=
y;
> > > > chmod +x new_binary so that the old (now out of sync) signing state=
 is lost
> > > >
> > > This is highlighted in the software update context in: https://develo=
per.apple.com/documentation/security/updating-mac-software
> > >
> > > > This code is incorrect because it modifies the command-line tool=E2=
=80=99s executable file in place. macOS caches information about the code=
=E2=80=99s signature in the kernel. It doesn=E2=80=99t flush that cache whe=
n you modify the file=E2=80=99s contents. Modifying the file in place yield=
s a mismatch between the file=E2=80=99s contents and the in-kernel cache, w=
hich can cause a hard-to-reproduce code-signing crash the next time you run=
 the tool.
> > > > While this example uses a command-line tool to demonstrate the issu=
e, updating any file that contains signed code might trigger this code-sign=
ing crash. That includes executables, frameworks, dynamic libraries, and bu=
ndles.
> > > > To update a file that contains signed code without risking this cra=
sh, write the updated code to a temporary file and replace the existing fil=
e with that temporary one:
> > >
> >
> > Nice, thanks for sharing this! Do you want to send a patch to fix this?
>
> The macOS CI jobs have been failing for a week. The QEMU 11.1 soft
> freeze is on July 7th and I'm concerned that we will enter the 11.1
> freeze without working macOS builds in the CI system.
>
> Does anyone want to fix this macOS host issue?
>
> Stefan

