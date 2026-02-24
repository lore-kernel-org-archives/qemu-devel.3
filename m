Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270D4E9B249
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupfi-00012k-F3; Tue, 24 Feb 2026 05:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vupfg-00012Y-TS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:29:40 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vupff-0008Le-7S
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:29:40 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad46a44easo5071430d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:29:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928976; cv=none;
 d=google.com; s=arc-20240605;
 b=ffCWRM4eCoeYW1qS2S1S1dDf3y+z1edOs1Ox74DXxkrCF4u/vDaG/fKrrArjkktgRZ
 qLFIqJZgS1wX8unmmhjktwiLROAmUbwQCInfJvmzz8yNSiOs/JNpNZo0BduEQXUgJ0az
 09rH1LBgi4kcjQrpwLNRipKTS9JVMshJc7oJXKe/jQ3Dqa3+PTN991NBZQJNpP/XTlRD
 kGGULzXQWRTJ9kP5PkrRF9JFMwo3rcaeXvTY7bjPAHHwz16SRsyq5rQDCc5PFZu79Vwg
 NUJwHNVf2RZ1LlB4I/6UvFTMLfduNc+QfS2K9XAsqNqXLq+Ye/huzLe3cT4umgIdRRMq
 HRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jLfaQE4n8ySEn559+51uYsx4GLS+EGdE5B+MgR+tcI0=;
 fh=kL/ngBt8EPGU8+6uaRQ/ntBYkR5vo8tU1gZCgq7YGG4=;
 b=RdSTI/BSS0pl5bTU0mVB2NZfk/sYlXBQv3qYaZiH1/mzXJoAY1q2HnTBA0ihNcXfvH
 9NPEu77f6eIObv8E7OTtqSKx7zZhaaXe+79esJ+Xhh4Fq3VqpM8QYjBBwzdesGlhmG1U
 By4Yu+rqvi4QQb/yDLNiGvDh4DHjD/TDOqN2DnTPbFOxKvw6dPMp2MICCJtlddWtiXZ4
 Rfc0rc/D+bOi1EaNlgX/9FuH9SpUdu1kkL9Kq8fTAtUTKMbKDSwufZYzkeP0LPOyCZEl
 4cBXRuISMk2yn9E90sC0szYGxC0hJsjb7isht2g4uJ9pqqGgKww5/WWYHf9RFq+em1N7
 3JFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771928976; x=1772533776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLfaQE4n8ySEn559+51uYsx4GLS+EGdE5B+MgR+tcI0=;
 b=eYxbBN2oGh61OTQVS3IQYXLnxF/2eM6bmyPO84X40QC8y2Deec00M6SQfhecO5o49T
 iRurfXfD42bvKAIZqTMWaZwDhOJNHGylhckuBYOHQDRi8LfaRVT/bHjd1htLvPbTE4gA
 sZtwub0Zg3I7pyPj3nJlfNbHt10owyx9BVeOM8GvsttYgM0zSRe6MlLE3E31vxc7MVuh
 UFdRcHR1ra89THiTZKt2blZqbbE/gablbXAsEg4KYNK++0TpqW13LKWO8P5en4p/x5OO
 Dx7T789UGZGK/83GtHzWkHAAlK2S084vgf73M3Cx2tXEqpjqXT5gY/omlQC6TrWDNlkH
 fLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928976; x=1772533776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLfaQE4n8ySEn559+51uYsx4GLS+EGdE5B+MgR+tcI0=;
 b=SXdhFYghNCPXdblqHY6rFkK4cKHjTajY/Np3RroR0DvTMORktbbKR64e0hPM6U59Js
 xVSvZsb4ZnFKJh2nZlcQB/qAiBB3YxtTNYmJYVraGxRhpxmXZEcE4SdOne5E5nRYKSp+
 F5hjgLmSGtAd2YzPwjouHvza4gjfb7vGyTBJYsHpnJuklEDn74R+7pfRvHSJt0YgWKcU
 ISlK38VfbtwVwWG8SSq0Vhz1K02O8TgS4gdiQqOmkwxt5Yu/qeuRJAzt3pf98CBuR84c
 26C6m+RUAL7aJfazhEB2Z7rN4qTsfluko+WdE3IYtZEwPBrCsQtbqPMeD1Rv7LSAVhZi
 qz9w==
X-Gm-Message-State: AOJu0YwZDAmm3nMK5AWyX/uYvyFD33SP5VK/HH3paXlzMRl4S6kx+Ntn
 ZGsZRe12Y/6KlVa4tw09bLcls87QszJHeFQ4Q66f9y7KmGgHPuAk/BMUQhs7i83g6xvkihjS6U2
 VeHKZ4UPxKEx6R7ZfSyR8LmbJGIksoxtE89QKCKIKEQ==
X-Gm-Gg: ATEYQzwOS0/mt75H7LoBPaeyf5rzS+w2v/IEz6rD9ucd8BoxEogpcJjUiEJ4d+HqdQU
 i0cJL9i9rBpZgQElJEBR2VohSbk014g1ICCoNzBXiZAa5IT/6Ej5R7hbNwLR4pkjfHLmP4v5A3e
 tQ/m57k+gwS5P5Aw6JjWX7RV3dF+Y65zOTXJWdQIR4elaqjZ11EJ2u1yfFZ6vr9Y7HMJGk2zqOa
 y9mbzA4W8tG5dwPL83VEaWYJRfUrbHm3qc6KXIUNnC4APSgqA2phuLeEFzVd+Pw7Hu75X+T8wJj
 uhWzP7UEviV9+kkLXoS20FWRchzFthq0mcgY54J3effETXGNiGJqvhA0Dp1gAmk2NJvE9Uyoq/L
 4zg==
X-Received: by 2002:a53:d008:0:b0:649:429a:4577 with SMTP id
 956f58d0204a3-64c790a6274mr9448680d50.86.1771928975688; Tue, 24 Feb 2026
 02:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-82-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-82-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 10:29:23 +0000
X-Gm-Features: AaiRm53pSMqqNM3ChZbzEjH9RBuf0lnqaZyHf5mW1-m8sPS3adnw6bc_VY-NGDU
Message-ID: <CAFEAcA_JDh++oFZ9+bHoPvxP4LuqjXUFWehqHdSZm16B=+iqCg@mail.gmail.com>
Subject: Re: [PULL v3 81/85] audio: rework audio_bug()
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 23 Feb 2026 at 13:51, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> audio_bug() is a bit unconventional, it is meant to be used as a
> condition expression, passing the actual condition as second argument
> (and __func__ as first argument).
>
> If the condition is true, it uses AUD_log() to print to stderr, and has
> some dubious recommendations printed only once.
>
> This change:
> - clears the control flow, and make the condition directly visible in
>   the 'if' statement.
> - uses standard QEMU error_report()
> - audio_bug() now captures __func__
> - remove the "Save all your work and restart..." once hint
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Hi; Coverity points out a bug here (CID 1645326, 1645328);
this looks like it is probably a pre-existing one that was either
re-noticed because of the code changes in this area, or else
made clearer to Coverity because of the cleanup of the control
flow logic. Anyway:

> @@ -498,9 +498,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>      AudioMixengBackendClass *k;
>      AudiodevPerDirectionOptions *pdo;
>
> -    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> -        dolog("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p\n",
> -              be, name, callback_fn, as);
> +    if (!be || !name || !callback_fn || !as) {
> +        audio_bug("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p",
> +                  be, name, callback_fn, as);
>          goto fail;
>      }

In this error-exit check, we will go to the "fail" label if be is NULL.
But the code at 'fail:' does:

    glue(audio_be_close_, TYPE)(be, sw);

and those functions will crash if passed a NULL AudioBackend pointer.

Presumably we should simply return in the be =3D=3D NULL case ?

thanks
-- PMM

