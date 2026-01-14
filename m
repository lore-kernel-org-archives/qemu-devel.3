Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92800D37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 14:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1di-0003mQ-A5; Wed, 14 Jan 2026 09:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1vg1de-0003hl-0J; Wed, 14 Jan 2026 09:14:22 -0500
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1vg1da-0001AI-Va; Wed, 14 Jan 2026 09:14:21 -0500
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 2787960801E5;
 Wed, 14 Jan 2026 15:14:13 +0100 (CET)
Message-ID: <27f2e668-c324-4f3a-a485-06fb43bded7b@csgraf.de>
Date: Wed, 14 Jan 2026 15:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hvf/arm: handle FEAT_SME2 migration
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
 <20260114-sme2-hvf-v1-1-ce9599596736@linaro.org>
 <6edbbdd7-8992-420e-9aee-7596afbcf00d@csgraf.de>
 <CAAjaMXZehMtdZC+7obmRZgfE+T2Dn64GTY2MqncPq9grKGcSsw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <CAAjaMXZehMtdZC+7obmRZgfE+T2Dn64GTY2MqncPq9grKGcSsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
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


On 14.01.26 12:51, Manos Pitsidianakis wrote:
> On Wed, Jan 14, 2026 at 1:19 PM Alexander Graf <agraf@csgraf.de> wrote:
>> Hi Manos!
>>
>> On 14.01.26 09:35, Manos Pitsidianakis wrote:
>>> SME2 support adds the following state for HVF guests:
>>>
>>> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>>>     not support it)
>>> - Predicate registers P0, .., P15 (also FEAT_SVE)
>>> - ZA register
>>> - ZT0 register
>>> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
>>> - SMPRI_EL1 which handles the PE's priority in the SMCU
>>> - TPIDR2_EL0 the thread local ID register for SME
>>>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>
>> Thanks a lot for the patches. I don't have an M4/M5 handy (yet), so I
>> can't test the code works correctly. But it sounds like you did that, so
>> I have no concerns on functionality.
> Yes, I tested it on Linaro's M4 machine. Adding a functional test
> using Arm's benchmark is possible, but I couldn't be bothered to
> create vm image assets just for this :)
>
> Note: testing migration is tricky because the CPU has to be in SME
> mode for the Z/P registers to have meaningful values, so you need to
> savevm while SME instructions are executed to get a useful migration
> state. I modified Arm's benchmark to compare the SME matrix
> calculations against the non-SME calculation to ensure they are the
> same and I savevm/loadvm a bunch of times while it ran with added
> printfs in the get/put methods to print whether SME was active or not.
>
>> However, I have concerns on a few maintainability aspects. You #ifdef
>> out a lot of code conditionally on the target macOS version. Any of that
>> code that is in ifdef may or may not end up getting compiled in CI or
>> other test builds, which means you are missing out on a lot of
>> compilation test coverage. As a general rule of thumb, please reduce
>> #ifdef to the bare minimum.
> I agree completely, the problem is two-fold here: the HVF exposes APIs
> with API_AVAILABLE(...) (clang's availability attribute) and also with
> plain ifdefs (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200), and
> specifically the HV_SME_FOO_REG variants, which cannot be protected
> with the availability attribute. )
>
> So every time an SME type such as hv_vcpu_sme_state_t is used, it has
> to be guarded :/ __builtin_available(...) check is not sufficient
> because it will not compile due to undefined types.
>
>
>> One thing I like to do (when possible) is to use the ifdef to define a
>> global const variable or an inline function. That way the compiler's
>> dead code analysis will eliminate the non-active aspects of your code,
>> but all previous compiler phases still run which means you get syntax
>> checks.
>>
>> How much of the code down here really does require #ifdefs? And if it's
>> a lot, maybe we just bump the minimum required macOS version instead.
>>
> The missing type definitions and missing function declarations will
> still raise compiler errors unfortunately. We could add those missing
> type definitions as stubs if they are not defined so that it compiles,
> but I chose to ifdef instead. What would you prefer?


How about you create a separate #include'd header that provides stubs 
and defines the same way the original headers would? You can #ifdef your 
way inside there all you want. And then you write the generic code with 
the base assumption that all definitions are available.

Alex



