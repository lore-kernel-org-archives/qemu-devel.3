Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7DACD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIWbd-000192-DY; Thu, 30 Apr 2026 14:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIWbS-00014D-P6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:59:16 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIWbQ-0005lB-NW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:59:14 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so265252d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777575550; cv=none;
 d=google.com; s=arc-20240605;
 b=dC685TBvDQtKkGoz9eRTYl5MXqLJPFfdXIk/fqWX8936BDqWkshNpbLe0PiYviIcL3
 comebN+7WXSkqG+/h6qLejlXA5pQzLR0A5Lo7ITWHUtaT2YYJxIsuZexQG/YQ9YitnEF
 EaevsdT2FPpG2WVjJ803ga4+DYmzj44mDutP0McdLwHm7nSy4ZgM+7TVnMa9rOKh5F4M
 kyta0c9j2nidnDmMfU1LBJDMswF5D2wOyhBcWnG7NkNJne2boCmRY7JvdUFUlwmwDZFx
 Cgzch4xyBDBn+X7uj/DqtRb64RLWNcKeeYXYUCquLLjF03NZjU3LnB1IAx5bTg8pv2Ew
 ZOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QMWsypGprU2vf2WaeRTAV+hObzHLR83YenxHnUaqiMw=;
 fh=7h/hL4H/2TqCtEC3HrEDvuFF/zRWaxDGzWBr9wKj618=;
 b=dONAtoAGOOV6ZgD4rd9bpcsPYsHjUJ6Z8rtghqHePpAGb7rY160fKlKVb6M7vxFk8a
 Y0KodNFynQ3Tw46rN86Bd1UG6pa+NZlpEQRbJ9UJ5BU/SZlXCaEZ/+ZDhcmrb6Waxbch
 uYuDFq7VG57/KbgXOt2nTYpwpV7juVyZbHFTAKVUtaaaGuK7cgG8eCb0NBng8Ln6fr6X
 4qrX/U/5InQ/aKZ1DaeI1nZoOsiXkSxTxA1B4paO5f0dkBZPIuWhmnuPtJoUs4ZZQi+V
 q+5dHDjpA5rfz57p/Wxf7BYqCi56Y7IEG8BjFoZiEi+HQ/ljl3PnBPdN0jqxkUasBk/V
 XuLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777575550; x=1778180350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QMWsypGprU2vf2WaeRTAV+hObzHLR83YenxHnUaqiMw=;
 b=rD5fiEXIXbnP1Hf5gt5+xkyuIRzB9VgwzrCo/A8J2k85qeR8Kq7pxLIcXNA3EBCWjn
 fojQR0cZr9sH+jADrizfClu8fRwqDkxjyGG6tietYq9XYREeyaDcIzBAEZbRypZSQUJL
 49D3Q8LKVocepCA3uHbXcdYVwcwoBPslPaLsvkvLMtgBMKtvMAyFg6kBSJ01Suwc/ZIl
 /qqetntBHFHxmhkbbTtqT6uYMJ6Od4C4LLiJ1EMeYShG+Q0CB396tBWgx9YgCtGssKSv
 /Ixd9fNOPcpD3fNbWItc8NP4kYp2uKBEDGtyWHjKMC71IU8ZJhOLzq3qgi1pDOIEbEhU
 fAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777575550; x=1778180350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMWsypGprU2vf2WaeRTAV+hObzHLR83YenxHnUaqiMw=;
 b=K7hfuEc9+HveOuaPW8BGU5fNffxggIllEARTNUgA7qLV6cHQl5KLN5JtbTz0R0pj5r
 gtH15xxrZ4sAeWUz0sZb/+AgUZTqU78Ukuvd8FD1wCSSdkDEmJm03FKwq7Jm+bgJGFUb
 6DjZjeZ5G1CtO2X7Zq4wxQ2ijBA2JAscRMUJx/0ti6PSdvvwKvc6Lw8n8HJgs5KXsNyC
 NRBApNHfKQ1paR2QR+E+i+gHZIzAtURK0vXe0ClVB0Rlweu3c02RpQdYN0Bz1WqeqN2Y
 j3sD+DUNxo09qT4wK0NJLqpTmmdaXFYOlXYk1jsRG3hz16geGfasyo+oUl5WT8FpRkgz
 71rQ==
X-Gm-Message-State: AOJu0Yz4UmtWcoEnlGSJ/8JIZiHNPfm8YwBibseAC4xKd4QUa7ea4aMy
 2C5KvQ/8VVWLN2rE3ozLwKGRoAFLnTt+n+VuakkHZ4ekvrUQbLrmyOm5MVbJ88geyvPGLwTBu5n
 416tUWxkr3bgYX9A8UyC/1aq0RkELNhunU0PHViqEkQ==
X-Gm-Gg: AeBDievO06rGIJUHZXqV78FnaAZkQnW+6mIiPNM0uK4/2luQkIFcuM6U9utruNUfddR
 rR5g3bmTWd6zgfMpQ5r2ERuFXO/8XIJzn98eK6TeU2dDSBQ6onBX9NVCK0/zJjosYZHgrJDaeqj
 huLIaFcNLfI4Am7Kbh8JCMvdZb/WF2teJzjQ7uRVkcW21E+8V/5PdHEBvGHrd0y3jMGMfvREMeU
 cj2F6Kt/vPFHlWgw0RyUTlSNfUSUstl3iU4pO6L7dp/1z64setz++6UuvTj/uDFu6DUL9Fr4JKg
 UMtpSGeRk6mSVcMELO3spEWrWLFQCM0kX0+Lmz0c0GEVG3J9HnvewW81NgtFbEBnLBirpJibVrK
 uyA==
X-Received: by 2002:a05:690e:43c5:b0:658:7513:5ee8 with SMTP id
 956f58d0204a3-65c30584863mr24561d50.21.1777575550014; Thu, 30 Apr 2026
 11:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260428083119.1400110-1-gs_liugan@163.com>
In-Reply-To: <20260428083119.1400110-1-gs_liugan@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 19:58:58 +0100
X-Gm-Features: AVHnY4I8zCXnTDxY2b4ksJBdjV5c-6MxSMh8812SItYPoloSnXgfhrDIVi1U85U
Message-ID: <CAFEAcA9HADVEBT=6pQSAr93G6uSmVo7Tz54U7nk0AKG57RXFGg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when
 prebits < 7
To: liugan1 <gs_liugan@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, liugan1 <liugan1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 28 Apr 2026 at 09:31, liugan1 <gs_liugan@163.com> wrote:
>
> From: liugan1 <liugan1@lixiang.com>
>
> The existing code uses a blanket `regno < 2` check to make
> ICC_AP1R0_EL1 and ICC_AP1R1_EL1 writes from Non-secure code WI
> (Write Ignore) when EL3 is present. This is intended to prevent
> NS code from claiming active interrupts in the Secure priority
> range, which could block Secure interrupt delivery.
>
> However, that check assumes prebits=7 (4 APR registers), where the
> NS priority range (128..255) maps entirely to AP1R2/AP1R3. Since
> commit 39f29e599355 ("hw/intc/arm_gicv3: Use correct number of
> priority bits for the CPU", first in 7.1), all QEMU AArch64 CPUs
> are initialised with gic_pribits=5 (one APR register), so NS
> priorities map to AP1R0 bits [16:31]. Blanket WI of the entire
> AP1R0 register prevents NS code from clearing its own NS active
> priority bits. Machines using hw_compat_7_0 (e.g. virt-7.0) still
> force pribits=8 via force-8-bit-prio and are therefore unaffected.
>
> A concrete consequence observed in virtualisation scenarios: when
> a guest VM acknowledges an SPI interrupt but does not perform EOI,
> is force-killed and restarted, the new guest's attempt to clear
> the residual active state by writing ICC_AP1R0_EL1=0 is silently
> ignored. The running priority (RPR) remains stuck at the old
> interrupt's priority, preventing all equal-or-lower priority
> interrupts (including timer interrupts) from being delivered, and
> hanging the guest.
>
> Fix this by computing the exact Secure/NS boundary within the APR
> bank based on prebits. For registers entirely in the Secure range,
> keep the WI behaviour. For the register that straddles the
> boundary, preserve only the Secure bits while allowing NS bits to
> be modified. For registers entirely in the NS range, allow full
> write access.
>
> The new logic produces identical behaviour to the old code when
> prebits=7, preserving existing behaviour for machines that use
> force-8-bit-prio.
>
> Fixes: 39f29e599355 ("hw/intc/arm_gicv3: Use correct number of priority bits for the CPU")
> Signed-off-by: liugan1 <liugan1@lixiang.com>

Whoops, yes; thanks for the bug fix.

Applied to target-arm.next, thanks.

-- PMM

