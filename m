Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F29D1A44A
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 08:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szXCo-0001v6-0h; Sat, 12 Oct 2024 04:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1szXCk-0001uS-6B
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 04:10:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1szXCh-0007bH-Mw
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 04:10:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so22001855ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728720619; x=1729325419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvnpsPs2T5XoEp9pE4R38pyZFQ5n3xUJy6VWpxC9bfU=;
 b=ORhi6ywhMVPRDpmoqw1Se4x9bbkxNQt0/ulpW6J25eeM4AhegykzoqWCm8MzBsdkKW
 10xmTEazGat1Lx5zeoww03gHEDSf7a7cjO46Ac5NIPCo2hV+YFOakA0uTnuSjWn/2i8F
 K+1TUtIS70xCEbuYvPhiW+1KNqLWVR7/9VSTFpV/u/1p7GSbe8YKh37Mr95CsqU97lZT
 oFv4El6MgSX4w3BlVeSHdVN9dbb9bdZGkZJ6UiY+0+6KtNi1M4R4rotEhx3mRrKr8UZa
 axTmq3QyaKXTq7bwLxmhQoprT/aFDD96zaIQTpeL9X9VLkxbgSuLHNKW/KxLpj4aTVvf
 Xn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728720619; x=1729325419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tvnpsPs2T5XoEp9pE4R38pyZFQ5n3xUJy6VWpxC9bfU=;
 b=bPAIZe9hgxGVxeYW6UcpZeXwYc1a7kz/I2caEzCRnGIA7CoMVMQ4SD9wAWfsr4G/dV
 /t5SmGpba1RvLC3WFoGtQZsM0IxVs6uglumMQLoD+yDYteJEEB+QOBVbQvclmE/i5R0S
 gDlYO5QH/EJZvzfH5SFBwIdfjFZEBeaC/WfBQmhksIlYGTu9Y/chbLEQY7qmvUNyelRR
 VBRSgJdoOGkS86qSm6mMSP7+q/pSXo6xh0/KMA3kq7VyDxsAFAd83BfbIhp/TKw/czx7
 VS0GanApuz4cjMucBUrI30Ur1eeOSgTeaWcFjonhExuqYFKn4q/HBgas7x+F1+2tum0n
 obtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD1mbJ91JGntariYlabmDDQKe4D2Snk0T0TWZN4B7YVm7H//hy/WjloZY/uQ9Raz3aBX/tJ2JZKIjw@nongnu.org
X-Gm-Message-State: AOJu0Yy9nTzxH1EpFqDr3uwIxm4VX89VXWDzK56k2gQRGpYlO1ynGTe0
 4F1E+o+/ukZKC/71IdhP1Bujqs7lKJqLiOHs7YlOFpteC6U1W1M0H82+Cj2mRQs=
X-Google-Smtp-Source: AGHT+IGs84trm198U4sYgheT64ByN3Y2GuTyX0oY3gyW4mt+q6ucLXlvTrdeqdocsyjaWpRG89arWg==
X-Received: by 2002:a17:90b:390a:b0:2e2:da81:40cb with SMTP id
 98e67ed59e1d1-2e3151b416amr2712676a91.6.1728720619466; 
 Sat, 12 Oct 2024 01:10:19 -0700 (PDT)
Received: from [10.84.144.194] ([63.216.146.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2b64aece7sm6332882a91.3.2024.10.12.01.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 01:10:19 -0700 (PDT)
Message-ID: <ceb6f780-5dc2-4df7-b4f3-70884124d705@bytedance.com>
Date: Sat, 12 Oct 2024 16:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <00f25e56-72e4-485a-a6a4-6b0c5563330d@intel.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <00f25e56-72e4-485a-a6a4-6b0c5563330d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.649,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Xiaoyao

On 10/12/24 下午3:13, Xiaoyao Li wrote:
> On 10/9/2024 11:56 AM, Chuang Xu wrote:
>> When QEMU is started with:
>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>
>> On Intel platform:
>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>> logical processors in the physical package".
>>
>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 
>> 90 for
>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>> CPUID.04H.EAX[31:26], which matches the expected result.
>>
>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>> integer too. Otherwise we may encounter unexpected results in guest.
>>
>> For example, when QEMU is started with CLI above and xtopology is 
>> disabled,
>> guest kernel 5.15.120 uses 
>> CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
>> calculate threads-per-core in detect_ht(). Then guest will get 
>> "90/(1+63)=1"
>> as the result, even though threads-per-core should actually be 2.
>>
>> And on AMD platform:
>> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
>> result meets our expectation.
>
> So for AMD platform, what's result for the same situation with 
> xtopology disabled? Does AMD uses another algorithm to calculate other 
> than CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) ?
>
For amd platform, CPUID.04H is reserved, so it uses 
CPUID.8000001E.EAX[15:8] (fied ThreadsPerComputeUnit) to obtain the result.
>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 
>> integer
>> only for Intel platform to solve the unexpected result.
>>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>> ---
>>   target/i386/cpu.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ff227a8c5c..641d4577b0 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>           }
>>           *edx = env->features[FEAT_1_EDX];
>>           if (threads_per_pkg > 1) {
>> -            *ebx |= threads_per_pkg << 16;
>> +            /*
>> +             * AMD requires logical processor count, but Intel needs 
>> maximum
>> +             * number of addressable IDs for logical processors per 
>> package.
>> +             */
>> +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>> +                *ebx |= threads_per_pkg << 16;
>> +            } else {
>> +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
>> +            }
>
> you need to handle the overflow case when the number of logical 
> processors > 255.
>
It seems other cpuid cases of bit shifting don't condiser the overflow 
case too..

Since intel only reserves 8bits for this field, do you have any 
suggestions to make sure this field emulated

correctly?

>>               *edx |= CPUID_HT;
>>           }
>>           if (!cpu->enable_pmu) {
>

