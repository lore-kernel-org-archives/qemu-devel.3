Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49634C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjUb0-0001fO-83; Tue, 14 Jul 2026 00:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wjUay-0001f1-D4; Tue, 14 Jul 2026 00:18:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wjUaj-00034e-DG; Tue, 14 Jul 2026 00:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784002657; bh=WvoQDYy0yohCZowgwj9SuD5RxC32WRG78XHBsHtnb90=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bj28313XPcQ/EbGMGqVXjEv8bE47BENMAqeekckegnF2Pa04fw5ZVklQPaG8+0vSf
 TpqoMtI8ElKahwZO/VwEF/PTEJeRv3MTbuspbMUzve03sVlwv7sv5aPMdspLz6Lzcp
 TrATetLXwKxVcYbZuQBrSecmisASI9uMNlv8okBhChAP0OCrEySLQsGGjBCGvz201K
 ALpJbD56dz+oF66CsKD83jaUOa2pNN1NLgCRVZUa/mFq8on6OyfnxRRnxj5VCm8oyN
 5c4eAbW+M4C3VdMjs3oHwV5O12drYEv2iq8c99foMRVkEyb98+9pJD6F4BmtvTDRux
 jb6sl3xl+0DbQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 126981C1576;
 Tue, 14 Jul 2026 07:17:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF1643EE2B7;
 Tue, 14 Jul 2026 07:17:37 +0300 (MSK)
Message-ID: <c5a9e4fb-5715-4805-8376-8ea13f5b48c5@tls.msk.ru>
Date: Tue, 14 Jul 2026 07:17:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/riscv/riscv-iommu.c: fault when !PTE_U and no
 priv access
To: Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
 <20260701121111.537654-3-daniel.barboza@oss.qualcomm.com>
 <731566cb-bbdd-418f-b80e-f68750f24212@tls.msk.ru> <87tsq3doxw.fsf@suse.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsFNBGYpLkcBEACsajkUXU2lngbm6RyZuCljo19q/XjZTMikctzMoJnBGVSmFV66kylUghxs
 HDQQF2YZJbnhSVt/mP6+V7gG6MKR5gYXYxLmypgu2lJdqelrtGf1XtMrobG6kuKFiD8OqV6l
 2M5iyOZT3ydIFOUX0WB/B9Lz9WcQ6zYO9Ohm92tiWWORCqhAnwZy4ua/nMZW3RgO7bM6GZKt
 /SFIorK9rVqzv40D6KNnSyeWfqf4WN3EvEOozMfWrXbEqA7kvd6ShjJoe1FzCEQ71Fj9dQHL
 DZG+44QXvN650DqEtQ4RW9ozFk3Du9u8lbrXC5cqaCIO4dx4E3zxIddqf6xFfu4Oa5cotCM6
 /4dgxDoF9udvmC36qYta+zuDsnAXrYSrut5RBb0moez/AR8HD/cs/dS360CLMrl67dpmA+XD
 7KKF+6g0RH46CD4cbj9c2egfoBOc+N5XYyr+6ejzeZNf40yjMZ9SFLrcWp4yQ7cpLsSz08lk
 a0RBKTpNWJdblviPQaLW5gair3tyJR+J1ER1UWRmKErm+Uq0VgLDBDQoFd9eqfJjCwuWZECp
 z2JUO+zBuGoKDzrDIZH2ErdcPx3oSlVC2VYOk6H4cH1CWr9Ri8i91ClivRAyVTbs67ha295B
 y4XnxIVaZU+jJzNgLvrXrkI1fTg4FJSQfN4W5BLCxT4sq8BDtwARAQABzSBNaWNoYWVsIFRv
 a2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLBlAQTAQoAPhYhBJ2L4U4/Kp3XkZko8WGtPZjs3yyO
 BQJmKS5HAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGGtPZjs3yyOZSAP
 /ibilK1gbHqEI2zR2J59Dc0tjtbByVmQ8IMh0SYU3j1jeUoku2UCgdnGKpwvLXtwZINgdl6Q
 cEaDBRX6drHLJFAi/sdgwVgdnDxaWVJO/ZIN/uJI0Tx7+FSAk8CWSa4IWUOzPNmtrDfb4z6v
 G36rppY8bTNKbX6nWFXuv2LXQr7g6+kKnbwv4QFpD+UFF1CrLm3byMq4ikdBXpZx030qBL61
 b7PrfXcBLao0357kWGH6C2Zu4wBnDUJwGi68pI5rzSRAFyAQsE89sjLdR1yFoBH8NiFnAQXP
 LA8Am9FMsC7D/bi/kwKTJdcZvzdGU1HG6tJvXLWC+nqGpJNBzRdDpjqtxNuL76vVd/JbsFMS
 JchLN+01fNQ5FHglvkd6md7vO+ULq+r9An5hMiDoRbYVUOBN8uiYNk+qKbdgSfbhsgPURqHi
 1bXkgMeMasqWbGMe7iBW/YH2ePfZ6HuKLNQDCkiWZYPQZvyXHvQHjuJJ5+US81tkqM+Q6Snq
 0L/O/LD0qLlbinHrcx0abg06VXBoYmGICJpf/3hhWQM4f+B/5w4vpl8q0B6Osz01pBUBfYak
 CiYCNHMWWVZkW9ZnY7FWiiPOu8iE1s5oPYqBljk3FNUk04SDKMF5TxL87I2nMBnVnvp0ZAuY
 k9ojiLqlhaKnZ1+zwmwmPmXzFSwlyMczPUMSzsFNBGYpLkcBEAC0mxV2j5M1x7GiXqxNVyWy
 OnlWqJkbkoyMlWFSErf+RUYlC9qVGwUihgsgEhQMg0nJiSISmU3vsNEx5j0T13pTEyWXWBdS
 XtZpNEW1lZ2DptoGg+6unpvxd2wn+dqzJqlpr4AY3vc95q4Za/NptWtSCsyJebZ7DxCCkzET
 tzbbnCjW1souCETrMy+G916w1gJkz4V1jLlRMEEoJHLrr1XKDdJRk/34AqXPKOzILlWRFK6s
 zOWa80/FNQV5cvjc2eN1HsTMFY5hjG3zOZb60WqwTisJwArjQbWKF49NLHp/6MpiSXIxF/FU
 jcVYrEk9sKHN+pERnLqIjHA8023whDWvJide7f1V9lrVcFt0zRIhZOp0IAE86E3stSJhZRhY
 xyIAx4dpDrw7EURLOhu+IXLeEJbtW89tp2Ydm7TVAt5iqBubpHpGTWV7hwPRQX2w2MBq1hCn
 K5Xx79omukJisbLqG5xUCR1RZBUfBlYnArssIZSOpdJ9wWMK+fl5gn54cs+yziUYU3Tgk0fJ
 t0DzQsgfd2JkxOEzJACjJWti2Gh3szmdgdoPEJH1Og7KeqbOu2mVCJm+2PrNlzCybOZuHOV5
 +vSarkb69qg9nU+4ZGX1m+EFLDqVUt1g0SjY6QmM5yjGBA46G3dwTEV0/u5Wh7idNT0mRg8R
 eP/62iTL55AM6QARAQABwsF8BBgBCgAmFiEEnYvhTj8qndeRmSjxYa09mOzfLI4FAmYpLkcC
 GwwFCRLMAwAACgkQYa09mOzfLI53ag/+ITb3WW9iqvbjDueV1ZHwUXYvebUEyQV7BFofaJbJ
 Sr7ek46iYdV4Jdosvq1FW+mzuzrhT+QzadEfYmLKrQV4EK7oYTyQ5hcch55eX00o+hyBHqM2
 RR/B5HGLYsuyQNv7a08dAUmmi9eAktQ29IfJi+2Y+S1okAEkWFxCUs4EE8YinCrVergB/MG5
 S7lN3XxITIaW00faKbqGtNqij3vNxua7UenN8NHNXTkrCgA+65clqYI3MGwpqkPnXIpTLGl+
 wBI5S540sIjhgrmWB0trjtUNxe9QcTGHoHtLeGX9QV5KgzNKoUNZsyqh++CPXHyvcN3OFJXm
 VUNRs/O3/b1capLdrVu+LPd6Zi7KAyWUqByPkK18+kwNUZvGsAt8WuVQF5telJ6TutfO8xqT
 FUzuTAHE+IaRU8DEnBpqv0LJ4wqqQ2MeEtodT1icXQ/5EDtM7OTH231lJCR5JxXOnWPuG6el
 YPkzzso6HT7rlapB5nulYmplJZSZ4RmE1ATZKf+wUPocDu6N10LtBNbwHWTT5NLtxNJAJAvl
 ojis6H1kRWZE/n5buyPY2NYeyWfjjrerOYt3er55n4C1I88RSCTGeejVmXWuo65QD2epvzE6
 3GgKngeVm7shlp7+d3D3+fAAHTvulQQqV3jOodz+B4yzuZ7WljkNrmrWrH8aI4uA98c=
In-Reply-To: <87tsq3doxw.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/13/26 16:00, Fabiano Rosas wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 

[..]
>> So, this patch adds a fix for the testing bits.
>>
>> When trying to pick this one up for 10.0.x (LTS) series, I've another doubt.
>> This testing fix fixes v10.2.0-1299-g9d8ffbfc1d3 "tests/qtest/libqos: Add RISC-V
>> IOMMU helper library".  Quite some tests were added based on that library.
>> It doesn't exist in 10.0.x, and neither is v10.2.0-656-g489812e32df
>> "tests/qtest/libqos: Add SMMUv3 helper library".
>> Sure I can drop the parts of this change which touches the tests.  But this
>> means we don't have tests to cover the issues being fixed, and I don't know
>> if the result of these fixes actually works or not.
>>
>> Should we pick up some testing bits in this area for 10.0.x (especially
>> 9d8ffbfc1d3 and some subsequent commits which use this library)?  Or just
>> ignore all riscv iommu patches in there?
> 
> I worry picking tests for stable could become a development task,
> requiring new code to make tests suitable for an older codebase/test
> codebase.
> 
> The test frameworks and their supporting infrastructure (such as the
> riscv iommu lib) don't ensure a stable abi so that a test from one
> version will run without issues when backported to an earlier
> version.

> Also, the tests are usually not structured in a way that allow us to
> pick just the part that tests the code fixes being backported, so we
> risk trying to test in an earlier version features that don't even exist
> at that point. There could also exist a complex graph of what's broken
> vs. what is being tested (e.g. broken in v10, fixed partially in v11,
> then test needs change, then fixed properly in v12, test needs change
> again, etc).

Things aren't that bad in practice.  Even a large new test lib with
some significant amount of tests built on top mostly Just Works (tm).
A bigger problem is to pick them up across various restructuring of
code, moving and splitting files, etc.

Also, if a test fails due to old code, we can look and fix it, - it
is just a test after all.  Or even mark it as "ok to fail" - if we know
it's due to the old code.

But having no tests at all - in my view - is worse.  Besides the tests
which also needs some back-porting/reviewing work when picked up for
older releases, the main code needs the same.  And without the tests
in place -- no tests in place at all -- we just don't know if something
is broken until users start reporting it.  Provided there *are* users
of this code in the older releases to begin with :)

And actually, this last one is a good question, I think.  As in - do
we really need the fixed iommu stuff in 10.0.x, when a lot of other
development happened in this and other parts of riscv64 since then?
10.0.x is used in debian trixie (current stable), and probably that's
it, - not even ubuntu uses it (which is derived from debian).  So, I
wonder, if this stuff is really interesting to someone outside of the
most active riscv community, who most likely uses the current qemu
anyway?

I'll pick this particular change to 10.0.x as the last missing one from
this pull request, since all the others has been picked up (but without
the change to tests).  Speaking of the future changes, lemme send a
separate email summarizing all this in a single place.  It feels like
we don't actually need many riscv changes in older 10.0.x at least.

Thanks,

/mjt

