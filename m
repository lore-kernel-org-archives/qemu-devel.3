Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F1BC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 18:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjN7e-0006Rh-Lj; Sat, 15 Feb 2025 13:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjN7d-0006RU-0D
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:42:37 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjN7Z-0004KK-90
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:42:36 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so1801836a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739644946; x=1740249746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDZ2c/5pwLdUWjHYDxkuCU+dmLSGu0I40qDFF2WWkfY=;
 b=nNnj/6ofQ3JWIPHKE83kX4XKZph+e0pd6YTU4HsDtvIenvt8TyTqmDNrTdZNDffOCw
 XTRyAU3pc6VoN1YtRYWwM1JzYK781WlCF3sp0VOdq4byAvKoWVB1LTucJUDlAiF4elsF
 ablQV73Q8OomNSmkn1c5ovSU/fkRxuDDn6Ahoj8xVJxbaLAgjWq+So39Kc01EdVpkdHm
 DSTRThVCPwn910hahff2yqw68vdJu351ZiZMSxgvMR2xtuKLHbDvEcwPlRG5Tsz3pI2A
 dAh1ck4q0rJ2sIptrVwz0WeB8qB59pbq/v8z+rLlNJq2aSwhSt+D0gx0KR+8BmYkDSFh
 m6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739644946; x=1740249746;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fDZ2c/5pwLdUWjHYDxkuCU+dmLSGu0I40qDFF2WWkfY=;
 b=hQTjvKn+qZ8a5rSDDAYnrl2+7/JqqPZOb4xSjd61pFJbjTAUT6vm1xLOmahhHSfHfu
 lbvrCxgGI1F6MsdhpvFtzMmHqxXrzpoMwTB9I0l1N32Zhzn1vu1jp16APJMzefphK5cY
 h3l/3WMgDjCizLG2qujO9ScIQsaXfznlxXCEQMfATRMJsC4HExAKVJnY4O9WBrA32M+R
 wJeNordDvGqIpBELY2sPdh2QjVb8ww3uMh0PBXBDVNM18qsLEiqUAvBxKTii0ro8r9GG
 PUnQBIsZ9JDbHMEydoEZEQT8sb9GsvV7u1Qaby1/WU4cQyRj81lYvRV1OdwPoea0NDV6
 mD+g==
X-Gm-Message-State: AOJu0YysheQybTDFIYZEqNTSYLnT0L+SDb4zSEa761jgstecSjF1g1Uy
 lwoIFuKEgjp6zBEz8Yvehckz0KcQMfDHFeQGaAXeNqvw3ETYub+HSW7USnSq6bRY4JNe35BrOGY
 3
X-Gm-Gg: ASbGncvzf3PiH+L8VN0bUq07FG8XOpNn+NkkNOxlUiId4KWekaPDCZFVheGbXtowBY3
 xguyP/916sS+oePzRlEecS+7dHkuHy5Whb0HoUYt1fiYi2r1tVHgxGnfwjocj6W1zWuYkHyp4Na
 nDu/qtTzfpth9rcREKAIscDU6d3qoPE6SYgPHVJWECNIlesdbsvCgNLatKlpHH/KwSzLV7q1nXs
 J96SkWRKMChE5ur0SudUUeSLgZuqIeAG0xL3C0IvOek6SqHBTmav9zIxGMW7KayHd22ngHQlN03
 DjQnyJqGAPkBT5W2ImmS3VVafUt6ee6NntsVPdL9m7o8lupCde6vk3M=
X-Google-Smtp-Source: AGHT+IESS0YEJRZo8ydLoolkVw4uvl21/z5bYEM/nZIUb4mjPSKmibgKJ8Fe1bdYLEyWNa7177BNdA==
X-Received: by 2002:a05:6a00:3096:b0:732:6248:ff73 with SMTP id
 d2e1a72fcca58-7326248ffd7mr5128990b3a.3.1739644945784; 
 Sat, 15 Feb 2025 10:42:25 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326ace1270sm897278b3a.114.2025.02.15.10.42.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 10:42:25 -0800 (PST)
Message-ID: <24b0147e-6825-4daa-afcd-a493685f9f6b@linaro.org>
Date: Sat, 15 Feb 2025 10:42:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/rx: Remove TCG_CALL_NO_WG from helpers which
 write env
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-6-keithp@keithp.com> <87jz9r1s3h.fsf@keithp.com>
 <21d559fc-1d81-4725-9523-60949a41e5a7@linaro.org>
Content-Language: en-US
In-Reply-To: <21d559fc-1d81-4725-9523-60949a41e5a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/15/25 09:09, Richard Henderson wrote:
> On 2/15/25 01:21, Keith Packard via wrote:
>>
>>> Functions which modify virtual machine state (such as virtual
>>> registers stored in memory) must not be marked TCG_CALL_NO_WG as that
>>> tells the optimizer that virtual registers values already loaded in
>>> machine registers are still valid, hence discards any changes which
>>> these helpers may have made.
>>
>> I still don't understand the restrictions on using these flags. I just
>> had to disable this flag for other helpers which only set conditions
>> codes in PSW and FPSW. Is that expected? When are these flags supposed
>> to be valid?
> 
> Yes, that's expected.
> 
> The state of affairs is not helped by the rx target's misuse of tcg globals.
> 
> A target should define tcg globals for values that are used frequently for emulation.  The 
> bits of the PSW certainly fit that bill, because they're touched by most arithmetic 
> operations.
> 
> However, fpsw, bpsw, bpc, isp, fintv, and intb are only used in move_to/from_cr and RTFI. 
> This is infrequent, so simply loading and storing to env is preferred.  E.g.
> 
>      tcg_gen_ld_i32(value, tcg_env, offsetof(CPURXState, fpsw));
> 

To finish my thought here,

> +DEF_HELPER_2(set_psw_rte, void, env, i32)
> +DEF_HELPER_2(set_psw, void, env, i32)
> +DEF_HELPER_1(scmpu, void, env)
> +DEF_HELPER_2(swhile, void, env, i32)
> +DEF_HELPER_2(suntil, void, env, i32)
> +DEF_HELPER_2(rmpa, void, env, i32)

are absolutely correct, in that they modify all of the psw_* globals.

> +DEF_HELPER_2(racw, void, env, i32)

is currently correct, in that it modifies cpu_acc.  That said, there's no reason that 
function could not be expanded inline:

     tcg_gen_shli_i64(cpu_acc, cpu_acc, imm);
     tcg_gen_addi_i64(cpu_acc, cpu_acc, 0x0000000080000000ull);
     tcg_gen_smin_i64(cpu_acc, cpu_acc, tcg_constant_i64(0x00007fff00000000ull));
     tcg_gen_smax_i64(cpu_acc, cpu_acc, tcg_constant_i64(0xffff800000000000ull));
     tcg_gen_andi_i64(cpu_acc, cpu_acc, 0xffffffff00000000ull);


r~

