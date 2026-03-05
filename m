Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90756F3D334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC5c-0000BP-Aa; Thu, 05 Mar 2026 12:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC5Y-0008Qr-K8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:02:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC5W-0003uE-Sa
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:02:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48370174e18so49945135e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730133; x=1773334933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5S4FWc2b0VCRiyuCVP1osL0L9CAwOiZq+WP/x3uphQ=;
 b=wWg+/CLoPWhDMfN7ZEmOL7l2cEABcQND7ZPIb06PGhHq+Yr/JMmpKCXM9cE9pblyRL
 PsjX3r9kddg4uBUkcqjXAKnn4bmXy/64ntKQgiLaLzBKVyJ1qPdYM7/CM/8+9Pn5epRc
 VSaR4BOx5kxMP5iNDhpemMaSqkt6HXbN7Lw8RQs92pzBMdlPJeNh5k37jl0feMexF/3I
 aKUpvQ5hlNwqyLq53ch6z1vZAQiDtShry0YFz37Qf+JmvZgeq3l9j2CoWJN5zIP4WSQG
 TrVugRJPYSbpAk8VrpbULRXYK8GjTBU54pw0frCgQxn81zp8ecxWWTDClyKO6FrGzmex
 duGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730133; x=1773334933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5S4FWc2b0VCRiyuCVP1osL0L9CAwOiZq+WP/x3uphQ=;
 b=I1vbTb4m4JrBzUWUiubrYKMP1oc+8uWS+ZGccMu7VyeanRwVhMpby6bEX0WHVSWB/l
 RHuLzTcHwazK1JesMSc9GxlUhP3xiIcvdg4Xs7zeFI/7XmyIhnLXvk25aMpnZ73nZAjg
 NyZVGpELges7ilnMzzTbDK/mS42dBJ3Yl0rqrBjlSLDnSPmgnDWsYKIOVRmcJGjKeBiR
 rUWCxgsxYjWkXWRI3XqZP48X7PghtuDyhXzO4aoTCeE+k5p+0v7Fy8Z9T34rK3nQaL6b
 z8v6Hm4tVhoHop0Io+VCFWNgbkR3ydSM+33tnDMvPZAPsImY6iYQybb639sJdvbCzcYs
 Qoeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO7+o9IdFE8jlH0E1Ba8rDeWNq8qOQk1sCKrbknp/6WiBb0vZxov2feKxsudCLcfHgF6h96cCYV7xW@nongnu.org
X-Gm-Message-State: AOJu0YweOY+5NshVClB/iF79BKssbZAqpI/tUy2sQiScZ+VxRn7DN7st
 XK5jVJWpgTs2iREIr+IAyPgMn0wb/FEMYoq6+AuT92vgUEQnRYqNO3v6XWGRsFJ2jO8=
X-Gm-Gg: ATEYQzxg4cKotc7fLLl68O0v/ETcQTV8Shx+BhclAnKrkBg2uBZdCqnZBkKj7izPsQH
 NHbEqLRetco6jIRrFvesCEr6Jb02EqxHnEk/Sa7EkWQo1bXHpIJg8Oz8X9aM28AAhC0C0LwBrTt
 kDjqY2eI07e3SJ9Ux2446XgLIwd8YRF3hoHbFFtNUSQI5/z+B1xH43+0Zw5zPaqHa2cGN0SGAwK
 W2O07lvSdy0a01mSyqjuSQFPpmMLmgvaQLkG7Rhoxg/XR2m09hPwvvGIkR/OT4rOWRt9Lj5qdPO
 R7iROID6pgSOhcxy1F+A+vsww7Jl8x+2A97ZtlOQzhrXEewDCuHwNrCXzgwSNA0kqCuDYeC8eHy
 Ia2RkL/NEPdqgulrOqyiO8pj3e+gG0B85Lvk4xhDZHqAYN54uAOFykLBqfoS5qSHqCivXi2CP4E
 FyxmqJo47UD9yYj8NslsybfCJnVPuxFEiDcb0MP8CdlvUdolMasNpq9Mrjjka4pWdlaA==
X-Received: by 2002:a05:600c:1986:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-48519897e1emr106549205e9.29.1772730132581; 
 Thu, 05 Mar 2026 09:02:12 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851ad28363sm36283015e9.30.2026.03.05.09.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 09:02:11 -0800 (PST)
Message-ID: <3d8b56db-aef0-40a3-81e8-e08803f8c5b7@linaro.org>
Date: Thu, 5 Mar 2026 18:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] hw/arm, target/arm: nested virtualisation on HVF
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-6-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c    |  1 +
>   accel/stubs/hvf-stub.c |  1 +
>   hw/arm/virt.c          |  5 +++++
>   include/system/hvf.h   |  5 +++++
>   target/arm/hvf/hvf.c   | 36 ++++++++++++++++++++++++++++++++++--
>   5 files changed, 46 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

