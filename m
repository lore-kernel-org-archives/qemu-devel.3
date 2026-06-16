Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E768ECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXpb-0002g0-Uk; Tue, 16 Jun 2026 13:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXpa-0002fU-41
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:44:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXpY-0007tG-AT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:44:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso81234b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781631846; x=1782236646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLglEkF3/08d0/Bu64hh9/+Rm4xSddElC/uoku+h/ek=;
 b=WmcD73WdOS9NvojR33F7A4oZHOMXX7xX4j61O7QJfFeK4BDfJuDeZM+n9fmNn3mYcE
 /5NEMKvZt7PIDtXOC4XwfOEvN6H1aOG44c5Fqq0ohAZZb5PKwQ3znylsutOB5d7OsGt9
 Cm7jKS6kJkEERxEUdDeHTAb22afmyVZ43v2r1iUDIASPTWWfcBzC3jMdHMDVF9bnr5cj
 xoT6T0fgnrlEBca5FVFO5lK3y0w4KTbJvBJnVNr+mDhIqqQ30uZpysRirr+NV33qV2xQ
 V12g/zQ6chbWeTg0nKJR6j+XhCMOwaHBoVjHDntAeQeXDCukXkZcjJ6UCZKtFz5rfRAE
 lzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631846; x=1782236646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLglEkF3/08d0/Bu64hh9/+Rm4xSddElC/uoku+h/ek=;
 b=aeUIsc3rqwDlT/lTohh1A8TBjDG0PoWq5eoZWnR7Ka+vNLtyQJvO/t8e100hJXSYzy
 +GbClLUot9VMqfUm2PtQ5gPlAEm6n3zHTWcd0hG0k3Ua1pI2TYPa6MNYqkA17if2MIwb
 p9PNf6OguThI4PB7Uy55BwEHkFElk/J2aUDTXHRPWFqNrdn4o+ObH1CYO63SqGH3UA9O
 uktFuClf6V2y479TOgw0wPpRs4C+jkxt79giqWlB+De/l+kHVTeLeK58lLwtjB3EFOAF
 F/WRoqi+vn8XOV8rSU1NIuzG5DiHl0x7dsh0Ms1K9YO5I04/tXUqegyHhG88be1ZrDeC
 03Dw==
X-Gm-Message-State: AOJu0Ywz17Nu3g7sf1yoxXHdUxBijmHElUcgl/Hbqbvz59i3w3GiL6qv
 Mz3a/D7QjVGGQggApnfkScgW7wl8CL50IsWFIBqu9cxqswPL5dyRmCvI9drqmYYW7sN8xxtYsJq
 Q8VgF
X-Gm-Gg: Acq92OEM+cekhxjX+6c/YJkegsGTCAD71HNd1jiGdFJR1+sgRNHp/tA8cx3lH/V1M9Y
 tykYrsLsx2N80gxriJ7+DxeShIRz4UwKNqYvKpF7hHvyLkrPj4S/fTa2RKPv/MWaOOZ+ztfoBmm
 d5yeB1wrwsDpAyjY8YUNjB1fSqA6CdVT4ANiH7GD8ZYbkAbpzlHo1eQiK+UiQ7KsEiJ8jp1P79a
 6p3C9v3ia4wSwheCLBsrMVh7WQeu1ygCzeqp4m97N60tAVxDkdNsAQXItG6T+5KosLdrLvdH88T
 lVpejdtDVyzbBBylGWbeGC7+Hhit5bar+3lOu5wdJADnvFZHfhHKhZ+7IXYeFV91VL8V9wpPUE3
 5SkCWz/X4jN5v5AFNuacoWODQ40IlINEX1SpAyXXRi9cd5a3Zl4nrvx7VHOO6kp7BmXkfSohrBL
 xBlIY8wuueOANOTcYE1f5JkloKa+bKI92c5G27+0cq5mXBOFGxqut2/5g6BrjFb2IFeW/T
X-Received: by 2002:a05:6a00:428a:b0:842:5bc8:ccf7 with SMTP id
 d2e1a72fcca58-84513f7a607mr3959092b3a.34.1781631846132; 
 Tue, 16 Jun 2026 10:44:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf039fsm13332648b3a.20.2026.06.16.10.44.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:44:05 -0700 (PDT)
Message-ID: <160cd623-7bb6-4f9c-b559-450c478feace@linaro.org>
Date: Tue, 16 Jun 2026 10:44:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: qemu-devel@nongnu.org
References: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/16/26 08:33, ZhengXiang Qin wrote:
> @@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>        */
>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                                mmu_idx, true, &phost, ra);
> +    if (ret == TLB_MMIO) {

flags are a bitmask -- you'd use "& TLB_MMIO" not equality.


r~

