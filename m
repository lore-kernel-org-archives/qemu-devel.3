Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82148CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfhv-0002Sc-AM; Wed, 03 Jun 2026 03:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUfhu-0002SC-6O; Wed, 03 Jun 2026 03:08:06 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wUfhs-00009T-6K; Wed, 03 Jun 2026 03:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780467730; bh=gDO5Ihnh4VrWdxPWusYzBscSVr9dGj9z2tlFoBuMQPo=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=FvLFeHigNCEqch3WsqDUN+MQeJua89nipNZKc6voTkRFV/1ZU+r2CFQMbpD43omJS
 0htnHBbZsGN3GTSY2yPdT4EpS9C3iq0Pk6mByklG9q2ONYW7m768MqtX+jPejzk3J7
 iSHfwDA2US25xI/jsHp64uLdIRBXScOOdhVW2bYQ=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:21:53 +0200 (CEST)
X-EA-Auth: Tst4tSq0GuzLNi1q96NhHb20k82ufP9vfgR/JnWZWjE1MWgMaJxRV1i2Wze1+cl/+3RWXq4xRd7+SEZMdxP5KOB40UqjbQsm
Message-ID: <f15e433e-7168-4731-993c-a41e6ebeefde@mailo.com>
Date: Wed, 3 Jun 2026 08:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory.c: add MemTxResult arg in
 memory_region_access_valid()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, "open list:S390 PCI" <qemu-s390x@nongnu.org>
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <20260602190857.1506939-2-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602190857.1506939-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

On 2/6/26 21:08, Daniel Henrique Barboza wrote:
> memory_region_access_valid() returns true and false and nothing else,
> but it makes distintions between error types that we can see via each
> error_log message: if mr->ops->valid.accepts fails the reason is
> set to "rejected", reason is set to "unaligned" if addr is unaligned
> and reason is set to "invalid size" if size is less that min_access_size
> or greater than max_access_size.
> 
> We're particularly interested in the "reason: rejected" result.  In
> RISC-V this is thrown when the mem_op tries to access a protected page,
> and we need to throw a special exception for this case.
> memory_region_dispatch_read() (and write())  will default to
> MEMTX_DECODE_ERROR because memory_region_access_valid() does not give
> additional info when it fails, and back in the RISC-V side we're having
> to make assumptions to determine that this MEMTX_DECODE_ERROR is in fact
> a "rejected" error type.
> 
> Add a new MemTxResult arg in memory_region_access_valid() that the
> funcion will use to set the reason why it failed.  Based on the error
> reasons (described above) and the definition of each MemTxResult, we're
> setting the following results:
> 
> - result ok: MEMTX_OK
> - rejected: MEMTX_ACCESS_ERROR
> - all other errors: MEMTX_DECODE_ERROR

Orthogonal, in "hw/pci/pci_device.h":

  /**
   * pci_dma_rw: Read from or write to an address space from PCI device.
   *
   * Return a MemTxResult indicating whether the operation succeeded
   * or failed (eg unassigned memory, device rejected the transaction,
   * IOMMU fault).

This could deserve clarification as the  mapping is not obvious to me.

Without looking at the code, I'd expect:

  . unassigned memory -> MEMTX_DECODE_ERROR
  . device rejected the transaction -> MEMTX_ACCESS_ERROR
  . IOMMU fault -> MEMTX_ACCESS_ERROR

What confuses me I guess is having 3 descriptions for 2 enums.

> 
> Existing callers are unchanged.  No behavioral change is intended for
> now.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/s390x/s390-pci-inst.c |  2 +-
>   include/system/memory.h  |  2 +-
>   system/memory.c          | 20 +++++++++++++++++---
>   system/physmem.c         |  3 ++-
>   4 files changed, 21 insertions(+), 6 deletions(-)


> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..d74fae52e3 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2602,7 +2602,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
>   

Please update the docstring.

>   bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
>                                   unsigned size, bool is_write,
> -                                MemTxAttrs attrs);
> +                                MemTxAttrs attrs, MemTxResult *result);
>   
>   /**
>    * memory_region_dispatch_read: perform a read directly to the specified
> diff --git a/system/memory.c b/system/memory.c
> index 739ba11da6..48348edb96 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1403,14 +1403,22 @@ bool memory_region_access_valid(MemoryRegion *mr,
>                                   hwaddr addr,
>                                   unsigned size,
>                                   bool is_write,
> -                                MemTxAttrs attrs)
> +                                MemTxAttrs attrs,
> +                                MemTxResult *result)
>   {
> +    if (result) {
> +        *result = MEMTX_OK;

Per "exec/memattrs.h":

   /* New-style MMIO accessors can indicate that the transaction failed.
    * A zero (MEMTX_OK) response means success; anything else is a
    * failure of some kind. The memory subsystem will bitwise-OR together
    * results if it is synthesizing an operation from multiple smaller
    * accesses.
    */

The caller should initialize to MEMTX_OK.

> +    }
> +
>       if (mr->ops->valid.accepts
>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
>           qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
>                         ", size %u, region '%s', reason: rejected\n",
>                         is_write ? "write" : "read",
>                         addr, size, memory_region_name(mr));
> +        if (result) {
> +            *result = MEMTX_ACCESS_ERROR;

Here I'd OR.

> +        }
>           return false;
>       }
>   
> @@ -1419,6 +1427,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
>                         ", size %u, region '%s', reason: unaligned\n",
>                         is_write ? "write" : "read",
>                         addr, size, memory_region_name(mr));
> +        if (result) {
> +            *result = MEMTX_DECODE_ERROR;

Ditto.

> +        }
>           return false;
>       }
>   
> @@ -1436,6 +1447,9 @@ bool memory_region_access_valid(MemoryRegion *mr,
>                         addr, size, memory_region_name(mr),
>                         mr->ops->valid.min_access_size,
>                         mr->ops->valid.max_access_size);
> +        if (result) {
> +            *result = MEMTX_DECODE_ERROR;

Ditto.

> +        }
>           return false;
>       }
>       return true;
> @@ -1478,7 +1492,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>                                              mr->alias_offset + addr,
>                                              pval, op, attrs);
>       }
> -    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
> +    if (!memory_region_access_valid(mr, addr, size, false, attrs, NULL)) {

Surely here you want to propagate the dispatched MR result.

>           *pval = unassigned_mem_read(mr, addr, size);
>           return MEMTX_DECODE_ERROR;
>       }
> @@ -1527,7 +1541,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>                                               mr->alias_offset + addr,
>                                               data, op, attrs);
>       }
> -    if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
> +    if (!memory_region_access_valid(mr, addr, size, true, attrs, NULL)) {
>           unassigned_mem_write(mr, addr, data, size);
>           return MEMTX_DECODE_ERROR;

Also here.

>       }
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf87573..a0f77aae66 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3635,7 +3635,8 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
>           mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>           if (!memory_access_is_direct(mr, is_write, attrs)) {
>               l = memory_access_size(mr, l, addr);
> -            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
> +            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs,
> +                                            NULL)) {
>                   return false;
>               }
>           }



