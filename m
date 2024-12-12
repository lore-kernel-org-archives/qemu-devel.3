Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7B8E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpSt-0000Dy-G6; Thu, 12 Dec 2024 15:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpSr-0000Cq-GD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:07:13 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLpSl-0008IU-Q9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:07:13 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso217834b6e.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734034025; x=1734638825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fuOKh4g40L+GRDW0EGeNdYn72z0r0KEBf1le9/Tf3HE=;
 b=q4djimD8j8mzNR08RQjhVdB9G7XM3C1Eutx8JmMUVgf34RmH7LCW8SEYv6s2q7W0AW
 btILdVxHnq2vvIkWzUjp+y+2pmBL0zsM6MGLlQ+2p0Wi4MUlLSQc2/Ssv9aCetj1CiF5
 Zwj1LHepBbHdINGU9YRQXOgniu8iz8JFFRUetzaHlqeBbFh2qdO2oZjXuiFz+DWNuPHN
 NUpTDtucTPmqsxYoWstFeyC45aMbwZKjZmmzhlTlfnCA5wKcv9oWujw/PEhCRgVWBP7x
 undM8JIjXDWHABltDHyKik5SH1XiIVxdyAD0/lJlZseLi7posOWyvFXyckrVioR4EF1I
 x+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734034025; x=1734638825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuOKh4g40L+GRDW0EGeNdYn72z0r0KEBf1le9/Tf3HE=;
 b=Z8cCvgjdJY17njT2w11+Xrc1NSocz4K9lKTbFmTJBkr8EAzRjJsz4QNicc/3AEqI5Q
 FvHWn48mFYm3LXW0qsb5YG2kLzmWkcE2LTH3otQdj5WNuoWOVXkzZiGeOyWMhluzbmXS
 EnG+pd0PttirGA+AX13yhPxmJ6PAz/CWmczPt+sInJgZbJhrEvbV6cuXi70LBFO0d1bk
 /p8mnWCUsQdTXSt+iq6csctv1S5mrS9htBVX7Z4sMvbynjwcGtlna1IM2qL8UbalwEmp
 ZJ++X+O1uWC8VgQuH6BUtl4Y6kLZPKmQbiAvSH3vAs53yHAv59P0Yx9SQnPPDP7487dn
 3GYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp+pk/q92dQuHvpUbGbpvizdtk+tSspWPLoVr2feCJzFoJAWkBRPPp7jA7SKIrEanjYMJDDyZFhsEp@nongnu.org
X-Gm-Message-State: AOJu0YyLCX9t/ZAL1mDyB9YZ+e1J2NsGO0nhALKM+5gg+sVdX9GHg8to
 aK4KXrl/my7E1AlApY2nNrdWK5fbaCHBS5aZJD6pcTLNRKqTZcK1A+WKWULkE1E=
X-Gm-Gg: ASbGnctBP6sFLwwgoeHRncwDSD8ed3fz9hazPqKs9/Y/wBPjAMNr5Tw8tNpV2VOUepl
 PJTQxrPKQLm6S9v4oJe7HcLA7iscAAJ4FRbULThC/rQO5tUm9iKhA1fHWzStn9bli65G5Z3TRNl
 S2ylm889+6SKDxc82VYnBeLtkr17C9NiKaNqk94H7U+gWgGFZ33pwh57pE0vd/sLsoR/tkVfhr0
 TSWShGC9JY/e3/iskRruMDzmfkFcpgx+hedGp/1imqnoEtgPBRlDyHudHWD9b5/ldMUyNDmig==
X-Google-Smtp-Source: AGHT+IHsHuAYTAmNID4ZaRT3EsuZrAIeV6UPoSZirkFbPA51miBHTzZ2W4vHRiuiSJRmk0KvG3RuCQ==
X-Received: by 2002:a05:6808:140a:b0:3eb:4b4c:80c9 with SMTP id
 5614622812f47-3eb856f3c80mr4866646b6e.0.1734034024931; 
 Thu, 12 Dec 2024 12:07:04 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eba3559c9esm139455b6e.49.2024.12.12.12.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 12:07:04 -0800 (PST)
Message-ID: <b972e394-240c-4c72-8461-620bd3192cbe@linaro.org>
Date: Thu, 12 Dec 2024 14:07:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: Use memcpy() and remove memcpy32()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241205205418.67613-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241205205418.67613-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 12/5/24 14:54, Philippe Mathieu-Daudé wrote:
> Rather than manually copying each register, use
> the libc memcpy(), which is well optimized nowadays.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/win_helper.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)

Queued, thanks.

r~

