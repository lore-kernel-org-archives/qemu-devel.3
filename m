Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C7C3DA42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 02:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRjUh-0004Iz-Cj; Wed, 10 Jul 2024 22:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRjUY-0004IQ-Gx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:25:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRjUS-0006ZQ-KM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:25:04 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxVup1Qo9mYRcDAA--.134S3;
 Thu, 11 Jul 2024 10:24:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axw8RyQo9mCG5DAA--.12311S3; 
 Thu, 11 Jul 2024 10:24:52 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/gdbstub: Add vector registers support
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, richard.henderson@linaro.org
References: <20240621065406.864232-1-gaosong@loongson.cn>
 <d5bd6d9d-12ba-7175-36d6-e1cff76f1f47@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5169ae6c-4348-9485-dc6e-f5dfd284eb31@loongson.cn>
Date: Thu, 11 Jul 2024 10:25:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d5bd6d9d-12ba-7175-36d6-e1cff76f1f47@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axw8RyQo9mCG5DAA--.12311S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfGw4DKF1DuF1xGF1fGr47Jrc_yoW8GFy3Wo
 Wj9F1Yqr4rZrWruw1rZrn8Ga4aqF1UCFs7JFW7u3sxCa1SkryUA3y8XryYq3y5WrZ7Wr15
 G3yUG34qkFWUZry5l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY47kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84x
 RDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.148,
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

在 2024/7/10 下午5:37, maobibo 写道:
>
>
> On 2024/6/21 下午2:54, Song Gao wrote:
>> GDB already support LoongArch vector extension[1], QEMU gdb adds
>> LoongArch vector registers support, so that users can use 'info 
>> all-registers'
>> to get all vector registers values.
>>
>> [1]: 
>> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1e9569f383a3d5a88ee07d0c2401bd95613c222e
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>> based-on:
>> https://patchew.org/QEMU/20240607035016.2975799-1-maobibo@loongson.cn/
>>
>>   configs/targets/loongarch64-linux-user.mak |  2 +-
>>   configs/targets/loongarch64-softmmu.mak    |  2 +-
>>   gdb-xml/loongarch-lasx.xml                 | 60 +++++++++++++++++++
>>   gdb-xml/loongarch-lsx.xml                  | 59 ++++++++++++++++++
>>   target/loongarch/gdbstub.c                 | 70 +++++++++++++++++++++-
>>   5 files changed, 189 insertions(+), 4 deletions(-)
>>   create mode 100644 gdb-xml/loongarch-lasx.xml
>>   create mode 100644 gdb-xml/loongarch-lsx.xml
>>
>> diff --git a/configs/targets/loongarch64-linux-user.mak 
>> b/configs/targets/loongarch64-linux-user.mak
>> index d878e5a113..ea9b7e839a 100644
>> --- a/configs/targets/loongarch64-linux-user.mak
>> +++ b/configs/targets/loongarch64-linux-user.mak
>> @@ -1,4 +1,4 @@
>>   # Default configuration for loongarch64-linux-user
>>   TARGET_ARCH=loongarch64
>>   TARGET_BASE_ARCH=loongarch
>> -TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
>> +TARGET_XML_FILES=gdb-xml/loongarch-base64.xml 
>> gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml 
>> gdb-xml/loongarch-lasx.xml
>> diff --git a/configs/targets/loongarch64-softmmu.mak 
>> b/configs/targets/loongarch64-softmmu.mak
>> index 65b65e0c34..ce19ab6a16 100644
>> --- a/configs/targets/loongarch64-softmmu.mak
>> +++ b/configs/targets/loongarch64-softmmu.mak
>> @@ -2,6 +2,6 @@ TARGET_ARCH=loongarch64
>>   TARGET_BASE_ARCH=loongarch
>>   TARGET_KVM_HAVE_GUEST_DEBUG=y
>>   TARGET_SUPPORTS_MTTCG=y
>> -TARGET_XML_FILES= gdb-xml/loongarch-base32.xml 
>> gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
>> +TARGET_XML_FILES= gdb-xml/loongarch-base32.xml 
>> gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml 
>> gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
>>   # all boards require libfdt
>>   TARGET_NEED_FDT=y
>> diff --git a/gdb-xml/loongarch-lasx.xml b/gdb-xml/loongarch-lasx.xml
>> new file mode 100644
>> index 0000000000..753b982c65
>> --- /dev/null
>> +++ b/gdb-xml/loongarch-lasx.xml
>> @@ -0,0 +1,60 @@
>> +<?xml version="1.0"?>
>> +<!-- Copyright (C) 2022-2024 Free Software Foundation, Inc.
>> +
>> +     Copying and distribution of this file, with or without 
>> modification,
>> +     are permitted in any medium without royalty provided the copyright
>> +     notice and this notice are preserved.  -->
>> +
>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> +<feature name="org.gnu.gdb.loongarch.lasx">
>> +  <vector id="v8f32" type="ieee_single" count="8"/>
>> +  <vector id="v4f64" type="ieee_double" count="4"/>
>> +  <vector id="v32i8" type="int8" count="32"/>
>> +  <vector id="v16i16" type="int16" count="16"/>
>> +  <vector id="v8i32" type="int32" count="8"/>
>> +  <vector id="v4i64" type="int64" count="4"/>
>> +  <vector id="v2ui128" type="uint128" count="2"/>
>> +
>> +  <union id="lasxv">
>> +    <field name="v8_float" type="v8f32"/>
>> +    <field name="v4_double" type="v4f64"/>
>> +    <field name="v32_int8" type="v32i8"/>
>> +    <field name="v16_int16" type="v16i16"/>
>> +    <field name="v8_int32" type="v8i32"/>
>> +    <field name="v4_int64" type="v4i64"/>
>> +    <field name="v2_uint128" type="v2ui128"/>
>> +  </union>
>> +
>> +  <reg name="xr0" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr1" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr2" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr3" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr4" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr5" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr6" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr7" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr8" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr9" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr10" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr11" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr12" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr13" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr14" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr15" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr16" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr17" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr18" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr19" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr20" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr21" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr22" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr23" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr24" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr25" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr26" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr27" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr28" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr29" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr30" bitsize="256" type="lasxv" group="lasx"/>
>> +  <reg name="xr31" bitsize="256" type="lasxv" group="lasx"/>
>> +</feature>
>> diff --git a/gdb-xml/loongarch-lsx.xml b/gdb-xml/loongarch-lsx.xml
>> new file mode 100644
>> index 0000000000..51af1c6fd5
>> --- /dev/null
>> +++ b/gdb-xml/loongarch-lsx.xml
>> @@ -0,0 +1,59 @@
>> +<?xml version="1.0"?>
>> +<!-- Copyright (C) 2022-2024 Free Software Foundation, Inc.
>> +
>> +     Copying and distribution of this file, with or without 
>> modification,
>> +     are permitted in any medium without royalty provided the copyright
>> +     notice and this notice are preserved.  -->
>> +
>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>> +<feature name="org.gnu.gdb.loongarch.lsx">
>> +  <vector id="v4f32" type="ieee_single" count="4"/>
>> +  <vector id="v2f64" type="ieee_double" count="2"/>
>> +  <vector id="v16i8" type="int8" count="16"/>
>> +  <vector id="v8i16" type="int16" count="8"/>
>> +  <vector id="v4i32" type="int32" count="4"/>
>> +  <vector id="v2i64" type="int64" count="2"/>
>> +
>> +  <union id="lsxv">
>> +    <field name="v4_float" type="v4f32"/>
>> +    <field name="v2_double" type="v2f64"/>
>> +    <field name="v16_int8" type="v16i8"/>
>> +    <field name="v8_int16" type="v8i16"/>
>> +    <field name="v4_int32" type="v4i32"/>
>> +    <field name="v2_int64" type="v2i64"/>
>> +    <field name="uint128" type="uint128"/>
>> +  </union>
>> +
>> +  <reg name="vr0" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr1" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr2" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr3" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr4" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr5" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr6" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr7" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr8" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr9" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr10" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr11" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr12" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr13" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr14" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr15" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr16" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr17" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr18" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr19" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr20" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr21" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr22" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr23" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr26" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr25" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr26" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr27" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr28" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr29" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr30" bitsize="128" type="lsxv" group="lsx"/>
>> +  <reg name="vr31" bitsize="128" type="lsxv" group="lsx"/>
>> +</feature>
>> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
>> index a0e1439bd0..c9e2ddd943 100644
>> --- a/target/loongarch/gdbstub.c
>> +++ b/target/loongarch/gdbstub.c
>> @@ -116,8 +116,74 @@ static int loongarch_gdb_set_fpu(CPUState *cs, 
>> uint8_t *mem_buf, int n)
>>       return length;
>>   }
>>   +static int loongarch_gdb_get_vec(CPUState *cs, GByteArray 
>> *mem_buf, int n, int vl)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    CPULoongArchState *env = &cpu->env;
>> +    int i, length = 0;
>> +
>> +    if (0 <= n && n < 32) {
>> +        for (i = 0; i < vl / 64; i++) {
>> +            length += gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(i));
>> +    }
> There is tab line wrapper issue.
Thank you.  I will correct it.
>
>> +    }
>> +
>> +    return length;
>> +}
>> +
>> +static int loongarch_gdb_set_vec(CPUState *cs, uint8_t *mem_buf, int 
>> n, int vl)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    CPULoongArchState *env = &cpu->env;
>> +    int i, length = 0;
>> +
>> +    if (0 <= n && n < 32) {
>> +        for (i = 0; i < vl / 64; i++) {
>> +            env->fpr[n].vreg.D(i) = ldq_le_p(mem_buf + 8 * i);
>> +            length += 8;
>> +        }
>> +    }
>> +
>> +    return length;
>> +}
>> +
>> +static int loongarch_gdb_get_lsx(CPUState *cs, GByteArray *mem_buf, 
>> int n)
>> +{
>> +    return loongarch_gdb_get_vec(cs, mem_buf, n, LSX_LEN);
>> +}
>> +
>> +static int loongarch_gdb_set_lsx(CPUState *cs, uint8_t *mem_buf, int n)
>> +{
>> +    return loongarch_gdb_set_vec(cs, mem_buf, n, LSX_LEN);
>> +}
>> +
>> +static int loongarch_gdb_get_lasx(CPUState *cs, GByteArray *mem_buf, 
>> int n)
>> +{
>> +    return loongarch_gdb_get_vec(cs, mem_buf, n, LASX_LEN);
>> +}
>> +
>> +static int loongarch_gdb_set_lasx(CPUState *cs, uint8_t *mem_buf, 
>> int n)
>> +{
>> +    return loongarch_gdb_set_vec(cs, mem_buf, n, LASX_LEN);
>> +}
>> +
>>   void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs)
>>   {
>> -    gdb_register_coprocessor(cs, loongarch_gdb_get_fpu, 
>> loongarch_gdb_set_fpu,
>> - gdb_find_static_feature("loongarch-fpu.xml"), 0);
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>> +    CPULoongArchState *env = &cpu->env;
>> +
>> +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
>> +        gdb_register_coprocessor(cs, loongarch_gdb_get_fpu, 
>> loongarch_gdb_set_fpu,
>> + gdb_find_static_feature("loongarch-fpu.xml"), 0);
>> +    }
>> +
>> +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LSX)) {
>> +        gdb_register_coprocessor(cs, loongarch_gdb_get_lsx, 
>> loongarch_gdb_set_lsx,
>> + gdb_find_static_feature("loongarch-lsx.xml"), 0);
>> +    }
>> +
>> +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LASX)) {
>> +        gdb_register_coprocessor(cs, loongarch_gdb_get_lasx, 
>> loongarch_gdb_set_lasx,
>> + gdb_find_static_feature("loongarch-lasx.xml"), 0);
>> +    }
> Can you list the actual output of gdb with the three conditions such 
> as LASX/LSX/FP enabled?
>
> I doubt the code should be:
> if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LASX)) {
> ...
> } else if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LSX)) {
> ...
> } else if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
> ...
> }
>
On LoongArch host:

  ENABLE                     GDB
                   FP             LSX              LASX
   FP              √          unavailable    unavailable
   LSX            √               √             unavailable
   LASX          √               √                   √

Thanks.
Song Gao
> Regards
> Bibo Mao
>>   }
>>


