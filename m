Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64B8CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBoyW-0004LU-Ag; Thu, 23 Oct 2025 02:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vBoyV-0004Kl-Lc; Thu, 23 Oct 2025 02:39:03 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vBoyT-0001w4-HV; Thu, 23 Oct 2025 02:39:03 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id 779051A0007;
 Thu, 23 Oct 2025 06:38:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 779051A0007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761201534; bh=z5dsFJFmgtnobo0SAehP4cpu/9uSPkmGC+VeE6JleII=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=WoeHuurGuKSyjnIoKYxXknpULChvrxKtZSzUPVh4heP79hn1Rea+ZW6l6Y+Fu4KKY
 87XGLAAxjzFDI61kXSJmLXPusx12hdk7Esc3xYveSirKgUIQ1ss4pmXU/ZZ2W5WlC2
 +6S9X9bNncak2b+O25Q5SmkqQldkiEOjVI1zOOY4LKSdSS6UINdilHvBseFoTu9SBm
 QNABfFqyJl0OEgO/yFVZfvvC+pPc/YhxBqx1IWs7s8TRZ+ZrrWGsetuoOg8SlziN+e
 9f/itOXaj7cnktyYiGXlcHI9PITgB7Vc4Ho2332rFAh4EplYJnGSfGx2e4eg7n3qdp
 iQ/9dal6ohMUA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 06:38:53 +0000 (UTC)
Received: from [10.30.30.254] (10.30.30.254) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 09:38:25 +0300
Message-ID: <e9f0bb8a-6512-4ed2-a1a4-deed8b47d125@syntacore.com>
Date: Thu, 23 Oct 2025 09:38:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Novikov <n.novikov@syntacore.com>
Subject: Re: [PATCH] accel/tcg: Pass actual memop_size to tlb_fill instead of 0
To: Richard Henderson <richard.henderson@linaro.org>
CC: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <n.novikov@syntacore.com>
References: <20251022115213.91457-1-n.novikov@syntacore.com>
 <79beaf9a-9558-40e7-a01d-5f80d8931eba@linaro.org>
 <busf3stsde5y7hq7zslr2kfyibp5ve2wrvrrawik3xbfpmsr7f@2nr5m4kdlltn>
 <6083717e-a013-4089-a54f-4c2ecc98a351@linaro.org>
Content-Language: en-US
In-Reply-To: <6083717e-a013-4089-a54f-4c2ecc98a351@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.30.30.254]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/23 02:56:00 #27792171
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=n.novikov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 22/10/2025 22:20, Richard Henderson wrote:
> On 10/22/25 13:59, Nikita Novikov wrote:
>>>> Fixes: ec03dd972378 ("accel/tcg: Hoist first page lookup above 
>>>> pointer_wrap")
>
> This cannot be true, btw, because ...
>
>>>> -        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
>>>> +        if (mmu_lookup1(cpu, &l->page[1], l->memop, l->mmu_idx, 
>>>> type, ra)) {
>
> ... this line did not change with that patch.
My bad, sorry. I suggest it will be better to use  `Related-to`, because 
actually this patch makes both halves of a split-page access consistent 
or did I misunderstand you?
>>>>                uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
>>>>                l->page[0].full = 
>>>> &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
>>>>            }
>>>
>>> How is the memop really applicable to the second half of a 
>>> split-page operation?
>>>
>> Because the second half is still part of the same guest memory 
>> operation. It must obey
>> the same size, alignment, and atomicity rules. Passing the real memop 
>> ensures correct
>> alignment and atomic checks even if the access crosses a page boundary.
>
> How?
>
> Let's use a concrete example: Access MO_64 | MO_UNALN at 0x1fffd.
>
> The first tlb_fill gets to see the start address 0x1fffd, and the 
> length 3 (and also the memop).
>
> The second tlb_fill gets to see the second page address 0x20000 and 
> the length 5 (but not the memop).
>
> Exactly what is the second tlb_fill going to do with 0x20000 and MO_64 
> | MO_UNALN?
>
The guest does a 64-bit access with flags MO_64 | MO_UNALN at address 
0x1fffd. The first `tlb_fill` handles bytes from 0x1fffd-0x1ffff with 
length 3, and sees the real `memop`, so it knows the access is unaligned 
but allowed. The second `tlb_fill` handles bytes 0x20000-0x20004 with 
length 5. If it gets `memop == 0`, it loses information about the access 
type, alignment and atomicity. With the real memop it stays consistent 
with the first half, because it knows this is part of one 64-bit 
unaligned access, not a separate normal one. For `MO_UNALN` it changes 
nothing, but for atomic or alignment-restricted cases it prevents the 
second page from being treated incorrectly as a normal split access.  
Also it does not raise an alignment fault, and sets the same slow-path 
flags (ex. `TLB_CHECK_ALIGNED`) and region checks.

I faced with this bug while debugging a case where `memop_size == 1`, 
because `memop_size(0) == 1`. According to the code it means the second 
half doesn’t carry any valid access information, but it's not true.

>
> r~

