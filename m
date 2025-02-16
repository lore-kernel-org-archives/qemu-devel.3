Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6241C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 08:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjZZj-0001dZ-2A; Sun, 16 Feb 2025 03:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjZZh-0001dN-Nx
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 03:00:25 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjZZg-0006Vn-59
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 03:00:25 -0500
Received: from [192.168.1.8] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51G808w73826314
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sun, 16 Feb 2025 08:00:11 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=eBHm74W9 header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739692812;
 bh=JKNPh4w3ovf0XwBBxyTep80IR1Zb0Bt24HXzPGYr3mQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=eBHm74W9z9VlBVyINmyW/+ziJrA20dGDKP0Ve3HTv0uIlg7RTAsARYIi07ZtNaCYD
 Oyk4sJ1Q2QPzZyo1+mfscDH/9N9WnoycbLzTh15wB0AbiX5j5BnFwomxwSqaaHlsxS
 wnXkBmsjLw4UonBNUJD4A23dPKRyXwGTiMhoUgianf49PYYBAu6FBDUGcrX67gFX0n
 6NwPZfaRT3E5tmEXL5BAeKRvwQlRjnY9++pMLwbbJ9FDAO1jiIryg8aubFPA6K5m0r
 TCRZlXx38UHamwl7jRxMF/LPGRcZc/nQss1t5JGI2TTqWz2haCodI3ZpP7RTLHn1fN
 MQ6eIdwDPhP5g==
Message-ID: <aedcfd05-96fc-4e8a-9fcb-3763e30a6663@anarch128.org>
Date: Sun, 16 Feb 2025 21:00:02 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
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

On 2/16/25 06:58, Richard Henderson wrote:
> 
>> the label member is merely a pointer to the instruction text to
>> be updated with the relative address of the constant, the primary
>> data is the constant data pool at the end of translation blocks.
>> this relates more closely to .data sections in offline codegen
>> if we were to imagine a translation block has .text and .data.
> 
> No, it doesn't.  It relates most closely to data emitted within .text, 
> accessed via pc-relative instructions with limited offsets.
> 
> This isn't a thing you'd have ever seen on x86 or x86_64, but it is 
> quite common for arm32 (12-bit offsets), sh4 (8-bit offsets), m68k (16- 
> bit offsets) and such.  Because the offsets are so small, they could 
> even be placed *within* functions not just between them.

I mentioned before I like the idea and have thought about architectures 
with constant streams and constant branch units.

say for arguments sake we considered it 'TCData' with embedded label and 
reloc (the purpose is the constant after after all, just it is not a 
TCGTemp, it's an explicitly reified constant in the codegen emitters). 
wondering if we could add a "disposition" field to control placement. 
TCG_DISP_TEXT_TB, TCG_DISP_DATA, etc. this way you could ask the code 
generator to do something more conventional while still supporting the 
short relative constant islands. "disposition" might be better than 
section as a name. also a DATA section could be mmap R without X perms 
to lessen the risk of injecting code as constants.

disposition; "the way in which something is placed or arranged, 
especially in relation to other things."

TCGConstant is another alternative I would consider as okay. distinct 
from TCGTemp of type TEMP_CONST which is heavier weight. it makes one 
wonder about reification of large implicit constants as opposed to the 
explicitly emitted ones we are talking about here.

TCGConstant might be better.

i'm looking at a TCG source-compatible code generator as an option so I 
may experiment locally. it is a private interface at the moment anyhow. 
that just seemed inconsistent as most structure definitions are in the 
header. but I understand it is a private interface.

the patch was code comprehension. i'm studying TCG interfaces and code 
at the moment. i'd like to stay source compatible as much as possible.

Michael.

