Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3A4EDA693
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSFG-00016F-Mi; Tue, 03 Mar 2026 11:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxSF6-00012K-4j
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:05:05 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxSF4-0000ig-Il
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:05:03 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506c02ec1b3so67376551cf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772553901; cv=none;
 d=google.com; s=arc-20240605;
 b=TZHxpRVJcgtm/4gfsO1G1xbKhhOghFt7MIzE/PbRBT1Id2M/UFXbnYU7j+JCOOJfTP
 /aWwYrrIh+7GAbajQt3htIMkPlnSboaL+VQr0N+9FX65CNz6ehjl0euWhAKOk/0rYzdX
 ++v+ZWtqnMq+NlTw1uDfZgvxVMP03//F6FAea3uNyfVvOg4wiR7Q66QXs2EFYxbke5Zp
 jToZD4DtCTFPxHKXf2uv7bL4Y0byJ0njldZZm5JgdFqk4QPLQvszTx3ADEaHYWnyr9Kg
 T0FT20dJ+fjUCKvVJQauhRkfjkNaLiBr2XhV2I3Q9ov62hlileFrgSKnJrd0q0OVqZan
 5ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fNKNzcqGElYy7bF1GKlUajYK9DCHCDb6hEIBW4dTLP4=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=btRuPIiZwlxvJjOKlMxwQF0DppwCcurOMGrjwfRe9Xfmtc1tkQGKiH7NJgzIFAwFGT
 FbRrozt3r9SjS40eOJYhLjfsGZkgOTYkSuW0OGFeLut1SJKuhouFn4B2DQeeWwoHbSGU
 kNNYmx1Jfi+3+k0Nts5SE7JL/wcIbSFNLBLLGXiJU6+W9LpX+BfmKn8TlDm9Ln4LbfAy
 IclPfYV+dWSId1rt6uyHY87GSp+kPUzR9CXyhPO0jHgA7xWzmI858NoRxpgBt2yEBQvZ
 xGP69ezjj2J5BaCf8FeikA1X9G/iyW/flaiUTKq7fOdD+jB7HOW1e+3c2qQNui0afruR
 /nEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772553901; x=1773158701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNKNzcqGElYy7bF1GKlUajYK9DCHCDb6hEIBW4dTLP4=;
 b=O5NYiY2qhkmVjgMPe7kdGZkOgmB+2Nz2YZSHxzA/RrEQM9geGzYYIqjoJlEMi6BW4G
 2Sjt/Pvk9iq1St8CxtO16XPe+QhIZDnhf9Fr/YgH4KZzsMWGEw6XcfzDfzwEjx6opG3W
 7M4lb5CAX4ar4EDG4jcaoQSrMhlI4UPCi/cB4FSg1URfYF8fqQaC7oGd7qHviX2HM7pW
 YcS+FRZULt1XbDH1nhnzG/iQ7vuiWU1RWBZm2Po08QhHGWV00sJ21f29Z44kNTwagk1D
 WR+b+iDOpp8IFsKilNjniNLLsF4myzHEZzSSEWVL7oK58eobqcUqtem8gatKimI4p2wT
 n8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553901; x=1773158701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNKNzcqGElYy7bF1GKlUajYK9DCHCDb6hEIBW4dTLP4=;
 b=nrQVfQHTgcFiUS5ZWqs+DgNGq71tpLy3ulURzYfJYUG0gOU6lWXzUkXqoNGSgx8tR6
 RLhq1WG1wwhaCdhpdXxIYUk6fM7H4ycPfr4NeEZSUQWz7FSsR3huKK0nyjix0J8B2fpC
 SF4YbAH/GE2RFf0uAuMqn4O1iTB6Gk9ZrzpKVUMFhO6DmBxiGg+ZZ1ASs2mSGHjPulKD
 mHrS3MYPKaSzWNh2GnzOIIwEWvN8kqmgxtwIc+bRvbVASdw4kQqZ7Wpjn6ZVpU75H9yp
 PKI2Kmwv0b//fEw11bwonAel+cQVUY4A1//eMbKBG0NoOxY5h80W7tiaTQXfWdVS+C0m
 sysw==
X-Gm-Message-State: AOJu0Yz2dmrXtsNHe5Ds4rtKOL3g4nEnEsv3AtyhNcvBL9kcFrrS7egz
 LKzwfRMeN3VSw61aMvR2/f/Sqvr47iz8Isch11qxdYrBD005tD86LO3ACt6eviPpYruw819/5T3
 Yj/t2fyMBciUZZH8+DjK+58Wr2JEF8PfGy1Ziy7jiVLg8r34=
X-Gm-Gg: ATEYQzyiwKcHrgFK30EJBC0i7h1vc2EAsccrWcKn7i//JZ2YTnpSDpLgSIcLaIh33ek
 NtHF16rhzNFgk6nNy+8CE0t6qryVyMjmejwEjIftF4l0IfnMMhUcryeTIEc0h8KKvg++pt+1dpL
 SibygpJhzztQQZ+V5Ha32r+sLew6zI5997cacR5fXS1OBFnVSRvTqGk4S4AJ+f9S0svTfL7BN6u
 u+T7Cu7dLbaeYesNVhBV797U/5hWYRbqG/sktw+wqPoERiChGK2WC4W6GuGLw0shMZhvwVVwNdd
 GgXYoo9e6IgyB65JLsfigklpcCqs2D30Fcb2b96c
X-Received: by 2002:ac8:5e08:0:b0:501:3b85:272c with SMTP id
 d75a77b69052e-508ceb1e73dmr26832301cf.31.1772553901137; Tue, 03 Mar 2026
 08:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
 <20260303-gl-v1-1-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260303-gl-v1-1-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 17:04:49 +0100
X-Gm-Features: AaiRm52m5YX4itO1zN7sl3C0qva5cCRDboBZph0RhURncE3Lo610mS8JM2Jl9-o
Message-ID: <CAJ+F1C+8p=T5iczkdZwH_Th9KEYm1YnyP2sSdZ86jkGE2RxFng@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/console: Unify pixman-OpenGL format mapping
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Mar 3, 2026 at 2:11=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> console_gl_check_format() was supposed to check if the pixman format is
> supported by surface_gl_create_texture(), but it missed
> PIXMAN_BE_x8r8g8b8 and PIXMAN_BE_a8r8g8b8, which are properly mapped to
> OpenGL formats by surface_gl_create_texture().
>
> Fix the discrepancy of the two functions by sharing the code to map
> pixman formats to OpenGL ones.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It should be fine for dbus display as well.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/console-gl.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index 403fc36fbdf2..22e9787c4156 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -31,19 +31,38 @@
>
>  /* ---------------------------------------------------------------------=
- */
>
> -bool console_gl_check_format(DisplayChangeListener *dcl,
> -                             pixman_format_code_t format)
> +static bool map_format(pixman_format_code_t format,
> +                       GLenum *glformat, GLenum *gltype)
>  {
>      switch (format) {
>      case PIXMAN_BE_b8g8r8x8:
>      case PIXMAN_BE_b8g8r8a8:
> +        *glformat =3D GL_BGRA_EXT;
> +        *gltype =3D GL_UNSIGNED_BYTE;
> +        return true;
> +    case PIXMAN_BE_x8r8g8b8:
> +    case PIXMAN_BE_a8r8g8b8:
> +        *glformat =3D GL_RGBA;
> +        *gltype =3D GL_UNSIGNED_BYTE;
> +        return true;
>      case PIXMAN_r5g6b5:
> +        *glformat =3D GL_RGB;
> +        *gltype =3D GL_UNSIGNED_SHORT_5_6_5;
>          return true;
>      default:
>          return false;
>      }
>  }
>
> +bool console_gl_check_format(DisplayChangeListener *dcl,
> +                             pixman_format_code_t format)
> +{
> +    GLenum glformat;
> +    GLenum gltype;
> +
> +    return map_format(format, &glformat, &gltype);
> +}
> +
>  void surface_gl_create_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface)
>  {
> @@ -54,25 +73,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
>          return;
>      }
>
> -    switch (surface_format(surface)) {
> -    case PIXMAN_BE_b8g8r8x8:
> -    case PIXMAN_BE_b8g8r8a8:
> -        surface->glformat =3D GL_BGRA_EXT;
> -        surface->gltype =3D GL_UNSIGNED_BYTE;
> -        break;
> -    case PIXMAN_BE_x8r8g8b8:
> -    case PIXMAN_BE_a8r8g8b8:
> -        surface->glformat =3D GL_RGBA;
> -        surface->gltype =3D GL_UNSIGNED_BYTE;
> -        break;
> -    case PIXMAN_r5g6b5:
> -        surface->glformat =3D GL_RGB;
> -        surface->gltype =3D GL_UNSIGNED_SHORT_5_6_5;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> +    assert(map_format(surface_format(surface), &surface->glformat, &surf=
ace->gltype));
>      glGenTextures(1, &surface->texture);
>      glEnable(GL_TEXTURE_2D);
>      glBindTexture(GL_TEXTURE_2D, surface->texture);
>
> --
> 2.53.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

