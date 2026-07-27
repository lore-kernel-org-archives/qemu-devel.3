Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A649C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKK4-0000eP-8Q; Mon, 27 Jul 2026 08:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1woKJy-0000bK-DS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1woKJw-000091-Aj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785154835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89NzTzSellfW3qMr8dN8sAksaWWUoRY5Hxr3im1aqv4=;
 b=TuSNLT3LS3lnF+kPEkA90Zaq0l7ELWxS1cdLwjyG3sDfD7TIto9O++BIr74WJUbgVj0gY1
 vRvoAmpbbVkvox4VWa9IOxbhe3cy8FnplqhvU74NvxUqwtjK3X82FpxJFT39HDXh58mLIS
 nIzUJAp4l+tPItSDOR6M0Pe9opR4ivM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-vqmTJ-8rP-ewf0TeZ_Gnjg-1; Mon, 27 Jul 2026 08:20:34 -0400
X-MC-Unique: vqmTJ-8rP-ewf0TeZ_Gnjg-1
X-Mimecast-MFC-AGG-ID: vqmTJ-8rP-ewf0TeZ_Gnjg_1785154833
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15ceb17a28so216331466b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785154833; x=1785759633; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=89NzTzSellfW3qMr8dN8sAksaWWUoRY5Hxr3im1aqv4=;
 b=UwNN3MDV3QKMhEbCpKGUfxp4fETCdx7ih+nOexhLtSa1pxIu9AWtLAg9uTEl6f2A4c
 jAx2Wn/XX6OMuldy/r++F2C8iJdc7M6JGhozZ+A+Cy1YM+kVMRgozhfU0BP884v423+C
 yi5RZA6StZv7Ienqi3YRIHzJABPufItIo1bxs3HxADBOupzm+kocLvFeSTASBO52sHQg
 qUfx8GQe224QQ1JzLioR5yOt1B7q8fUDXzrPBA/THmNG8vQzG5+LZoAAnFpaoewmz3Fu
 Hi6U56H/0myfPb9omVNp2CslJh4UY+ZAgSLPv8Xp+CFX2RyCuIgNfg8043bi5hAi+Q0/
 ms1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154833; x=1785759633;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=89NzTzSellfW3qMr8dN8sAksaWWUoRY5Hxr3im1aqv4=;
 b=JEU8+0GxSBdQ6zmRwwMbRV6VbmdGirmRwnyrm1o+HC8lFsSLEaYjzX/Kx+XbtF0oe0
 wl2Dfo9bsaWJiU6DovP8hqeUXBzqLMv1BKXIVAIVgnoBrO0cRecorSQy57FZ9XBl8+mP
 38dHjhfjzD8iEfrDxLfgCcobf4tL7lK+My24dKTUUEdt9wMq5OoNlPkD9pmHojakFZCx
 P2jySSoRTo624dM/OT0tRIIcrJsyDfx0EaCZE7u3rj6EAcxdKZYVhgXEl8LlRtXsGL6S
 pQD8YNoPUEdCWz9/LurZAQcWK6+xwoqYbVxIiqrcdNKbtZAIMNwM+SSxlBa3SaIiAvvI
 ZETA==
X-Gm-Message-State: AOJu0YxuZ9WcUY1kp4pOotNoI6hn4vk8uh02aywmmbxQTKfDOxfJfiGK
 KPoTJ8cIx+HWkb2iL8zO51z82tu9J/iva4Y70Fuh4A7h1DZ6n7BVsJMWpKBUx1wJBFiJ6OtN6M4
 HAsdY9pjKHM6PsC4zm5okYiH0cw73J/qLqBXZqn3kdkZteM//dvUvpvcxy9dJkf26
X-Gm-Gg: AR+sD12160W7KiujqM9XqPca+tYuTDJY/xc4DwqM8H9ypIOdIHApS1Iroj0O/L/3+vM
 l/x7mQqRmm6octHdrxM+CDPSCrUTGMjKgqdyHwwCwRTkBQdOKLTAU/FZ/bGqzi8edK6KG0QnOtM
 0GzX6oiCPuJhTCuCIdB597Uzc1GbKO6M0WB0RWtm5nlndR0Bsc56ec4sd+mfhNo0NplD30xMTiW
 iLMJi0kKbMT8IKZKWQKtaJwhMIz8A5NVne+9D6pBBtHoymFbHWW4gs/pCaTFj677yoEA98+VStC
 RvmHBFBpbFDg6raHlaLSVTctsrxfbIxV7SfXevXlu70MhD8jj8kNUhfjXDIs
X-Received: by 2002:a17:907:72cb:b0:c16:26c7:6ba8 with SMTP id
 a640c23a62f3a-c1f1ea08253mr325683866b.6.1785154832932; 
 Mon, 27 Jul 2026 05:20:32 -0700 (PDT)
X-Received: by 2002:a17:907:72cb:b0:c16:26c7:6ba8 with SMTP id
 a640c23a62f3a-c1f1ea08253mr325680866b.6.1785154832520; 
 Mon, 27 Jul 2026 05:20:32 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f19c57sm626106066b.58.2026.07.27.05.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:20:32 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:20:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Lukas Straub <lukasstraub2@web.de>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, Markus
 Armbruster <armbru@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Alex
 Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna
 Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Michael
 S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 26/44] qapi: convert intro sections for pci.json
Message-ID: <20260727142028.3206f9e7@imammedo>
In-Reply-To: <20260723044805.527643-27-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-27-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 23 Jul 2026 00:47:47 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/pci.json | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/qapi/pci.json b/qapi/pci.json
> index 694c741e420..a6a79f91afc 100644
> --- a/qapi/pci.json
> +++ b/qapi/pci.json
> @@ -13,8 +13,7 @@
>  
>  ##
>  # @PciMemoryRange:
> -#
> -# A PCI device memory region
> +#     A PCI device memory region
>  #
>  # @base: the starting address (guest physical)
>  #
> @@ -26,8 +25,7 @@
>  
>  ##
>  # @PciMemoryRegion:
> -#
> -# Information about a PCI device I/O region.
> +#     Information about a PCI device I/O region.
>  #
>  # @bar: the index of the Base Address Register for this region
>  #
> @@ -51,8 +49,7 @@
>  
>  ##
>  # @PciBusInfo:
> -#
> -# Information about a bus of a PCI Bridge device
> +#     Information about a bus of a PCI Bridge device
>  #
>  # @number: primary bus interface number.  This should be the number of
>  #     the bus the device resides on.
> @@ -80,8 +77,7 @@
>  
>  ##
>  # @PciBridgeInfo:
> -#
> -# Information about a PCI Bridge device
> +#     Information about a PCI Bridge device
>  #
>  # @bus: information about the bus the device resides on
>  #
> @@ -94,8 +90,7 @@
>  
>  ##
>  # @PciDeviceClass:
> -#
> -# Information about the Class of a PCI device
> +#     Information about the Class of a PCI device
>  #
>  # @desc: a string description of the device's class (not stable, and
>  #     should only be treated as informational)
> @@ -109,8 +104,7 @@
>  
>  ##
>  # @PciDeviceId:
> -#
> -# Information about the Id of a PCI device
> +#     Information about the Id of a PCI device
>  #
>  # @device: the PCI device id
>  #
> @@ -128,8 +122,7 @@
>  
>  ##
>  # @PciDeviceInfo:
> -#
> -# Information about a PCI device
> +#     Information about a PCI device
>  #
>  # @bus: the bus number of the device
>  #
> @@ -161,8 +154,7 @@
>  
>  ##
>  # @PciInfo:
> -#
> -# Information about a PCI bus
> +#     Information about a PCI bus
>  #
>  # @bus: the bus index
>  #
> @@ -174,8 +166,7 @@
>  
>  ##
>  # @query-pci:
> -#
> -# Return information about the PCI bus topology of the guest.
> +#     Return information about the PCI bus topology of the guest.
>  #
>  # Returns: a list of info for each PCI bus.  Each bus is
>  #     represented by a json-object, which has a key with a json-array


