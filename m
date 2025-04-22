Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F45AC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DWf-0006xj-Rb; Tue, 22 Apr 2025 09:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7DWY-0006pg-JL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:18:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7DWV-0002Ep-2x
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:18:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3660263f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745327929; x=1745932729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=77yyRGOmizuCBU9T40JZpDpZACJ9np8VqGyH6gRCUB4=;
 b=QFOohJpFyLwK+dgWjvjHD/xMrVi1xg/tlL2Nna51t6OYiNfX5eyLo5wdq2LK8aWSem
 QNCC1smf7NnDa4DZUQjZzbrM3cimDuCdRYftAgOu8++YtHm/UiXZO1MYBpKITudZX0k2
 VwAHCXX6M5TyAX74mm/FNauK+gJM01U5O1OtpksPbHPAd0NOk4XJD5rdxslSpVoWrqhD
 Jndn4dAollepPzhwiBMspV4Hlr9I7h0b7Dg3eX4Tag22Uq4ct19JmvIFz2D0rKey0DFv
 UeMS9RtcFi8hV81t9Brn5z3tE9AfkJjzWK35kPNGpP96DRkqYqZNphBZEy9lgU9kt74f
 1lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745327929; x=1745932729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77yyRGOmizuCBU9T40JZpDpZACJ9np8VqGyH6gRCUB4=;
 b=nKlJg1Y9L4vkkl60e2pNGyMAuva6v1ijNmTV+MG0bQ58GziZKRkEDmgxWorv0j9Hm3
 iG8n/q7y6X+bRa7pQZLGc+bskGk8pq6ARuWYL/CwVcv7Qt28DcChHlAcr3kuHEmidbGo
 LknGycqZ0uxQf7Ow2cPDwA6Jt/LJGTrhe1Z5YEA4bvTSXmAKDph56s/W7mqsofiTjWTQ
 IU02qKfdTNia6y8lx2CrrzgXuLQOHSSIKDv1LGQtPR2DaydP0JkAkc00x8+H/mB8KCDw
 aGhdMRzbaXWgJf0MmU2fcaloUf4zT6i4g25P1afIE/t8R58aRKe9mnrF+2EdNClt/9ds
 2tTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjL0L64cp+mRTucRRWOPibtxfL1Iyvz5ZIU1vtm5M9jCebdMbBPvrbgY07lapXLF2Bb/V/HYLATqf3@nongnu.org
X-Gm-Message-State: AOJu0Yy6+DHVMer5NYRWFf8fClD3UGpNqL/yUq8vakE0T/4A026QcGQi
 rdIzJr0tOjZ0y1ew2+oX5EFWDhsVEh1iLv4jZXVbj3Rp9x6C/iTbg4v3KhSDXv4=
X-Gm-Gg: ASbGnctn71IkFoqsdC6rJYDvGbD8JK+YxDGzuGE1kpT1Go02B07AN+eoUvdr00qwmGA
 qJrkV4DLuFvi5zSRwnKC54/Qa3/ZGUK4OnirdHNsmzxRgHQ+nQ6ypKQJrxnfN3HnNrUmy/ff39u
 WfR1faVu9t8X/p/lAZejDu52a+2UIs1uG+ZKOwPUq77i1LqnSZgNAM0QNMlO9IofO2B85UcEwYG
 l14W+kg8f8QDZbMGgoOC5QcoNCajvz2aY26N9Cuw/iiGozj3W31v7OqMHSOrVbpVUpp45cZYs9y
 6Y522/gk+FcIKv9C8Eb7ML8sjYgpkj9lhSSULj+Ef1LSohMe1lX9LIfTEJllEFVGlbqqephjp4T
 IoKlMhEQC
X-Google-Smtp-Source: AGHT+IEL8+8yNAzYoFl7rHop8v29EoyfHs3G1wMeezbwtgfEJzcFJTcarL8ri1g8Alw1DWNqtTwoFQ==
X-Received: by 2002:a5d:4345:0:b0:39f:f0e:8328 with SMTP id
 ffacd0b85a97d-39f0f0e83aamr3307811f8f.35.1745327928757; 
 Tue, 22 Apr 2025 06:18:48 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207basm15053641f8f.5.2025.04.22.06.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 06:18:48 -0700 (PDT)
Message-ID: <c67391b9-297f-478b-aea5-c27b0dba6cfd@linaro.org>
Date: Tue, 22 Apr 2025 15:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] acpi: Add machine option to disable SPCR table
To: Li Chen <me@linux.beauty>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
 <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
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

Hi,

On 22/4/25 14:05, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> The ACPI SPCR (Serial Port Console Redirection) table allows firmware
> to specify a preferred serial console device to the operating system.
> On ARM64 systems, Linux by default respects this table: even if the
> kernel command line does not include a hardware serial console (e.g.,
> "console=ttyAMA0"), the kernel still register the serial device
> referenced by SPCR as a printk console.
> 
> While this behavior is standard-compliant, it can lead to situations
> where guest console behavior is influenced by platform firmware rather
> than user-specified configuration. To make guest console behavior more
> predictable and under user control, this patch introduces a machine
> option to explicitly disable SPCR table exposure:
> 
>      -machine spcr=off
> 
> By default, the option is enabled (spcr=on), preserving existing
> behavior. When disabled, QEMU will omit the SPCR table from the guest's
> ACPI namespace, ensuring that only consoles explicitly declared in the
> kernel command line are registered.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Changes since V1: add Reviewed-by and Acked-by
> 
>   hw/arm/virt-acpi-build.c       |  5 ++++-
>   hw/core/machine.c              | 22 ++++++++++++++++++++++
>   hw/loongarch/virt-acpi-build.c |  4 +++-
>   hw/riscv/virt-acpi-build.c     |  5 ++++-
>   include/hw/boards.h            |  1 +
>   qemu-options.hx                |  5 +++++
>   6 files changed, 39 insertions(+), 3 deletions(-)


> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f22b2e7fc7..cdf2791a50 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -444,6 +444,7 @@ struct MachineState {
>       SmpCache smp_cache;
>       struct NVDIMMState *nvdimms_state;
>       struct NumaState *numa_state;
> +    bool enable_spcr;

I'm a bit reluctant to add a field used by 3 virt machines as
generic in MachineState. Shouldn't it be for each machine state?

Also I'm surprised we announce the SPCR table regardless a virt
serial exists. Shouldn't we have a disabled default and only
enable on virt machines, preferably checking the serial port
availability?

>   };
>   
>   /*
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..953680595f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>       "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>       "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>       "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> +    "                spcr=on|off controls ACPI SPCR support (default=on)\n"
>   #ifdef CONFIG_POSIX
>       "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>   #endif
> @@ -105,6 +106,10 @@ SRST
>           Enables or disables ACPI Heterogeneous Memory Attribute Table
>           (HMAT) support. The default is off.
>   
> +    ``spcr=on|off``
> +        Enables or disables ACPI Serial Port Console Redirection Table
> +        (SPCR) support. The default is on.

