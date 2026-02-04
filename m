Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB0E83EF9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 09:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYqE-0006qI-21; Wed, 04 Feb 2026 04:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnYq3-0006oG-De
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:06:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnYq1-0007M7-VB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:06:19 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f47610542so308763b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770195976; x=1770800776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1BQDt+ZwGveBewjMthST4kyVOdPiCHqqQdGl2PhLdU=;
 b=ftvrz9zW7lp+FROljnqRWmZh184dUkN5+QALYkS9SxxcKoDtkLLEatsNgGSsSG8vkU
 pbES3WludFpCrjeTwd34g1tDNwyBbgTjrCqm0B8I9BdGPa4wmtxvBdHGUPrmMH40tXbq
 BgzHz4klahH9yF7WiirSnct5e5QphOuKmNon7yXOUggw+0kRDFDm2DwDGeOceOK1u7O9
 DjF+KTIquyn0K8Xl8bALmoOGfMMAPcvIsmw3zFSA/cNTX0aRdURAhLtCqBR1ZhXV2rzS
 Y8BVjfb4ZsN12Rz94WLmzAuMYRlbPn7BkKLxFFzZSiUBi7/+EHd93E63QWTBL+mirOAP
 hEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770195976; x=1770800776;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1BQDt+ZwGveBewjMthST4kyVOdPiCHqqQdGl2PhLdU=;
 b=hgiTDM5LX3Y5esQBHjBumoFTMo6FUVC07uFCZq1IVNtbkY4MMyfmHcnVUXeU9/mcX1
 BpJJeuY7auQ7wSqa+8qhK7ILEq5I51dBEfVJ7M/L2FsFpHTnZdOUFVqwZZ739CJJQdD0
 lrwHsn+fJ4oHBtIO2W2DKNx6+ZAeRXm+LCFJO99T56rsnWsJRDS18ccI3fp2xwg0cToQ
 F+qEH/CtusicDN10vHZlaGTAOhmFpgTqdcuttSHyRhsRViho86ZBQbNvA6xOj/wX5Tjn
 MRESVow6UNeFzj4l+DIccQNyhjFt1PCSZwVhGa3S0VKy2qcvok3gli0oZER/88OjSKhc
 pidA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJnhCUB7VyB/2P1jkOCN6WvTP3Oiv+ukblB2lnk+KSYkghySnpC6/0ab1NvOrgajuzjRrvjZ6xbL+L@nongnu.org
X-Gm-Message-State: AOJu0YwXdXjbmWubOLeYmfXIchyZbCPY38/rVrDkq4dD0JagVrAsLVmD
 799YmhX1j1dts1GgaBF8hYe7RM4vRG/dp9RaFiG/bgTbE04cpYO/OG/eo18TusbYsN4=
X-Gm-Gg: AZuq6aKS0a6n4bIwONIFK1gX6nlSiCceY781rNuDAtInoUAA+uUa26axYiNoIZTLhbH
 N3y/xG9ktDlyqi/HB5yukhs2xpq+OYGJlM7lM1WVMPglafCUA1eudx+K0lorvUPJgtyOebvoJqZ
 e6rn6zrJzu2JzrBn93GT85UnLeVdm3yNXyVEdD/uM/U3N3VjnBWE2fnymvo3XzL8rxqWwpYxT1E
 YlY45edXUmn/JHA7ZaDfzk6BiJ1jG1IqVmspuMM/KtYrFNdJPKehTNbuP6CgCrfPzGqikFbyR/c
 hvBy7+9ziBeY2hhVo8Un25HT6v23G+Fo7q2SjtZERJbEyXuEeeJAKhH6DrJZdeLhJocNrsEKpl6
 LEyhzk3uQCsSBJKSL2Y4FWK8Qc3SWjG3SZjcewzybGmxoMGQ6GXlgBALkVpyVNJjBmV79U/OQNE
 IR1Z5UDV1jhnn1HdIndEyi54B0oNWahdYgUHssw7nVVf6mcaaPsXXen3HAHDbSG6ry58px9w==
X-Received: by 2002:a05:6a00:a14:b0:81f:8084:7ea0 with SMTP id
 d2e1a72fcca58-8241c163128mr2450978b3a.7.1770195975856; 
 Wed, 04 Feb 2026 01:06:15 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:bb8:49ae:4cdf:8d97?
 ([2401:d002:dc0f:2100:bb8:49ae:4cdf:8d97])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1a5214sm1853892b3a.16.2026.02.04.01.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 01:06:15 -0800 (PST)
Message-ID: <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
Date: Wed, 4 Feb 2026 19:06:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 18:05, Paolo Bonzini wrote:
> On 2/4/26 06:24, Richard Henderson wrote:
>> Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/optimize.c | 40 +++++++++++++++++++++++++++++++---------
>>   1 file changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index e6a16921c9..2944c5a748 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -1743,10 +1743,17 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>>               goto done;
>>           }
>> -        /* Lower invalid deposit into zero as AND + SHL or SHL + AND. */
>> +        /* Lower invalid deposit into zero. */
>>           if (!valid) {
>> -            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
>> -                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
>> +            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
>> +                /* EXTRACT (at 0) + SHL */
>> +                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
>> +                op2->args[0] = ret;
>> +                op2->args[1] = arg2;
>> +                op2->args[2] = 0;
>> +                op2->args[3] = len;
>> +            } else if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len)) {
>> +                /* SHL + EXTRACT (at 0) */
>>                   op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
>>                   op2->args[0] = ret;
>>                   op2->args[1] = arg2;
>> @@ -1757,14 +1764,29 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>>                   op->args[2] = 0;
>>                   op->args[3] = ofs + len;
>>                   goto done;
>> +            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type, len_mask)) {
>> +                /* AND + SHL */
> 
> Even if these extracts are valid, can they really be cheaper then an AND with immediate 
> argument, or back to back shifts?

This is primarily for x86.

(1) movz is 2 operand, so that may avoid clobbering an input,
(2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.

Because of these, there's a comment somewhere that says we'll prefer extract over and 
(perhaps in tcg_gen_andi_* or fold_and).  IIRC this also happens to simplify ppc and s390x 
insn selection (and vs rotate and mask).  AFAIK, no other hosts are penalized.



r~

