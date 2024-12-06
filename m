Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C37E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZQ6-0000Tf-9N; Fri, 06 Dec 2024 09:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJZQ3-0000T8-PY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:34:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJZQ1-0003wS-O3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:34:59 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862a921123so651393f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733495696; x=1734100496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7p/pCWiWYAa7p+4sfQ7+6ToNkUn2W0vom0JjKjiKcSM=;
 b=erdfSeAXJ7K+oyulgZawFmu5Cce1hrKcI85vRbV2r2ZkadtvOeODgeaeuqdIdirv6S
 M0/RQovvtCoAJ4Ebpkkg8XmFnSokOfe8o5E9TQCPNi3/EUL7YuIcGuMWnJP20oMJLYHW
 qMbnvLcc2uWYMdq8ktH5CEEX+22TXsy1ikGLvDvfUrGYLJQ3bRe/srzWrf01EU/vuAVC
 hzFRcsZc/i/1HreiKFRX/iJEsiFzggIBQAml1FhmY4DJXWeYe2yYJGUnvSQygiCSFOxu
 E5NE0WTaszv4/i+jRJEtxCzO4uImR8aZMJMhIM2G8iFqwrMDUUHkDPwBpLMM8YZaUXwW
 WZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495696; x=1734100496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7p/pCWiWYAa7p+4sfQ7+6ToNkUn2W0vom0JjKjiKcSM=;
 b=t2DUo/EgMvvkEB2RNWMj8LHGz1pkCvzEwzALvESxFLH5pRrtUb9E1BAqD6ThENmGIy
 gY600p1szy2YFmLN/edrFALL89gznv1OgEFj7uMb69wWOMp2oT1ecqFUz87n6XiFS7GH
 AFLjBeOaSdBNWihoib5kks3QWxHJP85GtxTGD016+33/4kjf8iB3l5AWkn2eWRKVJeCI
 76faAOhFC+N9FAtzdiF01hpOTa0ZGfBgXLvuGbFGshWGH6FhvGIlJ2kqagvCHM+8UdUb
 8L/0XFNblUQR3bN4WGJMGNr3Ab/FmnAM0L3r8u6xUYGsH27SfwNUEtMn/4S7J2SNnPIn
 jVWw==
X-Gm-Message-State: AOJu0Yx1TozUvFnnu5yg1qe529u8EYZWMC0v+eq8ZgR2DM6JDTc7Eu7m
 +R/xaakktRORK2VvhUYRYCbpIXDTy/oTPhZ33wmpdgoPE637RVLaye9BjhxfkXQ=
X-Gm-Gg: ASbGnctjlvqfDPn1fTg3o/3XuLrDf7YVf29kQeFv4D1ER5zLt6NA7qSNY767g1x03sN
 zMs3bAYXEhOjo271F8cOGLIIv5NWSi68fHyTnAYItDL6F1SUhQVJwXhfBK/Tl92N0lrisfE+0PE
 +5zWfp61dEaj3yQ0inUzykUckwHlBa92X7D7UgWPmVubc5g11xmgDYhYwjjgej6dKpM0aL6Nyz2
 6FnVaYJ63XCL8MhX+2xoRfSmXZ+ayl8u1kwPGkfzuJ0UlAxnxpMeIsKhaZGvQ==
X-Google-Smtp-Source: AGHT+IFOFwRnLv3/BgTOzJpIgnLNcKxNAKNMuRt786v3csh5R8PT935ONby+LVNaL2TGoHyEClQe9A==
X-Received: by 2002:a5d:47ab:0:b0:386:256c:8e5c with SMTP id
 ffacd0b85a97d-3862b36c8a6mr2351176f8f.20.1733495695556; 
 Fri, 06 Dec 2024 06:34:55 -0800 (PST)
Received: from [192.168.224.213] ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862e52a96csm1244596f8f.33.2024.12.06.06.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:34:54 -0800 (PST)
Message-ID: <30502a2f-3d33-4583-8e78-4da50ce1e247@linaro.org>
Date: Fri, 6 Dec 2024 15:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241205232437.85235-1-philmd@linaro.org>
 <20241205232437.85235-3-philmd@linaro.org>
 <CAMo8BfKMhNd0C2HwL2aGAjPUZS8B7u8ncyW5PicswPns28SAmA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMo8BfKMhNd0C2HwL2aGAjPUZS8B7u8ncyW5PicswPns28SAmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 6/12/24 13:41, Max Filippov wrote:
> On Thu, Dec 5, 2024 at 3:24 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> In preparation of heterogeneous emulation where cores with
>> different endianness can run concurrently, we need to remove
>> the tswap() calls -- which use a fixed per-binary endianness.
>>
>> Get the endianness of the CPU accessed using the libisa
>> xtensa_isa_is_big_endian() call and replace the tswap() calls
>> by bswap() ones when necessary.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/xtensa/xtensa-semi.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
>> index fa21b7e11fc..21d23e39de5 100644
>> --- a/target/xtensa/xtensa-semi.c
>> +++ b/target/xtensa/xtensa-semi.c
>> @@ -328,10 +328,17 @@ void HELPER(simcall)(CPUXtensaState *env)
>>               struct timeval tv = {0};
>>
>>               if (target_tv) {
>> +                bool cpu_big_endian = xtensa_isa_is_big_endian(env->config->isa);
>> +                bool swap_needed = HOST_BIG_ENDIAN != cpu_big_endian;
>> +
>>                   cpu_memory_rw_debug(cs, target_tv,
>>                           (uint8_t *)target_tvv, sizeof(target_tvv), 0);
>> -                tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
>> -                tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
>> +                if (swap_needed) {
>> +                    bswap32s(&target_tvv[0]);
>> +                    bswap32s(&target_tvv[1]);
>> +                }
>> +                tv.tv_sec = (int32_t)target_tvv[0];
>> +                tv.tv_usec = (int32_t)target_tvv[1];
> 
> This conversion looks a bit heavy. Maybe it would be better to
> give tswap*() an additional env argument and give the target
> a way to deal with it?

Yeah, something like that. TBH I'm not really happy with these
changes, and am having hard time figuring out a simple and
meaningful API.

> 
>>               }
>>               if (fd < 3 && sim_console) {
>>                   if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
>> @@ -381,6 +388,8 @@ void HELPER(simcall)(CPUXtensaState *env)
>>               int argc = semihosting_get_argc();
>>               int str_offset = (argc + 1) * sizeof(uint32_t);
>>               int i;
>> +            bool cpu_big_endian = xtensa_isa_is_big_endian(env->config->isa);
>> +            bool swap_needed = HOST_BIG_ENDIAN != cpu_big_endian;
>>               uint32_t argptr;
>>
>>               for (i = 0; i < argc; ++i) {
>> @@ -388,6 +397,9 @@ void HELPER(simcall)(CPUXtensaState *env)
>>                   int str_size = strlen(str) + 1;
>>
>>                   argptr = tswap32(regs[3] + str_offset);
> 
> The tswap() is still here.

Oops!

> 
>> +                if (swap_needed) {
>> +                    bswap32s(&argptr);
>> +                }
>>
>>                   cpu_memory_rw_debug(cs,
>>                                       regs[3] + i * sizeof(uint32_t),
> 


