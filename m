Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF449C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmYa-0005VB-Oz; Wed, 19 Aug 2026 16:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmYZ-0005Uv-P7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:06:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmYY-0004M0-7e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:06:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so10275475ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169996; x=1787774796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1iARXGsp1uaf2mPo8yoK1FQB93M+Op7YME5p5Rs4R8k=;
 b=pDMjxACAWhwUv7ev5gygps/EZmoxQ66jVdFE+B9sW5G+x0OXrs/0pXCzz6yQVUZMDo
 SC3gRELbqQJ+AdQjTHxqufyp2R0zgJvbkDcllRsfZg2JCXvNQ8k+HNehIlfAuy5uaNUQ
 Li+YYX7i4v365xVPn8SOXpXJFXEIIAVuBX17EKtFVXC1lCu3jKZ+3AIzcb/eG6PHlILo
 Gf0u+OvpU7BKcDPxLW1Tp2/CDJi2yjeRgs2TgVfzn7ZvyjrEPqO4QVH488gOI4SOkkP8
 qLqd4CzdhKHWRG75FDD3+EdAQ1TKf9XBVBJFlSCUjB+FVihQ6jdWtByflVDEN3fQ2mjM
 5H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169996; x=1787774796;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1iARXGsp1uaf2mPo8yoK1FQB93M+Op7YME5p5Rs4R8k=;
 b=m11c7nAwCr+OBdQIrp1vOVFB8BOVOgza2EzHK6+08vYOBvV3HEzwie4OyQZWY9fW26
 2FqIPBq/PctlJLHBe5dWYbByXkwMvGGq1kqx9WD2uArkpKEWG51de6/sTeqUgH/q6JLi
 Qad2tBqwZYpUMUt1uNTImrt2QsFBk2hoMOcUHPT6jzcGZ2ozGBhhwBKcYhu+lH8xdTcA
 1OuoS4iw5Fw7+AFK+oaTxKCw/95SpFPKz8k0G82S/nT+Z5yEpbNPow+enNVgYMd7cD6V
 6LUjEinJ/Tb/tvE6yPZliO4/H4tqyc57e2UTrEdJGVxsIdSynuU/qwP4dCCOyLZIUDsh
 XGtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RolsED56L3OuKGr6e+u9KKHLA3Aid8xHG4R1XwOVGNXDDu59yZMdq2i5K6HmNjyoNqtM5hDG1y+tW4W@nongnu.org
X-Gm-Message-State: AFuF++lv0JKBkIE/YrZXzckQj27AkFAnLnuRXhsoJ0rL3tlYnN2+UWUz
 kl4bN9B0XPDXbCyDdgmZs//YwzgiZV+QN9tIRLSaVRBT90ThroZPcDoeZycqyULYC51lPfChbDf
 pSiJNc+0=
X-Gm-Gg: AR+sD10eHP3e3YgLcXQJUVya9xo7NocWYv63PXOPQsGBIIgdgGPfarHh9AugS8iz8fm
 zYLtfdbRYxCyhbVeZkRtRCidSMhf8CRcv3Cg2wtPK20BdOW9Mn6Q7iR9xKY3u+BHnd94p7dch+K
 xlEhZ8fCAoMo/2D0nwypDf6Ny9DYtNnFo7ZthKZ4XftQfs6fj9IWPKjncz5fq/ReZI96X2CQRvE
 rdPiKkvrdhtQzb6K4evHWL1m3e3nTC0PiPnAB7shvheaWlEaBIf/IF3pRXBA3x78aycbINAPCuu
 xJUs3Y1NyqHuh0RJLxvkPh0NhnOy7sleDjTSTXu7WHc9jc47B62Ujeq+0Y1qymjxZC2GpimIWet
 Qb28DUaotPlhleqadAN4BxhewmZrhVdnXPle9zvlQx8EDEkK1dtDHxa3mGaMcOUHTund9VOwtxp
 bCgVoSSSYp+/KwaZwUrfqxm76fNWEmFEEtiF6kJdnQbxhfTr9qjoqG/bO++fSxJ/I35tTV5+cSf
 VfTsqP5mAEntWEKScE=
X-Received: by 2002:a17:90b:4d83:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39580eda10bmr12859508a91.3.1787169996109; 
 Wed, 19 Aug 2026 13:06:36 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm3683378a91.10.2026.08.19.13.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:06:35 -0700 (PDT)
Message-ID: <76582e2e-f332-453f-9759-6713275aa9e2@linaro.org>
Date: Wed, 19 Aug 2026 13:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] accel/tcg: Introduce .process_async_events and
 .transition_halt_to_exec
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Decompose the halt-to-execution transition into distinct steps:
> 
>   - process_async_events() called first to handle
>     target-specific asynchronous events,
> 
>   - transition_halt_to_exec() called after a halted
>     CPU has detected pending work and is about to
>     resume execution.
> 
> Either callback is optional; targets that don't implement them
> fall back to the existing cpu_exec_halt() callback for backward
> compatibility.
> 
> cpu_has_work_after_processing_async_events() orchestrates these
> callbacks: process async events, check for work, transition from
> halt, and clear the halted flag.
> 
> Inspired-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h | 17 ++++++++++++++++-
>   accel/tcg/cpu-exec.c        | 21 +++++++++++++++++----
>   2 files changed, 33 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

