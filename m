Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FC0E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGM9-0001Bn-0G; Fri, 10 Jan 2025 09:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGM4-00018I-5h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:51:22 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGM1-0000om-2p
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:51:19 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso2860155a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 06:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736520673; x=1737125473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjgY0HgB1/m+MlTavdon8zZqE7x250kOtu7Nc4lvl6k=;
 b=WTFog+U6cCTda9Nwd8cfxgIXHXdGzrnz1RQrcvG/AMMODCLWTi2Mb1QQu4xLPiEZeA
 BwqzzJckK8fn8wYk5ru09/nkZebK59fnraDA3mKVfFVhGT4aDAzv6rReqBQe1Hq3sl0y
 1FT6ibiiCpdmfJFhFFHmq5LXO4tArMG4g22gMbHVEDhlhIegli2faSb4HXKBbfap7+W6
 1w11pFjCkhBx+idVaroweSLKWJ6lbcICDNgeB9kQbvXIi+zNHG8VmvPacEDVufzQdkPj
 jAGYR6snNTvL1rXsYnln7OMsAehVhTVHH56vqcyCsg4FPvDuxEZEjiuyVwhe/YXdLbKh
 vCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736520673; x=1737125473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjgY0HgB1/m+MlTavdon8zZqE7x250kOtu7Nc4lvl6k=;
 b=RyKE7bL/bcKugi2FS/qkN6o63LfnDrtoXQDtHtAVU8ylnJFedcdFWqYKCQZNxLOzl8
 Ty2sImhZTYXLkpHDVhc83ZjOIQ1AdZLXZZLl024J53LrBSsOPev0FV0c8Y/dcz+JS74f
 toxtn+Fz/V8rq9dsEJSdXBhV+3hCRHKR4vV25EdlwwHIRpq9ZRHuzNxVP8HBOqeCcnPs
 dxZYhgv30vkCqtAVMtbEQ+BjOvJHxqkgS6xsTKbSarCke9l46ix7v3d5yTp8chSWSxQ9
 4DqVB01AFwQsLErQOiR7NFCaFm2QSYZh1XaNJslQJujZyAyCrrJQqa/JXWXatzsR4ar1
 CIfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYWzNGkWuPBOE3Kjek+wmLwyG95G2FY+hhFA9oWXxuVty2nINxoeV7tyEk4FDBLIPXNpJ1vtBTGfGB@nongnu.org
X-Gm-Message-State: AOJu0Yx4yhqe6DsUPk3ws+kSrsEcbgEwA3uuczW0XUCZzznVHshEfaLQ
 peLtU4apRlHcd55R1EwFVV8U2tYjzLbF1ZHHGhIJsUcIqrzGFpe04VbJSNVlwIA=
X-Gm-Gg: ASbGncsUbSK/j1/ZT2Q/KLuGF+pHKuF8CPNRVnC34tpMacHI7BYmLvBLpFYeNxfJVic
 xb6CByzRiNEBQTYs247mU95j+IKiq91Q0TnasN+iDtcy/tQ3/Hou0BimJhjrb/VKaY3roviJJoU
 HHBfuzkU8J3TdMeSS2EISFvYgEf9eDJqQwkY91wMtUkUeQ/Ej1w9oihTdk+AtuQz50IXyoLw+1+
 fIP/qRj5X6el3788eunhHb0rQqrzHFKvdoP0iicnUtYdxieUDxTmPl0DwEGKGYhe7mjgEmDvi/y
 Hehopts4XFzmO3qxo56TPuKFcIx+AtQ=
X-Google-Smtp-Source: AGHT+IGW7lQUnS1tTMu0r/fU4CerrXiXk2gwbWMPgzZLUak0EqnQ3ICZ7Vsw0LePKSxTPkqeV7Ik/w==
X-Received: by 2002:a17:90a:d003:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2f548eae095mr16629055a91.11.1736520673291; 
 Fri, 10 Jan 2025 06:51:13 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f5593fecc6sm3411667a91.19.2025.01.10.06.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 06:51:12 -0800 (PST)
Message-ID: <2af438ca-644f-4d8f-9a5d-1cedbc698a28@linaro.org>
Date: Fri, 10 Jan 2025 06:51:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 50/81] tcg: Add all_outop[]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-51-richard.henderson@linaro.org>
 <fd696582-0b9f-48b0-8721-2afc0a28c6ea@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fd696582-0b9f-48b0-8721-2afc0a28c6ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 1/9/25 15:21, Philippe Mathieu-Daudé wrote:
> On 7/1/25 09:00, Richard Henderson wrote:
>> Add infrastructure for more consolidated output of opcodes.
>> The base structure allows for constraints to be either static
>> or dynamic, and for the existence of those constraints to
>> replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 53 insertions(+), 7 deletions(-)
> 
> 
>> +static const TCGOutOp outop_notreached = {
>> +    .static_constraint = C_NotReached,
>> +};
>> +
>> +static const TCGOutOp * const all_outop[NB_OPS] = {
>> +    [0 ... NB_OPS - 1] = &outop_notreached,
>> +};
> 
> 
>> @@ -3331,18 +3370,25 @@ static void process_constraint_sets(TCGContext *s)
>>   static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
>>   {
>> -    const TCGOpDef *def = &tcg_op_defs[op->opc];
>> +    TCGOpcode opc = op->opc;
>> +    TCGType type = TCGOP_TYPE(op);
>> +    unsigned flags = TCGOP_FLAGS(op);
>> +    const TCGOpDef *def = &tcg_op_defs[opc];
>> +    const TCGOutOp *outop = all_outop[opc];
>>       TCGConstraintSetIndex con_set;
>> -#ifdef CONFIG_DEBUG_TCG
>> -    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
>> -#endif
>> -
>>       if (def->flags & TCG_OPF_NOT_PRESENT) {
>>           return empty_cts;
>>       }
>> -    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
>> +    if (outop) {
> 
> Always true,
> 
>> +        con_set = outop->static_constraint;
>> +        if (con_set == C_Dynamic) {
>> +            con_set = outop->dynamic_constraint(type, flags);
>> +        }
>> +    } else {
>> +        con_set = tcg_target_op_def(opc, type, flags);
> 
> so unreachable. Gremlins?
Yes, this was the midnight gremlin of which we spoke.
The outop_unreached thing has to wait until the end of the conversion.


r~

