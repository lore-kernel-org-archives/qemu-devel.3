Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F64ACD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfII-0002aS-L1; Sun, 17 May 2026 13:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfIB-0002Zf-IV
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:28:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfI9-0004Tc-UU
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:28:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b458ca2296so10414825ad.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038920; x=1779643720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vOFU4znfEsGVp9l4smN/TYD987cfM65/uvub5YClsds=;
 b=NP85OqP/bbU2tvanVIiaJ6NsjQaOigG1f6L4kub3w3krmDMgERS8ATOzxKGQrRUThv
 LaTXuknB9uXWxgeH/E5RYlZdLDADu6oyotvS0meenRG9bdbgTbZbdLZq1p0OVRI41xuV
 ggPKU7LHlOLiU4MOggs09y4df3uvTZW/wT7kXHp8sylizuk2lpbkbWPbpVx1h6QKo1iA
 pQjw1EKJ9bdsK4lOjQee71pQTWYFQzfLmAKUzw9qCYilHk1ex7X9/eByHQbDwGIpF1mJ
 ST7RL8hFyxUqVI5eygiDUUYWtfiu7OiV9wehPbIXcBbDfN5Ofac6y/VxuJfrApkd+uMz
 eWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038920; x=1779643720;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOFU4znfEsGVp9l4smN/TYD987cfM65/uvub5YClsds=;
 b=IfU1syL0qhMA7Jr8MtIseN0fBdM31MNjYlaA0A4SY3llTtnkkeqixGfls/71GnHvM6
 GdpRaScr66dDpfltBVcZ8JYEFeynx1/BxYmo5M2opyRWYrd2kU7krIG4PrBoLG+Rn3vI
 gkQ13xWkCWIcy3YAktjBHi2BH7OvUn14/H2Y/+RU+3cG6tNq1FRZUUebTb2Jbi4uJHuc
 Qm4lTNpmo81W4IQ1HxF0BzKhy1o6HEl+AkH8pjvvfSUNzd3gjN9qm1OHhq/u1KURs4/B
 +QWe15I7OhfIfdyW7olbV7cDLLaX4wRzvURKYXfRWsgTbwiQsFCxrryON02DDOS9DsZt
 5/cA==
X-Gm-Message-State: AOJu0Yz6DARLKP2b+pGYcUfsAd8DLMBQg4on1p/NaMRoqDySc4l7WkVI
 0SIiu/URMMO6fpyLxgEDvBgqkb4aP+PXQlGNrbsKvCHkaxjJE2UVX3OgMIgXDOClq0hgwuFmb4h
 UDMKy
X-Gm-Gg: Acq92OHyYDuw08TjUVVoZDCTuHFDgY0LNyLn6kKlqHnD26kRfLsfA+7wNP6C0nvaxHB
 fv8Gx6yUvXeYjv+qxKuJWvNa3eYycKhwtsQBuFf8SZrX+O35eVKZ/xGhTjfGIAMj9+aA3PKscMa
 tKw+g1lCsQhsKfxgle2IeJIZx011xP5tZw0e1ey24HgoFZNwwQdIHFqRAVS0j3sT3jdxv66/rSv
 OrTuHGQzfwpOe+saTJe0wetguPdYFl0oWgENG+hCxbbbwswHkS64d3Gmc80xs+ATFGDnmt/mJ50
 0ZFa2bbkFfodu0XJB10xY/fxYIfQBDwxyA2hKBp8huQrKGJuu4l/+99zFp/qEweImC40VTAAglg
 BPXpD6VEpW4xyPpn57rTQ5/aAREXjsUDBleDXH6zWzLhxomo/5VjYI3uu9qtwJzK+OnxwOZjE9A
 SbUQzT23jm7lw2fZcz57u0PmhAMIQkUZ0CJrmW
X-Received: by 2002:a17:903:3508:b0:2bd:78d6:2a15 with SMTP id
 d9443c01a7336-2bd7e802592mr124105665ad.7.1779038920179; 
 Sun, 17 May 2026 10:28:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11c7f3sm119926905ad.70.2026.05.17.10.28.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:28:39 -0700 (PDT)
Message-ID: <9aba3624-a5d4-41a6-a1b7-6e4b1ca53ae1@linaro.org>
Date: Sun, 17 May 2026 10:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/35] target/mips: add Octeon MTP0 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-16-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-16-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> MTP0 loads the low Octeon3 partial-product pair from rs/rt into P[0]
> and P[3] and sets P[1] to zero. Model the architecturally unpredictable
> P[2], P[4], and P[5] lanes as zero for deterministic emulation.
> 
> Legacy single-source encodings have rt encoded as $zero, so the same
> translator path also preserves the older Octeon behavior. Add the
> translator storage path so subsequent VMULU/VMM0/V3MULU operations can
> consume guest-managed partial products.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTP0 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Keep the Octeon3 two-source rt high-lane operand and document that
>      legacy one-source MTP encodings use rt == $zero.
> 
> Changes v5 -> v6:
>    - Zero P1 and model P2/P4/P5 as zero after checking the CN71XX
>      register-state table and description.
> ---
>   target/mips/tcg/octeon.decode      |  1 +
>   target/mips/tcg/octeon_translate.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

