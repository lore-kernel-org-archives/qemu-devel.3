Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218FF8FA71
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 13:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFAhl-00061Y-7e; Tue, 21 Apr 2026 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAhh-0005zk-BG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:59:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFAhf-000094-KD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 08:59:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so42909705e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776776386; x=1777381186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHsE+jZfljutcFeH25QlbrNIggxAWepn5LTEgZuBN04=;
 b=eWLQISzac1ps5K9NQq+KZbumGL6psgRht/3Fz0vFxIi5oGRczeWBOG1OD08oYXxj2k
 rhBCbF9Yx6vGSbkX554jWaiE/5Grz0e3EtRRD3sAkXhIfuu2xYlIbcqrnN3cX1kazshX
 r2J9XZsKPr6VUHERAxjlWCC1x4r7diRzgdGofQO6orzOJf22wMFUxnhx3GbiwsIxRVgW
 9oEBmdhKtoZpUGvPPVDPpa1PbjTKSs/tDE4q+FqOQ7E17DDt6sJHPO5h9VcHjdCNIYaU
 N1uze9SrvkuC5ExoYzpNZ0nhDdEApOycP8PAXMcqOH2PMtnJ3w0XWRS7mWaFqzjHZf2P
 dpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776386; x=1777381186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FHsE+jZfljutcFeH25QlbrNIggxAWepn5LTEgZuBN04=;
 b=g2Dmhy5BpG5duXO3FSXz9qfaLyFSEmJz3hYyMxwgJEZc4q0t1pmGgCg9eNSNoymA93
 XHEV2zIToIg/coEHU3SatWeYYuCjBc56h5CERMvDsGAUUQg3hs+6ZFUvIywVYxyzo1zV
 sfoU1ENvqq8Uh8ow3bTl6Cs+c6MNSqaXG8TA9PZw2x3/PDJ9JVrU4O0RXUkhISzia+CT
 TFNb9JQBjCp7TyrIJzPNB4wSsWraasifc27ySIMHp1pyixilPK5ygqG9wqsT9BSmcarq
 bf4MdLYSRbVB+wIAhhQHtx5bKQI8RcT1u6rMyZhJfujEsVs+4ph2M9DRc1Bdf3rUS7iB
 6IUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BdyPR4EVvTweQes5C/uSQ7TVhYrgUiO4D4pA2Czm0eTvI9QMp+emb9VVD9QXRKFNFoYOt1BOiwInI@nongnu.org
X-Gm-Message-State: AOJu0YxjEWFWpOmxf4BaS8UtTmsIs1/JkxnNHBa26wnOMei5B4VCdJea
 jaoxc0rXtBHrLsRfefr0qu5vC5WaN+hmHKLgWEXDwh81oCmTTrxrCLCSPmjHH2B4bFQ=
X-Gm-Gg: AeBDieuYaMJU9DpuOnRYJwWzBncLmZI0BjshC4UgfrecM0dmfUybtzi2QXgaKanScWa
 xZZo50TCc2TdCffiEQ3t+e6+DjnQNZj7RukEn2fQ4aRsJMC3CyjHB/8m73c2OeMoB8r5K6HN4S+
 2LXqzuddDVGvZeIubBXjbV0VSeJfSph/dCAYV9DROeXjxpqMVhLAM8OyLPZ+x1EvbH5SWAFVsBi
 czveQo4oPY8SzyJ1VjBpK3IWbWloGD5WsuLBVfGsaDz2RvaW1nqKI5l/crfd/m5OeKc8hpqX/KX
 gIqyJwEI3qsDKMcxYko7UAxlNoZZRzjmDBla239JCTF06ClqQISFGszJxcC/1Sez2O4If9SHf3T
 DLfR+FEX8iQofwhHhKhBioL+ArwhQ5H/JJkHXZvxsl5AM7dUu08PBL58jGLobODcGoQcGhXMNmB
 FdO8Yw+lzQbAI2FAU1kWUucyQiuC7bIuAg+UACLFJg7y5gWTh0PNqwP5nLMWYAh5537iK6hOgdF
 d1zPL7pZu28
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id
 5b1f17b1804b1-48a56dedadfmr20938815e9.27.1776776385747; 
 Tue, 21 Apr 2026 05:59:45 -0700 (PDT)
Received: from [10.193.39.66] (140.170.88.92.rev.sfr.net. [92.88.170.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm41904726f8f.37.2026.04.21.05.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 05:59:45 -0700 (PDT)
Message-ID: <20ba60c7-4929-418a-8596-c531243fec99@linaro.org>
Date: Tue, 21 Apr 2026 14:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] hw/riscv/atlantis: Add PCIe controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-11-joel@jms.id.au>
 <d133505a-8a81-458d-a0f0-8b17ff5c0eab@linaro.org>
 <aeceurHJHEa_HgvZ@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aeceurHJHEa_HgvZ@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/4/26 11:10, Nicholas Piggin wrote:
> On Tue, Apr 21, 2026 at 07:59:32AM +0200, Philippe Mathieu-Daudé wrote:
>> On 21/4/26 07:31, Joel Stanley wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> tt-atlantis is likely to use a generic ECAM compatible PCIe memory map,
>>> so gpex is not far off the OS programming model
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> v3: Avoid leaks in the dt string allocation
>>> ---
>>>    include/hw/riscv/tt_atlantis.h |   2 +
>>>    hw/riscv/tt_atlantis.c         | 225 ++++++++++++++++++++++++++++++++-
>>>    hw/riscv/Kconfig               |   2 +
>>>    3 files changed, 228 insertions(+), 1 deletion(-)
>>
>>
>>> +static void create_fdt_pcie(void *fdt,
>>> +                            const MemMapEntry *mem_ecam,
>>> +                            const MemMapEntry *mem_pio,
>>> +                            const MemMapEntry *mem_mmio32,
>>> +                            const MemMapEntry *mem_mmio64,
>>> +                            int legacy_irq,
>>> +                            uint32_t aplic_s_phandle,
>>> +                            uint32_t imsic_s_phandle)
>>> +{
>>> +    g_autofree char *name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
>>> +                                            mem_ecam->base);
>>> +
>>> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
>>> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
>>> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
>>> +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
>>> +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
>>> +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
>>> +                           mem_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
>>> +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
>>> +    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
>>> +
>>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>>> +                                 2, mem_ecam->base,
>>> +                                 2, mem_ecam->size);
>>> +    if (!(mem_mmio32->base & 0xffffffffUL)) {
>>> +        /* XXX: this is a silly hack because it would collide with PIO */
>>
>> Could you explain a bit more?
> 
> Ah this is a bit incomplete sorry I didn't catch it earlier. Before the
> mapping was finalised I just added this hacky way to determining PCIe IO
> address based on the physical address.
> 
> This should just go away and the IO addresses come from a different table.

Ah good, thanks for the explanation.

Regards,

Phil.

