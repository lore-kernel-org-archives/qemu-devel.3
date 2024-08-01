Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602E2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZR57-0001Kr-TH; Thu, 01 Aug 2024 04:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZR53-0001Jc-RR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZR51-0005Qa-WB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 04:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722500553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iYQ06zUbmI25q9SiHsxsTHQyZIlu8Vxo7Ewz7QsAZ0=;
 b=dtos2oCw58otPhfeb2o2uiFA3uesM1re43MHXu7tNywG36N9x7Anu41EdU3e5YFvJ6jxBL
 Q0zxb7terX+vaMrwTJO3cswWImXwBSbMbYKz3dXsrCF3K+SA5cFXSyGlYegPqz1/9mHVA5
 gJ3Vw80TS/1OTTBcRbq7hHYQkp35oFU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-6A7guLliOii16-cnXIzC3w-1; Thu, 01 Aug 2024 04:22:32 -0400
X-MC-Unique: 6A7guLliOii16-cnXIzC3w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7a83f54fdeso582664966b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 01:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722500551; x=1723105351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1iYQ06zUbmI25q9SiHsxsTHQyZIlu8Vxo7Ewz7QsAZ0=;
 b=uC9dbDW+XYNX6RF4ty6w8ME9+DiRbIV7cdXeIluHSD4OBpY/6gzM+1tTYLlNVWVTv6
 hUejtCEEeRiZj65R5gHGj1uzRzzE8kssWlpkNuP0g2OGRl9+zy3JbKIfU6tND00Uv/pK
 wJRnkfmcG0OzlCiUREqahkcgGG2UfBFxPPfBU7PWkbuDEpMdVcss0Xe95s8G3wUMWypP
 ndsl3JOjShzVmHd+ojnbDhLDBt3WjE7I0HVHyFa2SoADJjXuF++JJnrDyJen24knL8EC
 CWLrIdikIvmFdG3hNWZo8a/MAu9mSaMC8mACTXkSm1nHeVIlFyyJCBzSWLU5oaGTaGgY
 Tb3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGuftpw1QXYrWL30f6Ja05uxx1Ry5DSi4qeP66sZ0ELqhCI/F97ti+tPfV0ze8TZfWBnoEerYPp74wK6sGDxFXgKcDK/4=
X-Gm-Message-State: AOJu0YzfnnLnBNBabAtyE/LRLMrhC01YVJFbT4qf80jJ2zA1kl2/kwE7
 rtChuNcrxuD7SrGQxX5IG2wgg/6Q0DYERc6XRKGtXv4S/JkvjZQ9+t+IkIaxMoxNxxxc5nJCUE3
 CPVKlikAkIY3JjwfvR1wmEe/VtfKSSRCE/8Lzx+j09Nq8HO7KOrEJ
X-Received: by 2002:a17:907:2d24:b0:a7c:f6f5:390e with SMTP id
 a640c23a62f3a-a7daf67430fmr130121466b.58.1722500550986; 
 Thu, 01 Aug 2024 01:22:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsJUX2YeigZiTPvMV6rY+TJ5xy0GTAWHDzcHLpJi3a94oeMtpCA4zis3rc76EWkO+3W6HS2g==
X-Received: by 2002:a17:907:2d24:b0:a7c:f6f5:390e with SMTP id
 a640c23a62f3a-a7daf67430fmr130118366b.58.1722500550149; 
 Thu, 01 Aug 2024 01:22:30 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2316dsm872070066b.2.2024.08.01.01.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 01:22:27 -0700 (PDT)
Date: Thu, 1 Aug 2024 04:22:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL v2 17/61] virtio-snd: check for invalid param shift operands
Message-ID: <20240801042204-mutt-send-email-mst@kernel.org>
References: <cover.1721731723.git.mst@redhat.com>
 <9b6083465fb8311f2410615f8303a41f580a2a20.1721731723.git.mst@redhat.com>
 <21a0899b-cff5-49da-bda5-f53e12cca234@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21a0899b-cff5-49da-bda5-f53e12cca234@t-online.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jul 27, 2024 at 08:55:10AM +0200, Volker Rümelin wrote:
> > From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> > When setting the parameters of a PCM stream, we compute the bit flag
> > with the format and rate values as shift operand to check if they are
> > set in supported_formats and supported_rates.
> >
> > If the guest provides a format/rate value which when shifting 1 results
> > in a value bigger than the number of bits in
> > supported_formats/supported_rates, we must report an error.
> >
> > Previously, this ended up triggering the not reached assertions later
> > when converting to internal QEMU values.
> >
> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Message-Id: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/audio/virtio-snd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > index e6432ac959..e5196aa4bb 100644
> > --- a/hw/audio/virtio-snd.c
> > +++ b/hw/audio/virtio-snd.c
> > @@ -282,11 +282,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
> >          error_report("Number of channels is not supported.");
> >          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >      }
> > -    if (!(supported_formats & BIT(params->format))) {
> 
> Hi Manos,
> 
> this patch doesn't work as intended. I guess you wanted to write
> 
>     if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
>         !(supported_formats & BIT(params->format))) {
> 
> > +    if (BIT(params->format) > sizeof(supported_formats) ||
> > +        !(supported_formats & BIT(params->format))) {
> >          error_report("Stream format is not supported.");
> >          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >      }
> > -    if (!(supported_rates & BIT(params->rate))) {
> 
>     if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
>         !(supported_rates & BIT(params->rate))) {
> 
> With best regards,
> Volker


Any response here? Should I revert?

> > +    if (BIT(params->rate) > sizeof(supported_rates) ||
> > +        !(supported_rates & BIT(params->rate))) {
> >          error_report("Stream rate is not supported.");
> >          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
> >      }


