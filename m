Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A76C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 01:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBlQD-0003Uw-Og; Mon, 27 May 2024 21:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sBlQ9-0003UF-IJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 21:14:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sBlQ7-0006iR-2J
 for qemu-devel@nongnu.org; Mon, 27 May 2024 21:14:33 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Dxi+rxL1VmuH4AAA--.1913S3;
 Tue, 28 May 2024 09:14:25 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxvsfuL1VmR5MLAA--.30409S3; 
 Tue, 28 May 2024 09:14:24 +0800 (CST)
Subject: Re: [RFC v2 0/2] target/loongarch: Add loongson binary translation
 feature
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240527083501.844854-1-maobibo@loongson.cn>
 <83153da8-79e0-4cc0-b9e1-918cc5bf7f87@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <b9663e7d-2eed-d3fe-2f92-2784c8ee8961@loongson.cn>
Date: Tue, 28 May 2024 09:14:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <83153da8-79e0-4cc0-b9e1-918cc5bf7f87@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvsfuL1VmR5MLAA--.30409S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw13ArWfGF4DXF1kKF1kXrc_yoW8Wr1fpF
 W3GrW2yanFqw4UCa18Ar4UGF1rA3ykZr45urWDGFyfZF17Zrn0y340gFy8WayfXrW8AF97
 AF4Uta1vyrn8AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.786,
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



On 2024/5/27 下午6:39, Philippe Mathieu-Daudé wrote:
> Hi Bibo,
> 
> On 27/5/24 10:34, Bibo Mao wrote:
>> Loongson Binary Translation (LBT) is used to accelerate binary
>> translation. LBT feature is added in kvm mode, not supported in TCG
>> mode since it is not emulated. And only LBT feature is added here, LBT
>> registers saving and restoring is not supported since it depeeds on LBT
>> feautre implemented in KVM kernel
> 
> How do you test?
There is a test application using LBT instruction as followings.

If LBT is not enabled, it reports illegal instruction. And it does not 
report error during VM migration.

Regards
Bibo Mao

--------------------------------------------------------------------------
#include <stdio.h>
#include <sched.h>
int main()
{
     int a = 0, b = 0;
     for (;;)
     {
         asm(
             "li.d $t0, 0xff  \n\t"
             ".word ((0x17<<18)|(0x3f<<10)|(1<<5)|0xc) \n\t" // mtflag
             ".word ((0x17<<18)|(0x3f<<10)|(0<<5)|0xc) \n\t" // mfflag
             ".word ((0x17<<18)|(0x3f<<10)|(1<<5)|0xc) \n\t" // mtflag
             "move %0, $t0 \n\t"
             : "=r"(a) : : );
         sched_yield();
         asm(
             ".word ((0x17<<18)|(0x3f<<10)|(0<<5)|0xc) \n\t" // mfflag
             "move %0, $t0 \n\t"
             : "=r"(b) : :);

         if (a != b)
         {
             printf("in: 0x%x <=> out 0x%x \n", a, b);
             return 1;
         }

         sched_yield();
         int top = 0;
         asm(
             ".word (0x8008) \n\t"                 // settm
             ".word ((0x70 << 8) | (5 << 5)) \n\t" // mttop 1
             ".word (0x8009) \n\t"                 // inctop
             : : :);
         sched_yield();
         asm(
             ".word ((0x3a0 << 5) | (0xc)) \n\t" // mfftop
             "move %0, $t0 \n\t"
             : "=r"(top) : : );

         if (top != 6)
         {
             printf("top: %d \n", top);
             return 1;
         }
     }
     return 0;
}

> 
> Thanks,
> 
> Phil.


