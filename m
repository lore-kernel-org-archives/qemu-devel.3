Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E54C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3vQ-0002ez-8P; Wed, 05 Jun 2024 23:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sF3vN-0002eT-68
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:36:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sF3vK-00051Z-8k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:36:24 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxW+qwLmFmPhEEAA--.17256S3;
 Thu, 06 Jun 2024 11:36:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxbcetLmFmnW8WAA--.56324S3; 
 Thu, 06 Jun 2024 11:36:15 +0800 (CST)
Subject: Re: [PATCH 2/2] util/bufferiszero: Add simd acceleration for
 loongarch64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-3-maobibo@loongson.cn>
 <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
 <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
 <58ba9ea7-cc45-47d4-a278-3777b496cb44@linaro.org>
 <d504ffbb-353a-452f-bfb1-2640ee1badc9@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <da613eb1-65f8-b690-4517-04640581261b@loongson.cn>
Date: Thu, 6 Jun 2024 11:36:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d504ffbb-353a-452f-bfb1-2640ee1badc9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbcetLmFmnW8WAA--.56324S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurW5CF45XF1kWF4kCFWDZFc_yoWrCr18pr
 ZYkFyYyFW5Jrn3tr9xtw15Xr95tr18X3WDWF43JryUArs0qrn2qr4qgryq9F1Fqw4kJFy2
 vF4Fq34fuFy7JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.975,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/6/6 上午11:27, Richard Henderson wrote:
> On 6/5/24 20:18, Richard Henderson wrote:
>> On 6/5/24 19:30, maobibo wrote:
>>>
>>>
>>> On 2024/6/6 上午7:51, Richard Henderson wrote:
>>>> On 6/5/24 02:32, Bibo Mao wrote:
>>>>> Different gcc versions have different features, macro CONFIG_LSX_OPT
>>>>> and CONFIG_LASX_OPT is added here to detect whether gcc supports
>>>>> built-in lsx/lasx macro.
>>>>>
>>>>> Function buffer_zero_lsx() is added for 128bit simd fpu optimization,
>>>>> and function buffer_zero_lasx() is for 256bit simd fpu optimization.
>>>>>
>>>>> Loongarch gcc built-in lsx/lasx macro can be used only when compiler
>>>>> option -mlsx/-mlasx is added, and there is no separate compiler option
>>>>> for function only. So it is only in effect when qemu is compiled with
>>>>> parameter --extra-cflags="-mlasx"
>>>>>
>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>> ---
>>>>>   meson.build         |  11 +++++
>>>>>   util/bufferiszero.c | 103 
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 114 insertions(+)
>>>>>
>>>>> diff --git a/meson.build b/meson.build
>>>>> index 6386607144..29bc362d7a 100644
>>>>> --- a/meson.build
>>>>> +++ b/meson.build
>>>>> @@ -2855,6 +2855,17 @@ 
>>>>> config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
>>>>>       void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
>>>>>     '''))
>>>>> +# For Loongarch64, detect if LSX/LASX are available.
>>>>> + config_host_data.set('CONFIG_LSX_OPT', cc.compiles('''
>>>>> +    #include "lsxintrin.h"
>>>>> +    int foo(__m128i v) { return __lsx_bz_v(v); }
>>>>> +  '''))
>>>>> +
>>>>> +config_host_data.set('CONFIG_LASX_OPT', cc.compiles('''
>>>>> +    #include "lasxintrin.h"
>>>>> +    int foo(__m256i v) { return __lasx_xbz_v(v); }
>>>>> +  '''))
>>>>
>>>> Both of these are introduced by gcc 14 and llvm 18, so I'm not 
>>>> certain of the utility of separate tests.  We might simplify this with
>>>>
>>>>    config_host_data.set('CONFIG_LSX_LASX_INTRIN_H',
>>>>      cc.has_header('lsxintrin.h') && cc.has_header('lasxintrin.h'))
>>>>
>>>>
>>>> As you say, these headers require vector instructions to be enabled 
>>>> at compile-time rather than detecting them at runtime.  This is a 
>>>> point where the compilers could be improved to support 
>>>> __attribute__((target("xyz"))) and the builtins with that.  The i386 
>>>> port does this, for instance.
>>>>
>>>> In the meantime, it means that you don't need a runtime test.  
>>>> Similar to aarch64 and the use of __ARM_NEON as a compile-time test 
>>>> for simd support.  Perhaps
>>>>
>>>> #elif defined(CONFIG_LSX_LASX_INTRIN_H) && \
>>>>        (defined(__loongarch_sx) || defined(__loongarch_asx))
>>>> # ifdef __loongarch_sx
>>>>    ...
>>>> # endif
>>>> # ifdef __loongarch_asx
>>>>    ...
>>>> # endif
>>> Sure, will do in this way.
>>> And also there is runtime check coming from hwcap, such this:
>>>
>>> unsigned info = cpuinfo_init();
>>>    if (info & CPUINFO_LASX)
>>
>> static biz_accel_fn const accel_table[] = {
>>      buffer_is_zero_int_ge256,
>> #ifdef __loongarch_sx
>>      buffer_is_zero_lsx,
>> #endif
>> #ifdef __loongarch_asx
>>      buffer_is_zero_lasx,
>> #endif
>> };
>>
>> static unsigned best_accel(void)
>> {
>> #ifdef __loongarch_asx
>>      /* lasx may be index 1 or 2, but always last */
>>      return ARRAY_SIZE(accel_table) - 1;
>> #else
>>      /* lsx is always index 1 */
>>      return 1;
>> #endif
>> }
size of accel_table is decided at compile-time, will it be better if 
runtime checking is added also?  something like this:

  unsigned info = cpuinfo_init();

  #ifdef __loongarch_asx
  if (info & CPUINFO_LASX) {
       /* lasx may be index 1 or 2, but always last */
       return ARRAY_SIZE(accel_table) - 1;
  }
  #endif

> 
> It occurs to me that by accumulating host specific sections to this 
> file, we should split it like the atomics.  Put each portion in 
> host/include/*/host/bufferiszero.h.inc.
sure, will do.

> 
> I'll send a patch set handling the existing two hosts.
> 
> 
> r~
> 


