Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA929C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF8La-00050d-IE; Wed, 14 May 2025 05:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF8LZ-00050U-Jv
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:24:17 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF8LX-0004IT-Kj
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:24:17 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 54E9O48j1193337
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 14 May 2025 09:24:07 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=Avtiwagr header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1747214649;
 bh=AK6zBLK7RLCBSwPL0sH5lamTiEBbPnR2XuGfLB+seSM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Avtiwagrdnmk+yue1PC4RNfnXlIZ+bWOiw2EMslcpmLZB1/aSHqSidQVmFoqMABrx
 g9oadOrdJjn1OhnCSXq9/UWX6kqXOa/hSfokFLGkZx8+83SPjywzck4yyj81U21zJW
 wU+KEm32LzULXUwfbEkCZnVioBNrnHDyv+O1R1t1mC8Yn3j4u+PseGFia3wF5/9CWu
 L2qoBVvg6WRMZTELl9bDlOPnXuRhlu09FEk3MUuvi2Nj2ilyojXrqKwvTzngLP9LHB
 /bvbq2NLX6OzFQiIm4nqXsNh8Il0SaofKtjpFhsBoFEQCXVCif13yM6YNDtR7zn1vh
 v0ZVz2IURqnWA==
Message-ID: <6f3e890f-5424-4052-9025-696ca1426c36@anarch128.org>
Date: Wed, 14 May 2025 21:23:58 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
 <aCRROhtUyLK7axOf@redhat.com>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <aCRROhtUyLK7axOf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/14/25 20:17, Daniel P. Berrangé wrote:
> On Wed, May 14, 2025 at 07:39:27PM +1200, Michael Clark wrote:
>> diff --git a/disas/x86-core.c b/disas/x86-core.c
>> new file mode 100644
>> index 000000000000..c4f7034e3420
>> --- /dev/null
>> +++ b/disas/x86-core.c
>> @@ -0,0 +1,2716 @@
>> +/*
>> + * Copyright (c) 2024-2025 Michael Clark
>> + *
>> + * SPDX-License-Identifier: MIT
> 
> Note that we expect contributions to be under GPL-2.0-or-later, unless
> derived from existing code that forces use of a different license, which
> needs to be explained in the commit message

okay no problem, I can do that. there is a freestanding external origin:

https://github.com/michaeljclark/x86

I had a re-spin sitting in my queue for some time and I didn't have any
changes pending so I thought I would send it out. I would have folks
try it in private if they were considering merging it in the future.
one must balance the weight of future maintenance. I know that capstone
can be used to do the same so it is more of an FYI at this point.

Michael.

