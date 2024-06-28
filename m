Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFB9C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5xF-0001iL-1I; Fri, 28 Jun 2024 03:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5xC-0001hy-Sg; Fri, 28 Jun 2024 03:23:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5xA-0002wR-Tt; Fri, 28 Jun 2024 03:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eyavoEpXXCf6EvIoElMLvzoWuSWF0UmGAnjZ5OVYZkk=; b=ugqWMU2mdI64IEDSLC5II00xSj
 v88gJnIO71kg4N/kbmta75kj7sGPETRGX3UNtUw05JjmdEkF65F5Oo2RQOGeGBOc4ws5n+KLTpoXE
 hr1aEvmb0d5uUjtgvs6k/FBxjk/7+zAKuf2ClhCyfpPJIlxy2rBNdr9SaUkmskzi7c9ECTAu0rrBu
 fJRwFwC6qgftZ2+eqBbL4B+jgq2d5c4y/adVlWhqqQ9fU3vBHfT632wipUW4gInD3+aQNyymVvGIg
 UyWYMzmoGgFM8SY356L/GJDthHRqcQ+C4jQDUy3wMXxQQjz1GK093QBzW1Qzj2LY8z/b16oU5Wdr6
 FHQDJ2BFIHg4iVU+bVZOtvoP46y25s+VIEUxLzRXhEWL3ihkDyif5QgsACVfteCJXoALrFaVe6wAG
 J9ZP+MhYYVyE7JWA24GiSDcfii6RdVVGEFWbotb7Y5Chye1af1qIMKoXxNNIOnmxS18BqWaGEiNhD
 obLEOoAK5y5PCyFKU0GUQbJyDsSQ+Djl9YLPlvh9K8w5hBbZ8hYdOcP/QWgOsF1qCvgTQzXNFDFuE
 1wclvu3HuKH8m6cW/8/5VQhWlt6R2g0D4t4jvcrqLhfo+4l4jVaGme37DE33pKVL8QkZa9iFp1EZO
 LiCp4DdPE/TkdG3npDm3Kyq9e3Z5p7Azvg7/r2POw=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5vV-0008Qc-6N; Fri, 28 Jun 2024 08:21:49 +0100
Message-ID: <eb4e91b6-14da-46dd-a572-c07cb51afada@ilande.co.uk>
Date: Fri, 28 Jun 2024 08:23:06 +0100
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
 <20240627-san-v2-3-750bb0946dbd@daynix.com>
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
In-Reply-To: <20240627-san-v2-3-750bb0946dbd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 03/15] hw/ide: Remove internal DMA qemu_irq
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

> A function pointer is sufficient for internal usage. Replacing qemu_irq
> with one fixes the leak of qemu_irq.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/ppc/mac_dbdma.h |  5 +++--
>   hw/ide/macio.c             | 11 +++++++----
>   hw/misc/macio/mac_dbdma.c  | 10 +++++-----
>   3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> index 4a3f644516b3..1e1973c39580 100644
> --- a/include/hw/ppc/mac_dbdma.h
> +++ b/include/hw/ppc/mac_dbdma.h
> @@ -32,6 +32,7 @@
>   typedef struct DBDMA_io DBDMA_io;
>   
>   typedef void (*DBDMA_flush)(DBDMA_io *io);
> +typedef void (*DBDMA_irq)(DBDMA_io *io);
>   typedef void (*DBDMA_rw)(DBDMA_io *io);
>   typedef void (*DBDMA_end)(DBDMA_io *io);
>   struct DBDMA_io {
> @@ -154,7 +155,7 @@ typedef struct dbdma_cmd {
>   typedef struct DBDMA_channel {
>       int channel;
>       uint32_t regs[DBDMA_REGS];
> -    qemu_irq irq;
> +    DBDMA_irq irq;
>       DBDMA_io io;
>       DBDMA_rw rw;
>       DBDMA_flush flush;
> @@ -172,7 +173,7 @@ typedef struct DBDMAState DBDMAState;
>   
>   /* Externally callable functions */
>   
> -void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
> +void DBDMA_register_channel(void *dbdma, int nchan, DBDMA_irq irq,
>                               DBDMA_rw rw, DBDMA_flush flush,
>                               void *opaque);
>   void DBDMA_kick(DBDMAState *dbdma);
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index 9c96a857a7c1..425b670a52a9 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -427,9 +427,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
>       s->bus.dma = &s->dma;
>   }
>   
> -static void pmac_irq(void *opaque, int n, int level)
> +static void pmac_irq(MACIOIDEState *s, int n, int level)
>   {
> -    MACIOIDEState *s = opaque;
>       uint32_t mask = 0x80000000u >> n;
>   
>       /* We need to reflect the IRQ state in the irq register */
> @@ -446,6 +445,11 @@ static void pmac_irq(void *opaque, int n, int level)
>       }
>   }
>   
> +static void pmac_dma_irq(DBDMA_io *io)
> +{
> +    pmac_irq(io->opaque, 0, 1);
> +}
> +
>   static void pmac_ide_irq(void *opaque, int n, int level)
>   {
>       pmac_irq(opaque, 1, level);
> @@ -461,7 +465,6 @@ static void macio_ide_initfn(Object *obj)
>       sysbus_init_mmio(d, &s->mem);
>       sysbus_init_irq(d, &s->real_ide_irq);
>       sysbus_init_irq(d, &s->real_dma_irq);
> -    s->dma_irq = qemu_allocate_irq(pmac_irq, s, 0);
>       qdev_init_gpio_in_named_with_opaque(DEVICE(obj), pmac_ide_irq, s, NULL, 1);
>   
>       object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
> @@ -513,7 +516,7 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
>   
>   void macio_ide_register_dma(MACIOIDEState *s)
>   {
> -    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
> +    DBDMA_register_channel(s->dbdma, s->channel, pmac_dma_irq,
>                              pmac_ide_transfer, pmac_ide_flush, s);
>   }
>   
> diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
> index 2a528ea08caf..3450105ad851 100644
> --- a/hw/misc/macio/mac_dbdma.c
> +++ b/hw/misc/macio/mac_dbdma.c
> @@ -114,7 +114,7 @@ static void kill_channel(DBDMA_channel *ch)
>       ch->regs[DBDMA_STATUS] |= DEAD;
>       ch->regs[DBDMA_STATUS] &= ~ACTIVE;
>   
> -    qemu_irq_raise(ch->irq);
> +    ch->irq(&ch->io);
>   }
>   
>   static void conditional_interrupt(DBDMA_channel *ch)
> @@ -133,7 +133,7 @@ static void conditional_interrupt(DBDMA_channel *ch)
>       case INTR_NEVER:  /* don't interrupt */
>           return;
>       case INTR_ALWAYS: /* always interrupt */
> -        qemu_irq_raise(ch->irq);
> +            ch->irq(&ch->io);
>           DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
>           return;
>       }
> @@ -148,13 +148,13 @@ static void conditional_interrupt(DBDMA_channel *ch)
>       switch(intr) {
>       case INTR_IFSET:  /* intr if condition bit is 1 */
>           if (cond) {
> -            qemu_irq_raise(ch->irq);
> +            ch->irq(&ch->io);
>               DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
>           }
>           return;
>       case INTR_IFCLR:  /* intr if condition bit is 0 */
>           if (!cond) {
> -            qemu_irq_raise(ch->irq);
> +            ch->irq(&ch->io);
>               DBDMA_DPRINTFCH(ch, "%s: raise\n", __func__);
>           }
>           return;
> @@ -562,7 +562,7 @@ void DBDMA_kick(DBDMAState *dbdma)
>       qemu_bh_schedule(dbdma->bh);
>   }
>   
> -void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
> +void DBDMA_register_channel(void *dbdma, int nchan, DBDMA_irq irq,
>                               DBDMA_rw rw, DBDMA_flush flush,
>                               void *opaque)
>   {

At first glance I can't say I'm keen on this: in general we should be moving towards 
standardising on QEMU irqs or qdev gpios rather than introducing a custom function.

As per my previous email I suspect this is another symptom that something is wrong 
with the modelling, so I will take a look.


ATB,

Mark.


