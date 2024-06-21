Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC671C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKW2R-0006Fk-Fg; Fri, 21 Jun 2024 00:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKW2O-0006FK-5M
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:38:12 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKW2M-000334-NQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:38:11 -0400
Received: by mail-yb1-f174.google.com with SMTP id
 3f1490d57ef6-dfef5980a69so1590646276.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944689; x=1719549489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTptgE8hNc6iHb3J/5LydqxSVcU81eNMVUVVXfBsgP4=;
 b=Int7Jxl8jqy3HdT4UMORWW6Ef/zLwVzYQnIwwJoOS3eWIsnQBJ4d7tdtGF8CmMY7rE
 YsI+UybIyi7aU2euBE+Jy8CUtl3v6ot9D994SpypAAwiJwCgTpXeUpdYkLSBUaiyW7Gx
 1SM0w6jPG7rSi93im2cdEP4c3DzWB7FDLXT01qaUjquR24+MoBUD4fUBMUrX9CYB7Qtn
 FsS3J9knvBBBtdnZeSBdB1HMQf9xfSwYji9ubIKXGNzI6DtbNcGZLXL6VxPfkwEuiZq5
 a14yEg03D7kTLNRS+jPN3/UCLgzQgExOsHt5rnvHKspRlRw18Z5Mbz6vQimli9/99Y61
 cDqg==
X-Gm-Message-State: AOJu0YwH0neeuhFPVB/Lfcx+Jw/rINSWMtL3p7RkNinPVC5G1uzSUJFc
 a1OHsaJnkiZDN/LO0Wp7L+JWqDeO2LrK+gckocU7cHhj5zR5iMTO7gk0wQvCFIbWoxycvRLgjoO
 DTw/58b/kYNC4DAHh4Ai7M76Avqc=
X-Google-Smtp-Source: AGHT+IEF0Pw5aNGmP39GC8cTeu6+4gvfq6dMWyx08c8ROYgRJOqn+nscYMWfm421484XNipnEX084yn8VYwGc3OsW/s=
X-Received: by 2002:a25:69c6:0:b0:e02:c72a:5f4e with SMTP id
 3f1490d57ef6-e02c72a6199mr5900705276.53.1718944688438; Thu, 20 Jun 2024
 21:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240620234633.74447-1-syq@debian.org>
 <3faf6561-804f-4d1c-8204-f4bb9f7a3b94@linaro.org>
In-Reply-To: <3faf6561-804f-4d1c-8204-f4bb9f7a3b94@linaro.org>
From: YunQiang Su <syq@debian.org>
Date: Fri, 21 Jun 2024 12:37:57 +0800
Message-ID: <CAKcpw6UqJFFsVJ92tU-Aod8bC_WQsEZSCRZhD3efW7v6V88hOw@mail.gmail.com>
Subject: Re: [PATCH] mips: pass code of conditional trap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, macro@orcam.me.uk, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.174; envelope-from=wzssyqa@gmail.com;
 helo=mail-yb1-f174.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> =E4=BA=8E2024=E5=B9=B46=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 12:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/20/24 16:46, YunQiang Su wrote:
> > @@ -4553,7 +4559,7 @@ static void gen_trap(DisasContext *ctx, uint32_t =
opc,
> >           if (ctx->hflags !=3D ctx->saved_hflags) {
> >               tcg_gen_movi_i32(hflags, ctx->hflags);
> >           }
> > -        generate_exception(ctx, EXCP_TRAP);
> > +        generate_exception_with_code(ctx, EXCP_TRAP, code);
> >           gen_set_label(l1);
> >       }
> >   }
>
> There are two instances within gen_trap, one of which *does* store into e=
rror_code, but
> that gets overwritten by do_raise_exception_err.
>

Ohh, yes. There is another `generate_exception_end` if cond =3D=3D 0.

> Search for EXCP_TRAP.
>
>
> r~

