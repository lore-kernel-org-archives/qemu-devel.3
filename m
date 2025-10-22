Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3FCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbYy-0008Pk-7N; Wed, 22 Oct 2025 12:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBbYr-0008OD-G9
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBbYo-00019Z-Nn
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761149977;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8mcxZkgU/SKVAeTkiAwSGAKaVxY1V9jze9kVDqF30g=;
 b=cYwcduOepNtU2G5hdnXk9KKN8PbZLFmFe3pgboZ3A4cmCi1rSXwPxHiYL79AN666iSqSI4
 /nsINQgypPy/0Dks6eTv5RfxyzYZKO/JrRMtaoCRhgib0eNgck2RMl9NEQP3kwyt6pUHyE
 bWcWeeJ0QkE2gDWaIMaMm5HurDzH1oQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-_iUNliSdNnSI4tdHgbdjOg-1; Wed, 22 Oct 2025 12:19:34 -0400
X-MC-Unique: _iUNliSdNnSI4tdHgbdjOg-1
X-Mimecast-MFC-AGG-ID: _iUNliSdNnSI4tdHgbdjOg_1761149972
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47111dc7bdbso53974215e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761149972; x=1761754772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8mcxZkgU/SKVAeTkiAwSGAKaVxY1V9jze9kVDqF30g=;
 b=fdgjoAycgkeoOm1YewSqsTrcvgIuNJbAb4RgKd1oPlhdYJD+VOJ9WON6tmTaDsN2tY
 bOCyWfLDiayFPH+r7dZLrCQvS9Uyq6nAPFBhi0KytKByLWWyxr60zi//8Sd3DI3Dw55k
 Kece9PTKP8XJygZaL4Kei0leWp3Uz5xQcHsVF8uW1/OuiQjG8oV49ALAdrZ2zae+7+2A
 QUb3BJ4J1x2uvtu0qVrkUocYU0CYm99xy7D+MfjoJF7yRaw1ptwDvmS0LOlh0cDrX3tR
 VKpBeKZHopJlBSjQRD0tIt5eSg1F7lws91k4+66+LHYfgELHQJvKrbYghypE65l4jUUt
 s74w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy+ZmezxWdSSHCV2fl38H7cRBA3GAchdFIh3NyyYJBmsfs6eu05vYpvIOMpjZGT5Ud7yDeN+nANGwM@nongnu.org
X-Gm-Message-State: AOJu0YxukaWhJ7U3f/v7Bfp8bNMsZ274ASjD/JlBx6IJEOyscMxNz5/5
 hD5wzcBqwC2CqAwRnbO4JzHQT1SlEf2TXmXFglZVymz2q0pMvOE9MwOmo9JmqTvLWiKqLSmttPI
 3wfaQXOZ2jrh7HVa5HmflUAObVH0S7mtFaftLStMSXOqwF1FimxL3vpIu
X-Gm-Gg: ASbGncvl/2oAz19t1riCW6pqQCi5/EqzbBQWfm61GXysINrsnwkVbkIuyh4v1Ml/PhO
 AVwVzGd0fbAlBaOkLmZQxKYesEvw3RqxeoKNYZgzRAuxmG2jHLeM92YV/DHiVkCY6iHARA84e8o
 sKZy9LruExrEgZmKCWtcbzlB+UJpi6wU9eB3LSP+FoJxsnyzuCCucp72njja7/aYJdT3c8nU4E4
 UpdBvBkeaA8SSnUQi0fbhZB6PiCLF/sxyNcxeY37cF3UGAPETRppyW0UfUeYfyVkNJNsiDYi0Ga
 9DlXCnCrjRkOeEKzKwN5eaEr4MlvPIVA0JhVdYi5oPZ1QN55QEftmotIWpWWH84HFjqLRMowCJV
 pPZSiqg==
X-Received: by 2002:a05:600c:8b30:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-4711791cbcbmr161966615e9.30.1761149971950; 
 Wed, 22 Oct 2025 09:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH2lJW+TB7LN19UQxhxoFRBPyCFK0LIJca9GDLdbj8VoUgHDZ6huZwWonj7v5GGXf7fgYwOg==
X-Received: by 2002:a05:600c:8b30:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-4711791cbcbmr161966405e9.30.1761149971449; 
 Wed, 22 Oct 2025 09:19:31 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.198.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427e1be5d6csm25631002f8f.0.2025.10.22.09.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:19:30 -0700 (PDT)
Message-ID: <b74cf41a-2ead-4c1f-9e3b-89b14b1b6a6f@redhat.com>
Date: Wed, 22 Oct 2025 18:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest/bios-tables-test: Update DSDT blobs after
 GPEX _DSM change
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
 <20251022080639.243965-4-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251022080639.243965-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/22/25 10:06 AM, Shameer Kolothum wrote:
> Update the reference DSDT blobs after GPEX _DSM change. This affects the
> aarch64 'virt', riscv64 "virt", loongarch64 "virt" and the x86 'microvm'
> machines.
>
> DSDT diff is the same for all the machines/tests:
>
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20230628 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Oct 10 11:18:21 2025
> + * Disassembly of /tmp/aml-E6V9D3, Fri Oct 10 11:18:21 2025
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
>   *     Length           0x000014D9 (5337)
>   *     Revision         0x02
> - *     Checksum         0xA4
> + *     Checksum         0xA5
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>  {
>      Scope (\_SB)
>      {
>          Device (C000)
>          {
>              Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
>              Name (_UID, Zero)  // _UID: Unique ID
>          }
>
> @@ -1822,33 +1822,33 @@
>                  Else
>                  {
>                      CDW1 |= 0x04
>                  }
>
>                  Return (Arg3)
>              }
>
>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>              {
>                  If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
>                  {
>                      If ((Arg2 == Zero))
>                      {
>                          Return (Buffer (One)
>                          {
> -                             0x01                                             // .
> +                             0x00                                             // .
>                          })
>                      }
>                  }
>
>                  Return (Buffer (One)
>                  {
>                       0x00                                             // .
>                  })
>              }
>
>              Device (RES0)
>              {
>                  Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
>                  Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>                  {
>                      QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 bytes
>  .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
>  tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
>  .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
>  tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h   |  16 ----------------
>  17 files changed, 16 deletions(-)
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
> index 38f01adb61e6e4704821cee5e397888bb6b7e46d..35a862e44714d26ded01d40dc147e76cc73a1c84 100644
> GIT binary patch
> delta 26
> icmcbqc~g_iCD<k8rU(NA)6$Jx7Q&1So1KNHF#-T`5(jwz
>
> delta 26
> icmcbqc~g_iCD<k8rU(NA(~^x`7Q&2-o1KNHF#-T`3<r4t
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
> index 37a9af713b94a3fd34907dc86c40aaa79e93239c..7ce35f0d8606d17f3ddb9aa090c97c7ac9a38982 100644
> GIT binary patch
> delta 26
> hcmZ3lwO)(MCD<iIUzCA?sbC{lpD-iC=9$9N7y)3m2K4{{
>
> delta 26
> hcmZ3lwO)(MCD<iIUzCA?DSsnZpD-ii=9$9N7y)3g2K4{{
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
> index 04427e2d8eb8d2db0a7ae3dbe546d9072406d09b..6d1765c31017dede80d1d87f8fa7c6dd055d1839 100644
> GIT binary patch
> delta 26
> hcmaE6@XUbACD<h-O@e`esc<8gg)k$-W@lk#Rsd@^29E#$
>
> delta 26
> hcmaE6@XUbACD<h-O@e`esbC|Qg)k%IW@lk#Rsd@;29E#$
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
> index 43ab60496e5a06706d4626d9e7b58b2d7e809e75..61cce30c7471faa4a9b7e3562dcb4ab9b3519a21 100644
> GIT binary patch
> delta 26
> hcmeCz>eu3O33dtL7iC~z^4Z8`A<W3I*;)7uBLGsg1^WO1
>
> delta 26
> hcmeCz>eu3O33dtL7iC~z^4`d0A<W3Q*;)7uBLGsa1^WO1
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
> index 3c391674446167bc9c79fd5dcb1c37e80cc7bbae..ffc5f1c0d1090582672c60ade3eb1bc41acc5ef7 100644
> GIT binary patch
> delta 26
> hcmZ2wvdV<ZCD<iIONxPk>B>ef3t>iv&CbHl*#KgY2MquK
>
> delta 26
> hcmZ2wvdV<ZCD<iIONxPk>GDP{3t>ja&CbHl*#KgS2MquK
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
> index 71c632cedcca63a77a4cdde53d9bc392102687b6..f98dcbfc6b823bce6d5710e8056a4e260fb92a02 100644
> GIT binary patch
> delta 33
> ncmZp%ZL#HY33dr-kz-(B65YtPONfzS^HCu#E+BP5W(y+#m9q%&
>
> delta 33
> ncmZp%ZL#HY33dr-kz-(B65hzQONfzi^HCu#E+BP5W(y+#m7oal
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
> index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
> GIT binary patch
> delta 55
> zcmZ1!uqc4bCD<iINrQobY4t{~T|$fun~w_haPlxL5oBg$h;H&^@iCZuLC9<Ka+$51
> KK*?COql^H#4-gjs
>
> delta 55
> zcmZ1!uqc4bCD<iINrQobX~jmaT|$hEn~w_haPlxN5oBg$h;H&^@iCZuLC9<Ka+$51
> KK*?COql^H!*$@{1
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
> index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
> GIT binary patch
> delta 55
> zcmZ1!uqc4bCD<iINrQobY4t{~T|$fun~w_haPlxL5oBg$h;H&^@iCZuLC9<Ka+$51
> KK*?COql^H#4-gjs
>
> delta 55
> zcmZ1!uqc4bCD<iINrQobX~jmaT|$hEn~w_haPlxN5oBg$h;H&^@iCZuLC9<Ka+$51
> KK*?COql^H!*$@{1
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
> index 9f22cd3dc81efe3ebcb8caf913842a8dea910627..208a3163a6bf2a59cf421418dcb16ad1156285c6 100644
> GIT binary patch
> delta 26
> icmZ3iy;z&eCD<iou_yxr)69)rOd^a7n|Vd1F#-T#9R_9q
>
> delta 26
> icmZ3iy;z&eCD<iou_yxr(~ON=Od^bon|Vd1F#-T#7Y1ek
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
> index dd3775a0762ae1a5ddb89dd656d81eee581dccb6..f81e3e6cc794d77ea66b7e27b1afe56e248132b6 100644
> GIT binary patch
> delta 26
> hcmaE*`AU<^CD<k8l?Vd^llw+43t>iv&CbHh83A%X2VVdH
>
> delta 26
> hcmaE*`AU<^CD<k8l?Vd^liNlv3t>ja&CbHh83A%R2VVdH
>
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
> index 55aa34f988d6ef69293e91c5fe45bee0a02bc5f1..09aa903c4e875f541223e36f59b28e101599df20 100644
> GIT binary patch
> delta 26
> icmeyZ{9BpJCD<k8w;%%pW6Vab$vlh<o9FSwvH}2l69@SK
>
> delta 26
> icmeyZ{9BpJCD<k8w;%%pWAsL@$vljVo9FSwvH}2l4F~xE
>
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
> index c0955eb60448cc5f4d38d410abc260ae54ea2e9a..a069d6878fb45fa6b0e6342eedb0eb3d25eb20da 100644
> GIT binary patch
> delta 26
> icmX@0dq9`VCD<k8fEWV<W8y}x$vlh<o9FQ;aRC5qod+-g
>
> delta 26
> icmX@0dq9`VCD<k8fEWV<W5PzR$vljVo9FQ;aRC5qmj^Ha
>
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
> index 61e47e7252155dcf9c76879c4f60f4b3eef63f86..78ece52f57a383db128c7d1a08526e15ab911bb7 100644
> GIT binary patch
> delta 26
> hcmZovX;k5I33dr#6k=dte7=!uG7lre=6O8HtN>Vb2A==`
>
> delta 26
> hcmZovX;k5I33dr#6k=dte72EmG7lr;=6O8HtN>VV2A==`
>
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
> index b2afebc938ce45d798c8aa5f45a463f1617e257e..7ab23f47cc82dd7bc1975e17893a8cd61039e66d 100644
> GIT binary patch
> delta 26
> icmZ3fwo;ADCD<iIQ<#B)@%%=v$vlh<o9FR#vjG5Njt4CO
>
> delta 26
> icmZ3fwo;ADCD<iIQ<#B)@!UqP$vljVo9FR#vjG5NhzBhI
>
> diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
> index 527f239dab13a00ad42e5a70b8dc2b89f12aa84a..968e1a15c87bb5753b3a84ddb357e26312767220 100644
> GIT binary patch
> delta 25
> gcmca4eMy?jCD<k85-$S-lj=sUVqQju$#uLT0Ac+G$N&HU
>
> delta 25
> gcmca4eMy?jCD<k85-$S-lgdV}VqQkZ$#uLT0AcqA$N&HU
>
> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
> index ba258f454dc0e59ef2fd67e0ce37e270e7c122e8..b646a05551c1ed902413a462442346ce246f8675 100644
> GIT binary patch
> delta 25
> gcmZ1}zEYgaCD<ioB{u^D(~pf@mfVaClU=w|0bO|puK)l5
>
> delta 25
> gcmZ1}zEYgaCD<ioB{u^D)Ax;BmfVbtlU=w|0bO$juK)l5
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index e2fce2e972..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,17 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/DSDT",
> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
> -"tests/data/acpi/aarch64/virt/DSDT.topology",
> -"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
> -"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
> -"tests/data/acpi/aarch64/virt/DSDT.viot",
> -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
> -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
> -"tests/data/acpi/riscv64/virt/DSDT",
> -"tests/data/acpi/loongarch64/virt/DSDT",
> -"tests/data/acpi/loongarch64/virt/DSDT.topology",
> -"tests/data/acpi/loongarch64/virt/DSDT.numamem",
> -"tests/data/acpi/loongarch64/virt/DSDT.memhp",
> -"tests/data/acpi/x86/microvm/DSDT.pcie",


