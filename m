Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72720CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclVf-0000f5-HI; Thu, 25 Jun 2026 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclVd-0000eH-GS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:56:53 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclVc-0003F9-4a
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:56:53 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664801de06aso1404499d50.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399411; cv=none;
 d=google.com; s=arc-20260327;
 b=SOA2km1kF5vTrsqehrDvSXiKPHcBggTmedfXty1j9HEhxB3Av8GMQASaEhJGbginnc
 /fAd7Ih0iwqUIyjATLBwCShVNk5b69bvY6gvlFY6iCOVgTJGNWJ7CSOyyGSYIHGnvKG8
 dWttcDBx/QE/DDFCCJH5HffZ8YYa4m0nOb+wu4B2F51SKV7Df5ePKWkGwvgUsWnuwYDM
 WqV5gx3Xu4ipZLsEj1vhhycp7nkA7tdJYbTn4Tv9gowuU8J/q+tmT5LoKvsUW1Z2Gc3i
 rvM9fbojYbR/ol7GD/N5tLNi90OWFLnQdlwSWZYhM9xtVk2qRcjAmsivvrz+makIdLf0
 ZY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i/zCXl+P6RPAZgR9hjF7z+0cuHq30SL+nR/NueNuT6E=;
 fh=Y/+yWNElImv7sjUmsr9J/66ymQrTph2UwmhC37llMDM=;
 b=OGrKQbr0aL2XCwreY40ThFsjPL0cjyLNcHbXCjrWZcXO3BiuKDENHTW0Gi3F4rwjsE
 zTvfu7ocvPq5UOrKk+ccKgJl/NlmSbM+VxermQSnz+304V0jMZAQmQo9cCwQeUXEov3I
 KusdpUhyK0ZlUngyOv9je6tGUAta4Ji0qB8o/Nw1Y4XK4gOL0kITCF2Sg2B0YzVxtUbX
 oCfm3JWNXH9YQd6LhfMgT9CT9qt766NfNSEIq6BBsKsZRCdcY5KPGjm8/iAgcW86JMIG
 Z8kKUQxf017w0rRI/AsNLJ7h6BtGukVY0narwHdumkiYgsltVxOthvu9XzvnlezRz+Vj
 uowQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399411; x=1783004211; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i/zCXl+P6RPAZgR9hjF7z+0cuHq30SL+nR/NueNuT6E=;
 b=pK/gQQN8fDxAhZyyPkVEF2JQboL2qad1F2wtlFq8STeoXW5FLOo7Pl1q9UWc/ziy2Z
 g0LGSrfZtheai5yGEhRUqwhDuTG3cQKIYxs+J1gV0CXAb+huKMs4hbNIToVIF0ag3TOp
 YJp9e51XQAgY/H84PE8n0NBGOnHz0nC/v0G/YQ21Rsi0siRPRAdtU8cstvgWNde6uveJ
 q4xsBBF+4UVVVdEuEQjCeH2WmH4FILNkW3MLPvHobOvmgU8JTTrQcWToZgFlZZz8TGgl
 PVYIFJsNt/joRK1dN10et8i7oVaJcczgmebR/ot5aG9qSkI+SLfKZSq64fy8r5AolbFO
 kOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399411; x=1783004211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/zCXl+P6RPAZgR9hjF7z+0cuHq30SL+nR/NueNuT6E=;
 b=PUS0HaD0FW2y1ary9a/KuHGWVadKLpiiCIaeN+iuC10/Aa0odQqkH2ylwIxytcINcM
 UiXBDH0EIhse2fo1Khl40fJnltz1uisLTYMh1gsd+YU7/5Yrrx81eQVl1wxaxs3uQgwy
 ntWlCB+WTB2u5vVB261AWB+yonTfgjnp3ZRbimZUme9/Fsytsrgv1wKsFP6UdrYg+wpN
 f+za7BBshECW/yJsiEnptjlvao+vkSaTxDU1Yt76o0mZx7Lsw4RT/sVJuIUnnsMgGy+U
 rg0OAFpj+ZuG/N46VMeAiGTChTTArmi/A9dFQ6WxGAdkheNSp1d1ipnZcrM8/r5uI19h
 38Bg==
X-Gm-Message-State: AOJu0YyPMAMtEppt385hmLpHJCXbiovHGzFCzM3f58OPCCoyvC3zCk3k
 vU8v5FIGYgHsQej2zDrv30vmyUxqonwpjzAx+wc7VBMbSANrscs2l0xCllW/9k6lCz5fubw2gLv
 V4IAhMIAcn4aOUXdYvP4H7unJhdwhP7ySZwpGftJRww==
X-Gm-Gg: AfdE7cllL5U6DGppE9Oq8DxFqfjiYOU4uh/o1lcd6aw9tIa3kY24fH10kT4NDxRf22U
 W9Xc4JhiDkaw40EWsN+11HXDiucRqVly2WI6eKxVskhAnARvyvv1eHpj5+jVH5fXlnw9sxqToGg
 tzj7GAK1pE+Oesj58T0I5GN26wOgOkifZ9EGqvyCnOF84DfiEldviGbZ3ykx0zASiSteM1r8ezi
 x5b7qWVNUl7DPicMOb7En+tc9WwGBeqj0daW4VlIms6ygnC3uOH6jvhY4Gb3L5Qon1t9tJVn2iw
 PGDD6/N5wNVQJ1BPmN1nXdGTyasdpN1fNSAr9AfHxQjPOnTuq08KB3+I
X-Received: by 2002:a05:690e:bc6:b0:662:cf48:c1b2 with SMTP id
 956f58d0204a3-66487dd13ccmr2185702d50.36.1782399410875; Thu, 25 Jun 2026
 07:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260623170354.43981-1-163wangjack@gmail.com>
 <20260623170354.43981-2-163wangjack@gmail.com>
In-Reply-To: <20260623170354.43981-2-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 15:56:39 +0100
X-Gm-Features: AVVi8Cf0SnjwXIQ1CTkOCAcv4qg3CRrPYKhZ3pvioTVadpdCugm7dlv0EnTdG9g
Message-ID: <CAFEAcA9fS9v-=BTSVM+BJg8V3hbFf7q9xaP3MMVFC04cFJ7HVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/misc/imx_ccm: Replace DPRINTF with trace events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 23 Jun 2026 at 18:04, jack wang <163wangjack@gmail.com> wrote:
>
> ---
>  hw/misc/imx_ccm.c    | 18 +++---------------
>  hw/misc/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 15 deletions(-)

>  uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
> @@ -37,7 +26,7 @@ uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
>          freq = klass->get_clock_frequency(dev, clock);
>      }
>
> -    DPRINTF("(clock = %d) = %u\n", clock, freq);
> +    trace_imx_ccm_get_clock_frequency(clock,freq);

Our coding style wants a space after this comma.
(Running your patches through scripts/checkpatch.pl can
catch this kind of style nit, though it sometimes has
false positives.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

