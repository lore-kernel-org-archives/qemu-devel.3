Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51242C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Mh1-0008Th-6I; Mon, 28 Apr 2025 07:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9Mgn-0008Jp-LS
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:30:25 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9Mgk-0006QO-Cl
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:30:20 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476ae781d21so55196081cf.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745839817; x=1746444617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIqPigYp3Pw5WS9rLb0ajmo+bKsFXEeZUnnNSzzC+rU=;
 b=a7hZzLfXVvhaRf4zy9KRGALePLFxtvRFIt/qas/Ay9zQNjvvv5/2YlZWvxO/HGBcNz
 q40zxCh3B0+PZXuPcApFTJS+W4N9FV1T8s4NQomk5Vno9VQRe20awF+Fde/DEOWf7+cD
 AEBHc291Zc+GmyH+BxONps98aCdJFx1SiSxYoLnORRi9fYdHVZjdfazmq0IVntjnwcfL
 ip8vwr17M1TPDP5DjJZ8b1T4YtEZ6xUAv3E5DOzj8rjBdeVjAIhoBecmMHGuKREUG52x
 YS9Zatb+7BnlmDWY+wFtICQKnElqKJxZkM71RNg7UBcZVkjik+Ti0DdfedAY7eDCwcUL
 smRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745839817; x=1746444617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIqPigYp3Pw5WS9rLb0ajmo+bKsFXEeZUnnNSzzC+rU=;
 b=tIuGitZZBSMzO1V4mVO3DhixEWKD/lEynraX4E9pzvcoFLBb2iy8UtElzPgPHYQU7g
 yXTNmtrnhGq5n7rFKQuCM10L/D85LIPItN2sZ0SrEKIMYnYojUHHrICP5Iwf6ixSz9sN
 qp5GLa0MeGlglboRZKhAqpyiKUlO0Bs3OhzFmyoakg0H+zg1zNAyAIxUwncXeYNit67d
 p6a8CGTvYtbOG4lBp4RTyitEpCS1mPdf9hhiSi4coEXdt7dUcrQPK1N45KOa8CHP6zVT
 8JB40W21JqH6u8CJ8vDVh8j0UumNvQbbgbsL7YqCBlRdLlJdZrVeZ0YBfqvGuudjgSkr
 icLg==
X-Gm-Message-State: AOJu0Yy7vqiWSDtqPO+a9hHRANPha1ld/OCzX8UNoAJSbi28KBu92fCe
 +5J83qfgYbOj8b8rNjq6iUxuPp7oU4/c04In9WsmDLfjn8O0vjz4xGvKlX3rSSVxDdVmpCrgel2
 mNfXSOo+CIRcApZ/Ytz0iuFLifB/kv+Jl31088g==
X-Gm-Gg: ASbGncsN9IduOSnWfyoJXcwabAsjKI2xW+KdEiCkwV1R5kOHueEJmM4YDsH6DKuUZTB
 +oL+EQ64y1Qjr00Hoivj1QZMLmmEQx1KjwCCnd0+ckIf05KEaCQiUpfsqUa58nqdkA4JNcZDhKS
 I24JvXis0yFSM61Kfv9ElR/rGmO1mH7h1twhQJ9/bRcF+CnMQ3rNgBL6Q=
X-Google-Smtp-Source: AGHT+IEHOIRpARlQxt5qq9//Z2k1IyJAvc52vp8DA8GnTNTzg2Kzh44Qaa4ugc18crX7leQ+EuSdgzqQlaYomfGW1Vg=
X-Received: by 2002:ac8:5755:0:b0:476:c656:4e80 with SMTP id
 d75a77b69052e-48132e8c0c0mr163238311cf.34.1745839816545; Mon, 28 Apr 2025
 04:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250428080336.2574852-1-dietmar@proxmox.com>
 <20250428080336.2574852-2-dietmar@proxmox.com>
In-Reply-To: <20250428080336.2574852-2-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Apr 2025 15:30:03 +0400
X-Gm-Features: ATxdqUFIzjA4BmFkNSl5P-Sw4LBx4IwC8gAOjMJlFPJnuLo8OgFqBdTCiFqAIxQ
Message-ID: <CAJ+F1C+7cb2-B_wY8UWDaE1oqHXFncUnMTzX3eMax5Oa2cR+rQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] new configure option to enable gstreamer
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Mon, Apr 28, 2025 at 12:07=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.co=
m> wrote:
>
> GStreamer is required to implement H264 encoding for VNC. Please note
> that QEMU already depends on this library when you enable Spice.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build                   | 10 ++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 15 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 41f68d3806..626d58d989 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1348,6 +1348,14 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +
> +gstreamer =3D not_found
> +if not get_option('gstreamer').auto() or have_system
> +  gstreamer =3D dependency('gstreamer-1.0 gstreamer-base-1.0', version: =
'>=3D1.22.0',
> +                          required: get_option('gstreamer'),
> +                          method: 'pkg-config')
> +endif
> +
>  qpl =3D not_found
>  if not get_option('qpl').auto() or have_system
>    qpl =3D dependency('qpl', version: '>=3D1.5.0',
> @@ -2563,6 +2571,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_mall=
oc_trim)
>  config_host_data.set('CONFIG_STATX', has_statx)
>  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_GSTREAMER', gstreamer.found())
>  config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_UADK', uadk.found())
>  config_host_data.set('CONFIG_QATZIP', qatzip.found())
> @@ -4836,6 +4845,7 @@ summary_info +=3D {'snappy support':    snappy}
>  summary_info +=3D {'bzip2 support':     libbzip2}
>  summary_info +=3D {'lzfse support':     liblzfse}
>  summary_info +=3D {'zstd support':      zstd}
> +summary_info +=3D {'gstreamer support': gstreamer}
>  summary_info +=3D {'Query Processing Library support': qpl}
>  summary_info +=3D {'UADK Library support': uadk}
>  summary_info +=3D {'qatzip support':    qatzip}
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..11cd132be5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -254,6 +254,8 @@ option('vnc_sasl', type : 'feature', value : 'auto',
>         description: 'SASL authentication for VNC server')
>  option('vte', type : 'feature', value : 'auto',
>         description: 'vte support for the gtk UI')
> +option('gstreamer', type : 'feature', value : 'auto',
> +       description: 'for VNC H.264 encoding with gstreamer')
>
>  # GTK Clipboard implementation is disabled by default, since it may caus=
e hangs
>  # of the guest VCPUs. See gitlab issue 1150:
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 3e8e00852b..f88475f707 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -229,6 +229,7 @@ meson_options_help() {
>    printf "%s\n" '                  Xen PCI passthrough support'
>    printf "%s\n" '  xkbcommon       xkbcommon support'
>    printf "%s\n" '  zstd            zstd compression support'
> +  printf "%s\n" '  gstreamer       gstreamer support (H264 for VNC)'
>  }
>  _meson_option_parse() {
>    case $1 in
> @@ -581,6 +582,8 @@ _meson_option_parse() {
>      --disable-xkbcommon) printf "%s" -Dxkbcommon=3Ddisabled ;;
>      --enable-zstd) printf "%s" -Dzstd=3Denabled ;;
>      --disable-zstd) printf "%s" -Dzstd=3Ddisabled ;;
> +    --enable-gstreamer) printf "%s" -Dgstreamer=3Denabled ;;
> +    --disable-gstreamer) printf "%s" -Dgstreamer=3Ddisabled ;;
>      *) return 1 ;;
>    esac
>  }
> --
> 2.39.5
>
>


--=20
Marc-Andr=C3=A9 Lureau

