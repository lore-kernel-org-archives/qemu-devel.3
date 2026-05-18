Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6A7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzUO-0007vH-U0; Mon, 18 May 2026 11:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzUN-0007tp-4r
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:02:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzUL-0003ZD-Gs
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:02:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b458ca2296so17184875ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779116556; x=1779721356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58xGmEWDODaC31gDXv6G3RGzVo6dwhCEBPCXHZLMR+8=;
 b=hW48lnASat8Y6aUMe+gsDebZEEtH8PFXDqYZ40pUNqOwzEd/WDrq06FqGrT2sfRe+T
 opaPokCDQmS7u3B2Ab2ms4HhtzHyfzHqfBz2h7YcLiSFp6LohpDBh3XoMwYAHqdWooS+
 rVFEWyEqAGUGut2ioiMQYe3JJuHCNqBnll/kWUSvkdzT+6a1uLWmcIo3MecDf/bBy9Lh
 Rgbo42XR1sadFpBrsSdvFa8DIG3IJcYKZQzSqbmfe/BOlxw89pq1kCfsr9GXxlv9t4Oc
 XdIw7uhuLTWfROkwli42NKXm0eeha+F0xAI8yumdTHKr0XXk2Q32A+cnhKwapoyQqtr4
 J6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779116556; x=1779721356;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58xGmEWDODaC31gDXv6G3RGzVo6dwhCEBPCXHZLMR+8=;
 b=bdUvnuhAcOrIGgi813wMuA2NjowzZ7T3q8uJYfqniG73q9XJMN0ISUTHdzIex7jCPs
 QleCfeA9MjPwvtcjfSy5NMNmdqcpqXHD6BQ7mJ/P56hhOB97RkiL8av+OKUxT4FfM2e8
 yMdvmAFFfb9cNum7NbuK53xJSVD/qHEKEsCbSyvlU8b6RTLOp4piyMXqw7T5i9aqgWJL
 Oj59IaZUAgvhu16mZ1Vg3X9q2sVitbwVTm9VRDHIbPcg66iAcSKZZnJV2WsbJlab1/Rt
 l903QODc2LMEqfFLzq/PnqDAJgfv0J66Tla3y21D/9Enwj/74nkhA52hvJSR+FqIwb8O
 vUng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QHVwHWn37sATa9G+RaDh8Xn3xwG9eouJ6lnTiJ1z6TT9yy+b9QLqikZxGW23rnJb/SUInaQGLSiv+@nongnu.org
X-Gm-Message-State: AOJu0YyeXo4KxeIxkslo1CONL8ZJki+AR4gp4uqT9aZ4lRFiriWI/xZm
 4fJizG47wpAaxVlB7r6MrlQLXC4zR1wEuJaKWNqnQYyFW+tqg06Ngc6gVDplbkV9UrI=
X-Gm-Gg: Acq92OG6929/Z9vd60pZX3udJ/gBi3PBk9ZO2y5+cDGh8P7aEHfOtqDYmQ+pDOyHYFX
 HmhtiBWr8AoBKKdW7hAHLwHM4du3V/XNlI5qJF+GEN7JYqcjyqnXGObfCsC+2pnOo6TQQ5tmDay
 0E604Ku7SuqIQ0L+gl3bKBx2ZRn4JFXAE5A398ztSBp5YGl8Ws2WhU2zfG+panQBAf3C3VFPYOG
 CmhkjmwrqpRUC412B/vcgeeua64fG3n5rqC6AxNQXr9R8QyYWJb2c4UqTyg+zLld+tjz/tfflkX
 v+I9D9Un0V7cxy4TZIDOPJqbE+gmT2bejc3a04Eq6TTE148lQeyqfjjOnNLg/OfpsuVpMxwGaKX
 uTvLGdbT+eHUePjmjX0xLgL9OC9i5LKbMc8fn8rFBc8JmJYD3a+HLazoqTPNjuUGnEJR8KSFr7C
 k+PrAUMiS3vO88DTfuAbpCXtNOyvYc5ODbZ+b9
X-Received: by 2002:a17:902:db08:b0:2b9:ec37:2977 with SMTP id
 d9443c01a7336-2bd7e98f43dmr170688425ad.38.1779116552785; 
 Mon, 18 May 2026 08:02:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f36fsm187837095ad.21.2026.05.18.08.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:02:32 -0700 (PDT)
Message-ID: <8af2e90d-8598-4cc4-b821-0ba4a17b5cb9@linaro.org>
Date: Mon, 18 May 2026 08:02:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 32/35] tests/tcg/mips: cover Octeon COP2 selector
 readback
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
 <20260517-mips-octeon-missing-insns-v2-v8-32-206151ee77ec@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-32-206151ee77ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/17/26 22:29, James Hilliard wrote:
> Extend the Octeon linux-user smoke test with AES key and key-length
> DMTC2/DMFC2 readback checks. These selectors exercise the explicit COP2
> decodetree entries and direct TCG register-transfer paths introduced by
> the decode split.
> 
> Keep the coverage independent from the functional crypto-vector test so the
> in-tree TCG smoke test catches selector routing regressions quickly.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> 
> ---
> Changes v7 -> v8:
>    - Split AES COP2 selector readback coverage out of the COP2 crypto core
>      patch.
> ---
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 71 +++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

