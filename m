Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEC9D1CDC1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 03:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQzZi-0006aq-OI; Wed, 03 Dec 2025 22:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vQzZh-0006Zu-48
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:00:09 -0500
Received: from sg-1-18.ptr.blmpb.com ([118.26.132.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu@openatom.club>)
 id 1vQzZc-0005U1-An
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 22:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764817192;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/eOfff8m1Bd0DAhvZvHE2jR3QGjvN5IX6hQR0UmLTOU=;
 b=YSBl6zAb5Z4N7GJBMvnH9SNKQBi1VUA2bq8bnmn/l7b0RLUYjXMEnTmU+3hEq416otMmMC
 yJlF77H6XkhBg9l1bJyme80DPj5BYEZoCzf5C0IGUOuYqz8eBcau2wkcU4SwHPRYLXyXI4
 80YuUL+vb45ErHZK2dsTVQ/IZrCS6MdsOvdq2uguV1BVbeXTNNjH8W5j4OU2E6oAlErzHv
 qKsN/VeueJOdxLBzY21GqyW43blLKpqhWJNAmBBFkVu/TKTIr6OX/U4FMEORXSsM9NfUOH
 g4LIB8ySWILqSlYGkX7eAFoGfUjAvsO/FMWRW1szEe57UxMRX9Vt7FV3cU69rQ==
Content-Type: text/plain; charset=UTF-8
Received: from [10.13.14.160] ([218.81.29.112]) by smtp.feishu.cn with ESMTPS;
 Thu, 04 Dec 2025 10:59:49 +0800
X-Lms-Return-Path: <lba+26930f926+2989eb+nongnu.org+chao.liu@openatom.club>
Content-Transfer-Encoding: 7bit
To: "Conor Dooley" <conor@kernel.org>, "Chao Liu" <chao.liu@zevorn.cn>
Date: Thu, 4 Dec 2025 10:59:47 +0800
User-Agent: Mozilla Thunderbird
Cc: <richard.henderson@linaro.org>, <paolo.savini@embecosm.com>, 
 <npiggin@gmail.com>, <ebiggers@kernel.org>, <dbarboza@ventanamicro.com>, 
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
From: "Chao Liu" <chao.liu@openatom.club>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <c27edc69ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn>
 <20251203-squiggle-gentile-f27af704359e@spud>
 <20251203-huskiness-manhandle-6925834ee8f0@spud>
X-Original-From: Chao Liu <chao.liu@openatom.club>
In-Reply-To: <20251203-huskiness-manhandle-6925834ee8f0@spud>
Subject: Re: [PATCH v1 1/5] target/riscv: add thead-c908 cpu support
Message-Id: <20499d8c-cc75-4354-9eee-4d2e7023bd4c@openatom.club>
Mime-Version: 1.0
Received-SPF: pass client-ip=118.26.132.18;
 envelope-from=chao.liu@openatom.club; helo=sg-1-18.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/4/2025 1:13 AM, Conor Dooley wrote:
> On Wed, Dec 03, 2025 at 05:12:37PM +0000, Conor Dooley wrote:
>> On Sun, Nov 30, 2025 at 05:21:06PM +0800, Chao Liu wrote:
>>> The C908 processor is based on the RV64GCB[V] instruction
>>> set, compatible to RVA22 Profile and implements the XIE
>>> (XuanTie Instruction Extension) technology.
>>>
>>> Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
>>> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> ---
>>>  target/riscv/cpu-qom.h |   2 +
>>>  target/riscv/cpu.c     |  43 +++++
>>>  target/riscv/th_csr.c  | 380 ++++++++++++++++++++++++++++++++++++++++-
>>>  3 files changed, 424 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>> index 75f4e43408..1ddb5a6a6c 100644
>>> --- a/target/riscv/cpu-qom.h
>>> +++ b/target/riscv/cpu-qom.h
>>> @@ -52,6 +52,8 @@
>>>  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
>>>  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>>>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
>>> +#define TYPE_RISCV_CPU_THEAD_C908       RISCV_CPU_TYPE_NAME("thead-c908")
>>> +#define TYPE_RISCV_CPU_THEAD_C908V      RISCV_CPU_TYPE_NAME("thead-c908v")
>>>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>>>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>>>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index d055ddf462..202ff130ee 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -3091,6 +3091,49 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>  #endif
>>>      ),
>>>  
>>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
>>> +        .misa_mxl_max = MXL_RV64,
>>> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
>>> +        .priv_spec = PRIV_VERSION_1_12_0,
>>> +
>>> +        /* ISA extensions */
>>> +        .cfg.ext_xtheadba = true,
>>> +        .cfg.ext_xtheadbb = true,
>>> +        .cfg.ext_xtheadbs = true,
>>> +        .cfg.ext_xtheadcmo = true,
>>> +        .cfg.ext_xtheadcondmov = true,
>>> +        .cfg.ext_xtheadmac = true,
>>> +        .cfg.ext_xtheadmemidx = true,
>>> +        .cfg.ext_xtheadmempair = true,
>>> +        .cfg.ext_xtheadsync = true,
>>> +        .cfg.ext_zba = true,
>>> +        .cfg.ext_zbb = true,
>>> +        .cfg.ext_zbc = true,
>>> +        .cfg.ext_zbs = true,
>>> +        .cfg.ext_zkt = true,
>>> +        .cfg.ext_zbkc = true,
>>> +        .cfg.ext_zicsr = true,
>>> +        .cfg.ext_zifencei = true,
>>> +        .cfg.ext_zihintpause = true,
>>> +        .cfg.ext_zicbom = true,
>>> +        .cfg.ext_zicboz = true,
>>> +        .cfg.ext_zfh = true,
>>> +        .cfg.ext_xtheadfmv = true,
>>> +        .cfg.ext_xtheadfmemidx = true,
>>> +        .cfg.pmp = true,
>>
>> I think Svpbmt is missing here, both it and the T-Head MAEE stuff are
>> supported on the k230. What I will end up merging into mainline for the
> 
> Whoops, should have specified that I meant the mainline linux kernel.
> 
You're right, I will enable the Svpbmt extension in PATCH v2.

Thanks,
Chao
>> k230 uses Svpbmt instead of MAEE.
> 

