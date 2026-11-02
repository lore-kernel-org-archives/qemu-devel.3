Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDD606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 01:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNges-000057-AT; Sun, 01 Nov 2026 20:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xNgeo-0008WP-Vd
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 20:16:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xNgel-00063S-TP
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 20:16:18 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxLNJQ5OdqBWUbAA--.13853S3;
 Mon, 02 Nov 2026 09:16:00 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx2c1N5Odq9r0xAA--.37906S2;
 Mon, 02 Nov 2026 09:15:57 +0800 (CST)
Subject: Re: [RFC] target/i386: design for TCG emulation of LAM
To: mdspan <mdspan.github@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de
References: <CALU8FV9KC48FC2FGahqSh2uEqyedy-QZAgZ9qgap147d=Hr-+Q@mail.gmail.com>
 <1a022cad-2010-4b1a-bef7-ae9effe0b12b@linaro.org>
 <CALU8FV9M7+Cm4m963Fx_-g+TGiZXVxe6mUiKkzax5f=Gn6Odsw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7a7e1172-25eb-8dab-0ba5-b03b33bed2fa@loongson.cn>
Date: Mon, 2 Nov 2026 09:17:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALU8FV9M7+Cm4m963Fx_-g+TGiZXVxe6mUiKkzax5f=Gn6Odsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx2c1N5Odq9r0xAA--.37906S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWrArWDuw1kGF18ur1ktFc_yoW8Zr1Upa
 s5CanYkrWDAay0kw4q9w1DtF15Zan8Aay8JayUKr1rCr13Zr1I9rZ8Kas3ua48Kw4rt3yj
 yFWYyayxuF98JFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.853,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/31 下午9:03, mdspan wrote:
> On 10/21/26 14:20, Richard Henderson wrote:
>> In particular, arm requires the complete address, including tagging, to
>> be available for any raised exception.  So clipping the address at any
>> other place loses that information.  Dunno if that applies to LAM.
> 
> It doesn't for LAM. LAM masking applies before paging, so CR2 gets
> the masked address (ISE 319433-048, section 6.5). The non-canonical
> case riases #GP, which doesn't report an address.
> 
> One change would touch common code: tlb_flush_range_locked() compares
> large_page_addr in all 64 bits, so INVLPG of the untagged address
> misses a large page entered under a tagged alias. I'd compare under
> the flush mask:
> 
>      if (((addr + len - 1) & d->large_page_mask & mask) ==
>          (d->large_page_addr & mask)) {
There is similar issue on LoongArch, there is windows mapping before MMU 
TLB, such as 64bit virtual address 0x9000 XXXX XXXX XXXX -> 48 bit PA 
0xXXXX XXXX XXXX. I try to add 48 bit page size when adding QEMU TLB 
with API tlb_set_page(), but qemu LoongArch fails to boot, so I give up :(

Regards
Bibo Mao
> 
> If that's fine, I'll post the system-mode series.
> 
> On Wed, Oct 21, 2026 at 6:20 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 10/21/26 12:57, mdspan wrote:
>>> Ping.
>>>
>>> Paolo, Richard: does masking in get_physical_address(), with TLB
>>> entries kept per tag and INVLPG flushing all aliases through
>>> tlb_flush_page_bits_by_mmuidx(), look acceptable to you? I have a
>>> prototype of items 1 and 2 and can post it as an RFC series if that
>>> would be easier to review.
>>
>> Yes, this is what we do in target/arm for top-byte-ignore.
>>
>> In particular, arm requires the complete address, including tagging, to
>> be available for any raised exception.  So clipping the address at any
>> other place loses that information.  Dunno if that applies to LAM.
>>
>> r~


