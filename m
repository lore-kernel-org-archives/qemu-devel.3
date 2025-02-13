Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571ACC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiboj-0006CQ-2o; Thu, 13 Feb 2025 11:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiboR-0005na-2w
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:11:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiboO-0007CX-Rc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:11:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220bff984a0so18603885ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739463094; x=1740067894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97F4M5gBh8WaJTSAqlKUeUulEnWrYq+Z0LMs9GpeJT8=;
 b=JQ3+3dFu172dw2iqwQ1hokxjGCaiSO7heBst33aDzMHxFQUskNdLE1boG9DYCZSVRd
 zRHxVg/puifGknjhEHNTjbUzKos96aL175uM3VEtGsZIUNvvLMEyHb0hjJSpnq90u1Hu
 Y5DIwNTJR0kpKDy4IDYWA1VgE1TS2n4r/0Pg5kPiKxGNmpxqQPgkfh0DJ7Dyx6NTZSyK
 GMGRntePCfDOuUuqMUaWOew5a1tjOW1prYGH7NT7IrfxzwIo+NWXqn6dp/XtHP7/5iIP
 nc8iBcYUDUuI/HnIywyfW9tN6ye38y3PIXIIrJepzlp2SjCFFfl4s8DvrfNTkReEsLMS
 N3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739463094; x=1740067894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97F4M5gBh8WaJTSAqlKUeUulEnWrYq+Z0LMs9GpeJT8=;
 b=mSnTDLC3t5FHO3aO/eNI1++LGv9oBY04HTGUi6xCPJokA5t5uI8A/XjX9re+D42lT7
 36xfIeKYpE0kRPQass5XTDeCqtbgVQ0mWjDCYulqJan9bT7rdTq8jg2Bt3c1WvximWvu
 6waQncV7eBLG9bOaznxdKhJxvAZpsni9TXdbbUmyNTQzb1s0uGJnAnyaGmrmK/eki32d
 OrX5GWxpH/aO1CKGBa+VSucYh/+TSeUC4+p3kkq50KLTflE/aiFYhkdrwvxfUF2VEF6n
 8Ch6KM90aJj/LWdtz18tkkZHiej/asSujvL7p9Ri8gi8wBw/TQV1itXKjBk7jYwMUSFH
 ALJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRDUglcV0dqytptZUC2LB8rVrM38uW39VNPB7X8xtQMblM957/+RyvX1LZ3EdlNNLilVObfLM+77Ef@nongnu.org
X-Gm-Message-State: AOJu0Ywt6mHNkcxZMD+F9dp/uXWP1omH3Z/a7Z+6D44fvxkxv5V8qjRh
 QtaeHeDcCQxjwC+q/p4pSdcX/1IYCdMHr3mgXw8gLupBnL4MYHM2EktiVTio9QU=
X-Gm-Gg: ASbGncvQWxilQgbPnHmH23uQIiaUKZSQuOsmNd0mr6NP0sluZYdPk6jTfl1vwhIYZw3
 Eh7aOYpQ/pbLNGbEgG3H5HLBjLiAFwlJLZO0NqmVsPEIZvOpUff6zGy8Fn95ZrcxneLtuB0inUe
 2QSF/Pw1XPMq3bPiNClWMTtWkaKeagJtmZ6vKjTPnuPGzLZY9tglAwe/ha4iNqEpfLjH1aSaDx7
 S3fIc/GzfHW8PRbhwdv5vxw1Vc4aCSEqbIuUM8Z8FZEIg/45xh2jes9kugNoKDeU3OW24D6DOTH
 fXCdJfGvCWeSpW4PTPzkxij9OPRXV7VTJsVP3NVLUVp7e/2aS4TGiEg=
X-Google-Smtp-Source: AGHT+IE4MBEOSqtNF+ko3GkgpFItyWHwntKb+IbjjZy4YjSTeDrmxnaoFT1jBDXCjHmg46PF+GO+mA==
X-Received: by 2002:a17:903:2f89:b0:21f:3abc:b9e8 with SMTP id
 d9443c01a7336-220d215943dmr60677805ad.43.1739463094621; 
 Thu, 13 Feb 2025 08:11:34 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348f7asm14357665ad.23.2025.02.13.08.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 08:11:34 -0800 (PST)
Message-ID: <9dbc295d-9c9a-47d0-8a97-7619b84c5b46@linaro.org>
Date: Thu, 13 Feb 2025 08:11:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/microblaze: Use uint64_t for CPUMBState.ear
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, Anton Johansson <anjo@rev.ng>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-5-richard.henderson@linaro.org>
 <5b0a2b4c-7c70-4d3d-96ce-855feced435f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5b0a2b4c-7c70-4d3d-96ce-855feced435f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/13/25 04:42, Philippe Mathieu-Daudé wrote:
> On 12/2/25 23:01, Richard Henderson wrote:
>> Use an explicit 64-bit type for EAR.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/microblaze/cpu.h       | 2 +-
>>   target/microblaze/translate.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
>> index 45f7f49809..01571d4f86 100644
>> --- a/target/microblaze/cpu.h
>> +++ b/target/microblaze/cpu.h
>> @@ -248,7 +248,7 @@ struct CPUArchState {
>>       uint32_t pc;
>>       uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>>       uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
>> -    target_ulong ear;
>> +    uint64_t ear;
>>       uint32_t esr;
>>       uint32_t fsr;
>>       uint32_t btr;
>> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
>> index d5c5e650e0..549013d25e 100644
>> --- a/target/microblaze/translate.c
>> +++ b/target/microblaze/translate.c
>> @@ -1842,7 +1842,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>>       }
>>       qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
>> -                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
>> +                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
>>                    env->esr, env->fsr, env->btr, env->edr,
>>                    env->ear, env->slr, env->shr);
> 
> So IIUC no need to worry about the upper 32-bits as Anton
> suggested in my RFC:
> https://lore.kernel.org/qemu-devel/ 
> rbczkcp7whvovj55htcvongsc45xyhia5sgckqunszldag3iey@4vsbsjak4wr2/

The upper 32 bits can only be written by the 64-bit "extended address" instructions, which 
are supervisor only.  So certainly the upper 32-bits are not relevant to linux-user.

We are not currently, but *should* be writing to ear from linux-user so that ear gets 
populated in the signal context.  We're missing a record_sigsegv hook.


r~

