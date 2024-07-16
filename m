Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6AEC3DA4B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 01:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTWiz-0007j9-Nq; Mon, 15 Jul 2024 21:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sTWiw-0007ic-AU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:11:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sTWit-000449-Nw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 21:11:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxjuuzyJVm89IEAA--.12519S3;
 Tue, 16 Jul 2024 09:11:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsWwyJVmEo1KAA--.26235S3; 
 Tue, 16 Jul 2024 09:11:14 +0800 (CST)
Subject: Re: [PATCH v2 1/4] hw/intc/loongson_ipi_common: Add loongson ipi
 common class
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <20240704033802.3838618-2-maobibo@loongson.cn>
 <3cf8df41-f5b2-49b2-be0f-28c96c0e638f@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4258e01d-1334-dd63-81c3-4895670a9a13@loongson.cn>
Date: Tue, 16 Jul 2024 09:11:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3cf8df41-f5b2-49b2-be0f-28c96c0e638f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxlsWwyJVmEo1KAA--.26235S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4DAw4fAFWDZry8WFy3trc_yoW5CrykpF
 ykCrZ8GryUJrn3Jr13Jr17XFy5Zr95J3Z8JF10qF1UAryDJr1F9w1UWr9Fgw1UJr48Jr1U
 Xr1jqr9ruF17JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.467,
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



On 2024/7/15 下午11:31, Philippe Mathieu-Daudé wrote:
> On 4/7/24 05:37, Bibo Mao wrote:
>> Loongson ipi common class and instance is created here, it comes
>> from file loongson_ipi mostly. For the new added loongson ipi
>> common class, there is four interfaces defined here:
>>   1. Interfaces pre_save/post_load are used for future kvm child class
>>   2. Interface get_iocsr_as can be used for different architectures,
>> now MIPS 3A4000 and LoongArch 3A5000 machine use this ip, can inherit
>> this common class.
>>   3. Interace cpu_by_arch_id is added, by default generic function
>> cpu_by_arch_id() is used to search vcpu from physical cpuid, it is
>> generic searching method. Different machine may define other search
>> methods such binary searching method.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
>>   include/hw/intc/loongson_ipi_common.h |  77 +++++
>>   2 files changed, 471 insertions(+)
>>   create mode 100644 hw/intc/loongson_ipi_common.c
>>   create mode 100644 include/hw/intc/loongson_ipi_common.h
> 
> 
>> +static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, 
>> CPUState *cpu,
>> +                                 uint64_t val,
>> +                                 hwaddr addr, MemTxAttrs attrs)
>> +{
>> +    int i, mask = 0, data = 0;
>> +    AddressSpace *iocsr_as;
>> +    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
>> +
>> +    iocsr_as = NULL;
>> +    if (licc->get_iocsr_as) {
>> +        iocsr_as = licc->get_iocsr_as(cpu);
>> +    }
>> +
>> +    if (!iocsr_as) {
>> +        return MEMTX_DECODE_ERROR;
>> +    }
>> +
>> +    /*
>> +     * bit 27-30 is mask for byte writing,
>> +     * if the mask is 0, we need not to do anything.
>> +     */
>> +    if ((val >> 27) & 0xf) {
>> +        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
> 
> Adding/removing files make noticing the uncommented changes very hard
> (see my v3).
> 
> Here you use little-endian instead of host one. This device is L-E only
> so this makes sense, but I'd have appreciate at least a comment about
> it.

Good catch, there is compile warning when address_space_ldl() is used, 
so address_space_ldl_le() is used to remove compile warning. I will 
double check the compile warning issue.

Regard
Bibo Mao
> 
>> +        for (i = 0; i < 4; i++) {
>> +            /* get mask for byte writing */
>> +            if (val & (0x1 << (27 + i))) {
>> +                mask |= 0xff << (i * 8);
>> +            }
>> +        }
>> +    }
>> +
>> +    data &= mask;
>> +    data |= (val >> 32) & ~mask;
>> +    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
> 
> Ditto.
> 
>> +    return MEMTX_OK;
>> +}
> 


