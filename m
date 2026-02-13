Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643FDEF99E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 23:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr2BW-0003t5-Io; Fri, 13 Feb 2026 18:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vr2BV-0003sx-59
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 18:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vr2BR-0003Ae-JL
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 18:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771023763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaN9tx/t6Howl++DEgqc/NZnXQKF6QnO8xAWyLsvs3M=;
 b=FZNe6DS0GQ+9XQG/Qkr0E+KI8a6sVPoVIEReOqjCXHaI+y81iOiDGWkhvFEzInOl4OpzUu
 Y8WRnGrAIsh9ISro9qXO52ELDUSMzzt6OHyKX8s2HwaLHTeCMXDGb8jmCBWCj/HF3X632K
 Hp2CH9o1JSkuxEwDkQ+Cwpv+dLKyJ+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Z6UF4WrRNISvGS3-IPl9Jw-1; Fri, 13 Feb 2026 18:02:41 -0500
X-MC-Unique: Z6UF4WrRNISvGS3-IPl9Jw-1
X-Mimecast-MFC-AGG-ID: Z6UF4WrRNISvGS3-IPl9Jw_1771023761
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-356236ae3c1so1265952a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 15:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771023760; cv=none;
 d=google.com; s=arc-20240605;
 b=Yi7EOa+eZ3Jsgja84OhJb+ki/lgMLbQx5Yn5sc9Tn4pXT+HVKrIiSgEk1fZd9Osz0I
 cEHjPvrQZIi9/LbBRxGhjGcOmSh0ax9IltbtSKn2SpkZsFGgktcN9fRy15PMjRis8oK9
 YyyLnQd4xWruYmn2ozzJCmgNa1gMwKkR2XEWCNZQONKVo7FQFZ97cPo1dJ+cK07OBdmk
 GwEl4xCWuLtbSknhUZxJ64AHhl0+Qpw8eupIM8iRHjYBTsk5AILQeUS4VQpNzRpp7diA
 WUky99/M02VPObUc2NnKhnDkaq2ORigwVsw6N3FK0FNYtOx3L7hibrbmK1MmMMm/dmks
 Pitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jaN9tx/t6Howl++DEgqc/NZnXQKF6QnO8xAWyLsvs3M=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=g8lRv1xnNgROYUx83PL31heVMtvV0sKYCrKmc7JFwq0esgf8Q62qUuUQHYSXnX1YM+
 o2Plb4jkwlufCKw3q2VHtmcn1FWgAESX8/yQL/YvkJFEyljVpyZe0fyuFgPzajnR7j7r
 K3ieYcRqthPcnNMGBd+2L4yYa7waYCW0OLUT8eGeItHQc7iEYyEwd9NLKIyj5RxfMg8X
 GWnr1FHInXVQhbeQwERegmPrQvDz6bXFkL5az4mx5KuBjbdYDQQn/r/e/ynmPqIZKabO
 0DTYFsDR6X2r2HwH694A76A3q/IjHZD45LFk4/656ZFto77KPONYzU2xBhye/RwVNZT8
 8EaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771023760; x=1771628560; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaN9tx/t6Howl++DEgqc/NZnXQKF6QnO8xAWyLsvs3M=;
 b=J6OnuVrvsfTCr1e3DOPaRlPomotyekAIZH3PQO64nqdEXO1Bh5PCV6fqw1DKJqdPL1
 bpbnEHhzT4/eYxjrpbE23sFs5Eg7XE2QdbMh9XkiBYSFmDowtf3Wo/DbshgixV+NRzf1
 pkV4L5mQ0ZgsCtaKpE/f4+1JkhW+pLLrnkDT7SQ3MJGjRb+NAKNEDHF9UTD1cDXcSgWE
 b75fQza+8ILHp8hzo43O94+9GLfrFZyWD/p090MyZXakHRDla/xh/Q41jwwc64HjoFUk
 Rv8aCmRt+qOG7L1Y4VdZrd/WZNkf9IC7tzFxkAw7kHjxxtRK/f9/hz9UtHej3Fhff4B2
 R8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023760; x=1771628560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaN9tx/t6Howl++DEgqc/NZnXQKF6QnO8xAWyLsvs3M=;
 b=YTr20JzhdOCfHB5v8KZSmtJVCiXJ5GMB1MiZAsXRrsd/OfYo5enEPMIKmUypi0BZTg
 V0hZjsWfdgkH4aGBlH/9eV6TTQ3bi6YqA6qukO2B5u4Mkw3hf5MbmyWzROp/qkq1G46s
 yTJDxNUc9uWJcV3fLyYE7jP5hiQW7bHJhuV+wD6jzT2CQZfdgYpw7Lq3azP//89PGXER
 LXqmGRNSRyBH+sKjbZ4z5zz/FO66fSos4bXo+fxO7efpxqjR/dRwVRwnRD1eqndYiEse
 gtZ7KWC/bES1JOQIJn5YvLsCVp49Yi2jehhgdKdqgu6oO8y5/LSckacIjUfP6KVa2vFY
 CCFg==
X-Gm-Message-State: AOJu0YzlGicSYEoBmRz9PPDoqMzjJvzOhKYkp9ecbiZVY8dN6/tKEUSN
 P0qUdaftQj3ceFQpKUtKrJjnSSP0i5TLWg4dS9qdHxIWpZOh5VEArdlKDbOBj+Y31pZNBV94WlB
 wsrFPcBoDuJH3LBqWk7onPvL786eICNt9mTdg4Uy/Zwj5759TL2XErDqg2UnXzZkS9sI48dl8JF
 Jh3SMxqV/yOvTsswmLr4KDcQ9pj3vDG5g=
X-Gm-Gg: AZuq6aLMbjvJoiwHo5XOfyKTgwqX90EbqQmCwfOzQ+Nd7kiTIsMg0dN5OI3srtc2Yjd
 78j2O5tWJ53hg54LjGQGCtMjP4ox3GqaJQROhY3HENCbIPyUcxYwEr7uKgge5u2Xi9AfClxUwiM
 38szbQc0i83AS8iyYT2AtZGV8DecbrEAeUvymLdrB+bU/V90AjmGofNq0SoLbivaYUQPIAfPSSd
 F0nnzd72SjPNRlo3tRSgKDFAJR4SiVMIck56g==
X-Received: by 2002:a17:90b:53cf:b0:354:7e46:4a8e with SMTP id
 98e67ed59e1d1-357b50e2d6dmr1194896a91.7.1771023760531; 
 Fri, 13 Feb 2026 15:02:40 -0800 (PST)
X-Received: by 2002:a17:90b:53cf:b0:354:7e46:4a8e with SMTP id
 98e67ed59e1d1-357b50e2d6dmr1194880a91.7.1771023760000; Fri, 13 Feb 2026
 15:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-10-marcandre.lureau@redhat.com>
 <1e10cb81-5168-4907-8bc5-4223f1494bc8@nutanix.com>
In-Reply-To: <1e10cb81-5168-4907-8bc5-4223f1494bc8@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 14 Feb 2026 03:02:28 +0400
X-Gm-Features: AZwV_QjLtvOW2zG7aIzb08CGCuzGsWGNjbUTBrEJNnRny1QOIYZbZoM2wFJWw1g
Message-ID: <CAMxuvawemXRX5xwvc3ES33VCaSzdK6XtaMO6KYO8-aOCTSLNtw@mail.gmail.com>
Subject: Re: [PATCH 09/43] audio/pw: convert to QOM lifecycle methods
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 13, 2026 at 11:17=E2=80=AFAM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Migrate the PipeWire audio backend from the legacy driver init/fini
> > callbacks to proper QOM realize and finalize methods.
> >
> > The pwaudio struct fields are now embedded directly in the AudioPw
> > QOM object instead of being allocated separately as drv_opaque. This
> > allows accessing the backend state through proper QOM type casting
> > with AUDIO_PW() rather than casting drv_opaque pointers.
> >
> > The PipeWire thread loop and context are now managed through the QOM
> > lifecycle, with initialization in realize and cleanup in finalize.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/pwaudio.c | 119 +++++++++++++++++++++++------------------------=
-
> >   1 file changed, 58 insertions(+), 61 deletions(-)
> >
> > diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> > index ed48a9754fe..ddf5f2c70f7 100644
> > --- a/audio/pwaudio.c
> > +++ b/audio/pwaudio.c
> > @@ -31,36 +31,27 @@
> >   #define TYPE_AUDIO_PW "audio-pipewire"
> >   OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
> >
> > +static AudioBackendClass *audio_pw_parent_class;
> > +
> >   struct AudioPw {
> >       AudioMixengBackend parent;
> > -};
> >
> > -static struct audio_driver pw_audio_driver;
> > +    struct pw_thread_loop *thread_loop;
> > +    struct pw_context *context;
> >
> > -static void audio_pw_class_init(ObjectClass *klass, const void *data)
> > -{
> > -    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> > +    struct pw_core *core;
> > +    struct spa_hook core_listener;
> > +    int last_seq, pending_seq, error;
> > +};
> >
> > -    k->driver =3D &pw_audio_driver;
> > -}
> > +static struct audio_driver pw_audio_driver;
> >
> >   typedef struct pwvolume {
> >       uint32_t channels;
> >       float values[SPA_AUDIO_MAX_CHANNELS];
> >   } pwvolume;
> >
> > -typedef struct pwaudio {
> > -    Audiodev *dev;
> > -    struct pw_thread_loop *thread_loop;
> > -    struct pw_context *context;
> > -
> > -    struct pw_core *core;
> > -    struct spa_hook core_listener;
> > -    int last_seq, pending_seq, error;
> > -} pwaudio;
> > -
> >   typedef struct PWVoice {
> > -    pwaudio *g;
> >       struct pw_stream *stream;
> >       struct spa_hook stream_listener;
> >       struct spa_audio_info_raw info;
> > @@ -236,9 +227,9 @@ static const struct pw_stream_events playback_strea=
m_events =3D {
> >   static size_t
> >   qpw_read(HWVoiceIn *hw, void *data, size_t len)
> >   {
> > +    AudioPw *c =3D AUDIO_PW(hw->s);
> >       PWVoiceIn *pw =3D (PWVoiceIn *) hw;
> >       PWVoice *v =3D &pw->v;
> > -    pwaudio *c =3D v->g;
> >       const char *error =3D NULL;
> >       size_t l;
> >       int32_t avail;
> > @@ -273,9 +264,9 @@ done_unlock:
> >
> >   static size_t qpw_buffer_get_free(HWVoiceOut *hw)
> >   {
> > +    AudioPw *c =3D AUDIO_PW(hw->s);
> >       PWVoiceOut *pw =3D (PWVoiceOut *)hw;
> >       PWVoice *v =3D &pw->v;
> > -    pwaudio *c =3D v->g;
> >       const char *error =3D NULL;
> >       int32_t filled, avail;
> >       uint32_t index;
> > @@ -298,9 +289,9 @@ done_unlock:
> >   static size_t
> >   qpw_write(HWVoiceOut *hw, void *data, size_t len)
> >   {
> > +    AudioPw *c =3D AUDIO_PW(hw->s);
> >       PWVoiceOut *pw =3D (PWVoiceOut *) hw;
> >       PWVoice *v =3D &pw->v;
> > -    pwaudio *c =3D v->g;
> >       const char *error =3D NULL;
> >       int32_t filled, avail;
> >       uint32_t index;
> > @@ -434,7 +425,7 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endian=
ness,
> >   }
> >
> >   static int
> > -qpw_stream_new(pwaudio *c, PWVoice *v, const char *stream_name,
> > +qpw_stream_new(AudioPw *c, PWVoice *v, const char *stream_name,
> >                  const char *name, enum spa_direction dir)
> >   {
> >       int res;
> > @@ -452,8 +443,8 @@ qpw_stream_new(pwaudio *c, PWVoice *v, const char *=
stream_name,
> >       }
> >
> >       /* 75% of the timer period for faster updates */
> > -    buf_samples =3D (uint64_t)v->g->dev->timer_period * v->info.rate
> > -                    * 3 / 4 / 1000000;
> > +    buf_samples =3D (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_peri=
od
> > +        * v->info.rate * 3 / 4 / 1000000;
> >       pw_properties_setf(props, PW_KEY_NODE_LATENCY, "%" PRIu64 "/%u",
> >                          buf_samples, v->info.rate);
> >
> > @@ -535,11 +526,11 @@ qpw_set_position(uint32_t channels, uint32_t posi=
tion[SPA_AUDIO_MAX_CHANNELS])
> >   static int
> >   qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque=
)
> >   {
> > +    AudioPw *c =3D AUDIO_PW(hw->s);
> >       PWVoiceOut *pw =3D (PWVoiceOut *) hw;
> >       PWVoice *v =3D &pw->v;
> >       struct audsettings obt_as =3D *as;
> > -    pwaudio *c =3D v->g =3D drv_opaque;
> > -    AudiodevPipewireOptions *popts =3D &c->dev->u.pipewire;
> > +    AudiodevPipewireOptions *popts =3D &AUDIO_MIXENG_BACKEND(c)->dev->=
u.pipewire;
> >       AudiodevPipewirePerDirectionOptions *ppdo =3D popts->out;
> >       int r;
> >
> > @@ -554,11 +545,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *=
as, void *drv_opaque)
> >           pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_si=
ze);
> >       v->frame_size *=3D as->nchannels;
> >
> > -    v->req =3D (uint64_t)c->dev->timer_period * v->info.rate
> > +    v->req =3D (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period * =
v->info.rate
> >           * 1 / 2 / 1000000 * v->frame_size;
> >
> >       /* call the function that creates a new stream for playback */
> > -    r =3D qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
> > +    r =3D qpw_stream_new(c, v, ppdo->stream_name ?: AUDIO_MIXENG_BACKE=
ND(c)->dev->id,
> >                          ppdo->name, SPA_DIRECTION_OUTPUT);
> >       if (r < 0) {
> >           pw_thread_loop_unlock(c->thread_loop);
> > @@ -582,11 +573,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *=
as, void *drv_opaque)
> >   static int
> >   qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> >   {
> > +    AudioPw *c =3D AUDIO_PW(hw->s);
> >       PWVoiceIn *pw =3D (PWVoiceIn *) hw;
> >       PWVoice *v =3D &pw->v;
> >       struct audsettings obt_as =3D *as;
> > -    pwaudio *c =3D v->g =3D drv_opaque;
> > -    AudiodevPipewireOptions *popts =3D &c->dev->u.pipewire;
> > +    AudiodevPipewireOptions *popts =3D &AUDIO_MIXENG_BACKEND(c)->dev->=
u.pipewire;
> >       AudiodevPipewirePerDirectionOptions *ppdo =3D popts->in;
> >       int r;
> >
> > @@ -602,7 +593,7 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, =
void *drv_opaque)
> >       v->frame_size *=3D as->nchannels;
> >
> >       /* call the function that creates a new stream for recording */
> > -    r =3D qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
> > +    r =3D qpw_stream_new(c, v, ppdo->stream_name ? : AUDIO_MIXENG_BACK=
END(c)->dev->id,
> >                          ppdo->name, SPA_DIRECTION_INPUT);
> >       if (r < 0) {
> >           pw_thread_loop_unlock(c->thread_loop);
> > @@ -621,10 +612,8 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as,=
 void *drv_opaque)
> >   }
> >
> >   static void
> > -qpw_voice_fini(PWVoice *v)
> > +qpw_voice_fini(AudioPw *c, PWVoice *v)
> >   {
> > -    pwaudio *c =3D v->g;
> > -
> >       if (!v->stream) {
> >           return;
> >       }
> > @@ -637,19 +626,18 @@ qpw_voice_fini(PWVoice *v)
> >   static void
> >   qpw_fini_out(HWVoiceOut *hw)
> >   {
> > -    qpw_voice_fini(&PW_VOICE_OUT(hw)->v);
> > +    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v);
> >   }
> >
> >   static void
> >   qpw_fini_in(HWVoiceIn *hw)
> >   {
> > -    qpw_voice_fini(&PW_VOICE_IN(hw)->v);
> > +    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v);
> >   }
> >
> >   static void
> > -qpw_voice_set_enabled(PWVoice *v, bool enable)
> > +qpw_voice_set_enabled(AudioPw *c, PWVoice *v, bool enable)
> >   {
> > -    pwaudio *c =3D v->g;
> >       pw_thread_loop_lock(c->thread_loop);
> >       pw_stream_set_active(v->stream, enable);
> >       pw_thread_loop_unlock(c->thread_loop);
> > @@ -658,19 +646,18 @@ qpw_voice_set_enabled(PWVoice *v, bool enable)
> >   static void
> >   qpw_enable_out(HWVoiceOut *hw, bool enable)
> >   {
> > -    qpw_voice_set_enabled(&PW_VOICE_OUT(hw)->v, enable);
> > +    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, enabl=
e);
> >   }
> >
> >   static void
> >   qpw_enable_in(HWVoiceIn *hw, bool enable)
> >   {
> > -    qpw_voice_set_enabled(&PW_VOICE_IN(hw)->v, enable);
> > +    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, enable=
);
> >   }
> >
> >   static void
> > -qpw_voice_set_volume(PWVoice *v, Volume *vol)
> > +qpw_voice_set_volume(AudioPw *c, PWVoice *v, Volume *vol)
> >   {
> > -    pwaudio *c =3D v->g;
> >       int i, ret;
> >
> >       pw_thread_loop_lock(c->thread_loop);
> > @@ -693,16 +680,16 @@ qpw_voice_set_volume(PWVoice *v, Volume *vol)
> >   static void
> >   qpw_volume_out(HWVoiceOut *hw, Volume *vol)
> >   {
> > -    qpw_voice_set_volume(&PW_VOICE_OUT(hw)->v, vol);
> > +    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, vol);
> >   }
> >
> >   static void
> >   qpw_volume_in(HWVoiceIn *hw, Volume *vol)
> >   {
> > -    qpw_voice_set_volume(&PW_VOICE_IN(hw)->v, vol);
> > +    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, vol);
> >   }
> >
> > -static int wait_resync(pwaudio *pw)
> > +static int wait_resync(AudioPw *pw)
> >   {
> >       int res;
> >       pw->pending_seq =3D pw_core_sync(pw->core, PW_ID_CORE, pw->pendin=
g_seq);
> > @@ -725,7 +712,7 @@ static int wait_resync(pwaudio *pw)
> >   static void
> >   on_core_error(void *data, uint32_t id, int seq, int res, const char *=
message)
> >   {
> > -    pwaudio *pw =3D data;
> > +    AudioPw *pw =3D data;
> >
> >       error_report("error id:%u seq:%d res:%d (%s): %s",
> >                   id, seq, res, spa_strerror(res), message);
> > @@ -737,7 +724,7 @@ on_core_error(void *data, uint32_t id, int seq, int=
 res, const char *message)
> >   static void
> >   on_core_done(void *data, uint32_t id, int seq)
> >   {
> > -    pwaudio *pw =3D data;
> > +    AudioPw *pw =3D data;
> >       assert(id =3D=3D PW_ID_CORE);
> >       pw->last_seq =3D seq;
> >       if (pw->pending_seq =3D=3D seq) {
> > @@ -752,17 +739,20 @@ static const struct pw_core_events core_events =
=3D {
> >       .error =3D on_core_error,
> >   };
> >
> > -static void *
> > -qpw_audio_init(Audiodev *dev, Error **errp)
> > +static bool
> > +audio_pw_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
> >   {
> > -    g_autofree pwaudio *pw =3D g_new0(pwaudio, 1);
> > +    AudioPw *pw =3D AUDIO_PW(abe);
> >
> >       assert(dev->driver =3D=3D AUDIODEV_DRIVER_PIPEWIRE);
> >       trace_pw_audio_init();
> >
> > +    if (!audio_pw_parent_class->realize(abe, dev, errp)) {
> > +        return false;
> > +    }
> > +
> >       pw_init(NULL, NULL);
> >
> > -    pw->dev =3D dev;
> >       pw->thread_loop =3D pw_thread_loop_new("PipeWire thread loop", NU=
LL);
> >       if (pw->thread_loop =3D=3D NULL) {
> >           error_setg_errno(errp, errno, "Could not create PipeWire loop=
");
> > @@ -801,8 +791,7 @@ qpw_audio_init(Audiodev *dev, Error **errp)
> >       }
> >
> >       pw_thread_loop_unlock(pw->thread_loop);
> > -
> > -    return g_steal_pointer(&pw);
> > +    return true;
>
> Unrelated to this patch directly, however when viewing the file at this
> commit I see the end of audio_pw_realize() looks like this:
>
>      if (wait_resync(pw) < 0) {
>          pw_thread_loop_unlock(pw->thread_loop);
>      }
>
>      pw_thread_loop_unlock(pw->thread_loop);
>      return true;
>
> If pw_thread_loop_unlock() is always called regardless, why do we need
> the wait_resync() logic? Is there a refcounted mutex involved?
>
> >   fail:
> >       if (pw->thread_loop) {
> > @@ -810,13 +799,13 @@ fail:
> >       }
> >       g_clear_pointer(&pw->context, pw_context_destroy);
> >       g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
> > -    return NULL;
> > +    return false;
> >   }
> >
> >   static void
> > -qpw_audio_fini(void *opaque)
> > +audio_pw_finalize(Object *obj)
> >   {
> > -    pwaudio *pw =3D opaque;
> > +    AudioPw *pw =3D AUDIO_PW(obj);
> >
> >       if (pw->thread_loop) {
> >           pw_thread_loop_stop(pw->thread_loop);
> > @@ -831,9 +820,7 @@ qpw_audio_fini(void *opaque)
> >       if (pw->context) {
> >           pw_context_destroy(pw->context);
> >       }
> > -    pw_thread_loop_destroy(pw->thread_loop);
> > -
> > -    g_free(pw);
> > +    g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
> >   }
>
> Is there any way that pw->thread_loop can be locked when _finalize() is
> invoked given that there is no explicit unlock here? Or is this done by
> one of the other functions?
>

All functions taking the lock are releasing it, afaict, and finalize
isn't called with lock taken.

> >   static struct audio_pcm_ops qpw_pcm_ops =3D {
> > @@ -855,8 +842,6 @@ static struct audio_pcm_ops qpw_pcm_ops =3D {
> >
> >   static struct audio_driver pw_audio_driver =3D {
> >       .name =3D "pipewire",
> > -    .init =3D qpw_audio_init,
> > -    .fini =3D qpw_audio_fini,
> >       .pcm_ops =3D &qpw_pcm_ops,
> >       .max_voices_out =3D INT_MAX,
> >       .max_voices_in =3D INT_MAX,
> > @@ -864,11 +849,23 @@ static struct audio_driver pw_audio_driver =3D {
> >       .voice_size_in =3D sizeof(PWVoiceIn),
> >   };
> >
> > +static void audio_pw_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> > +
> > +    audio_pw_parent_class =3D AUDIO_BACKEND_CLASS(object_class_get_par=
ent(klass));
> > +
> > +    b->realize =3D audio_pw_realize;
> > +    k->driver =3D &pw_audio_driver;
> > +}
> > +
> >   static const TypeInfo audio_pw_info =3D {
> >       .name =3D TYPE_AUDIO_PW,
> >       .parent =3D TYPE_AUDIO_MIXENG_BACKEND,
> >       .instance_size =3D sizeof(AudioPw),
> >       .class_init =3D audio_pw_class_init,
> > +    .instance_finalize =3D audio_pw_finalize,
> >   };
> >
> >   static void
>
> Regardless:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>

thanks


