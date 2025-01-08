Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBECE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdWt-0002S7-9K; Wed, 08 Jan 2025 16:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdWq-0002Rr-Kh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:23:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdWn-0005kc-CF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:23:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163b0c09afso3160465ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736371427; x=1736976227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LD3wV6zXImDGJLak8OuA1TD/TcMpBHgvBJNlMpOU68I=;
 b=DYhOZYU2mka5BhN03Gltw+nvoSEvY1Y5lwjkQUCXmg4k8o11tY83erkqozQZ4y65BV
 UqQoYK54aVP5BcSO6XS0tNzjovdMBERQsSHT+8ot1Qi5EkSNCw6Oans+UhuN+dfdCNyD
 W5evjTM5zxbjCu8mUOBnhkRqe4Q0b9caHjznRfTXp8IjoYqB24hOcynzw/73WAPX9Mpq
 Oi3qefVZCMKeZUSUY9FslqoxnmNskKvbBPSWZ2m4h01Cep7Zgw2DoApO2ZUia1V4yvDx
 12uZTVpM6N51UcZUNK/RwrvYOFYZkC+GIHtl/v6ZML24HftIxERyKz9Cwf9jTdnmr5pR
 AobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736371427; x=1736976227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LD3wV6zXImDGJLak8OuA1TD/TcMpBHgvBJNlMpOU68I=;
 b=w3RMMrptJAh3tnuUIp71fwFkqDbUueWPYpvn8Xp4aIdaINGdgPeVRVTidNXzonfZFY
 c7SsT2JSKgSRDOsxYMnwDNjKypaBqabEibZ8OlwTjzmmgqhUnHil4KUiSGUtOLiaGgkm
 yg0aqeS0TLoQS6uOtaM4JdesH3ua2Vf6VxoJIHxkbBAgF+VfrTUs1mhHPHV/ijyj2rma
 mRlQsHPm9fRemDC1jZpZvrEEx1VntT86hjJap2vVp6t7WUvvcvXZCpXTXWR7zCHp2clk
 f0vQ65g74jrXSn4Mx0VDKz3waZUnbWQ+eIQnfTQ/sZXjsh3tVV4Cym+5BgciTPXYZwlh
 /36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeJ0/aJQQl2+OZJxkbltvlKEea6c80BavgOqQ4uOwt0pl7rynUXw+id3+GnVlPCf9zyg8Ggg4eUJIg@nongnu.org
X-Gm-Message-State: AOJu0YzEmkyY7+R9qq2FRvzSm/PYU3wQNtzu4ssmzUP6XLr3OTx4Sycj
 tBTTvhvZH4rOlS3qYfdWT7DlYpgGCI2gp+KyAkTWpVJPocxzIfq+xKhVNIhE9WY=
X-Gm-Gg: ASbGncsP1BMJKshmTiRw2e5kfh3m7HQ7+HDaljzMSqsDJTXwAsROzfBVxkLJq1yORYD
 K01WtlGCW89Hdkf9dEBUzt3IuLDzT+pGMMqX5jxignM2zSOPcYchbr7bN+HyQB23P5XVcrYHMTX
 Y7Zb/86nMJ+eloB5KTaRJlUGIHKSbfxPh3MTY0TR1+Tm9S6nZaqc+G8A0w23bbQHPlq6dHgSkD/
 nj3otKcknRR49tPKdbwAglv/mpe63qtaNdAydO5igYOEen6oOd+WcYoS38IXeJxkye20wpMgW3x
 tzHmk/AjMOpqq8awFb0MM/43D/qlZNo=
X-Google-Smtp-Source: AGHT+IEiwkALAUkLA8V+PS0xGvD8nynX9TOIpWFvt4mkZIWUz+dir4WM3QFFVWY/VSasl/TFz+Lygg==
X-Received: by 2002:a05:6a20:734a:b0:1d9:c64a:9f72 with SMTP id
 adf61e73a8af0-1e88d0a2a44mr7614679637.2.1736371427526; 
 Wed, 08 Jan 2025 13:23:47 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b2b3e80fsm27968327a12.31.2025.01.08.13.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:23:47 -0800 (PST)
Message-ID: <b7e1c48f-fef9-480a-832b-d7aa9cdb17bf@linaro.org>
Date: Wed, 8 Jan 2025 13:23:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/81] tcg: Replace TCGOP_VECL with TCGOP_TYPE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-3-richard.henderson@linaro.org>
 <1271a667-845a-458b-b8e8-b3a9a75fafc3@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1271a667-845a-458b-b8e8-b3a9a75fafc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/8/25 09:39, Philippe Mathieu-Daudé wrote:
> On 7/1/25 08:59, Richard Henderson wrote:
>> In the replacement, drop the TCGType - TCG_TYPE_V64 adjustment,
>> except for the call to tcg_out_vec_op.  Pass type to tcg_gen_op[1-6],
>> so that all integer opcodes gain the type.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg.h      |   2 +-
>>   tcg/tcg-internal.h     |  13 ++---
>>   tcg/optimize.c         |  10 +---
>>   tcg/tcg-op-ldst.c      |  26 ++++++----
>>   tcg/tcg-op-vec.c       |   8 +--
>>   tcg/tcg-op.c           | 113 +++++++++++++++++++++++------------------
>>   tcg/tcg.c              |  11 ++--
>>   docs/devel/tcg-ops.rst |  15 +++---
>>   8 files changed, 105 insertions(+), 93 deletions(-)
> 
> 
>> @@ -3320,7 +3333,7 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
>>           tcg_debug_assert(idx == TB_EXIT_REQUESTED);
>>       }
>> -    tcg_gen_op1i(INDEX_op_exit_tb, val);
>> +    tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
> 
> Having TCG_TYPE_I32 = 0 is confusing.
> 
> Should we define TCG_TYPE_VOID = 0 first, shifting all other types
> (and updating tcg_type_size())?

No.  E.g. tcg/aarch64/tcg-target.c.inc:

/* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
    makes things much cleaner.  */
QEMU_BUILD_BUG_ON(TCG_TYPE_I32 != 0 || TCG_TYPE_I64 != 1);

Obviously this value is never used for INDEX_op_exit_tb (and others).  If you really think 
it's important, we could add VOID as another value.  But I think that might be more 
confusing than anything else.  So far we're restricted to integer and vector types.  If we 
add a third classification, we're going to want to adjust all of the checks everywhere.


r~

