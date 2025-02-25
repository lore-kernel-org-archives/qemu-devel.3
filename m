Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA16C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0UG-00078c-Tr; Tue, 25 Feb 2025 14:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0U3-00076i-SL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:20:51 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0Tz-0006Nn-L9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:20:46 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc3db58932so8902607a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740511242; x=1741116042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lGSiMi83Z50ymoFTZhm1/VAAdztxDQEf5HIit9pBlkM=;
 b=OE1MmcIlFdarn7t/hPQBOTzLQWLxUYYZQhmTGh3lJPRyfVzVChuvOC4I14+yqyVWU1
 CLKc+uIQrYfOmXSc0qwqNuvVPjzsVTbl3ag5q4HipSuYniHiOznLqx5iIsDY90aYKgjX
 2GXIBV+r/W2EZweThtio8mGbqvepkC6AfMYx/HQ38G9Wl5l+VqmA0X7fq8FABWjACK/U
 +9wYZ5rgt+CKusT9FkD9TGS8T9e8U2os5g4dMc1S3QsnMOS11X24AF4UYuvCh87780mN
 AWl8uDJteZJZpGPbiJJNp5xsPpyS8A2iVljsy8QmszZk3S23PEdDmJXSkUw3JWrpwLK2
 0hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511242; x=1741116042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lGSiMi83Z50ymoFTZhm1/VAAdztxDQEf5HIit9pBlkM=;
 b=FWrBkK8+YQwdq3sRHTWAx1a95BgIZ0haK18ELhYubmj6D7K21p+lAMdfJyV8+CQcft
 RYrq7Dr74o3QahNTiBgKHEkuHRQ1B1tEnlD84Kel+BY38wFCPq4ZwPuQqqlzyMDZvLvU
 D0oMwK+EJ7HgIY6dCa1mupcRqn3aq7LAo1Bz04SsmMvcoWV2RX9fqQ+lr+iWA/BW4Egt
 hurzn/jHUhrl8mhNz8iNuOJp2wM5juwNeLVXIGG4xZM9WY6Wk0I4242+QzEPqxn9J+cn
 k55wRxoY9R4UO/5S6JeJJqHBrArp4ntLCOv7lqQXNdvDowdtE5m0v4tRPsvcSJ9TD4UD
 aVCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmmGozsksBVaGvMWhv5H3vYXRo9/UyWZluFdVMa3+ymv+al2IaUyojqIPWI9S4wfBwfSfwNpZoI5No@nongnu.org
X-Gm-Message-State: AOJu0Yz7i9Dx/WdUMD34fjExxp8YbOhpteSbr619dimrsJBKzLL5Cz5M
 R4I7YfIqorNTM38U2353OIopxX5z+KVnQ5EMWJkfFJt/e//Na2A+i0Uy3dkuTig=
X-Gm-Gg: ASbGncvI3bQtmCDi0iC7ypkZIr1tLOw8rMoEMbaB/qU0qYizRW6SWCbMPp2TyupN3PA
 rIrweynLomeFUMXm48J4/26qQGUgHxSdyGhH+W6NUVwSB6pWFf6ZAayXnVX20+u6R1Zec6ucLwR
 JhhB7nRoiQ4RNENN/cwPZNBUwmHNmMKcC3GDrQ/oM9j+6ZH3iCdT2nYO9sKfiwyN+R0wNsLGBUB
 FQ892xiJydYZDRv6CRP1fRYqKojbpgRnMrqSGDICw4nI4Wxv3zwkzYftHPGB/p5kdJnR0uZvLJd
 rQPnKWTejNhJLEXvi5LmI1VLDA8EQ/mB0wZ4g0/lL3OYoZDAn/s9PR4lwSQPZRXkpDVaMae299A
 OSDHv84M=
X-Google-Smtp-Source: AGHT+IFEnrW1Bdxz6DhUiUe4clxMc2xPaynFZc+Z0fA7XAMoDrfgqCfBTKkVrbDvfXuTLVugZXGlZw==
X-Received: by 2002:a05:6a21:b97:b0:1e1:b60c:5bcf with SMTP id
 adf61e73a8af0-1eef3d5a9c9mr38491688637.32.1740511241849; 
 Tue, 25 Feb 2025 11:20:41 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aeda7e84cbdsm1478774a12.24.2025.02.25.11.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:20:41 -0800 (PST)
Message-ID: <61cbdd92-e5c1-443b-87f7-dba148b95b15@linaro.org>
Date: Tue, 25 Feb 2025 11:20:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 004/162] tcg: Convert add to TCGOutOpBinary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-5-richard.henderson@linaro.org>
 <21f85e1d-938e-40e8-b33d-95f8cb4a13a7@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <21f85e1d-938e-40e8-b33d-95f8cb4a13a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/25/25 10:17, Philippe Mathieu-Daudé wrote:
>> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
>> index a0f050ff9c..08106b6e4c 100644
>> --- a/tcg/loongarch64/tcg-target.c.inc
>> +++ b/tcg/loongarch64/tcg-target.c.inc
> 
> 
>> +static const TCGOutOpBinary outop_add = {
>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> 
> So now 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
> signed32 cast, OK.

Yes, TCG_CT_CONST_S32 will match all constants for TCG_TYPE_I32, so there is no change in 
functionality.

>> +static const TCGOutOpBinary outop_add = {
>> +    .base.static_constraint = C_O1_I2(r, r, rT),
> 
> Similarly, 32-bit uses 'T' constraint (TCG_CT_CONST_S32) and we get the
> signed32 cast, OK.

Yes.

>> @@ -2989,8 +3000,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>>                   tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
>>               }
>>           } else if (const_args[2]) {
>> -            a2 = -a2;
>> -            goto do_addi_32;
>> +            tgen_addi(s, type, a0, a1, (int32_t)-a2);
> 
> So do we really need the (int32_t) cast here?

Interesting question.

(0) Truncate -INT32_MIN to remain a 32-bit quantity.

(1) We are *supposed* to have eliminated this case already, converting
     all subtract of constant to add of negative constant.  That said,
     patch 9 fixes one more case of this.  (There were rebase conflicts
     moving patch 9 earlier, so I took the lazy way and left it where it is.)

(2) The cast goes away when we convert INDEX_op_sub_* and forcefully
     disallow subtract of constant.

Because of (1), we *probably* don't need the cast now, but until (2) it's difficult to 
prove.  On balance I think it's better to have it until we are sure we don't need it.

>> +static const TCGOutOpBinary outop_add = {
>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> 
> Don't we need
> 
>         .base.static_constraint = C_O1_I2(r, rz, rJ),
> 
> since commit 1bbcae5adaa ("tcg/sparc64: Use 'z' constraint")?

Constants should never appear in the first source operand.
The optimize pass will always swap commutative operands.

This patch asserts that this has been done:

> +    case INDEX_op_add_i32:
> +    case INDEX_op_add_i64:
> +        {
> +            const TCGOutOpBinary *out =
> +                container_of(all_outop[op->opc], TCGOutOpBinary, base);
> +
> +            tcg_debug_assert(!const_args[1]);

Therefore, simplify the constraints so that they're not attempting to handle nonsense.


r~

