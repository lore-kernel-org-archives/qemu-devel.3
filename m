Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCEEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPrc-0003eD-P3; Tue, 03 Jun 2025 07:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPra-0003b8-NY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:31:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPrY-0005vp-MP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:31:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so48060715e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748950282; x=1749555082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKOwEl362d4twqQkTyMBWKi4e+TfPV5Vj4tvLOsMHV8=;
 b=Bqua7k4VCZGYPQ4uqlkOfoRlfBV6Kq7EpLnzOj8SU79pbq6p0Sd6uuwMs8tSIUm+kZ
 Ih2KHxjpgc9qj6XUbzW91W72H4sacH93QxRzoQ92Z0OvnpTAzySAx7+a3Kjpc1F/lNrW
 3xg1+aLMZFClwxDz2TMSjHhIWyvX/+Kf0gG/srm25Q5Fd/09vQnSzRFP6C84vUlxoWMm
 aS1H3gyc5NCoPvWF4DFHATq0XosS7F2oGuwrQcLTH54Cq2iR0nD2iGcx3WmG7mJW1q+t
 TPcflNFIsKpD2xaKQU8gA9fy/z2IUZpvz6a7W2CHJu5EONQ388+BKcE/teQjiW57csY7
 AaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950282; x=1749555082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKOwEl362d4twqQkTyMBWKi4e+TfPV5Vj4tvLOsMHV8=;
 b=UMzrAIMiUpKwBZH7yrlqPhuE4gSOnHgnQv3Y6etKbUZGqe6xmCFeWqUILu3Qz+nmBF
 u+2vcpTnOiQzqmkYVEKVsogOB1K8pPTCneGxhCcOqzkmlzkbZcXrS8A6VYFdo+jUsSTN
 vbkflyHUOfGZy5p40lHU6yYvh58Fl+j2mXauMdCoy7tnIqH+Ewf+iRVb4w50O9WNQ4Aw
 IWXTYhC4CjKOgQgqIUBk356BT2pDcoYSsTxN0SDAYuUw3AUI7gHyqxUzEMbpwQ8wRGpP
 IiYlsW/Y75O2GzEmR0GlvjmVB9xdUjKyRdE1jv+zv51BOdPSPN564WfKL0OiCDfAX+Zn
 cSDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJAwj1juxmMYZFhFk+yeEPRSmwi4mFxhiflvunEVSAL5FdMzxGOLcE7X0lN2DlNflq0QY/k17EYh8f@nongnu.org
X-Gm-Message-State: AOJu0YzNNPrezz5qWh+cnEZ4ZeujIlPPWzDNE1TWVkW5FGZhLmeuazdt
 SYNDgUSvzFp/TZ7NET1CLpZyRNO6XnQ5Jq+b8UpURjAIwWt5clN8TpiBDQvpf+etjic=
X-Gm-Gg: ASbGncs1+xreSWyFr2iD2o8i+9mxVpRq0OGvXphOhM6Z1DvQMcA9NG0goPtn9TcFtSW
 wPKhipSGBJKq7MmH3SHZb6QobaOJH5dXJj99tGx0QD/pfA6ppbQX74VnK6oVWo6wC/hFZeakZoI
 fZK+QA/Vq+83p+UXvZETRnX0t/uCH1jxeXqMdI6RuLBKZuCBCxCASHR8xz4dPeHIVUwiG0zuy8G
 +BrE0Q/i02Drr3HbpVPPdWC0LT7fBybj0kjLPGV4F2Z4HcCFAUiYuVkpvdBek2gVgS22LQ/xDBv
 KDDyrivb8m4oE8rN29Q1xd7vRzNyNeVs3PBpU7Y0yhDAOl5nw9f+IWoBaYNRCVshg3zD7wTPy2b
 bZILPwJnmP9EN4MmnJ76PW9A3
X-Google-Smtp-Source: AGHT+IHyVCdfbxqsNUrBhmOkUpEETqQc9Hk6tRcouD8jz6k9+k/WMjSmy6D5KlL3KTkK2QhQuWwNAQ==
X-Received: by 2002:a05:600c:64ca:b0:43d:1b95:6d0e with SMTP id
 5b1f17b1804b1-451221a31aamr90775565e9.23.1748950282601; 
 Tue, 03 Jun 2025 04:31:22 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006946sm158019135e9.31.2025.06.03.04.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:31:21 -0700 (PDT)
Message-ID: <0940128b-f6b4-41bf-9dc7-40e1bd953047@linaro.org>
Date: Tue, 3 Jun 2025 13:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] hw/pci-host/raven: Remove is-legacy-prep property
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <0d41c18a8831bd4c8b0948eda3ef8f60f5a311f3.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0d41c18a8831bd4c8b0948eda3ef8f60f5a311f3.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> This was a workaround for the prep machine that was removed 5 years
> ago so this is no longer needed.
> 
> Fixes: b2ce76a073 (hw/ppc/prep: Remove the deprecated "prep" machine
>         and the OpenHackware BIOS)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 21f7ca65e0..b78a8f32d3 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -75,7 +75,6 @@ struct PRePPCIState {
>       RavenPCIState pci_dev;
>   
>       int contiguous_map;
> -    bool is_legacy_prep;
>   };
>   
>   #define BIOS_SIZE (1 * MiB)
> @@ -243,22 +242,18 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       MemoryRegion *address_space_mem = get_system_memory();
>       int i;
>   
> -    if (s->is_legacy_prep) {
> -        for (i = 0; i < PCI_NUM_PINS; i++) {
> -            sysbus_init_irq(dev, &s->pci_irqs[i]);
> -        }
> -    } else {
> -        /* According to PReP specification section 6.1.6 "System Interrupt
> -         * Assignments", all PCI interrupts are routed via IRQ 15 */
> -        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
> -        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
> -                                &error_fatal);
> -        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
> -        sysbus_init_irq(dev, &s->or_irq->out_irq);
> -
> -        for (i = 0; i < PCI_NUM_PINS; i++) {
> -            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
> -        }
> +    /*
> +     * According to PReP specification section 6.1.6 "System Interrupt
> +     * Assignments", all PCI interrupts are routed via IRQ 15
> +     */
> +    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
> +    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
> +                            &error_fatal);
> +    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
> +    sysbus_init_irq(dev, &s->or_irq->out_irq);
> +
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
>       }
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
> @@ -426,9 +421,6 @@ static const Property raven_pcihost_properties[] = {
>       DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
>                          EM_NONE),
>       DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
> -    /* Temporary workaround until legacy prep machine is removed */
> -    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
> -                     false),
>   };
>   
>   static void raven_pcihost_class_init(ObjectClass *klass, const void *data)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


