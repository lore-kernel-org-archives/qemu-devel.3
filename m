Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E0CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBnc3-0002kX-AK; Mon, 27 May 2024 23:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sBnc0-0002jG-Q9
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:34:56 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sBnbr-0003jq-MX
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:34:50 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681907af6a8so283091a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1716867279; x=1717472079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUURy1C5MsuCRmz8UoV052T9DBPc2pajgYSBfEUNOVs=;
 b=LgIIXIsKC149by8bbdIfb862YIG72CUTHOFVjKzUwr7bj/EzcYtj67J1vSFEtkxyfg
 EiOimtSd4qKvoWw5iqPx4Dif4wdOnkrP8Y+pH5PEb5Av43rjkEdWvmMC28fRANZ7Hlo7
 PszVNXBFOSWg7lfwA7btbW2dXAL7unxdoNkNBipeVrkiVScfiM7wAzWyMVEr3glb/baW
 8P8j30Kx1ca9pPh1Kl66w5FCtZu8ojOS8xCLnNOYl9ch8VG/YPjUsW+oETjF/QqYTnLy
 g9P3AbEbS54miYFePrpJ1Xzxey1YNSBcpGqGu3NQw5oTIySAwkW/OZW5koI6sltxC2/Z
 jfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716867279; x=1717472079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUURy1C5MsuCRmz8UoV052T9DBPc2pajgYSBfEUNOVs=;
 b=IwsmUQvKZniSrLSX07sj8mTg5ZwIg7tyQNicYxbiRAP0dFICN2zeg4vXFh1131kMBY
 LC9/gYo/vN4QCGM2ISWMgStgyqgM4LifJsNaLOSBOMG7t9zKF91tUVGK4aX9l1PrPQhZ
 y5AWFUvuHH99jqOU0uAdgpGBTkFXa080b/exXWE9M5PpVer4SrOSftSAUPQymfdGtFMS
 IvGYr7a4TUKaq9u5q5tyG/vrSETA70ejCHsoX7q5RO8gUejytckBRIgFUtydIOR/h7UR
 VNrORd6V9W/XR96i5UarshQetN+EFrXtRIOr9GFoTEFfhyy8vTUQtiM9jmLVObD9xdv2
 qnwA==
X-Gm-Message-State: AOJu0YxpNGZCgiPpJq7Jq1V0NiMF7t0ACOTIr5yU/L22pkeCPsZN2bDI
 k+hRrK69qFJeUsSicEbm99HOs0RxLpsHdMQCCpCFfXyr0Hp9f1W8pX33uFvKz4M=
X-Google-Smtp-Source: AGHT+IEr5lZqpWUa9fLZ+dcr4GSNmeMaeSPe7tjDPe6iVvXf5y7BzkMwU/kqDtnHTMOT6YnOgyb6XQ==
X-Received: by 2002:a05:6a20:e188:b0:1b2:1ef8:3409 with SMTP id
 adf61e73a8af0-1b21ef8373bmr10041407637.49.1716867279470; 
 Mon, 27 May 2024 20:34:39 -0700 (PDT)
Received: from [10.84.140.51] ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9ccdb0sm71065195ad.273.2024.05.27.20.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 20:34:39 -0700 (PDT)
Message-ID: <05a50abf-7899-4113-8f63-47409657729d@bytedance.com>
Date: Tue, 28 May 2024 11:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: cpu: fixup number of addressable IDs for processor
 cores in the physical package
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Igor Mammedov <imammedo@redhat.com>
References: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
 <ZlVCDdpTvu9HmV/W@intel.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <ZlVCDdpTvu9HmV/W@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Zhao,

On 2024/5/28 上午10:31, Zhao Liu wrote:
> Hi Chuang,
>
> On Mon, May 27, 2024 at 11:13:33AM +0800, Chuang Xu wrote:
>> Date: Mon, 27 May 2024 11:13:33 +0800
>> From: Chuang Xu <xuchuangxclwt@bytedance.com>
>> Subject: [PATCH] x86: cpu: fixup number of addressable IDs for processor
>>   cores in the physical package
> According to the usual practice of QEMU commits, people tend to use
> "i386/cpu" as the subject prefix, which indicates the code path.
>
>> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
>>
>> When QEMU is started with:
>> -cpu host,host-cache-info=on,l3-cache=off \
> Just a discussion, "l3-cache=off" doesn't work in host cache pssthu
> case, do you have a specific need that you don't want to see l3 cache?
>
No specific need, just generated by libvirt.
>> -smp 2,sockets=1,dies=1,cores=1,threads=2
>> Guest can't acquire maximum number of addressable IDs for processor cores in
>> the physical package from CPUID[04H].
>>
>> This bug was introduced in commit d7caf13b5fcf742e5680c1d3448ba070fc811644.
>> Fix it by changing the judgement condition to a >= 1.
> Pls add a "Fixes" tag like:
>
> Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
>
> Since this is a historical issue that deserves to be ported to the
> stable branch, you can cc stable list by:
>
> Cc: qemu-stable@nongnu.org
>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> As the patch sender, it's better to put your signature on the last line.
> ;-)
>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> ---
>>   target/i386/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index cd16cb893d..0369c01153 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6097,7 +6097,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>               if (*eax & 31) {
>>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>>                   int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>> -                if (cs->nr_cores > 1) {
>> +                if (cs->nr_cores >= 1) {
> Like Igor suggested, this condition could be removed since cs->nr_cores can't
> be 0.
>
>>                       *eax &= ~0xFC000000;
>>                       *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>>                   }
> ...the code is outdated, pls rebase on the latest master branch.
My fault, sorry for forgetting to pull the latest code..
> Regards,
> Zhao
>
Thanks for all your suggestions!

Chuang


