Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C35D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9Mf-00059P-KK; Tue, 20 Jan 2026 05:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Me-000591-4E
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:53:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Mc-0001GB-DT
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:53:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so24194015e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768906412; x=1769511212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pBcHmEdlPnVHeisONRE0lAPw55NOu3KoN6EiEkZTRBM=;
 b=UUQNt/RIhk2aKgSBQ5WM1YVa3ngkXVBNVhdb/KS3q0b/ZqcpKfsFGnXzfxRN5uxPFR
 Mv/RipD9jn2KXRYICrH9mkEfJ/3/djUvZZoEhnX/SmoTTbBL/0ZMqaxxqMpLz81HK0ZU
 +Pft4xv6VvfRxqeDmg8HiJRIASIrH7zRsFQ9HXCq0wrwBr7p/l3AFvWCx/EeETd6bwPe
 juEa9SVtuJR1cijiykay3CnFWVTI43+eyWsHe2rsBwm/wVrkghAku0WM3AQtKD/z4OIZ
 pD0pdb8clA3HvuiTTq8bxLVTujVG28sTgTBS9ubsMJleSL1g6sCvAvTGM8yHRBj9HL4X
 lJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906412; x=1769511212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBcHmEdlPnVHeisONRE0lAPw55NOu3KoN6EiEkZTRBM=;
 b=SagkBmlpyffr14srrSapJXAVyco56O5FJEXeEH7NvLRNGeUdP0o3HeVUbiF+QrsUPI
 RCa/g512i0sXKjR1sJy8LLUGTgtymF1mrNFDcJOQJpFoU9MMt8vg8y4+VnkiwgGIBhvP
 dL+ivFTrFKOTTRotyoUmBT6pvx6DJIc4c6Z/zTWVWaUsZB8/NucxJtPqJP1dEgAjLInf
 qqqr/VVbvNk1GKQ3GtfzBCvCafxiNbqEfBPpD54uRUgNlLv854Z53paXvIDsYn7Y+QIN
 wL7wiuNYXjTVbHO2BbfMcxYJTsjTWrZ8TDSbcxJxNZQ1mm0ZScqiQRFqZt61cOgrhOah
 Yprw==
X-Gm-Message-State: AOJu0YznhFE8EYCLILcKA3O/Dl1FlPVlgfgTvuuRGsv5pwMeWGOfENl/
 OL9z93LyTxgU+ENjS/UFvsTlb7QDtppukMeO03BeiiXhLStOCn/o6XSeNTpQ/vUUN+w=
X-Gm-Gg: AY/fxX4NPIOQl/ZUO2QoUHQA4atduAj0KH86pIXbHQ2XsMturLGiyYQZUmSZbMWEJFr
 Ak11s2wGuonSoyYy41aCbHty9PoFOqEBwqyIrMf1sRCc02zmuEtslZIbNReUKXCSUoOuPVk1Acx
 93L8erPwAoEESMCj91slOrSeA30wkeXVQ4V+5e9yPogvDsA9oORzIX1t4kvos0YuPzuh5Z0pO00
 +iQ1ekABCmXNoQteBfXQpNy5XP0B5TtErcQDFgSdfI/IlAak/hL5AW4ENaGww59qmx1nQRupbaE
 6Hfh1I3QaJAgLuUfkZedfiutoHGXscAOq+SOXwsxr3Y/aZni6+e0993BIumto0YirXf/o/rmsfw
 GdW5P2azSnqsUSW89Hdg1JDEDIh0Epun/931itpQ0jNGsf6P44Qp/XVBVj52ypcO2d75zPQ4/k0
 rSxFRFS2PhgmU2SFPW6+Dd1gdvtXnUoHi7AlvDcOlweP61DUEpm+0P8yLcJ3JtZP5D
X-Received: by 2002:a05:600c:c105:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4803e7e8586mr16957585e9.21.1768906412414; 
 Tue, 20 Jan 2026 02:53:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569998240sm28206757f8f.43.2026.01.20.02.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 02:53:31 -0800 (PST)
Message-ID: <31dfb73c-769f-49d2-9068-b8ac34180d77@linaro.org>
Date: Tue, 20 Jan 2026 11:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
 <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/1/26 11:01, Manos Pitsidianakis wrote:
> On Tue, Jan 20, 2026 at 11:50 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 15/1/26 12:20, Manos Pitsidianakis wrote:
>>> Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.
>>>
>>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>>    target/arm/cpu.c     |  4 +++-
>>>    target/arm/cpu64.c   | 13 ++++++++++++-
>>>    target/arm/hvf/hvf.c | 25 +++++++++++++------------
>>>    3 files changed, 28 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index caf7980b1fc5244c5c2f130e79ba869456c20c88..7f4ebfdf61217db6075495119c1b642bc2abf295 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1577,7 +1577,9 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
>>>             * assumes it, so if the user asked for sve=off then turn off SME also.
>>>             * (KVM doesn't currently support SME at all.)
>>>             */
>>> -        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
>>> +        if (!hvf_enabled()
>>
>> In my experience "if(!accel)" is bug prone, maybe change to explicit "if
>> (tcg_enabled() || kvm_enabled()"?
> 
> Shouldn't we list all accelerators instead of just tcg/kvm then?

Correct.

> 
> And why is if(!accel) bug prone?

I was thinking of f46f05b6d88 ("target/arm: Only allow disabling NEON
when using TCG").

> 
>>
>>> +            && cpu_isar_feature(aa64_sme, cpu)
>>> +            && !cpu_isar_feature(aa64_sve, cpu)) {
>>>                object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
>>>            }
>>>


>>> @@ -1252,6 +1252,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>>                                  arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
>>>        assert_hvf_ok(ret);
>>>
>>> +    aarch64_add_sme_properties(OBJECT(cpu));
>>
>> Out of scope, those aarch64_add_FEAT_properties() should really take a
>> ARMCPU *cpu argument IMHO.
> 
> You're just looking for new things to fix :D

Correct!

> 
>>
>>>        return 0;
>>>    }
>>>
>>>
>>
> 


