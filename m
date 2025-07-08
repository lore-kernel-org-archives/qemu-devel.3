Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A92C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDu-0005U4-K9; Tue, 08 Jul 2025 16:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDv5-0003f7-R2
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDuz-0001QP-Aj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmP45IDu6KBnKz7CDVnRI2MYKx9DHEVWpCMeCpqJdOg=;
 b=eFkeZ5PIUrLyaTzF9sd43F4r697sD0WGN5QC8h2FJlraBGDgobaNJAHzeU1t5ilHRgeAoP
 YFI7Umo9xEm81BDKuuxBM36sW61KHCR7iMS0MINAXCr0xJIl3HGqzodj2LK3/Uz8sOYejs
 wTBc7o+iuCKMvYRwkVLY/750Q6SwwTo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-kFiQXyHIPiCXPUdjqhgh2A-1; Tue, 08 Jul 2025 11:10:28 -0400
X-MC-Unique: kFiQXyHIPiCXPUdjqhgh2A-1
X-Mimecast-MFC-AGG-ID: kFiQXyHIPiCXPUdjqhgh2A_1751987426
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530c186394so17648835e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751987421; x=1752592221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmP45IDu6KBnKz7CDVnRI2MYKx9DHEVWpCMeCpqJdOg=;
 b=ct0kMituI18K/ABgbVg9NjBsRSjw6yI3FT+jlIoD5NqMkKJjY+ip4+rvSAgWN65P4P
 Iy/TNCdj7elSejMqRDe7ifJS+LZC1hgtxjB06Iuk5Q+8uQWccqsVp6cTV66mtLe5YPU+
 rufJoNH9R8VIB88ZGhL5T/FRLVrbMHYyY7z/h8fMyOm6o8x5tkLDArcktyvllavMlkpE
 FBTWIu9U89S58dYHW5+kfFycmzjSpS2exk0VOCD76uZwshDzSQETvEVZ9zz23Jdg0NB+
 vBXdL1NYxZCR5LEq7NOhKEnNgV10Hihw/CeQGBCE8Mecx0o9cYRByc2aGUnPsXcHRFwu
 9mKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/7X0+ualbzcnAJhHoXX7YmciyyhWjp1RvRHOEDUUdRNz0gBQ3LVTcicMLZw+7WE/k0R5yA/Ljy7de@nongnu.org
X-Gm-Message-State: AOJu0YzcDNHzSPNTEdtlaXthJVdcmzP4C09kl6l4fTnYHZG29ho4OhE7
 K+LytGq6nfLruBZiHEJBXh2BiTEK+lbXrkaN71M1Ne3qf5EGuk3MM/C51lDkqhdGmzyOudRA0C5
 34y7BdXDjafE73X7Gji22LTXz5nfb6w0ql4oEel5kZ8LBEcVNb7YFdtuN
X-Gm-Gg: ASbGncttPziqu1p6QWxEGU9eKRzqNLWIC9Qrzz8ntHA4M+ya7NZzT8MUZ7Cj8omEP7i
 5ZCjJuWOczJ2P9XJsWYyLRtJBkrU6OVaHrajUuadgl4+dShH92Chi60iRXELy5d8UsgwbPsVJJ6
 JDGn/LZBYyjnv+BXW1OItejKUrpexsjQfeXUgO5dskiQE3EDWSRliR3GKz3EmsryiuJ1G0unKgG
 xavqxeVUBRrNMSzI8/DFnRu6/VEhi75VPyV3fKKCtjzpzE7VjDDAo8ZLfvUw1SHK77LwJz4VNqa
 rLLQlxNIacCZyUJCvs3SrlaKx6p4QUuRaRoSDLe9tzu97GfLDlGA3B0ecUCreaCgzFMYWw==
X-Received: by 2002:a05:600c:1e02:b0:442:f4a3:9388 with SMTP id
 5b1f17b1804b1-454ccc4a47emr41546235e9.19.1751987420319; 
 Tue, 08 Jul 2025 08:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDfGzF4MQa4MyBxdlAAlPECEFbjn3hpHfziD4+Og03gM7CLRIJ3Tn/aP0KYDkcAvfN6ig2EA==
X-Received: by 2002:a05:600c:1e02:b0:442:f4a3:9388 with SMTP id
 5b1f17b1804b1-454ccc4a47emr41545535e9.19.1751987419679; 
 Tue, 08 Jul 2025 08:10:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a54f0sm24108235e9.35.2025.07.08.08.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 08:10:18 -0700 (PDT)
Message-ID: <f49a4f6e-d9c7-47cf-8267-138535d5f2d1@redhat.com>
Date: Tue, 8 Jul 2025 17:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/12] qtest/bios-tables-test: Update tables for smmuv3
 tests
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-13-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250703084643.85740-13-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer,

On 7/3/25 10:46 AM, Shameer Kolothum wrote:
> For the legacy smmuv3 test case, generated IORT has a single SMMUv3 node,
> a Root Complex(RC) node and 1 ITS node.
> RC node features 4 ID mappings, of which 2 points to SMMU node and the
> remaining ones points to ITS.
>
>        pcie.0 -> {SMMU0} -> {ITS}
> {RC}   pcie.1 -> {SMMU0} -> {ITS}
>        pcie.2            -> {ITS}
>        [all other ids]   -> {ITS}
>
> ...
> [030h 0048   1]                         Type : 00
> [031h 0049   2]                       Length : 0018
> [033h 0051   1]                     Revision : 01
> [034h 0052   4]                   Identifier : 00000000
> [038h 0056   4]                Mapping Count : 00000000
> [03Ch 0060   4]               Mapping Offset : 00000000
>
> [040h 0064   4]                     ItsCount : 00000001
> [044h 0068   4]                  Identifiers : 00000000
>
> [048h 0072   1]                         Type : 04
> [049h 0073   2]                       Length : 0058
> [04Bh 0075   1]                     Revision : 04
> [04Ch 0076   4]                   Identifier : 00000001
> [050h 0080   4]                Mapping Count : 00000001
> [054h 0084   4]               Mapping Offset : 00000044
>
> [058h 0088   8]                 Base Address : 0000000009050000
> [060h 0096   4]        Flags (decoded below) : 00000001
>                              COHACC Override : 1
>                                HTTU Override : 0
>                       Proximity Domain Valid : 0
> [064h 0100   4]                     Reserved : 00000000
> [068h 0104   8]                VATOS Address : 0000000000000000
> [070h 0112   4]                        Model : 00000000
> [074h 0116   4]                   Event GSIV : 0000006A
> [078h 0120   4]                     PRI GSIV : 0000006B
> [07Ch 0124   4]                    GERR GSIV : 0000006D
> [080h 0128   4]                    Sync GSIV : 0000006C
> [084h 0132   4]             Proximity Domain : 00000000
> [088h 0136   4]      Device ID Mapping Index : 00000000
>
> [08Ch 0140   4]                   Input base : 00000000
> [090h 0144   4]                     ID Count : 0000FFFF
> [094h 0148   4]                  Output Base : 00000000
> [098h 0152   4]             Output Reference : 00000030
> [09Ch 0156   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [0A0h 0160   1]                         Type : 02
> [0A1h 0161   2]                       Length : 0074
> [0A3h 0163   1]                     Revision : 03
> [0A4h 0164   4]                   Identifier : 00000002
> [0A8h 0168   4]                Mapping Count : 00000004
> [0ACh 0172   4]               Mapping Offset : 00000024
>
> [0B0h 0176   8]            Memory Properties : [IORT Memory Access Properties]
> [0B0h 0176   4]              Cache Coherency : 00000001
> [0B4h 0180   1]        Hints (decoded below) : 00
>                                    Transient : 0
>                               Write Allocate : 0
>                                Read Allocate : 0
>                                     Override : 0
> [0B5h 0181   2]                     Reserved : 0000
> [0B7h 0183   1] Memory Flags (decoded below) : 03
>                                    Coherency : 1
>                             Device Attribute : 1
> [0B8h 0184   4]                ATS Attribute : 00000000
> [0BCh 0188   4]           PCI Segment Number : 00000000
> [0C0h 0192   1]            Memory Size Limit : 40
> [0C1h 0193   2]           PASID Capabilities : 0000
> [0C3h 0195   1]                     Reserved : 00
>
> [0C4h 0196   4]                   Input base : 00000000
> [0C8h 0200   4]                     ID Count : 000001FF
> [0CCh 0204   4]                  Output Base : 00000000
> [0D0h 0208   4]             Output Reference : 00000048
> [0D4h 0212   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [0D8h 0216   4]                   Input base : 00001000
> [0DCh 0220   4]                     ID Count : 000000FF
> [0E0h 0224   4]                  Output Base : 00001000
> [0E4h 0228   4]             Output Reference : 00000048
> [0E8h 0232   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [0ECh 0236   4]                   Input base : 00000200
> [0F0h 0240   4]                     ID Count : 00000DFF
> [0F4h 0244   4]                  Output Base : 00000200
> [0F8h 0248   4]             Output Reference : 00000030
> [0FCh 0252   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [100h 0256   4]                   Input base : 00001100
> [104h 0260   4]                     ID Count : 0000EEFF
> [108h 0264   4]                  Output Base : 00001100
> [10Ch 0268   4]             Output Reference : 00000030
> [110h 0272   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> For the smmuv3-dev test case, IORT has 2 SMMUV3 nodes,
> 1 RC node and 1 ITS node.
> RC node features 4 ID mappings. 2 of them target the 2
> SMMU nodes while the others targets the ITS.
>
>         pcie.0 -> {SMMU0} -> {ITS}
> {RC}    pcie.1 -> {SMMU1} -> {ITS}
>         pcie.2            -> {ITS}
>         [all other ids]   -> {ITS}
> ...
> [030h 0048   1]                         Type : 00
> [031h 0049   2]                       Length : 0018
> [033h 0051   1]                     Revision : 01
> [034h 0052   4]                   Identifier : 00000000
> [038h 0056   4]                Mapping Count : 00000000
> [03Ch 0060   4]               Mapping Offset : 00000000
>
> [040h 0064   4]                     ItsCount : 00000001
> [044h 0068   4]                  Identifiers : 00000000
>
> [048h 0072   1]                         Type : 04
> [049h 0073   2]                       Length : 0058
> [04Bh 0075   1]                     Revision : 04
> [04Ch 0076   4]                   Identifier : 00000001
> [050h 0080   4]                Mapping Count : 00000001
> [054h 0084   4]               Mapping Offset : 00000044
>
> [058h 0088   8]                 Base Address : 000000000C000000
> [060h 0096   4]        Flags (decoded below) : 00000001
>                              COHACC Override : 1
>                                HTTU Override : 0
>                       Proximity Domain Valid : 0
> [064h 0100   4]                     Reserved : 00000000
> [068h 0104   8]                VATOS Address : 0000000000000000
> [070h 0112   4]                        Model : 00000000
> [074h 0116   4]                   Event GSIV : 00000090
> [078h 0120   4]                     PRI GSIV : 00000091
> [07Ch 0124   4]                    GERR GSIV : 00000093
> [080h 0128   4]                    Sync GSIV : 00000092
> [084h 0132   4]             Proximity Domain : 00000000
> [088h 0136   4]      Device ID Mapping Index : 00000000
>
> [08Ch 0140   4]                   Input base : 00000000
> [090h 0144   4]                     ID Count : 0000FFFF
> [094h 0148   4]                  Output Base : 00000000
> [098h 0152   4]             Output Reference : 00000030
> [09Ch 0156   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [0A0h 0160   1]                         Type : 04
> [0A1h 0161   2]                       Length : 0058
> [0A3h 0163   1]                     Revision : 04
> [0A4h 0164   4]                   Identifier : 00000002
> [0A8h 0168   4]                Mapping Count : 00000001
> [0ACh 0172   4]               Mapping Offset : 00000044
>
> [0B0h 0176   8]                 Base Address : 000000000C020000
> [0B8h 0184   4]        Flags (decoded below) : 00000001
>                              COHACC Override : 1
>                                HTTU Override : 0
>                       Proximity Domain Valid : 0
> [0BCh 0188   4]                     Reserved : 00000000
> [0C0h 0192   8]                VATOS Address : 0000000000000000
> [0C8h 0200   4]                        Model : 00000000
> [0CCh 0204   4]                   Event GSIV : 00000094
> [0D0h 0208   4]                     PRI GSIV : 00000095
> [0D4h 0212   4]                    GERR GSIV : 00000097
> [0D8h 0216   4]                    Sync GSIV : 00000096
> [0DCh 0220   4]             Proximity Domain : 00000000
> [0E0h 0224   4]      Device ID Mapping Index : 00000000
>
> [0E4h 0228   4]                   Input base : 00000000
> [0E8h 0232   4]                     ID Count : 0000FFFF
> [0ECh 0236   4]                  Output Base : 00000000
> [0F0h 0240   4]             Output Reference : 00000030
> [0F4h 0244   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [0F8h 0248   1]                         Type : 02
> [0F9h 0249   2]                       Length : 0074
> [0FBh 0251   1]                     Revision : 03
> [0FCh 0252   4]                   Identifier : 00000003
> [100h 0256   4]                Mapping Count : 00000004
> [104h 0260   4]               Mapping Offset : 00000024
>
> [108h 0264   8]            Memory Properties : [IORT Memory Access Properties]
> [108h 0264   4]              Cache Coherency : 00000001
> [10Ch 0268   1]        Hints (decoded below) : 00
>                                    Transient : 0
>                               Write Allocate : 0
>                                Read Allocate : 0
>                                     Override : 0
> [10Dh 0269   2]                     Reserved : 0000
> [10Fh 0271   1] Memory Flags (decoded below) : 03
>                                    Coherency : 1
>                             Device Attribute : 1
> [110h 0272   4]                ATS Attribute : 00000000
> [114h 0276   4]           PCI Segment Number : 00000000
> [118h 0280   1]            Memory Size Limit : 40
> [119h 0281   2]           PASID Capabilities : 0000
> [11Bh 0283   1]                     Reserved : 00
>
> [11Ch 0284   4]                   Input base : 00000000
> [120h 0288   4]                     ID Count : 000001FF
> [124h 0292   4]                  Output Base : 00000000
> [128h 0296   4]             Output Reference : 00000048
> [12Ch 0300   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [130h 0304   4]                   Input base : 00001000
> [134h 0308   4]                     ID Count : 000000FF
> [138h 0312   4]                  Output Base : 00001000
> [13Ch 0316   4]             Output Reference : 000000A0
> [140h 0320   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [144h 0324   4]                   Input base : 00000200
> [148h 0328   4]                     ID Count : 00000DFF
> [14Ch 0332   4]                  Output Base : 00000200
> [150h 0336   4]             Output Reference : 00000030
> [154h 0340   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> [158h 0344   4]                   Input base : 00001100
> [15Ch 0348   4]                     ID Count : 0000EEFF
> [160h 0352   4]                  Output Base : 00001100
> [164h 0356   4]             Output Reference : 00000030
> [168h 0360   4]        Flags (decoded below) : 00000000
>                               Single Mapping : 0
>
> Note: DSDT changes are not described here as it is not impacted by the
> way the SMMUv3 is instantiated.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | Bin 0 -> 10162 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10162 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 0 -> 364 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
>  5 files changed, 4 deletions(-)
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4b166b836e75f0c049c245b0c1dc7955f0dbcd04 100644
> GIT binary patch
> literal 10162
> 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%0A^zQD+K_OoMj4$6*$KLz#q&a&ALlf{oY
> zk<<&FWwW0t6H+gBmaTbS$hQ8+cD~m?H~PPjt-F24j-8!rvupf%TVUH#w$KiF*t4^1
> z%b{uiKHvE^du`6(%?_^M4Zq^{PreQ8TRsPG>^p-uHkPzjEn3SGD?Pli_YB^sTGAR;
> zT5DNirMY1*;7twyZ)zpHv6U+cZ<+#llLNq;S_yA5Pk7T5z?&QZ-qcEXlX=3MrU2gL
> z0Pv<(!kf$!-ZTa9CI^5wwG!TBp75qAfHye+ys4G&Ci8?hO#!^g0pLxogg2QdylD#H
> zO%4EWY9+kMJmF1K0B>>tcvCCkP38%2ngV!}1HhYF32!n_c+(WXn;Zb%)Jk}hdBU5f
> z0N&&P@TOM6o6Hm5GzIV`2Y@%V65eE<@TMt%H#q>jsg>|1^Mp4|0ldip;7zTBH<>5A
> zX$s&?4ghazCA`Tz;Z0KjZ*l;5Q!C+3<_T|_0(g@Hz?)hLZ!%AK(-gp)901<bN_dlb
> z!keZ5-sAxArdGn6%oE-;1@I;ZfH$=g-ejKerYV3oIRLz=mGCC>gf~qAyvYIJO|67C
> znJ2ty3gAr+0B>p~yvaP_O;Z4GasYT!E8$J%32&MLc#{Lbn_3BPGEaEZ6u_Gt0N&I}
> zc$0a;o2CHX<N)xdR>GUi6W%lh@FoX<H?<PpWS;PbDN~JJzPS;e+5ZZmv2Ird&Fv0m
> z@0DlZLa;Z!A>D6nzl>DuE-sDJ)BoU)AMA2^&7P@@*r!@?v7f!{a%#_3!qacMHGKLp
> zp2LNeuJHI5@*Lkmt+U;A2$Y{8^J><7?)dOEu%olIu0w-+AZq?~+UDTf*YNjmceb~B
> z1@9Gq{MNz`mWEHG_C)_hEPn7EsC>Ox`gprzq-7sD^`WeG^qXOn`F3}Ee|c)LxBb@P
> j&?6M@oHUL<cqhZ@rw`i?I-A+!qbGB?<KZ$dW`+L(PyH`>
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4b166b836e75f0c049c245b0c1dc7955f0dbcd04 100644
> GIT binary patch
> literal 10162
> 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%0A^zQD+K_OoMj4$6*$KLz#q&a&ALlf{oY
> zk<<&FWwW0t6H+gBmaTbS$hQ8+cD~m?H~PPjt-F24j-8!rvupf%TVUH#w$KiF*t4^1
> z%b{uiKHvE^du`6(%?_^M4Zq^{PreQ8TRsPG>^p-uHkPzjEn3SGD?Pli_YB^sTGAR;
> zT5DNirMY1*;7twyZ)zpHv6U+cZ<+#llLNq;S_yA5Pk7T5z?&QZ-qcEXlX=3MrU2gL
> z0Pv<(!kf$!-ZTa9CI^5wwG!TBp75qAfHye+ys4G&Ci8?hO#!^g0pLxogg2QdylD#H
> zO%4EWY9+kMJmF1K0B>>tcvCCkP38%2ngV!}1HhYF32!n_c+(WXn;Zb%)Jk}hdBU5f
> z0N&&P@TOM6o6Hm5GzIV`2Y@%V65eE<@TMt%H#q>jsg>|1^Mp4|0ldip;7zTBH<>5A
> zX$s&?4ghazCA`Tz;Z0KjZ*l;5Q!C+3<_T|_0(g@Hz?)hLZ!%AK(-gp)901<bN_dlb
> z!keZ5-sAxArdGn6%oE-;1@I;ZfH$=g-ejKerYV3oIRLz=mGCC>gf~qAyvYIJO|67C
> znJ2ty3gAr+0B>p~yvaP_O;Z4GasYT!E8$J%32&MLc#{Lbn_3BPGEaEZ6u_Gt0N&I}
> zc$0a;o2CHX<N)xdR>GUi6W%lh@FoX<H?<PpWS;PbDN~JJzPS;e+5ZZmv2Ird&Fv0m
> z@0DlZLa;Z!A>D6nzl>DuE-sDJ)BoU)AMA2^&7P@@*r!@?v7f!{a%#_3!qacMHGKLp
> zp2LNeuJHI5@*Lkmt+U;A2$Y{8^J><7?)dOEu%olIu0w-+AZq?~+UDTf*YNjmceb~B
> z1@9Gq{MNz`mWEHG_C)_hEPn7EsC>Ox`gprzq-7sD^`WeG^qXOn`F3}Ee|c)LxBb@P
> j&?6M@oHUL<cqhZ@rw`i?I-A+!qbGB?<KZ$dW`+L(PyH`>
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..67be268f62afbf2d9459540984da5e9340afdaaa 100644
> GIT binary patch
> literal 364
> zcmebD4+_a)WME)E<>c?|5v<@85#X!<1VAAM5F13Z0I>lOgMkDCNC*yK9F_<M77!bR
> zT_CbNAPOcA5rU8tfYd}Fo(#m3AVP5R|9=P*W*^90CZG_)Tqd06P64W$3dGZacp4BR
> z19WqlN*I`#feJu=QvqVAJ3&HV-~grnLnS<*d<Fpq2Cx%>^a7X|(1HJXfgB(Wb2oz^
> MQ0yI03`oPo01?F*0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..41981a449fc306b80cccd87ddec3c593a8d72c07 100644
> GIT binary patch
> literal 276
> zcmX|*K@NgI3`M`puy8?wi3^u3IDkhWzycE!jI!Vis5{Ti6^7s1@{>QmeVugXHa@5G
> z0SNbY?1op>&X2C5h#<9Ops%#*0ztdHi8G?q;$EluQNrhn>{ys@`b&R|d8G8O{Jrdl
> mkP$_?rfr{mN!3^;8w}Q?1auX1XIzvDUSRruoXA!(rn3!nx)K2Z
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 2e3e3ccdce..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,5 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
> -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
> -"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
> -"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",


