Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C9CC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5uC-0005co-8r; Fri, 28 Jun 2024 03:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5tx-0005Nv-UD; Fri, 28 Jun 2024 03:20:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5tv-0001O1-Nf; Fri, 28 Jun 2024 03:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=BQXcDGrbTH1BIiik4vlmQG3bp4fR8x4xGEYXscXBtho=; b=swKUS7Su+sQniBsVgG0jCtFc6V
 16yYROsyTIIKwkMPpAq/Z9gZDp/4vqlc9xPYkTWYe2LZD00bT/V7KCiIpBvhUSUxqznRQ0LK3MbDh
 qpn1hHE/81ZwsFOe1UeJLLzvHLo9nG8B04tt/i8W7ce6aM9H3xYNUwOm1aswqKX7IOjn5Mk+/oyhe
 yfzoFpdVmx1Urg6ZSoeN88Ki5DZGFoYrztSB87KsbliWu5MXSXPeER6AEh3wCAjAjduHI3wql8LC8
 lN3vNfAfq54d1ICIV/ByjGb+8zPK/5MYnoyp7y0T5kJE1L/b9Jhqr9lvKcRez0aI7MdbHWWGAHYTD
 WlGjD9qkfSovJKgvk4xLe/E4QcBqos2Wu4CaBkynhOnzY+ypXZuY/yKOmoK0TaICu/EMll/l8s87q
 m2fw7tNumLCD1aq100ntcWplgzsnR+95S+xxMiZUuuJwWAANZf+P6GWDov5iIkpRCtsS94D2f++0R
 psqyrEohg6J1HGsW0+gwXD+dkmtZt3YNSyyDFtTOPJOH/dTERig866UeScjO5uDW4wJYKubIhJrRj
 EyOLwTmpxhniRjcuAXnL3kApUUA23rPuLyann6mi92Rg+0vp1nOZPWbm+tWs7FhNYTnF7Gk+Fqnd5
 iPlbEcC2cbIYoKXYYkDPg2fz3CS+K9AMXgcKEFiHE=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5sI-0008NX-9p; Fri, 28 Jun 2024 08:18:31 +0100
Message-ID: <78dc561c-3abc-4ee0-b2c6-9b219e513705@ilande.co.uk>
Date: Fri, 28 Jun 2024 08:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-2-750bb0946dbd@daynix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240627-san-v2-2-750bb0946dbd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 02/15] hw/ide: Convert macio ide_irq into GPIO line
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/06/2024 14:37, Akihiko Odaki wrote:

> macio ide_irq is connected to the IDE bus. This fixes the leak of
> ide_irq.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ide/macio.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index aca90d04f0e8..9c96a857a7c1 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -427,7 +427,7 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
>       s->bus.dma = &s->dma;
>   }
>   
> -static void pmac_ide_irq(void *opaque, int n, int level)
> +static void pmac_irq(void *opaque, int n, int level)
>   {
>       MACIOIDEState *s = opaque;
>       uint32_t mask = 0x80000000u >> n;
> @@ -446,6 +446,11 @@ static void pmac_ide_irq(void *opaque, int n, int level)
>       }
>   }
>   
> +static void pmac_ide_irq(void *opaque, int n, int level)
> +{
> +    pmac_irq(opaque, 1, level);
> +}
> +
>   static void macio_ide_initfn(Object *obj)
>   {
>       SysBusDevice *d = SYS_BUS_DEVICE(obj);
> @@ -456,8 +461,8 @@ static void macio_ide_initfn(Object *obj)
>       sysbus_init_mmio(d, &s->mem);
>       sysbus_init_irq(d, &s->real_ide_irq);
>       sysbus_init_irq(d, &s->real_dma_irq);
> -    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
> -    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
> +    s->dma_irq = qemu_allocate_irq(pmac_irq, s, 0);
> +    qdev_init_gpio_in_named_with_opaque(DEVICE(obj), pmac_ide_irq, s, NULL, 1);
>   
>       object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
>                                (Object **) &s->dbdma,
> 

This doesn't feel quite right: generally I consider the use of 
qdev_init_gpio_in_named_with_opaque() to indicate that the underlying modelling is 
incorrect. Let me have a look and see if I can figure out what's supposed to be 
happening.

I guess I should probably be marked as maintainer of hw/ide/macio.c as it is part of 
the macio device, but it looks as if this is missing from MAINTAINERS.


ATB,

Mark.


