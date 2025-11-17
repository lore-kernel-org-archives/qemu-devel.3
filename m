Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C457CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0oW-0008FI-2K; Mon, 17 Nov 2025 10:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL0o4-00083l-0R; Mon, 17 Nov 2025 10:06:17 -0500
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1vL0o0-0007x4-NC; Mon, 17 Nov 2025 10:06:15 -0500
Received: from [IPV6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3]
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 75465359B5;
 Mon, 17 Nov 2025 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763391968; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8U3TtoJxhtWxSEnLsiezKiadFsmmZEAR39z4jUqxtQ=;
 b=oH4GfQ3nvbGUonV01qrILo8BTY6EEIS/mDjPjeyJD+K4+pHFnpmTLsw4c/alywDnHKFAAD
 TGJQobY+LlcfBhi7/cRHh/8PsbQKGe3ID5S4oEwnIdvXx0Sj0aem+eA/B0ibWGxCE6Iwbd
 QxAzBZkTfs+u8K6DRCSfhHxnExa4sec=
Message-ID: <595db230-2354-4949-8e4d-e8b374c9985d@mlugg.co.uk>
Date: Mon, 17 Nov 2025 15:06:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] linux-user: fix reserved_va page leak in do_munmap
To: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-4-mlugg@mlugg.co.uk>
 <CAFEAcA-bCh=YdU=+FsHu_oKG_L+8hhrFW+E5XN3xomVyppNvnQ@mail.gmail.com>
Content-Language: en-US
From: Matthew Lugg <mlugg@mlugg.co.uk>
In-Reply-To: <CAFEAcA-bCh=YdU=+FsHu_oKG_L+8hhrFW+E5XN3xomVyppNvnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/20/25 17:00, Peter Maydell wrote:
> I don't really understand this code, I'm just looking at
> it fresh, so my comment below might be wrong.
> 
>> -    /*
>> -     * If guest pages remain on the first or last host pages,
>> -     * adjust the deallocation to retain those guest pages.
>> -     * The single page special case is required for the last page,
>> -     * lest real_start overflow to zero.
>> -     */
> 
> This comment says we need the special case for
> "real_last - real_start < host_page_size" to avoid an overflow.
> 
>> -    if (real_last - real_start < host_page_size) {
>> -        prot = 0;
> 
> We delete the special case...
> 
>> -        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
>> -            prot |= page_get_flags(a);
>> -        }
>> -        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
>> -            prot |= page_get_flags(a + 1);
>> -        }
>> -        if (prot != 0) {
>> -            return 0;
>> -        }
>> -    } else {
>> -        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
>> -            prot |= page_get_flags(a);
>> -        }
>> -        if (prot != 0) {
>> -            real_start += host_page_size;
>> -        }
>> +    /* end or real_end may have overflowed to 0, but that's okay. */
>>
>> -        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
>> -            prot |= page_get_flags(a + 1);
>> -        }
>> -        if (prot != 0) {
>> -            real_last -= host_page_size;
>> -        }
>> +    /* If [real_start,start) contains a mapped guest page, retain the first page. */
>> +    for (prot = 0, off = 0; off < start - real_start; off += TARGET_PAGE_SIZE) {
>> +        prot |= page_get_flags(real_start + off);
>> +    }
>> +    if (prot != 0) {
>> +        real_start += host_page_size;
> 
> ...and now if real_start was the last page in the
> address space, this addition will overflow it to zero.
> g
Indeed, but the idea (which I didn't make clear enough, apologies) is 
that this overflow is completely unproblematic. Provided you never 
perform inequality comparisons on the value, overflow gives correct 
results! Regardless though, Richard has asked that I revert to the old 
strategy:

On 10/21/2025, Richard Henderson wrote:
> No, it is not simpler with 'end', because end == 0 is 'valid' in the 
> sense that the range goes from [start, (abi_ptr)-1]. But having end
> <= start is awkward in the extreme.
> 
> Thus we prefer the inclusive range [start, last] to the exclusive 
> range [start, end).
> 
> Not everything has been converted away from 'end', but we certainly 
> should not regress existing code.
> 
> 
> r~
My perspective was that the only thing we actually lose from having 'end 
<= start' is the ability to perform comparisons on these addresses, and 
that this is better than the alternative, where we not only need the 
single-page special case, but also the corrected 'real_last' computation 
needs to use a temporarily-overflowed value:

   real_last = ROUND_UP(last + 1, host_page_size) - 1;

I'm not here to argue style, though, so I'm happy to replace this diff 
with a small one which only changes the 'real_last' definition. Will do 
that in the next version of this series.

-- 
Matthew

