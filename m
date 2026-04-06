Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3BBFB5175
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9sLg-00029f-3N; Mon, 06 Apr 2026 18:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sLd-000295-4t
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:23:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sLb-0007lf-F5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:23:08 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-356337f058aso2364030a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775514186; x=1776118986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YGKNipJ2OVvWokNZzLAt4TPzeTRaTaNXeLouxv44BFQ=;
 b=ptxn4EPoq0rgp0bN7Tdu+6xtKBL6+sm2Z8Ho8MleXLor7a2OhQLstjwDp1WZZxnN6o
 MGXatwVzgtHib0Li1sY7Bf/owoFnNgsK1CfSshOkHKm8g/AVBW9p8P/7a0eKlUcJpchP
 g5Oi+0d9z7hwcHl/xsAU0M/s2DwiEX1ARb1w7783pmfbVhnGvP3U5YiY+atShW3txo9y
 7xD1/aIgCv2nqZMEOE9JyG404rFd7xukl1+RHosYYDvSAC7wN6tdHNjqHnjm/LNUUpEg
 pL6UlgDM6Jh1gcQ8YUBsvqUP1KUEmAWFvrPqBH3ce9H274FH/ZZ8+ASQshCZvju6ADdB
 dHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775514186; x=1776118986;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGKNipJ2OVvWokNZzLAt4TPzeTRaTaNXeLouxv44BFQ=;
 b=rkpoq0AiglVmvhuXb72XWVUKZoYd5RmOgCLfrCFV0mn8/NZiTUOz3KqwOYHqF7JXSS
 ACH/seRUkSH3KnO0hmcC8k9fU7O/HgzHrVye1YAtBaYzVkZPTgB+EnKzJI5RjKo9ONvi
 u8asXOFHcQxJOB0Ev26VWvf9e7yzJLRQiNimNTJQYxJsrcPV45bXISP7dZHN+6YsVnaS
 D8U1JNvFyk9+GC8mNX61xqpKD3i8r7stnC5nQrJu9+Wif4cYhppxY6xOqRJ48iv7qSWa
 PLo/upDA59s3s4STmwl0mHQR/Yuk2PvmhBJifsk8Zml//C2zZOpVz0y3bzW+Wl8VtX0U
 s65Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DjwZUEOyoOLn3+YRtb83btn3bUimIDhbRytjhOqEu1YTwOgnW3Zbxg8OdN0UE57EsBDnBGn2JxRe@nongnu.org
X-Gm-Message-State: AOJu0YyvHg+5VgYCJloSst7xc64rspMVz3aQApL55UvUXZ7EF6+8gHzd
 UlQITREKaEUcoxXgGoiAehacudQ1bngb+p6/deX2EvZVv9eUJTzk+uQ+uW3r5X6jHhA=
X-Gm-Gg: AeBDieuG1h4Vi9gR7IoLpgYkKtBxnScrKp6Dn8gsZPG4fA6Qom2fM3+YB8KzxdIaUwp
 3DBOZQ/ZbQ6sGcrUDfSKmXyAcEV+kWtIyB86+NIonipwjDXnIn9E7jh9dBzeJLIqa8EELQT/J10
 jch7fTkIhGUxTV0jBHJLny6mdVlGN3zkEcDA7hTLj51ouNs2SxY1ZDARngliGPVj4ydNOdA/7xN
 c7zaNfL6znikhDnFS37Qvy1bJXASl4A+MWHQJA/5wprf5px1e3K7N423zjiO2WHhO+TXi+7uu/n
 0Q7zdWuR9qgIq8FTBsTLkZW1K3F+5+XeBGywuXRMEZ0xxcntOTbTWYHokAkdM+gsmAWEd1kciQK
 ZYD4PAXXCGVoTLugblBPmcXZ9cJrYoxAaOQg5K0pTUdzdTf12uLVL/4AdynFdugXOdu518kzDGD
 nG0BtD+VwfxsFJ0dE9Ikppe7vs4ngF9fParhchjMsHuPIzZlHIjmILUdmmUK+FIlb29O4veA==
X-Received: by 2002:a17:90b:184e:b0:35d:90c4:59f3 with SMTP id
 98e67ed59e1d1-35de6872d57mr14409182a91.13.1775514185461; 
 Mon, 06 Apr 2026 15:23:05 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de697d1basm4099828a91.9.2026.04.06.15.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:23:04 -0700 (PDT)
Message-ID: <427d0c5b-c470-443c-816a-529bb1883250@linaro.org>
Date: Mon, 6 Apr 2026 15:23:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/20] tcg/translator: add parameter to translator_loop
 for current addr type
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-14-pierrick.bouvier@linaro.org>
 <6fc3e58d-16b9-4a09-9889-3b739f78f106@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <6fc3e58d-16b9-4a09-9889-3b739f78f106@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/6/26 2:29 PM, Richard Henderson wrote:
> On 4/7/26 04:26, Pierrick Bouvier wrote:
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -121,13 +121,15 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
>>    
>>    void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>>                         vaddr pc, void *host_pc, const TranslatorOps *ops,
>> -                     DisasContextBase *db)
>> +                     DisasContextBase *db, TCGType addr_type)
>>    {
>>        uint32_t cflags = tb_cflags(tb);
>>        TCGOp *icount_start_insn;
>>        TCGOp *first_insn_start = NULL;
>>        bool plugin_enabled;
>>    
>> +    tcg_ctx->addr_type = addr_type;
> 
> You should be removing the corresponding line from tb_gen_code.
>

Right, forgot it.

>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>> index 4d22d7d5a45..24c556bffc0 100644
>> --- a/target/alpha/translate.c
>> +++ b/target/alpha/translate.c
>> @@ -2953,5 +2953,6 @@ void alpha_translate_code(CPUState *cpu, TranslationBlock *tb,
>>                              int *max_insns, vaddr pc, void *host_pc)
>>    {
>>        DisasContext dc;
>> -    translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
>> +    translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base,
>> +                    tcg_default_addr_type());
>>    }
> 
> Use TCG_TYPE_VA to match TCGv_va for the compilation unit.
> That's even future-proof for arm32 when TCG_ADDRESS_BITS changes in the next patch.
>

Ok, sounds good.

> 
> r~


