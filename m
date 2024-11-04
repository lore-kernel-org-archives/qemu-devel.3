Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2609AD1BDD4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81IZ-0005hj-Ch; Mon, 04 Nov 2024 12:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t81IW-0005hU-SG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:55:28 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t81IR-0003Ja-IP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:55:28 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso3546469b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730742922; x=1731347722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6VOGJfhosPhm+97I1oRcLNlin6jFFhMY0z3OWLPYjY=;
 b=REGd4sAq/KIpcWRwJBwYuW1X7GQSyWsvstj+Nfe6+gSAF4rb+5qhQOEzC8YsDQN5Nv
 b4d6MVnWSr/Ne97yEClL9jbj5A1G4Kd/zI0gUNCJRQ93qpm8y0UTaj4VNn8vsRLSHQ3X
 /YTnFSZj5DZvgkGxtK62HvgzE6LhRknuv0mUUv9Aikfd5zsLuNj4FW1eQLcNDYf3/njh
 y5LDvS0T+Vcoa7H6uPndtaGhNk+WsSPQTWj6eN+wFQ6k0UaGx2Krl3tWn2N601+1hnpR
 cDReO0Lf5XlJzVrvUC2ehpF9j8iOnQOJ1RZOZw65gNGWTgxfCGQzFN0DudgBinYWQ4gh
 F0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742922; x=1731347722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6VOGJfhosPhm+97I1oRcLNlin6jFFhMY0z3OWLPYjY=;
 b=k3n4e0gkLnadlnYgNtywlA54QJBqAnkGoi98fkEHViNuKpOx0elPXhfUSXnOKEQTTS
 XEYxJ3vImMX1FJCxwMJKxr52Umbsk05avMH4VPoXfYmJreXj6ZOGZfcHI328FH6wX/EF
 hCnWUNIgA6Ta5qsnagAuUSv5YWo6Li+FBapIIWctfPsKaJP48VP2IqqAs0lc8izDfcCZ
 gEZ7y4Qx2Ra8EoVNdS+4ZTfW9N9UkVL0GWSd26507dFpWeOoA5zSqlyYI5OTd3otYbtv
 TzXzoYm9Da4N4/RtPfYk88pTIdaZAnIJ8giK3ieanMfX2GEQHDkHikIJbuhpBvpGXxqc
 hGcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxTrWOp/AkDYHbZqckNfLZjg5fNYdunvBmdcRtFZaDU8PywNDpM2+L6Y7/HYcBQW0Te2wxvGbbNubS@nongnu.org
X-Gm-Message-State: AOJu0YyMjlNFK57lbxf7zNlCaUBPKDhyEpd4iXWou9SIULPnvSKbXCkQ
 8UILBTg+ZmEPepinbziJ/Mcksv2x27AovLHEztuXKvKH5C+74Lp/cUS/EMb4S24=
X-Google-Smtp-Source: AGHT+IHPOXusixGmxPpk17Y+ACcpyV6eleeqjIVI+5KDM7X7bfwvEOGKDVQbcTYI6TDxOcnBpJkHLQ==
X-Received: by 2002:a05:6a20:7288:b0:1d8:a67e:d323 with SMTP id
 adf61e73a8af0-1dba423639cmr19982821637.22.1730742921780; 
 Mon, 04 Nov 2024 09:55:21 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee5da842absm4985612a12.17.2024.11.04.09.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 09:55:21 -0800 (PST)
Message-ID: <5e0d5a1d-55ba-472e-a62c-e38a629e4878@ventanamicro.com>
Date: Mon, 4 Nov 2024 14:55:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/50] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Deepak Gupta <debug@rivosinc.com>,
 Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Rob Bradford <rbradford@rivosinc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 11/1/24 10:39 AM, Michael Tokarev wrote:
> 31.10.2024 06:52, Alistair Francis wrote:
> 
>> ----------------------------------------------------------------
>> RISC-V PR for 9.2
>>
>> * Fix an access to VXSAT
>> * Expose RV32 cpu to RV64 QEMU
>> * Don't clear PLIC pending bits on IRQ lowering
>> * Make PLIC zeroth priority register read-only
>> * Set vtype.vill on CPU reset
>> * Check and update APLIC pending when write sourcecfg
>> * Avoid dropping charecters with HTIF
>> * Apply FIFO backpressure to guests using SiFive UART
>> * Support for control flow integrity extensions
>> * Support for the IOMMU with the virt machine
>> * set 'aia_mode' to default in error path
>> * clarify how 'riscv-aia' default works
> 
> Is there anything in there which is worth picking up for qemu-stable?

I believe everything that has a "Fixes" tags can be ported to qemu-stable.

As for what should be ported to older stables, unless there's an open bug in Gitlab
that is aimed at an older stable release I wouldn't worry about it. Applying in the
current qemu-stable is enough.


Thanks,

Daniel

> I see numerous "fixes" in there, but I'm not sure which is which and
> what is important to have working in 9.1, 9.0, 8.2 (ubuntu lts) or 7.2...
> (I've added some CCs)
> 
> Thanks,
> 
> /mjt
> 
>> ----------------------------------------------------------------
>> Alistair Francis (2):
>>        hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
>>        hw/char: sifive_uart: Print uart characters async
>>
>> Anton Blanchard (1):
>>        target/riscv: Fix vcompress with rvv_ta_all_1s
>>
>> Daniel Henrique Barboza (6):
>>        pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>>        test/qtest: add riscv-iommu-pci tests
>>        qtest/riscv-iommu-test: add init queues test
>>        docs/specs: add riscv-iommu
>>        target/riscv/kvm: set 'aia_mode' to default in error path
>>        target/riscv/kvm: clarify how 'riscv-aia' default works
>>
>> Deepak Gupta (20):
>>        target/riscv: expose *envcfg csr and priv to qemu-user as well
>>        target/riscv: Add zicfilp extension
>>        target/riscv: Introduce elp state and enabling controls for zicfilp
>>        target/riscv: save and restore elp state on priv transitions
>>        target/riscv: additional code information for sw check
>>        target/riscv: tracking indirect branches (fcfi) for zicfilp
>>        target/riscv: zicfilp `lpad` impl and branch tracking
>>        disas/riscv: enable `lpad` disassembly
>>        target/riscv: Expose zicfilp extension as a cpu property
>>        target/riscv: Add zicfiss extension
>>        target/riscv: introduce ssp and enabling controls for zicfiss
>>        target/riscv: tb flag for shadow stack instructions
>>        target/riscv: mmu changes for zicfiss shadow stack protection
>>        target/riscv: AMO operations always raise store/AMO fault
>>        target/riscv: update `decode_save_opc` to store extra word2
>>        target/riscv: implement zicfiss instructions
>>        target/riscv: compressed encodings for sspush and sspopchk
>>        disas/riscv: enable disassembly for zicfiss instructions
>>        disas/riscv: enable disassembly for compressed sspush/sspopchk
>>        target/riscv: Expose zicfiss extension as a cpu property
>>
>> Evgenii Prokopiev (1):
>>        target/riscv/csr.c: Fix an access to VXSAT
>>
>> LIU Zhiwei (2):
>>        target/riscv: Add max32 CPU for RV64 QEMU
>>        tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
>>
>> Rob Bradford (1):
>>        target/riscv: Set vtype.vill on CPU reset
>>
>> Sergey Makarov (2):
>>        hw/intc: Make zeroth priority register read-only
>>        hw/intc: Don't clear pending bits on IRQ lowering
>>
>> TANG Tiancheng (6):
>>        target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>>        target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>>        target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>>        target/riscv: Detect sxl to set bit width for RV32 in RV64
>>        target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>>        target/riscv: Enable RV32 CPU support in RV64 QEMU
>>
>> Tomasz Jeznach (8):
>>        exec/memtxattr: add process identifier to the transaction attributes
>>        hw/riscv: add riscv-iommu-bits.h
>>        hw/riscv: add RISC-V IOMMU base emulation
>>        hw/riscv: add riscv-iommu-pci reference device
>>        hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>>        hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>>        hw/riscv/riscv-iommu: add ATS support
>>        hw/riscv/riscv-iommu: add DBG support
>>
>> Yong-Xuan Wang (1):
>>        hw/intc/riscv_aplic: Check and update pending when write sourcecfg
> 
> 
> 

