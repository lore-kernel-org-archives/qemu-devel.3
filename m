Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9001FCCD18F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ZVC-0006U9-6m; Tue, 14 Oct 2025 03:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZV7-0006OR-1h
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:17 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8ZV4-0004uG-J7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:31:16 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-85a4ceb4c3dso620647585a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760427073; x=1761031873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFWHcPIUvx9EJHfwqZISxJIFez0dk0uvp+wt59f792M=;
 b=dqzxCHDSnfh6b8VzkZzyxUV+So+ec6KrqdtjaNVV80dVGH0436O526NOHrnY1ZoVIx
 pEe+0q4bqs/6dJsbj2cYsL87qAwx6DqIRN9OCSNcwhWFjP4r+wHEWpWNjB2b2lBImgX1
 T4vG9FVirtLp9cmAKNYNLv2A9uPh5t9LSnBK6BHR+RsrMC/atVG7VRXWKDoXBl0B1m06
 5ZKLgodFwH+/b0P3lxhBvVPgWWFNYc+JmAmG1g9rR+KtYp1EQ/DgeZZ2E4Pm76Nb61wg
 2MLJqBQNF+MjtGy3YYEHc3mw4GnYxbZ6qBRikbw5oVcaC0kkWKE4vri9MWnjJ1fgLNGu
 EkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427073; x=1761031873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFWHcPIUvx9EJHfwqZISxJIFez0dk0uvp+wt59f792M=;
 b=i6cv7Dg7lXiLcc00o1/7o7udIYNOTpML7M2cfg7m3TenJ4R7kyaD9eycTkJYPk2d/u
 d3yVhFjo7u9u9ODnMCaff25Yyi5HNz1/8UxTZ8qAsyyxAwRH/26lFsQIAuk+Vl4pys1C
 XNhODRjhDANvqPCPCe6QefoAG+XHbsflkzBE4SGBDjprOI/MvpQeUk/uG004tRt3Q33i
 3TwQnKs0NXPjyjZ3oD8rvjMMDrpGEB2Nmk+1H7sp34qIZCNlpW10xs92EgRg2TchWlv7
 secJiCexJVx6kxmMw2QcMsfl26UKHFuww4lBeoGe5e/c5jOA9kE9soWT+3JpVreBVf3f
 u10g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi5iVCwEm2kQbp8FFUj5QNR9EIIECY2bcaDeOOmg0/IE5xnxlCrwmVXYelrNB/HAAuJetnFLdm4xy9@nongnu.org
X-Gm-Message-State: AOJu0YxAIO991Ag1Vp8QXaecxEcMgUBewy+yCtWXTjzyqDyYORYDkcNz
 7nCyDpfPotb0AX+s9J2pyj7P4sNm5ZHMLzPTNuKYmEq8di3PaAmdkJiiFJdi6WQ60uc645EBfBl
 rpP8N63/9N8Lt37GIEPRmpw/42L1WLUk=
X-Gm-Gg: ASbGnctzX8QCbNnsPvJ6BwySF8HeJZXKtAaEuwGq0QR0iJW2bBiJn/lP6bFAYIEDBQA
 VPvY7WcNuVFmgbxqWfxH4tNxwntdnivHwvaa/dN2F6ADdTgTUMc0vJ4tgwbpi81IXuxSbQ8Z0DO
 5mgeKO9SLFSkCKxrtjsEowro1deep2wIMyqdiW3sKpg1KenMqLfiOqGzW+cbkUdh+eaxeNY+n4X
 pjLeoGtTBW6HjqFX9/Hhf5rfgy1QcozrOSIbpIT3SXse1LCbsB8rZPEAjcdrn/AjwHk
X-Google-Smtp-Source: AGHT+IGq2D3ySkEjyg+tR3qCDlwW+Hc1hTjFX9AsxFfpyccsu1Xc4Na0oTMNduO7/ye1fHPtTSepSZGyITsq1sT6H7A=
X-Received: by 2002:ac8:4a98:0:b0:4e6:ed89:c017 with SMTP id
 d75a77b69052e-4e6ed89cb1cmr216979761cf.70.1760427073196; Tue, 14 Oct 2025
 00:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-5-vsementsov@yandex-team.ru>
In-Reply-To: <20251013133836.852018-5-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 11:31:01 +0400
X-Gm-Features: AS18NWBf1YHd6ekzMX5MwIZ2K11L3MixVuxrN_JUWB_qOFRiqo7fsN7T3BbAcMA
Message-ID: <CAJ+F1CJ_7tzDfF6E1Fh2nZr5rELbxayY04w9HA3W=OjX8SuCxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] chardev/char: move filename and be_opened handling
 to qemu_char_open()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
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

On Mon, Oct 13, 2025 at 5:40=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Absent filename and necessity to send CHR_EVENT_OPENED are artifacts
> of .open(). Handle them in qemu_char_open().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 64ec60c0f2..6498d53daa 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -247,18 +247,27 @@ int qemu_chr_add_client(Chardev *s, int fd)
>  }
>
>  static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
> -                           bool *be_opened, Error **errp)
> +                           const char *default_filename, Error **errp)
>  {
>      ERRP_GUARD();
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +    bool be_opened =3D true;
>
>      if (cc->open) {
> -        cc->open(chr, backend, be_opened, errp);
> +        cc->open(chr, backend, &be_opened, errp);
>          if (*errp) {
>              return false;
>          }
>      }
>
> +    if (!chr->filename) {
> +        chr->filename =3D g_strdup(default_filename);
> +    }
> +
> +    if (be_opened) {
> +        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +    }
> +
>      return true;
>  }
>
> @@ -1021,7 +1030,6 @@ static Chardev *chardev_new(const char *id, const c=
har *typename,
>      Object *obj;
>      Chardev *chr =3D NULL;
>      Error *local_err =3D NULL;
> -    bool be_opened =3D true;
>
>      assert(g_str_has_prefix(typename, "chardev-"));
>      assert(id);
> @@ -1036,17 +1044,10 @@ static Chardev *chardev_new(const char *id, const=
 char *typename,
>          goto fail;
>      }
>
> -    if (!qemu_char_open(chr, backend, &be_opened, &local_err)) {
> +    if (!qemu_char_open(chr, backend, typename + 8, &local_err)) {
>          goto fail;
>      }
>
> -    if (!chr->filename) {
> -        chr->filename =3D g_strdup(typename + 8);
> -    }
> -    if (be_opened) {
> -        qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> -    }
> -
>      return chr;
>
>  fail:
> --
> 2.48.1
>
>


--
Marc-Andr=C3=A9 Lureau

