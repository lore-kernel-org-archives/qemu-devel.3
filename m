Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70520E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 03:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNkiW-0003CZ-NR; Tue, 17 Dec 2024 22:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkiT-0003CL-3U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:27:17 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNkiF-0007Sm-Tn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 22:27:16 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f4c111991bso190269eaf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 19:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734492420; x=1735097220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ey8X1/3sKaLcIQQNAStbHtenQE3+s9At3fqOLWzS1pw=;
 b=gVSr3f0om8sDHz9y988BlvpheS68Cj/7vI7cFTFWEpOK/aALMkZpSfoe0Vs16vYkpx
 lCjsCrqHMqj8edrtTbZlf58Jei7nTCLEL3OxrE2/qCBFa0irxFqaG5CHqZYWKgeQKXBW
 2DqPyaoDTqpdLo81TAiQ1orH2axEIBMTZ8L4RdvFyHwvebK8YgkzHTyYe9jL4ls+DOeI
 iTz5niGuuxaIO3dqdoxH/CTh3SmvjN3ihZIYc0BZv9NXYIio0oBX3+3p+cKo7TKuih4z
 RGTtJjzsRh5g4ie9IZR9isYfU3wwn9UWwVJ31xT25v8LoEGy77Ejy/5sdRfAt+5XdO4I
 T9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734492420; x=1735097220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ey8X1/3sKaLcIQQNAStbHtenQE3+s9At3fqOLWzS1pw=;
 b=qtn3gPhvlKQjwMqScu4LiIa/RiN8NI29+uxx1vQQ9rYGnJG+t165sdk/CFG1NeU3Ni
 DapHAr/1YVvt+b0NxFpDollmDUpV/LCHkGy2aeqAZAwBysRrO8uyPvjvbrWIrC3p8+cR
 GjYlcghEh6I6dp9lktL4OULl7Ii0iYy0NT76sCnMykVcrezJz431Urys2kv33FJZbich
 8eOKGWyJde1xkw4avpmIvaJ7ilpBnmquxO67NG2IS1LQK+0a/rmF/KLUG6rQpKDYET2W
 oW37bph0b6KqXOWaSLYwow++kUfK9FuFojU+f/gYGTscSj0rvVyOAWgA6VrhGMilsEae
 X4Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFkF/WMrMgkBrXvPCnKZNmQ99DTzIHk8qsWgN6qR3P6qXslMW8pLDg9dPgtCfY6sg/yGzqaoL23zAF@nongnu.org
X-Gm-Message-State: AOJu0YyuUwUtr81VyKFEzZXs7Q9yENPvUT0mrDq2MIDOLZT+2+khuDKq
 LAGgEWOGxrS2oGXHmeB8dEjaTaHfcwnygOHRCNGMtUjaJYk4jQzt/1tkYsCROKM=
X-Gm-Gg: ASbGncuGDEElhOEm+yNx0M1IgPRgKsz/RHpPYcIn43iNNMZdIYv0C6pHCXTvpiRqaiX
 Re7pJZLu04O0RoYyb2x5lHxF9I28OSHp18I7WhRMiVNb4534TBaz29hnsBLT9cSwlgqRGptMYEH
 YgI2ix5ay0DInFJBnxKDfpfUxGh/g6yRGVpmE+c4f4zkiBJXrM5wxqT2eMpAMZ+G3kL95H1xbmr
 LespkpyzfTzAECDtU9J+n4JDIMAon+pg4pou4uaCE4+HgQioWVAZw3jLueVWgDh6Shjd/+JhQ==
X-Google-Smtp-Source: AGHT+IE0TC0Jxo3wgCSPKsS2/huI0TTH/DHagWyzg7dKBkfPd9s4SrlkY/vH3hAHBpkbUMzmJ8j7qA==
X-Received: by 2002:a4a:a3c9:0:b0:5f2:c0df:7ed5 with SMTP id
 006d021491bc7-5f4670183f0mr3627319eaf.3.1734492420179; 
 Tue, 17 Dec 2024 19:27:00 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a737119sm2496058eaf.25.2024.12.17.19.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 19:26:59 -0800 (PST)
Message-ID: <13ef3f72-a916-43a1-baa0-30125829222e@linaro.org>
Date: Tue, 17 Dec 2024 21:26:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/46] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-28-richard.henderson@linaro.org>
 <26ad88d4-7614-4ea0-bc6d-7b7df69bf38d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <26ad88d4-7614-4ea0-bc6d-7b7df69bf38d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/17/24 14:35, Pierrick Bouvier wrote:
>> @@ -3001,11 +3010,18 @@ void tcg_optimize(TCGContext *s)
>>               break;
>>           case INDEX_op_qemu_ld_a32_i32:
>>           case INDEX_op_qemu_ld_a64_i32:
>> +            done = fold_qemu_ld_1reg(&ctx, op);
>> +            break;
>>           case INDEX_op_qemu_ld_a32_i64:
>>           case INDEX_op_qemu_ld_a64_i64:
>> +            if (TCG_TARGET_REG_BITS == 64) {
>> +                done = fold_qemu_ld_1reg(&ctx, op);
>> +                break;
>> +            }
>> +            QEMU_FALLTHROUGH;
>>           case INDEX_op_qemu_ld_a32_i128:
>>           case INDEX_op_qemu_ld_a64_i128:
>> -            done = fold_qemu_ld(&ctx, op);
>> +            done = fold_qemu_ld_2reg(&ctx, op);
>>               break;
>>           case INDEX_op_qemu_st8_a32_i32:
>>           case INDEX_op_qemu_st8_a64_i32:
> 
> Couldn't we handle this case in fold_masks instead (at least the 64 bits store on 32 bits 
> guest case)?

No, not with the assertion that the TCGOp passed to fold_masks have a single output.


r~

