Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49893D277CA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veMLD-000142-6c; Fri, 09 Jan 2026 18:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veML9-0000z7-Cu
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:56:23 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veML6-0003qH-EC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:56:22 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-29f102b013fso46544075ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768002978; x=1768607778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGNyw6s5MTr0RaZ4KmcfEpmjKqGLLGsTn8L5MxuLE50=;
 b=k9/aolF8IWQ0jy2ZHQj5c1o9bH6PLB6ydW1yHMNf9HEH4T8/f6JhQ7dKI0YWnezSzp
 c+8w+dx9V/15exZPp6veWZ2sNA0lufRMGd5yGRVizdiJffDxF8xZNurRnxi04+7jt9bV
 eR19d4EFJ7ysssNC0xKVKCtnYBwp/8Y6jCEdWyoxXzOkE3ZlENivSy/g0au+dB6d3n0I
 ZCfIBrWOb+bv3XoG/aM32XDaRS+l6GAEB8g3j7qqG7Fj2EAGTDDxAzDEz9sYkpozfGBC
 JAzLvzE8btZgyp62TT0zOPVFJSUC1gBnHxzk8ya3L/nebycGcOKhBl1TD7lsac4sGiaF
 t9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768002978; x=1768607778;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QGNyw6s5MTr0RaZ4KmcfEpmjKqGLLGsTn8L5MxuLE50=;
 b=UBvDtgNFtH34ku5eIAXq0LLFUmRVQg0tjRJdSzNxuqRXmHoUrA3HFv0hB0IV2UJe5O
 7vxboLYeRP8miSHlfrvvRvOtJXLkCFcmvcp8EiowfW8EG4tr48JAes76kkyq7e2lhpFg
 cpJdEROEbShGzQpRaIiXxaxkJWiA+yjd7FmK7aENXuM4DKogIGib9v7536c4cpZsDDFQ
 rfY1VYFm0se85rCGxy2/ewyy3xKPIPqVKcAMHshcsZxuxSEmiyxG+nGscXU/VRxIV1Ap
 gmsM3e0Vc2PAlh3QQE7wN/LUgFnD+zqvDyaH1j312xc37ImHEjJOnJZHv70km+xYihf1
 qWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6oJ84FYoC/n5uMJGZ4AH3ovFbLUdCPTVvr1fKHMVVsGfE2fwYCm54y97Rjk0SQrZp0inVMwxAR05P@nongnu.org
X-Gm-Message-State: AOJu0YwK9U774Ujy+latcD15H/7u01FUrJiEa38dbXuAMZqjz8s76yFd
 1cMrbBxIlMwvpiBogwxLdK6qFUnC+e8hurNCiFA8hN0bpmXlavPdAHhFwDjdYRgkcgg=
X-Gm-Gg: AY/fxX65TCRCnGSUIVHViWxbJ/S+I3MeD4/unIkpBGzt3EqOHNLEvCCniCmDDRRdATs
 YpQcO1nY/COe9TiqproIsHLQml0/Yon3Rgz2W7I3IN4Qt6GtCYrt2ZXQUzoPszBsQZZ/+FoktzP
 kvhmUqFgQ06cUDODjPtvvmvBbw++vJESsoxDQAL2sXr1tZaflRTCbm/B0Q/8WyChf2YT86T7BQ1
 dSyhCgGkd3QOWQ9ZOkwIkOoCbkytSP3Lk3kr65Ftq1ECoruGsmSsXYMAfst+GgodPbJ0y2ONy2T
 uYr77vw+htF8YEI41sgv8qQUexaGOJY0kPKEV9KAB6I+mFjF8cIRvpWCCkRuj/XuhKxFLRY5n1N
 vHcEONbullZ7oMJ9e8jlHGKXCXXGAwJQA1DRqjPl+Yw4gfz50cBPfVbMS3xhyFAXNgfuv3u5jFJ
 Ld/KVqC2RtUVg7rdB8+SxjmpysSg==
X-Google-Smtp-Source: AGHT+IGcVl3XSpvoYN//cKumS8BX07cD5U8g1ZP56WcGVKOfuyXEYFnXOUyXIwGhEm6zBM/307wf0g==
X-Received: by 2002:a17:903:37d0:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-2a3ee458e26mr103697125ad.27.1768002978331; 
 Fri, 09 Jan 2026 15:56:18 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48dc1sm112810845ad.40.2026.01.09.15.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:56:17 -0800 (PST)
Message-ID: <4be5bd97-21a5-40fe-9a9c-a4e05b11a1ea@linaro.org>
Date: Sat, 10 Jan 2026 10:56:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/tcg: Restrict WatchPoint API to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260106231908.16756-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260106231908.16756-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/7/26 10:19, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series is related to single binary, where we want
> to build compilation units once. Headers using the
> 'CONFIG_USER_ONLY' definition are "poisoned", except if
> we duplicate the meson source set, in that case we define
> COMPILING_SYSTEM_VS_USER and CONFIG_USER_ONLY is no more
> poisoned.
> 
> Looking at the watchpoint API, CONFIG_USER_ONLY is only
> used to avoid stubs, so it can easily be reworked to avoid
> the need of duplicated source set.
> 
> Since here, we also restrict the API to TCG, and unify it
> in a single header: "accel/tcg/watchpoint.h", since it is
> distinct to the BreakPoint API which can be used by hardware
> accelerators.

Watchpoints could be used on aarch64 kvm.

They probably could be used on other kvm, with modifications to kvm -- at present the api 
presented to the hypervisor is breakpoint specific, and I'm not sure why.

I think it would be shame to preclude other accelerators from handling watchpoints, even 
if none currently do so.


r~

