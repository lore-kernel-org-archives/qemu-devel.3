Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD58CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZ78-0005yC-T3; Thu, 28 May 2026 07:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liugang24219@sangfor.com.cn>)
 id 1wSZ77-0005y4-H4
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:41:25 -0400
Received: from mail-m105.netease.com ([154.81.10.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liugang24219@sangfor.com.cn>)
 id 1wSZ72-000474-3h
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:41:24 -0400
Received: from [172.23.76.122] (unknown [121.32.254.149])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4030048cf;
 Thu, 28 May 2026 19:34:06 +0800 (GMT+08:00)
Message-ID: <878aa971-2868-4181-80a3-93567a715905@sangfor.com.cn>
Date: Thu, 28 May 2026 19:34:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/e1000: Use address_space_stb for Rx descriptor
 status write on aarch64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
 Ding Hui <dinghui@sangfor.com.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
 <CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com>
From: Liu Gang <liugang24219@sangfor.com.cn>
In-Reply-To: <CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6e5cf42903abkunm51a8d52cd03a9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxhDVhkeSh9DGB1PHhlIGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUpVSElVSU5PVUpPQllXWRYaDxIVHRRZQVlPS0hVSk
 tISk5MSVVKS0tVSkJLS1kG
Received-SPF: pass client-ip=154.81.10.5;
 envelope-from=liugang24219@sangfor.com.cn; helo=mail-m105.netease.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2026/5/27 21:45, Peter Maydell 写道:
> On Wed, 27 May 2026 at 14:23, Liu Gang <liugang24219@sangfor.com.cn> wrote:
>>
>> From: LiuGang <liugang24219@sangfor.com.cn>
>>
>> In x86 environments, writing the Rx descriptor status byte with a single
>> pci_dma_write() works correctly. However, on aarch64 with glibc 2.24+,
>> the memcpy/memmove implementation uses a branchless sequence that copies
>> the same byte three times when count == 1. This results in three
>> consecutive STRB operations.
>> Ref: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/aarch64/memcpy.S;hb=refs/heads/release/2.24/master#l124
>>
>> When the guest uses an e1000 NIC and DPDK, this behavior can cause
>> packet reception to stop or packets to be dropped repeatedly. Under
>> normal operation, DPDK clears the DD flag after processing a packet and
>> then updates RDT. But due to the triple STRB from memcpy/memmove, the
>> DD flag may be cleared and then immediately set again. This causes DPDK
>> to consume the same packet twice, making RDT be incremented by one extra.
>> As a result, RDH == RDT, and QEMU mistakenly considers the receive
>> queue full, stopping packet reception.
>>
>> The issue can be reproduced on aarch64 using the adapted test program:
>> https://github.com/cdkey/e1000_poc
>>
>> Replace pci_dma_write() with address_space_stb() to write the DD status
>> byte directly, avoiding the problematic memcpy/memmove sequence and
>> resolving the issue.
>>
>> Fixes: 034d00d48581("e1000: set RX descriptor status in a separate
>> operation")
>> Signed-off-by: Liu Gang <liugang24219@sangfor.com.cn>
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>>   hw/net/e1000.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index 202ad40401..f7be035e0f 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -869,6 +869,14 @@ e1000_receiver_overrun(E1000State *s, size_t size)
>>       set_ics(s, 0, E1000_ICS_RXO);
>>   }
>>
>> +static inline void
>> +e1000_dma_write_byte(PCIDevice *d, dma_addr_t addr, uint8_t val)
>> +{
>> +    AddressSpace *as = pci_get_address_space(d);
>> +    dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
>> +    address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
> 
> I don't think there's any guarantee that we won't write
> multiple times to the memory in this case either. This
> eventually boils down to calling address_space_stm_internal
> which for dispatch to RAM calls stm_p(), which for a byte
> write will call stb_p(), which is "*(uint8_t *)ptr = v;"
> and there's no guarantee in the C standard about that doing
> only a single byte store to memory.
> 
> I think this change only gives different behaviour by accident,
> not by design.
> 
> -- PMM
> 
> 
Thank you for the thoughtful review. You raise a very valid point — the 
C standard indeed does not mandate that a non-atomic assignment like 
*(uint8_t *)ptr = v; will be compiled to a single byte store.

I have prepared a minimal test example on Compiler Explorer to verify 
that the direct byte storage method (`*(uint8_t *)ptr = v;`) does not 
result in multiple storage operations under different architectures and 
compilers: https://godbolt.org/z/q3vfPcjME

This example confirms that, at a typical -O2 optimization level, the 
generated code is a single instruction across different architectures 
and compilers. While this is not an absolute guarantee, it reflects what 
commonly happens in practice with common toolchains.

Looking forward to your guidance.

