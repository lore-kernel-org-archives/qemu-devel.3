Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A02CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6IK-00041P-DR; Mon, 15 Jun 2026 08:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liugang24219@sangfor.com.cn>)
 id 1wZ6II-00040i-Hy
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:19:58 -0400
Received: from mail-m8311.xmail.ntesmail.com ([156.224.83.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liugang24219@sangfor.com.cn>)
 id 1wZ6IF-0003lo-6Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:19:58 -0400
Received: from [172.23.76.122] (unknown [121.32.254.149])
 by smtp.qiye.163.com (Hmail) with ESMTP id 426f53a0d;
 Mon, 15 Jun 2026 20:02:18 +0800 (GMT+08:00)
Message-ID: <86b9aa68-3b97-4a3e-8ba0-7a3317a7cabe@sangfor.com.cn>
Date: Mon, 15 Jun 2026 20:02:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/e1000: Use address_space_stb for Rx descriptor
 status write on aarch64
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Ding Hui <dinghui@sangfor.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
 <3490ea2e-2c23-41d1-a12a-a8202e67d428@redhat.com>
From: Liu Gang <liugang24219@sangfor.com.cn>
In-Reply-To: <3490ea2e-2c23-41d1-a12a-a8202e67d428@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ecb293dfb03abkunm84df9f762fc36c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE1JVhofH0JKTBlCTEkfTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUpVSElVSU5PVUpPQllXWRYaDxIVHRRZQVlPS0hVSk
 tISk5MSVVKS0tVSkJLS1kG
Received-SPF: pass client-ip=156.224.83.11;
 envelope-from=liugang24219@sangfor.com.cn; helo=mail-m8311.xmail.ntesmail.com
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

在 2026/6/13 7:38, Gavin Shan 写道:
> Hi Liu & Ding,
> 
> On 5/27/26 7:17 PM, Liu Gang wrote:
>> From: LiuGang <liugang24219@sangfor.com.cn>
>>
>> In x86 environments, writing the Rx descriptor status byte with a single
>> pci_dma_write() works correctly. However, on aarch64 with glibc 2.24+,
>> the memcpy/memmove implementation uses a branchless sequence that copies
>> the same byte three times when count == 1. This results in three
>> consecutive STRB operations.
>> Ref: 
>> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/aarch64/memcpy.S;hb=refs/heads/release/2.24/master#l124
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
>>   hw/net/e1000.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index 202ad40401..f7be035e0f 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -869,6 +869,14 @@ e1000_receiver_overrun(E1000State *s, size_t size)
>>       set_ics(s, 0, E1000_ICS_RXO);
>>   }
>> +static inline void
>> +e1000_dma_write_byte(PCIDevice *d, dma_addr_t addr, uint8_t val)
>> +{
>> +    AddressSpace *as = pci_get_address_space(d);
>> +    dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
>> +    address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
>> +}
>> +
>>   static ssize_t
>>   e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int 
>> iovcnt)
>>   {
>> @@ -980,8 +988,8 @@ e1000_receive_iov(NetClientState *nc, const struct 
>> iovec *iov, int iovcnt)
>>           }
>>           pci_dma_write(d, base, &desc, sizeof(desc));
>>           desc.status |= (vlan_status | E1000_RXD_STAT_DD);
>> -        pci_dma_write(d, base + offsetof(struct e1000_rx_desc, status),
>> -                      &desc.status, sizeof(desc.status));
>> +        e1000_dma_write_byte(d, base + offsetof(struct e1000_rx_desc, 
>> status),
>> +                             desc.status);
>>           if (++s->mac_reg[RDH] * sizeof(desc) >= s->mac_reg[RDLEN])
>>               s->mac_reg[RDH] = 0;
> 
> Could you please try the following series to see if this issue gets fixed?
> 
> https://lore.kernel.org/qemu-arm/311f0568-facf-49de-83e8-7844f5c60e29@redhat.com/
> 
> Thanks,
> Gavin
> 
> 
> 
We have previously verified this effect. In
https://github.com/cdkey/e1000_poc , after removing -ffreestanding from 
the Makefile, the assembly of pci_dma_write is as follows:


pci_dma_write(d, base + offsetof(struct e1000_rx_desc, status), 
&desc.status, sizeof(desc.status));
   40104c:       d5033bbf        dmb     ish
   401050:       f9401fa0        ldr     x0, [x29, #56]
   401054:       91003000        add     x0, x0, #0xc
   401058:       3940d3a1        ldrb    w1, [x29, #52]
   40105c:       39000001        strb    w1, [x0]
   401060:       d503201f        nop
In this case, the code works correctly and the “not receiving packets” 
issue does not occur. I believe your change has the same effect.

To be safe, I additionally verified your change and confirmed it can 
also fix the “not receiving packets” problem.

Thanks,
– Liu Gang

