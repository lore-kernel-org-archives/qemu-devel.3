Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DA1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPKy-0003KS-9Q; Wed, 26 Feb 2025 16:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnPKw-0003FX-Vl
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:53:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnPKu-0000mh-UV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:53:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so6194675ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740606775; x=1741211575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tG8pOvKTtRHDJQex1bmZMB6uNtzs3XCAvVnFq96qinI=;
 b=zkpSu2bMSujjrpn6hef8GQ8jl5dDeMnqT0obKuFNyasl3wUf/V2l2zdhCsY1kgx6dW
 mVNittLjD+qyiD62qO1hhKlSrzWJOxSnduqqNwR2VZaOq1Sa1yz3UJ2T1KU9RPPmYsyn
 kKC6H3Bc4YL/ly9QWXpKzpOWwSqTD0QDpoqR321a3Dma/g5FgQRPenfVB1IomzaL/7Po
 naGPj7//uJx7UjpcutthGB1SBrtsUxs9FahpRgqMutCxsmFlgn614dVsxMKyJIEsGplv
 oHeWJUJhKJ/h7EMzwaFun1d5zL7bXtD2PobkLu0tgexZ8JEszDLuOq8QUqF8MjEshmf0
 /6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740606775; x=1741211575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tG8pOvKTtRHDJQex1bmZMB6uNtzs3XCAvVnFq96qinI=;
 b=YsPG5c96Rusvc3bcKUm4VhEzKZxMrZTUbmsFPsbR4nr+0xXrvOZIrAhXVFlC+OoOHU
 d26COKSJyvJEFYezMahiUOAN9ddES11T730D4hMnmHJaYPsDCnRSp03xZQFb1/Ts02nm
 65NU5pro3FLgG5utAtKF4gIXf2abQlFQXFXoh6zBOB8U/5FDz0IX+WnkS3F9zRqb7b4D
 rHlucEog9hdyLwWj8EvBFYe9WObEXuddZWa+PSeFO+g+EqeuGjyFGTrO5SutXvFSvedy
 M61NuwufU14lnY1oAj+FkTR9jFhcAVlbXJuVydIFsWDlVGEhuKn00s9rAsN29gahLLVX
 pt1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXntt2jAVHCYQFXEEPfbD+m4/Am8yECJXzEVjMuglpBM/lmYarDYSu265geIAS05JuAXkMOIKiJRRK@nongnu.org
X-Gm-Message-State: AOJu0YytCTIqgSFg1/T0zvYV1s7D2vfpEH1YA20OHCsTn+Kd1g1rhSZ8
 lUqKZG4PcAxHnecJow0tDqS0DFlXhyz4MIRvrF44UEoWvMoyM4iRYIxTqPLncRGIvYIIH6v75T7
 d
X-Gm-Gg: ASbGncui8B4MEM1wZRPJrim8L9xQxpMPINAXkHIBC2+qDEhb5BxA5vpOIUBBhboALYw
 J/UhnWq60AvSakF6myvAvGPBgXBV+I5Z5GqTxsAcuNXunnNe8fVBBnfxEDbUTZ+k2ybmHRT/BHH
 0UuP/mzzQ89a2HgC54rId2En6yPNAugCfT0KpKtdMrm91cRDBvm7xb+OFLcrD7F2952dwpZysH3
 iefhjnRbR9lo2aH+NxC+AEQ39FMi1zJaxPyxLzzyw9hk1QnxWhzZnFn5UXERDN2G9/SRNxydOpI
 e1iRSjM99lBf80yaHk17wQVYZPYvHFCtz5z88K0EZmSoSSvSeWJ8sElbElrs4EmQs0geS30eKx0
 PFnSKc+Y=
X-Google-Smtp-Source: AGHT+IGixDl7f9PUliWoHR8bpKbouO9N0OUaqrQyv0tBTJpBWz2eeFAszZsxVopK4XRtasRXXKDjxA==
X-Received: by 2002:a17:902:d507:b0:21f:6ce8:29df with SMTP id
 d9443c01a7336-2234a1603efmr15617465ad.3.1740606775370; 
 Wed, 26 Feb 2025 13:52:55 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c59a2sm1000555ad.141.2025.02.26.13.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 13:52:54 -0800 (PST)
Message-ID: <7af17a02-84f0-4f5e-91bf-f1bd19d1e5ab@linaro.org>
Date: Wed, 26 Feb 2025 13:52:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
 <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
 <7035dcac-380b-49c6-a091-29afcdb631c2@linaro.org>
 <471ba4e3-be12-4571-9165-80b780a6e9a1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <471ba4e3-be12-4571-9165-80b780a6e9a1@linaro.org>
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

On 2/26/25 13:51, Philippe Mathieu-Daudé wrote:
> On 22/2/25 18:41, Richard Henderson wrote:
>> On 2/20/25 14:17, Philippe Mathieu-Daudé wrote:
>>>> @@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>>>>       case -1:
>>>>           tcg_gen_mov_i64(ret, arg1);
>>>>           return;
>>>> -    case 0xff:
>>>> -        /* Don't recurse with tcg_gen_ext8u_i64.  */
>>>> -        if (TCG_TARGET_HAS_ext8u_i64) {
>>>> -            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
>>>> -            return;
>>>> -        }
>>>> -        break;
>>>> -    case 0xffff:
>>>> -        if (TCG_TARGET_HAS_ext16u_i64) {
>>>> -            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
>>>> -            return;
>>>> -        }
>>>> -        break;
>>>> -    case 0xffffffffu:
>>>> -        if (TCG_TARGET_HAS_ext32u_i64) {
>>>> -            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
>>>> -            return;
>>>> +    default:
>>>> +        /*
>>>> +         * Canonicalize on extract, if valid.  This aids x86 with its
>>>> +         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
>>>> +         * which does not require matching operands.  Other backends can
>>>> +         * trivially expand the extract to AND during code generation.
>>>> +         */
>>>
>>> Could also use s/0/ofs/ like for 32-bit.
>>
>> Pardon?  Are you confusing the tcg_gen_andi_{i32,i64} changes
>> with the tcg_gen_{s}extract_{i32,i64} changes?
>>
>> This andi_i64 hunk exactly matches the andi_i32 hunk.
> 
> I am thinking of handling ofs > 0:
> 
>             unsigned ofs = ctz64(arg2);
>             int64_t val = arg2 >> ofs;
> 
>             if (!(val & (val + 1))) {
>                 unsigned len = cto64(val);
>                 if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
>                     tcg_gen_extract_i64(ret, arg1, ofs, len);
>                     return;
>                 }
>             }
> 

This is AND.  There is no shift involved.  If ofs != 0, you cannot use extract.


r~

