Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A6C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBI-0004iW-Ho; Tue, 08 Jul 2025 16:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDjS-0000jF-TB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:02 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDjL-0006CV-96
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:11:56 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73cddf31c47so521952a34.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001903; x=1752606703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tta5Mdv0u4HyunTJLNPVqLhMBNwh/iE+JErBOo/o8Yc=;
 b=DRyVxL7zFoozO2ThJgLCVWoBtU8pK2HRQQ/5GR7wUVRWf9aS4SDhKHop+rsSr0caks
 +8GFhiXnMHIjGOzQ/FpvgC5xoDVd20C9YZp841kkbGHHVfXrLcQ3ecKaYFVonCsIv0V8
 Dg+Hy8JWPOoEOdpkMr+t8y2swwSLgqZ/fuapTC1gnKSxS2y6RJ3ejqGv7FTHZlkqCflW
 Z6g1Qg1Qlfz4c3P3wwrIl4Pwye+hjLLpNme3AbWFo0H9076nyOT6oZW28Uwir645wizt
 P60X+QrzBbPaET8PYqzh5b5S3/MrVTWRwfn2IGzE+Kuc3QLWA7XvY6srfi69OykdwsKh
 JMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001903; x=1752606703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tta5Mdv0u4HyunTJLNPVqLhMBNwh/iE+JErBOo/o8Yc=;
 b=NSCcLEb5ZWnN0/I38EP4vdj7tuJNrFBAIwoxLXLv2ERvUzQnXYJGEw0tARYlVlUDMf
 iscs0EaVKdzChegwcChabCxKmOtqyVpjS07o2uU9tkrciyWvBUlVjvEkTRiyQ8zqvJT8
 T4HE6OW4nb6P4E61ey2qjYxqkSFttTgUtCRIMAXWPMP6xscelAWaMDKSNXjpAv9UhPLN
 mEdC3ry9GZtHWkJQ2IAcia0EzR1qT89xoBjNw/lOZsKb9jkrGuIyB7eRE55s95ekN3DG
 B4BLYuITOBhUa8Uaoy54vbXhzAIuU8tEqSitGVtmC08vBg4XV/qTrJw3pODJjDzcYkhF
 +PuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHc3fwkPe8dg0JXQKQE8nn7K52WpsfS0uHKTUkchd/0tXu8KP5ZfYtmz0MKnDnh5GwZsEHJFCGpZx0@nongnu.org
X-Gm-Message-State: AOJu0Yza4dzGSYnfNmHEj6h+RCY/J9aEpEApIMam/bigjrpdFQdZoYOE
 C0h5fZsfFPHsBIOtCz1bPLx+sM7Reinh6if9DO3tzUQNUyHBEU0KgkMTV3VL3zWjCvDDP5EwVEM
 gy7mz
X-Gm-Gg: ASbGncuDkl6cGKgXlsZgWVgjB0g5O++eZ0bBoQWGXiw9d9mHuoPy1ChhHwUIxUIjW2Q
 awBZxSvtzW0UtvD+p6JgIZ8vFCkdfTH8D5g34GKLJriU+XoH8yeUfd0dxtRtcvYmxQETCGRSv5q
 TMp/FlXc57ew5iCujHUL/5w+QwhFNY0QwthRbLTsL4+pPVXJDK/upzyjemjKUFesXCy60r0GOQt
 iFqvDXhQDHzq91wJ5UruqZr7f+Dr7fZfhGkv0O+knIdcaonu0QsSZ06vq7O9Dj/aesew2invd7W
 5CuftUFXpvHKE4taFdT3wCWb4Stoib2mPtqzPWjzYBBN7B+k/S2LccvVb7jHXzzN61JLUYuFUWg
 =
X-Google-Smtp-Source: AGHT+IGzGrv5wUVsy6z+dn1Bx5Y2gV1AqOR0Neyx1aJCMXa8JqNaYvtMeYEI5OcqDHRG/gCYni+m8g==
X-Received: by 2002:a17:902:f644:b0:234:d399:f948 with SMTP id
 d9443c01a7336-23c875428a0mr219465405ad.33.1751996129198; 
 Tue, 08 Jul 2025 10:35:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8459c6e5sm122901325ad.227.2025.07.08.10.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:35:28 -0700 (PDT)
Message-ID: <c7af688f-6400-464a-b6ee-f5ae99d827a1@linaro.org>
Date: Tue, 8 Jul 2025 10:35:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 7/8] qemu: Declare all load/store helper in
 'qemu/bswap.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
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
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x334.google.com
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


