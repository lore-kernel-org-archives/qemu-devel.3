Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB3C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 02:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZKOe-0007Xg-JR; Tue, 08 Jul 2025 22:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uZKOM-0007Jj-6g
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 22:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uZKOJ-0004uZ-Dk
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 22:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752027511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFnG1aR5KJKsjJMN6oGXhtKh6+SHVAfC0zZCRmExiwM=;
 b=aVK2GvcUtJHBb9QNUbez/W3buJXuRZZfyFolQenReT6mmxyy09j6pV0fvKAjJajk41nNyg
 1vTfEG8YMzNiAShGCr2FMOKakM/nqtjE0XC0hyrJ/0X5lqWJFqbEd416Pq2zi2b4O0FQ/l
 Sx9sRFm4EcXPHd7yDJv5u/odVMCQJrY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-L2816kM2Pnaq8XYDxs8fRA-1; Tue, 08 Jul 2025 22:18:30 -0400
X-MC-Unique: L2816kM2Pnaq8XYDxs8fRA-1
X-Mimecast-MFC-AGG-ID: L2816kM2Pnaq8XYDxs8fRA_1752027509
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e1d70d67so45387585ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 19:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752027509; x=1752632309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFnG1aR5KJKsjJMN6oGXhtKh6+SHVAfC0zZCRmExiwM=;
 b=BSxo5FRzH7GfrMcxGtZnbqlphkCM8NbaRaMoeaxRtL1IgLZ+jB4Zd556Q6uazTj+uO
 OPeDbnNcnI0tIibnnLuKvtHkPA/F0J2iMHr78o/7RjCIhI/iR/mjtlH+EQfumip6ssV+
 69Xjmug+JefgkB06OHMT6xX5/jvwrwdi63QNMcWdzWwcja1jdoc42i8kNWf7f7ufBej3
 CDfPY5T/V2b3x6DHlxMsSca5d5CBAMkhjRN8U1Tu827z9TDzVkN9lokpPuKaZdGoVYtN
 U85MK7Cb5Q2DvSUUc9d6AkZ0hS1p2Lgcv1eTAnckzHkDh1qVtInBYTyognHt2RpR9hib
 Oaig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3S1g25eCbvvx0RThvGVZ/zB9Ql0phubccrjuBcVIcpxjNyo3OBC6H0lQWRgbkq423tZ20I30+sHWa@nongnu.org
X-Gm-Message-State: AOJu0YwQP3oWXghk1I1qQ3bhg4SEH1sGYBeDimKUEtxIqNN0IL6C6ZVA
 LGiAEY4WI5XdUOZ+zyRIGIor4gHAmNbsWlh1bAAKnwM6vfMT4D1vw6KngCkYg9tc7ZpuGbT/vh6
 hqqhYj7aek0FUGJvcG4fT51XNyI3iRxPlb+fJELNFID5Mf2uCza6CLGev
X-Gm-Gg: ASbGnct0IrTL63ABodE9gAvxW3TxQGvaMN3oLOQHkMVZlHypQucg2oNNjrvFw0sHo/h
 MANhlkEBIPfuvCr/aitgv9kjbuQSDiEm+VHwUmMI36l7PULfAjASKUtxCR4zY/LpO6qNBA5UrRd
 10IxoE59oIL64iDsVpAY6+/WWlbm+DW6w6OEYySp52tYW0Qk8tmaM8maS4frUpVldb2xxOsE43U
 jcrVx3otR1RsmmqKS811Wajf2QUruzkgjbbxuomJ+4gTakWfB0H2g7l7SKyH3qDPG7POC6QO1ES
 IOs0v5is+DKLJM5gyz51KTRF
X-Received: by 2002:a17:902:dac8:b0:235:880:cf8a with SMTP id
 d9443c01a7336-23ddb1a48b3mr10863635ad.15.1752027508606; 
 Tue, 08 Jul 2025 19:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF758b2ibND/x6dXtOrEBiormeDqvjQmBzEsUyb5F/6CNFHpZJPSQps2QEHUWnUNpXtbfGZCw==
X-Received: by 2002:a17:902:dac8:b0:235:880:cf8a with SMTP id
 d9443c01a7336-23ddb1a48b3mr10863235ad.15.1752027508249; 
 Tue, 08 Jul 2025 19:18:28 -0700 (PDT)
Received: from [10.72.116.6] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c300f7160sm486260a91.43.2025.07.08.19.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 19:18:27 -0700 (PDT)
Message-ID: <bae99e88-56da-4182-b409-de1304b9ab7b@redhat.com>
Date: Wed, 9 Jul 2025 10:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] ramfb: Add property to control if load the romfile
To: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20250704030315.2181235-1-shahuang@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250704030315.2181235-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi maintainers,

This is a kindly ping, could you help to review this patch series?

Thanks,
Shaoqin

On 7/4/25 11:03 AM, Shaoqin Huang wrote:
> Currently the ramfb device loads the vgabios-ramfb.bin unconditionally, but only
> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> for ramfb, so they don't need to load the romfile.
> 
> So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
> device, because the vfio display also use the ramfb_setup() to load
> the vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Then I set the use_legacy_x86_rom property to false by default, and only set it
> to true on x86 since only x86 will need it.
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.
> 
> Changelog:
> ---------
> v8 -> v9:
>    - Improve the commit message.
> v7 -> v8:
>    - Set the property in microvm machine type.
> v6 -> v7:
>    - Set the property into hw_compat_10_0 instead of hw_compat_9_2.
> v5 -> v6:
>    - Set the property to true on those historical versioned machine types.
> v4 -> v5:
>    - Fix some typo error.
>    - Set the property in piix machine type.
> v3 -> v4:
>    - Set the new property to false by default, only set it to true on x86.
> v2 -> v3:
>    - Fix the underscore error.
>    - Add a new patch to set the property in arm compatibility.
> v1 -> v2:
>    - Change the property name.
> 
> v7: https://lore.kernel.org/all/20250702085616.2172722-1-shahuang@redhat.com/
> v6: https://lore.kernel.org/all/20250701030549.2153331-1-shahuang@redhat.com/
> v5: https://lore.kernel.org/all/20250626034526.2136585-1-shahuang@redhat.com/
> v4: https://lore.kernel.org/all/20250617030521.2109305-1-shahuang@redhat.com/
> v3: https://lore.kernel.org/all/20250609073408.2083831-1-shahuang@redhat.com/
> v2: https://lore.kernel.org/all/20250606070234.2063451-1-shahuang@redhat.com/
> v1: https://lore.kernel.org/all/20250605030351.2056571-1-shahuang@redhat.com/
> 
> Shaoqin Huang (2):
>    ramfb: Add property to control if load the romfile
>    hw/i386: Add the ramfb romfile compatibility
> 
>   hw/core/machine.c             |  2 ++
>   hw/display/ramfb-standalone.c |  4 +++-
>   hw/display/ramfb-stubs.c      |  2 +-
>   hw/display/ramfb.c            |  6 ++++--
>   hw/i386/microvm.c             |  3 +++
>   hw/i386/pc_piix.c             | 10 ++++++++++
>   hw/i386/pc_q35.c              |  3 +++
>   hw/vfio/display.c             |  4 ++--
>   hw/vfio/pci.c                 |  1 +
>   hw/vfio/pci.h                 |  1 +
>   include/hw/display/ramfb.h    |  2 +-
>   11 files changed, 31 insertions(+), 7 deletions(-)
> 

-- 
Shaoqin


