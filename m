Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTX8-0005nP-U4; Tue, 18 Aug 2026 19:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwTX6-0005mN-OM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:47:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwTX5-0004At-81
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:47:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cace91f112so4364525ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787096870; x=1787701670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fc56p3k8uuRnc97EoofyEUOBaGfYaZmyJH4nBz5RWwg=;
 b=iwSgs1gxtvASv5VsQOeHUgqJ+ijL3AuzzpBoiFR7fjH3cedk2yTUZ2jmUCxgwebGl9
 lrJ1/trT5BoRKyRzqvke3IbqR/WXza16rT+jMuYgezbr6q4GYIVJy5TEfQjHTcVYigkQ
 xwrmXQDivo2ESOAAogldx6cBY6mPdbn2SNY3iC5TVOsG7fwJiYDRJ7E6r+nAna1pBJMP
 Kxn0GqjWm4u/UNzKlRSQwIJ6OZIUMsqkz0tx33Ges4UcQz3f+3fjMCtRuS/y1j3ZOn9x
 T7JIMNOXHFD+E8gvhLwsiBS4zWbaj++THW3XdGgF77cliROSyP70WvsTVCZ3yVWBXoHL
 Q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787096870; x=1787701670;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fc56p3k8uuRnc97EoofyEUOBaGfYaZmyJH4nBz5RWwg=;
 b=lvVc60NyfcHS2UJqL8nY9uF0PfAHr/LSP2cwgcevfwhUNdsWbFsYz7uldQIjy19njQ
 W1OaGUdi+Q3DnOSqFKivzngIzUBJ9blVHgd5HddlMIdllNAHe8gC6fvRsq93SUD0OJks
 yKMVXh31+n74C3wY3j50FGSjTHc/QApIF36RXGkZNCl5MAD9PPTvndPz9JNFuxBgmmEg
 Ph3t4nPlzdwxHq22mFZfeooEAwBbcd9qfjtK4MXrxM2T01sAx+lFvb3nrmYvMCRQexZT
 P7jX+pYTKPbOnErinjng6FdzoyCx6p46eE4mD4eOep1mQlK+/ZFpKr+4STm28rP8QxTc
 MyqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppN11H3mncw4V9j93LMsTKzNDM7vrbAtMg9o9iFFMeoeMEHhnrhzJUihMENL7TKdZ9LGXkAENVAMma@nongnu.org
X-Gm-Message-State: AOJu0Yz7/byzHfgiFjgNl9NrzM6M7Xcu9QUt6rJEPM70ZosedtMe/5uh
 c7QU7mry4THKTqErZv0Q5JTAONeY3GlXRhlYjwjjzKeFX52n6bXZS2QHaiI+Lcxtt3c=
X-Gm-Gg: AR+sD10A7q+usfUMyksddiIfi8CykSDqylRe79zFj2T6S9OWWmb7q+2p7kpKLL3xWlh
 t1rpGBKGg2qpT1zQF07F/dj20DjuNr35cDnAr0H55W8rvr0fiekc/Ww0fCBEV79jMnz7PjwnaHZ
 s/33lytVtvzbdjhxIoLyxCoDEU9ij1ANpEJxwzfyfretYBnQjlY08MXSCG1nrq0Ye6DEJ291Irq
 pTLMcHv4+iCErFAE2/dky+1IOzBWHosbZGgP1YfFSo85/u5HDXaX4ZSObBBoRAvGSTyBTmJryLj
 mdunj3TmwFj3B+3aMDee3j5Paw/k0J7GtGqVFxYT0XWA7TKeuoFZkQE5+RCQIvGs73gYHhw/D4t
 3jfo2onI2ZqzWiTsIKVE47JvE6A3MXoT42mMYCTnD/G5P0ILaj/LSGLYUlX2nQ8ErWx8S+89kGm
 gAMEJGHk2/FXbx0lnZZ9tClW24v1gSdk4U2cG1x9eYlbLCjczFKSqz+dVEA6hIw0M1VfdO9JHf6
 5ZOZ2fKZP8tbUyrnTI=
X-Received: by 2002:a17:90b:164c:b0:393:19a3:4e5 with SMTP id
 98e67ed59e1d1-395812c6e07mr783639a91.16.1787096869446; 
 Tue, 18 Aug 2026 16:47:49 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb87174sm379525a91.12.2026.08.18.16.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 16:47:48 -0700 (PDT)
Message-ID: <00df9c29-1bbb-41c2-958c-dd5d57c35564@linaro.org>
Date: Tue, 18 Aug 2026 16:47:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/18] target/riscv: Recognize watchpoints with
 first/last
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-17-richard.henderson@linaro.org>
 <c25aa359-4519-483e-aa7e-2ba69daa18c2@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c25aa359-4519-483e-aa7e-2ba69daa18c2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/17/26 22:43, Philippe Mathieu-Daudé wrote:
> On 15/8/26 22:37, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/riscv/tcg/cpu_helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
>> index 11f2654da1..3318e82ea7 100644
>> --- a/target/riscv/tcg/cpu_helper.c
>> +++ b/target/riscv/tcg/cpu_helper.c
>> @@ -1784,8 +1784,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, vaddr first, 
>> vaddr last,
>>            * Otherwise we'll throw a debug exception and execution
>>            * will continue elsewhere.
>>            */
>> -        cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
>> -                             wp_access, retaddr);
>> +        cpu_check_watchpoint(cs, first, last - first + 1,
>> +                             MEMTXATTRS_UNSPECIFIED, wp_access, retaddr);
> 
> Maybe squash in "accel/tcg: Replace size with first/last in TCGCPUOps.tlb_fill"

No, because that one explicitly makes no other code changes.


> or re-order just after?

Ok.

> I'm confused by this single WP change in middle of PMP API ones.
It's just before the last use of size is removed.  :-/


r~

