Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABEAC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZZq-0003NS-Or; Mon, 10 Feb 2025 14:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZZn-0003N1-C9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:36:15 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZZk-0000u3-GP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:36:14 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so6023557a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739216171; x=1739820971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1iBWhi95mhxmEgNqQDCWVz6kk0a7Kvp8WZvC/THKsqE=;
 b=keQLizw74h31H/JirhhOnq5zAT72YvbH8qweAgXeGAifjSe2PoW0SRlT0XyJBWh/SJ
 OB0yVIpFEKLrweGlajWdRDEdADiP8CW3HXyKK9Ndg21+hcIpDfJ9L/0/+RdwqB7GXONW
 HZoB6Uyf4DwsE3197D6fF4ycbuU1TG2lSJQicgfDLX2G23FCIpl7D+NMP0LxFMCha6BQ
 NAWhY2j1kNsBmxIXX9lxp7ELbcCZR9V8tt1pY0/2OJkduFeYElTRx7zuywZ9MKTvB97p
 B5YBKBQE4BYpQ0bj9rlwgpaNyz4qcPNRFLw9wtZwk3dd0XGC7u5y1p3EjoW8QHcpqOII
 PUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216171; x=1739820971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1iBWhi95mhxmEgNqQDCWVz6kk0a7Kvp8WZvC/THKsqE=;
 b=TnmYyXcpg1oDy7dusVbBcweqML5ZozXmsYCP+EnT6ZH9n7W/LpcVCdcqAFVgUNR4G1
 hcu6kC0yTmz+EaYs9UL/56bT82Mu4HGV4XuYxUvChWL9I4M/cFhzqf99ijUQLWc4tKsK
 08KhYb/exDVVYid0+YpN57Z2DhwkkY3mNWoUkQHPXal1jQZiBFlMsv3mJpDz7QxbvAcf
 2zg+68l9v4kU5EX6YxVxSFtUdB8dGestgQV0pwE54LfscGMdXRuIqanVgdWGQT0FZ2nd
 FYjV31qY0fcJsLRtEpzG381WxniUFj/erPp5XElVlpRBWMq+OI87jqXBYdvrRe5hUyjI
 n1RA==
X-Gm-Message-State: AOJu0YyewF3WKu03fxYV8q4Zm5LrMEp0D9fznWRUxJogDKSiqJRSU1Xv
 UOMMaW+2asgUnuimkkEAXQBN6Zu5pGIxC1KWWdDiK5fr8tMeHYJG2HmGvyfTseSgfAhZqGs+V7E
 W
X-Gm-Gg: ASbGncuxHQ1LIqz0Z2gugASDGVnwgzU7vYaNfT9JA0KZg6bVT9+9GAaR02zJY7HcjyI
 8woR02E0dpCx0Kc7pB5XUT5cwnSY0NH/SqA97b7Sj4HTOoTDR12mBlCpeFXkwje+PY5FLhU0glr
 +6w6D/snzfALkakTvAC4uh9qIZm14Z93gq08+NbfHVVEiVuM+/1YA/oxNx+aQKai66osMCWXkbV
 T7jbtHSDYDQ526xEww09LiMoYsZLlC+vMV1NT7QOw2xw7j2t+3D6EYHhI/Nd+5OHEORm2ni9PAB
 9EFj3sb6P8quJM/jpShpcq6ulh+zyafZQOF1tbZs76jeErZJ/AzT8rA=
X-Google-Smtp-Source: AGHT+IFBYYO/7kp4wCTNSMx1nZgxvP7IQzcL/uNaooWIMR3woCnz7KvUnf4w9yOpYw2U2YuknjkX7g==
X-Received: by 2002:a05:6a00:90a5:b0:730:957d:a811 with SMTP id
 d2e1a72fcca58-73217e1741bmr1198369b3a.1.1739216170339; 
 Mon, 10 Feb 2025 11:36:10 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7309270637bsm2021044b3a.172.2025.02.10.11.36.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:36:10 -0800 (PST)
Message-ID: <9cf7bd67-0a24-45a1-87f8-0d57bb936e85@linaro.org>
Date: Mon, 10 Feb 2025 11:36:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to
 CP_ACCESS_UNDEFINED
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-14-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> CP_ACCESS_TRAP_UNCATEGORIZED is technically an accurate description
> of what this return value from a cpreg accessfn does, but it's liable
> to confusion because it doesn't match how the Arm ARM pseudocode
> indicates this case. What it does is an EXCP_UDEF with a zero
> ("uncategorized") syndrome value, which is what an UNDEFINED instruction
> does. The pseudocode uses "UNDEFINED" to show this; rename our
> constant to CP_ACCESS_UNDEFINED to make the parallel clearer.
> 
> Commit created with
> sed -i -e 's/CP_ACCESS_TRAP_UNCATEGORIZED/CP_ACCESS_UNDEFINED/' $(git grep -l CP_ACCESS_TRAP_UNCATEGORIZED)
> 
> plus manual editing of the comment.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  5 +++--
>   target/arm/helper.c        | 30 +++++++++++++++---------------
>   target/arm/tcg/op_helper.c |  6 +++---
>   3 files changed, 21 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

