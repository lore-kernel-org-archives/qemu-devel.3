Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA8DD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwfV-0007Uj-0g; Mon, 02 Mar 2026 01:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwfQ-0007Rn-11
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:22:09 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwfN-0005hc-CB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:22:07 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6226LBB4033525
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 15:22:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=y9KYHnJdKXI4Bm/Yc9UuAE4OKFG8WxOH7EecF1Td82s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772432521; v=1;
 b=EhE2EcgzQ2QHDWYWMza5ZUa0orO/GlpomYeIW2X6y6Gralq7ipO0GBu9Rx2MGcR0
 gC5PS2cgimJtmi/f4B8Z2A2zfLVX7tto62xr3SRM1+sUH4uSBRF7ueFnOuJypNNw
 hT0kG3uYsliRmyyOhb15seklXgXd0wcapK3vteK4YVPlxDUXRjtPkMJ3rVxZz++n
 jcmqlzUZhhjLH4Yt0CmMd3BL03xgg4vo44wFKwOFnoYQkS2+66unidOUMb7FkcJ6
 lrdssimRJ2Lh/l3pUTwWZ8KWw6jQX8AHTUjRdAldzjX+GI0BzBAz+gC0fgOivD52
 epCPoA3orN9+xe71ziPsyw==
Message-ID: <82dfe6e2-22c1-4df1-9e49-a2c7a2970082@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 2 Mar 2026 15:21:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
 <8a2872f3-dfbb-3fed-dd95-3cd474e3ca2b@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8a2872f3-dfbb-3fed-dd95-3cd474e3ca2b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/02/27 7:22, BALATON Zoltan wrote:
> On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
>> physmem.c defines 2 stubs which are related to ram-block:
>> qemu_ram_block_from_host() and qemu_ram_get_fd().
>> Move them with the other ram-block stubs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> stubs/physmem.c   | 13 -------------
>> stubs/ram-block.c | 11 +++++++++++
> 
> Maybe should be the other way around moving what's in subs/ram-block.c 
> to stubs/physmem.c considering the the functions these stub out are in 
> system/physmem.c and there's no system/ram-block.c.

But this stubs out functions in "ramblock.h" (though it's not
"ram-block.h")

Regards,
Akihiko Odaki

> 
> Regards,
> BALATON Zoltan
> 
>> stubs/meson.build |  1 -
>> 3 files changed, 11 insertions(+), 14 deletions(-)
>> delete mode 100644 stubs/physmem.c
>>
>> diff --git a/stubs/physmem.c b/stubs/physmem.c
>> deleted file mode 100644
>> index 14667f2bd8f..00000000000
>> --- a/stubs/physmem.c
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -#include "qemu/osdep.h"
>> -#include "system/ramblock.h"
>> -
>> -RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>> -                                   ram_addr_t *offset)
>> -{
>> -    return NULL;
>> -}
>> -
>> -int qemu_ram_get_fd(RAMBlock *rb)
>> -{
>> -    return -1;
>> -}
>> diff --git a/stubs/ram-block.c b/stubs/ram-block.c
>> index 8790a59593e..f0650b19ac6 100644
>> --- a/stubs/ram-block.c
>> +++ b/stubs/ram-block.c
>> @@ -35,3 +35,14 @@ int ram_block_discard_disable(bool state)
>> {
>>     return 0;
>> }
>> +
>> +RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>> +                                   ram_addr_t *offset)
>> +{
>> +    return NULL;
>> +}
>> +
>> +int qemu_ram_get_fd(RAMBlock *rb)
>> +{
>> +    return -1;
>> +}
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 8a07059500d..0171f531523 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -20,7 +20,6 @@ if have_block
>>   stub_ss.add(files('get-vm-name.c'))
>>   stub_ss.add(files('iothread-lock-block.c'))
>>   stub_ss.add(files('migr-blocker.c'))
>> -  stub_ss.add(files('physmem.c'))
>>   stub_ss.add(files('ram-block.c'))
>>   stub_ss.add(files('runstate-check.c'))
>>   stub_ss.add(files('uuid.c'))
>>


