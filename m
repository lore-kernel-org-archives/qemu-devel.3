Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A10FE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDw5-0002Yc-I5; Fri, 24 Apr 2026 06:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDw4-0002YM-16
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:39:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDw2-0001we-9R
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:38:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so36521345e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777027136; x=1777631936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=74fVi5JPTgndw28mYVNUSy9hX7KtDLK5j2RfHoUH1FQ=;
 b=RR1m2goaRYoZzmx04dZd8t2+qjrSKgvUTXOrMd96EPkLA+6oWNfX3CP+x19fWUZSVw
 ffVLpHp1a6MS9Im705xVzRPnsT8IZLblGPL9vDmFSuwD7vs2dtIcEBQeFiSkSXMXGbYE
 3mfHyrNIidJtw6slLqDlFAhzoKjKtUUJTiKP5yJy+L3w3RlpYv8SU7sB1yLlzK1hid5o
 63ILnILeMRfXWTyQcPUFFSC3GEvHZ1pQbsDwsGXXT0qMeMJ9yxYIMBOLZRwdsWm3Cyl5
 IhZNhErE2V5gWPKAbMb9QVjcVm3n5BI8Dje2Ne93QRaEXw16Q8ggJ2oTHZF9Hgi5YXlR
 vYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777027136; x=1777631936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=74fVi5JPTgndw28mYVNUSy9hX7KtDLK5j2RfHoUH1FQ=;
 b=dQRlX1b+icc6T1AXY0gBJkZ85AdPGBuwSTCDh0E61JJP1mg687MJ70P4+AaLVOKc/g
 B+a81ZC4okKfrqKuzIDoQcWNDBgnM+jrt7B6x1GR90I1W1qjKqyTO7lyB6K7R8lK/WJ1
 4hFQ2piG3Xq/9zo/VUfE3LQUwudm60sGV9ZKPJzwLQZmTkhfYHaMrPo+z0XpP3UsbKxY
 Xg1OhLr6VLVRHeyF2xSKrj+6Znu0P3JGsw6voHACoBXsOK8sGIMlJ6FDz5w2OY12mnyl
 Vwlk+CcI7O0Hm3Tr8UGTpLZARQMuuchOGJgWqknLjfInr6mYVzI+HFJZzsc1SDBebuMx
 5+0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wSqphR45xHjMZqhmj8q8Mb9kU0w642t9gYyemV9rlDdC0TSCyHAyOEr7B29SpCwVLt4NNSJUGTrZe@nongnu.org
X-Gm-Message-State: AOJu0Ywbhlg7PxpLlX/d1TFgtYPj9rYbzOjLRLOKBneATO6f1Q9kTkrN
 AMnJ9wUvj2yoeX4GBad5ejFsvbF5tunrIfO6GOdMAgbM5pRdn+rBxlvKapkmcULSPns=
X-Gm-Gg: AeBDietmDXkKR8thnjcTVqzCTgHkXYXJViyOFtOskX6D7OVb8J7iooedhngSRfT8rNA
 Azblqgg393fva3GY8+rs3U/glOsEtMqAQyoiK9DGB2pAXgIf2WwHs0OR1SP2qtUMVQ26yNPTLJP
 32Rmn+ZZ6X+MjXxp5++FGvv5WvBc93kwCvxbVFVHS5mMKkDP/aNHF3KWAHy2zMHCbp5ZogRQHQN
 bUZ0F3xKqNb3/32yYNuvSEF/o4SbDjVBhMX6CdaA8aGnmXAY0BnQQpVj/3E/TTs7NOpz36KAbOr
 LW0imKuAS5/DTcaLzaC1gN4TMjw77rPWACaJmRPakEWkC1vHaxfwRF/mLiqKVOnaux09A9uZDs1
 0rxL6InO2hWl6PwWJL8H4mTXqQD9x76supOgjtyiU6XTe6E3zNK3J7ihJvFS9gGcVUe8dqn2QtW
 V6vufF8XNWaqTo7EiDatplaE9WvagRAkTh8qURNrka29j0B8yNTXBZCSu0jSLuDKkiL4n52Kr7q
 Srs
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a5821692dmr175685265e9.4.1777027136100; 
 Fri, 24 Apr 2026 03:38:56 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891b46cffasm404295135e9.13.2026.04.24.03.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 03:38:55 -0700 (PDT)
Message-ID: <06f3afc0-ffb5-42df-b800-c7d4ce112694@linaro.org>
Date: Fri, 24 Apr 2026 12:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] target: Simplify env_archcpu(cpu_env(cpu))
 expression
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-2-philmd@linaro.org>
 <03119ad8-de87-4bb4-8f73-062de85e8d6d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03119ad8-de87-4bb4-8f73-062de85e8d6d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/4/26 00:26, Richard Henderson wrote:
> On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
>> env_archcpu(cpu_env(CPUState)) expands to ArchCPU,
>> available via the ARCH_CPU() macro. Use the latter
>> to avoid using &env.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c       | 2 +-
>>   target/hexagon/translate.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5fc8f6bbbd9..2fb768048b8 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -2303,7 +2303,7 @@ static int hvf_handle_exception(CPUState *cpu, 
>> hv_vcpu_exit_exception_t *excp)
>>   static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>>   {
>> -    ARMCPU *arm_cpu = env_archcpu(cpu_env(cpu));
>> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
>>       int ret = 0;
> 
> ARM_CPU has an object_dynamic_cast_assert() inside; the env* converters 
> do not.
> You should be making a considered choice about this change, not just 
> "simpler".

If not calling object_dynamic_cast_assert() is what we want here, then
maybe we could add yet another QOM cast macro with explicit name,
otherwise at least add a comment why we don't use the same pattern.

Having to think about hidden knowledge of such performance penalty is
not great from an API point of view. I'd expect most new developers to
copy/paste working patterns without looking at macro expansion
involvments, WDYT?

