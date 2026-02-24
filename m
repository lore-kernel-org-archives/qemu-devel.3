Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C6DE9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqLX-0002Zh-Vh; Tue, 24 Feb 2026 06:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqLW-0002ZS-Om
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:12:54 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqLV-0000ZV-6g
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:12:54 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso51673351cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:12:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931572; cv=none;
 d=google.com; s=arc-20240605;
 b=JqJDBh0wdIc4nsiOPuQ2abc6TchbwqFltgGr0bpzCh925Mu8HcJ/8I5W6xNUqgAupL
 0O1O5jjn/lLAFOfwSJwKy1DdXtUHg3eBva1sZ8rbq7dtfLy9aTntISoNcPj17qBbMvk/
 RiTvys5UQv3yyjqVtgEougUaARjDTtPa6hotuOMiJUiJzqEE5kH2JtM/k4vE4OOo/piz
 PGNV9JVDJs8xB64TR87EFIgXs/NeTEmeCOjoULQ65c9n+BqIs1uK8H/GR58ytSwzdBkK
 3aKpD9C4rVP5UZB7X7wJKLosBhiRDdjWawQOBwGEoHQVuBz30Gz8+Tv5u4REFGKfqdOi
 OA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e3qzfVi23AfN43UeGcXBNLQaP8JnA3cHwMM61cIPQx4=;
 fh=J2gPOJ8TpA/ueD43faqjKBRi8lp/VQEkmL0P9bpNOrw=;
 b=I4/9qthbugf2XBLt4VCbSNI8gyap24oexDSNTjyLl5F11DZ/8rJZxyKtxwmTkeCjvm
 JuL5AASNpDXuiWfH47e9zosYX+a2YFBh9yAUt2NnicicWjB4Owgk8k5nurSBQO9CO474
 4b+ghUJZ4nPxA/YZEf4SwjYH1/XXsbLuZSrf6SpbqV+LX+5EyGpARXSXMSvHoQTpzuGL
 t4WBIvLnflqYrdCvpSItNOPHDEZb/2kBv9rqswtrPUJnmuSxqYt5RS16W4viL1eAONqs
 XAsKPRXxM5gg6RAC5kIc0htDpbnl0FT9NFslBx4BS/V94eZgQTtvemBLyFufXrdpuD5F
 8AnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931572; x=1772536372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3qzfVi23AfN43UeGcXBNLQaP8JnA3cHwMM61cIPQx4=;
 b=ISCCZ6T5CnSgtYq6c3cJxwSJXRBKlkVxNeTxpw6OZARSG9d8XQqM4T+d0W+MqZtQ1H
 gTtK9bjeienL+26G8LNyxDzC4oj8Hf51nTaMUkbcMMLU0owx+nX9AUA9n2T1h1MQ+U7X
 EfainCLoEz9Gbkmd5+r74SS/GEA/QbGgf5wEgniFPG5sVj87h9iaRPup49XUpEWVIaPI
 n82eVq9k6C+X3XsNP2/VsxWjDU04WYkBsYoShpTQzzfLhAN/1YG08I572Y/R5IFLRozB
 AyYu4IV0oYaL8P4edU6h5Z09QBzvFWFKJzirwCh2rVcJoR6rYWBpBRVhsyA+rsdA3Qdj
 WNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931572; x=1772536372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3qzfVi23AfN43UeGcXBNLQaP8JnA3cHwMM61cIPQx4=;
 b=aHcO9MI4hPJMpRt8f4ZmDfg+IL0OST3CDD/u7jzkOm7ZhHawkspshAeKwEg7c0IN/j
 v/zuQastyo5P4s4h741WrhsAOhXsl9t/OO0rFh/G2ksyWuLCVD2SSPhcZsm+AD2zJX+Y
 wy3o5mavuOM3oP7wQ46DEgnwtkjM2jFabSTmgbc/zZX1z9NRfjth6iZB01EkWFjpWbC2
 4+y5/ieyPUZHDaqLqJ/ol1mgisGM2WLF7yNTM+X0ZHd9gZW7eEzF33fTcT3GKMsioCOF
 1SwULs1wLDlEk3kN4SaRwvZ4dCrJWcmROfUvmzDr/A0THsgTgg2m7oMu+qphiZLgtdXs
 Wx+Q==
X-Gm-Message-State: AOJu0YwGC2q+FH8UebL6JdAGc2IsqOZjnVzYmrmE2scm8fpa0QuBGGIi
 ZxQFWg+Dxd4dsgzLRkOomrmQudQvyGOnjEfUBJzhLPkip9wkW8lNcozfinHmJq8WD71XMW7Hinf
 kyYvmGrYOCJb2w2TujAPMZ/wvSrqGvrk=
X-Gm-Gg: AZuq6aLwnujh6opX+l3Y/rAD+txnjXStU642A1NQOl7Oq3GnCcbLdxrrceOoCLUN6cx
 kU2cnYcjRXd7fI14jAW6qeFbq7hzCjvBx7Z78+1wZhpKbLhAe30GLOnRAs9XiTxByRSz3di9IfE
 TFgpcKvI2OlYLBNK3nTqcZe/bLDwunN9okw6tqd79rM+6fMG1P2dV0P02c449fhxdClSF/XfxOk
 QtQPngT1S8JRQHiel9bMEtQeSejUh+9czOFszWs7Vk/MIiXjDKlnUWJUrWj+MJSG8+Y6nS42PtM
 OjGSUic=
X-Received: by 2002:ac8:5d8e:0:b0:507:3fe:8cff with SMTP id
 d75a77b69052e-5070bc88b52mr159022731cf.59.1771931571941; Tue, 24 Feb 2026
 03:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-82-marcandre.lureau@redhat.com>
 <CAFEAcA_JDh++oFZ9+bHoPvxP4LuqjXUFWehqHdSZm16B=+iqCg@mail.gmail.com>
In-Reply-To: <CAFEAcA_JDh++oFZ9+bHoPvxP4LuqjXUFWehqHdSZm16B=+iqCg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:12:40 +0100
X-Gm-Features: AaiRm535yo5ipB0h44PFeNxrZaAQi2lr_MVJwfwmI-88bA3WTeev5GL_ViaubpA
Message-ID: <CAJ+F1C+TV3mQ0uqYF0txyiW9jKENMoYncLAAqUhFF3fFax9eAg@mail.gmail.com>
Subject: Re: [PULL v3 81/85] audio: rework audio_bug()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Feb 24, 2026 at 11:30=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 23 Feb 2026 at 13:51, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > audio_bug() is a bit unconventional, it is meant to be used as a
> > condition expression, passing the actual condition as second argument
> > (and __func__ as first argument).
> >
> > If the condition is true, it uses AUD_log() to print to stderr, and has
> > some dubious recommendations printed only once.
> >
> > This change:
> > - clears the control flow, and make the condition directly visible in
> >   the 'if' statement.
> > - uses standard QEMU error_report()
> > - audio_bug() now captures __func__
> > - remove the "Save all your work and restart..." once hint
> >
> > Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi; Coverity points out a bug here (CID 1645326, 1645328);
> this looks like it is probably a pre-existing one that was either
> re-noticed because of the code changes in this area, or else
> made clearer to Coverity because of the cleanup of the control
> flow logic. Anyway:
>
> > @@ -498,9 +498,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
> >      AudioMixengBackendClass *k;
> >      AudiodevPerDirectionOptions *pdo;
> >
> > -    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> > -        dolog("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p\n",
> > -              be, name, callback_fn, as);
> > +    if (!be || !name || !callback_fn || !as) {
> > +        audio_bug("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p",
> > +                  be, name, callback_fn, as);
> >          goto fail;
> >      }
>
> In this error-exit check, we will go to the "fail" label if be is NULL.
> But the code at 'fail:' does:
>
>     glue(audio_be_close_, TYPE)(be, sw);
>
> and those functions will crash if passed a NULL AudioBackend pointer.
>
> Presumably we should simply return in the be =3D=3D NULL case ?

I think so. abort() may be an option too imho

Do you want me to send a patch?

--=20
Marc-Andr=C3=A9 Lureau

