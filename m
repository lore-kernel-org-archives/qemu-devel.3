Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87625C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1H0W-0004vd-1W; Sun, 28 Apr 2024 22:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1H0T-0004vO-RO
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:44:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1H0Q-0005MT-QC
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:44:41 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxfeuRCS9muMQEAA--.12474S3;
 Mon, 29 Apr 2024 10:44:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxTN6OCS9mJqQJAA--.24498S3; 
 Mon, 29 Apr 2024 10:44:32 +0800 (CST)
Subject: Re: [PULL 02/17] hw/loongarch: Add load initrd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
References: <20240428085117.2422473-1-gaosong@loongson.cn>
 <20240428085117.2422473-3-gaosong@loongson.cn>
 <dd6d6a05-386f-4555-a3d7-d4f769fff81b@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5abe3aca-d08c-fc33-412b-8a55a5f42597@loongson.cn>
Date: Mon, 29 Apr 2024 10:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dd6d6a05-386f-4555-a3d7-d4f769fff81b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxTN6OCS9mJqQJAA--.24498S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWUZF45CrW3WrWDWFWkXwc_yoW5Zrykpr
 4kJry5Gry5Arn5Jr17JryUuFy5Jr18J3Z8XF1xXFyUJr47tr1qqr1UXr92grWDJw4rGr1U
 Jr1DJr1jvF1UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.702,
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

在 2024/4/29 上午2:59, Richard Henderson 写道:
> On 4/28/24 01:51, Song Gao wrote:
>> we load initrd ramdisk after kernel_high address
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Message-Id: <20240426091551.2397867-3-gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 9feed17db3..a9522d6912 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -22,7 +22,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void 
>> *opaque, uint64_t addr)
>>     static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>   {
>> -    uint64_t kernel_entry, kernel_low, kernel_high;
>> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
>> +    ram_addr_t initrd_offset;
>>       ssize_t kernel_size;
>>         kernel_size = load_elf(info->kernel_filename, NULL,
>> @@ -37,6 +38,32 @@ static int64_t load_kernel_info(struct 
>> loongarch_boot_info *info)
>>                        load_elf_strerror(kernel_size));
>>           exit(1);
>>       }
>> +
>> +    if (info->initrd_filename) {
>> +        initrd_size = get_image_size(info->initrd_filename);
>> +        if (initrd_size > 0) {
>> +            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 
>> 64 * KiB);
>> +
>> +            if (initrd_offset + initrd_size > info->ram_size) {
>> +                error_report("memory too small for initial ram disk 
>> '%s'",
>> +                             info->initrd_filename);
>> +                exit(1);
>> +            }
>> +
>> +            initrd_size = load_image_targphys(info->initrd_filename, 
>> initrd_offset,
>> +                                              info->ram_size - 
>> initrd_offset);
>> +        }
>> +
>> +        if (initrd_size == (target_ulong)-1) {
>> +            error_report("could not load initial ram disk '%s'",
>> +                         info->initrd_filename);
>> +            exit(1);
>> +        }
>> +    } else {
>> +        error_report("Need initrd!");
>> +        exit(1);
>> +    }
>> +
>>       return kernel_entry;
>>   }
>
> This doesn't simply allow initrd, it requires an initrd.
> This causes make check-tcg to fail:
>
>>   TEST    interrupt on loongarch64
>> qemu-system-loongarch64: Need initrd!
>
> https://gitlab.com/qemu-project/qemu/-/jobs/6733983794
I'm sorry I missed this test.  I will send v2 fix this problem and the 
job [1] failed

[1] https://gitlab.com/qemu-project/qemu/-/jobs/6733983763

Thanks.
Song gao


