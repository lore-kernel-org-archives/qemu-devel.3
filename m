Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B6ACA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5j5-0006WV-EF; Fri, 30 Aug 2024 13:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1sk5iz-0006Uk-IS; Fri, 30 Aug 2024 13:47:55 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1sk5ix-0004hi-DM; Fri, 30 Aug 2024 13:47:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3E220C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725040065;
 bh=8+sN9E4YHy9w0jcJOPwRC3fIN153meNkMETDm6Cm5SQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=dZi0SWGKZWaVfIuR4+vcegAwhiZx3zgdkcFvOOqzn2TyAheFxVxn71/nyWUEfKXBl
 bx01DWIbKtLZzgo4E0HroVomVZFnPo7cPOIhQ9k3UgNza5qzheLOzffTXew+ti/O+y
 VuHbZbXvpf9xB2EdfPhWrdxuyauaYUPCkHzCjIb0LzvqGbC8C0Afpvora0A7Kh3piF
 Hx4KK4PG5Eodbz1kYhl7xhNoZ6rXnHAFi2IBTkLw0ZV9WFodh6nYZF1/nwXueEu7wQ
 3Jpdw/AzPnhnECVSuc0lr8FJMyIl9PPWEoU3ZNQCxrjLyo7trrTfr1bQthUGLNGoM0
 rYg0Ym7TkDIVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725040065;
 bh=8+sN9E4YHy9w0jcJOPwRC3fIN153meNkMETDm6Cm5SQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=acyYjkJ1JT7oLt2GuCLX1uZG6a+6eG5/F+O0fLYhz9anLMEPW+CxUEWJXFMeM4eXo
 tiIDgV44dBSUjPWYJJRnSG7cDMhlX0bZeogJq0SHzEuEHhkCQXuNeSpXOpCQcWQFwK
 H2j3tA8J66Q6ufhiahOcwCkIka8/zYmz4IA2YcuO9IETf4kLfr0QcJaHYDwk5nhSKT
 CmSDR2z+J0DA4ps2+ZCI6dz3ZhNCYyKf9BJ8DuKcbzH73nmxycmfbkwGQKYAr6zmtD
 NIjs0AMNG1vHcKT1PP7nWVwbY+STLm1DP4ROy/j6rqOlOgTgD2jKRlUblQOP5P7ud9
 QmGjLXoQ+7I/g==
Message-ID: <f26253a4-8b34-4cd7-8375-e49b8d1842a4@syntacore.com>
Date: Fri, 30 Aug 2024 20:47:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Stop timer with infinite timecmp
To: Andrew Jones <ajones@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Anup Patel
 <apatel@ventanamicro.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, <atishp@rivosinc.com>
References: <20240829084002.1805006-2-ajones@ventanamicro.com>
 <5f547cd8-2068-4499-af7e-04f3f27ea617@syntacore.com>
 <20240830-f7e2039c7d1cc5e33bd1f5b2@orel>
Content-Language: en-US, ru-RU
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <20240830-f7e2039c7d1cc5e33bd1f5b2@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=vladimir.isaev@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



30.08.2024 17:50, Andrew Jones пишет:
> On Fri, Aug 30, 2024 at 02:05:05PM GMT, Vladimir Isaev wrote:
>> Hi Andrew,
>>
>> 29.08.2024 11:40, Andrew Jones wrote:
>>> While the spec doesn't state it, setting timecmp to UINT64_MAX is
>>> another way to stop a timer, as it's considered setting the next
>>> timer event to occur at infinity. 
>>
>> I think this should be explicitly stated in the spec, since some software
>> may initially set time and timecmp to big values just to check how overflow
>> is handled. And without it no chance that all HW implementations will interpret
>> UINT64_MAX as 'stop timer'.
>>
>> Do we need github issue on SSTC/privileged?
> 
> Hi Vladimir,
> 
> I don't think we need to update the spec, so hardware is free to make the
> interrupt pending if time ever reaches UINT64_MAX. However, the hardware
> will then need to clear the pending interrupt on the very next increment
> of time. This means even if the interrupt is raised it will most likely
> look spurious to the handler. I think we can leave this to software. If
> the software wants to use UINT64_MAX to stop timers, then it may also want
> to add a check in its timer handlers for timecmp == UINT64_MAX, and, under
> that condition, just ignore the interrupt.
> 

oh, I got it, thank you for explanation!

> Thanks,
> drew
> 
>>
>> Thank you,
>> Vladimir Isaev
>>
>>> And, even if the time CSR does
>>> eventually reach UINT64_MAX, the very next tick will bring it back to
>>> zero, once again less than timecmp. For this reason
>>> riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
>>> previously set timecmp has not yet expired, then setting timecmp to
>>> UINT64_MAX to disable / stop it would not work, as the special case
>>> left the previous QEMU timer active, which would then still deliver
>>> an interrupt at that previous timecmp time. Ensure the stopped timer
>>> will not still deliver an interrupt by also deleting the QEMU timer
>>> in the UINT64_MAX special case.
>>>
>>> Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when timecmp == UINT64_MAX")
>>> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>>  target/riscv/time_helper.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
>>> index 8d245bed3ae3..bc0d9a0c4c35 100644
>>> --- a/target/riscv/time_helper.c
>>> +++ b/target/riscv/time_helper.c
>>> @@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
>>>       * equals UINT64_MAX.
>>>       */
>>>      if (timecmp == UINT64_MAX) {
>>> +        timer_del(timer);
>>>          return;
>>>      }
>>>  
>>
>>
>>


