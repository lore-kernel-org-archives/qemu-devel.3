Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9EAC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENe2-00059t-4G; Tue, 04 Jun 2024 02:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sENdw-00059a-Ha
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sENdv-0001sw-0U
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717482453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JVtdIWNto+KqDFiBlQzdZJhx14N17tSKBoZOMoyk4A=;
 b=DPRPU26bNN2uxgtNuuaRbnbG59X5YZ6F0ClIKdiXNXY6G+iqjcnvZMG9rJB3rJh6yliUg1
 5VRy4IuL6h1RCuRWmRN/NCd1JapbdLkNiWKw7P4Aoq+lxwygZ5WtpsEyKSz1at8BySDqCw
 dEj34bCEYe1kcQHvc4EFaRXxiFV9whE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-6ZyKj-B-NEGkv_UPU8SQAw-1; Tue, 04 Jun 2024 02:27:31 -0400
X-MC-Unique: 6ZyKj-B-NEGkv_UPU8SQAw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a79421a14so421536a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482450; x=1718087250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JVtdIWNto+KqDFiBlQzdZJhx14N17tSKBoZOMoyk4A=;
 b=ELQXXEATQ5U01dh9Ttmsha9yLXeyv9kd5igUYgMTR+6BD1A2O8TlkxuKIP4JyS7kMq
 xSeTCxGsQpk94pvvVU4M5xKAJjLH/Ldi7/kyW/Upu2PPd3UBRU8PmzvANwcgnyLlXyq0
 lFSedE5GFQGF5UIIAD+KNoEZgfl30KQ/+W3V+pY4myXiGMBpd7CUT3yKOeYUgRG2fpx+
 xhYlE8wdp0UpXyfffYaMTvNIfnmuxJ6xaK+WFuGS5xSfG/5Lv3UNEYhQozLOICMS+SGq
 aegvsxfWyQHjabgpjzhXAM/IQj3pKR1kSVAWhpRBZXESfiRIeWUFjEC/JaO7BpxMyyVh
 UNhQ==
X-Gm-Message-State: AOJu0YzmFDefID6cClXYDEWzeqo2DEzoX4FRnoMf7cuNSqWnAuSxTh0e
 3fdfpn9OwEVTOjMOCDGXM6b9japFxhCEgK+EEjxCPncjfLMLCrESfk8SVi6nyOTuNffg7VucRAR
 Y1tUtrzUwLtBe8MS8wOkhbMF7v18Pl6a0Q5Vq5A0gP8zbPainP6vIQWmsHwSKfvyfVz8zS+9VL2
 b+8oRLIAtzNIPzSTzgRhVWbD1LBsI=
X-Received: by 2002:a50:9548:0:b0:57a:2ccf:ed2f with SMTP id
 4fb4d7f45d1cf-57a363b4972mr7705405a12.3.1717482450700; 
 Mon, 03 Jun 2024 23:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgCCSiWmq1QljOi/YHDSSxZ/u0tvY5jfAekfJZ3pRnQnD3+sRh5XAJAPUGxLID5iQcee+lK0g7D2RiA9UbizE=
X-Received: by 2002:a50:9548:0:b0:57a:2ccf:ed2f with SMTP id
 4fb4d7f45d1cf-57a363b4972mr7705397a12.3.1717482450320; Mon, 03 Jun 2024
 23:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240603151825.188353-1-kraxel@redhat.com>
 <20240603151825.188353-2-kraxel@redhat.com>
In-Reply-To: <20240603151825.188353-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Jun 2024 10:27:18 +0400
Message-ID: <CAMxuvawqf-0dKPsZP2UTcDWPWQ+8FKbZ=S4KX02hQO1qeeGVMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org, 
 Stefano Stabellini <sstabellini@kernel.org>, qemu-stable@nongnu.org
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Mon, Jun 3, 2024 at 7:18=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
>
> In case the display surface uses a shared buffer (i.e. uses vga vram
> directly instead of a shadow) go unshare the buffer before clearing it.
>
> This avoids vga memory corruption, which in turn fixes unblanking not
> working properly with X11.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 30facc6c8e33..474b6b14c327 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s, int =
full_update)
>      if (s->last_scr_width <=3D 0 || s->last_scr_height <=3D 0)
>          return;
>
> +    if (is_buffer_shared(surface)) {

Perhaps the suggestion to rename the function (in the following patch)
should instead be surface_is_allocated() ? that would match the actual
flag check. But callers would have to ! the result. Wdyt?

> +        /* unshare buffer, otherwise the blanking corrupts vga vram */
> +        surface =3D qemu_create_displaysurface(s->last_scr_width, s->las=
t_scr_height);
> +        dpy_gfx_replace_surface(s->con, surface);

Ok, this looks safer than calling "resize".

thanks

> +    }
> +
>      w =3D s->last_scr_width * surface_bytes_per_pixel(surface);
>      d =3D surface_data(surface);
>      for(i =3D 0; i < s->last_scr_height; i++) {
> --
> 2.45.1
>


