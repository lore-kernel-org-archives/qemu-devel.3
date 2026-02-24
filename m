Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE28E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqEr-0001fp-Bj; Tue, 24 Feb 2026 06:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEh-0001b2-8P
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:05:51 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEd-0006mH-An
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:05:49 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-897002b7576so71044166d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931143; cv=none;
 d=google.com; s=arc-20240605;
 b=A9D0isXXOWfwtVAIBnK666jfdYwW+eFXZ6LeQWzCyiJNxU20uf7eTHpghiQAFCluIE
 xrMSZsA3wwwF4aduzfAo8D4m/xbwhJtCLbFYpakJt+apQ/D3iKlQXj7W09IgTA2CzX2q
 RiqUhiCAO7j/b1IlkJvLDwxVucnZqWA8VzWKJk/euC880FWFPjwG4xZtbpW5+qn5n+lT
 C/2E4vM0vgAn0YsvU0hZN+D4RW0WNO57rmB63aQyOy5g0CgCRyk34y91Dd7eyZzt4/AX
 FdTVa9MrchIbEsmr+JMXPwGG7v1+yNkgmBHrXJdU80wVbgw6ZxRQvOk1Xm+rrkZVWw4e
 lLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P7VObRBrTIKmHY6Mq/ISv9kSvW4SBkC7ODol1rClFAg=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=GPJz3V3hYDQr6+3l0EiNOG6RwONJlxLTikR+hoZtazLD1VjKowePZyMvmY9oQVDAqM
 jmC6wJMW05jJK3PH1F0MjPJHVh1mSzgF/WUMuDYeg6coKYF1uczfonWdE0Nf68Q8GhXx
 i3TYA9EJwVxBR9uOb5M3gFRgbZRSWH3I7ei7l6R7NN0+81E145auqy7EP0xXHTPKp9OR
 PmlWVWJkDglsK5I0hTOWOP2QVu1mk79wOqL+7OxevsHrSJUHuiMFF3c+DQOV+y/6q2cr
 diZigH5vfi92d8W0eVj+bHrDszwzyFoOatskelg5NMG0QBJo2iNDAQs+trmSxpwkZWKB
 kAFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931143; x=1772535943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7VObRBrTIKmHY6Mq/ISv9kSvW4SBkC7ODol1rClFAg=;
 b=kbVZPLuW4mQ32gsj5qNyAgdFzfb4d9hrQLxrzaU65YZ3gcEWQqr3iCFWD8kvNjGTNd
 Q9BisHFPuCLCApeTaNkaE/9EZom5Bggcg98HbB3JQ/QxHv+4ri9/22wwUorZ16KZIIcx
 wrB0FzHG/0rgHuOzdTeFh/ykRpvbd/F134N6WCFmCUHT/Ah3POO2Vi2JBqxD7Q3AjdcA
 NAf9iwwASAq8PjQ1Y45aZrzWW5oc4qUfUL0YwLKOU8eCu2zhOdBYEF8zFU7ndJ8qf+Tn
 QS/UUSsmJ/stWv7ekH5uqmLAW08gX/MWxyj+wCK8K3bLdeefQaA09duZcin2ssesS1li
 iiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931143; x=1772535943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7VObRBrTIKmHY6Mq/ISv9kSvW4SBkC7ODol1rClFAg=;
 b=vAL1a+vVzWaMKVAZgPbt2s7kUKGTvpp9omFtprPgDkGvho9e/d3N67TY+YnIICjxnL
 u2jeAup4Z9GiARG5h/j2CYpui8hLkCWEHlwzGhFYmp4kyD2jHJXP1FAW5b9EImODqV9A
 T3Hjb/+ltT8WIxncny/5FHvT0ykDGh6/jIfmHa7ZnfnHLM3BmjbI+PoQK419nOLgHOd1
 b9VdOMVRVxr5uwHulZugJlGQBGNDzVR7+SaOvRKCD+CqQIOYy0AfckVoP1Lh0L9kqI78
 IcIdeAwcXyl3blgAyFgyL4Wfyph0+vf1Fiyn3WSb4b5HIVkbmrFeJe+yhJcBbxDjk6LM
 rpDw==
X-Gm-Message-State: AOJu0YzWaNnMwmwj7A4KjXT/eDbrtsuziSjpo9t92S1Z5noiozyLxEnZ
 5XCi1IlKbxf9KIdl92R8NNvMQLmicoy/qm6xLzCp0WD2tStO/gMNh38GFSZx7hMmNcvUQ20xRc2
 D0EmxI/wBhLcXbTIl56wbBCZzLR5QotM=
X-Gm-Gg: AZuq6aJgqx27S7rVpIbDk9fZHU1eiSpzFQ/6J1S9CEhvgb8l3ERW1yZZjGyUJ/MmJ6U
 5lHE6aCf3Pn7ORmLaRE6G5U/6FLKB1W843mSAnhBPlU+Vv/fD0C2iQm56oMFCN8P1tl8H8FhACH
 Gcn6Y33xLtFT5WujfQN/QXBcAaVApgA+VXqo4axbpcUMAMCrb/A75TY2yV/KtcMOZrdLdkTP4j1
 qZM9HiRn8tRjsXK8A1bZJMqNWeyp79q95SO35tW5y40EwErVymTkWA5g64heKvLsfAMaUINDcal
 oWgO8dw=
X-Received: by 2002:a05:622a:1987:b0:4f1:be34:aa09 with SMTP id
 d75a77b69052e-5070bbd9f55mr164062841cf.23.1771931142801; Tue, 24 Feb 2026
 03:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-11-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-11-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:05:30 +0100
X-Gm-Features: AaiRm52ZoqZwsjdqDnBiIaIEzNrYt2kbbaZLgdkCWtLP3G79oBIjvnLtl1uHpAc
Message-ID: <CAJ+F1CJ3tH3woNihc8-3bt8KEFmCqdP4d6WJ-=x7Mx70gaKNew@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] meson.build: ignore audio drivers when
 configured with --disable-audio
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2e.google.com
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

On Mon, Feb 23, 2026 at 9:27=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> When QEMU is configured with `--disable-audio`, we do not need to add the
> audio drivers list to config_host_data. We also do not need to print this
> list.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index fdb2578447..ae71a0dd91 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2272,46 +2272,55 @@ endif
>  config_host_data =3D configuration_data()
>
>  config_host_data.set('CONFIG_HAVE_RUST', have_rust)
> -audio_drivers_selected =3D []
> -if have_system
> -  audio_drivers_available =3D {
> -    'alsa': alsa.found(),
> -    'coreaudio': coreaudio.found(),
> -    'dsound': dsound.found(),
> -    'jack': jack.found(),
> -    'oss': oss.found(),
> -    'pa': pulse.found(),
> -    'pipewire': pipewire.found(),
> -    'sdl': sdl.found(),
> -    'sndio': sndio.found(),
> -  }
> -  foreach k, v: audio_drivers_available
> -    config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
> -  endforeach
> +config_host_data.set('CONFIG_AUDIO', have_audio)
> +if have_audio
> +  audio_drivers_selected =3D []
> +  if have_system
> +    audio_drivers_available =3D {
> +      'alsa': alsa.found(),
> +      'coreaudio': coreaudio.found(),
> +      'dsound': dsound.found(),
> +      'jack': jack.found(),
> +      'oss': oss.found(),
> +      'pa': pulse.found(),
> +      'pipewire': pipewire.found(),
> +      'sdl': sdl.found(),
> +      'sndio': sndio.found(),
> +    }
> +    foreach k, v: audio_drivers_available
> +      config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
> +    endforeach
>
> -  # Default to native drivers first, OSS second, SDL third
> -  audio_drivers_priority =3D \
> -    [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
> -    (host_os =3D=3D 'linux' ? [] : [ 'sdl' ])
> -  audio_drivers_default =3D []
> -  foreach k: audio_drivers_priority
> -    if audio_drivers_available[k]
> -      audio_drivers_default +=3D k
> -    endif
> -  endforeach
> +    # Default to native drivers first, OSS second, SDL third
> +    audio_drivers_priority =3D \
> +      [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
> +      (host_os =3D=3D 'linux' ? [] : [ 'sdl' ])
> +    audio_drivers_default =3D []
> +    foreach k: audio_drivers_priority
> +      if audio_drivers_available[k]
> +        audio_drivers_default +=3D k
> +      endif
> +    endforeach
>
> +    foreach k: get_option('audio_drv_list')
> +      if k =3D=3D 'default'
> +        audio_drivers_selected +=3D audio_drivers_default
> +      elif not audio_drivers_available[k]
> +        error('Audio driver "@0@" not available.'.format(k))
> +      else
> +        audio_drivers_selected +=3D k
> +      endif
> +    endforeach
> +  endif
> +  config_host_data.set('CONFIG_AUDIO_DRIVERS',
> +                      '"' + '", "'.join(audio_drivers_selected) + '", ')
> +else
>    foreach k: get_option('audio_drv_list')
> -    if k =3D=3D 'default'
> -      audio_drivers_selected +=3D audio_drivers_default
> -    elif not audio_drivers_available[k]
> -      error('Audio driver "@0@" not available.'.format(k))
> -    else
> -      audio_drivers_selected +=3D k
> +    if k !=3D 'default'
> +      error('Audio drivers are not supported because audio is disabled.'=
)
>      endif
>    endforeach
>  endif
> -config_host_data.set('CONFIG_AUDIO_DRIVERS',
> -                     '"' + '", "'.join(audio_drivers_selected) + '", ')
>
>  have_host_block_device =3D (host_os !=3D 'darwin' or
>      cc.has_header('IOKit/storage/IOMedia.h'))
> @@ -4684,7 +4693,8 @@ if enable_modules
>    summary_info +=3D {'alternative module path': get_option('module_upgra=
des')}
>  endif
>  summary_info +=3D {'fuzzing support':   get_option('fuzzing')}
> -if have_system
> +summary_info +=3D {'Audio support':     have_audio}
> +if have_audio
>    summary_info +=3D {'Audio drivers':     ' '.join(audio_drivers_selecte=
d)}
>  endif
>  summary_info +=3D {'Trace backends':    ','.join(get_option('trace_backe=
nds'))}
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

