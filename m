Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9942AC25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 01:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBPZ7-00082A-4q; Sun, 26 May 2024 21:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sBPZ5-00081I-88; Sun, 26 May 2024 21:54:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1sBPZ1-0006pU-DA; Sun, 26 May 2024 21:54:19 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxL_C751NmXQIAAA--.129S3;
 Mon, 27 May 2024 09:54:03 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxZcW451Nm4ZsKAA--.17292S3; 
 Mon, 27 May 2024 09:54:02 +0800 (CST)
Subject: Re: [PULL 01/10] target/loongarch/kvm: Fix VM recovery from disk
 failures
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>
References: <20240523014637.614872-1-gaosong@loongson.cn>
 <20240523014637.614872-2-gaosong@loongson.cn>
 <78c5abe1-546d-4ced-a160-a087ff3326ce@tls.msk.ru>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3df90839-c24d-f580-8049-cc20df443919@loongson.cn>
Date: Mon, 27 May 2024 09:54:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <78c5abe1-546d-4ced-a160-a087ff3326ce@tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxZcW451Nm4ZsKAA--.17292S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4xAF45Zr45Cr4xJr1rKrX_yoW8Cw4rpF
 1kZFyUKFyrCrykZw1xta45W3s8Wr4UGa17KF4Yya4kGFs7JrnYgr4vq3sFgF4rAw48Jr1j
 vr4kJr9rZFsrZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.118,
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

在 2024/5/24 下午6:00, Michael Tokarev 写道:
> 23.05.2024 04:46, Song Gao wrote:
>> vmstate does not save kvm_state_conter,
>> which can cause VM recovery from disk to fail.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Message-Id: <20240508024732.3127792-1-gaosong@loongson.cn>
>> ---
>>   target/loongarch/machine.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> index 9cd9e848d6..08a7fa5370 100644
>> --- a/target/loongarch/machine.c
>> +++ b/target/loongarch/machine.c
>> @@ -145,8 +145,8 @@ static const VMStateDescription vmstate_tlb = {
>>   /* LoongArch CPU state */
>>   const VMStateDescription vmstate_loongarch_cpu = {
>>       .name = "cpu",
>> -    .version_id = 1,
>> -    .minimum_version_id = 1,
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
>> @@ -208,6 +208,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>           VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
>>           VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
>>   +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>> +
>>           VMSTATE_END_OF_LIST()
>>       },
>>       .subsections = (const VMStateDescription * const []) {
>
> Should this really be part of any stable releases?
[...]
>
> Wouldn't it break migration between, say, 8.2 with this change
> and without?
Yes, I didn't take this into consideration, please ignore this patch.

Thanks.
Song Gao
> Thanks,
>
> /mjt


