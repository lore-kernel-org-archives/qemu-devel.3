Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF7C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9ZR-0002Ae-TT; Wed, 15 Jan 2025 15:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9ZM-00029c-Lj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:00:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9ZK-0004lF-VY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:00:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so814822f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971249; x=1737576049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xU+mbWhqAd8xBJFUx2srI1R8h0JLUTzfe0uehb9oI4=;
 b=cVKWEHR1gzuOPmIgwjULfxHxP4Cyz5mbeaAvFTduh5puhoIEDcmilxg+nWqA3l9Skz
 a6hryCigZNmewm4eMdR/a7PglTrn9GSZGG/aV/zjq79F3A4N9dv6H5EvCbAiKKxOL+fj
 N37Gs4qfwGfVs98N1HhmyMDFv+773g/+8Xi8r1YroN4/FpZeHmNgufbG51XLF+9KeqUr
 BtOHbqCKnw9q4coiLG2rrmNnbfRzVeJaqxf1cQ6h2LVmV8PHlocoYmNom7o4udZ4jqhx
 E1vVP5Avc/bpuLYHYMiF4bsQypyeW+RZgSNHSjjBanEwrUxVk01SHtO8LWKzaJF6DSVu
 68hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971249; x=1737576049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xU+mbWhqAd8xBJFUx2srI1R8h0JLUTzfe0uehb9oI4=;
 b=vovFc8UGDrXOnyIb6G4AzV7vfULCp8X9pOG7M3mYtyANIuQNHx9Dl/d1KnJVZKLYhN
 LmEvpuPzw5KBMCYko2NBoLgok3ksO4FMwZfZ6TSJGj0BdqEm+c7jB8kjf15NJ/u7Kbws
 0xhTEkGqdFa3AqH0x7nr2Qr2GAu0EwImAowzUBncUz98Ml6FCmGHSMahnns57Phjdymm
 iZpIrxYBF8AcUTTTeTg4B9n3wp/7Gk/mQM7PK62v1HLNYdZj1PeCweadMioADFP+vr8d
 1aYDSVTmEfO2E4QqI1G2+UUfR0Jl1JQl0Kc3ZJZPlzkgv/j43TV9+IK/0c7z+jR6cETU
 mxAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU49g3evHuRURWI+QPVF49t/3VMEWZAgGM8N76vvWA2WYu7/0UOddpvHzyhi40jaIrp8Q4ccQ46yNK4@nongnu.org
X-Gm-Message-State: AOJu0YyQUlVMYxP1yXN1JkAvWkbi2CylnZJvdBXv8VcMVmiKW2BzFo7W
 zXEyr/yUluDWClhoHzhRSbKHb66YNfRdf6w4SYNaElY/ysQd6SSj+qZrjLqath6zT1mgV0aiw4z
 dm/w=
X-Gm-Gg: ASbGnctZchI4TlB3soH11tTlGmq6Siumrz02/FEupND/HoQvquZM7rw8iArQhqvQCbk
 smpWLaZKgwkFB/8udZrQkT8dfmVT8arw40PvR5sCWyrDJRT/cINQDVu6iMehQ3O0ob0MhPnsjXg
 gwuVzX/Hog/Nm1PEZhh7f+X76nhKZQy97m1RcqM+eaaWE8iohBgoHEwHuivJVnfVFeIzaOe+j09
 8e+uZYdL8bj4wuIMKtVVZrGeZirBg79wszqjCeXMhZEPBSDulbhuHd81qE3qLJ+TFoKrmtbkirL
 V28Bfrw4B+qwYeqgT9qnkKa+
X-Google-Smtp-Source: AGHT+IFEPYqGFW3abNEYv08zjJDFgwa8CiWxY0U/hub1lql9Eezpcm9CJSIlaeMqwUFP7j4Dhkdf4w==
X-Received: by 2002:a5d:6d0e:0:b0:38a:a117:3dbe with SMTP id
 ffacd0b85a97d-38aa1174168mr12938747f8f.21.1736971249149; 
 Wed, 15 Jan 2025 12:00:49 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81a4sm18875339f8f.68.2025.01.15.12.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:00:48 -0800 (PST)
Message-ID: <ea8fe7b5-7fcf-4b3c-86ef-7c60636ad517@linaro.org>
Date: Wed, 15 Jan 2025 21:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/81] tcg: Replace TCGOP_VECL with TCGOP_TYPE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-3-richard.henderson@linaro.org>
 <1271a667-845a-458b-b8e8-b3a9a75fafc3@linaro.org>
 <b7e1c48f-fef9-480a-832b-d7aa9cdb17bf@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b7e1c48f-fef9-480a-832b-d7aa9cdb17bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 8/1/25 22:23, Richard Henderson wrote:
> On 1/8/25 09:39, Philippe Mathieu-Daudé wrote:
>> On 7/1/25 08:59, Richard Henderson wrote:
>>> In the replacement, drop the TCGType - TCG_TYPE_V64 adjustment,
>>> except for the call to tcg_out_vec_op.  Pass type to tcg_gen_op[1-6],
>>> so that all integer opcodes gain the type.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/tcg/tcg.h      |   2 +-
>>>   tcg/tcg-internal.h     |  13 ++---
>>>   tcg/optimize.c         |  10 +---
>>>   tcg/tcg-op-ldst.c      |  26 ++++++----
>>>   tcg/tcg-op-vec.c       |   8 +--
>>>   tcg/tcg-op.c           | 113 +++++++++++++++++++++++------------------
>>>   tcg/tcg.c              |  11 ++--
>>>   docs/devel/tcg-ops.rst |  15 +++---
>>>   8 files changed, 105 insertions(+), 93 deletions(-)
>>
>>
>>> @@ -3320,7 +3333,7 @@ void tcg_gen_exit_tb(const TranslationBlock 
>>> *tb, unsigned idx)
>>>           tcg_debug_assert(idx == TB_EXIT_REQUESTED);
>>>       }
>>> -    tcg_gen_op1i(INDEX_op_exit_tb, val);
>>> +    tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
>>
>> Having TCG_TYPE_I32 = 0 is confusing.
>>
>> Should we define TCG_TYPE_VOID = 0 first, shifting all other types
>> (and updating tcg_type_size())?
> 
> No.  E.g. tcg/aarch64/tcg-target.c.inc:
> 
> /* We're going to re-use TCGType in setting of the SF bit, which controls
>     the size of the operation performed.  If we know the values match, it
>     makes things much cleaner.  */
> QEMU_BUILD_BUG_ON(TCG_TYPE_I32 != 0 || TCG_TYPE_I64 != 1);
> 
> Obviously this value is never used for INDEX_op_exit_tb (and others).  
> If you really think it's important, we could add VOID as another value.  
> But I think that might be more confusing than anything else.  So far 
> we're restricted to integer and vector types.  If we add a third 
> classification, we're going to want to adjust all of the checks everywhere.

No need for VOID, I'm good ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


