Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01372CF9C6C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 14:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stSYM-00031J-Bn; Wed, 25 Sep 2024 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangtiezhu@loongson.cn>)
 id 1stINh-0000ay-UX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 23:07:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yangtiezhu@loongson.cn>) id 1stINe-0004uo-VV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 23:07:57 -0400
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx646AfvNmv40OAA--.908S3;
 Wed, 25 Sep 2024 11:07:44 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
 by front2 (Coremail) with SMTP id qciowMAxZ8V7fvNmJsgRAA--.326S3;
 Wed, 25 Sep 2024 11:07:40 +0800 (CST)
Subject: Re: [PATCH v4 2/2] target/loongarch: Implement lbt registers
 save/restore function
To: maobibo <maobibo@loongson.cn>
References: <20240904061859.86615-1-maobibo@loongson.cn>
 <20240904061859.86615-3-maobibo@loongson.cn>
 <c14c8927-bb9b-9c3f-dca7-c86f79e73770@loongson.cn>
 <7ddb45a0-e685-2af0-749a-821cc08f22e8@loongson.cn>
 <a15a6f5d-5f9b-2bde-1300-81bd53ca25fa@loongson.cn>
 <c7257d12-dad4-7d1e-2fb7-876599a820a8@loongson.cn>
 <e844b0f8-e85e-a026-72b3-3af4d1af19d9@loongson.cn>
Cc: gaosong <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <136c79c7-4680-721b-0f0f-76b51dfd6b86@loongson.cn>
Date: Wed, 25 Sep 2024 11:07:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e844b0f8-e85e-a026-72b3-3af4d1af19d9@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qciowMAxZ8V7fvNmJsgRAA--.326S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
 BjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
 xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
 j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
 AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
 14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
 I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2
 jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
 AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
 WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
 0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
 rNtxDUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=yangtiezhu@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.21,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Sep 2024 09:59:35 -0400
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



On 09/24/2024 09:28 AM, maobibo wrote:
> Hi Tiezhu,
>
> Does mainline gdb support to dump LBT register now?

Yes, here are the related gdb commit and kernel code:

https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=e4d74c01e773

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/loongarch/include/uapi/asm/ptrace.h#n59

Thanks,
Tiezhu


