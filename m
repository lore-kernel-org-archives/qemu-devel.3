Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07790CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFw3q-0001YP-95; Mon, 03 Nov 2025 10:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw3n-0001Y7-FG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw3i-0008H9-Sx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762182082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9QJeWarUhRAjbywXCnUyA7NpiuDupvmjQ+aYJsVXWA=;
 b=BELtUDDy55Nmk/cKo829Lt+VTv7nW5yx+0IUfDN2yagzxmtY+6wEZPjP0AgI+E5cyrZONI
 kpVAVxbcmoJfu33PgnEDzQ60QcszNPo2/rTmt3GxoVUUIUIf1ZkI9U8cHsxG+pGcHEGDwk
 AKSfE3yTPCZ9pgG0Azx7AKCaSnDKFhI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-v0WjBJNdNu210V9mZ0dVPg-1; Mon, 03 Nov 2025 10:01:20 -0500
X-MC-Unique: v0WjBJNdNu210V9mZ0dVPg-1
X-Mimecast-MFC-AGG-ID: v0WjBJNdNu210V9mZ0dVPg_1762182079
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c71c5892so1602918f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762182077; x=1762786877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9QJeWarUhRAjbywXCnUyA7NpiuDupvmjQ+aYJsVXWA=;
 b=dLhZ697XCKFc57BdSNj1qeugvrIgokvJXJ27PCrTiDvHHKDx2nDRg6CUJ/c+qkqWoC
 DXRleXvi1l17McvndIs7rO/b2WsFXv6roE6pdle8nWtPFW4EEBc2iODJKSb+MPfy1UzA
 OfRUdCGM07IyhlxBV7GviGhINiCuN9pIRXkzFqaVHP4Bo8YcPYVH0y+EPhWHBF3v2v1t
 dZGT45dfhArPLk2/gqvwvwvYPyORDuUQH6mhlNu9FCZIjQtW5/r8bCSAoISDAgcE9WFS
 1fzTnJXd29Y9x8jJHiUtFdPP1dwdkrMggK0mbfIN0ZJH9MOUASFYGgfU7unR/HyClgHw
 gL2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWub8E1DiL3OnNEczzlBpbs0F30RqL8T8F2aG/0UYxIOfdBOhBkLIYDRo+nSLXNz6/xrVPyoYjM74fN@nongnu.org
X-Gm-Message-State: AOJu0YyTbqbvrWkuNLBAr72PqshNWTgVemdu7sbaEdTfTdp9wWsVR+ay
 cM5TEYj1ApS2/DWARCKLyoVYZm8riyZVlo7c7I5RT6Kp1moM3HDmFAlRSO73fX6+wUVro+CcedV
 voSxcnG0WcTN3WkLwp/WdMB1JKKkVk7V4pBbmEbU5jQ5XCzE+/8nAR5VaxEEK2GSi
X-Gm-Gg: ASbGncurraOv/H5oYMhfju3WctahWO/gOlA4Y4Gk1vSSvR+Ga9KE0uw9iizO1tzHKzW
 IoP+KLZfmN8FfiEPMHmygbXL1qQLlpovd7hniN778XMkBytS9LiL71d6MbkJs0KOgHMSpq1JEOV
 Paw108ST4nYeN/aPlItMOU+FUdJEf5oHHdeujW5/njdE1Dqxkb5m77J/Oytj8ZnWm/qphGZ9rf0
 FaiFG6VH3/2x1Wy/v/ydKx2yQkdGF1g+Pu/w1CPh1hmGmDM0vr6eWvo0RiPfbZaWdlZyB6X6+5i
 Y4kWUzybI9l7RXe2ldw8UvYu0zDweS8aA6DJcH53rWBY1hdMGYz6pxgNsCnpHVD59o+FoWzrcdX
 wlaoRQDYsP4zahE3uEFHxiEcI8ST4jIqBelzkiRPGTtG4yg==
X-Received: by 2002:a05:6000:4024:b0:429:cdde:be1e with SMTP id
 ffacd0b85a97d-429cddebfa6mr4273346f8f.39.1762182076683; 
 Mon, 03 Nov 2025 07:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3u4ncTxet/3Jx9CSsR2yogp8B9YkMPVgf2P2iOGDdvlgSC012vnf82lcK0QDdXqMcMqokIw==
X-Received: by 2002:a05:6000:4024:b0:429:cdde:be1e with SMTP id
 ffacd0b85a97d-429cddebfa6mr4273308f8f.39.1762182076067; 
 Mon, 03 Nov 2025 07:01:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1405fffsm20844222f8f.45.2025.11.03.07.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 07:01:15 -0800 (PST)
Message-ID: <d50c917d-c691-4bfc-a1d6-64171fd7bcf3@redhat.com>
Date: Mon, 3 Nov 2025 16:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/32] tests/qtest/bios-tables-test: Update IORT blobs
 after revision upgrade
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-25-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-25-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Update the reference IORT blobs after revision upgrade for RMR node
> support. This affects the aarch64 'virt' IORT tests.
>
> IORT diff is the same for all the tests:
>
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20230628 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
> + * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
>   *
>   * ACPI Data Table [IORT]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
>
>  [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
>  [004h 0004 004h]                Table Length : 00000080
> -[008h 0008 001h]                    Revision : 03
> -[009h 0009 001h]                    Checksum : B3
> +[008h 0008 001h]                    Revision : 05
> +[009h 0009 001h]                    Checksum : B1
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
>  ...
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
>  5 files changed, 4 deletions(-)
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
> index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..a234aae4c2d04668d34313836d32ca20e19c0880 100644
> GIT binary patch
> delta 18
> ZcmZo*Y+&T_^bZPYU|?Wi-8hk}3;-#Q1d;#%
>
> delta 18
> ZcmZo*Y+&T_^bZPYU|?Wi-aL`33;-#O1d;#%
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
> index c10da4e61dd00e7eb062558a2735d49ca0b20620..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3 100644
> GIT binary patch
> delta 18
> ZcmZ3(xQ3C-(?2L=4FdxM>(q%{ivTdM1ttIh
>
> delta 18
> ZcmZ3(xQ3C-(?2L=4FdxM^Yn>aivTdK1ttIh
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
> index 67be268f62afbf2d9459540984da5e9340afdaaa..43a15fe2bf6cc650ffcbceff86919ea892928c0e 100644
> GIT binary patch
> delta 19
> acmaFE^oEJc(?2LAhmnDS^~6T5Bt`%|fCYU3
>
> delta 19
> acmaFE^oEJc(?2LAhmnDS`P4?PBt`%|eg%C1
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
> index 41981a449fc306b80cccd87ddec3c593a8d72c07..5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4 100644
> GIT binary patch
> delta 19
> acmbQjG=+)F(?2Lggpq-P)oUXc7b5^FiUXej
>
> delta 19
> acmbQjG=+)F(?2Lggpq-P*=Hjc7b5^Fhy$Mh
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 3279638ad0..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,5 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/IORT",
> -"tests/data/acpi/aarch64/virt/IORT.its_off",
> -"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
> -"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",


