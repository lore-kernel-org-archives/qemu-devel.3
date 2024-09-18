Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1019CCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqthk-0001kN-EP; Wed, 18 Sep 2024 08:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sqthh-0001hF-BJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:22:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sqthe-0007Nn-DH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:22:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20551eeba95so51209115ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726662152; x=1727266952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoZvzrqtYkPzDqiF8l2U/IOSUyoXsdz6sZLSE507Qjc=;
 b=guTyO4Zcw0pE+1b8VGXDFEUcsOMbl23QK6uW52kzHvixt/11+ZFI+H63h7/rtn2XEm
 s04sbHvviOHL5wz0sJIOPA5vkiJ6rZBq8UTE848EXqCjRmZy1T2hJxWfHr4JARW1ffFT
 6g8osAPVOiJVxsKtrj5Bdi1qfhUWP9bykgXznR6IeSEYh+FdU72V/0blCPBPMYxrogNg
 5tYnw2WTOOx/QCKlrHxGpvvDSr2BgJFqhL1TY5460ljaGvsDyEvnjVDhzK347aNzR+Px
 LadOB98QikmB2UZBAAvFhM/HmAwu9+65bgjtqcrqOn4PATcIj20nlBT/PR8Itw0KPU4S
 2v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726662152; x=1727266952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VoZvzrqtYkPzDqiF8l2U/IOSUyoXsdz6sZLSE507Qjc=;
 b=Z2v1bFhXNLTKU0Lxob/hJQMLq7rfhLSLTxggl960m+wNDscwJSM1/Q/w8XuandhXvA
 qj48oUhysV8fv6GeRf1n0fwoXFcUMc/cp0/CRheONtCgaEPxaGk7QF0K/IiwQTgmVPoP
 TtcukbUK/6ucyts+iz4aTZkXkzeeXwDHnNOxkeZSr3FDL34FfjEOp2IINshVYi47WDc9
 SvaTj5didBg7zoZkG2crQmI3AxLYoJy1GnlwkyM1FqbgBeNOZCVuIpwExm4Q/7MqVmx8
 U1lxJMR82lW5P7lZQcUSQYYaLgmQh+ZAnesq8LbWDhFhD3bnkdBmzHGoJc9RKqk5AJ4Y
 5eJw==
X-Gm-Message-State: AOJu0YwlGKDzVOSqhO+PZvdqU9jZRNwgtJ5pFcXUIjPoDxYPf7WXqBa7
 DsUwvJG8MGJaThJlCqLxPtJwDA45uU4i5+mKdEhj23IkiXTcrGJOIL34Yt00zz8=
X-Google-Smtp-Source: AGHT+IGKSSr/Y2NQRxRzaK73LTt0r6gPwhXQZpu5lqftaqYYuqu35O4Pd6hFfdXBP949eyKu5nufRw==
X-Received: by 2002:a17:902:cf06:b0:206:aa2e:6d1f with SMTP id
 d9443c01a7336-2078296a953mr295103945ad.46.1726662152233; 
 Wed, 18 Sep 2024 05:22:32 -0700 (PDT)
Received: from [10.84.158.138] ([203.208.167.149])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946fab2bsm64293705ad.194.2024.09.18.05.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 05:22:31 -0700 (PDT)
Message-ID: <4967d160-bb34-498f-8f41-d451ac590482@bytedance.com>
Date: Wed, 18 Sep 2024 20:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20240914110127.67690-1-xuchuangxclwt@bytedance.com>
 <20240918140242.2c360209@imammedo.users.ipa.redhat.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <20240918140242.2c360209@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi, Igor:

On 2024/9/18 下午8:02, Igor Mammedov wrote:
> On Sat, 14 Sep 2024 19:01:27 +0800
> Chuang Xu <xuchuangxclwt@bytedance.com> wrote:
>
>> When QEMU is started with:
>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>
>> Execute "cpuid -1 -l 1 -r" in guest, we'll get:
>> eax=0x000806f8 ebx=0x465a0800 ecx=0xfffaba1f edx=0x3fa9fbff
>> CPUID.01H.EBX[23:16] is 90, while the expected value is 128.
>>
>> Execute "cpuid -1 -l 4 -r" in guest, we'll get:
>> eax=0xfc004121 ebx=0x02c0003f ecx=0x0000003f edx=0x00000000
>> CPUID.04H.EAX[31:26] is 63, which is as expected.
>>
>> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>> integer too. Otherwise we may encounter unexpected results in guest.
>>
>> For example, when QEMU is started with CLI above and xtopology is disabled,
>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
>> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
>> as the result, even though theads-per-core should actually be 2.
>>
>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
>> to solve the unexpected result.
>>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>> ---
>>   target/i386/cpu.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 4c2e6f3a71..24d60ead9e 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
>>       return num_ids - 1;
>>   }
>>   
>> +static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
>> +{
>> +    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
>> +    return num_threads;
>> +}
>> +
>>   static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>>   {
>>       uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
>> @@ -6417,7 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           }
>>           *edx = env->features[FEAT_1_EDX];
>>           if (threads_per_pkg > 1) {
>> -            *ebx |= threads_per_pkg << 16;
>> +            *ebx |= max_thread_number_in_package(&topo_info) << 16;
> why not use pow2ceil(threads_per_pkg) instead?

I saw in the latest code that calculations of cpuids involving CPU topology all use topo_info,
so in order to maintain consistency in code style, I also used topo_info for calculation.

>
>>               *edx |= CPUID_HT;
>>           }
>>           if (!cpu->enable_pmu) {

