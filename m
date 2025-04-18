Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA84EC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 09:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5iPp-0001NK-SR; Fri, 18 Apr 2025 05:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iPk-0001L6-5A
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:53:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5iPi-0004tZ-Am
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 05:53:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso16560205e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744970016; x=1745574816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3rJfOV/p/szPo4n3ALk6woIiQhlMYlsJJRmRBSMfjY=;
 b=mNWQD3MRJtT2h/aA9xEKbbg+S/u2FllnXSO7TgklFNWCBreb3/HwD7hPc1ORWuU+xN
 o6MbrHFVpLyrm8bGjDQqSEW6AFjl6Aw/n4n3V1+MqFpb1kI61Jcovo9ohsiknt7WJT20
 xnqHmuJTDZ8ErMvTgeaiOH+dbo5lVsOtKg21xjV+YqwM9z3s4y0oMb9uAsmREJWdYEYP
 M9TqYOCPQfj+C0XSO5mASmyfCaGLNQWtRBVEuyLF8Ob3aDv/2Mk0fKK+SFffHcTb51wz
 zMgzeFDyblfLOOXwQPL2y3tskfAvebylJmVIENe3fdMtDBvOzP9rzTyU1Q0kmlqizvFZ
 93pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744970016; x=1745574816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3rJfOV/p/szPo4n3ALk6woIiQhlMYlsJJRmRBSMfjY=;
 b=q5QtLmN9Csm2CgPlhWPZF9aQen6Fo1yp63OPBNKsxA4WFeF+l9eo6TmvS9x+VkswhC
 0LKgcDOkhIB1mx+NiFryM1bmWZCxnvk9ulpnLI1bLnPdkm998ggNysIxfisKFBHS9o6L
 EWMM3ZTeoIJ0VqNb7B4MMG67lL+8CiWZ/ldbueOgqMDemWz/ly1Ti2PWERNy0t2ncM/9
 WJPqOQFZ7UtYjhZjcQWHftjS/dkjbD3kAUhu3lOIP3zNGkLpkemP1vTQy8MB6IqCrG/G
 2LDOrqNk4/8r5mz4o/xXVurGcCTdmf98OkSyIP5qiNaYoR1VFPqo3yjx2DOwKM/jQecq
 //vg==
X-Gm-Message-State: AOJu0YzJUNkbu6Y6JmwacNgMur9i4AETkV34zSSVDTmz1flVaGJ1q0Nh
 pZqYeXsHzrtArbUvhXuElQNxWMjGyAsrtJ8czrnLX+N8+Kqgxj4scf2e3taM6L3lqpjkSg+H63+
 A
X-Gm-Gg: ASbGncvqES0h2Avzw3So9ImL9SKBkOSGYmV4RReM2fAzf6KxNE61+nJE+bQpowWY+JK
 5iU3YhNCLiCSWMmqSM2MxV/gsNcJKmKWa5zL0mHwi8BEBZnuZugTLwLLTb7BoBc30a5oNJs2Q8h
 tm4uMw0dt4htv/ta1FeaHsMUHQp42IOYlY+dPuk3wAW++8aqJTrsTCfLKupEqvgYHCYVmr27urt
 xd2QGVEOULyRsJhoCo3JVd7GBJ8sSJt1iETYKSkRVkgXuqHRglHFiWXurson2OKWQ8qE4tnM3sX
 lp+cPGEPzO0ZNXBypBq2ZIBNnTiX8PwkF8gOtlxVM6fLBEKkWfNRyE0UMJkpiJIhYbzFCUOWuM/
 RYSzPrxWd
X-Google-Smtp-Source: AGHT+IG4BY8/RKORtDDzz8NKOSQ9HTTABpIEOPBAFzQrB//F9tr4YOkkcU0BD8SJ3Eb3V7dnu1jszA==
X-Received: by 2002:a05:600c:4ecc:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-4406ac17729mr15437275e9.29.1744970016603; 
 Fri, 18 Apr 2025 02:53:36 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4330d8sm2328445f8f.33.2025.04.18.02.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 02:53:36 -0700 (PDT)
Message-ID: <2f743d6c-b1fe-4abe-9779-8ca60d26e424@linaro.org>
Date: Fri, 18 Apr 2025 11:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] target/loongarch: Guard 64-bit-only insn
 translation with TRANS64 macro
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>, qemu@hev.cc
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-4-wangrui@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250418082103.447780-4-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18/4/25 10:21, WANG Rui wrote:
> This patch replaces uses of the generic TRANS macro with TRANS64 for
> instructions that are only valid when 64-bit support is available.
> 
> This improves correctness and avoids potential assertion failures or
> undefined behavior during translation on 32-bit-only configurations.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++----------
>   .../tcg/insn_trans/trans_extra.c.inc          |  8 +++--
>   .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
>   .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
>   target/loongarch/translate.h                  |  4 +++
>   6 files changed, 40 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


