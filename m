Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A98C25B76
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 02:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF2ti-0001jr-St; Wed, 05 Jun 2024 22:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sF2tg-0001je-Kc
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 22:30:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sF2td-0002It-Lm
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 22:30:36 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx_epCH2Fm_A0EAA--.17197S3;
 Thu, 06 Jun 2024 10:30:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxBMU_H2Fmq2IWAA--.45616S3; 
 Thu, 06 Jun 2024 10:30:26 +0800 (CST)
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
From: maobibo <maobibo@loongson.cn>
Message-ID: <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
Date: Thu, 6 Jun 2024 10:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxBMU_H2Fmq2IWAA--.45616S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw17uw1DAFWUtry5uF48uFX_yoWrJw45pr
 9YkF1YyFWkJr1xtr97AF1Fgr9Yyr18Ww1UGayxtry5ZryrXw1vqr929r9I9F15Xan7Jry0
 vw48KryS9FyUArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
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



On 2024/6/6 上午7:51, Richard Henderson wrote:
> On 6/5/24 02:32, Bibo Mao wrote:
>> Different gcc versions have different features, macro CONFIG_LSX_OPT
>> and CONFIG_LASX_OPT is added here to detect whether gcc supports
>> built-in lsx/lasx macro.
>>
>> Function buffer_zero_lsx() is added for 128bit simd fpu optimization,
>> and function buffer_zero_lasx() is for 256bit simd fpu optimization.
>>
>> Loongarch gcc built-in lsx/lasx macro can be used only when compiler
>> option -mlsx/-mlasx is added, and there is no separate compiler option
>> for function only. So it is only in effect when qemu is compiled with
>> parameter --extra-cflags="-mlasx"
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   meson.build         |  11 +++++
>>   util/bufferiszero.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 6386607144..29bc362d7a 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2855,6 +2855,17 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', 
>> cc.compiles('''
>>       void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
>>     '''))
>> +# For Loongarch64, detect if LSX/LASX are available.
>> + config_host_data.set('CONFIG_LSX_OPT', cc.compiles('''
>> +    #include "lsxintrin.h"
>> +    int foo(__m128i v) { return __lsx_bz_v(v); }
>> +  '''))
>> +
>> +config_host_data.set('CONFIG_LASX_OPT', cc.compiles('''
>> +    #include "lasxintrin.h"
>> +    int foo(__m256i v) { return __lasx_xbz_v(v); }
>> +  '''))
> 
> Both of these are introduced by gcc 14 and llvm 18, so I'm not certain 
> of the utility of separate tests.  We might simplify this with
> 
>    config_host_data.set('CONFIG_LSX_LASX_INTRIN_H',
>      cc.has_header('lsxintrin.h') && cc.has_header('lasxintrin.h'))
> 
> 
> As you say, these headers require vector instructions to be enabled at 
> compile-time rather than detecting them at runtime.  This is a point 
> where the compilers could be improved to support 
> __attribute__((target("xyz"))) and the builtins with that.  The i386 
> port does this, for instance.
> 
> In the meantime, it means that you don't need a runtime test.  Similar 
> to aarch64 and the use of __ARM_NEON as a compile-time test for simd 
> support.  Perhaps
> 
> #elif defined(CONFIG_LSX_LASX_INTRIN_H) && \
>        (defined(__loongarch_sx) || defined(__loongarch_asx))
> # ifdef __loongarch_sx
>    ...
> # endif
> # ifdef __loongarch_asx
>    ...
> # endif
Sure, will do in this way.
And also there is runtime check coming from hwcap, such this:

unsigned info = cpuinfo_init();
   if (info & CPUINFO_LASX)

> 
> 
> The actual code is perfectly fine, of course, since it follows the 
> pattern from the others.  How much improvement do you see from 
> bufferiszero-bench?
yes, it is much easier to follow others, it is not new things.

Here is the benchmark result, no obvious improvement with 1K
buffer size. 200% improvement with LASX, 100% improve with LSX
with 16K page size.

# /root/src/qemu/b/tests/bench/bufferiszero-bench --tap -k
# Start of cutils tests
# Start of bufferiszero tests
# buffer_is_zero #0:  1KB    13460 MB/sec
# buffer_is_zero #0:  4KB    36857 MB/sec
# buffer_is_zero #0: 16KB    69884 MB/sec
# buffer_is_zero #0: 64KB    80863 MB/sec
#
# buffer_is_zero #1:  1KB    11180 MB/sec
# buffer_is_zero #1:  4KB    27972 MB/sec
# buffer_is_zero #1: 16KB    42951 MB/sec
# buffer_is_zero #1: 64KB    43293 MB/sec
#
# buffer_is_zero #2:  1KB    10026 MB/sec
# buffer_is_zero #2:  4KB    18373 MB/sec
# buffer_is_zero #2: 16KB    23933 MB/sec
# buffer_is_zero #2: 64KB    25180 MB/sec

Regards
Bibo Mao

> 
> 
> r~


