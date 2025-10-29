Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DFCCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1xy-00027p-R7; Wed, 29 Oct 2025 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1xr-00026u-S8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:55:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1xn-00025c-QW
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:55:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so42481585e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761728124; x=1762332924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/co+1TFBCq7VR6d6uAccrB3JPV3bcd0Mu6K2wDOPIqQ=;
 b=J+ldWvHikJz0NCo7Z7+FNc32Q+iyyXyFLDBaetABjhcXjOOrnX/IcnRlKnJei1P2Ct
 UO1OalQZjV22YO8GDl2b+mboSeyB/verEnj/wLUXBlXOYruY4Bc6zXjIqgP9LKdALbnT
 1t0qYoDuQVVMePj4q8vyoEbWlyFCR0reoGxHg2ErUdVmIT/Cg/3w/8FwZki0A6Rb6vZM
 UcS2E/r5Ds+gaaE+KNe25hArCqNmABCJ8czlpwsrlNf4+e81eUD3q80zbBdfk+hXmIim
 JQTM9RDhQcJpGIvJUdBKf1ZUdojWlBfoBbpHKq7b+VfqV3gV+IUKZoaenUk8GGCGowAL
 d4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761728124; x=1762332924;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/co+1TFBCq7VR6d6uAccrB3JPV3bcd0Mu6K2wDOPIqQ=;
 b=L7Bt//kx+ByrhhCix0+u3Asz6jDyI9wvaRlPOHmlYBps0YHOnOKZ5aKSxNsLUK9X1l
 5ZTSqyP86vlxjds/VPt44O2ElQawAvBnvoJQJI841JHR4Q2nyTlJ1N5y/+8wq4dU4XIj
 vRE5ua1H86ujZhQJdp3wrwqycQs087dtDk/OGa0Tm6XRf4gBrv6EFNicjt3KXj+kkTmU
 Hrnd6GjBDJjXg8r9LYk22PsQ4UF6PyC5tgtTqWzS+1Lqvr8FYxAICNWLpacGRjFqn7Bo
 gW2HuqWeH7+OSP01WBfQXjNYrZ7gWT2Xh+3nGh9RBV+iyqSLF+T/v7rQ1D9Ki8cJUSK4
 Gn2w==
X-Gm-Message-State: AOJu0Yyzbwu3GbaHu7NfM/s5IPzRDkqUi+NUb9shrIl2vRWFf1DuBZRI
 NhGqqR1p1OqffBlCCVcfbL7obf3IQch/sBDwc41NydZyLcApD63NYFX5oB8Ksj/uzdADsYoPUqq
 xDrkTTwk=
X-Gm-Gg: ASbGncv5oZvTcjh01GXaJJS/6yGkFyKeDgjIWQ9D+/FWbMrwEJ42PVramz36CFlzXDZ
 GQTbX7xcXUJrg+bK390MSRPPMuxFnBOnFFNdAFaOhK9LsgwZrtP6aBJz9CCAW94d7MPd7d5ZJHQ
 cwhqKa8B0vtaQX8V5B+qgp81Zu9+JZ3Ofn4en66WzlvjuZedfCfU0Fsa8qp6H/kmz6u5MeWJnY4
 JijNDxkXe56h676c/PiCWLDrnkCKByctWSd6TQ6DbS6w+JhCZqwICm/wwvp7Ly24PskagRyvi/W
 jE3ClM7QRPNEPutfWBHsK1zt2wy0VXlfEoScB+y+JiqEOG5xXx4HL90ngDd/wKGViObMe+37tWn
 UIn32shAyBNHS+EAiXBqCCH138KQDVjmFa5C9l4+pL92Su3k2fHdLdWakT4TOk65oDvrOmv74Zv
 Oe8nDpOLJoo4EuKESb
X-Google-Smtp-Source: AGHT+IHxafoxuhpWg4V1vFe9BeLGm2K8tBae563evTDimV+3JwYZPgvm1ZY1ZbUxU98ocrS6gsHWWQ==
X-Received: by 2002:a05:600d:435c:b0:46f:b42e:e39e with SMTP id
 5b1f17b1804b1-4771e3cb792mr11520335e9.39.1761728124483; 
 Wed, 29 Oct 2025 01:55:24 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e235ae1sm43283005e9.17.2025.10.29.01.55.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:55:24 -0700 (PDT)
Message-ID: <88e3fb1c-2885-4633-9c65-4c70e076389a@linaro.org>
Date: Wed, 29 Oct 2025 09:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/25] hw/sysbus: Simplify SysBusDevice::mmio
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-26-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> Directly access the MemoryRegion array, removing
> the need for the embedded structure.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/sysbus.h | 4 +---
>   hw/core/sysbus.c    | 8 ++++----
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

