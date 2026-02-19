Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33D0E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1FB-0004X4-Hy; Thu, 19 Feb 2026 05:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1F8-0004Wp-9M
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:26:47 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1F5-0001Ms-08
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:26:45 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-649df3c22d4so670511d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771496802; cv=none;
 d=google.com; s=arc-20240605;
 b=kAabTfubBMLXxDm/AdG0ARBBPM3yniCkNY8MV5jfnC/Yt5apMht+pPFnya2RFqdYXi
 9YrGjXL+OgEipw0jayrAL1Bhf5hlqG2FGci7OJKcny+EwAFswcG4NloLia4W2cdGB5hy
 bLwkvCC3aJv5Y9jySxKuxUl7KLVFY/LcRqGkD7jWjuDyHRBt1jwuzyxLdpzxmgXgnbdK
 t6nO48vKZPnqenK40ESfhYyIvy8x6qbf4QmsIj5yL9VHzMjT2mYJ5//LfyBfXh1gjFwc
 gwPFGPB2nMXAjcYriumPOIZUTSY5Abk7XymGpNqzGn2ZmW0qFHlV8LKsP3gKJ15zF9Hp
 oC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nB393zfsiwGsDpyjttpMaZ2J28IphapeTZpOoqwhjLY=;
 fh=tG4CBmJXTonVRysEBib/KeCatw1YkaSor9+9/0kVez4=;
 b=BuT9j5AqNzPXyb8gfXGyePdX77XCR4cPIrETfe+dCpRjWTbZM30fGfeBefTm+wKt5Z
 Elb16pR+zVuWT74kmMerhhvpCDqRY+qWKGAUBBVb57UTyzWhyrAiJ1/fmxTuYBEO3zgg
 oZp+AfrkVpTI3V4vCza8VmkFj3FOcVMO3aJsqNpeY7U37OJthFNiLTTNyV6FVThv/fzV
 4SFjRTF5UOidyaW/f9Ud9lamkcNbgHXbqDOJxy7etnJxyOWg6OUCtufQ8lVzFAL9MwQp
 9/St8fhuICUlO+nFFI9E4K5EkDwB2b7WbGSMbbw8nS4gTIs7v8xbSxjV9TvDdiuabrVm
 aUVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771496802; x=1772101602; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nB393zfsiwGsDpyjttpMaZ2J28IphapeTZpOoqwhjLY=;
 b=PNAXD7GzIzgtJOxtB898wqb/9jG0U3+rMcFYdsReZEcwnpd+jEUP4ERhUzkTaHMklQ
 wBcMOmVDNi55gV+5ink/tslC6KnvYCv5lvNbLYolFQexYI7/eQRGG3AODMg2ZoPb9iAp
 njxE/eZ/roOret+D/Nv5gWCbe31tXlwbXBvvQ2Q/v6/5oAIJyySCFPmqZos4aN0JQKFP
 OSlzMLoS01PyG76qPIvHAjqS7o0w+2hbC7+vlp9ouEzi0iJ0QvWw+RcfA5i7soZ4TQ+q
 Sv860e/XQxccfHgstdKEjJM5DoDNodAku+xmDneNeo9Fu33zxYh8sWH6lzz5WKLLDGxN
 XQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771496802; x=1772101602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nB393zfsiwGsDpyjttpMaZ2J28IphapeTZpOoqwhjLY=;
 b=rhrhlX8g5C1XWYncOELaLiI5fyYWsxpITeQeYXLDPskRshMUODG7mb//fI/Li+HFn8
 qP7m1pn74e17knEFWeOE9OLZRgYLzx7OdGBhFRGM6fO7yu6UOjy56mpPMRWjuTVAsvJV
 qRQ4LBe5lb75h6lEEcyEyUCzKaBlFisB5kB/WprXdkHeha3DNIfzBJgcAm3xdAu6PuyS
 OD0wuzv7+r/sAZroKAjQ0q43/I9w4dJTQVMP8aCLgazfIdiSnyM/qj3CNcHPFg5250Ni
 aC2ZkMrC/kNa3gIhCN+tqoSr6mplMJAd6rHPiBTj60e2fo7IlHHtZr3XKklzu4EZd4ty
 Q8Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3i4lbAHbeHCVHavqiCLRcv3fln/QOU5kPNboVluvZhN/HQLVWE0H1lXg9woCBKWN8wtqn6v+n2gb6@nongnu.org
X-Gm-Message-State: AOJu0Yw9hbDj6i3b891SiC7MEpPbMFp0b5rHW5BlReJtDWyTgtKlrI92
 T71YAcNT/47mXFzuKgIZNL8BmdKRnqubkB8i8aTRXsjQM7f8C5LvSlXQiRY9f68md3B3n4AdreG
 pLpU98tG/4THhj5dSpGWZJWi3neua10nj+ofGF8nFnQ==
X-Gm-Gg: AZuq6aKYlaA9tCPn8LdXE7C2kTr0hsNiVFEO/4/xuY/n41tQqYDaP7/BmobJs5cvT2j
 5OxIDyfGzPlg5CuGfG9k50rEjgM6n2IxEDlNjJocPUtiTPObCBQMbq715Ba/Enc/RlGbeRfzzgE
 I+aXZDoKJAkHB4V+j+NkjrNOOZpuO6OV4KrZn+tSiNaCHmUuJ9biWRLYmxZSHInE2Gy1EMbctif
 h8JEbFc6M+yvm3jpU4bQpY7JXWzJiFb2w5mLfkG2vBYqjc6byye7C35XMwXPJ45sv+LMEc739Ur
 pW7FmbDWuU2J110CkqWqnHmKImBDUShJHMirSvskou1qB/xoT6Ac5m1ailf1CGGanNI=
X-Received: by 2002:a05:690e:1386:b0:649:b31e:8f59 with SMTP id
 956f58d0204a3-64c21a99f96mr14201838d50.35.1771496801944; Thu, 19 Feb 2026
 02:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
 <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
 <CAMxuvazA6Cay33qNT=Y9jN+TgxSTkKZdNfSORkQBG=Nr_0ok9Q@mail.gmail.com>
 <CAMxuvawjL=OV=doW5jqRBTBRhcF5DARUtgCN9hj4nyox_051Tg@mail.gmail.com>
In-Reply-To: <CAMxuvawjL=OV=doW5jqRBTBRhcF5DARUtgCN9hj4nyox_051Tg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:26:30 +0000
X-Gm-Features: AZwV_Qiqr9Eypf10Z-XhF-vJgvYqKPSlp8UkaArA5KWId7hj_Iz6TtbWe5fI20s
Message-ID: <CAFEAcA8dCFY3FfreEAMAMJsU=7dqGV0DzrAqMVBrD-wkuGkxvQ@mail.gmail.com>
Subject: Re: [PULL 00/85] Audio patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Benn=C3=A9e=2C_Alex?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 19 Feb 2026 at 10:22, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Feb 19, 2026 at 10:48=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi
> >
> > On Thu, Feb 19, 2026 at 10:13=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org> wrote:
> > >
> > > Hi; something in here seems to be causing the replay tests
> > > in the functional-test suite to fail. I've tried retry on
> > > the jobs several times so it doesn't seem to be an
> > > intermittent or infrastructure thing. Examples:
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/13179297572
> > > https://gitlab.com/qemu-project/qemu/-/jobs/13179297533
> > > https://gitlab.com/qemu-project/qemu/-/jobs/13179297557
> > >
> >
> > Good catch, this is related to "replay: remove dependency on audio/",
> > changing the replay format.
> >
> > I didn't realize there were scripts (scripts/replay-dump.py) checking
> > it (QEMU_CI=3D2 don't run those tests?).
>
> The following patch should be enough. Do you want me to resubmit?
>
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 097636570dd..081aaa36c5e 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -395,6 +395,9 @@ def decode_end(eid, name, dumpfile):
>                    Decoder(39, "EVENT_END", decode_end),
>  ]
>
> +# EVENT_AUDIO_IN has changed
> +v13_event_table =3D v12_event_table
> +
>  def parse_arguments():
>      "Grab arguments for script"
>      parser =3D argparse.ArgumentParser()
> @@ -413,7 +416,10 @@ def decode_file(filename):
>      # see REPLAY_VERSION
>      print("HEADER: version 0x%x" % (version))
>
> -    if version =3D=3D 0xe0200c:
> +    if version =3D=3D 0xe0200d:
> +        event_decode_table =3D v13_event_table
> +        replay_state.checkpoint_start =3D 30
> +    elif version =3D=3D 0xe0200c:
>

Yes, you'll need to resubmit, because I can't edit signed tags.

Also, ideally somebody who understands the replay tests should
review that fix.

-- PMM

