Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3DFCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRGr-00068M-Hl; Mon, 25 Aug 2025 03:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRGm-00067h-AK
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:05:32 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRGd-0008CM-CR
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:05:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61c7942597fso392276a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756105520; x=1756710320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0+ehFD4WTn1fBln4opAQmq2mIo1Wq2A3xYJuDoTbpY=;
 b=LJe1icEoD3/F8iAfYkWjqR3xUk6IFvjEhC56g5Ywo5YmUjkB1QbUazor9cR+S2e/5N
 BLQBSnf6W6NTNdgQYqN4jZMd3YsSXb3I8mQ/CqQ2/2mowFcJcvC4ywd/3VE0C4L9JG5h
 vj+3AbaiSTlOrxMxpQfBwTgX6shB35ylhbV2PfjLoDrpfRBEd5mqBJ7Swdaeq2hSB/I2
 Zig36787VV5y2Efqr418AuO7BfcVDCtZU3WSx6dDDUd7wL3IFqzDaYDvysWTm8m6HyDA
 vS72nhodP05YGsj0QJa/KYl5FUBpUjdsJT51ofZYXoYF2M8zVA1dpJ7k5ZRt4vA9Tagk
 x3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756105520; x=1756710320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0+ehFD4WTn1fBln4opAQmq2mIo1Wq2A3xYJuDoTbpY=;
 b=UkCWteK/T6ENrUnttn+CIPn1ZQCksX4eNHzjWlg/yr4HzJydZUvbhn0F1vvk+wC5z2
 llUcYy8lfNGlOJ4Ykm48aQIiGBruz0oB9H/a7qbavJAVwiDMZj2U4ZUyrZZc4shebof7
 7ytvPSphpNKUQs3tn3qDYUA2bf3FgOUWZH5pM3j5uhCXfBXfp4xg4Mfit88RyvDQJtO7
 BoJ+cISMHflG9l/I65BstffHUcQQhgEzwQiW5fWQxuNhIm6n7UTIT4zv0wOn5QrxAXh3
 yQ19BKCyF24Oy7BXBP2ZqsE2rZvibi3RAEGHoG1ttCPwGQfj36RzBSdMAsCWTFJXSHQi
 jpCw==
X-Gm-Message-State: AOJu0YzEjfj2yOXieXpV2RBBQMJDkjuV21SjfOoiFeLgozPKh3h5JshR
 LDhlN8s1eF3RQVLkM1M2Z+1cMYZJtCcPFzsz3pe59wJog+UUFqOQ+RXzWhHn5ehKQmKEnGjEVjC
 Leb9v2ozf9ZimPSmRTdta3XGwfKLtj+gm/4hcLnNwFg==
X-Gm-Gg: ASbGncuqwbbuPE0GX2JBJuw0j+bMp9sy+I0/yNnv2cY3Eu78YbDDFBgKtBTJ27Codfa
 haZHu3zwj0S/SYmzsvT90XIN9UIWhkDxrdUrHvsdBmdGdJmcEMdZkuR6YfWoHSeb5+oO/I7tit9
 CsTwJND29ZOi7Yfn6oJN38+QhTH/2ESvHs1HOpxORROn/im/dFQyraDT+SgmVBXcLVMAJNODRn/
 7RqlYNh
X-Google-Smtp-Source: AGHT+IHy8howX/GnKeGHEEdHxQt3ATU9CXTq10L+0I7USOrKewNygLl9JqO3Pk96kaX2O64BOnwOzoo3AwEwhojw1BQ=
X-Received: by 2002:a05:6402:b49:b0:61c:3601:c07c with SMTP id
 4fb4d7f45d1cf-61c3601c2fdmr4379332a12.13.1756105519708; Mon, 25 Aug 2025
 00:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-3-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-3-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:04:53 +0300
X-Gm-Features: Ac12FXwLaIbAuMOPy1RJPPxrytcfTA0hDapGFw-zq00gQKAqO5VuRj6vgPsqccE
Message-ID: <CAAjaMXas2ZuZze_EDSEnARFfc4rB5LchdN=xD55dYfPs+aZdmg@mail.gmail.com>
Subject: Re: [PATCH 02/14] rust: move dependencies to rust/Cargo.toml
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

On Fri, Aug 22, 2025 at 3:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> As more crates start using the same dependencies, it's better to not
> repeat the versions and move the dependency declarations to the workspace=
.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.toml          | 5 +++++
>  rust/qemu-api/Cargo.toml | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
> index 682184cb158..99c275f2d9f 100644
> --- a/rust/Cargo.toml
> +++ b/rust/Cargo.toml
> @@ -15,6 +15,11 @@ license =3D "GPL-2.0-or-later"
>  repository =3D "https://gitlab.com/qemu-project/qemu/"
>  rust-version =3D "1.83.0"
>
> +[workspace.dependencies]
> +anyhow =3D "~1.0"
> +foreign =3D "~0.3.1"
> +libc =3D "0.2.162"
> +
>  [workspace.lints.rust]
>  unexpected_cfgs =3D { level =3D "deny", check-cfg =3D [
>      'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> index db7000dee44..c07a17a28b0 100644
> --- a/rust/qemu-api/Cargo.toml
> +++ b/rust/qemu-api/Cargo.toml
> @@ -15,9 +15,9 @@ rust-version.workspace =3D true
>
>  [dependencies]
>  qemu_api_macros =3D { path =3D "../qemu-api-macros" }
> -anyhow =3D "~1.0"
> -libc =3D "0.2.162"
> -foreign =3D "~0.3.1"
> +anyhow =3D { workspace =3D true }
> +foreign =3D { workspace =3D true }
> +libc =3D { workspace =3D true }
>
>  [features]
>  default =3D ["debug_cell"]
> --
> 2.50.1
>
>

