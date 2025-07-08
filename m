Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A700C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEcz-0004EB-KN; Tue, 08 Jul 2025 16:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZDUZ-0002c1-P7
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:56:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZDUJ-0000t6-5u
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:56:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60cc11b34f6so349623a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752000952; x=1752605752; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99Xyeg6JNL+or4U/pcF1FCRiCmlJH+oIVR0AAzXf1+s=;
 b=D7KEK/RFDWWYVkIxAu1ahalBkkWQ6y/irp2L6C3+w+GS1Bd7/A+PNx3iBsGOquxwzs
 E+eYSEY5nrs9tqYQHabCmMEMv7FHWBGWm6Sm0lyElJ1g0UiDdn24ultk7V3qH59XyEfa
 27rSkD9joWhyAnfAB6VNdeVWL5VW0GQy6D/YWKI+IN1xKOL8K2dqAo/l4f1xB3eJIVQq
 mQiKum1pqGCZe+v7hJgEf/+q8kuX02j6RpxSzybhtmfmy//wjn7yH3oXGKVP0gPAxtX5
 NMZeajAeiO20H9Wb0yQZzK63nCGdZuH0FDW1JN6HM56bW5jssUe/db2pUmEwPLH08lS4
 GC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752000952; x=1752605752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99Xyeg6JNL+or4U/pcF1FCRiCmlJH+oIVR0AAzXf1+s=;
 b=GEEupQijjoHBxbWVIc0BUacAjf7mOtOBm51nSBL8jR78BLPpuRlf38wyywwRnpPmFU
 AULz5F/mAoF8jOBOf9Ad8sae1PsWCCM3gLmSaBZgdfd4vbCG2YbueBtR/U0LDl2wb7Dc
 oaAt6vr68MS8HAB2DPUZKEspWdR9tgsDCC+I4QZSXwnK4iKqdq8WIS2uqzeAzlo6MggN
 LigLLHfTnyuSkOTsn1k4dPLWB32kel82NUZfNXQEgI6rrDtsnRT/G3euPFGOLJg38vX1
 GmtedRWhlOBM+nXd3I/S/aNAW2xeP236WsVOFD0g/EUqNXnCnCo6Q8suKmnqpyCkn4Nu
 mwzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNhtWlNZkRb9uT1RrOOCUicJwDAkXUDlN4jpX98pW2P8FQN5EZOOFKmEFwyqELoBuHi7+p784yXsEC@nongnu.org
X-Gm-Message-State: AOJu0YwCGbJjVjymGwWjo6NLIW6QU66+Bac+xL4Yys4VuXT8xoAZ9ahj
 JQpGtlCRWOPss+CDvlK7wPeL/mkJkyXM3iMC0NvRWNzeE+hRtpYKoFOIfNr8lIzDlUakHg/Kb9k
 HwChMLmuXYi/SoOZLlKfCXrHfQwl6udHlSbEi9lIuEKpDJBRCFfetT5fAQA==
X-Gm-Gg: ASbGncuNwPIBj/nxTyvpY4zigAW9VKeihUVH4MJxRQgmKfOYjL/6Dp1cn+9E0E94Yzv
 G7tmJWPdDOU99yc0Gmi9JSmMnsGy8iOjgsJ4q///ArJ5Ko6fAVIceHVPzeplM/JjyrJPBRaSZSE
 HP1OxVPSFF42Tj84rUqX+YOJENgd5BCqk6EtgiBotZ3b8=
X-Google-Smtp-Source: AGHT+IGnC1Mre2C9WvuCTFnCcCWuD0IWhOn9KEfPwi644XZpLA0BXpcHc66kweYKbZ/6q2SzPDlO9HVpzFDms+cbGJU=
X-Received: by 2002:a05:6402:35c2:b0:60c:679e:b957 with SMTP id
 4fb4d7f45d1cf-6104bf17842mr1719815a12.1.1751958756514; Tue, 08 Jul 2025
 00:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
 <20250707193009.12901-3-vr_qemu@t-online.de>
In-Reply-To: <20250707193009.12901-3-vr_qemu@t-online.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 8 Jul 2025 10:12:10 +0300
X-Gm-Features: Ac12FXzw4xjhllE8XAOfgqFBcQ6tSZzEt_DanNvRYIKs6O1JuetfC0WvG4qwFcg
Message-ID: <CAAjaMXYBwWgpoeMasQ5gkSFpN+ZS-wsS0N9+QOiNUUPOTVKxyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/audio/sb16: block structure coding style fixes
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 7, 2025 at 10:31=E2=80=AFPM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Change the block structure according to the QEMU Coding Style
> documentation.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/sb16.c | 57 +++++++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 37 deletions(-)
>
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 714144eb61..e23d86674e 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -204,8 +204,7 @@ static void control (SB16State *s, int hold)
>              hold_DREQ(s, nchan);
>          }
>          AUD_set_active_out (s->voice, 1);
> -    }
> -    else {
> +    } else {
>          release_DREQ(s, nchan);
>          AUD_set_active_out (s->voice, 0);
>      }
> @@ -271,10 +270,10 @@ static void dma_cmd8 (SB16State *s, int mask, int d=
ma_len)
>      s->fmt_signed =3D 0;
>      s->fmt_stereo =3D (s->mixer_regs[0x0e] & 2) !=3D 0;
>      if (-1 =3D=3D s->time_const) {
> -        if (s->freq <=3D 0)
> +        if (s->freq <=3D 0) {
>              s->freq =3D 11025;
> -    }
> -    else {
> +        }
> +    } else {
>          int tmp =3D (256 - s->time_const);
>          s->freq =3D (1000000 + (tmp / 2)) / tmp;
>      }
> @@ -282,8 +281,7 @@ static void dma_cmd8 (SB16State *s, int mask, int dma=
_len)
>
>      if (dma_len !=3D -1) {
>          s->block_size =3D dma_len << s->fmt_stereo;
> -    }
> -    else {
> +    } else {
>          /* This is apparently the only way to make both Act1/PL
>             and SecondReality/FC work
>
> @@ -362,16 +360,13 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uin=
t8_t d0, int dma_len)
>      if (16 =3D=3D s->fmt_bits) {
>          if (s->fmt_signed) {
>              s->fmt =3D AUDIO_FORMAT_S16;
> -        }
> -        else {
> +        } else {
>              s->fmt =3D AUDIO_FORMAT_U16;
>          }
> -    }
> -    else {
> +    } else {
>          if (s->fmt_signed) {
>              s->fmt =3D AUDIO_FORMAT_S8;
> -        }
> -        else {
> +        } else {
>              s->fmt =3D AUDIO_FORMAT_U8;
>          }
>      }
> @@ -422,8 +417,7 @@ static inline uint8_t dsp_get_data (SB16State *s)
>  {
>      if (s->in_index) {
>          return s->in2_data[--s->in_index];
> -    }
> -    else {
> +    } else {
>          dolog ("buffer underflow\n");
>          return 0;
>      }
> @@ -447,8 +441,7 @@ static void command (SB16State *s, uint8_t cmd)
>              qemu_log_mask(LOG_GUEST_ERROR, "%#x wrong bits\n", cmd);
>          }
>          s->needed_bytes =3D 3;
> -    }
> -    else {
> +    } else {
>          s->needed_bytes =3D 0;
>
>          switch (cmd) {
> @@ -674,8 +667,7 @@ static void command (SB16State *s, uint8_t cmd)
>   exit:
>      if (!s->needed_bytes) {
>          s->cmd =3D -1;
> -    }
> -    else {
> +    } else {
>          s->cmd =3D cmd;
>      }
>      return;
> @@ -715,14 +707,12 @@ static void complete (SB16State *s)
>          if (s->cmd & 8) {
>              dolog ("ADC params cmd =3D %#x d0 =3D %d, d1 =3D %d, d2 =3D =
%d\n",
>                     s->cmd, d0, d1, d2);
> -        }
> -        else {
> +        } else {
>              ldebug ("cmd =3D %#x d0 =3D %d, d1 =3D %d, d2 =3D %d\n",
>                      s->cmd, d0, d1, d2);
>              dma_cmd (s, s->cmd, d0, d1 + (d2 << 8));
>          }
> -    }
> -    else {
> +    } else {
>          switch (s->cmd) {
>          case 0x04:
>              s->csp_mode =3D dsp_get_data (s);
> @@ -747,8 +737,7 @@ static void complete (SB16State *s)
>                  ldebug ("0x83[%d] <- %#x\n", s->csp_reg83r, d0);
>                  s->csp_reg83[s->csp_reg83r % 4] =3D d0;
>                  s->csp_reg83r +=3D 1;
> -            }
> -            else {
> +            } else {
>                  s->csp_regs[d1] =3D d0;
>              }
>              break;
> @@ -763,8 +752,7 @@ static void complete (SB16State *s)
>                          s->csp_reg83[s->csp_reg83w % 4]);
>                  dsp_out_data (s, s->csp_reg83[s->csp_reg83w % 4]);
>                  s->csp_reg83w +=3D 1;
> -            }
> -            else {
> +            } else {
>                  dsp_out_data (s, s->csp_regs[d0]);
>              }
>              break;
> @@ -819,8 +807,7 @@ static void complete (SB16State *s)
>                  ticks =3D muldiv64(bytes, NANOSECONDS_PER_SECOND, freq);
>                  if (ticks < NANOSECONDS_PER_SECOND / 1024) {
>                      qemu_irq_raise (s->pic);
> -                }
> -                else {
> +                } else {
>                      if (s->aux_ts) {
>                          timer_mod (
>                              s->aux_ts,
> @@ -992,12 +979,10 @@ static void dsp_write(void *opaque, uint32_t nport,=
 uint32_t val)
>                  log_dsp (s);
>              }
>  #endif
> -        }
> -        else {
> +        } else {
>              if (s->in_index =3D=3D sizeof (s->in2_data)) {
>                  dolog ("in data overrun\n");
> -            }
> -            else {
> +            } else {
>                  s->in2_data[s->in_index++] =3D val;
>                  if (s->in_index =3D=3D s->needed_bytes) {
>                      s->needed_bytes =3D 0;
> @@ -1032,8 +1017,7 @@ static uint32_t dsp_read(void *opaque, uint32_t npo=
rt)
>          if (s->out_data_len) {
>              retval =3D s->out_data[--s->out_data_len];
>              s->last_read_byte =3D retval;
> -        }
> -        else {
> +        } else {
>              if (s->cmd !=3D -1) {
>                  dolog ("empty output buffer for command %#x\n",
>                         s->cmd);
> @@ -1255,8 +1239,7 @@ static int SB_read_DMA (void *opaque, int nchan, in=
t dma_pos, int dma_len)
>              release_DREQ(s, nchan);
>              return dma_pos;
>          }
> -    }
> -    else {
> +    } else {
>          free =3D dma_len;
>      }
>
> --
> 2.43.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

