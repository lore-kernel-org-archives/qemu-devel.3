Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5583C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Vm-00086R-3u; Tue, 25 Feb 2025 15:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tn1Vk-00086D-HU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:26:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tn1Vi-0000LM-Px
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:26:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f1e8efef5so3599660f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740515193; x=1741119993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mFi83MMa7EkgkmiK0Pck0s/B+XSuyl1xeFHmXSYw6wg=;
 b=v1ULxuMf3kqSBkPRo+MZJmFc2DEvVyozBD11y2kkUqZGvSujxBz4ClAf6qxKpaly4/
 faQMElkUmq/PyGGs5jI8j47Zf5WKVf1vd1HgxG1BbduTVGmzYaZWhcHU8d8xhIfaYAoT
 kzS/2qm5bDIcnBPDNEDX8slkHifWEi0L0y9pCyC9x5ayBqFZiJgdmzHnEi8mjEbjpnk8
 Rk8qUqETlr9+93G67TnFy8IiNVEfrkfS4UmpOg6ENsKRNwts72ImgEhOUXOiDylRK3h1
 C80tarwhZufV7kwdw4Vt8PGhHc7WlfwagYSfXl45eQ4+FRDge6wikUWLfWbQ0RasRL7m
 3Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740515193; x=1741119993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFi83MMa7EkgkmiK0Pck0s/B+XSuyl1xeFHmXSYw6wg=;
 b=EScN2RdHqr0Janmxz2L91QpNdWkYDOFXyjlCDENON0Hn8T73v+CelZxABNu62Bhv9t
 O/pdPJMc8zW7GwRpz73zx+HzPWS9FFEbO6cC8F4NXYtiLQePEvmRTV0nAGqtUZP1W/xx
 L65qjw2fPm/j7yQPO50WV6jOjpP+1TMPNSODJvwnJPWGszjls13xCay9TOZz59AHEeXu
 MYWZDWmagvs5moaa0ZoQblQUfRd8G+rs2f/XctIQYAzNT427eQclimUIoR00gzTGEZ5i
 voEDybOdtpwFIN6ApLTMWKVYxg0b1JZX5pQqJiLeW+8wciuxvEtqgRvrGdzQaBf2CGOQ
 s7EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXLicsxxvqcC4sgXletZI6Cvjj+ov4rPdFsbSGsl3csz/NJcGqC+V1m8kuL6UDXRZOoNDnop/60CI3@nongnu.org
X-Gm-Message-State: AOJu0Yy37YRl1ZxmoERutYPuq1n+g4J23k/L4jFEeLmpZ5yp2/tH3LTs
 7XS9KPQ9oYSqHf3sedQzaqn53XKg3FQzLpEy1Io7aqJW7XwX8+c62Qa3WYMeQBo=
X-Gm-Gg: ASbGnct0MUgzUgzc5ybaRJuesjzaqy0PwZdfyjD96F10Kuor7TBVIZtdZgdTrOuaHgY
 susXtOg9eXbOO53VVHwlzTBzDKX/2hv2Viw3ykx4O/nuoZCuUhmlhxGD+stY+qwWfu+p/ISIPhY
 nxg6X4XAx84gafDX5rpf5hUyOCZuol6C7I/GjZa0TfH+Gl4Kc4DIbY2QVqDfJ+lK8ELzgf0fJ5H
 BFdHdKoC5kipOA93VjS0nItd6RwY0bPBsRSsxTOjSDRmQgkYot9g1pJWdMcemJCys/kmvRucqI9
 p1Bt08Q6p50VG8XA/WUl1RxefnuCxIYFq7oUNw1KkRi/+ZkzUGQyyM7KF2/ODZwXihndlA==
X-Google-Smtp-Source: AGHT+IGlnOT8Rov/rtMZ1zLJfM5NspcD2qCJVKx62oiTH5+GHkjZ2c3ZZDVZ64o/ywT8l0M6HKO5Dg==
X-Received: by 2002:a05:6000:1cc6:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-390cc638914mr3198461f8f.46.1740515193270; 
 Tue, 25 Feb 2025 12:26:33 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e7268sm3352369f8f.70.2025.02.25.12.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:26:32 -0800 (PST)
Message-ID: <1571620f-e5e9-45a5-977a-f7bab8a24c2d@linaro.org>
Date: Tue, 25 Feb 2025 21:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 006/162] tcg: Convert and to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-7-richard.henderson@linaro.org>
 <e344bd3a-fd3a-4314-9fe7-97ac0b252a89@linaro.org>
 <ea4ed0b0-b6f0-4167-ad56-c3b8e675c22e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ea4ed0b0-b6f0-4167-ad56-c3b8e675c22e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 25/2/25 20:25, Richard Henderson wrote:
> On 2/25/25 10:40, Philippe Mathieu-Daudé wrote:
>>> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
>>> index 1115d1e38d..01010dfdc0 100644
>>> --- a/tcg/i386/tcg-target.c.inc
>>> +++ b/tcg/i386/tcg-target.c.inc
>>
>>
>>> +static void tgen_andi(TCGContext *s, TCGType type,
>>> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
>>> +{
>>> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
>>> +    tgen_arithi(s, ARITH_AND + rexw, a0, a2, 0);
>>
>> We could s/0/false/ in preparation of tgen_arithi() taking a boolean
>> for the CF bit.
> 
> Ok.
> 
> 
>>> +++ b/tcg/s390x/tcg-target.c.inc
>>> @@ -2196,6 +2196,31 @@ static const TCGOutOpBinary outop_add = {
>>>       .out_rri = tgen_addi,
>>>   };
>>> +static void tgen_and(TCGContext *s, TCGType type,
>>> +                     TCGReg a0, TCGReg a1, TCGReg a2)
>>> +{
>>> +    if (type != TCG_TYPE_I32) {
>>> +        tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
>>> +    } else if (a0 == a1) {
>>> +        tcg_out_insn(s, RR, NR, a0, a2);
>>> +    } else {
>>> +        tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
>>> +    }
>>> +}
>>> +
>>> +static void tgen_andi_3(TCGContext *s, TCGType type,
>>> +                        TCGReg a0, TCGReg a1, tcg_target_long a2)
>>> +{
>>> +    tcg_out_mov(s, type, a0, a1);
>>> +    tgen_andi(s, type, a0, a2);
>>> +}
>>> +
>>> +static const TCGOutOpBinary outop_and = {
>>> +    .base.static_constraint = C_O1_I2(r, r, rNKR),
>>
>> So INDEX_op_and_i32 gets more constraints (ri -> rNKR):
>>
>> CONST('K', TCG_CT_CONST_P32)
>> CONST('N', TCG_CT_CONST_INV)
>> CONST('R', TCG_CT_CONST_INVRISBG)
>>
>> IIUC this doesn't affect anything, as these constraints are only
>> useful for 64-bit ops, right?
> 
> Yes, as with the similar question vs addition, TCG_CT_CONST_P32 will 
> match all TCG_TYPE_I32.
> 
>>> +++ b/tcg/sparc64/tcg-target.c.inc
>>
>>
>>> +static const TCGOutOpBinary outop_and = {
>>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
>>
>> Again, missing 'z', so C_O1_I2(r, rz, rJ)?
> 
> Again, eliminating impossible constraints.
> AND shares the same assert for non-constant as ADD.

Yes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


