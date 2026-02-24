Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48338E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqF0-0001nB-EY; Tue, 24 Feb 2026 06:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEm-0001ds-LZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:05:57 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEf-0006mb-Er
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:05:51 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-506a6cf8242so44476451cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931148; cv=none;
 d=google.com; s=arc-20240605;
 b=cMytfp4fv5weNCvjJvtzdj8X9enqiTCRAJLl71R83V4QQcCMnD2xdwn7PzLQcXkQyj
 r/PkxwCNlMN4+Uy/lAa297s6JLw4VCzA4U5u9fJJvOng5VfXK5OPc3Ts+cKABTkMT8Ch
 TXO1IeFsQfBldv+fcekCV6QXaPMZ/G41EU+BOVHLnZMPbXkGA2OlYD2fGP5d3SXLjuLP
 1z1z/Rolp9pEfiOFLPjrKd7nm3RDKRUt0E068lsrNX07QBqwGgOrRPFvuWnXKi/ku75u
 camCLER1TAEIW0yUY4Njoq+90i2BPk8cBSBt1Whsmojqs97SvXLntMtHj3UtZaIfd7sW
 8VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1EHsAvYpCS6f/WEySJiD1cD5dVAQMZVfAXyNDCrzFGA=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=hztzz6JKLFMmfHYrx9E6ZfeI8Q0KY62OYWHK4CLtqsKDP7bTb89hzj8ZlFMCoFmdwz
 xQSawbx+d+JQqofZ6CW6rc1tvhKnG9UY8o48P10BFGMsTTEtHgvAG03vVKv1cn7FYQJU
 hExpeeLxiHV12xi0USAyX+wQZviUhlrohXM8VPD78dFPPt2rXlze0mYJP0LlnF+4mxl4
 eSDLZNc29hMBtaV5aJinRsUnhS9OVNXiFgO/FjcOjjbt9o6lMrlHAsykTmGt6tCKq2gC
 TRkqKXuwOOzpPqoL95bMeFhR6hQnLyWFM2wpZYwMdmzrxcl7+xToiAG/tokQ+8M0OCVD
 kj+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931148; x=1772535948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EHsAvYpCS6f/WEySJiD1cD5dVAQMZVfAXyNDCrzFGA=;
 b=M1n8oaaJSWhCXFdEE2yMCezBjfzZnssaP/UbeXb6u0mB35J7WDBz/QRqlZtxHnlzQv
 KxiCfAa2jPAvmGoe/Fo7Aftev3HIoEIqh8CKmUJkzv1HEJMgNtzgfvFn+GT1Ado7TJzo
 kmQ1bURZd1uipp31JR+sFAasNhGswufM3ricgFBUCrWIPnRFo4Ps0iH7oh6zmQGd2IgD
 Vw9oKhA4Zq45FLwoeeM2/UJn7Xu4F8qfkSR4OXZimgQoV2EQp0yAbazMSWHik0PdF5Xp
 2azEVtdjSVIa6uymOKEgb7dpDkjCVJe70GPNwgb3idvgVI+YH00Rzm0pwXLEBz9S1q+2
 ToTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931148; x=1772535948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EHsAvYpCS6f/WEySJiD1cD5dVAQMZVfAXyNDCrzFGA=;
 b=ibdr9xFF84ngDisjpP5tzwvJeUb1+eNubPC8Bn2k7/mbwBg/ASfVK4HUnypRgrVx7t
 BJAHAHi39ukVszWPJLMVUctnl62bliqy/E1nhpHiG/EuCjM78iv4/1Y4O4Cd407Y+ysy
 4rAfg0OBjlWZAnoRYVfzSDNGETafIRaLPhF1a3j2OIMh+EgefT6Spsz1v/zpLM4URUjA
 BD+oeuM1WUrD/hXlRPs/mU/maATje99Dsve4GVdH+SVMDYGeRkdeW2OuqFB26/QE46tJ
 eKiDcm7x14W2eTJ7Kt3dg8n8326lHjYbD4uGK9NFCHn06o5HTUbH0W0h9Ssr748QQjoJ
 Tj5Q==
X-Gm-Message-State: AOJu0Yzf2cp66fcKq5g8Wy2yrUBOt/zwn5EFOPsSQuvIZBZE9fTXG6AC
 D3NWmjV4jfp4pzID74H/IAhIpJCAm5k5TgLr0u0djG39rQZLOE3mQPlKj+Hlnbm1+JQ4BLBdTar
 nYpncSGgxZbIzIHI4N6nx+0dr1z5k9hs=
X-Gm-Gg: AZuq6aJ2UmRNgJsS/IBvHOc6/9y1uOq7/NNJjNbgn2unDLqfmya7t17RaTqNlaV3zZB
 v4lMR3LgO7Wd7R7OSEq/eubh/7UXfMrFY2+2eDNeEL0xbTHCh2DkejuZDGF0JYif/qDT8xxyFs6
 6XnQDaxMhp8KmgVcm6YAL0xsBDKmve70ieve30xsqjvY1rl23vR0sKI+QVKnqZXt994DwEpvTfl
 iu0u1fTeyuU+xdNzU9uAV5YtRBGzjyaU6vIPDbpKl0tEDvF02Wj85HyB712rZnSpuUjTSddIcB2
 H7LA9c4=
X-Received: by 2002:a05:622a:1646:b0:506:9d3e:67ee with SMTP id
 d75a77b69052e-5070bced339mr154351691cf.71.1771931147596; Tue, 24 Feb 2026
 03:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-2-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-2-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:05:36 +0100
X-Gm-Features: AaiRm51cmw3U8PWn8F02qCNPKXPD8aDagwpyTAIkY0F0HLjObOVJqkYYyEjfBCg
Message-ID: <CAJ+F1CJZ8YqXKUcX_4k22W5xO4MvmyyH-bkVWCdcasEUMRs9TA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] audio: add `audio` build option for meson and
 Kconfig
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

Hi

On Mon, Feb 23, 2026 at 9:27=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> This patch adds the `audio` option to meson_options.txt. It is
> propagated into Kconfig as AUDIO. It is enabled by default.
> The corresponding `--disable-audio` and `--enable-audio` options
> for `configure` are also added.
>
> For now, this option does nothing. In subsequent patches, it will
> gradually disable audio in different places. The final goal is to stop
> building sources from `audio/` and `hw/audio/` and other audio-related
> files (except for some stubs). Note that this intent is different from
> `-audio none`, which mutes audio but still compiles the audio subsystem.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Kconfig.host                  | 3 +++
>  meson.build                   | 3 +++
>  meson_options.txt             | 3 +++
>  scripts/meson-buildoptions.sh | 3 +++
>  4 files changed, 12 insertions(+)
>
> diff --git a/Kconfig.host b/Kconfig.host
> index 933425c74b..ec129aa4fc 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -29,6 +29,9 @@ config IVSHMEM
>  config TPM
>      bool
>
> +config AUDIO
> +    bool
> +
>  config FDT
>      bool
>
> diff --git a/meson.build b/meson.build
> index 414c8ea7e2..fdb2578447 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -68,6 +68,8 @@ foreach target : target_dirs
>  endforeach
>  have_user =3D have_linux_user or have_bsd_user
>
> +have_audio =3D get_option('audio').disable_auto_if(not have_system).allo=
wed()
> +
>  ############
>  # Programs #
>  ############
> @@ -3250,6 +3252,7 @@ disassemblers =3D {
>  have_ivshmem =3D config_host_data.get('CONFIG_EVENTFD')
>  host_kconfig =3D \
>    (get_option('fuzzing') ? ['CONFIG_FUZZ=3Dy'] : []) + \
> +  (have_audio ? ['CONFIG_AUDIO=3Dy'] : []) + \
>    (have_tpm ? ['CONFIG_TPM=3Dy'] : []) + \
>    (pixman.found() ? ['CONFIG_PIXMAN=3Dy'] : []) + \
>    (spice.found() ? ['CONFIG_SPICE=3Dy'] : []) + \
> diff --git a/meson_options.txt b/meson_options.txt
> index 2836156257..d7c94e6d6d 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value : 'auto',
>  option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemal=
loc'],
>         value: 'system', description: 'choose memory allocator to use')
>
> +option('audio', type: 'feature', value: 'auto',
> +       description: 'Audio support')
> +
>  option('kvm', type: 'feature', value: 'auto',
>         description: 'KVM acceleration support')
>  option('mshv', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index e8edc5252a..642f06efc5 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -96,6 +96,7 @@ meson_options_help() {
>    printf "%s\n" '  af-xdp          AF_XDP network backend support'
>    printf "%s\n" '  alsa            ALSA sound support'
>    printf "%s\n" '  attr            attr/xattr support'
> +  printf "%s\n" '  audio           Audio support'
>    printf "%s\n" '  auth-pam        PAM access control'
>    printf "%s\n" '  blkio           libblkio block device driver'
>    printf "%s\n" '  bochs           bochs image format support'
> @@ -242,6 +243,8 @@ _meson_option_parse() {
>      --disable-asan) printf "%s" -Dasan=3Dfalse ;;
>      --enable-attr) printf "%s" -Dattr=3Denabled ;;
>      --disable-attr) printf "%s" -Dattr=3Ddisabled ;;
> +    --enable-audio) printf "%s" -Daudio=3Denabled ;;
> +    --disable-audio) printf "%s" -Daudio=3Ddisabled ;;
>      --audio-drv-list=3D*) quote_sh "-Daudio_drv_list=3D$2" ;;
>      --enable-auth-pam) printf "%s" -Dauth_pam=3Denabled ;;
>      --disable-auth-pam) printf "%s" -Dauth_pam=3Ddisabled ;;
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

