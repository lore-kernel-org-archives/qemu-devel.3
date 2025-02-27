Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D40C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZTd-0005nS-Ud; Thu, 27 Feb 2025 03:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnZTb-0005n9-L1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:42:39 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnZTZ-0007pS-Jy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:42:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f504f087eso417092f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740645755; x=1741250555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCvEupuybjfM+oXsTdxzE1T17LAWQJNidicHSfrovks=;
 b=hQQX1fjpRtoF7DeQ7Fa5HmjwIuN3S+e6sZh6AFdcp6td6jbCGEWLIJDQpX8IqrA+Va
 E3/S2f0jfVn7te08Tv9g2mF4tkcH2ud9yKL9atDcu4YzhtRIkRA3BeFTL7ERdJuUpcZ6
 1hguu4WBq2433PeF9djy8424AM81nK42ZTjWB2SuwyTCX6bgqLdCTSmsUTZE3GN6CWIV
 CB8F5DoohDanDpH0mwDn84lzQrvgiogkmFXv8zbIR5B7ADF5kJLE374XkrfohOJWHj50
 78Ma0lUoEnmMoCuoJwQzVCkPtkEv0WHUxxz6R2Dglv9SOHMgvLHluIFzpnpoAcKiKJXh
 6DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740645755; x=1741250555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tCvEupuybjfM+oXsTdxzE1T17LAWQJNidicHSfrovks=;
 b=X4oJxPZD5uc0hGBUKb4aI1Ciyi/n0mzLbdcdJpNViFbxuvwjgdpQ38ylHfrOFe32kk
 ZyQ3KdDhJailsl0EspgpjjKkU2WTtKwB/lEh+xzyfqjPcoUGekZ42/29THvfnhXlFT+F
 5v0PIzk8fGVFCldBI1qs07YGL2hhtSOhqI0BfSual7RwK5gankzTqWQV649+Uh5qovZ6
 KSjm6Nqv5up3Zx8FJzK63LVOpZTnc/Z7KN56gEO6Sojfm7FXHaUxj2TniZ7TSXulucbZ
 AmjdYIzRc6SxRWQgVVDfN8QnMPTROGtuMjppaXfba4S1M79gFOSx7sew3EK6GWYCevzd
 HmSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1fAN6/ggrgAqnAkz1P37i/RKDXjGQ4/Q3ibHrrXjWqcrwU8GHzAeFnI0XDZgtManyCnGueS2UxNxj@nongnu.org
X-Gm-Message-State: AOJu0Yy11ZNZbfS087AQirNY+l33g2ToWnaQ3m2uIYsfrIFP/kDT+wP8
 EGjeJsJoI7G+mBsumHxPmYUXpYrJKUiKBHrFwXsXcmS52R22yOry99hk3C0KJ0vUSw+jsSYBOQH
 UUqE=
X-Gm-Gg: ASbGnctZQI3ArMFdM0gIiUDtcZrtaY/osRJoMcyvGwYAhOWHwM0BxxG4Ar0fOgbanBO
 tN0C3xAxaUbIthAlzpaumMY0pcXWGmaycTe5h8FOqjJ5zfqADakkCoktGlRkIhdsGvIKPxh8rxO
 b8F6UFECzn/VMSVU8PPxl15gO6G4udsiFDPd8AnXCBEf9LdhpSP5E5OugY8R9dGA3lkZX1SQrpO
 pbvNWycnZ7eY6O7IKc3cMBI43qvweBaA4Z5M1Pw1OTnYMGBV3mzQeXpo8sDl893nc8Ffcaf+qrD
 fuuYgHiY6bC+vJXU9asvL6pleMOzkYzNPmnm8WPinVL9tLYCe1fe17ozLSWplDLZZ1NN+w==
X-Google-Smtp-Source: AGHT+IFUf1zPPb/QuPkfcuJDwsvRpSUvrLf9F1/63cGgeeJx/JBvDSwAp4CZx2i7xMMe7/MgKDs1OQ==
X-Received: by 2002:adf:e341:0:b0:38f:513a:e12c with SMTP id
 ffacd0b85a97d-390d4f9faf9mr4367971f8f.45.1740645755341; 
 Thu, 27 Feb 2025 00:42:35 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6739sm1294657f8f.22.2025.02.27.00.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:42:34 -0800 (PST)
Message-ID: <96003060-0292-4e5b-b8cb-9d6b956e25c0@linaro.org>
Date: Thu, 27 Feb 2025 09:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
 <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
 <7035dcac-380b-49c6-a091-29afcdb631c2@linaro.org>
 <471ba4e3-be12-4571-9165-80b780a6e9a1@linaro.org>
 <7af17a02-84f0-4f5e-91bf-f1bd19d1e5ab@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7af17a02-84f0-4f5e-91bf-f1bd19d1e5ab@linaro.org>
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

On 26/2/25 22:52, Richard Henderson wrote:
> On 2/26/25 13:51, Philippe Mathieu-Daudé wrote:
>> On 22/2/25 18:41, Richard Henderson wrote:
>>> On 2/20/25 14:17, Philippe Mathieu-Daudé wrote:
>>>>> @@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, 
>>>>> TCGv_i64 arg1, int64_t arg2)
>>>>>       case -1:
>>>>>           tcg_gen_mov_i64(ret, arg1);
>>>>>           return;
>>>>> -    case 0xff:
>>>>> -        /* Don't recurse with tcg_gen_ext8u_i64.  */
>>>>> -        if (TCG_TARGET_HAS_ext8u_i64) {
>>>>> -            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
>>>>> -            return;
>>>>> -        }
>>>>> -        break;
>>>>> -    case 0xffff:
>>>>> -        if (TCG_TARGET_HAS_ext16u_i64) {
>>>>> -            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
>>>>> -            return;
>>>>> -        }
>>>>> -        break;
>>>>> -    case 0xffffffffu:
>>>>> -        if (TCG_TARGET_HAS_ext32u_i64) {
>>>>> -            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
>>>>> -            return;
>>>>> +    default:
>>>>> +        /*
>>>>> +         * Canonicalize on extract, if valid.  This aids x86 with its
>>>>> +         * 2 operand MOVZBL and 2 operand AND, selecting the 
>>>>> TCGOpcode
>>>>> +         * which does not require matching operands.  Other 
>>>>> backends can
>>>>> +         * trivially expand the extract to AND during code 
>>>>> generation.
>>>>> +         */
>>>>
>>>> Could also use s/0/ofs/ like for 32-bit.
>>>
>>> Pardon?  Are you confusing the tcg_gen_andi_{i32,i64} changes
>>> with the tcg_gen_{s}extract_{i32,i64} changes?
>>>
>>> This andi_i64 hunk exactly matches the andi_i32 hunk.
>>
>> I am thinking of handling ofs > 0:
>>
>>             unsigned ofs = ctz64(arg2);
>>             int64_t val = arg2 >> ofs;
>>
>>             if (!(val & (val + 1))) {
>>                 unsigned len = cto64(val);
>>                 if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
>>                     tcg_gen_extract_i64(ret, arg1, ofs, len);
>>                     return;
>>                 }
>>             }
>>
> 
> This is AND.  There is no shift involved.  If ofs != 0, you cannot use 
> extract.

🤦 right...

