Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D80C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoQ6-00052k-C4; Tue, 25 Aug 2026 06:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyoQ3-00050I-TQ; Tue, 25 Aug 2026 06:30:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyoQ0-0007Jb-Eu; Tue, 25 Aug 2026 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787653763; bh=T58seEQ2+Mw3qyO1JL8K/lnp2B6Pgkkz57mJ0zmp67o=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=tMQqz4WmXpfkrZT4F7cTRTmUn0Sbpm7SiHEMDx/S50eMdIMwIIPBljFBd7S2YOoXZ
 UPpu4FvkDFWa18oLiwsyuEF4g0IATZ4ctpNxCcvuvjcFXv5ncUY4JqGqj9PWgJBlRp
 Nze/6jhlYeL0i1SqmnQD9BfLLUqyDQIP8F49wCQ7HH2lACBJDX3oovqMzwMZeHUE/b
 jjAcASj2/RK2Nsqk+iU4oGPErRP6JbBDdoD/a9oK61kPeJE6YqTMhTXbnGZbKJwOqZ
 YdfcX9SAVHWsNm4bGX7ZYWgNmJEL0N/ZdvfK8hZL9xTABc2iod/31bE9x048JybIBk
 7M4vWOfAMr+Ag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E292F1CE457;
 Tue, 25 Aug 2026 13:29:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC94641621F;
 Tue, 25 Aug 2026 13:30:00 +0300 (MSK)
Message-ID: <fb9606c6-b629-442c-a482-4ebb54dd232f@tls.msk.ru>
Date: Tue, 25 Aug 2026 13:29:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/43] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
From: Michael Tokarev <mjt@tls.msk.ru>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
 <20260821110101.3971391-14-peter.maydell@linaro.org>
 <fd8ab02f-d134-4241-ae40-1ae32007a9e1@tls.msk.ru>
Content-Language: en-US, ru-RU
In-Reply-To: <fd8ab02f-d134-4241-ae40-1ae32007a9e1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/21/26 19:44, Michael Tokarev wrote:
> On 8/21/26 14:00, Peter Maydell wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> The trans_WHILE_ptr function incorrectly handles the case where the
>> address difference divided by ESIZE results in zero. This happens when
>> the address difference is less than ESIZE but greater than zero.
>>
>> Fix by dropping direct comparisons of op0 vs op1, and instead
>> testing the scaled diff vs 0.  Merge with the bounding to the
>> maximum vector length via wrapping arithmetic.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 14f6dad168e ("target/arm: Implement SVE2 WHILERW, WHILEWR")
>> Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-id: 20260811191540.79882-3-richard.henderson@linaro.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
...
> While picking this one up for 10.0.x stable series, I come across an
> interesting case.  This very code were changed in v10.0.0-1961-gf96fd13c6ea0
> ("target/arm: Move scale by esz into helper_sve_while*"), and is now being
> dropped entirely.
> 
> The back-port of this patch to 10.0.x is below, and is also available at
> https://gitlab.com/mjt0k/qemu/-/commit/f25f16d5c5d364306ee88438704a9054855c12b0
> (staging-10.0 branch).  It should be okay, but I appreciate an additional
> look there, just in case :)
> 
> (Yes, I picked up the testcase too, and it passes).

So, this testcase fails on 10.0.x, here: https://gitlab.com/qemu-project/qemu/-/jobs/16088801753
sve-while-ptr: /home/gitlab-runner/builds/bCHvkPZE-/0/qemu-project/qemu/tests/tcg/aarch64/sve-while-ptr.c:19: main: Assertion `p == 0x1111' failed.

It seems this only happens on ubuntu-24.04-aarch64-all-linux-static job,
which is kinda unexpected.

I guess my backport is wrong for 10.0.x.

I'm dropping this change from 10.0.x for now, and will either take another
look at it later, trying to figure out what's going on, or I need help :)

Thanks,

/mjt

