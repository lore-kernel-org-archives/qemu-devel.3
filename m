Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D901E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoTY-0001Jd-Vq; Wed, 04 Dec 2024 07:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tIoTU-0001Iw-01; Wed, 04 Dec 2024 07:27:24 -0500
Received: from mail-gw01.astralinux.ru ([37.230.196.243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tIoTQ-0002MY-Pd; Wed, 04 Dec 2024 07:27:22 -0500
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw01.astralinux.ru (Postfix) with ESMTP id 4533024CFD;
 Wed,  4 Dec 2024 15:27:14 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru
 [10.177.185.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
 Wed,  4 Dec 2024 15:27:11 +0300 (MSK)
Received: from [10.198.36.161] (unknown [10.198.36.161])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Y3Gx82Kwnz1c0sJ;
 Wed,  4 Dec 2024 15:27:07 +0300 (MSK)
Message-ID: <ada94c51-f334-4991-9699-9e37c42925f0@astralinux.ru>
Date: Wed, 4 Dec 2024 15:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/nrf51_timer: prevent integer overflow
Content-Language: ru
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, sdl.qemu@linuxtesting.org
References: <20241203162525.75156-1-abelova@astralinux.ru>
 <CAFEAcA-y2-k8HnTHwTzqL4MGqrTAC1AKD5iP1s9XOTk0OrVYTg@mail.gmail.com>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <CAFEAcA-y2-k8HnTHwTzqL4MGqrTAC1AKD5iP1s9XOTk0OrVYTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; astralinux.ru:7.1.1;
 new-mail.astralinux.ru:7.1.1; 127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189612 [Dec 04 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2024/12/04 07:59:00 #26935148
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=37.230.196.243;
 envelope-from=abelova@astralinux.ru; helo=mail-gw01.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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


On 12/3/24 7:46 PM, Peter Maydell wrote:
> On Tue, 3 Dec 2024 at 16:25, Anastasia Belova <abelova@astralinux.ru> wrote:
>> Both counter and tick are uint32_t and the result
>> of their addition may not fit this type. Add
>> explicit casting to uint64_t.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: c5a4829c08 ("hw/timer/nrf51_timer: Add nRF51 Timer peripheral")
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> ---
>>   hw/timer/nrf51_timer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
>> index 35b0e62d5b..b5ff235eb8 100644
>> --- a/hw/timer/nrf51_timer.c
>> +++ b/hw/timer/nrf51_timer.c
>> @@ -44,7 +44,7 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
>>   {
>>       uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
>>
>> -    s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
>> +    s->counter = ((uint64_t)s->counter + ticks) % BIT(bitwidths[s->bitmode]);
> Can you explain when adding the cast makes a difference?
> Since s->counter is 32 bits and ticks is 32 bits and
> the RHS of the % is a power of 2, it's not clear to
> me that keeping the top 32 bits in the addition and then
> discarding it after the % is any different from only
> taking the bottom 32 bits of the addition.
>
You're right. I was sure this situation invokes UB.

Thanks for your patience,
Anastasia Belova

