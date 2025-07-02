Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FEFC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz5e-0006OG-JY; Wed, 02 Jul 2025 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz5c-0006CS-EH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:09:36 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz5W-0002NC-Aj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:09:36 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40a4de1753fso778b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468966; x=1752073766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNofgsbgVVZ4B/p3tuaZB+kBWVJ7k9O2rU0tsdcjj4s=;
 b=WDIaMU43ueDmOR3IyNMsYG/S7NXrwul5FyduYXN/0G9P80VTkAtKWxBFgTQLk/WdO9
 EDlBCW1uLERHayibx+/0zjnxqe5M04XUQ3igFrwK+Kjl5VboNuF6g6GluL6Hm3N9i48T
 76FBbsnMEdg8iJCg3xxXpnPsRKP7GEzRdXStgD/hIvH14xIBp3WBA8aGf2iqozk7VUXT
 XASH/AC/z/nUx9r85prKEtTHTQukrTP8Dbl6gJX3LFXFlhr/RWqXa7cif96hO5bAYMBN
 w7fGpsFZSCqn3cwGKuGwQzbd4LCQKfDqgQJvWuq6XRZMuNvcOu+SiAylBF9GjEUZm7vf
 2/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468966; x=1752073766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNofgsbgVVZ4B/p3tuaZB+kBWVJ7k9O2rU0tsdcjj4s=;
 b=Xt9AQLhrNNbbkbWj/voLpaTMUYtykMx2SLyjoENDuiMFW0rVeLQl5zBNeajIxIuiED
 3Pc5Ju9g2pwpf2RdlaeraCq0fKjJQss4iSMCiUPp7Yku6VZ/b7m7MjUVTUoUNRp3IlMg
 JULs2UUZqSNiuvTHM2w+gVYfD4exxc70qTo+Ktdt7eOGeIpzvWHcfV5CYVlz78wbjvrk
 fWo5ldonikb1PDOSiA7f+hgJp01Jj1AeNsyEizQ50BFl96QyjFAh3Rab7niScdxH2VT3
 /Sdylh4EhVemP8YiBh3HxsWE5dpvsx80sYoMW9aJwurVfJGI3gVDKSuxPVOPrPrB99xW
 QKTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8nUiFNnNy5W+OWDI+U0KURA1t51+2ZazSriw0PlR3dFkMfGHnDtBg2w/5+s8urA+pY7mxOe7CvPuP@nongnu.org
X-Gm-Message-State: AOJu0Yy9vHl2c7fa8DuUQkE9EfzyyduDQ0oURzXUw1YzKC5Q6Ym6HPrU
 YGMa0CjVTZYUvYem9NToews/PEnJP/SkEV2B9Hi0dI2hREXA0l71ZHRuK1wrQTvKDWg=
X-Gm-Gg: ASbGncsZJZK2ZM7WYQ987hfonrGDehRq9zCWZwgRjLmMlWsOkSjGVCoPGknNOGP4iwu
 5+U8dSdBoDFTT8g22h/w/WyUgahCJvorETbIcwOt2sNNs9lRHjwQ4wo5uTpLFkgLE6bvDQ6+fTj
 rzXN26hp1XGQDq4lmV/1R0w2ojuJgLrCFO4nwpoC5HHsDB3rLyDk2tZtBcIghq4GVI2jLmNEWtg
 udSokkECPCTrYpD0bpmaQ3Lo/gzvmER4eAJ0kpZ+u/fhl3/f1pbLq25aAsCaCYg6NzL0VyShr5k
 Xyb7vVGlm0YGPmDoVuDZvBqDYtj3eg9KnKKAiP/QpsndjaNmLi8atoCd+YyHS5LeWLC8PFQNVNd
 V
X-Google-Smtp-Source: AGHT+IH+aD6cPXTA7TFu3RxYOvSvUtn5F3MkA9f3g6ttK9PmhWWp2wJeVp67PZgmE4NGELgc/mcIbQ==
X-Received: by 2002:a05:6808:218e:b0:409:f8e:72bd with SMTP id
 5614622812f47-40b899cdd33mr2188346b6e.6.1751468966120; 
 Wed, 02 Jul 2025 08:09:26 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611c3bff8ccsm1506591eaf.35.2025.07.02.08.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:09:25 -0700 (PDT)
Message-ID: <b4d1f4b3-eb97-418d-9fb4-47f9828a3f44@linaro.org>
Date: Wed, 2 Jul 2025 09:09:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 34/68] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-35-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-35-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

