Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733ACEFB817
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 08:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vunrb-0004pp-9m; Tue, 24 Feb 2026 03:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vunrX-0004pQ-JV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vunrV-000540-0L
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771922024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdFoPgIQKqnRgMfivwhu4uO+ZXYtI2SR4MwtJqMuTGU=;
 b=AkstSZSF5eiXG9n8XiruFaESnWuWUQGa3rPV67027CWV8V79FBUqaTHXwENSUNQ7NDPsYn
 SzfNgWrqwo0DQxDiD4hX0xIqBvd5iT11FaiGaBgUh5AbmIhMJXfwO1zJh2xmA9t9hKrJtP
 +mZdtQ2In+CpyXiPfrjpd7qOsut9JAM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-jm9o7RFeNoWSANw2484Cfg-1; Tue, 24 Feb 2026 03:33:42 -0500
X-MC-Unique: jm9o7RFeNoWSANw2484Cfg-1
X-Mimecast-MFC-AGG-ID: jm9o7RFeNoWSANw2484Cfg_1771922021
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435af2d3144so3048234f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 00:33:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771922021; cv=none;
 d=google.com; s=arc-20240605;
 b=bhh1hONjnao9sQ9sfzWgAw4zsUzKLNFOBbPxtmvTpaSWWzKxTD3m5Jz/ojO+/JzO6W
 nWgi3uOwQznRKpyQl3M3r1irdldY82xwQQnHPig93nK2lM6pR8qENc5af6CfdMH7aeFz
 fn+5i8YMl3u848J0pVbh/VOouQNyiwU6HBBBmiUnp1rdN+G3wf177I17sAR5d8v0nDO7
 GFdkXFTt87Bcv8IAwUE5UYqoMgyHHzLrkbLTbQPF4uQAoROZ7PGeBcryJYe9Z94TdDBT
 rsUbvhdc2llchjfQkvuwz5GPq5hrFE5xSLCfdwxfKYwMAFlEC9aYbXnHUTQizt5Yetjw
 TQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AdFoPgIQKqnRgMfivwhu4uO+ZXYtI2SR4MwtJqMuTGU=;
 fh=EbdhaRkUFk/a+E/+UKSWFKaXy3eMUSUnS7kutR18yu4=;
 b=PzV1bH0LIMgGxn3iLGLIeKSX3x1Xd0bS22UI3jb8pmu3GYaPIlnFbtUtZ3hhMk9N2c
 u8In6zJTrprr5jhKFNyslPN1uAiOn6ZJI+o/2Jg/IbIy0BjvOvy+OoSUdP7Iy3a0lcPs
 PksUlBkwk1fEuvuT2e6OxFzChGD7T0IKH1oq09UkO3R0rywaPGY7LkBwfO6US96nIelc
 425UEzjsNkW+3E0Zw+er9L/H/SlBOEWkBhJFwpGTbc2jhCBkUnrnoPOUnuyxmfxTNrco
 QNKbRKYpBagt96D/3VG4h2l0Eo4eKj8nudxDWZD+LjneSK2h11nYh+/JVjU5AGJxzzfk
 OsPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771922021; x=1772526821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AdFoPgIQKqnRgMfivwhu4uO+ZXYtI2SR4MwtJqMuTGU=;
 b=CTZUW8oQJUwAgL05H4V/Jp6ccC4DMK8UbC7JC4XoC0FfrtyDt+bb9+6id9bj3Q7F9x
 c8Sy7Kt4+dJ2ZDPmjSUdJkA3VnWm9bCh2L6JlmB+3N5/5eM0BvWC0EkfG5RIqCZqT6y7
 9KNEfyarfKyZJOnIGgNvyEuyXDvge39RoO8TqYrnghV3XUsznRaqhzuV44E/CoNUgwP5
 jejSgaDZtQsF9ebazEKt3EJaMLtYpKMlfv+tpkK3my3HqU9n4dFgrW4PqQUtRLljQ9hm
 WlNFKPCBuABJpVfEnQvaC1d9qPxcKkTA15FFpqk+clR3Lz+KffrxEDCoWRfJLx7sSsjE
 A6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771922021; x=1772526821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdFoPgIQKqnRgMfivwhu4uO+ZXYtI2SR4MwtJqMuTGU=;
 b=hFOmpQOqWQssUu5BVJUNNzCPs7WxOwxu48eB4v9rT6ksQFTaGcMEa1uCRsNUAEIBtz
 5c8g2CWTtZiO+lgms+Mv1JikKKF/nW0a5LAiYCZJPkn/yQLfyXBHkFIWUPLO2CByhWlj
 DolQnDJ6iYkhPHvVLWi2izBgA2Jnh0LG0mG5VT49Zx1bqHpSwF3eDumsvAA4AvCqHy4m
 MtUKiCNj5l0lYAMCQ/0UpmyPel1C7u0pCxhRYmFCakVQvikvU7mYdSGGVZ9uKQSUdut1
 wJyuKG6zZNMIVerCPHje2c7BICgMsNSUC9vnoeLOhbhsbrN7ydjOO2G298gGPCImlxnY
 oJFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV73vKLvkSx1k8dgGRK1a0kUpyXgbeUBgHLc0o1GUuVRkDJAIcvr11fu6J9fWPiioKSA4OdWHSwSDMW@nongnu.org
X-Gm-Message-State: AOJu0Yy03G8qt0vYtOAqDKcVQO3qS3eIzxYYX4Eu/JCSFFWUpRvfeWxL
 795ZzUSaH+sZKbeXvqYtZFAGpvqN+WYA/k4raR0dXNqLE90CuKUcx1crUdUucXAnopx3frjrLCl
 2lgHSlXX0/RcWpQjCyZDoiMICkzkX4mpV5MItW0HUMQP+V1SvPS72utQcxD4bK5TKDP+sMJEgam
 ARf4IyJM92qRyV+JCuVNpEtuFUEx7UQLA=
X-Gm-Gg: ATEYQzxLWZKaKPyMXJFmGuZ1sctab/8CDABQjGUOqvpn7hQH5x2fHntHNQbI5OJC3eD
 A2qPqEO0NlT9SIeQZyccMMH0UBeMOZAcQPN6RKzGfxND4ap7szmMlDcs4JwcMwyZYcDgIn9Jy99
 9F/kaoLS9AuT3V6RzWtU3M+ws/ywHINaw+kRVGG5+/LAzgVC2bt6fp4Fnz5iGwWSaYMKliee4eF
 PyRvob5X/pm4xOxCbIdxWRpFodAxR/cIdcznN6bGTBbDUcREgPZ9vdh1i50MZWX874/9GPXzzx9
 +tjmraQ=
X-Received: by 2002:a05:6000:402b:b0:435:975a:131c with SMTP id
 ffacd0b85a97d-4396f17e214mr19017597f8f.36.1771922020960; 
 Tue, 24 Feb 2026 00:33:40 -0800 (PST)
X-Received: by 2002:a05:6000:402b:b0:435:975a:131c with SMTP id
 ffacd0b85a97d-4396f17e214mr19017556f8f.36.1771922020465; Tue, 24 Feb 2026
 00:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-10-heifetz@yandex-team.com>
 <87o6le602l.fsf@pond.sub.org>
In-Reply-To: <87o6le602l.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Feb 2026 09:33:26 +0100
X-Gm-Features: AaiRm527EiB-baxA2erLdmvmk_lotkVAdwmRl7LRvD14L2gL6PVmrQ4cDDYYGL0
Message-ID: <CABgObfbB_Dr=u1M8meZ7-cdfuppSFAY9ktuuOZSq7cftNom5Cw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] audio: do not build audio-related sources with
 --disable-audio
To: Markus Armbruster <armbru@redhat.com>
Cc: Sergei Heifetz <heifetz@yandex-team.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: multipart/alternative; boundary="00000000000099a0cd064b8dbe72"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_PASS=-0.001,
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

--00000000000099a0cd064b8dbe72
Content-Type: text/plain; charset="UTF-8"

Il mar 24 feb 2026, 09:02 Markus Armbruster <armbru@redhat.com> ha scritto:

> Sergei Heifetz <heifetz@yandex-team.com> writes:
>
> > When QEMU is configured with `--disable-audio`, do not build any
> > audio-related sources.
> >
> > - audio/meson.build and replay/meson.build:
> >   Exclude audio-related sources when audio is disabled.
> >
> > - audio/audio-stub.c:
> >   Provide a minimal set of straightforward stubs.
> >
> > - replay/replay-audio-stub.c:
> >   Move the existing stubs from replay/stubs-system.c into a separate
> >   file.
> >
> > - qapi/audio.json:
> >   Remove the QMP `query-audiodevs` command.
> >
> > - hmp-commands*.hx:
> >   Remove the HMP `info capture`, `stopcapture` and `wavcapture`
> >   commands.
> >
> > Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>
> [...]
>
> diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
> index f1319c9002..f80f6c98d4 100644
> --- a/include/qemu/audio-capture.h
> +++ b/include/qemu/audio-capture.h
> @@ -8,6 +8,8 @@
>
>  #include "audio.h"
>
> +#ifdef CONFIG_AUDIO
> +
>  struct capture_ops {
>      void (*info) (void *opaque);
>      void (*destroy) (void *opaque);
> @@ -30,4 +32,6 @@ void audio_be_del_capture(
>      CaptureVoiceOut *cap,
>      void *cb_opaque);
>
> +#endif
> +
>  #endif /* QEMU_AUDIO_CAPTURE_H */
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index cff8a334f3..552689116c 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -32,6 +32,8 @@
>  #include "gio/gio.h"
>  #endif
>
> +#ifdef CONFIG_AUDIO
> +
>  typedef void (*audio_callback_fn) (void *opaque, int avail);
>
>  typedef struct audsettings {
> @@ -240,4 +242,7 @@ static inline bool audio_format_is_signed(AudioFormat
> fmt)
>  #define TYPE_AUDIO_BACKEND "audio-backend"
>  OBJECT_DECLARE_TYPE(AudioBackend, AudioBackendClass, AUDIO_BACKEND)
>
> +#else
> +#define audio_cleanup() ((void)0)
> +#endif
>  #endif /* QEMU_AUDIO_H */
> diff --git a/ui/vnc.h b/ui/vnc.h
> index ec8d0c91b5..89e0199be1 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -184,7 +184,9 @@ struct VncDisplay
>      VncDisplaySASL sasl;
>  #endif
>
> +#ifdef CONFIG_AUDIO
>      AudioBackend *audio_be;
> +#endif
>
>      VMChangeStateEntry *vmstate_handler_entry;
>  };
> @@ -325,8 +327,10 @@ struct VncState
>      pixman_format_code_t client_format;
>      int client_endian; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
>
> +#ifdef CONFIG_AUDIO
>      CaptureVoiceOut *audio_cap;
>      struct audsettings as;
> +#endif
>
>      VncReadEvent *read_handler;
>      size_t read_handler_expect;
> diff --git a/audio/audio-stub.c b/audio/audio-stub.c
> index f58f88cd83..e69de29bb2 100644
> --- a/audio/audio-stub.c
> +++ b/audio/audio-stub.c
> @@ -1,22 +0,0 @@
> -/*
> - * Stub for audio.c
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qapi/qapi-commands-audio.h"
> -#include "qemu/audio.h"
> -#include "qapi/error.h"
> -
> -void audio_cleanup(void) {}
> -
> -AudioBackend *audio_be_by_name(const char *name, Error **errp)
> -{
> -  error_setg(errp, "audio disabled");
> -  return NULL;
> -}
> -
> -void audio_init_audiodevs(void) {}
> -
> -void audio_create_default_audiodevs(void) {}
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d4ef620c17..12fbe0b0a6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -750,6 +750,7 @@ static char *machine_get_audiodev(Object *obj, Error
> **errp)
>  static void machine_set_audiodev(Object *obj, const char *value,
>                                   Error **errp)
>  {
> +#ifdef CONFIG_AUDIO
>      MachineState *ms = MACHINE(obj);
>
>      if (!audio_be_by_name(value, errp)) {
> @@ -758,6 +759,9 @@ static void machine_set_audiodev(Object *obj, const
> char *value,
>
>      g_free(ms->audiodev);
>      ms->audiodev = g_strdup(value);
> +#else
> +    error_setg(errp, "audio disabled");
> +#endif
>  }
>
>  HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState
> *machine)
> diff --git a/system/vl.c b/system/vl.c
> index 1034a4688f..6b2e7bc26e 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2067,10 +2067,12 @@ static void qemu_create_early_backends(void)
>       * setting machine properties, so they can be referred to.
>       */
>      configure_blockdev(&bdo_queue, machine_class, snapshot);
> +#ifdef CONFIG_AUDIO
>      audio_init_audiodevs();
>      if (default_audio) {
>          audio_create_default_audiodevs();
>      }
> +#endif
>  }
>
>
> diff --git a/ui/dbus.c b/ui/dbus.c
> index 60c8e0b473..2354e5d805 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -35,7 +35,9 @@
>  #include "ui/egl-context.h"
>  #endif
>  #include "qemu/audio.h"
> +#ifdef CONFIG_AUDIO
>  #include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of
> drv->name */
> +#endif
>  #include "qapi/error.h"
>  #include "trace.h"
>
>
>

--00000000000099a0cd064b8dbe72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 24 feb 2026, 09:02 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Sergei Heifetz &lt;<a href=3D"mailto:heifetz@yandex-team.com" target=3D"_bl=
ank" rel=3D"noreferrer">heifetz@yandex-team.com</a>&gt; writes:<br>
<br>
&gt; When QEMU is configured with `--disable-audio`, do not build any<br>
&gt; audio-related sources.<br>
&gt;<br>
&gt; - audio/meson.build and replay/meson.build:<br>
&gt;=C2=A0 =C2=A0Exclude audio-related sources when audio is disabled.<br>
&gt;<br>
&gt; - audio/audio-stub.c:<br>
&gt;=C2=A0 =C2=A0Provide a minimal set of straightforward stubs.<br>
&gt;<br>
&gt; - replay/replay-audio-stub.c:<br>
&gt;=C2=A0 =C2=A0Move the existing stubs from replay/stubs-system.c into a =
separate<br>
&gt;=C2=A0 =C2=A0file.<br>
&gt;<br>
&gt; - qapi/audio.json:<br>
&gt;=C2=A0 =C2=A0Remove the QMP `query-audiodevs` command.<br>
&gt;<br>
&gt; - hmp-commands*.hx:<br>
&gt;=C2=A0 =C2=A0Remove the HMP `info capture`, `stopcapture` and `wavcaptu=
re`<br>
&gt;=C2=A0 =C2=A0commands.<br>
&gt;<br>
&gt; Signed-off-by: Sergei Heifetz &lt;<a href=3D"mailto:heifetz@yandex-tea=
m.com" target=3D"_blank" rel=3D"noreferrer">heifetz@yandex-team.com</a>&gt;=
<br>
<br>
[...]<br>
<br></blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quote gm=
ail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h<br=
>
index f1319c9002..f80f6c98d4 100644<br>
--- a/include/qemu/audio-capture.h<br>
+++ b/include/qemu/audio-capture.h<br>
@@ -8,6 +8,8 @@<br>
<br>
=C2=A0#include &quot;audio.h&quot;<br>
<br>
+#ifdef CONFIG_AUDIO<br>
+<br>
=C2=A0struct capture_ops {<br>
=C2=A0 =C2=A0 =C2=A0void (*info) (void *opaque);<br>
=C2=A0 =C2=A0 =C2=A0void (*destroy) (void *opaque);<br>
@@ -30,4 +32,6 @@ void audio_be_del_capture(<br>
=C2=A0 =C2=A0 =C2=A0CaptureVoiceOut *cap,<br>
=C2=A0 =C2=A0 =C2=A0void *cb_opaque);<br>
<br>
+#endif<br>
+<br>
=C2=A0#endif /* QEMU_AUDIO_CAPTURE_H */<br>
diff --git a/include/qemu/audio.h b/include/qemu/audio.h<br>
index cff8a334f3..552689116c 100644<br>
--- a/include/qemu/audio.h<br>
+++ b/include/qemu/audio.h<br>
@@ -32,6 +32,8 @@<br>
=C2=A0#include &quot;gio/gio.h&quot;<br>
=C2=A0#endif<br>
<br>
+#ifdef CONFIG_AUDIO<br>
+<br>
=C2=A0typedef void (*audio_callback_fn) (void *opaque, int avail);<br>
<br>
=C2=A0typedef struct audsettings {<br>
@@ -240,4 +242,7 @@ static inline bool audio_format_is_signed(AudioFormat f=
mt)<br>
=C2=A0#define TYPE_AUDIO_BACKEND &quot;audio-backend&quot;<br>
=C2=A0OBJECT_DECLARE_TYPE(AudioBackend, AudioBackendClass, AUDIO_BACKEND)<b=
r>
<br>
+#else<br>
+#define audio_cleanup() ((void)0)<br>
+#endif<br>
=C2=A0#endif /* QEMU_AUDIO_H */<br>
diff --git a/ui/vnc.h b/ui/vnc.h<br>
index ec8d0c91b5..89e0199be1 100644<br>
--- a/ui/vnc.h<br>
+++ b/ui/vnc.h<br>
@@ -184,7 +184,9 @@ struct VncDisplay<br>
=C2=A0 =C2=A0 =C2=A0VncDisplaySASL sasl;<br>
=C2=A0#endif<br>
<br>
+#ifdef CONFIG_AUDIO<br>
=C2=A0 =C2=A0 =C2=A0AudioBackend *audio_be;<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0VMChangeStateEntry *vmstate_handler_entry;<br>
=C2=A0};<br>
@@ -325,8 +327,10 @@ struct VncState<br>
=C2=A0 =C2=A0 =C2=A0pixman_format_code_t client_format;<br>
=C2=A0 =C2=A0 =C2=A0int client_endian; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN *=
/<br>
<br>
+#ifdef CONFIG_AUDIO<br>
=C2=A0 =C2=A0 =C2=A0CaptureVoiceOut *audio_cap;<br>
=C2=A0 =C2=A0 =C2=A0struct audsettings as;<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0VncReadEvent *read_handler;<br>
=C2=A0 =C2=A0 =C2=A0size_t read_handler_expect;<br>
diff --git a/audio/audio-stub.c b/audio/audio-stub.c<br>
index f58f88cd83..e69de29bb2 100644<br>
--- a/audio/audio-stub.c<br>
+++ b/audio/audio-stub.c<br>
@@ -1,22 +0,0 @@<br>
-/*<br>
- * Stub for audio.c<br>
- *<br>
- * SPDX-License-Identifier: GPL-2.0-or-later<br>
- */<br>
-<br>
-#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qapi/qapi-commands-audio.h&quot;<br>
-#include &quot;qemu/audio.h&quot;<br>
-#include &quot;qapi/error.h&quot;<br>
-<br>
-void audio_cleanup(void) {}<br>
-<br>
-AudioBackend *audio_be_by_name(const char *name, Error **errp)<br>
-{<br>
-=C2=A0 error_setg(errp, &quot;audio disabled&quot;);<br>
-=C2=A0 return NULL;<br>
-}<br>
-<br>
-void audio_init_audiodevs(void) {}<br>
-<br>
-void audio_create_default_audiodevs(void) {}<br>
diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
index d4ef620c17..12fbe0b0a6 100644<br>
--- a/hw/core/machine.c<br>
+++ b/hw/core/machine.c<br>
@@ -750,6 +750,7 @@ static char *machine_get_audiodev(Object *obj, Error **=
errp)<br>
=C2=A0static void machine_set_audiodev(Object *obj, const char *value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
+#ifdef CONFIG_AUDIO<br>
=C2=A0 =C2=A0 =C2=A0MachineState *ms =3D MACHINE(obj);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!audio_be_by_name(value, errp)) {<br>
@@ -758,6 +759,9 @@ static void machine_set_audiodev(Object *obj, const cha=
r *value,<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(ms-&gt;audiodev);<br>
=C2=A0 =C2=A0 =C2=A0ms-&gt;audiodev =3D g_strdup(value);<br>
+#else<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;audio disabled&quot;);<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *ma=
chine)<br>
diff --git a/system/vl.c b/system/vl.c<br>
index 1034a4688f..6b2e7bc26e 100644<br>
--- a/system/vl.c<br>
+++ b/system/vl.c<br>
@@ -2067,10 +2067,12 @@ static void qemu_create_early_backends(void)<br>
=C2=A0 =C2=A0 =C2=A0 * setting machine properties, so they can be referred =
to.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0configure_blockdev(&amp;bdo_queue, machine_class, snaps=
hot);<br>
+#ifdef CONFIG_AUDIO<br>
=C2=A0 =C2=A0 =C2=A0audio_init_audiodevs();<br>
=C2=A0 =C2=A0 =C2=A0if (default_audio) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audio_create_default_audiodevs();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
=C2=A0}<br>
<br>
<br>
diff --git a/ui/dbus.c b/ui/dbus.c<br>
index 60c8e0b473..2354e5d805 100644<br>
--- a/ui/dbus.c<br>
+++ b/ui/dbus.c<br>
@@ -35,7 +35,9 @@<br>
=C2=A0#include &quot;ui/egl-context.h&quot;<br>
=C2=A0#endif<br>
=C2=A0#include &quot;qemu/audio.h&quot;<br>
+#ifdef CONFIG_AUDIO<br>
=C2=A0#include &quot;audio/audio_int.h&quot; /* FIXME: use QOM dynamic cast=
 instead of drv-&gt;name */<br>
+#endif<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000099a0cd064b8dbe72--


