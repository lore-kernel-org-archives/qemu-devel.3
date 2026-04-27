Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9BFFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHJRM-0005H5-UC; Mon, 27 Apr 2026 06:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHJQu-0005Fr-OY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:43:22 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHJQs-0001E7-GV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:43:20 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65492d097acso3226792d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286597; cv=none;
 d=google.com; s=arc-20240605;
 b=aRXp3gSy29AUq6ekwdSA755iHeBjmbk/+H8YxHiRj+I3P6CbazvQqPCi5SA7zo91O/
 AFo4daw69nnTj+woocux3texclnQ4dpzBVY/loHTB+iY2D/ci6BP89JdTSpBu6zFtyzK
 4c1R5MHOVBmGtJCI3cH0D/fgDAC95ULE7ydJxN5FrjKYEHQsFziQ+zC0NDSJcamTpbCJ
 mpW0AMi/J0/AmpKDewdTMoRzKDIXp2ToozJk6Kw6TmqJOfBNe0DhlkJR4DeMFGZ+cdeK
 DaweB+DiCLSRCLrFnfOwsZny1+pY7Jzojhtx+DzozEQKfOBUIgG+fhkDSJ4/vrKHu0kB
 wa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SA/p4WJP2E2300b7hYm1QwSr22CaEwN4z32UNz+3FuI=;
 fh=OstSsYwxAu9sBNzLPYugHzyuNcGEA3i36exBIKVuL6A=;
 b=aIk5qG5PQowSiwJr+k688kNWwL717QIbaskn7yxbs3/BBj+bkJYEP+JmKyLUchzHTb
 svTjkdYVZtsNH1mxmb10gOQWNBXC+3rIEUm5PIugjb/z15+4VYk7X5itRXYafvl/MRwB
 3naD98jVpVcd4c5epZuilrChCOQZtB1wslRtSgQnWnodDYJAYwinGFl0u5bO44GPZf2l
 kONFbl/rUrCVVNGaqnBIebnxE59AJc/zyeYrQG0Qag5D90F7xMcwbL4AjAlrvb75s2nu
 C+FCjizMK//He8RUaKhvPR+OV/Gg27ZW7jTuCl7EvAT4KE7/RoFrwyid4dKTarJOIVUe
 CVbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777286597; x=1777891397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SA/p4WJP2E2300b7hYm1QwSr22CaEwN4z32UNz+3FuI=;
 b=qyj01+xgyvj5GHd8g7jGKI8xh2D3I3zYhWQFjmq5s0ERXvbZvLUL6DnYPYhXAms9FY
 z3BNmIPYuuhYtFE8qXBU2ZRjyw8vKRWZX3SFmhgkQLF70uL3o9TIMCub+fQW6HNt84NR
 4OBgbHLtfM0+1+wGVYR/3fYGv9E0Sn5xVGe4fYipdfGyfDSuBEu7CzIr6K532nrUJVFD
 sxFdwmbEMgcCUzG70v8J9KWSmO/WdXUMmxr0Q7G2gnVrIQT1A060MVsEPlHuvumYwwUu
 XiqVljIBL+N14+fTq/BItp1JnQgjlFhuVvV5ai5n2GsqM5EEoFlJ7yuhpqnicwi9L6r4
 R+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777286597; x=1777891397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SA/p4WJP2E2300b7hYm1QwSr22CaEwN4z32UNz+3FuI=;
 b=n17BhzIx9sDD+j83DI3EHjmp/GcFJ3aXQUNHPCmm+FcKPXn40bs8GZpDHs27LBL2kF
 ALnAylykN1EuqQB7+3U3hlzZXl3zLLkJHkH8Ztr4qU7bi50SwzalCXj8LsGX2kBVAWGG
 emdqLEk2iimKy4UA+6l8MBffPwwWvLAlb2cBNI3eHbYnlAjZBPN5D/fSRtnwpwJL0QE+
 ATaf/HIrzKCHh/6G8bZrgNT5Jg4FdAHzigJtHpYbLWJH5txFRbrtkIVRrUjjmubGfRtF
 ggIb8AqGhrOM/mz8PSAV+YLz6ZnJq/PTFzV3pcDCmhO/bz4dNqJnYPrc838/2JV+UVha
 drgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JECL1+nhY5nKK/OlJ6uzDRB97MyFE7AaHV8okicXfwS1A1fSwz6k1yzSWQGH+gL5PifhSBNOr4PVj@nongnu.org
X-Gm-Message-State: AOJu0YztsaA9uhL6L0wbNmh2ugI1Gsgf5AaHvcklCRxN3sd8jocqW2FV
 wWkr6lpLfjn1I7sgCkg3jq8n7JomHE4K6OXAY6O5FjNMsMGt2bf9ayEL1j/ldlla+NJUMEBUZN+
 pwR3+GcLDpVO1oyiZQcSp5Im7FDXFO3q6U42bMbUqJw==
X-Gm-Gg: AeBDieuM+7quvIdOGqLxJF7YjMVvhTfbUeWvM7Bewu5l0uTNt2cDGwAwkbIaXDfM0Xd
 daRpv3ZrHY2qxdg5ChX5nl6a1lGzbVszme0szY/5a+6CrMNfSvXvmDNXHWSiM3S1l7a89xTR1XC
 /EAgmYlOwWzk48Q2ybq7PfWUxrul1lZ0ueimnXQD5LBEXRxebLpViCkUAcK8xIddKvb8VgIO/pE
 si94VMVnCsSztjvNRapOntCs8hqtWUI0VtTiXWI1skO352t204boaNSjP9z5SnSwAQBxngD97Xp
 Ji+qj4tyN+AtYBT9kpnXFCBHUgkVqRpj+YO0oEj45FDlZ/xPYzceWGIiRDfYar3Q9l2OhqHosG2
 WIA==
X-Received: by 2002:a05:690e:2501:20b0:650:849:db44 with SMTP id
 956f58d0204a3-65310a13c3emr28702564d50.38.1777286597272; Mon, 27 Apr 2026
 03:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260412110240.93116-1-yangyanglan718@gmail.com>
In-Reply-To: <20260412110240.93116-1-yangyanglan718@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 11:43:03 +0100
X-Gm-Features: AQROBzBLkDZMWh4beHsvpnVOqjj5HKT85qoUTmyXv7wJ7j_18ZlP1SkhXct8gFY
Message-ID: <CAFEAcA-6+Qekb--xqCa49yNtkKAgkLnWLf=Q+Bf5WER9cOxmeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] i.MX6UL LCDIF device model and SoC wiring
To: Yucai Liu <yangyanglan718@gmail.com>
Cc: pbonzini@redhat.com, jcd@tribudubois.net, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 12 Apr 2026 at 12:02, Yucai Liu <yangyanglan718@gmail.com> wrote:
>
> From: Yucai Liu <1486344514@qq.com>
>
> This series adds a basic i.MX6UL LCDIF device model under hw/display
> and wires it into the i.MX6UL SoC.
>
> Changes in v3:
> - merge the previous "build symbol" patch into the device patch
> - drop the unrelated hw/arm/meson.build line-wrap-only change
> - fix commit message formatting (use real newlines)
> - use 16 KiB for the LCDIF MMIO region size in both device and SoC map
> - rework register indexing/storage to match 0x10-spaced register layout
> - apply SET/CLR/TOG semantics only to registers that have those aliases
> - set CTRL1 reset value to 0x000f0000
> - remove redundant 32bpp host-surface check
> - move realize-time cleanup to unrealize
>
> Yucai Liu (2):
>   hw/display: Add i.MX6UL LCDIF device model
>   hw/arm/fsl-imx6ul: Wire in the LCDIF device model



Applied to target-arm.next, thanks.

-- PMM

