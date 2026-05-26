Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5875ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq5Z-0004Oa-Sk; Tue, 26 May 2026 07:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRq5P-0004G4-FT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:36:40 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wRq5N-0005Rf-UJ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:36:39 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-30246cfd41aso194677eec.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779795388; cv=none;
 d=google.com; s=arc-20240605;
 b=OrQIQKBEWfNi7Fdn8cj1TYBRfkEhwX4c/sGPnS+kmIMqMBI5PeDEf6Ln0jKmzbac+f
 4QTNMssjWhJKNVpk3v0i7u9CsmVRJ7haSFkZD+rR89Frd4Ytb3BV11e1xafOE1PWg2a9
 1eKw6mRcLr7iFqhE2GwVEpbbE9x00EWSZ/7v9c1aK2JzLbu1JFh3Iq82b8SomOB5CSPC
 euEnfK7BqvRB2CeLHdk+mZIESA/DkxatInVdzKCxyI+L9JV8ZQi5i1f0IEsDzmOeeewT
 Wnsv39TOcWU5BH5iBdG7IsxvCyshfV/A+BsIisrDOwqs53gvrbGHQ7Fx8/D3l0VuML5F
 5zRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5G5/eZX2sMQJ1AuBwUloeDGF/nN9GHpcUmw710ZTiP8=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=WrGASTCN8cSLGpvb9Xd4yrTu6wFw27zYNOTWQwRjYo9jFCs33N2kq97vBZ6hvZKydn
 gM+RPGIDQCyOy6pMjyzQ44XSDaLlpDw46pnB0KYDHFhT6TLH8/f26o/KSaq5zWH50x0R
 qLJIj5LKSksqbIVltc/40uGaDJf7fvyTDfRgxtx1aR5IlRdQtdQUvVuwxDjAJaK8gWkJ
 mbY0+nz/YLVOkIW7tmgPIly66/0ys37c6eIYwcHdeTczTeoqnituQjNqkxRkf6cgAefl
 +hnlQbGWplKI5Cj/36z6GyTctI03vTGE/yyG2xfN5CYeJlwhsTDbcp/OrZsh7dYRdCtg
 9CNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779795388; x=1780400188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5G5/eZX2sMQJ1AuBwUloeDGF/nN9GHpcUmw710ZTiP8=;
 b=lPKg+2Ft+U0aUCMdEim3GxFeAdPeVXgcmKSmoScpBU03btc/6IlJsttV0EoYFtcwCE
 LBUz4fDECu4iWRuAdUC6U8EMhNtwGXJ3ka6zLuB7g8nS5NskZBNBK84Y/cFI6KAOaLZW
 wzXf85eV6obgK+dEg2Xe556Juhu3ustBzkcHaDre/jcOjXH3sgdH32E5ZluCy3f3otoh
 C6pTAcSw02lexicyolX09acmthRHDoR+wgQtr49iw0J8lr6djm6+Q32EegHKfp4C/D2f
 4QCMPGFikW6sdgFClnK7629WmlSDoH7L5fPt0wCgzgePzzZTbhlQ7OyUKNCpRhNUv6Et
 YPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795388; x=1780400188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5G5/eZX2sMQJ1AuBwUloeDGF/nN9GHpcUmw710ZTiP8=;
 b=oR2W4hJpsxE3uFBhGQrcpqeCWLDHBTh2KhHmGG/Q6Qvh6PAnePK1nI8H/UVgrGM+1+
 tPYXM+rA8KTYfNhfz/4RNUsA/XUoOzFmSbZlA9QfI0ivlePHDdk7hL7FoJqIC9dnZWhF
 WG4KLqYccDJ5VVNMvKRpMHdYHrFSpUT1/KtevJfd1Q+YbBMucMdjwk5WcU+hDEx5oLR5
 6/7iwn6KFL8S0LHze74fXNqlR1zzwAqqmhQkMIB7lL5L/YL7vOcQ8/GRzWgz7BgTniwi
 kPKJlf33leT8w8nbojHFWqzU3D23MSLiD5Nm1pTCitaCcZTaUT1ftmXiZn575RajqwZ0
 ChcQ==
X-Gm-Message-State: AOJu0Yzz7jm5oRFv2Jldv72iS8gk3sOl9ILrdIp/uHDAhNwEMvLM8533
 lgu0i0qxzWKDbAgyN9Lp9sqkXdOlGXSONKau1wqG9TEkacbuxnMSTpo0IPEgXqT79xsvS0JTtmS
 cNLcygM/DaAjnGZsboKD/ebGNm7IJh40=
X-Gm-Gg: Acq92OEavGKwdVIMTi1s239078pmpsFNxqSbJKtKIl1A+e9RDnXJQgcj6PANjDfYYfN
 NcbPdoej2Q6+Ah57Eptvgv5LNayPMFkrLgxukhibe8HvTiEpE/sUQXAuDnxg4n5IPOI6hu66STj
 JUsRa8ov83rZYMG3nD7PRGamw1hLv9W4iQXGQLY5zKwuI8fYav0BO5EQ9AYYBWbHoCC8yjsf/G2
 7GKfOte4D5+1QI5ENJFkMwHjPun7Ew6UKC+ie63eXy1a4h74IWbxnQW7r9EH5cD2wW1lqvcdP8t
 D8Cj5ZpCHUu0cKBkOy/LiBainb4AgYU9dGfQzx8=
X-Received: by 2002:a05:7301:4918:b0:2e6:e868:4f38 with SMTP id
 5a478bee46e88-30449024c7bmr7582510eec.3.1779795387975; Tue, 26 May 2026
 04:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260526092446.147924-1-pbonzini@redhat.com>
In-Reply-To: <20260526092446.147924-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 May 2026 15:36:16 +0400
X-Gm-Features: AVHnY4IQ77a8uwB-j2l4awJJjDBFrdKTWIa7TEiTHPiKAXDI2j7RYrbb5d_FnvU
Message-ID: <CAJ+F1CJpapHN_UWD-TaZKRjT01RTNvLvammE6301-HLO0T3Fog@mail.gmail.com>
Subject: Re: [PATCH] rust: fix incorrect dependency in Cargo.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132d.google.com
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

On Tue, May 26, 2026 at 1:25=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  rust/bindings/hwcore-sys/Cargo.toml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/rust/bindings/hwcore-sys/Cargo.toml b/rust/bindings/hwcore-s=
ys/Cargo.toml
> index c20024e921a..b5ae33da8ed 100644
> --- a/rust/bindings/hwcore-sys/Cargo.toml
> +++ b/rust/bindings/hwcore-sys/Cargo.toml
> @@ -21,7 +21,6 @@ chardev-sys =3D { path =3D "../chardev-sys" }
>  qom-sys =3D { path =3D "../qom-sys" }
>  migration-sys =3D { path =3D "../migration-sys" }
>  util-sys =3D { path =3D "../util-sys" }
> -system-sys =3D { path =3D "../system-sys" }
>
>  [lints]
>  workspace =3D true
> --
> 2.54.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

