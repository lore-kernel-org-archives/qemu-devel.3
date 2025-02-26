Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D0EC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPJr-0002kl-5M; Wed, 26 Feb 2025 16:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPJp-0002kc-Mv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:51:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPJn-0000hk-Q5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:51:53 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so238362f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740606710; x=1741211510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AveMZS13THvpBuMekq9XoXd0ANO5A+FINiJ29C50+VA=;
 b=D80/cePEG79N3E38Po7+9aJ/+ITnCiFp66fSte5SJKTLPc7MPSE1MXOp0zHCmlNY/N
 m67jLuDsMbIcw8rZNIAtBFkC8H2vyggopAEJLJJmfZCB5txN2sNXN+QeW7cajlUvyTQ/
 P6rnLFy1GVQU1DfUVkyPuj3pNAMjlJWIzkGlEQr54s3c1zuAWJB5MDmz1hawIYql5e3q
 bGllyPpSNf7TzkhIII/SZd3Lvi3NAVHWKiynljhh8SJN+QOcwV6g0fqLYwsjUllruzNX
 HNGhuBeW1jBywK0alPnJ4ZRORKUV9Om5PuAqPUrzM+uG7eNk1WuXO5n0ENmJtyoXIyFj
 NpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740606710; x=1741211510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AveMZS13THvpBuMekq9XoXd0ANO5A+FINiJ29C50+VA=;
 b=YlNWcGRI6dNKG7t0ps6uxDZQHUDvUBDEzsY8fRw1OlJH3TPJ8Q6ZIwJm81p1jnGGor
 cb7kYjY7heRv1LkJOy52xLKhmVzXHXJyYYlnsVR1/1T+OQhYE/eXu5S9Gioe0tyGlioF
 9nVnBjABsyqHq4LSkwAvM4KTlOAvIKLLBHqznNiOPSAnZNXQP1nwOU5/aLInBsEBAcS/
 ubhEJBhoA+asoqGwGQA3+p8fOwaArtYmj6RBwJzakL7EcCAZ9jJb4KYffbL+SJA7QFVv
 odGBWDUKAbPLIKHgzGzauIqId6CoIfmt/REAqaCktDW1pGqwc6MS1CtVlFKOiFl/oA7B
 73kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLlntwOJBY0JwEu4PCOw+hLu1d0ly0dLUtr1SOQy1k7aE0gcQsmJxvvKaqlmF6c5s0cMgJnP/9xFYQ@nongnu.org
X-Gm-Message-State: AOJu0Yz4sQCGO4AbW1nx0kKzrlGhFeFjtC+T7P0xfP4grFJO+ifaI8Ob
 JvrlGDXzpKYwdaMcBRgZHJly02ppU/rErhqdfvqIrI89zx5h1DxcXn8cMxeH8P+uSVIM25HqVXh
 xHmo=
X-Gm-Gg: ASbGncvvUHDlSGQMiLL+kp/DcJPVc6QBF7EI/e3HD0aKaYHVuYML5A7rkTI8mziAdmN
 y5Y2ipzlNe+fRW2pgQStZtQG/RzFYEUkzTduaHgbmQvfqrpe6m/eixrspQPOxUNvMeY9OyYaJcg
 m5ZrC869ZjNVFL5DeISa5UXDLdXjQCvne0vWbsPku4DNYPfcXnP7WDtHrdZBnxcXa1UOQPM9SLX
 JpzJxQjJxpw6e9quCZEcLFgwza5cBjMnQ0FjJ4z/hHa3u9eb4xkq/0kVA3Nn7vk4p1ud/k91pK5
 DsrsgxJWrtlu/q8JlHUJqyvyfDEqYeDWFUF8/lplk1q2a7n1gnG99Pfv8lKNqzUBBWUV3g==
X-Google-Smtp-Source: AGHT+IHvCqJuri0rtB3PE0lBEp+3YU62LbzZbWVKA0wQ04eoarHJzK9HK9QsqNVZaSRkjyb1yX0s0g==
X-Received: by 2002:adf:f391:0:b0:38d:e3d4:4468 with SMTP id
 ffacd0b85a97d-390cc63c3d9mr8628931f8f.51.1740606710019; 
 Wed, 26 Feb 2025 13:51:50 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b737043aasm2286195e9.14.2025.02.26.13.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 13:51:49 -0800 (PST)
Message-ID: <471ba4e3-be12-4571-9165-80b780a6e9a1@linaro.org>
Date: Wed, 26 Feb 2025 22:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
 <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
 <7035dcac-380b-49c6-a091-29afcdb631c2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7035dcac-380b-49c6-a091-29afcdb631c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 22/2/25 18:41, Richard Henderson wrote:
> On 2/20/25 14:17, Philippe Mathieu-Daudé wrote:
>>> @@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 
>>> arg1, int64_t arg2)
>>>       case -1:
>>>           tcg_gen_mov_i64(ret, arg1);
>>>           return;
>>> -    case 0xff:
>>> -        /* Don't recurse with tcg_gen_ext8u_i64.  */
>>> -        if (TCG_TARGET_HAS_ext8u_i64) {
>>> -            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
>>> -            return;
>>> -        }
>>> -        break;
>>> -    case 0xffff:
>>> -        if (TCG_TARGET_HAS_ext16u_i64) {
>>> -            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
>>> -            return;
>>> -        }
>>> -        break;
>>> -    case 0xffffffffu:
>>> -        if (TCG_TARGET_HAS_ext32u_i64) {
>>> -            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
>>> -            return;
>>> +    default:
>>> +        /*
>>> +         * Canonicalize on extract, if valid.  This aids x86 with its
>>> +         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
>>> +         * which does not require matching operands.  Other backends 
>>> can
>>> +         * trivially expand the extract to AND during code generation.
>>> +         */
>>
>> Could also use s/0/ofs/ like for 32-bit.
> 
> Pardon?  Are you confusing the tcg_gen_andi_{i32,i64} changes
> with the tcg_gen_{s}extract_{i32,i64} changes?
> 
> This andi_i64 hunk exactly matches the andi_i32 hunk.

I am thinking of handling ofs > 0:

            unsigned ofs = ctz64(arg2);
            int64_t val = arg2 >> ofs;

            if (!(val & (val + 1))) {
                unsigned len = cto64(val);
                if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
                    tcg_gen_extract_i64(ret, arg1, ofs, len);
                    return;
                }
            }


