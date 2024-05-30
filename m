Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11708C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgU8-0007rG-8B; Thu, 30 May 2024 10:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgU5-0007pi-VA
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:10:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgU3-0001Ue-J2
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:10:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dc9cef36dso573978f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078220; x=1717683020; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J3HiJGmtGWTq9v6rsVXPjYgN2PkJzGxhZSTfFS/QoXA=;
 b=to7wH+JbMwE+PPbCeaLTQncZDvZR8pNqT0HiTEkdhw9V8qzi65IIQzKg8eQ0/8WpBG
 YU/ETV5hTZRlX7B/KIs9Ew4mSwC3g8HCZ/kXGKSKYeEJ72RpZGb7bl63Rz4AQafLq/Gn
 8qPpKyg1t0XK34mFf+an0vKPxWSsDJCcJLTz0AHuVg1aL52FEMlPkec44pMzFk+BC4Z0
 rYpNu5XG654wAq7i9N7vM158kIYTQsroZ8szYBsOVJOflLYcl9WjwMxOCIxFxG9NvODT
 dbdCreV0HAaACQQTGBef/WAKgIeFDA2qypXRY/EsJn8F6rGOUAVaOBoPga/KJsig0zC/
 i3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078220; x=1717683020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3HiJGmtGWTq9v6rsVXPjYgN2PkJzGxhZSTfFS/QoXA=;
 b=ci40bEHraTk4S3UhjU8+U/WGCkwHfmvCUf4UHw1La4D7yvTZl3tgGwwxQAnZT8TwLm
 pQrRcVWwaur71T7soPgbjODbGMeO6KRfJADjFiG9aLTe6fpDJvYUpNkAuPD+wcQkJgno
 o+3zYv0hDpUEDTnD10ge92u/oQqQdTsut8onLILzHhHlb8KTp2OA7OW4DzuGF7z9Wmtv
 wTS0gPr+HHCgttWnfb1jw8kUYT70VKck7qSQWD9lVwNJK1XLQ+0Fsx4FwwWeC1yrl8m0
 I602R72p/Jwu8iTpgkabeFSygnYZMa8g5bIb9qgNDprrS9mm29A20NbvzOQwcns3viEk
 NNDg==
X-Gm-Message-State: AOJu0YwX9Aai+oXmteGDkBeQnoTtSHjLdE7V+gKebHbUq6QBRnDGsGZD
 rxCS1li3F/KeFRpEubZyrgGjJfPDH7Ej7uGgSWGkb3y/0NS5tMLbhD/ZS4N7ZTZUkU2l3yn/42u
 HJ5Ncv0Z0458NfxojggKHEQuvaBrsMQwT2msu/A==
X-Google-Smtp-Source: AGHT+IHwwyBl8JOn+TVZPt1kWQBk3S0XG03sW30jG19ajgoxPrmEcUqIWTwYm3bqON4/C6xFJ1JXDMpkOi/rSpIhM+Y=
X-Received: by 2002:a05:6000:d52:b0:357:39e7:33a2 with SMTP id
 ffacd0b85a97d-35dc009194dmr1571672f8f.21.1717078219856; Thu, 30 May 2024
 07:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-32-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:10:08 +0100
Message-ID: <CAFEAcA8Vok=tNa_a2-dwcrKHPdZ4qf-MF2jmkqcWKi1daJ7PpQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/33] target/arm: Convert SQDMULH,
 SQRDMULH to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 28 May 2024 at 21:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the last instructions within disas_simd_three_reg_same
> and disas_simd_scalar_three_reg_same, so remove them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

