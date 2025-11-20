Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3717BCF8847
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3MO-0007aI-8s; Thu, 20 Nov 2025 07:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3M3-0007UM-9v
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:01:39 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3M1-00043J-AD
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:01:38 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3eae4e590a4so239690fac.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763640096; x=1764244896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3tFfvdkAZuykFuhavubWzW+tt7BCO4yozz0yoia5Ao=;
 b=HggfpDCJcXEYUArSTse0OEKXb5AbUdCJPd+phNMW97nmUeebpr3uQAcJS0bwFyENv8
 Xe+RQhuBgn4/L0I2jJEj4lt07jQmAS0cSLfSDzsLoi6FhswvhVuYenc6YJE+3Ru5ypj9
 J9X0fVtWoNh6LN178ivsdD8G4fLdvAVZ/cxwI+0sbLV9p0hMnI5V9Hd5q8DE3oI/n3cv
 JQDe8mixwO8FZqj5QFPIqToWe/HZ+z6TrQN7FtXs9MCH4Wsb+mBTCTFo8wWP6Ui8Gfrp
 bVCNF0CKGE0Ulat1tawc5VioXeF4w/vAkUuRArPG4H8YlUBXogb6WxPwehWgPdzh++Or
 1Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763640096; x=1764244896;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R3tFfvdkAZuykFuhavubWzW+tt7BCO4yozz0yoia5Ao=;
 b=ZnNTlMOif08+4ugdV1xKEFNuligXiMhxgugGdcGXY6WlsZusrYmVU911tHYM4IwmY4
 Tu0I1Nj6Dp2NdiQGpZr+E2wplSZ7tBbKpQzSv66rq9xSTUpdzuTbEI8+9YSbqBwh2OJ+
 jihWDK0xrTJHBHJE+5w0jm/iEXD0LGNvqEFhf5tyIq74Ai0Rqqvb6QzgAs7oNUQJgvPK
 wcyi3TVzyCM9Gtab3/0pSptU7m1mZGX6q+aFc7SYppntwEOjwvRFjIwqVQz/Yi/7KPvz
 P2huLStfFjzrsUFNvdDFl+D4YnnwLScO0HEUh4+6uXpY2ixqXBwM4X0YtigdvbM+bhHe
 vpww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq6tWI1VpisUcpYH6Lz2HC72KGVSygSahITc7zsDIf6WHrQUieWN39VeS9L60uXG3Mm0CehknQyKJi@nongnu.org
X-Gm-Message-State: AOJu0YzLx2i9yumdd4RTl0UFetOEIBGm6bKW4UytltFoGShwEr1ggegi
 +YokDmlcVu4ICmlg8ypTxoFDTGzbUard5YncvFfbXaIZK995kJsGKAeKRL8nLLGsyIePG0aXWCa
 ZKhpL8p4=
X-Gm-Gg: ASbGnctVHjmfzcPyi/AZSuJCvWuZ9rg/AQQBb6DpKhJIlgLxvSwXmpajmhg0h7THKLs
 pmdG9Q0j40J1R26lymz3UT6DscuQeUR2lqYrbw+4mV2a8WgDP437S0Y/giL24aqn+g2264NUx/6
 KWKaQNIonxAaS18Do7XNMvwzvGb9Mbj4GUvfGaVTnQvVIjmyWRm3Z3qgeReCcJnm4qfjtjGeEqx
 5D/cXQhrb33gYvZqRKLLWDZEXUEcyyBSdcsF33/jIkYNamxKy+KlOTQdOrlDp1zchUWfgWtVOaK
 k2JMfZ78+NDwz4HMuf5DLXq6tyPQv8Tk35EaWlo/x3vhhu74uXExSQBy0oMeU60EfU4zhxLyjwA
 tFXnK1LEkmtn9BZXEg1QAgqYYnnMdvLjEU1LRZsRdv0aD/P7AEnfZGlJDMEliwFyQRcGsoBIwHx
 mMe2R8NI6e8+nVaGxLodAyuewWvaU=
X-Google-Smtp-Source: AGHT+IGV9UOPEolf+O/M/6ZC2/Z/P8nRN0SdULeS0yEW1pLRV3BLqckkS94HTSAX38CbYougemuDJA==
X-Received: by 2002:a05:6871:228b:b0:306:c53a:f904 with SMTP id
 586e51a60fabf-3ec9a400f1bmr1641698fac.9.1763640095898; 
 Thu, 20 Nov 2025 04:01:35 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc8ab10sm1023731fac.16.2025.11.20.04.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 04:01:34 -0800 (PST)
Message-ID: <71ca906b-5365-43c8-be54-6f0a85bbe0c6@ventanamicro.com>
Date: Thu, 20 Nov 2025 09:01:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] hw/riscv: add CBQRI controllers to virt machine
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>, Vasudevan Srinivasan
 <vasu@rivosinc.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-7-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-7-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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



On 11/19/25 9:42 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Add CBQRI controllers to the RISC-V virt machine. The device properties
> can be fully configured from the command line:
> 
>    $ qemu-system-riscv64 -M virt ... \
>        -device riscv.cbqri.capacity,mmio_base=0x04828000[,...]
>        -device riscv.cbqri.bandwidth,mmio_base=0x04829000[,...]
> 
> The mmio_base option is mandatory, the others are optional.
> 
> Many -device arguments as wanted can be provided as long as their
> mmio regions don't conflict.
> 
> To see all possible options:
> 
>    $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
>    riscv.cbqri.capacity options:
>      alloc_op_config_limit=<bool> -  (default: true)
>      alloc_op_flush_rcid=<bool> -  (default: true)
>      alloc_op_read_limit=<bool> -  (default: true)
>      at_code=<bool>         -  (default: true)
>      at_data=<bool>         -  (default: true)
>      max_mcids=<uint16>     -  (default: 256)
>      max_rcids=<uint16>     -  (default: 64)
>      mmio_base=<uint64>     -  (default: 0)
>      mon_evt_id_none=<bool> -  (default: true)
>      mon_evt_id_occupancy=<bool> -  (default: true)
>      mon_op_config_event=<bool> -  (default: true)
>      mon_op_read_counter=<bool> -  (default: true)
>      ncblks=<uint16>        -  (default: 16)
>      target=<str>
> 
>    $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
>    riscv.cbqri.bandwidth options:
>      alloc_op_config_limit=<bool> -  (default: true)
>      alloc_op_read_limit=<bool> -  (default: true)
>      at_code=<bool>         -  (default: true)
>      at_data=<bool>         -  (default: true)
>      max_mcids=<uint16>     -  (default: 256)
>      max_rcids=<uint16>     -  (default: 64)
>      mmio_base=<uint64>     -  (default: 0)
>      mon_evt_id_none=<bool> -  (default: true)
>      mon_evt_id_rdonly_count=<bool> -  (default: true)
>      mon_evt_id_rdwr_count=<bool> -  (default: true)
>      mon_evt_id_wronly_count=<bool> -  (default: true)
>      mon_op_config_event=<bool> -  (default: true)
>      mon_op_read_counter=<bool> -  (default: true)
>      nbwblks=<uint16>       -  (default: 1024)
>      target=<str>
> 
> Boolean options correspond to hardware capabilities that can be disabled
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/virt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 17909206c7ef..498f606d33b1 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,7 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/riscv/cbqri.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
>   #include "hw/uefi/var-service-api.h"
> @@ -1941,6 +1942,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>   #ifdef CONFIG_TPM
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>   #endif
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_BC);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_CC);
>   
>       object_class_property_add_bool(oc, "aclint", virt_get_aclint,
>                                      virt_set_aclint);
> 


