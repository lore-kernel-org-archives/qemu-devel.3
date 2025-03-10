Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD23C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfUj-0004ln-Rs; Mon, 10 Mar 2025 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1trfUZ-0004eA-RQ; Mon, 10 Mar 2025 11:56:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1trfUU-0005zF-Ik; Mon, 10 Mar 2025 11:56:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso6473204a91.3; 
 Mon, 10 Mar 2025 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741622185; x=1742226985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=8Vi5Sg99YPVeh5AfwVvgVpAirn+FiFtAF6KtRUAriZk=;
 b=Xfo0vTAsppKGbQcSLUp6QgHGqnVdRXozbEnlJkMW++icyZxBKmjBtGPsln/1D8WRsY
 5HNZNpvtyNE3j9Yva4KFyA9MfPySzkKBlydVfUV7IpvpMMHdqGDUfZJ6phTrjNIuaGO0
 YBYJSySiIUk1c7HGkOQ0xmIEgEWkB1PMeGXXZPBmjjCD4xceYX31awa3V0SUbZBJ6llO
 TDES6lT08BaaqHhJeOg6QnQcTLYEbiUg2iR8UvJ3iBmBmLHAF3cohvDWrsvKvN5o1DTl
 n8vMscjYZgNuFDrZGR7Ql+kh9mtV5eVYCj/hV/x13DqY28+W6QCTezSvSGNjbe0hsNZL
 nRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622185; x=1742226985;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Vi5Sg99YPVeh5AfwVvgVpAirn+FiFtAF6KtRUAriZk=;
 b=s7N7WJ0/1ft1zl0UC0iitV+bToa4quW48BnWz1dqANbEkDSWq2LAQEdeu7+rS1r05s
 EgD+OoKBJARvbzse3AKQvoTky9jQy0LjYtnMBNF9xy2RcTQ/IT5iyocMcNkRymjmgad/
 EChu2hmmFRqz2rHVxUrVjVgCozNjDuPzg4L6wmLgC0xt6UBMQ2SKFNcsp6JaJtIAGUsl
 6EiE9WBjFbG0qAR6Ijp0DqblzXsstUOjYF+Py56kmalXNQhSSiKyGwozmkYOFJvQgsYi
 1WjW+NGMx3vjWUg4VV5z6qlHAPXnG15G9/+m1WwkNx6tuzU8CenVpmTlI5w01Ig/IZpq
 zbrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSxN4phKubVbOrQcbKyGBC4ixwzwUIi91kcpruZri8Lqn3sD7TUtyddBRUUe2b/k1Sjc1XrLK3p1txug==@nongnu.org,
 AJvYcCUUAnNpVS4ZCIIJK33khWZKjZRpZYnKT1HlIvXa7qnOddFcXXtndmQ84MHztgzlen48oRSIwYMlk/E=@nongnu.org,
 AJvYcCWhAcakJVMs85yNekQOecXVrqxcVFm1ug3y0NPn2m/096xefv5EmPA0VH4ZTO8nI42TG6k4gvt0Iw==@nongnu.org
X-Gm-Message-State: AOJu0Yzh6rltp2V4ZQBgV9AuLhcb7qxXgqWnyzI0RhwdpEbIsHyNr6DF
 /CPXY5jeMV32rWUYzr+miQ4520M0KBIv+XpBA6MiYtAD9J8Mqqk9
X-Gm-Gg: ASbGncvWEj+aSaepaKLvJMKsSLXMykoKcMQBRHM6TpwfoFaUfHhuV5gWFnQF+/4hzBb
 unQt1Fk8NpnYO63e7c5ABAOYSepGF8zHWzPpVdU7QJKoWObglmVOB/lyyCLEOyzTy+M5RBRpEY7
 3dKkYSya+YaVA+0e3arL/dKZGLHE7/BvLhk007Y+OTE8i4no6GsKUv1FHWSEAywgM3fQ8lGzL4k
 Jy5SpGEiFYNUrIuRaaGjdtvINyhz5mziCPnsWXZsdRFxBEvV2LoQ7s91MOBL78xTxtmVqOzGBz4
 wMfum7z2IfG5Tvo4mLLr4glFhoKtxFxOBotmDg9a8OXGNblph0YqCdePgAQOga9uhTQ01/CPiZT
 ZK9m8b8OJa1DjGGTZ+g==
X-Google-Smtp-Source: AGHT+IEtEIPDrrK+QCcaHfWQ1uzmMM36/HGT9d0rqsFZQpSPXKiuWYaOYaGYE46JQDoEGc/dEmS1gQ==
X-Received: by 2002:a17:90b:4c4a:b0:2ff:7ad4:77b1 with SMTP id
 98e67ed59e1d1-2ff7ce4f260mr23031651a91.2.1741622184736; 
 Mon, 10 Mar 2025 08:56:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e823ba3sm11266117a91.47.2025.03.10.08.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:56:24 -0700 (PDT)
Message-ID: <6ecc3790-e5a1-4d02-aefa-c6d632936a6a@roeck-us.net>
Date: Mon, 10 Mar 2025 08:56:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-15-philmd@linaro.org>
 <d97b9dd5-e569-636d-8ee7-b1a48c402429@eik.bme.hu>
 <0fa157de-ee4e-4b7f-b08e-bdf65e1840ad@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0fa157de-ee4e-4b7f-b08e-bdf65e1840ad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/25 08:27, Philippe Mathieu-Daudé wrote:
> On 10/3/25 15:09, BALATON Zoltan wrote:
>> On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> The previous commit removed the single use of instance
>>> setting the "endianness" property.
>>>
>>> Since classes can register their io_ops with correct
>>> endianness, no need to support different ones.
>>>
>>> Remove the code related to SDHCIState::endianess field.
>>>
>>> Remove the now unused SDHCIState::io_ops field, since we
>>> directly use the class one.
>>>
>>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/sd/sdhci-internal.h |  1 -
>>> include/hw/sd/sdhci.h  |  2 --
>>> hw/sd/sdhci.c          | 33 +++------------------------------
>>> 3 files changed, 3 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>>> index d99a8493db2..e4da6c831d1 100644
>>> --- a/hw/sd/sdhci-internal.h
>>> +++ b/hw/sd/sdhci-internal.h
>>> @@ -308,7 +308,6 @@ extern const VMStateDescription sdhci_vmstate;
>>> #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
>>>
>>> #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>> -    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
>>>     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
>>>     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
>>>     \
>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>> index e8fced5eedc..1016a5b5b77 100644
>>> --- a/include/hw/sd/sdhci.h
>>> +++ b/include/hw/sd/sdhci.h
>>> @@ -54,7 +54,6 @@ struct SDHCIState {
>>>     AddressSpace sysbus_dma_as;
>>>     AddressSpace *dma_as;
>>>     MemoryRegion *dma_mr;
>>> -    const MemoryRegionOps *io_ops;
>>>
>>>     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>>>     QEMUTimer *transfer_timer;
>>> @@ -105,7 +104,6 @@ struct SDHCIState {
>>>
>>>     /* Configurable properties */
>>>     uint32_t quirks;
>>> -    uint8_t endianness;
>>>     uint8_t sd_spec_version;
>>>     uint8_t uhs_mode;
>>> };
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 47e4bd1a610..cbb9f4ae8c0 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -1391,17 +1391,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>> }
>>>
>>> static const MemoryRegionOps sdhci_mmio_le_ops = {
>>> -    .read = sdhci_read,
>>> -    .write = sdhci_write,
>>> -    .valid = {
>>> -        .min_access_size = 1,
>>> -        .max_access_size = 4,
>>> -        .unaligned = false
>>> -    },
>>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>>> -};
>>> -
>>> -static const MemoryRegionOps sdhci_mmio_be_ops = {
>>>     .read = sdhci_read,
>>>     .write = sdhci_write,
>>>     .impl = {
>>> @@ -1413,7 +1402,7 @@ static const MemoryRegionOps sdhci_mmio_be_ops = {
>>>         .max_access_size = 4,
>>>         .unaligned = false
>>>     },
>>> -    .endianness = DEVICE_BIG_ENDIAN,
>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>> };
>>>
>>> static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>>> @@ -1467,23 +1456,6 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>     SDHCIClass *sc = s->sc;
>>>     const char *class_name = object_get_typename(OBJECT(s));
>>>
>>> -    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
>>> -    switch (s->endianness) {
>>> -    case DEVICE_LITTLE_ENDIAN:
>>> -        /* s->io_ops is little endian by default */
>>> -        break;
>>> -    case DEVICE_BIG_ENDIAN:
>>> -        if (s->io_ops != &sdhci_mmio_le_ops) {
>>> -            error_setg(errp, "SD controller doesn't support big endianness");
>>> -            return;
>>> -        }
>>> -        s->io_ops = &sdhci_mmio_be_ops;
>>> -        break;
>>> -    default:
>>> -        error_setg(errp, "Incorrect endianness");
>>> -        return;
>>> -    }
>>> -
>>>     sdhci_init_readonly_registers(s, errp);
>>>     if (*errp) {
>>>         return;
>>> @@ -1493,7 +1465,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>     s->fifo_buffer = g_malloc0(s->buf_maxsz);
>>>
>>>     assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
>>> -    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, class_name,
>>> +    memory_region_init_io(&s->iomem, OBJECT(s), sc->io_ops, s, class_name,
>>>                           sc->iomem_size);
>>> }
>>>
>>> @@ -1578,6 +1550,7 @@ void sdhci_common_class_init(ObjectClass *klass, const void *data)
>>>     dc->vmsd = &sdhci_vmstate;
>>>     device_class_set_legacy_reset(dc, sdhci_poweron_reset);
>>>
>>> +    sc->io_ops = &sdhci_mmio_le_ops;
>>
>> You call common_class_init in subclass class_inits last so this would overwrite what subclass has set, doesn't it? I think you either have to change order in subclass class_init methods or not set this here.
> 
> Oops... I'm surprised tests passed. Do we have coverage for sdhci on
> e500 machines? Or are we only testing them via virtio PCI block storage?

Not sure if that is what you are asking, but I have been testing it with
sdhci-pci for a long time (not this series, though).

Guenter


