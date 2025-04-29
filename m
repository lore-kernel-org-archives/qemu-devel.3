Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A11C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mQd-0004aL-Lm; Tue, 29 Apr 2025 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9mQc-0004XV-1j
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:59:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9mQa-0008GZ-6J
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:59:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so46095695e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745938758; x=1746543558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMhmQHLH8iV90bKlA7RRenTXjvbapnut7sKnApZGq/c=;
 b=ztpsxTOqU1dVtS2cbZt9RYdE3PTOM3k8e4/SHLlzC6MuauUyA1QvGZ6Lwr5YH8Xv7M
 b/PN8xI6pMEgsH0cfR9q0H/LT1hNv4jrmOcI8Ct4D2aHSyVkjmhmyAZOVmGtRXaeY9kk
 JFL0kWu4lWDCJeyjaM0tTRNNOOrXtYRFu/g4exvYAKoscPbBdGOmrtQiG9ODvaH/SFSP
 d6Dg1uwd+IOFTLtPPIOeNO+5s5b8RFxQVL3WL7NepRqcTyRFGmQXDO2JB+fMjVMfUT5x
 yrkrvZIhcmf/dvyNTmWcAEuumQHXZ/RyIpTf9eCoMiG5SZBPlOYGKTiT1SNqBbRIHBK6
 RDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745938758; x=1746543558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMhmQHLH8iV90bKlA7RRenTXjvbapnut7sKnApZGq/c=;
 b=bhwqMjt6mmCY0Mru8xz/aP4CMGlwW2lT91yfJSEKIdQVbqHIHpUnZA9DiFfYqEuvl2
 NaWT1PUAV9CKuvQyquXgb12hchQHTCm1QpA8BCDvcwzLLXXhqFUaSDWvepvxlocxcrOC
 dYEEKwb58ZwnxXy1EjgNaq7f7R9XPnyisVW0s/f2gIZe/g9/xISAp60k9YJzdzMhyEzX
 utimx6+PLiYgUctfHTrLihEu4170J3Da41yaBnnL977pLn2WfbF4xsD5MgUxNR7XZ3Qs
 suf8INSwhkdGqB+pdCGIzuXtoaxRRh+JlXJ5I78wP/RkcUdifcTcQNgJU3kdKueXh1iy
 Hkhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzk4iByi0/wUz86f9HG23nNiGAeKutsj/yenkqVdIbvhgptxxdII7rZ9IeVSWpXtGDG9bpASnojweJ@nongnu.org
X-Gm-Message-State: AOJu0YxVzHvQWMM+dNR5NLdfVw5F1MeluFASOxXfvnwPxdJSLwtSIi5N
 p6b9UMl6DQLr3WBTn/KcyiJbu751PhtHQGL+//gqcuMCif5PriaZBH12Xk6KP3E=
X-Gm-Gg: ASbGnctciP2BMMqK2TwCOZso+YRi+iGm+rV6k+km4dwXKuQi+9V3mRPbi0kOdjx4NpH
 jJMhBkOMVrL/fXiwq5qnMiBkS38WrvCaD26tpbBCbgE9hewKum2jU3YQh5JlkGd1BmknaF4Leqk
 RQXcYGsdxvtBnDytUu7i3N1QQFnneTGsWb8ZNXyskjnHBbkzsF8YaghNaRid2OwxE6wRRk0B0d2
 KNO2S9PZolsWuUi5jzy+2ApEU6r1CIF0ImS/mr+/Ab1d/TwMCFyozlU/ZXCmQBWmRZXaSaJcLQa
 0Vu67S1Fo9p5ADkaxf+LBW7eqt/mZMrIERUPWXHWfQGIXojckEjy13HZvkwAoexjLZSgPOfnV32
 Bw7tC+LvzbrXHLg==
X-Google-Smtp-Source: AGHT+IFBC8MwQqZfUE2JQVkITXAWw82smszcDtWrkFX9lAOZGsorTVUtA1y98Y0SrLjIb75IOnt/mg==
X-Received: by 2002:a5d:5f91:0:b0:391:29f:4f87 with SMTP id
 ffacd0b85a97d-3a0894a393emr3644098f8f.49.1745938758147; 
 Tue, 29 Apr 2025 07:59:18 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d67esm14339507f8f.17.2025.04.29.07.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 07:59:17 -0700 (PDT)
Message-ID: <fd4e6766-c5f3-4e5e-8eeb-5d2296ba440a@linaro.org>
Date: Tue, 29 Apr 2025 16:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] target/microblaze: Use 'obj' in DEVICE() casts in
 mb_cpu_initfn()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429132200.605611-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/4/25 15:21, Peter Maydell wrote:
> We're about to make a change that removes the only other use
> of the 'cpu' local variable in mb_cpu_initfn(); since the
> DEVICE() casts work fine with the Object*, use that instead,
> so that we can remove the local variable when we make the
> following change.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


