Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD32E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqF1-0001pa-59; Tue, 24 Feb 2026 06:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEo-0001fr-GU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:00 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEl-0006mr-Nb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:05:57 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso51619131cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:05:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931152; cv=none;
 d=google.com; s=arc-20240605;
 b=Q7S6QEoKNmcuM0xP8bYnU1M+aU4/7E759WRCi1KqdTTFx5Yjy60B3JQjdDaVYvSN5r
 8TPpdaai7Mis7D/dr6FGg87LyBkX5v6xTScUrke3XDZM/R8C9HdPz2mEaDnTF4Ys+2mh
 +ebDKxlH4ZdgbyRrA83R/4qWTBNBHNKOVOyiWhsQ6WajG2NlYZ9MyB9WunOZCWPCjOTI
 CMMooEWAq5bukVgSH8cCEaGtlBIvSdnVeUdO/uG/+hYtuORKkk/ObcpIF8Ntm0IcWtF/
 UplY9ehlxfDJD+Sw9WWpi2tB7jy1wJtP/8r4S54m5TptBBKtMBH6vKKuIStv5zQ0tkYF
 qAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ES0TIvyAcB+yT0HHhYkWCZfDkFKqAHEICeCv8LxjLRE=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=Hbo7nk0gXQhGZFHzV0hbLsMmY9HfyGepMLj1qurEJ+Ihpz4zRcIPSjsXNXDSMIoRPS
 7iJ43BSxzyy6UYIRpqQwhaYIArz70JiiW/CAFAD06fsw4w8xCHpH/+z+mA9nFwHjDEeJ
 6El2ilwao+3zXDNTNQuunJlvHMZefTUZrSsd8fNScIAMZj4Rhu9KOnd9dNJII7KSQQN+
 ThGe4Kml6wE12gCL+rXKv+8yzzsyCWhNeCb+8nIJ8SAAxuf7qdxo3+jzPTQEdwzIIb84
 PBwCugAX5oKGjymAQoDSczGzieO8fFiuceBBKLl/6pY8vdkKOTGIMBOqwGJdBiR1FY5D
 i+Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931152; x=1772535952; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ES0TIvyAcB+yT0HHhYkWCZfDkFKqAHEICeCv8LxjLRE=;
 b=fi/D1tRe4kReZ2ZzQsAPJO6bjXAbS1P7OyWuE92ULA+tqGtWptz0tDD+1rlmi9Xlpr
 Tb6lLTRtZ5u0K3MJJmFrlZMJ5J2DvX/B5lJFnFOHONyFQkMUvwx6NYojYIEY++9+F43n
 iDpAKG4VknG4DnlZS3FxqVkJPXGP7rl4uhzmr63zFixyBBxKAnBM7gOWKoLVNeLyz5a1
 RCLXfFujLLJg5neKhFs5YEnvXhWCHVMK6EJE+Ry6W1TUg6Yn5W40gJxmwWeutcn2l4wh
 iL5Vj3nEJi62aqM8pnXz/pHXu2eDHC5tUsblKTy7JyWKf7vyRlmAtDMU1pJufNMcT2HZ
 Dypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931152; x=1772535952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ES0TIvyAcB+yT0HHhYkWCZfDkFKqAHEICeCv8LxjLRE=;
 b=RP38c2tf0LJ9LIU8hqWgJeGa7j4+ia0FF739JkL5M4NwInn5KIg1PsrKKt2f5XBV+j
 IhB5uXy/QYf/rwZpxT4wPAK0MSK0UEKcAE76k49LpfFPnWVqBMp/u2f5OdZDhRqJ76ON
 yyAuIRqINt7KOK7YsPs+janBAIbyNVRLNckvkbO5G5UrjjSiYXVR+mvWgyLlqpbPxJXk
 aC7yAb0mdzF3FyFQnFTkwCzSxsFKy8ucTKVCifYdgjqF5tGKg865f3hdfmpy39g9I6XP
 DeHdVV1UHn7ysJyHUk/al5J6Z5oIWsNoxZL7f4x/5xituTSUpb27dt2oRjAi/R9LBDCe
 r4/w==
X-Gm-Message-State: AOJu0YzwvMNHWdvgG5gWLZH588JRS17xMXebXxzXVKypRsQBPVbfHQDq
 vrjdyB4hJEZ0K5yeFI7hgZQ5vOfVIqz+8V1aDov6MP25haP7lav//9umle4c358/kJXaa11Ts6R
 RV9HO+tP11/qz7PYbVuuiamfh3aCLngE=
X-Gm-Gg: AZuq6aId+WMVuKDsQ+BNEXegWvP3G77ThHPXV8MMRcau6rd9rmsql4rK1lSyzc8lgsM
 eXZlvdZqB6vQTmrg0IfXg0NtVgqJ/Dce7smV/1WoVejaxsA35SWrBTp4NE2wNXiQTWcVy6Em8Qo
 KXO6xqY1iE6IHrRmSu2VI9hj9aWTKL+b2FWVPBT6QFKkqKfZjaMtzbzcU3UJ2S3Kc54LJSfg6Ec
 kA+vHnJnfhMhxMQmeZz+BHozJzzeM6KxKKKN+ouqLzcnY65OhEQwmmLl8RYxNOMzPVhkCyVx3rZ
 M9CdOxg=
X-Received: by 2002:ac8:5d16:0:b0:4f1:ddda:9a26 with SMTP id
 d75a77b69052e-5070bc4b4e3mr179953941cf.35.1771931152117; Tue, 24 Feb 2026
 03:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-3-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-3-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:05:41 +0100
X-Gm-Features: AaiRm50nx81G4PSHL6iIGG_YMqjk-NoVm3Pei4bUYqpexv7aD0S4byn9iM_7EvQ
Message-ID: <CAJ+F1CJGk_ejDAd066KE1Q_WHn3tjyw2d9xpcCJE1SZL2oA9sw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ui/vnc: disable audio feature when configured
 with --disable-audio
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Mon, Feb 23, 2026 at 9:26=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> Disable the audio feature in VNC when QEMU is configured with
> `--disable-audio`. Do not compile the corresponding audio-related
> code.

Users will have to call query-command-line-options to figure out if
audio support was disabled. Since this is an optional build option, I
don't know if we treat it as a breaking change.

>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>  ui/vnc.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index daf5b01d34..e6b6a9f4f9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1072,6 +1072,7 @@ static void vnc_update_throttle_offset(VncState *vs=
)
>      size_t offset =3D
>          vs->client_width * vs->client_height * vs->client_pf.bytes_per_p=
ixel;
>
> +#ifdef CONFIG_AUDIO
>      if (vs->audio_cap) {
>          int bps;
>          switch (vs->as.fmt) {
> @@ -1091,6 +1092,7 @@ static void vnc_update_throttle_offset(VncState *vs=
)
>          }
>          offset +=3D vs->as.freq * bps * vs->as.nchannels;
>      }
> +#endif
>
>      /* Put a floor of 1MB on offset, so that if we have a large pending
>       * buffer and the display is resized to a small size & back again
> @@ -1214,6 +1216,7 @@ static int vnc_update_client(VncState *vs, int has_=
dirty)
>      return n;
>  }
>
> +#ifdef CONFIG_AUDIO
>  /* audio */
>  static void audio_capture_notify(void *opaque, audcnotification_e cmd)
>  {
> @@ -1293,6 +1296,7 @@ static void audio_del(VncState *vs)
>          vs->audio_cap =3D NULL;
>      }
>  }
> +#endif
>
>  static void vnc_disconnect_start(VncState *vs)
>  {
> @@ -1332,7 +1336,9 @@ void vnc_disconnect_finish(VncState *vs)
>  #ifdef CONFIG_VNC_SASL
>      vnc_sasl_client_cleanup(vs);
>  #endif /* CONFIG_VNC_SASL */
> +#ifdef CONFIG_AUDIO
>      audio_del(vs);
> +#endif
>      qkbd_state_lift_all_keys(vs->vd->kbd);
>
>      if (vs->mouse_mode_notifier.notify !=3D NULL) {
> @@ -2097,6 +2103,7 @@ static void send_ext_key_event_ack(VncState *vs)
>      vnc_flush(vs);
>  }
>
> +#ifdef CONFIG_AUDIO
>  static void send_ext_audio_ack(VncState *vs)
>  {
>      vnc_lock_output(vs);
> @@ -2110,6 +2117,7 @@ static void send_ext_audio_ack(VncState *vs)
>      vnc_unlock_output(vs);
>      vnc_flush(vs);
>  }
> +#endif
>
>  static void send_xvp_message(VncState *vs, int code)
>  {
> @@ -2197,10 +2205,15 @@ static void set_encodings(VncState *vs, int32_t *=
encodings, size_t n_encodings)
>              send_ext_key_event_ack(vs);
>              break;
>          case VNC_ENCODING_AUDIO:
> +#ifdef CONFIG_AUDIO
>              if (vs->vd->audio_be) {
>                  vnc_set_feature(vs, VNC_FEATURE_AUDIO);
>                  send_ext_audio_ack(vs);
>              }
> +#else
> +            VNC_DEBUG("Audio encoding received with audio subsystem "
> +                      "disabled\n");
> +#endif
>              break;
>          case VNC_ENCODING_WMVi:
>              vnc_set_feature(vs, VNC_FEATURE_WMVI);
> @@ -2394,7 +2407,9 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
>  {
>      int i;
>      uint16_t limit;
> -    uint32_t freq;
> +    #ifdef CONFIG_AUDIO
> +        uint32_t freq;
> +    #endif

Indentation is off

>      VncDisplay *vd =3D vs->vd;
>
>      if (data[0] > 3) {
> @@ -2571,7 +2586,9 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
>                  vnc_client_error(vs);
>                  break;
>              }
> -
> +#ifndef CONFIG_AUDIO
> +            abort();

I'd keep the if AUDIO case first, for consistency


> +#else
>              if (len =3D=3D 2)
>                  return 4;
>
> @@ -2626,7 +2643,7 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
>                  break;
>              }
>              break;
> -
> +#endif
>          default:
>              VNC_DEBUG("Msg: %d\n", read_u16(data, 0));
>              vnc_client_error(vs);
> @@ -3369,10 +3386,12 @@ static void vnc_connect(VncDisplay *vd, QIOChanne=
lSocket *sioc,
>      vs->last_x =3D -1;
>      vs->last_y =3D -1;
>
> +#ifdef CONFIG_AUDIO
>      vs->as.freq =3D 44100;
>      vs->as.nchannels =3D 2;
>      vs->as.fmt =3D AUDIO_FORMAT_S16;
>      vs->as.big_endian =3D false;
> +#endif
>
>      qemu_mutex_init(&vs->output_mutex);
>      vs->bh =3D qemu_bh_new(vnc_jobs_bh, vs);
> @@ -3645,9 +3664,11 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "non-adaptive",
>              .type =3D QEMU_OPT_BOOL,
> +#ifdef CONFIG_AUDIO
>          },{
>              .name =3D "audiodev",
>              .type =3D QEMU_OPT_STRING,
> +#endif
>          },{
>              .name =3D "power-control",
>              .type =3D QEMU_OPT_BOOL,
> @@ -4080,7 +4101,9 @@ void vnc_display_open(const char *id, Error **errp)
>      const char *saslauthz;
>      int lock_key_sync =3D 1;
>      int key_delay_ms;
> +#ifdef CONFIG_AUDIO
>      const char *audiodev;
> +#endif
>      const char *passwordSecret;
>
>      if (!vd) {
> @@ -4238,6 +4261,7 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>      vd->ledstate =3D 0;
>
> +#ifdef CONFIG_AUDIO
>      audiodev =3D qemu_opt_get(opts, "audiodev");
>      if (audiodev) {
>          vd->audio_be =3D audio_be_by_name(audiodev, errp);
> @@ -4247,6 +4271,7 @@ void vnc_display_open(const char *id, Error **errp)
>      } else {
>          vd->audio_be =3D audio_get_default_audio_be(NULL);
>      }
> +#endif
>
>      device_id =3D qemu_opt_get(opts, "display");
>      if (device_id) {
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

