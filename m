Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0AE8FDCD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWUR-00059w-Ix; Sat, 27 Dec 2025 10:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWUN-00059U-Br
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:45:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWUL-0007iU-Kv
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:45:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3699592f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850352; x=1767455152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fhUJ/Yk4QRjAoV7W75pmeUPDNM9P6XGiwppWO4+I1/U=;
 b=ATCOQjc3xKhS5PuZuU15OGUeaK458N7VCn0ute0dCpcS1nvRiR+mx/ZoMiofhGnqh0
 u7e59XGZAC8nF0HPMhPaWs893F9XScljJe60jb+qz9VFfeFMITK9YZMenm8LtbtJKnJq
 CUv36mAaI0p9RwLvv8Eu3l+56KGJHQHoWzzZSIKDFSBNM62VRRJU3qnUpRUBbLYAl+Je
 weDzzpvsDOuixmzKNXtkj4e9NnXcR5VWLeiVv61zXrtkFCEg97Ax217VfHeaqHUDs8na
 mKF2lISqUJI+s6YpFnXlX9ab9JmyveZkGCgC7ywksOWNeEttG/95Jdsho+t9XrsXNMB6
 PmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850352; x=1767455152;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fhUJ/Yk4QRjAoV7W75pmeUPDNM9P6XGiwppWO4+I1/U=;
 b=R6GpOkQkC6xe9appHsIvVldCbBsz12LJdGuHfT1kS9YLdLwx08DMvhpc8WRMVe3X80
 YRjksaaC6SlGN2z5jw0KnWmwtrEdbdeU6C9TMc7mAU2aAFFV7eWDfWK55G8Wv9bCeP4E
 0/dtgxY3QVzyJZSb0LrYfPkkSWZWhXp2VWT0Yw7sP7kq5r5astCBUbKGTQT2XKrQBxoW
 VAHN+0l/GjcFs2B+ySFY4lRfYsFRWB3IKPSycmfrc9aYbtekZwzelTukrbCAgwXwblp3
 UDSTqFxovt2g/2sQPm35gbsZZQvQUTXaKm+jN5dRn1fxPo0+W05fjNxTtEOtilA1oiSY
 GehQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoWl1J+44gvBamEbZ59QhENL5Ft8IRht+JEupOfxOHhFcsOsFJwtPcKK/FmTOV3Gom+7fL9KGTrNkR@nongnu.org
X-Gm-Message-State: AOJu0YxhZEXn0L4PXnmzuhac4kUBbVNb1ayg4FimqxVwJ241g9PnVb1q
 PudGNXuUDXuT9+WoEt3J39fszPseBxV6Ni5MSEmZZ5V0kfVhJAK8mj0TIGlwL30FfuE=
X-Gm-Gg: AY/fxX6e1zE6qTs/g2viJZpv0q04CUt2RnQ17YQ1tg/60+0/g8mO5e1xOyCBgnaF5pG
 z8erE7bpv+z2C9uvy8WvkxwJAFGXqVY5Dj9a3d9c9RbAv/EDi8vgQTF1L9Bgl/6gx2s7T7oCEZo
 aNnpORyEcznFFCv7VoqcaFAY95S6NmNwhXCHmN1UC35tcBdsV7LxVJ5gbNssp8cs5js0GRCgCnI
 Jpb11xfMB3Td2ZBmutt8ZDf6ivo0ArAyUtyCrXXtQMapsMQWRVo5l+JYxTTr19GeaHhcf5a8s5B
 WEnS0VKDgH8Zly3fQiaJzfqhO8hiyRqh9WAHYme+btdbVXp4WZUUtPy6OP7IYjqm4TAsiMQxqP8
 UGXON4xKhZa1mKFSW8Kl3HydARA5h/ct3v271ZW3700uFYN4IXPnyCSBFcei5xKFOBIL64Ji6YI
 BRMB487Dnq3KJgKD371ibmlihB4YVcEDG5aJDpyHt0Z70/QOLJzXQWT/zmEbDnbg==
X-Google-Smtp-Source: AGHT+IGpRzu6lROkV9M1vqOOrILtS4ToN8IdOrcE/LXInhyfDwe5xsQysujtSBqN2EMvFN8tpPxZqQ==
X-Received: by 2002:a5d:5887:0:b0:431:3bd:3781 with SMTP id
 ffacd0b85a97d-4324e4f935bmr32162947f8f.37.1766850351685; 
 Sat, 27 Dec 2025 07:45:51 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm52318442f8f.37.2025.12.27.07.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:45:51 -0800 (PST)
Message-ID: <f7dd1a94-c135-489f-857f-0b71f891e5fc@linaro.org>
Date: Sat, 27 Dec 2025 16:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 029/153] include: reorganize memory API headers
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-30-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227091622.20725-30-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Paolo,

On 27/12/25 10:14, Paolo Bonzini wrote:
> Move RAMBlock functions out of ram_addr.h and cpu-common.h;
> move memory API headers out of include/exec and into include/system.

I know you want the good of the project and make it evolve,
but TBH pushing your own unreviewed patches without looking
at others work in the same area is really demotivating, it
feel like you completely ignore us.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS                              |   2 +-
>   include/exec/cpu-common.h                |  74 -----------
>   include/exec/cputlb.h                    |   1 +
>   include/exec/translation-block.h         |   2 +
>   include/hw/core/qdev-properties-system.h |   1 +
>   include/hw/i2c/smbus_eeprom.h            |   2 +-
>   include/hw/xen/xen-hvm-common.h          |   1 +
>   include/system/balloon.h                 |   2 +-
>   include/system/block-ram-registrar.h     |   2 +-
>   include/system/iommufd.h                 |   2 +-
>   include/system/memory.h                  |  16 ++-
>   include/system/memory_mapping.h          |   4 +-
>   include/system/physmem.h                 |   2 +-
>   include/system/ram_addr.h                | 136 +++----------------
>   include/system/ramblock.h                | 160 ++++++++++++++++++++++-
>   include/{exec => system}/ramlist.h       |  10 +-
>   include/system/xen-mapcache.h            |   1 -
>   include/system/xen.h                     |   3 +-
>   migration/migration.h                    |   3 +-
>   migration/ram.h                          |   1 +
>   accel/mshv/mshv-all.c                    |   1 +
>   accel/tcg/cputlb.c                       |   2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c          |   1 +
>   backends/hostmem.c                       |   1 +
>   block/blkio.c                            |   2 +-
>   dump/dump.c                              |   1 +
>   hw/acpi/ghes.c                           |   1 +
>   hw/acpi/nvdimm.c                         |   1 +
>   hw/acpi/vmgenid.c                        |   1 +
>   hw/arm/omap1.c                           |   1 +
>   hw/audio/marvell_88w8618.c               |   1 +
>   hw/char/riscv_htif.c                     |   1 +
>   hw/core/cpu-common.c                     |   1 +
>   hw/core/machine-qmp-cmds.c               |   1 +
>   hw/core/numa.c                           |   3 +-
>   hw/display/exynos4210_fimd.c             |   1 +
>   hw/display/omap_lcdc.c                   |   1 +
>   hw/display/ramfb.c                       |   1 +
>   hw/display/vga.c                         |   1 +
>   hw/dma/i8257.c                           |   1 +
>   hw/dma/omap_dma.c                        |   1 +
>   hw/dma/rc4030.c                          |   1 +
>   hw/dma/sifive_pdma.c                     |   1 +
>   hw/hyperv/hyperv.c                       |   1 +
>   hw/hyperv/syndbg.c                       |   1 +
>   hw/hyperv/vmbus.c                        |   1 +
>   hw/i386/kvm/clock.c                      |   1 +
>   hw/i386/vapic.c                          |   1 +
>   hw/intc/apic.c                           |   1 +
>   hw/intc/xive2.c                          |   1 +
>   hw/m68k/next-cube.c                      |   1 +
>   hw/microblaze/boot.c                     |   1 +
>   hw/misc/pc-testdev.c                     |   1 +
>   hw/net/fsl_etsec/rings.c                 |   1 +
>   hw/net/mcf_fec.c                         |   1 +
>   hw/net/opencores_eth.c                   |   1 +
>   hw/net/xgmac.c                           |   1 +
>   hw/nvram/spapr_nvram.c                   |   1 +
>   hw/ppc/amigaone.c                        |   1 +
>   hw/ppc/e500.c                            |   1 +
>   hw/ppc/pegasos.c                         |   1 +
>   hw/ppc/pnv.c                             |   1 +
>   hw/ppc/ppc440_uc.c                       |   1 +
>   hw/ppc/spapr.c                           |   1 +
>   hw/ppc/spapr_drc.c                       |   1 +
>   hw/ppc/spapr_events.c                    |   1 +
>   hw/ppc/spapr_hcall.c                     |   1 +
>   hw/ppc/spapr_rtas.c                      |   1 +
>   hw/ppc/spapr_tpm_proxy.c                 |   1 +
>   hw/ppc/virtex_ml507.c                    |   1 +
>   hw/remote/proxy-memory-listener.c        |   1 +
>   hw/s390x/css.c                           |   1 +
>   hw/s390x/ipl.c                           |   1 +
>   hw/s390x/s390-pci-bus.c                  |   1 +
>   hw/s390x/s390-stattrib.c                 |   1 +
>   hw/s390x/virtio-ccw.c                    |   1 +
>   hw/scsi/vmw_pvscsi.c                     |   1 +
>   hw/sparc/leon3.c                         |   1 +
>   hw/vfio-user/container.c                 |   1 +
>   hw/vfio/container.c                      |   2 +-
>   hw/vfio/helpers.c                        |   1 +
>   hw/vfio/migration.c                      |   2 +-
>   hw/virtio/vhost.c                        |   1 +
>   hw/xen/xen-mapcache.c                    |   1 +
>   hw/xen/xen_pt_graphics.c                 |   1 +
>   hw/xtensa/xtfpga.c                       |   1 +
>   migration/ram.c                          |   2 +-
>   stubs/physmem.c                          |   2 +-
>   stubs/ram-block.c                        |   4 +-
>   system/ioport.c                          |   1 +
>   system/memory.c                          |   2 +-
>   system/physmem.c                         |   2 +-
>   target/arm/kvm.c                         |   1 +
>   target/i386/kvm/kvm.c                    |   1 +
>   target/i386/sev.c                        |   1 +
>   target/ppc/kvm.c                         |   2 +-
>   target/s390x/kvm/kvm.c                   |   2 +-
>   tests/qtest/fuzz/generic_fuzz.c          |   2 +-
>   util/vfio-helpers.c                      |   2 +-
>   rust/hw/char/pl011/src/bindings.rs       |   4 +-
>   rust/hw/core/src/bindings.rs             |   2 +-
>   rust/system/src/bindings.rs              |   5 +-
>   102 files changed, 298 insertions(+), 234 deletions(-)
>   rename include/{exec => system}/ramlist.h (94%)


