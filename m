Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC6CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAle2-0004sU-6S; Mon, 20 Oct 2025 04:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAle0-0004m9-GF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:53:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAldy-0002hp-7q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:53:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so28016885e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760950408; x=1761555208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bQR+VfsEYRv4jYuvJa5HsMcpujaZmaRmeQD1rcR3hzs=;
 b=jQV21h6HNpIlT11rY8bf5WTwuQ+IVCE+BgxBdSRAj7Q+2QT17NIUhpULU5COmo1ZFF
 u5NCuHa2GwF5nH/59v2ttxbSNh/xsj0ZRpEFmFeJf9vyfNv/POEa1tsuHJUE7J0Ba3pf
 4xu3T0RYUYFyy59a2WpSExbJCXjR9LH4xHKcMpEF61ma5P7gpMuw1DPS8X/VeBSViL5B
 J6nqu2fGnlUlYMYj5/ufcsU9Uw0RCS4N9xVjYs1Vp22kXIPwxoOWlwJMHA7ET1ldwciO
 yRWYKY93wvHOn8KnitdyfqKLGqOAgUaxI+XIV3tmWyBQZLc0MAzfRajYNq/Io70Bm7o5
 qBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760950408; x=1761555208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQR+VfsEYRv4jYuvJa5HsMcpujaZmaRmeQD1rcR3hzs=;
 b=hEZoVCjne4MAaaVjodd+NSjVKdicJ0/O8QROSgSIfTHlHXZjALM6bsTwujALlfNDkC
 l2dmOAXsaOKT2pu2mb1LT05WCbeTaZG6vWdvJ0wfkXiRq4ReGqtUlHb//mku8uUW3YIh
 Pc+/SPc8Exgb2GM82Rv2kqoi1e20GmFrdFVEcqKu/L6zGwyy+bu42AaEYfY2OB+zIF8E
 Zwl1a1BSFNt5AMXfvu7BgnG/sjayY9PCYzEMIoO83MxrLQz4apWQ5ixKQI751+bTO05M
 wCqXpqeFahSDszY/AS8OOrqYShqya/Pe0GzSQMZ4ATF9X88i9IUrNgB7v76vUreVK+ey
 jDSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc4uq+ffgOVEY2knfXlCk6tjAJq5CCuWX88xG4fXN0/TYn/kgqv9Cbmgm/CJDcXFgZ07hM+IZzYH4L@nongnu.org
X-Gm-Message-State: AOJu0Yzw7bSwvBde0TahzM+njuViFmbMkEng6f4xjDKxYYheqDonPBis
 3HzU2bc6C9MmFMGTLhUeAWlmN7P1UjZLa9lkpfAyb6aRlZMP1uIQFwwqH+00lD94n+8=
X-Gm-Gg: ASbGncv881z7CB9YSdmNbWi/L2y4CFxtcmYSLN0Id/lTgAVl9LmFku9hcPyz2TaJHsr
 hmMJ1yPpmpQKo1BT/Z1Ur6VlbDoEKdo0V9+I9sj/LN8IdbfFdgkDYXBOVm/4UbTrwnr+f3zQLMS
 58RtOcalYBL9+GEDbIXrsNM94hq93M9FejkadDnzOUvBJTiRb3CtlORypIXhQFDsgUmvt1CchIb
 LhCnpqSf65/2GqLVzKYSh5nVbuzohAOVazSqoRbiOipPVuh5Oop3rwt6OxB6nH7PbFAQMF27uco
 gIq9/EcqlIHCscfNQTgTEIFSy7ANzbXQVrzm1dFvsScaHQQdl4VY7ncbkM7ug/OWFjzkdiUb5oa
 veMS61PagJMaZIOl9I/rsuvE7oHTGy4YYJfvdnBcapWhZ7qG0zLir6U9mZ0rNHSpIcOPWe3c+6K
 Xn9Q1XAb8/WlXR9hp329JZYEVAYZR3czx+whoq2ZHOeto=
X-Google-Smtp-Source: AGHT+IGL0HOn9j/ngMoYUVq51WwNmzCSrhEQCFp5rOGL/1+/z6e4uIfhLGqRz5BqRNlI7471UuqsgA==
X-Received: by 2002:a05:6000:2888:b0:427:374:d91e with SMTP id
 ffacd0b85a97d-42704b4e139mr10369084f8f.11.1760950407779; 
 Mon, 20 Oct 2025 01:53:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9853sm14153900f8f.33.2025.10.20.01.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:53:27 -0700 (PDT)
Message-ID: <2ae1a2ba-74b6-4786-9001-29f292d7f144@linaro.org>
Date: Mon, 20 Oct 2025 10:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] hw/ppc/pegasos2: Add bus frequency to machine
 state
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <bb655f2827b35951a76d2251f71382c0e7f31d2c.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bb655f2827b35951a76d2251f71382c0e7f31d2c.1760798392.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 18/10/25 17:11, BALATON Zoltan wrote:
> Store the bus frequency in the machine state and set it from instance
> init method.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index f7999520e4..ae3f01231d 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -55,8 +55,6 @@
>   #define H_PRIVILEGE  -3  /* Caller not privileged */
>   #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or conflicting */
>   
> -#define BUS_FREQ_HZ 133333333
> -
>   #define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
>   OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
>   
> @@ -66,6 +64,7 @@ struct PegasosMachineState {
>       PowerPCCPU *cpu;
>       DeviceState *nb; /* north bridge */
>       DeviceState *sb; /* south bridge */
> +    int bus_freq_hz;

IMHO this field belongs to PegasosMachineClass, being read-only.

>       IRQState pci_irqs[PCI_NUM_PINS];
>       OrIRQState orirq[PCI_NUM_PINS];
>       qemu_irq mv_pirq[PCI_NUM_PINS];


> +static void pegasos2_init(Object *obj)
> +{
> +    PegasosMachineState *pm = PEGASOS_MACHINE(obj);
> +
> +    pm->bus_freq_hz = 133333333;
> +}
> +
>   static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -610,7 +616,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
>       VofMachineIfClass *vmc = VOF_MACHINE_CLASS(oc);
>   
>       mc->desc = "Genesi/bPlan Pegasos II";
> -    mc->init = pegasos2_init;
> +    mc->init = pegasos_init;
>       mc->reset = pegasos2_machine_reset;
>       mc->block_default_type = IF_IDE;
>       mc->default_boot_order = "cd";
> @@ -640,6 +646,7 @@ static const TypeInfo pegasos_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("pegasos2"),
>           .parent        = TYPE_PEGASOS_MACHINE,
>           .class_init    = pegasos2_machine_class_init,
> +        .instance_init = pegasos2_init,
>           .interfaces = (const InterfaceInfo[]) {
>                 { TYPE_PPC_VIRTUAL_HYPERVISOR },
>                 { TYPE_VOF_MACHINE_IF },

If you want pegasos2_init(), move the definition here to avoid churn
in patch #12.

