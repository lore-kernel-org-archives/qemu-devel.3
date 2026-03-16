Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71655F53D6E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AT9-0003C4-Ux; Mon, 16 Mar 2026 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2AT0-0003AF-Uv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2ASq-0001jo-Jv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773677200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Awtpk1QgiNykjBrqze3l6ppEYY2FlI6uf//qFwjg7WQ=;
 b=AFmQzuDJK9fXKrCiMtA484jgAOaAO+XWI7wgBvBDVX+FuOQTwbDlMaEqYn6pVA1UrfcP23
 hRveqRguFll9S52Q+Bzk+wkwu9NqsYkNJArrJduxAJ8HFEU6Y0PJPz1tdn6KunIgvB+G76
 /sQc6cDbwMRTO2g+J7/kplLXdSfIQao=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-CzqS2FPKNqWO9GfnduMDvg-1; Mon, 16 Mar 2026 12:06:39 -0400
X-MC-Unique: CzqS2FPKNqWO9GfnduMDvg-1
X-Mimecast-MFC-AGG-ID: CzqS2FPKNqWO9GfnduMDvg_1773677199
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5091f12ed3bso372876691cf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773677199; x=1774281999; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Awtpk1QgiNykjBrqze3l6ppEYY2FlI6uf//qFwjg7WQ=;
 b=IyO1M59782RgO+9lWCsMeilftgpZlERtfS7HD7NIZ+hMVC42kPI2fza/9vhs4VKbGO
 47PYMlQf90TvKKu0lDa2EmtaZd1j/5HZY9IVUDjsoYoUUx1eKzPJXcfsXE4MioZX9CJI
 lLtLyk32Wdgk8UEVtCFrLYNqfTaC+2m+qhTKi0tl0O4DyTFWv4cDoScItiUQfOwJrhZw
 u/fGBhokPcDb6zAURg7T4UqisNFhN9mbeQtm1CnGpAZfv5q5XXMTCuu6MRy9tp2THvBH
 8X7J8D0qjH7OpQKkijotT81RYZOAZHDyjClxDk++usx23tSPHwM0z8Ty5VslQqZ2mYN7
 IRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773677199; x=1774281999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Awtpk1QgiNykjBrqze3l6ppEYY2FlI6uf//qFwjg7WQ=;
 b=sPLa/PoBmV6pm88P0FXhH6TtGcCLYfCxHSaUj3Kd7nRtNkxu+iNbrK0H3NeIakDVZw
 pKTalRLowxXq9t3Bm2xGp+OOjoRRfZZ6PxaiHQMFQblvMjmOZPi3dmpH/umGjBUGarxh
 PFdGIWWAeeNSG85UfEdc0gxlZ1zpev6Rsm3abmmT4ekuCDl9SUYfbBUDgYlUwEtzHvhq
 urJpFW75QK7e0Vh7YHjXZ2qoo4yUMCGcXKqwGEERY4Ovlq2dntG56YSj8GoPWSjb4c8Z
 yjvNI9U9abQ2suJJTF/IjIsPY7JO6uc0LyZYjKCf/61sLRdUTBmisDzAEiQ659rLED+D
 ga4A==
X-Gm-Message-State: AOJu0YynHU9bCDRCrjQe92t7PD2oa+DjF/Og+3qg6yG6SrO1eQh39qnX
 CzvL+NICsLxa5dt0ROX5/OwMsMPIg9nu7zsjogYQJhOz2frZdrm6X6ysAeh0L+HuqsuDWuuJB29
 sjE4q8luoIrav/ESN5VSrkmAPf9kdNctZ5oAJaT+gFAf+PpiqKGXhDGHC
X-Gm-Gg: ATEYQzx5zW8khHD0jNyP1HI5X3pA2Xzky4g/9/vd1/N0mfVdS0ZFLZlbWLo4w7Go1rq
 2UW4n8tSn79dHr3HZPikA8Dn9XOfmUDdIy4iGLl7qMufmTZlHTdP6sF0EDq/q7/LScKvoHavRIt
 xOyCnyoxACQJKCxDxcjJOwtRw4HWbtFaTStgNPBmDQqP4QuK2o0UQo2HvEbiHIggz+BS8oYa95r
 1eJ3bwpCOMYhS4H5Eu9BRdevDBtAO4g+DTLVxz+3aHOIUTvm2J+Z+B40T/YBJj30rO0lZNw0zvW
 tEXbrb+Uuk7LP4m3u9JKElgaTBNuW3EfxjX22eyUKOgrFmbAEOmbpjnZDDXMjln9yzhllplT+Ed
 lnnJPrzb3s9zgbw==
X-Received: by 2002:ac8:5703:0:b0:509:39b5:a97c with SMTP id
 d75a77b69052e-50957cd9ef5mr175534111cf.27.1773677198737; 
 Mon, 16 Mar 2026 09:06:38 -0700 (PDT)
X-Received: by 2002:ac8:5703:0:b0:509:39b5:a97c with SMTP id
 d75a77b69052e-50957cd9ef5mr175533371cf.27.1773677198175; 
 Mon, 16 Mar 2026 09:06:38 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65cd7f49sm124122036d6.34.2026.03.16.09.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:06:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:06:36 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
Message-ID: <abgqjKVFHKxuKupP@x1.local>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316130651.5C8735968DE@zero.eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
> current_machine which is not set during init when inspecting the
> device. This causes the qtest/device-introspect-test to fail since a

Does it has anything to do with aux-ram-share?  I thought it's because the
qom introspect test will create yet another sun-tcx device, causing double
registration?

> recent change to use memory_region_init_rom instead of global vmstate.
> Fix it by removing the init method and move memory region creation in
> realize.
> 
> Fixes: 653c4fa5b0 hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate
> Reported by: Thomas Huth <thuth@redhat.com>

Missing "-" in the tag.

I can queue it for rc1 with above fixed, BALATON please help confirm.

PS: Mark, please feel free to comment or if you want to take it.

Thanks,

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/tcx.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index c8a4ac21ca..ea92a48400 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -751,10 +751,15 @@ static const GraphicHwOps tcx24_ops = {
>      .gfx_update = tcx24_update_display,
>  };
>  
> -static void tcx_initfn(Object *obj)
> +static void tcx_realize(DeviceState *dev, Error **errp)
>  {
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    TCXState *s = TCX(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    TCXState *s = TCX(dev);
> +    Object *obj = OBJECT(dev);
> +    ram_addr_t vram_offset = 0;
> +    int size, ret;
> +    uint8_t *vram_base;
> +    char *fcode_filename;
>  
>      memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
>                             &error_fatal);
> @@ -804,16 +809,6 @@ static void tcx_initfn(Object *obj)
>      memory_region_init_io(&s->alt, obj, &tcx_dummy_ops, s, "tcx.alt",
>                            TCX_ALT_NREGS);
>      sysbus_init_mmio(sbd, &s->alt);
> -}
> -
> -static void tcx_realizefn(DeviceState *dev, Error **errp)
> -{
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    TCXState *s = TCX(dev);
> -    ram_addr_t vram_offset = 0;
> -    int size, ret;
> -    uint8_t *vram_base;
> -    char *fcode_filename;
>  
>      memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
>                             s->vram_size * (1 + 4 + 4), &error_fatal);
> @@ -887,7 +882,7 @@ static void tcx_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->realize = tcx_realizefn;
> +    dc->realize = tcx_realize;
>      device_class_set_legacy_reset(dc, tcx_reset);
>      dc->vmsd = &vmstate_tcx;
>      device_class_set_props(dc, tcx_properties);
> @@ -897,7 +892,6 @@ static const TypeInfo tcx_info = {
>      .name          = TYPE_TCX,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(TCXState),
> -    .instance_init = tcx_initfn,
>      .class_init    = tcx_class_init,
>  };
>  
> -- 
> 2.41.3
> 

-- 
Peter Xu


