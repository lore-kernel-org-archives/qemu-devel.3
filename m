Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B31C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpZ0-0007kY-6l; Mon, 07 Jul 2025 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpXw-0003Mi-T8
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:22:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpXt-0005QK-TW
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:22:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4530921461aso23905845e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908944; x=1752513744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=paYtJ7v2X2U4yptAsJY82VjkgnlJ/HM86V8loisqpec=;
 b=Y0SzYz7rXG6HuwxInygYA426JzHY5lXAZFSN0gSDyKJsu65kogfLYYNpOqO6Q8IUk0
 GfGKRRpBs74bjEt5hEkBSgfXOwWIdcsOR6yAIuZKdg30Zad3VXLpHGZL1Dl1NchSX8BQ
 IYO992eJHBW5ssnNqOAdZRjfwhgKz+vt4J0n2VlfdKJHPltHYnsdv5WimWnQJ90F/KDy
 vWm6yHTFxNxBBDQmibUvaLe0AqN3ySkh+UUAc67qND8s1Em44r2+LnSqHO1n4GPGjyeq
 oo/Y6e6d5MMTAegqMowXKnJ99AbUy++hf8ujCX6hs8oTU9NOR7iNzxE0c3B8sXoGtqy6
 3rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908944; x=1752513744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=paYtJ7v2X2U4yptAsJY82VjkgnlJ/HM86V8loisqpec=;
 b=bGnOIUONSePcJ6mCj+TYWfDoef8A4h9g8Pr1GmlJTpLRmDeasB4vtcgmwg0251gkZs
 vCQPuKHJHpy9SX+OLQpy7m7XMC4K2sT0oF/b7S2dVgtD5NCrb7UhNWvVBG9CUVgsTt0p
 aFGFQNHX6sx7gywSe+U/gx1+KMT0OrRFdgjCBKqMPyyt5lczpSRHz/fTz+U8a7CBCY5s
 GrSSlVuyPe4Yacok2Pj0nlYv1wY8EFmet5uPiob/HhN5ieEGJCtwzMHAXfrRBqrdgp+3
 GFhZvGkS40ZYhg7hQG2/fmjnZu835xFwa+sVFiaJqkT8YcEtUwuaX/h+rub53IyiJj/x
 ou3Q==
X-Gm-Message-State: AOJu0Yw2rPCENeQPu7O4ewOwMRBu0sIct9vhWLIzUtzlIrWFdmcDVLkw
 vORP/WM65VtLDXZ7VMXqzrg3UBf/3fGQrpGu2WK2x/h8/yOmF0nfEHyFz2JX+DmG5RJF5AWnLoX
 QTvwQjz8=
X-Gm-Gg: ASbGncvBJhAbjNFU4E+5dV799yhqb00dX8P+qbH+HG2O2hABrvtLWIOWw58jLtAZvum
 FxN102IWr1xsDUtpGVz0wm5EdcynnpVDiN2WHNGBWWrIYz6MTrkLeuLn5dr+LGWH2scxQrscXXT
 DskMP/zk+q6nIQAvJeWbXchiJTkSggo+9fl6DCYyi4cuAZOz4sXAIXDoD2XrEh2jx8ilJn6l3B2
 UqPcdSzRzPNZbd7S9PV4DjZPzO1ZZIog0nkWn2dFmcVq9ZnFjvdiETE9lXuNal79f7BNiS+ne1h
 ApR72YV3xL3Bxt7CrBYxRKj9NUYDUey56PHxphY9pH90MyJTT24piA0E7p8UlHLlARw0evhc5o2
 VfTAzBgXk8IosoKm44C9GBllUwrhT7g==
X-Google-Smtp-Source: AGHT+IHefGuJAF517+mai6M7mCSdD6JNqKqA01ahRarb/HFaXhq8n/h41cFGAKxBBv7VpLzADCFpiA==
X-Received: by 2002:a05:6000:41e3:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3b49aa741edmr7243779f8f.31.1751908943906; 
 Mon, 07 Jul 2025 10:22:23 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030cdf5sm10629027f8f.1.2025.07.07.10.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 10:22:23 -0700 (PDT)
Message-ID: <028f0166-32ea-4a9e-ae4c-1221aeb4c6d5@linaro.org>
Date: Mon, 7 Jul 2025 19:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v6 08/14] qemu: Declare all load/store
 helpert in 'qemu/bswap.h'
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 Helge Deller <deller@gmx.de>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Bernhard Beschow <shentey@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-9-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707172009.3884-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/7/25 19:20, Philippe Mathieu-Daudé wrote:

Oops typo "helper" in subject.

> Restrict "exec/tswap.h" to the tswap*() methods,
> move the load/store helpers with the other ones
> declared in "qemu/bswap.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tswap.h                 | 70 --------------------------
>   include/qemu/bswap.h                 | 73 ++++++++++++++++++++++++++++
>   include/system/memory.h              |  1 -
>   include/user/abitypes.h              |  1 -
>   target/ppc/mmu-hash64.h              |  2 -
>   hw/acpi/bios-linker-loader.c         |  2 -
>   hw/arm/allwinner-r40.c               |  1 -
>   hw/arm/boot.c                        |  2 +
>   hw/arm/npcm7xx.c                     |  2 +-
>   hw/block/hd-geometry.c               |  1 -
>   hw/char/riscv_htif.c                 |  1 -
>   hw/cxl/cxl-events.c                  |  2 -
>   hw/display/artist.c                  |  1 +
>   hw/display/ati.c                     |  1 +
>   hw/net/can/ctucan_core.c             |  1 -
>   hw/net/lan9118.c                     |  1 +
>   hw/net/rtl8139.c                     |  1 +
>   hw/net/vmxnet3.c                     |  1 -
>   hw/pci-host/gt64120.c                |  1 +
>   hw/pci-host/pnv_phb3.c               |  1 +
>   hw/pci-host/pnv_phb4.c               |  1 +
>   hw/pci-host/ppce500.c                |  1 -
>   hw/pci-host/sh_pci.c                 |  1 -
>   hw/s390x/s390-pci-inst.c             |  1 +
>   hw/sensor/lsm303dlhc_mag.c           |  1 -
>   hw/smbios/smbios.c                   |  1 +
>   hw/vfio/migration-multifd.c          |  1 -
>   hw/virtio/virtio-pci.c               |  1 +
>   hw/vmapple/virtio-blk.c              |  1 -
>   target/arm/cpu.c                     |  1 -
>   target/i386/tcg/system/excp_helper.c |  1 -
>   target/i386/xsave_helper.c           |  1 -
>   target/riscv/vector_helper.c         |  1 -
>   tests/tcg/plugins/mem.c              |  1 +
>   34 files changed, 87 insertions(+), 93 deletions(-)


