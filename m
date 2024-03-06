Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85273C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 07:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhlrS-00018o-Gq; Wed, 06 Mar 2024 02:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rhlrP-00018g-Rp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:38:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rhlrM-000112-Tn
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:38:43 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxafB1Hehl1QYVAA--.52921S3;
 Wed, 06 Mar 2024 15:38:29 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrhNxHehl0RRPAA--.23630S3; 
 Wed, 06 Mar 2024 15:38:27 +0800 (CST)
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>,
 lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 zhaotianrui@loongson.cn, Huacai Chen <chenhuacai@kernel.org>
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
 <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
 <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
 <5325b63b-2a51-8448-bf70-c0659497db61@loongson.cn>
 <fa6b408c-43fd-4011-b704-ac7ae256fcbf@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <051240a2-4c9d-94f9-32f0-daa399b48a8e@loongson.cn>
Date: Wed, 6 Mar 2024 15:38:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fa6b408c-43fd-4011-b704-ac7ae256fcbf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrhNxHehl0RRPAA--.23630S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyfArWrtryrGF18uFWDKFX_yoW8KrWrpa
 y5CF43tayqqay0v3Z7Z3WSvFyrCF4Igay5ur1rGryYyFs8Xry2kF1IyFZ8tFWUXr97C3WI
 qr4Utw4UuFWDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.98,
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

Sorry, manual is updated already and we do not notice that still.

https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf

It is Chinese web link, English manual is not updated. Here is English 
translation by manual with instruction  "lddir rd, rj, level"

If the bit[14:13] of the register rj is not equal to 0 and its bit[6] 
is 1, the value of the register rj is a marked as HugePage page entries. 
In this case, the value from register rj is written directly to register rd.

If the bit[14:13] of the register rj is equal to 0 and its bit[6] is 1, 
the value of the register rj is an Hugepage table entry. In this case, 
replace the bit[14:13] of the register RJ value with level[1:0], the val 
is written to the register rd.

If the bit[6] bit of register rj is 0, the value of the universal 
register rj is the page table entry, it is  physical address base page 
table. In this case, if the LDDIR command is executed, the address will 
be refilled according to the TLB currently processed. Retrieve the base 
address of the next-level page table and write it to the common register 
rd.

We will remove temporary lddir_ps, and record page size with bit[14:13] 
in next version.

Regards
Bibo Mao

On 2024/3/6 下午12:10, Richard Henderson wrote:
> On 3/5/24 17:52, lixianglai wrote:
>> The LDDIR_PS variable is not described in detail in the manual, but is 
>> only an intermediate variable to assist in page size calculation 
>> during tcg simulation.
> 
> This is exactly why I believe adding this intermediate variable is wrong.
> 
> What happens if LDPTE is *not* preceded by LDDIR?  It's not the usual 
> way a tlb fill routine works, but *something* should happen if you 
> construct a valid huge page tlb entry by hand and pass it directly to 
> LDPTE.
> 
> With your implementation, this will not work because lddir_ps will not 
> be initialized. But I expect that on real hardware it would work.
> 
> If this does not work on real hardware, then there *is* some heretofore 
> undocumented hardware state.  If so, then we need a description of this 
> state from the hardware engineers -- the documentation of LDDIR and 
> LDPTE need updating.  Finally, this new hardware state needs to be added 
> to the migration state.
> 
> 
> r~


