Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8AE9B253
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqFQ-0002AQ-76; Tue, 24 Feb 2026 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFN-00028V-Ob
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:34 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFK-0006pI-Vc
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:33 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5069b3e0c66so83176071cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931189; cv=none;
 d=google.com; s=arc-20240605;
 b=b07H2Mn4RoEvJG/+n2+fpJoH7Yi7mg/Nz58/BgFTlKWDYXRZrqlshRuoy/bQywVa0E
 SagDcQ/C2TNyDOy/oCzSnG3jk8pc68QPKiuROOTTnGg/3cezBJjjMNhX+YGVoYwBjAVO
 +7yaGRLv2WAXInDFXuXz513azM4mPbxylNSyHxkhVlDmzrR0uvp4MagpqEFn4XT3hx3M
 hppAYuffxoOxL5LZCfeHd19efcRv044d3wQveHHl5lQiWoDrYfsMIFTMSPn+H3TmWwgo
 egJ0vvaWUByLQ7ibHCQv1Vr23xi3fchcGUjiQHbUzO4tQ4URrxOnlVElu4YHFU4YcFru
 LwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rVkSvx6FCUBuLJhweEihcTC77IGsE9NzPz82UMcwL9I=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=ObZiVt0hqrlM14OpmOx4JseYvRnTjj4hKPwzbryCcsQwXNB3HVGNQVPqBKd3TM2uKl
 BqvUeDVUyJYf+Jq9o1DX4I+xznVNY023O24anHRxrMFYxsdqSReNHELirhGmqvg3/f8J
 LQBmOkWDocSU8X9ua8QpaQ+IjX78JTiu0DYNrCi1W2VFExaxdR31FBtmmiBYnFC4cY8t
 doqpo/k61leqDANJBKxMGniRbq8oi4JieC33s1fLin7HYbVd9yQ6AfPdJrv8ajET+6tz
 cusSvhxwHqZK4u0KV/rKaPLCh4UzXXuq3qfHMy/kzSXYAEKupd/do5L3MOtz51hlr5vg
 Ebzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931189; x=1772535989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVkSvx6FCUBuLJhweEihcTC77IGsE9NzPz82UMcwL9I=;
 b=ViziLfxpHgiZVwMoD/+VV98s2i+dwShZeQ4jnV5fc2XVXTXY8+S23DA4I9ip6NsPzf
 Otq+OXZoSKymM6/g3OUr3mWtbQxbKZFGIeQm8T06DjWj6bmSoEv10obzJpxAB186TMLU
 HmmqsIuB6Skl6BSJCp1e81qVwGW3nWjnPBG1kgdpaEKif8MjLECRFvS4M5IpezJ4Ykrz
 puv8c69GoIjJ3a1HTyke7wTP8cwa6K/jlC99U8iq+GygNL7U2fFt3Q4/D0dAD7sDB1YK
 1PgALAjZIcMnLjHyVMTCyw6I4nNRpndU5ARTgFCVObLQgZdg/Aj/y2Uogz77DeAEpyIW
 YUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931189; x=1772535989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVkSvx6FCUBuLJhweEihcTC77IGsE9NzPz82UMcwL9I=;
 b=USgcMZHEK9shloCMjAJ7174gFn5npioX2vcoXIAzZStQvIuZIylHVQW9jc6Slu/f3v
 PJxlDaBTMWMo60oGTthjNBP4MkF75Knd2wm6ZG+eMqlZWBK7usbbGyYIuyjU5ElCyUqh
 dSrKQhY17DpUdzl7LnGyalQqfGkuOsQ2WrTTUMteVdLS30nuG89/VVV7/D2fjrlQRSdq
 52je8iHdwSF3c6JGMJ93fwNpDxVLpRygRblgWOplNyNjvIOmCHXDMLCDlLW/LQhmrrNX
 t1O4H5py8/wj+jn9z5gwjyslPpWOaaiSoiI0HgOg2DzeivQhci77q5zFUkhw4sIUXaGk
 aurA==
X-Gm-Message-State: AOJu0Yxyzv2+kqG3S6qeW78xUFkO0UsFBIz6JHoy4VbQ72E6fcoALM+O
 faT3WMiFB28VUQMgdDAdlDZh/A0rCLkM4Vq+r4ZOv2l6jiNC9nCSN850nCPyUYUmYLAg/IV6HvN
 zx7WvxVOb6lzBDDqM7jmz2AMcrO93el4=
X-Gm-Gg: AZuq6aIMJuYLm38hhSV1yC8oqszc6GT09NlgzPHoaLqMmDKzjcWPa1nPtKWkq27z8If
 MXKK4YGvcOzOm4eDHWu2NRK2pY9di5J0iq8PVR8N8TOZRy7AYwppVUBRN2t9tlVIhLppuCx2N3D
 myUAHFPSTp+jV70urJdD6MHEeRA+CPBnT/F12693AAks2shuJTEboBYFn+0J3OGqzPN0xcOKY+G
 LvWPMPw/JRQzRqDgaNqrZeDFvFJKeaqgy87CcSyIY/6hdlPCI75MNlcjw6FHh8wIhl0fwCHZtdF
 v297JzE9t5/8zGi/uw==
X-Received: by 2002:a05:622a:91:b0:4ff:5ad1:5c36 with SMTP id
 d75a77b69052e-506f308ac26mr206418791cf.5.1771931189468; Tue, 24 Feb 2026
 03:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-9-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-9-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:06:17 +0100
X-Gm-Features: AaiRm52lBWklKy0ldzw38Y4uedUykLb2E3rBAeNtiiEBeUTe2z4FcSKfX1ryjPc
Message-ID: <CAJ+F1CLePepqaQ=FNvQodLouQiS7-=Tzp_Kg1CdUtQOJ+M6LpQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] tests/audio: do not compile if audio is disabled
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Feb 23, 2026 at 9:26=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> If QEMU is configured with --disable-audio, do not compile the audio
> tests.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/audio/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/audio/meson.build b/tests/audio/meson.build
> index 84754bde22..97c1d623bb 100644
> --- a/tests/audio/meson.build
> +++ b/tests/audio/meson.build
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
> -if not have_system
> +if not have_audio
>    subdir_done()
>  endif
>
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

