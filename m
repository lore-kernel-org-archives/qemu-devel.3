Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07164CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZRP-0008Rh-Uz; Mon, 08 Jun 2026 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWZRD-0008RH-A7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWZRA-0007f9-Gf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780923038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TGPBhJeNNX2lh+dlHTWweX0xL6ngrYYBO6CNuFKasAU=;
 b=b7awhPDcWzoNy+DOFhDfu9XlR84yQVXwg4Ch9DGYuuBFeGQH+0Aurkh+/93hxURLhwFNfr
 th1+gHfVtOKk0yt1mVVjOGWBdu452v4MkOGEkcrk6AhuqwRjM1b1AxWnZi8QoAX91qZCKz
 oN4iM1zQUNbVB/LRzZp0HsFIoOKKeFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-m9wk9YJlP0a0aoWULO4_kg-1; Mon, 08 Jun 2026 08:50:37 -0400
X-MC-Unique: m9wk9YJlP0a0aoWULO4_kg-1
X-Mimecast-MFC-AGG-ID: m9wk9YJlP0a0aoWULO4_kg_1780923035
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so35708235e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780923035; x=1781527835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TGPBhJeNNX2lh+dlHTWweX0xL6ngrYYBO6CNuFKasAU=;
 b=GDrr027AU+5o6KsJqmpdz+yD+JtHo5qOgon0CIqqdf/m1BJZ6u0So1cRZrwys9kZZ9
 7phx0wPlA0knGRWs4g7KAhv3wqOiugyzMFPgni8HoFUJIQMdLbFI9Lz0pST2hS828tHc
 fsrP/bymi8rsdIhYjV7PaDxaOUHGr0lHrsWgB1J9lBLABg3AsGzlCXEX9sDj9aeERlBR
 o8AraM8FJhApqDFKmj4k2QkVSzzKeUr48GV8pdqHdN5RQPeLUyhnhd5hIPxKY/EHd2a4
 3VACF5xgAjoammOkWwHBh7QYexhTMHiLkwDoXJBqOBNfHHNgAkdBoTNyGmQKntxgXIM9
 UpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923035; x=1781527835;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGPBhJeNNX2lh+dlHTWweX0xL6ngrYYBO6CNuFKasAU=;
 b=q5WmWWdocYEhDUsWXfj0Ma9LqgDoF6LJLVuArXWouUDhweLPrrbuTf4R2A4A90UWPE
 rXL7754/1MvjemsVmMQo+SpQyXy+o7NIGu3bFgH2J1icU+YRoxwtDI8dlTGUeE+sdS1I
 UOr7a0xECPAyR8oWV298dEAfPgjSgFo958m6y5E9xTzmbx3o568zCfdNXZUbBuF4LVgu
 FM01INjSik9F0ZRUwm3SKYjBVPSSrN2taLglP024I1CotbNjt82QXIJmPRXjpWla8Lci
 8T3ejcNlom0jtRrhkS9N2UXrB4HAVor1pjOlr65pn7U8zcOm5+jWApATKbWUxBq95S/W
 Z80Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xEadxV0KKiAiMXdWzYZ8foN0+pI3+/8JS9vbW6yhqlPYjs9Rv6WWmx273UXNSg3DIUJkmf1oAZHAu@nongnu.org
X-Gm-Message-State: AOJu0Yx/OuVYV0SpV/mKyQ0NGSsuOp/Hb+Tmpk7VaXV9m/Le/69GmjBb
 xVKHDdMPmuI6cVgzEvwbVPruyXznvpvkkR7hpIjhtdsrt704xTDXXC6OnTw8C2LuUscVYqU7wFC
 999x5RuOIutOOdPa2QJT55ye2xqGDp7wKSbIsWeU8uBHMzAB+MUA/x1N9
X-Gm-Gg: Acq92OE+MvZioCLkERYTDiCRm7ZREV3YzwSqXkVH7KO24qP7TfLwtGS7tOBjiWmQ5PA
 9mJUwC5V81UW98Ho1R2QLHhV6iTqtSBBZ8JCuvaVeXa+Ec7Gkp1Jr0Iy9tkgJOvzLFoD6CN6FHu
 n9h+nA3Z1Z3MBQOr2821fGvEcoRX1uPXy0ORh7FXvjTbbs1IZCmed3aQg32CGyOqk8zYNTuXcka
 gOqwKTniPNB7EYih+wiDZU4C9CCQ2ZPIIHTfBzBOdx6rLZrepaddgmMaX3Kb/aIdIyxbx0Z5vfT
 Yl1g8dYmfTK9AstWPqQgFt3tZWA4CxcqnFsb6CPD1nUakMmTbSHFtjAjc36fe+CmCOUKOZvMPAu
 a/MUGLlgqof+kQEgH7m6t2ZlMxgNSSgW9yURDWQaaoew+orTz4+8ZpMT3j/ptapcH9CjdaEE=
X-Received: by 2002:a05:600c:45d1:b0:490:51e2:bc86 with SMTP id
 5b1f17b1804b1-490c260a60bmr240352715e9.23.1780923035082; 
 Mon, 08 Jun 2026 05:50:35 -0700 (PDT)
X-Received: by 2002:a05:600c:45d1:b0:490:51e2:bc86 with SMTP id
 5b1f17b1804b1-490c260a60bmr240352245e9.23.1780923034639; 
 Mon, 08 Jun 2026 05:50:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc391aaasm453743815e9.1.2026.06.08.05.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 05:50:33 -0700 (PDT)
Message-ID: <62b98e0c-011a-4f9e-a913-4fc24aa8450d@redhat.com>
Date: Mon, 8 Jun 2026 14:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/33] vfio/pci: close display console during
 unrealize, not finalize
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Peter Maydell
 <peter.maydell@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-5-9ea6355ea08f@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260608-b4-ui-v2-5-9ea6355ea08f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Marc-André,

On 6/8/26 09:16, Marc-André Lureau wrote:
> The QemuGraphicConsole holds a strong QOM link back to the device via
> its "device" property (OBJ_PROP_LINK_STRONG). When graphic_console_close()
> is only called from vfio_display_finalize() during object finalize, this
> creates a ref-cycle deadlock: the device can't reach refcount 0 because
> the console holds a strong ref, but the console's ref is only dropped by
> graphic_console_close() which runs inside finalize.
> 
> Split the display teardown into two phases:
> - vfio_display_exit(): called during unrealize (vfio_exitfn), closes
>    the graphic console to break the ref cycle, and removes display
>    region subregions while the parent memory regions are still alive.
> - vfio_display_finalize(): remains in finalize (vfio_pci_put_device),
>    frees display region memory, dmabuf, and edid resources. The region
>    memory contains QOM child objects (MemoryRegions) that must stay
>    alive until QOM finalization has processed them.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/vfio/pci.h     |  1 +
>   hw/vfio/display.c | 30 +++++++++++++++++++-----------
>   hw/vfio/pci.c     |  1 +
>   3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d350..cf567115870 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -270,6 +270,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
>   void vfio_display_reset(VFIOPCIDevice *vdev);
>   bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_display_exit(VFIOPCIDevice *vdev);
>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
>   extern const VMStateDescription vfio_display_vmstate;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 8f91e83da88..34cc25ee0e0 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -505,15 +505,6 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_display_region_exit(VFIODisplay *dpy)
> -{
> -    if (!dpy->region.buffer.size) {
> -        return;
> -    }
> -
> -    vfio_region_exit(&dpy->region.buffer);
> -    vfio_region_finalize(&dpy->region.buffer);
> -}
>   
>   /* ---------------------------------------------------------------------- */
>   
> @@ -547,17 +538,34 @@ bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>       return false;
>   }
>   
> -void vfio_display_finalize(VFIOPCIDevice *vdev)
> +void vfio_display_exit(VFIOPCIDevice *vdev)
>   {
>       if (!vdev->dpy) {
>           return;
>       }
>   
> +    if (display_opengl) {
> +        qemu_console_set_display_gl_ctx(vdev->dpy->con, NULL);
> +    }
>       qemu_graphic_console_close(vdev->dpy->con);
> +    if (vdev->dpy->region.buffer.size) {
> +        vfio_region_exit(&vdev->dpy->region.buffer);
> +    }
> +}
> +
> +void vfio_display_finalize(VFIOPCIDevice *vdev)
> +{
> +    if (!vdev->dpy) {
> +        return;
> +    }
> +
>       vfio_display_dmabuf_exit(vdev->dpy);

vfio_display_dmabuf_exit() will use dpy->con after it's closed :

   qemu_console_gl_release_dmabuf(dpy->con, dmabuf->buf);

It is OK ?

if so,


Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> -    vfio_display_region_exit(vdev->dpy);
> +    if (vdev->dpy->region.buffer.size) {
> +        vfio_region_finalize(&vdev->dpy->region.buffer);
> +    }
>       vfio_display_edid_exit(vdev->dpy);
>       g_free(vdev->dpy);
> +    vdev->dpy = NULL;
>   }
>   
>   static bool migrate_needed(void *opaque)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e637..78beacd24e1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3624,6 +3624,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>       VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
> +    vfio_display_exit(vdev);
>       vfio_unregister_req_notifier(vdev);
>       vfio_unregister_err_notifier(vdev);
>       pci_device_set_intx_routing_notifier(pdev, NULL);
> 


