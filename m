Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA03D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3R7-0000tL-RI; Tue, 09 Dec 2025 14:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT3Qe-0000pG-Jy
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:31:23 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT3Qd-0000Uv-0G
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:31:20 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6430834244aso4958926d50.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765308677; x=1765913477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ql0sjCPPDpabR0CJEtisz6XpjiPg9u5mtglBgwE6+oo=;
 b=xnejsaXqAHuNu6f8JjWybjDszyVZkfbP+ilf1CzKM1H1GJJaSERZHOUjAytrohrniJ
 /JIlsRWpL0cH2PNaxG8ECmizgvWLEtoDeG3mvTdftbt6FSZe+Stu/Q9HXcaYPtnK15qF
 YJEOfpK2yPXj1GJQf1YQmyYWFrA/hp+g1B4y8HPcxkE+eONwn642R38PZF7jx+B2eXew
 rKy+t2PGP+tzlNLV87SI5VoGW2Eyyeafj6GftymLpCxbf3ZHkiw8v2mT5TcsEukp0P2V
 VnCG2wb6yB0fJbDNYgPrqjaYpoZheKzNr4/+NDxKpNngSHoCx5L7n4w87RmtF91fTExS
 JjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765308677; x=1765913477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ql0sjCPPDpabR0CJEtisz6XpjiPg9u5mtglBgwE6+oo=;
 b=TZCmoyseWuh5qouXmD2fSWeO5vWCG0TUutwBw/9TCG5jG7SjrocLgSP8AHr1OGjD3D
 YUb0NMTKaC44Nb4pPPTxDl7ZWnjJ1PBUbWtqg/Lr3f3Y9AQ+HGSzPrZRO/YU2UXqTfRB
 VbuLam7fJDIt+312DaaY1g8zTUcec8Rzo3csf7hD+RS5L52dUW4BnFEj9lFhJvR9Kaf+
 WG5jWdKSANw1W9YBqNIfBTrr1UBW+XfmfgtcaKZl9CzNSLl8U7CEmqmVZeo2zJVGzVYx
 Wlm2ITzCORdKtge0HzxMR8SA7blpYtqRsn8hcY3vB9Ur3ZfupVLIS/80TWT21ThsWPx4
 u0Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtodnxgzdPbjISkHHetlgmMug/d0t42rg+/ocO3XGrVSIZ+mb2PR09QDFjmXljrJwJVBHpPB0Vw7wO@nongnu.org
X-Gm-Message-State: AOJu0YwiWVHx+ZeBmWu5r9Nl5TcAnmyLGl4hoPbMDdXeKo988ethiTEz
 RBFRXe/BaZDIkmPMZK0Kxhp1DQztJNKw1q5ux0a2KP+b14ncdas6JprYI4vkL6CzzPxrox9nswg
 FJ1co4Js=
X-Gm-Gg: AY/fxX5jIkSLfklY1Xujxrfy7REW/+pmOKgRoWc6ibZY4XXMIkptsuA/Yswv9mdyk6I
 70LrAFcqX/jxqttAPYFxC6WD9bj1OVfoSY3boBlhYcTkCcAkOYoDgUGuBs7DV4mEHIGZ3ByfBLM
 kN1M9Qwx3hHM4cQAgVKO9FwA0MsjOYu0qt7z96dUi0cy0deCc9SCLbF/ktPoSOdwmA3Yrwnxn4A
 hXEsHFo2TCiooJyqnHSnNhCnZNj/Oi11n8TdNRjjHR6jP6l6KQC17YSu/wv50M0bVSZvKBzPB4H
 CH1ALDGV4oUEa5rKmwu/5wnK41wiPUceDqmRzzdI/KUf2jgHFG54YlSffFdMeS5Oum+xZCm/b7+
 tkErokyjnWEDgKDF70mWRjDm74UFGWkXtOoqaQvQbiF1rF1CxPBMe1v7NnHYou0kGSjYxGuKTvr
 q4NYZGhNRLyNbS7FPiuLHoz+UBJNECEWbcVbDYOh99Ky8cYVwABG0=
X-Google-Smtp-Source: AGHT+IELptWmqkqrZ7QePYgeNk7KVMRDizDztcQCy6dMFZmfBezWwiJKvldJtCyHUhwcsz1H0af+DQ==
X-Received: by 2002:a05:690e:1283:b0:63f:b366:98d5 with SMTP id
 956f58d0204a3-6446e911126mr43565d50.9.1765308677342; 
 Tue, 09 Dec 2025 11:31:17 -0800 (PST)
Received: from [10.152.62.227] ([172.58.182.152])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b4ae638sm63076857b3.4.2025.12.09.11.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 11:31:17 -0800 (PST)
Message-ID: <ce025501-d19a-4e05-93bd-de5c75a84ecd@linaro.org>
Date: Tue, 9 Dec 2025 13:31:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 10.2 0/4] a few Arm HVF and TCG bug fixes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20251209162829.1328559-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209162829.1328559-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb130.google.com
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

On 12/9/25 10:28, Alex Bennée wrote:
> The following changes since commit 2257f52a97f28ce3be4366817ea8817ad866562b:
> 
>    Merge tag 'pull-10.2-final-fixes-051225-2' of https://gitlab.com/stsquad/qemu into staging (2025-12-05 12:38:37 -0600)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-more-final-fixes-091225-1
> 
> for you to fetch changes up to dd77ef99aa0280c467fe8442b4238122899ae6cf:
> 
>    target/arm: handle unaligned PC during tlb probe (2025-12-09 16:21:56 +0000)
> 
> ----------------------------------------------------------------
> a few Arm HVF and TCG bug fixes:
> 
>    - don't re-use TCG only PSCI code in HVF
>    - fix deadlock in HVF when shutting down (#3228)
>    - fix corruption of register state from PSCI (#3228)
>    - properly prioritise PC alignment faults (#3233)
> 
> ----------------------------------------------------------------
> Alex Bennée (4):
>        Revert "target/arm: Re-use arm_is_psci_call() in HVF"
>        target/arm: ensure PSCI register updates are flushed
>        target/arm: make HV_EXIT_REASON_CANCELED leave hvf_arch_vcpu_exec
>        target/arm: handle unaligned PC during tlb probe
> 
>   target/arm/hvf/hvf.c        | 11 ++++++++---
>   target/arm/tcg/tlb_helper.c | 21 ++++++++++++++++-----
>   2 files changed, 24 insertions(+), 8 deletions(-)
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

