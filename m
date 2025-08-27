Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710B9CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 09:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urCYZ-0007Q2-Mi; Wed, 27 Aug 2025 05:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urCYT-0007M7-Pf
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:34:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urCYR-0000qb-67
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:34:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so6165785b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756287286; x=1756892086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pNWIUnQbAOzZAjqb7pomPKypKSp77pJ1e8733OCm+c=;
 b=YYtsnwKTTlFMqHN4MR72IjbFJI3IoJxGGdqWSnL/E911PVkGwkeBM1lZChBpAmGxJq
 fjkWmn4CRDmQhIcaMg2agE1gnodd4fRIXir6UDwpI1w4DelFFqSuiTnyYxgVShL6UFig
 QKJ/AEXjVrToCi+Z049LM/tHVScWg2DRWAKqNlxPK9//x2YIa3NtOiRDoG/ctTjc7rx2
 ngEQbUiLKTQxJpZt1jI9fztN2mvS7XG7V/i/zXR0KYTTzHnYKOB8XT4np7DtPYAIU0Z/
 buXFRsYsKbtulkBlxfx0dVKN7L8RqZ85dERo6Rdy7JUuKi1m+K/UkFtCuceJnRysByKf
 v8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756287286; x=1756892086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0pNWIUnQbAOzZAjqb7pomPKypKSp77pJ1e8733OCm+c=;
 b=Tbk1spsvM2Y5xbDreejvsbpRJALzo7U1KEZftJIcTEmoKV9GNY0SO/YG7vcIxm5GUG
 weouFFQaKBHxM1TLQ4aQ4khUOSsuN7jwCj6Zm7lsVq4zNKgoxIBxX8dy9HLmHwtEUIVG
 l3494DRjO6fSK/7tJ3REoRN7fT+gn0L/S6GPTSnQ9eeAIHgUZkUWfH0Iwsmyps1tMlZh
 ishSE7NkbfLLRLycP7eG5XuOHJxEtxrxajulRjEQM61XwOw7UbIsNBYGmLiBAi70fAOR
 cBQylOp7s5X8ayTLf+ZkzwEpXAV5B/iviKppo0snZ+yg00wJ6YU8xluBqchFwH4NYzRk
 JE7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSvUdHlIc2SlnfLumcvMFiPNxzMGtS8Su6Ekybldq1B5b/X69kPSQAqHvqL4Wj+CaX/+avXLua/Kvy@nongnu.org
X-Gm-Message-State: AOJu0YwlLSJF6jbPn7BbK4g5e+yFx2JdM5rgDvgoEGAc8388VxfPA2Jc
 1/9k5Y25hMqqqxn2d9tEWUhncjdQAiN9+fHwKkAzORQQ39fncSQj0O4W612e23iiBIs=
X-Gm-Gg: ASbGnctUwET3lStkv2SWZnKS/7KQHmZsKWtALFi0jUnXdEanIHrvXYWaoBqM+3EBuqw
 SepM4QKlkB0wNiXsVAZCuFlpJwSSMCITQLJuXIvko1ZxeF3eybsS4Qee7L39sg1ani5cBxm63Lw
 a48cMgvSv3rkQH07DV7ruV+d15HWzD4t3g3obMRjLUUw0Cs5lNq3NgshTC0uVgMUtzbm9bcH6OE
 xQx2+xjYsRgqHw9lm8iuRBRrCFnQKSBi4zJOc+XT6slRUwbz5QCZqrIE02P85o+NUzz9qv0/1gI
 MIsAhCMaJ0Bz5JfoyrTCIiXoL0StAXtQLJcNbO3XCldWl+BfotVnptGoZkauDCtfp+24pUrzvel
 ZDO4QMqlHQ3SnkItbMdYYvMfaXXT792jFQJ+Hy/ljlxQHQu0=
X-Google-Smtp-Source: AGHT+IH8WYKQ5MjIyKmVTkKKOMbndYWEGFdzmw+A9BCfOlQMmDU3gdg6ikZYTJRYTvp0wTcITuEU2g==
X-Received: by 2002:a05:6300:210e:b0:240:1e97:7a15 with SMTP id
 adf61e73a8af0-24340cbdfd2mr28831379637.27.1756287285621; 
 Wed, 27 Aug 2025 02:34:45 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8afc11sm11041513a12.17.2025.08.27.02.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 02:34:45 -0700 (PDT)
Message-ID: <7298f273-69ef-4f3e-9c21-87c437c32629@linaro.org>
Date: Wed, 27 Aug 2025 19:34:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tcg/i386: Improve 8-bit shifts with VGF2P8AFFINEQB
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250809234208.12158-1-richard.henderson@linaro.org>
 <31647a8c-60b7-4e27-b89f-6d1709331ec0@linaro.org>
 <3d7f2ebe-111a-4858-a014-4e82872c0e88@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <3d7f2ebe-111a-4858-a014-4e82872c0e88@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 8/27/25 18:12, Paolo Bonzini wrote:
> On 8/27/25 09:26, Richard Henderson wrote:
>> On 8/10/25 09:42, Richard Henderson wrote:
>>> x86 doesn't directly support 8-bit vector shifts, so we have
>>> some 2 to 5 insn expansions.  With VGF2P8AFFINEQB, we can do
>>> it in 1 insn, plus a (possibly shared) constant load.
>>>
>>>
>>> r~
>>>
>>>
>>> Richard Henderson (3):
>>>    cpuinfo/i386: Detect GFNI as an AVX extension
>>>    tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
>>>    tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts
>>>
>>>   host/include/i386/host/cpuinfo.h |  1 +
>>>   include/qemu/cpuid.h             |  3 ++
>>>   util/cpuinfo-i386.c              |  1 +
>>>   tcg/i386/tcg-target-opc.h.inc    |  1 +
>>>   tcg/i386/tcg-target.c.inc        | 81 ++++++++++++++++++++++++++++++--
>>>   5 files changed, 83 insertions(+), 4 deletions(-)
>>>
>>
>> Ping.
> 
> I don't know the target-independent part of TCG, but arithmetic right shift by 7 probably 
> should keep using pcmpgtb?

There is no such target independent expansion.  But it's a good idea to add to x86, at 
least for the two sizes that don't directly support such shift.


r~

