Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBAACD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXLm-0003u0-GP; Thu, 28 May 2026 05:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXLk-0003t9-89
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:48:24 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXLi-0002J8-M0
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:48:24 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65e15fb394bso8874262d50.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779961701; cv=none;
 d=google.com; s=arc-20240605;
 b=OpNSXWlj7OlC7YYLuxS/R7lYRNG3/v/sFIWF/3DD9vC+50t1SWSAEGlYQl9xdBjNS/
 8m8T470hRDpTtgIbC0Drzk3/Zt0VQmZJybRT3x4nao4oyk421/u7lhDDN8QTucOhF+oA
 JxfgoQjjVOViNOhuIXlaC0q7PwqveC2HhpzrVxKgjtPjSfygkdxC122G42VIVa50fOfJ
 eGgvNDHhMhLe/Z2EVvpK7nJXcw23XWt0j532zHgIvKmVb6Le/w6uVjNK2gVafEypxlOE
 QC/9ZKUVNmqcle9m7ES3Szp9P9t81DDunOz1PXipSZKyq+9Iuih1qyGQZKPfSzOhpRfc
 jKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1HU1zwMXbhz7xLkyYPPNmDVJLve1TXNd/hOzasB73pI=;
 fh=sSa3c9cclErlmicNGG47cYU+Hd/ho+zZMzQcLt7o4/w=;
 b=LMMwHyD7EWU0oaRCk0QxUyXdF5IoWhj8F/MOSQYllF0q+J3OTaCRFC6xE6J15wxvhg
 AShybzNwWbxwIu2edCV2bJ0+LbIkrwlQSlr42IlmU+91ugVu6MNhUnMQYyBg3ydDGwTi
 r6pDFLeIzMjtWYH39NE7ZQN0HvhB8S9LuTh5+SfpvKvzxHjZtvAMEf0efG/Uq3NBQguu
 gOG8HIOcrLN/CgImdBAfvi7GRSe72CWBGsnBTHJD/FKu2oKo/f6TCphhvfm7saRN+Po+
 edoCR1mNneAXvghhYnWA+jWlGsBl7I39ZHVdm9HjPxhrTsFZ6aNqqyH+89/QX8R+GQZR
 f6Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779961701; x=1780566501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HU1zwMXbhz7xLkyYPPNmDVJLve1TXNd/hOzasB73pI=;
 b=aUTaN1zBfRnuQ0YkzVi0qsu4yE0wcgds4CHfE6TEA1a1AV03l97knYUvCn/L7TJKEd
 Af1FLQQ9tVbqPZ1EfiR8dWZBPhstwvouWLPc1ZxuiGpZkWM1gFuAM6M07rjrqx/tBSRD
 50BkbcOzP5dIGjm1iyXI/t0uSxJkwJaXO51K2cfBJAif4Ac4JuIAj1uL6kwxm4BCpELH
 toJyraZx3Q1a9M1Y8QFISu+x5YvtqfNNzQobAJamlM5+hUkuS0jO/9J7pX8nncUlKiXO
 tvCObmsyrstdPeEgHwcDq7On6KUal1PcsHbU/QF2/xBDfA+PrqjJkrGj419Izvld/1ha
 heaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779961701; x=1780566501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HU1zwMXbhz7xLkyYPPNmDVJLve1TXNd/hOzasB73pI=;
 b=F5nZS9DDK2Io3iekyr/axF82enfbBqEq5xJJSTb6fa3A93CCCK/PriYuQx1kGtzqEs
 oB4lFZdSxX+WhBD7ncjhZfIcIvViKnLilDfOqfWsVy1HVXnf/vra9Aul95vV9NOSKT7I
 oNkyG8aZvYWkl7WtCjy7fYNTehCHVqM/mIe+wWErHKnDTEHpCV+3IUjRUlMqdcvj8ZNG
 WegMsQwzVPo+qh2Xqw0QX71dCrECe+9qi9vpSuhQnIohvJRITiQK4HYtTfijMvi2WS6F
 y1SokuetLFh9OQgufWBU3mqEXlM9NhhLWrxbd6GxL4S+8XNUL28PmlRbHrIgGRMmggAX
 v+fA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8t+IspOxBQkSevV+9XsuHWF8qCCM6kJ0l/F8wBD6dLGFU7pzix35QoDQnOUJLfuFxX2YhsRQlDbeJV@nongnu.org
X-Gm-Message-State: AOJu0Ywkh7ESJ41zvjTljouGjxCY5pVeNRxD1ao3yjkgBPXxI/S7fbde
 cTrAgl6qRuT0sW4YJ9LT7AzbbX3ijJExvJJmTSdeFIKJiidqulgPlnQIkfpTn7FqVnJ/4fQVvTm
 SvcExSRdj8besfFw4tPyRBPsXzV5RghrAnp0aksP5/g==
X-Gm-Gg: Acq92OFInPI3Q1Hbe7xhg+Jiyi5w/4bAfMGtYrehU8odhtf1GasCz9SD+xv17g7NCrN
 dmEoPAaDZ8x/p1UuKeUAqnHQCzZQ+3PI6h2C0CA3IsXb4VxlsFP62twH52AM3kz0DARZk93CNvP
 kJAVfOTqoJPm6Yp8b63tkODW04rwbiROBxzDJrqXdO5YlqO2pgV8c+XiAg+ZH/3H+1M8DTsIg7M
 +rrrJdaheWFmM6FYP5T9dxWkQAo/IBUQovwMEe2qYx3D+c1Zw5+5tPjKyizX4Uilt6MQTmcozDq
 xylyRTw6Cjg6SkJLmz3Zt8sIEk728iU32cvay1z0nGvwRUYClo5QMNgfl6ciRf0DmVpvXx4f3g1
 uDuIkoRD2wSQE
X-Received: by 2002:a05:690e:2513:20b0:65e:14b6:b1c5 with SMTP id
 956f58d0204a3-65ec9658015mr19963825d50.15.1779961701149; Thu, 28 May 2026
 02:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260524002617.69593-2-wrigjl@proton.me>
In-Reply-To: <20260524002617.69593-2-wrigjl@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 10:48:09 +0100
X-Gm-Features: AVHnY4Ljkn0384QaxK9BKn2PghL8VN6RXMmK2qNFWxSONSflpgjUiFaTXcwXR0I
Message-ID: <CAFEAcA9nqbCXxu6A1f6gbBjHWkP=P8a0WgMLTfAUxzqdNm_N9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
To: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sun, 24 May 2026 at 01:26, Jason Wright <wrigjl@proton.me> wrote:
>
> Add an .accessfn to the RNDR and RNDRRS system registers that traps
> reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
> Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
> the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
> shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
> check of arm_current_el().
>
> When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
> with SCR_EL3.TRNDR=0 should UNDEF rather than succeed; handle that case
> in access_rndr(). Register the rndr_reginfo CP reg entries whenever either
> FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even on a
> FEAT_RNG_TRAP-only CPU.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jason Wright <wrigjl@proton.me>

SCR_EL3.TRNDR = 1 also does one other thing: when it is set,
ID_AA64ISAR0_EL1.RNDR reads as 0b0001, regardless of whether
FEAT_RNG is implemented. (When TRNDR = 0, ID_AA64ISAR0_EL1.RNDR
reports the presence or absence of FEAT_RNG as usual.)

It looks like this patch has missed that bit. We need to give
that ID register a readfn so it can at runtime report the
different value if necessary, similar to what we do with
id_aa64pfr0_read().

thanks
-- PMM

