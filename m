Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1416CD3177E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OPb-0006CV-B6; Tue, 05 Nov 2024 13:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8OPZ-0006CD-SD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:36:17 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8OPX-0007et-Tu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:36:17 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so5691593b3a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730831773; x=1731436573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WbgSdr35ADj8CVZXVtT+W19ekxubMbsFsAss1WedoK8=;
 b=bXaKPdWmn3AO6Fdaakynt8vwPuBDMRT0SIAOoATmQZYL3t7k3O8BiY+9XuibmI5weg
 yy+X+s5JOi45qGTQmIdzU6KgWF22bik2W44GESVm1HOGX1cL9imkPNTN4lboUeJuf9Dw
 RFPIqeu+8HsxcT/AZRQzWBQEtCMtbswn+Boe65rtg/RW7Bn5OPT7Q+PVXtVgJ+etsxYM
 tQq0kXRIKlzxsDpsg6amQ7F5pgOtRAAd6bSCHUVK9hl1pDQ2+KMW32GekVgEur+f+E7Q
 fEijqT9Ns3LZcdOZsIY2pW2Ds5Ukn7TjfBt4703FUOlgMAe0z9FS+SEggrXGmINvN4FP
 MQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730831773; x=1731436573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WbgSdr35ADj8CVZXVtT+W19ekxubMbsFsAss1WedoK8=;
 b=KiolRvetLS/EHre/OKjGKwLHlWJyzvl7/A3p0BGP41OYRXZMvHqyccFT3m2WpkK4/1
 U3hRT5yGwujQrsOlMAOEno3qLz/lFB/TGpUxNg5sfhd9IknnXbIvFYbwFuTujFa3Dqgj
 dfCbfm7siOp3m21LJj0nrS38eeBcpGRDf+83LmrenLdOcTWRO+9tT72uIgdCsxxtHbl2
 SZ0++ELMzmB8FEKbUc14eTwspoE15DH+ycvojgYttIL/weyp33WeULYBNL6eHrApz5Ts
 8ShFHeYt4+64NapdBZFaLvnZjNmNLGEvlMzvFRRXBaSAA21o684NRoQxdsIG+x8zy+lq
 cpwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2hkn1ZbaxqRE47hRadK69qMGc6vSJmmOdPFw0D7desk56quGYZGjCsb7K7uk+cFVRI44B76dGH7pc@nongnu.org
X-Gm-Message-State: AOJu0YyRlOUScmKgwZ61F+ZaAjouFvfDTSmtPuMnrNBu5nRNpmZxKUqF
 riJwa4PjMfX6gJfbkRxwasubSvKQvTaV6FNVPCsvZ7lVuqKfV1KDoQ8gPxlXpWwo8wP4RroWCGH
 q
X-Google-Smtp-Source: AGHT+IHf8vxRxu/1MpfS3l0wQPybzUzNUdBgblOcOQ1/bxlYWPEOrKUkuXTNAzetE1ACZivX0vqjkw==
X-Received: by 2002:a05:6a21:3947:b0:1d9:c615:944f with SMTP id
 adf61e73a8af0-1dba52a44afmr25788669637.11.1730831773195; 
 Tue, 05 Nov 2024 10:36:13 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc1b8ccfsm10084654b3a.23.2024.11.05.10.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 10:36:12 -0800 (PST)
Message-ID: <b8e239d2-e0d5-4cac-a074-cb1ed277a08a@ventanamicro.com>
Date: Tue, 5 Nov 2024 15:36:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Support RISC-V IOPMP
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
References: <20240715095702.1222213-1-ethan84@andestech.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240715095702.1222213-1-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

Hi Ethan,


Do you plan to send a new version of this work? It seems to me that we're
a couple of reviews away from getting it merged.


Thanks,

Daniel

On 7/15/24 6:56 AM, Ethan Chen wrote:
> This series implements basic functions of IOPMP specification v0.9.1 rapid-k
> model.
> The specification url:
> https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1
> 
> When IOPMP is enabled, memory access to system memory from devices and
> the CPU will be checked by the IOPMP.
> 
> The issue of CPU access to non-CPU address space via IOMMU was previously
> mentioned by Jim Shu, who provided a patch[1] to fix it. IOPMP also requires
> this patch.
> 
> [1] accel/tcg: Store section pointer in CPUTLBEntryFull
>      https://patchew.org/QEMU/20240612081416.29704-1-jim.shu@sifive.com/20240612081416.29704-2-jim.shu@sifive.com/
> 
> 
> Changes for v8:
> 
>    - Support transactions from CPU
>    - Add an API to set up IOPMP protection for system memory
>    - Add an API to configure the RISCV CPU to support IOPMP and specify the
>      CPU's RRID
>    - Add an API for DMA operation with IOPMP support
>    - Add SPDX license identifiers to new files (Stefan W.)
>    - Remove IOPMP PCI interface(pci_setup_iommu) (Zhiwei)
> 
> Changes for v7:
> 
>    - Change the specification version to v0.9.1
>    - Remove the sps extension
>    - Remove stall support, transaction information which need requestor device
>      support.
>    - Remove iopmp_cascade option for virt machine
>    - Refine 'addr' range checks switch case (Daniel)
> 
> Ethan Chen (8):
>    memory: Introduce memory region fetch operation
>    system/physmem: Support IOMMU granularity smaller than TARGET_PAGE
>      size
>    target/riscv: Add support for IOPMP
>    hw/misc/riscv_iopmp: Add RISC-V IOPMP device
>    hw/misc/riscv_iopmp: Add API to set up IOPMP protection for system
>      memory
>    hw/misc/riscv_iopmp: Add API to configure RISCV CPU IOPMP support
>    hw/misc/riscv_iopmp:  Add DMA operation with IOPMP support API
>    hw/riscv/virt: Add IOPMP support
> 
>   accel/tcg/cputlb.c            |   29 +-
>   docs/system/riscv/virt.rst    |    5 +
>   hw/misc/Kconfig               |    3 +
>   hw/misc/meson.build           |    1 +
>   hw/misc/riscv_iopmp.c         | 1289 +++++++++++++++++++++++++++++++++
>   hw/misc/trace-events          |    3 +
>   hw/riscv/Kconfig              |    1 +
>   hw/riscv/virt.c               |   63 ++
>   include/exec/memory.h         |   30 +
>   include/hw/misc/riscv_iopmp.h |  173 +++++
>   include/hw/riscv/virt.h       |    5 +-
>   system/memory.c               |  104 +++
>   system/physmem.c              |    4 +
>   system/trace-events           |    2 +
>   target/riscv/cpu_cfg.h        |    2 +
>   target/riscv/cpu_helper.c     |   18 +-
>   16 files changed, 1722 insertions(+), 10 deletions(-)
>   create mode 100644 hw/misc/riscv_iopmp.c
>   create mode 100644 include/hw/misc/riscv_iopmp.h
> 

