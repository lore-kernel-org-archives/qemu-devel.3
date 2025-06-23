Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E79C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkUa-0004pu-P0; Mon, 23 Jun 2025 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTkUO-0004ie-9K
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:57:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTkUK-0000LX-CD
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:57:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so4054004a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750697861; x=1751302661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ajonSy2Ip1Wa9zwTEtqQlpYz9Z4bvEkzVBRyRwoE4I=;
 b=BQ+T6A1qX6IpHNLNOpUCFNxGf2YHJMPVKNklSC4mNWX6bdUDiLxpOs08rMmu3xtERO
 jQOXy5IH7YVoDM74Ofjy+VaKJOGjd4idsikzMr3G/nilZcDDtagiRKDb9hsKhxSuc0bE
 G4HZqaPG11LOiLiiYojOgu4nvNYM5S5lMKcl+6xLmx53OBL1xjdzQUXD1CHcSLnuoPio
 2A4g/4NRw98S+T98B+ZWjKPBTCNjaqyjsq42DCIP3QQ2Z7W2SnE8BYukQgWVikeBx2XH
 hNIByQpeiN1yzn4d5d30YQjqO/LdlqIxRs9Na1GiIhk6EaF6d2o9mosN/9pBlRiCJFow
 bahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697861; x=1751302661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ajonSy2Ip1Wa9zwTEtqQlpYz9Z4bvEkzVBRyRwoE4I=;
 b=ak8dgu/rqgl9KvZ0SfaWhqb2Zl+CVhkKG429LYGWXwZuAPKtTPIDvUzzucP0HjLcXO
 Ncky443fIwULH3w3pBnEjUY7FXESDXGh17lfZ74lehtG3ihiNw441l6Yt1UqH1womEww
 5du0ooqC3G5CrjXwXasBEjsNMhcL7LuCMs8QMMsQ2kWNM16O24C+iIa+mHUSIdYpqhyc
 IHRwHQPFhAPdlP9zTf0fF43Yabx0/HCCzVzLtgA8yBVL+sgVJ7uYVwFqcJKtv07q99qm
 sexbOuCn7blmzDHt+7DJIpNTJTU4SCCq+RadXZQjcCu3VAdGca61OtzqnKVd0SIToy3K
 Uzgg==
X-Gm-Message-State: AOJu0YzIjetZnfkV9Zkvbt3eijCYGuNmRW5w1QcHcd+QVCOf73UN+8bW
 yIuUeFC81CLULpxYyK9CG4bihgBJCGCYbwcSoUZ3rQrB0/BX4XXuXr/7pPKa9wqPPbKy3ff+Jro
 iMxJCZrI=
X-Gm-Gg: ASbGnctpQeBzr8XaU8Zg0qa4eKNs0ZNpbxRIeFHSllDoOSsYoibDTcf7U8lg1btNFOu
 JTwVSOZ61GoXv+GzZbMLLPnGHZTTtodUFqCCllIRg28UAXPP5P02BxuctVBTTHQI1sh8eeTsdPQ
 voe+Ei0EGwRkBoycvpHk4DgW6TrAPMZL7Y3fB9FlZg2/Ue4lL/Y+Q8xaNmtQ4GWvPp9sjMoGM6/
 7TI1QaY5sKYB+DBN0NoQDHpHu8d6cqoE+iPhEvEuJIHpzeRX2VgH0gTJqij3qnr3EJUBCAe7VLO
 /XwJp23GcQcpcWjCUo0hSvSOYq58tTqug3SnWgfaoyzi+O0ohuTa2W0b/O7SPl31r+p34myAUlg
 EXl4dg1Tmp7LWCtRzRrC6ejzKao2M
X-Google-Smtp-Source: AGHT+IFFQ2kcXPZOKtFjHL1BkHB2ci8Lano0/oEENQa6DJcsfQQn375EMZoQCTqcHzc5C3aOffFSUg==
X-Received: by 2002:a05:6a21:7014:b0:1f5:8eec:e517 with SMTP id
 adf61e73a8af0-22026d6456bmr17316580637.9.1750697861209; 
 Mon, 23 Jun 2025 09:57:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f11a20c8sm8390116a12.27.2025.06.23.09.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 09:57:40 -0700 (PDT)
Message-ID: <132c70aa-5080-4f4a-8366-c0c8616aed23@linaro.org>
Date: Mon, 23 Jun 2025 09:57:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 015/101] target/arm: Add isar feature tests for SME2,
 SVE2p1
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-16-richard.henderson@linaro.org>
 <CAFEAcA-VMzZZSsXij0wuyT142vZppEfjXWUd0z=zW=x51z3mAg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-VMzZZSsXij0wuyT142vZppEfjXWUd0z=zW=x51z3mAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 6/23/25 03:44, Peter Maydell wrote:
>> +static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
>> +{
>> +    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
>> +}
> 
> I think we should put these "utility" functions that are
> testing for a combination of architectural features in their
> own section of this header, in the same way that we separate
> out 'Feature tests for "does this exist in either 32-bit or 64-bit?"'.

Ok.

> (I assume the reason we want them rather than just having the
> caller open-code the "sme2 && i64i64" is so we can use them in
> a macro or something later on?)

Yes, exactly.


r~

