Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHS5I-0004Nv-RP; Wed, 12 Jun 2024 13:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin.murphy@arm.com>)
 id 1sHS5H-0004N2-8r; Wed, 12 Jun 2024 13:48:31 -0400
Received: from foss.arm.com ([217.140.110.172])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robin.murphy@arm.com>)
 id 1sHS5F-0004mq-3z; Wed, 12 Jun 2024 13:48:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7DD1042;
 Wed, 12 Jun 2024 10:48:49 -0700 (PDT)
Received: from [10.1.27.52] (010265703453.arm.com [10.1.27.52])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8A5D3F64C;
 Wed, 12 Jun 2024 10:48:22 -0700 (PDT)
Message-ID: <ed3df37e-fddd-465c-8ae9-1c5791966995@arm.com>
Date: Wed, 12 Jun 2024 18:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, gshan@redhat.com,
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com,
 shahuang@redhat.com, qemu-riscv <qemu-riscv@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Song Gao <gaosong@loongson.cn>
References: <20240612020506.307793-1-zhenyzha@redhat.com>
 <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
 <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
 <8d7e111b-4f74-4a67-b01b-2af5ce009a06@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8d7e111b-4f74-4a67-b01b-2af5ce009a06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=robin.murphy@arm.com; helo=foss.arm.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024-06-12 1:50 pm, Philippe Mathieu-Daudé wrote:
> On 12/6/24 14:48, Peter Maydell wrote:
>> On Wed, 12 Jun 2024 at 13:33, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> Hi Zhenyu,
>>>
>>> On 12/6/24 04:05, Zhenyu Zhang wrote:
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>> index 3c93c0c0a6..3cefac6d43 100644
>>>> --- a/hw/arm/virt.c
>>>> +++ b/hw/arm/virt.c
>>>> @@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
>>>>        qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
>>>>        qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt");
>>>>
>>>> +    /*
>>>> +     * For QEMU, all DMA is coherent. Advertising this in the root 
>>>> node
>>>> +     * has two benefits:
>>>> +     *
>>>> +     * - It avoids potential bugs where we forget to mark a DMA
>>>> +     *   capable device as being dma-coherent
>>>> +     * - It avoids spurious warnings from the Linux kernel about
>>>> +     *   devices which can't do DMA at all
>>>> +     */
>>>> +    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
>>>
>>> OK, but why restrict that to the Aarch64 virt machine?
>>> Shouldn't advertise this generically in create_device_tree()?
>>> Or otherwise at least in the other virt machines?
>>
>> create_device_tree() creates an empty device tree, not one
>> with stuff in it. It seems reasonable to me for this property
>> on the root to be set in the same place we set other properties
>> of the root node.
> 
> OK. Still the question about other virt machines remains
> unanswered :)

 From the DT consumer point of view, the interpretation and assumptions 
around coherency *are* generally architecture- or platform-specific. For 
instance on RISC-V, many platforms want to assume coherency by default 
(and potentially use "dma-noncoherent" to mark individual devices that 
aren't), while others may still want to do the opposite and use 
"dma-coherent" in the same manner as Arm and AArch64. Neither property 
existed back in ePAPR, so typical PowerPC systems wouldn't even be 
looking and will just make their own assumptions by other means.

Thanks,
Robin.

