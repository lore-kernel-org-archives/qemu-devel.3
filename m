Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8FBE67495
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 07:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXaRL-0006bG-Vk; Mon, 22 Dec 2025 02:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vXaQu-0006aI-Ga
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 02:34:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vXaQq-0003el-JY
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 02:34:20 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxqsJr9EhpSdkBAA--.5702S3;
 Mon, 22 Dec 2025 15:34:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx38Jo9Ehp80YDAA--.10109S3;
 Mon, 22 Dec 2025 15:34:02 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Permit bytes/half access to IOCSR
To: Yao Zi <me@ziyao.cc>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
References: <20251221122205.56463-2-me@ziyao.cc>
 <ad1e33d6-8568-e050-f7d8-eb656a4af729@loongson.cn> <aUju2fhuuF5rs96H@pie>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <cd836bb8-c1a9-fd4d-7fef-557c9328faa7@loongson.cn>
Date: Mon, 22 Dec 2025 15:31:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aUju2fhuuF5rs96H@pie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38Jo9Ehp80YDAA--.10109S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCrWkuF1rWF4UCFWkuFW8KrX_yoW5Jw4UpF
 yDuFs8AFWUtrn7AF4vq3ZrXFZ5AwsrGrW3W347Kryruw15Zw13Zr40g3yY9F97Wws5Gw10
 qry0gasaqFWDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8r9N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.354,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/12/22 下午3:12, Yao Zi wrote:
> On Mon, Dec 22, 2025 at 11:24:38AM +0800, Bibo Mao wrote:
>>
>>
>> On 2025/12/21 下午8:22, Yao Zi wrote:
>>> IOCSRs could be accessed in any sizes from 1 to 8 bytes as long as the
>>> address is aligned, regardless whether through MMIO or iocsr{rd,wr}
>>> instructions. Lower min_access_size to 1 byte for IOCSR memory region to
>>> match real-hardware behavior.
>> Hi Yao,
>>
>> What is the detailed problem you encountered? Or just look through code and
>> think that it should be so.
> 
> I don't think there's a real use-case for this. However, without the
> patch, the behavior of iocsrrd.b differs between real hardware and QEMU,
> you could try this diff with Linux kernel for comparing.
> 
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 25a87378e48e..679e311ac654 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -621,3 +621,13 @@ void __init setup_arch(char **cmdline_p)
>   	kasan_init();
>   #endif
>   }
> +
> +static int __init read_iocsr(void)
> +{
> +	pr_info("%s: iocsrrd_b(0x10) = 0x%x\n", __func__,
> +		__iocsrrd_b(0x10));
> +
> +	return 0;
> +}
> +
> +late_initcall(read_iocsr);
> 
> On QEMU, the error raised by address_space_ldub is silently ignored by
> helper_iocsrrd_b(), and thus __iocsrrd_b(0x10) results in zero, while on
> real hardware it doesn't.
In general we should write code based on user manual rather than 
experience, is that right?

Also you can try readb/writeb API with generic PCI devices and check 
whether the emulated PCI device is the same with real device.

Regards
Bibo Mao
> 
> Ignoring the error returned by address_space_{ld,st}* in helper_iocsr*
> could cause more behaviors inconsistent with real LoongArch hardware.
> But in the case shown in the diff that a single byte is read from iocsr,
> the access shouldn't fail at all, which this patch tries to fix.
> 
> Regards,
> Yao Zi
> 
>> IOCSR supports 1/2/4/8 byte access like MMIO, however here is IOCSR MISC
>> device rather than IOCSR bus emulation. What is the usage and scenery to
>> read IOCSR MISC device with one byte?
>>
>> It is similar with other device emulation with MMIO, such as e1000e with 4
>> bytes aligned rather than any byte:
>> static const MemoryRegionOps mmio_ops = {
>>      .read = e1000e_mmio_read,
>>      .write = e1000e_mmio_write,
>>      .endianness = DEVICE_LITTLE_ENDIAN,
>>      .impl = {
>>          .min_access_size = 4,
>>          .max_access_size = 4,
>>      },
>> };
>>
>>
>> Regards
>> Bibo Mao


