Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BACF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sspbP-0003DR-1r; Mon, 23 Sep 2024 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sspbL-0003CN-KM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 16:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sspbJ-0008R4-Ke
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 16:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727123042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhbiwiJFCwKh1cedh93mYPGzqn0I6CcDg91v+sJv4qk=;
 b=SbK08VuSyupr1+uG6FxdCwKMChDpurSPrRjlrpxEZqRezWLX7jzuFy9Oeu+6XE5aNO4qN+
 ZPF9ViSwzkWHYXUBhZNog418SE1RN+5CtF2nAc/z00I6YJxm8xJpT63AqrQydA2enP+z7k
 tucpc/PadkVcn7JNDjnge0A4BvhoHuo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-B8CGICKcPfWmh_Pn4XQfSw-1; Mon, 23 Sep 2024 16:23:59 -0400
X-MC-Unique: B8CGICKcPfWmh_Pn4XQfSw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a8d2ecdf414so353614566b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 13:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123038; x=1727727838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhbiwiJFCwKh1cedh93mYPGzqn0I6CcDg91v+sJv4qk=;
 b=dqtR89uXiG0DRn+juC3HYq/W1o1Ojs+4j9PuNA/cXWZ8NUqq0EEHKKrkDga/BCgn8Z
 r3qRSmnD6PK49Elco3Qh4G/SsuxaZvHqHdcm9VXFKKurnh9acTzWJX5fMVUca2WM/1Q0
 TxMtJ3AXxQAAdoldj9q6WYwd0/nhSFEjtx72mX8kO8/zgZ/qp0xxMLbpRjKc/WrU5Rd9
 OrxiF70dHbXg1kztSoyVIp0zYY1A1dkLu/SrOkLJpqOBrzc7sd6rpQdrOVAnj1nCYWXA
 LHG2n3dM8eK4rlYo4GawxEoI624SkjI6fSbWdae4KJaiuaB4/ruixZzSGNrOFz336v3E
 rDRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCo/olzHgqzO8hRaZhtIKFJWni1yc9rR4yknS0L21e/cCwf4lxCsGQquuWbKfcxL07Q7U77EiS/IMF@nongnu.org
X-Gm-Message-State: AOJu0YwI1mdYc/ZtwU6C+R9re/Ex9lHKt0ebPcuishUCxAldEIKmwKcX
 3SPVC2F0O7adSMjAz/vsUMvg+PaDQaPMx9OqRHHLQbasDjvdcaU3Hxf++waAFX5ZyxkZcTT5lmK
 BGODiSR3kEbmU6Of3DYh86WW5/2z9wguhZOT2IlNbsDaF2vpChKOZ
X-Received: by 2002:a17:907:e615:b0:a8d:7046:a1bd with SMTP id
 a640c23a62f3a-a90d501ad10mr1109491966b.28.1727123038058; 
 Mon, 23 Sep 2024 13:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYPVeG4oiv5wzoxvrbneEdheUrkSFcDqe3AeW6k3U2Ifv2LIepuLd5EExlDElKoDOU/6WN1g==
X-Received: by 2002:a17:907:e615:b0:a8d:7046:a1bd with SMTP id
 a640c23a62f3a-a90d501ad10mr1109489566b.28.1727123037573; 
 Mon, 23 Sep 2024 13:23:57 -0700 (PDT)
Received: from [10.5.51.18] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a908d2305e3sm1037327466b.186.2024.09.23.13.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 13:23:57 -0700 (PDT)
Message-ID: <cbc6d0f4-ab9d-46c5-862f-aac83c91af3a@redhat.com>
Date: Mon, 23 Sep 2024 22:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] E500 Cleanup
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Bernhard,

On 9/23/24 11:29, Bernhard Beschow wrote:
> This series is part of a bigger series exploring data-driven machine creation
> using device tree blobs on top of the e500 machines [1]. It contains patches to
> make this exploration easier which are also expected to provide value in
> themselves.
> 
> The cleanup starts with the e500 machine class itself, then proceeds with
> machine-specific device models and concludes with more or less loosely related
> devices. Device cleanup mostly consists of using the DEFINE_TYPES() macro.

Since you recently took a look at the machine models, would you
be willing to take over maintenance of the e500 ? It shouldn't
be an enormous amount of work.

Thanks,

C.



> [1] https://github.com/shentok/qemu/tree/e500-fdt
> 
> Bernhard Beschow (23):
>    hw/ppc/e500: Do not leak struct boot_info
>    hw/ppc/e500: Reduce scope of env pointer
>    hw/ppc/e500: Prefer QOM cast
>    hw/ppc/e500: Remove unused "irqs" parameter
>    hw/ppc/e500: Add missing device tree properties to i2c controller node
>    hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>      resources
>    hw/ppc/e500: Extract ppce500_ccsr.c
>    hw/ppc/ppce500_ccsr: Log access to unimplemented registers
>    hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>    hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
>    hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>    hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>    hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>    hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>    hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>    hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>    hw/intc: Guard openpic_kvm.c by dedicated OPENPIC_KVM Kconfig switch
>    hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>    hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>    hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>    hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>    hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>    hw/vfio/platform: Let vfio_start_eventfd_injection() take
>      VFIOPlatformDevice pointer
> 
>   MAINTAINERS              |   2 +-
>   hw/ppc/e500-ccsr.h       |   2 +
>   hw/ppc/e500.h            |   8 +++
>   hw/block/pflash_cfi01.c  |  21 +++----
>   hw/gpio/mpc8xxx.c        |  22 +++-----
>   hw/i2c/mpc_i2c.c         |  29 +++++-----
>   hw/i2c/smbus_eeprom.c    |  19 +++----
>   hw/net/fsl_etsec/etsec.c |  22 +++-----
>   hw/pci-host/ppce500.c    |  54 ++++++++----------
>   hw/ppc/e500.c            |  61 +++++---------------
>   hw/ppc/mpc8544_guts.c    |  32 +++++++----
>   hw/ppc/ppce500_ccsr.c    |  67 ++++++++++++++++++++++
>   hw/rtc/ds1338.c          |  20 +++----
>   hw/sd/sdhci.c            |  62 +++++++++-----------
>   hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
>   hw/vfio/platform.c       |   7 +--
>   hw/i2c/trace-events      |   5 ++
>   hw/intc/Kconfig          |   4 ++
>   hw/intc/meson.build      |   3 +-
>   hw/ppc/meson.build       |   1 +
>   hw/ppc/trace-events      |   3 +
>   21 files changed, 285 insertions(+), 277 deletions(-)
>   create mode 100644 hw/ppc/ppce500_ccsr.c
> 


