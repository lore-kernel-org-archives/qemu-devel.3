Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF603C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN61Z-0003ee-88; Fri, 28 Jun 2024 03:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN61X-0003YO-DY; Fri, 28 Jun 2024 03:27:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN61V-0006qg-TD; Fri, 28 Jun 2024 03:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=avaP5V4evyTESkZpU+tHsU+6spQiqPzbd3k3nTkT3zk=; b=o+q839dk+8N/9g2oKXZQPxHLWm
 M4S/lf46fodXijiSEZDeE8+bix84YU6uWvYx8GYKj8Lt9cjVSsxAsQpywhMQQhP5WJsEVcvRXZJQI
 C6tf0xvW683/ncsdiacw3dFWnNO5yUdnk5pabuko3ByLjuxVu40u7ULyOsWwBBYQpyyelIi+HGVlO
 8A8jL4T4a9gqsz90Gz25B/nAkdJpz5UNpjrVdlfJnezVNRQTpE86MMmDews6sx7eumMzs4OOn+gJQ
 yI9nlv7oqylIrDYKpjASYjvRbH9dDsRRRHDGykGNw3Vmgix3912xwpMFb6TDa2KAivbvUjhDg/Lze
 3ssgfCJu/d/a9q4GvL/my7GMCmmb/f8v7IfDoFEiiF1KzB+mYrxgVkeO/qutasaxH2u7Simn88Ts+
 u0yrs0EvVtX7CyejoFXerQApufxYOXOoxJgbiqD4wI2lfVJQAicX+tRvUxYw2W6bjP4tiGkkNJ1NA
 MISfWi3abqrkUzY4j1luaZ/QHCxoJtwmHfVHBFHsi3OkLuy+AD2b7ji1JpEjrnUdIauNJlvUhUMpt
 QfX46VIBdAqLWSz1TzvKnMJTL5jKxxu/OleDE5wDsZqKd+OPvgz4z8iyeAEhZfNu9j/LF4pkM4O7c
 IWEOYpHfLQ4IW1F8hXJC9AA2Lvui2rfeYwyqXCZ7U=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5zu-0008Tv-Ga; Fri, 28 Jun 2024 08:26:22 +0100
Message-ID: <075008cd-be83-4695-a60a-9bd5f6c9a4d2@ilande.co.uk>
Date: Fri, 28 Jun 2024 08:27:39 +0100
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
 <20240627-san-v2-4-750bb0946dbd@daynix.com>
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
In-Reply-To: <20240627-san-v2-4-750bb0946dbd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
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

> This fixes qemu_irq array leak.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/isa/vt82c686.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 8582ac0322eb..629d2d568137 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>       ViaISAState *s = VIA_ISA(d);
>       DeviceState *dev = DEVICE(d);
>       PCIBus *pci_bus = pci_get_bus(d);
> -    qemu_irq *isa_irq;
> +    qemu_irq isa_irq;
>       ISABus *isa_bus;
>       int i;
>   
>       qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>       qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
> +    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 1);
> +    isa_irq = qdev_get_gpio_in_named(dev, "i8259", 0);
>       isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>                             errp);
>   
> @@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>           return;
>       }
>   
> -    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
> +    s->isa_irqs_in = i8259_init(isa_bus, isa_irq);
>       isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>       i8254_pit_init(isa_bus, 0x40, 0, NULL);
>       i8257_dma_init(OBJECT(d), isa_bus, 0);

Have you confirmed that the machines using the VIA can still boot correctly with this 
change? I have a vague memory that Phil tried something like this, but due to legacy 
code poking around directly in the ISA IRQ array after realize it caused some things 
to break.


ATB,

Mark.


