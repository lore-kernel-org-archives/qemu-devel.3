Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAE0CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAxZ-0001mB-6b; Thu, 18 Jun 2026 07:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1waAxW-0001lW-90
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1waAxU-0007nb-TA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781782255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLifyH9wwKhXmZr0mH4q7xbzpvzt1kDkLGA8uGgC+KI=;
 b=WDJT00+E6Hfo5BSHrcb3eDw0ApkRb13ks9UX1cN0BiVFtc/ByOf3gGSoiZG65bZKgBzQgR
 5nfBNNWg1p/QgLAimv4Qn1JuJSEuZOPpEigkOQMukZmBhorZkG8ZIG5kAz9tFwp+qfUo/b
 CFUHWwucG2YdtsKILmvJHwQpLtx/3qs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-dF48XnSyNeyoYLkB_8mxbw-1; Thu, 18 Jun 2026 07:30:53 -0400
X-MC-Unique: dF48XnSyNeyoYLkB_8mxbw-1
X-Mimecast-MFC-AGG-ID: dF48XnSyNeyoYLkB_8mxbw_1781782253
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88da04b71dso590808a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 04:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781782253; cv=none;
 d=google.com; s=arc-20240605;
 b=cQbP32UZ00vFaiO1UhUn6180n2ST0uN4BsYupWrVWDdRuwdIhsEexK167TBUhHbrMK
 Cap9uVzfwm9peKRM/IKqmAq7lifWgtAhMUdyRmIrpuKosJLLejbcu5tZ1lcMvDlpW098
 1WnGr5tSuz8L+lK1kGjHWwvlixT5PVIxfwVzBA0ESD6VQlxL75eOXnSCkHG7QX+2Ypm3
 f6cGwQHtDuVqN1nhdBedsVI2LhLPiIr70boKUyLmhCp2EtFyuzGW3uE4rsCIZKVLUNCh
 k/7BFl5W0c78w5Aa3CJQDybnx/wpPMfCUDFpWDjDQe849Ts3HkG4Yi0Ca6a1hSPDG9iF
 tF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GLifyH9wwKhXmZr0mH4q7xbzpvzt1kDkLGA8uGgC+KI=;
 fh=w+VAXIwO0btySx+RJ+E+w4s5PR/wdBxtmklBKOkx3oE=;
 b=KG8oTw3XT4x8ao2AdLhUzAoEd6h7Fx3ecfM6jW8nCjbt2ocsAPh2wJaNbnvfiWkB+K
 OfWcsWmQ6rOAfMZud4r2qbk5j8KnbZC4sMHw1+pqH2wqTe17XoDgxgfUwMB0BfwVdzjD
 8C2xva1aeGGuHLhTqHHdYwQiAonSA+ATfYRHp20twYZuKuLZha8dyjsjChfLwWU6EAWc
 tfOBgNkHC3juTMoLwEVnKS2sbfNPqopNIvqYVdrdl/9iOwIcmXJp527q+aWkMwVJ9/7J
 9nPC78kwr/KjPXhtHNyHRTKJScwV86T/N+fPwzBiv3L0PtacPWMmpaF7Zp46/ejetmWZ
 jDqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781782253; x=1782387053; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLifyH9wwKhXmZr0mH4q7xbzpvzt1kDkLGA8uGgC+KI=;
 b=WCZvFT3vPliRhSbEvLPCKF5pdwV64/fJ43IU2578j3L1aMBKKCyOL/O7Hl7+dmH1f1
 jjg3pmFJWHQENozI9NRPamVvhy8czvTgKqsqynlc4bHBkEQ+b3y4dMjOkmwEYkWAgnzY
 4Y6lazIzFraO3Nb5APwEHRruauRgfn4UFvb5kuYCSVirh4N/ntA/ekv7p5OtfReE7KrV
 RkcPNPD00vE7IApqKWrCGz87mU/+N5L4HVPFyzpEZxQaCdOjAfjPjTpb0DzqBxGBAXK1
 lptknXnJz2FB0UYHi9YHIq9RoqLi2eNrrLOQNm9uLuSdoXZnbTRaU84VDSlF9Pyt1kIu
 nGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781782253; x=1782387053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLifyH9wwKhXmZr0mH4q7xbzpvzt1kDkLGA8uGgC+KI=;
 b=BedHU9vNwCFLuLje8kXp4LJPhV43d7o4xltWpbB+06UrccrbZuJSTDROck7BmpX0y8
 GZmDtmugTnFCsWeKkBgj0Gj8jqTKFHy+GXLQLDCKnohYy2nZQeyT+dBGNLqPtwJ4zvVy
 6BvLM6Kjf4EVqrcWp+2Azz/oNWf8SpPzEz+Xk67C+npBQ8yMBf5ALPSawStnA4qBZMzo
 4kBnUZ/PaLTkFW/4MbgUctovbVODgBeVHo9p2kNuS+VSm//pvbv5lskmVemZkG4JwzM6
 fK3F5DziX8kpAnKj3/HPjMlrETQH3Pw9adaH8s8fAXONTvFcG0/lZc+hAAiuUI2alxoz
 nxIQ==
X-Gm-Message-State: AOJu0Yyfj0IypRRoGMeZKOiqrEdFnw3C1y77eEIpFJEk0V9eY9mtN+I5
 2wKEIcQfs2TBMc6ys7+XAuZxYDDoeR0aQmJ1CWaY7vYZDc9wmwwnoVzHk28L54FetDa08Sv3E/c
 bW8Lx9JDqwFxUENYtUo/noqJUn5zGYMy9xUlfGZb4KPVkYuzLEfV6ikg9sqSRXCLjJL931Y07LB
 dzbyeWDD2V9SLw63JaPd4NuAJkvC3lshY=
X-Gm-Gg: AfdE7ckmybXcK00KzzExR2KIM9fPkVGnaWVadwweKiefKkdI04xij3O+p3eIT9AsT1J
 i+ZiVw9yTQNNTvwaKw8ANSKGgcaLRTlOHB4IqqxY55Vy9gp7jAiVu06Vw2Kxhc81gnWkYXNKbZK
 ayRFBbdBcphpYGrtVUo4uhtdELM4YkDMuEY7VP0szC5Fta6Hd3Ivb+pvWCZkuacYeTTDnX1Rhfl
 GQ3HYJfmHc+TDrXKx5iocIAOu233+2xevSRbLHeDV3oJpMs7WfDLrxGwxuS6FSTI+55Kf6vY4/i
 gqDiRupCyWgS
X-Received: by 2002:a17:902:d542:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2c6f3465e4amr24726635ad.19.1781782252552; 
 Thu, 18 Jun 2026 04:30:52 -0700 (PDT)
X-Received: by 2002:a17:902:d542:b0:2be:3434:4e28 with SMTP id
 d9443c01a7336-2c6f3465e4amr24726115ad.19.1781782252063; Thu, 18 Jun 2026
 04:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-char-win-stdio-typo-v1-1-05086b1b326b@gmail.com>
In-Reply-To: <20260618-char-win-stdio-typo-v1-1-05086b1b326b@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 18 Jun 2026 15:30:40 +0400
X-Gm-Features: AVVi8CcbsqQWhcDF1h72udzseGsRD5QOyH8jb0jf1pkg9kQpTTxO0QlCdOydFDQ
Message-ID: <CAMxuvawA-fGRAu25dL9Q=C2jqxTJkhibqrJtu6y8NsDy8P7rrA@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] char-win-stdio: fix typo in spelling of 'stdio'
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 18, 2026 at 3:21=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-win-stdio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index bb9c195a8b..0deba3bffb 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -128,7 +128,7 @@ static void win_stdio_thread_wait_func(void *opaque)
>      SetEvent(stdio->hInputDoneEvent);
>  }
>
> -static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
> +static void win_stdio_chr_set_echo(Chardev *chr, bool echo)
>  {
>      WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
>      DWORD              dwMode =3D 0;
> @@ -205,7 +205,7 @@ static bool win_stdio_chr_open(Chardev *chr,
>
>      SetConsoleMode(stdio->hStdIn, dwMode);
>
> -    win_stiod_chr_set_echo(chr, false);
> +    win_stdio_chr_set_echo(chr, false);
>
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      return true;
> @@ -263,7 +263,7 @@ static void char_win_stdio_class_init(ObjectClass *oc=
, const void *data)
>
>      cc->chr_open =3D win_stdio_chr_open;
>      cc->chr_write =3D win_stdio_chr_write;
> -    cc->chr_set_echo =3D win_stiod_chr_set_echo;
> +    cc->chr_set_echo =3D win_stdio_chr_set_echo;
>  }
>
>  static const TypeInfo char_win_stdio_type_info =3D {
>
> ---
> base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
> change-id: 20260618-char-win-stdio-typo-5abb197de4e2
>
> Best regards,
> --
> Filip Hejsek <filip.hejsek@gmail.com>
>


