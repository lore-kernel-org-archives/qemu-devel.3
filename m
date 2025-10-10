Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C099ECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GcI-0000oj-Bn; Fri, 10 Oct 2025 13:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GcF-0000oC-6D
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:09:15 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7Gc7-0004Sg-QB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:09:14 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b633b54d05dso1475966a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760116142; x=1760720942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dot1i7MCEiH7xJpvRlns1oIRyRrpAOiYHIpFrhLYBeQ=;
 b=O6CKQQRzgTI33CpPU7Q2S+1i7VuM/jmVxBkPRLdRANhSGXosGqEpxVjq0+4RK7rV9o
 PMalLtv6Lyg/LS1vxOGRaJiTRsOtVpPfBWRueLkP503ATXIXoLXlnyVX8MKVQs+DUc3c
 cJqpGfEkJZ37acGt0GibRHzZGgKME4bO8kEy9mMrEhLnUDfx+qZ4noR4+Z4jX6tDykGi
 CNtmRHbzpOZFOy2SY4iWxdWe9UQP94vRfetZVWKa4jp95YfLxlIcJusJCv47eP57j5wh
 9DaDDUSIQmYeBdAeLhZnenXAuRPeBzlasIZM9wiLe5VMcuRmLnAbD3bWIDmyHSeX1vjD
 qEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760116142; x=1760720942;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dot1i7MCEiH7xJpvRlns1oIRyRrpAOiYHIpFrhLYBeQ=;
 b=jRapHrDjVTasbOLkcksQhL2djkG07K1TRB0KuBzwEZYi8NRy4NPxaArfpvUgAmh5iZ
 xd9qwl/kHcHcQ5FzJteeL7pPpXqUYVb+OFxqlmiEzJphZwvsU/qSPsFEb9c/SKo1oU3C
 Xr6u8RDuwIyUxj8zWF6CbNMQfG/g7kZS/auAkbjf2WL6moX62eplATJ/P2EfgA7Lp77J
 wH+BSZxMUOP23mpBuZjCgy2JHcTSR5dzfdbWo/4w4vvonp6HQZhTjGjPNyssbqZIatBL
 46StN5eaMLMF9TcQiU+ghOSjI6UXqB1R3i8EFw3r6A2T+N+N+0sbcL7SjosxBOUtHbtb
 teVw==
X-Gm-Message-State: AOJu0Yzhyd2DQqlW5bailjpxVp/+NZwys4v59WRdsIAJ2X33RvyimHHM
 7ZvsijiKnU423HsbE0zgdDHaYEgCkuwimBq7WObYQNYIg0kLaFq4El+Pnq0qOKfeSU0uNSNdJvq
 hJuqAN6I=
X-Gm-Gg: ASbGncuZjyNDplVJ59jAAydHpElXvRoXLs8dCkmn3pi6RjLtvYKoF6qQrtsUiuyeR1v
 VfMF07ajPYcUnmuE1MobcZ7mTLAdtAIUJ7uyFXV7mHhy2pSBThpYnuhk42LoKo1KEtSoIVmDPoY
 aS5YzsY128ekGqXjs3J5n44xuE0bVc9vj3YlpJzX/mCaMzkN/XOoCWXok030hwYon3V2V4XV3wJ
 eO6J4AL23ejFSrWYQdqcbBTigSf6n6bQ9wargI+Iz9bd7Yevpiycd/SVnF/9A5uK9+nOPcuznt7
 woVjHWRd2TsUz0vNjoAhaFwFxVgvw88818Zv05vJj2sruedeavi5Y/x+nTDOuatHlJ3qLpYAgML
 n+F6xX4C9qFydlAyAqAikRtHnYfftx7xv2/5HQsNuVkosls+Ff35/dO15+a8=
X-Google-Smtp-Source: AGHT+IFm1WuMJUZom6sME4fbJx02J8EixPA74JhyuRvjsFcNVEqV0OM2zoqP3cAhDCL6jnjHX01V/w==
X-Received: by 2002:a17:902:ebc5:b0:26e:e6ab:66fe with SMTP id
 d9443c01a7336-2902720f560mr159122455ad.5.1760116142464; 
 Fri, 10 Oct 2025 10:09:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e1cbadsm62174905ad.33.2025.10.10.10.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:09:02 -0700 (PDT)
Message-ID: <5aa65653-7d7c-4948-b8a3-2ae466e82961@linaro.org>
Date: Fri, 10 Oct 2025 10:09:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] target/tricore: Expand TCGv type for 32-bit target
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> The TriCore target is only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/tricore-*
>    configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32
> 
> Replace:
> 
>    TCGv -> TCGv_i32
>    tcg_temp_new -> tcg_temp_new_i32
> 
> This is a mechanical replacement, adapting style to pass
> the checkpatch.pl script.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 1248 +++++++++++++++++++-----------------
>   1 file changed, 642 insertions(+), 606 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

