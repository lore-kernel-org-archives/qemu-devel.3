Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBDD0D17B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlJp-0003Ua-Mx; Thu, 08 Jan 2026 03:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlJl-0003T0-Vf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:24:31 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlJk-0003jJ-N5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:24:29 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4ee158187aaso30509851cf.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767860667; x=1768465467; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7ApMP/mjb1UwonqgYpP2D+Ea4FiMtu3bfWqVwNNNJs=;
 b=c+hu6c9G4YHH3nykzk4a7T8X3ubc+C3JbPimrlbY9046UJlabATKebgp1WblKU2Trg
 M1IdWmNRfnuDuaCXsi10Lo9PwJ7Id7KBQYckTS3CyXQQ1pZ/SjClXnJmUOJ4NIs5Ezhd
 J1bD4hQN7U/XivqAoTGZycg+WLlr/O5rBKM+j3A9KgySd3PLywgHXoxqwoHcYRjt711o
 WCWiOikvKwv9y0SHn3kPnyg9CdS+TIcsRNgAkwzUs8lUxOkUG7uyYotn6w4Mrqged3lN
 koJllqKirzYqNc40nZgdcBRjNUdSQT1WK/3L41V6RYsJ8J3nAwq/z0c6liE8Vfl51pPt
 kE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767860667; x=1768465467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7ApMP/mjb1UwonqgYpP2D+Ea4FiMtu3bfWqVwNNNJs=;
 b=bCQWHNBcFJW9PezCkiZ83ZKgsEw1sR8+HIipSvvICKg63kw8YtQTlzDLA83rLY310a
 X1NGXAR/0uhtnwByy/owhL2zfUVSenGfPbk2T/jbqNDBEXFLpwJSclhTE92uXLdgYWTo
 wBsQsNKmAI3qtmgT77qhpIMPABNOBJHg2udIGM0dT2tCitJbIyYYBWTZnVoMUbMJizpw
 XpHziYT/k9H/0QENj/+NvI3tFgloFsxOB/lpPZh3JtWqqjoWaJJEtUz9DYD5ghaW1Pm0
 qg1buboYZEOJLdTZZ/prrnwx9U31P7opDMTwkwDYO0uaOjoo1hb9fIPTJxC9p/tzpK79
 /Rqg==
X-Gm-Message-State: AOJu0YwYC0/N+nD2rC/2nsqQX0aunMeNeWkAcK98vsRGyv+yEj5llb3h
 qaW/lyb/IcUTO5PbOhbyYwnoIxO1kry5NCcxmPlYKU2eTnZ/xuHrQvLUIm5lSx5HE4eK9K/LWM2
 M5KpZAsGcAJJvej/D8+U4foU+zDxGNGA=
X-Gm-Gg: AY/fxX5ArVz+XLhSjPIM6V3rWb/iWTQLynXL/D4lzCHifdl/H7CFSJjAk7YAg3CEnVL
 5roJ5ExNXTUB3gSxkmVr6M+Nu+AqL4QYADDNsUBfYdGGe3xKhrxWzloZvCYwZmbwZun5i3mAPPZ
 4YS1W2HiEGwtujPiIiVS5cvQVelOMmN4c1FncXclqsq+jkAACGHUk5U17vqxJwH6kPm0hbjkNRL
 pT4WUo3FfCIbxxeZeegEU91DHmTiOPuxeYK228W5hfNDeHWJhM1P+ZzWJytKkDGUQIIRKFlewbP
 MmtZ0PU10j0WnFBHl+J1XNQ7k5k=
X-Google-Smtp-Source: AGHT+IFojSx6lVNchov8r3F73b2qMjkBInu/d81ahGzBcLfZwfEd6DuTIA6ydWoVWjTm8h5eYsjMmjXswRCPo+Omrqo=
X-Received: by 2002:a05:622a:41c4:b0:4ff:bfb1:7b36 with SMTP id
 d75a77b69052e-4ffbfb17d87mr20481641cf.52.1767860667621; Thu, 08 Jan 2026
 00:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-2-philmd@linaro.org>
In-Reply-To: <20260107180519.50820-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 12:24:16 +0400
X-Gm-Features: AQt7F2qlekiPoMcLzk4kZhnqUwNKgjKz6kO4Sju8o9fSvXCUftPvb_ANhTBvEc0
Message-ID: <CAJ+F1CKknetjiCXeW_K8MurFw_KMVFUiop69UfaL5fhoi1rH1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dump/win_dump: Abort in create_win_dump() on non-x86
 hosts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

Hi

On Wed, Jan 7, 2026 at 10:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> win_dump_available() reports an error on non-x86 hosts
> when Windows dump format is not available. In that case
> win_dump_available() shouldn't be called, otherwise this
> is a programming error: abort.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

(qmp_dump_guest_memory() should prevent that runtime error)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/win_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 3162e8bd487..6e07913dfb4 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -489,7 +489,7 @@ bool win_dump_available(Error **errp)
>
>  void create_win_dump(DumpState *s, Error **errp)
>  {
> -    win_dump_available(errp);
> +    g_assert_not_reached();
>  }
>
>  #endif
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

