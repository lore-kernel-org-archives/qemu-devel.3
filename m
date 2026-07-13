Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4FCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjF4x-00037d-A8; Mon, 13 Jul 2026 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wjF4v-000370-PS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:44:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wjF4u-0003Ux-BI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:44:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso646340f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783943042; cv=none;
 d=google.com; s=arc-20260327;
 b=b7sIIz40Nwaqej/qM6FAr5lFYDAQ47VWVHR8brEogos5sEL24g95FXydjdNuWRf+KI
 ZDDgTKJXhFkpE/CAjWYtrY36rmjxdCmsMIjsVUEqoCnhAZxICGXKu+mdkfiRUYHUH0xD
 CR0Gst7cX6zvs2sys0MWHzlC25GyQAyPyOepH4C39+2DPA8d294+uftTzi+7dYhtGFQ4
 NDpxbmbv2dw+UiqXX0ezhLeRi58DNN/+aU6LwIAYV+w3n2nXxUJu/fXqY+IfSt3KDl52
 xC/NQKpzmKrJqS2lWGNB6GWpndsC8Ew9BNJzJhYF28h32nGWwJlqg+SSNVeU6qbjPnGM
 tZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LT9W4I7jLxPnX9fLtL+DaSfDgdiHLdTNHZNrepeHftU=;
 fh=GauA/jLFjWCuHvu1zU+hzihpiTaSiuhEybDxxqOTQGk=;
 b=Lyb/JvGY8O8VvkeJQ2mfocuak24WHoddt9ss+wa9q6vLn6mcZ6EjIaIQEznGko45Od
 AfA8bx84w+0TwTblMcbf5/s16pVl/lA61Iq1fnSWbT5I0JB0gPic73i5e/g2LBJeLs6R
 i4BodaSi+UbUKBJH/OGniHZf2SCKFXwmlfQv3h3sRFbEDTOtb51u8YXRpnoR1rPiDnGj
 n6b4N1WX3AAuZx29Hwv8p0yxU/X0CHBW6MDDc9/5N7o2gHKdnv3JQbCWYDqrX1kFjtt9
 W74j5/+dCFhu2slyJp8BV63mzkQHX2unbiiSCLxEe7iQXq2dQrVnaXNQdXG3G8G7hlVy
 ogNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783943042; x=1784547842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LT9W4I7jLxPnX9fLtL+DaSfDgdiHLdTNHZNrepeHftU=;
 b=Yb627mSkTccjshnG8kBNZe+a3ReynsAldJcEFhwdSDxOeVXd8jtiF4wbc3HLRNQgRP
 R5MW5T0q38ARdQdmMlT8bZhjfsF5z+3+AwHu6zk58fWMz85DMCiTGwn2kfjma2sVQLMo
 GRq6ah/sC2ymmYOj/eRPik/t0MgF2gmA/b027AaNkNgTwO51bCkKoPlSBqHolc4UvnB3
 CMk8dHWT4Z7Wc+E4o0eEkHRpoKSM3WzvxT6tvdgvcCqRs4p8Wse0fc6iRmX/RYxlvZNG
 OMU0ayvLX8wINF365vH6OMH4Wp6jTKMCPd/nl1vX3DizIoTHd6c077TVZloyYB13nmHI
 Mwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783943042; x=1784547842;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LT9W4I7jLxPnX9fLtL+DaSfDgdiHLdTNHZNrepeHftU=;
 b=Xfp+SDE+t0UULkIuZs8RbSoEaZqR0i6PllRZ+N8ssFFUJAF+qaNzbmRQeNkQLTdkAP
 BwUiivI5CGXjWpr4O4Fpf/uXqiEMe4MXTzED6vlPO1ZWF6/KiusgqpTQ9uopqTKK6lwu
 oQOa9RXF4sjSIYTsz/cb5yM1fh4882HWlRRafqPptFXnCA3sjOcAHZR+IYHN+vdmvoTo
 +QghAE7MNBETG/mXr3ph2P55+gFWfJnRCvgb2GZs3E+fpN01oj/I5/nGIAEEmaXx4uqg
 6fDYD6Y2HzigytCNQMFvQZabAohU4xBuGdLZLq87XB4zdplFywbywNkHu9AOJz3I9ptj
 ab1g==
X-Gm-Message-State: AOJu0YzLDya3QRV97KWhF9QB89PnWofLNqDWehu2ZIZEZBt/dcCml3PW
 yfDP3M0JyEkMFthVLHyK7IUOu2Ekhax3kx2dwRAaBb/yxQ3eQD15dWhWt+98BuLUyi0PMOMnTzw
 OvjIUsfYcLTPXNEylh19DMUBL6RHBFFYTsITImwWjVA==
X-Gm-Gg: AfdE7cneGUmLtpUdeKUolH2MAtqAq4BPelDFZKTTdqawS6azFY3aO0+suDhCYgFDa8a
 u0F4npMclykB5Zw+VVqsozhhewn6iEW97FN2AOy2cVbYKuwyhLkFuJPOhNw5VNChCf9SUPvfJBQ
 ODqTqzC2sK/vnwXfcZkpaGdUwPdVwZB6QgX61/0y7er8OOr6VKrYyqA5wJedzjyWzxSew1BXvkx
 bf29hUNRiypGlq/KAlaX5iGlg21m67ITodyCojLSAnres/M5KqGy+s7/SY+JbLZExo9C/3/CoTq
 exgYJEypQQrU6DRaxjqPb0xhOKRjaP8506v42BeDE2mAh4nrOAlZii+TZ2ofZqygjI4DZZiXuPr
 BdyygUMPXM9yrsApJG3or4OX3yoHvlYOPnaQWI8ntRXFl0dd3y7e6
X-Received: by 2002:a5d:5f90:0:b0:478:33fe:f987 with SMTP id
 ffacd0b85a97d-47f2dc95d57mr9205801f8f.23.1783943041701; Mon, 13 Jul 2026
 04:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260713084307.79593-1-alexander@mihalicyn.com>
 <20260713084307.79593-3-alexander@mihalicyn.com>
In-Reply-To: <20260713084307.79593-3-alexander@mihalicyn.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 13 Jul 2026 14:43:35 +0300
X-Gm-Features: AUfX_myKpXvOMmru-CDCYEYtnlD9euf_CpJWIg6rAEOcTVIoJTHC-0vDZcKp68s
Message-ID: <CAAjaMXZuMEmZ0S6+2LyWP6j_RFRDO7VyztfjjYPLMxg3vMw+ew@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/audio/virtio-sound: drop unused struct
 VirtIOSoundPCMStream.flushing field
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

On Mon, Jul 13, 2026 at 11:43=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> v4:
>         - this commit was split from
>           "hw/audio/virtio-sound: add stream state variable"
>           (suggested by Manos Pitsidianakis)
> ---
>  include/hw/audio/virtio-snd.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index f8bb5c95b97..b60b098ccd8 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -138,7 +138,6 @@ struct VirtIOSoundPCMStream {
>      virtio_snd_pcm_set_params params;
>      uint32_t id;
>      VirtIOSound *s;
> -    bool flushing;
>      audsettings as;
>      union {
>          SWVoiceIn *in;
> --
> 2.47.3
>

