Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C8C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0Yo-0000s6-Ce; Tue, 25 Feb 2025 14:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0Yc-0000qg-68
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:25:31 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0Ya-0007Cp-D0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:25:29 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fc1f410186so232614a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740511527; x=1741116327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7SvWQjNtOSKdMn++9M4koJ7JnXuCxg71vVb+kNrE0K0=;
 b=yppHOYaU4Q6tY/o6iy2xukBDD+P3w78DnLMvO4L8OKmqQScchh6QSFH19gt8oi3eiC
 mRSX0IKfjT4y8arTUWhiXfG/c8175/GyWgA1B7M98Db5BUtWCn4sfoaWqWjAxMu5es2T
 nln2/lr58d13kh6Lb1LrADcjo1xZQb7s9T35Y0RrdwZvLSIoERdnfQV0YGw7K4wkmbJZ
 MRq+3g0Sybs/o0iA5xnPGRE9CUnvmqZTdfpcAPt9gMDv7jeKD2ERqGx9v9STs8GNCsBM
 bcOGNI3HnMv3H93kgXNqADLE9PGaVV008V9PWhqF3MTrUe31yLJvKlyJNNQaQwHH9D/2
 +I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511527; x=1741116327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SvWQjNtOSKdMn++9M4koJ7JnXuCxg71vVb+kNrE0K0=;
 b=t/JN7P+Kuv41UPkt/WpFKBohlHBOaQ8pRJaSUzyAb5hfCbR1U//9VEZGZtk+An53Nh
 UIMSaaYc+xaFPSxSbO8juSuNC/Datf6NsSCMowcPr/y8ATPVrXvesBkilzxRjnZvyH6U
 WM6uMuilVAZSiDRDs4nyiGpOOXb7Lb+W4M2g43jv0gMupvXLczSNk7lTeUvXS0O4l+dO
 MLXQL4eygKDOZ58ikRrQQ0+rdl1uN4TqLseDymPWs7l8X16RA5NrLedf2b9e0i3fwvIH
 sHfCiPRXNuygzCCaZ3AaPU0yvlCS1NEq3UbnmRs7VLAd67SnAQt6vAv9zZ44+pYWaK94
 f30g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW19TBR3KbKPTrf98I/d/joF82zXWBX3rMbaqShwGzEOiMTM9ez01swWyp4xGC+3Lu8znwBYawERP2@nongnu.org
X-Gm-Message-State: AOJu0YwComquf8XmtIbjilsLo7lYT+DFoYIjwh3jmAag7rKavRCtECb1
 YJiyFr94pLaoTFvjqz0vNhWRfdLeZgyqt+St/Uj8hQYetxWXoUvH9NZ+BbBWvBxj0M1ZvUpfiFz
 k
X-Gm-Gg: ASbGncuFzaUj6MSDUV40qvZrnnQNBpa+qkHr/zjVuSgAFUGbbbltArwYulJT0MRvjvk
 B5gJgmn015wyX7Orca/InHs4ke5sh9hvN3UjE6L+kPnRh4/jYwvmgdSzR6+BPZCcinIWbJYLNei
 sHDaEI0IvAeRXSm7OcMSmhc6HiskpgRJ00CkpibYHJDHuitZNwfTaku6fNVXpBxCm7BhuqeQ61H
 29qL8ORjmkiWmjqlVMFUOepKjQekxT0eVB5EDtz6Qr6obpcQTaMc2zqeS7B92/sRsfIwPfH6dFn
 1CF6AYcx6dDomTbQwRjrZASK7HMASnY1gGQPskiv2c/fBm07S/bsNlbl1KQ3JF1eKVzbXLYIfg0
 bX/7CsuY=
X-Google-Smtp-Source: AGHT+IFV4jOAcJsqy69dAhrBzJ+512A1hxAR2SHWcB8oN9G5DPIORd6GnB9rRPBkrLMpQHeekvF7rw==
X-Received: by 2002:a17:90b:3d0e:b0:2ee:ee77:226d with SMTP id
 98e67ed59e1d1-2fce7ad5240mr28967710a91.4.1740511526733; 
 Tue, 25 Feb 2025 11:25:26 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb0499d8sm8863158a91.11.2025.02.25.11.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:25:26 -0800 (PST)
Message-ID: <ea4ed0b0-b6f0-4167-ad56-c3b8e675c22e@linaro.org>
Date: Tue, 25 Feb 2025 11:25:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 006/162] tcg: Convert and to TCGOutOpBinary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-7-richard.henderson@linaro.org>
 <e344bd3a-fd3a-4314-9fe7-97ac0b252a89@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e344bd3a-fd3a-4314-9fe7-97ac0b252a89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/25/25 10:40, Philippe Mathieu-Daudé wrote:
>> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
>> index 1115d1e38d..01010dfdc0 100644
>> --- a/tcg/i386/tcg-target.c.inc
>> +++ b/tcg/i386/tcg-target.c.inc
> 
> 
>> +static void tgen_andi(TCGContext *s, TCGType type,
>> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
>> +{
>> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
>> +    tgen_arithi(s, ARITH_AND + rexw, a0, a2, 0);
> 
> We could s/0/false/ in preparation of tgen_arithi() taking a boolean
> for the CF bit.

Ok.


>> +++ b/tcg/s390x/tcg-target.c.inc
>> @@ -2196,6 +2196,31 @@ static const TCGOutOpBinary outop_add = {
>>       .out_rri = tgen_addi,
>>   };
>> +static void tgen_and(TCGContext *s, TCGType type,
>> +                     TCGReg a0, TCGReg a1, TCGReg a2)
>> +{
>> +    if (type != TCG_TYPE_I32) {
>> +        tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
>> +    } else if (a0 == a1) {
>> +        tcg_out_insn(s, RR, NR, a0, a2);
>> +    } else {
>> +        tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
>> +    }
>> +}
>> +
>> +static void tgen_andi_3(TCGContext *s, TCGType type,
>> +                        TCGReg a0, TCGReg a1, tcg_target_long a2)
>> +{
>> +    tcg_out_mov(s, type, a0, a1);
>> +    tgen_andi(s, type, a0, a2);
>> +}
>> +
>> +static const TCGOutOpBinary outop_and = {
>> +    .base.static_constraint = C_O1_I2(r, r, rNKR),
> 
> So INDEX_op_and_i32 gets more constraints (ri -> rNKR):
> 
> CONST('K', TCG_CT_CONST_P32)
> CONST('N', TCG_CT_CONST_INV)
> CONST('R', TCG_CT_CONST_INVRISBG)
> 
> IIUC this doesn't affect anything, as these constraints are only
> useful for 64-bit ops, right?

Yes, as with the similar question vs addition, TCG_CT_CONST_P32 will match all TCG_TYPE_I32.

>> +++ b/tcg/sparc64/tcg-target.c.inc
> 
> 
>> +static const TCGOutOpBinary outop_and = {
>> +    .base.static_constraint = C_O1_I2(r, r, rJ),
> 
> Again, missing 'z', so C_O1_I2(r, rz, rJ)?

Again, eliminating impossible constraints.
AND shares the same assert for non-constant as ADD.


r~

