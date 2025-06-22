Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF813C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9PS-0001VV-FY; Sat, 21 Jun 2025 21:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9PQ-0001Up-Fv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:22:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9PO-0006j3-VR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:22:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23508d30142so41745745ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555329; x=1751160129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aciwkNRkqs2E27xAmzazlrbU1YNt4ANnxWVBoYTHMUw=;
 b=nOFawZFoDmAIrMyfQ859SzVTPa8hxtlqlgCvve61+aAADmho8LLjJbQLogQFXiI6mF
 eX+p5b5G8BqEFEeckQo7+asAfGpHNU38ZljIMadszWfi/ap1jtW8c9JIB5SA7Sth/4Pv
 F8n9YEKYCvzneH4SnVsbc50Q7rrHU348Uzi/uTAaBljr5He8fq8dPO39m4qVBO9hlEDk
 /mJgZQLqMraQQ0I+dHq8ouvRMYtrKwvFYPwc4y09cgBmKcPZvlYFpknr+R7BCKVOtlZA
 7vq485zYY8pbFc8EuICh5YFb9QfMsM9UgJKuDhNO4Ga9g9ZanI4cqXiTAN0fTgqrQw56
 ZXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555329; x=1751160129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aciwkNRkqs2E27xAmzazlrbU1YNt4ANnxWVBoYTHMUw=;
 b=B+1K1ChxunOaDwczQC+D9GV+EWuMPmSKsBoitf2dXdrkTGIR9qAlEr/YJEdp242xeo
 VX8D+NjUF6PWP0lMTR1fz/KN662J6BMfZ2KXgw2ne+RMypdmvmMgZLdJOxmTXaDDknSM
 GlNot0J0gbu4xexei+u2mQC3PPzJ6/oG7pZy7Bcl2QF+LU411Lrphs7eYvJaH1IiqBdX
 v3eZ3cBNDJxnoO2lD7m3DW0nOymvxrF9K1A6ILtgpQgJHNlthzoKeYKELHZ0KeEwmSXO
 6WYai3nr/MqlEeXz6ts6B/YnC/iz6aaLuIKFXPR8ANKKRQw6aCYBWT9n64pKTt9ahK0a
 lEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHSqYNSNOLvYYkbzWVKWGV/zp0JFd71LWKahIuDcGa9ZiuuXGdJRyhQHAoCOSNPIp9ErOX7gyC8tOj@nongnu.org
X-Gm-Message-State: AOJu0YwhTISpuzapf/+G2wufOLILPVV/g2aEDe9H7M8LPITg9ywNZKpS
 HeL5KbR7YPeALeJDbY1riHJJnzzzCGj+zfH+5lgyvorwR/zQRHfGQux4qutG1eTduhI=
X-Gm-Gg: ASbGnctUVOJEb3xVDbYJoY538vwjoKgSltziXdMd0942MtVHI4Lb4inFq6z9ujbIM3A
 kPUUa/uH5nX0mhgSjeARBx4irRBg1+ABAmkwEtD9NLPcqCwOo5leldW8m7V5a+13PeRUIHz9DHh
 M8AAntUgIzLYDSjjbnnrsUYpQbKzdhjo/hQ7P1woU8y3G1/k+k8jQnkQeBwyoZpEYJVkankTPnb
 9adoyr7hlaI6ERthYf6j/6BGUC00qedAT6Bo12n4Lq0cn9uS4ofHrQ2VJhnLpWU7DlyeI+/7UGR
 fLLURV++AHAvdwB4O4yqSpskOxsIklWuhYcmYmVnCjhX7p8DBd8lKzBUgLt5lgr5cBdsq8lLyE8
 JYtTFHY8ZhdQsG99jK/T39gNr0N0M
X-Google-Smtp-Source: AGHT+IEDwak+kJgXq6CUOj4sMggBoU2ygCh+6Ke/b7YVNQyxdJdkyFceZJluGY1d+g+KyAZ3GEPIew==
X-Received: by 2002:a17:902:c94a:b0:235:ef67:b595 with SMTP id
 d9443c01a7336-237d9acc6e7mr130355215ad.35.1750555329230; 
 Sat, 21 Jun 2025 18:22:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d87182b2sm50005215ad.231.2025.06.21.18.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:22:08 -0700 (PDT)
Message-ID: <8f4b32bf-0356-4e15-ac73-205327ea6deb@linaro.org>
Date: Sat, 21 Jun 2025 18:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/48] accel: Move cpus_are_resettable()
 declaration to AccelClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> AccelOpsClass is for methods dealing with vCPUs.
> When only dealing with AccelState, AccelClass is sufficient.
> 
> Move cpus_are_resettable() declaration to accel/accel-system.c.
> 
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Adapt KVM handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h       |  1 +
>   include/system/accel-ops.h |  1 -
>   accel/accel-system.c       | 10 ++++++++++
>   accel/kvm/kvm-accel-ops.c  |  6 ------
>   accel/kvm/kvm-all.c        |  6 ++++++
>   system/cpus.c              |  8 --------
>   6 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

