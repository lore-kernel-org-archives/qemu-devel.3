Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517E1C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3V44-0004Xt-RK; Mon, 07 Sep 2026 04:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3V43-0004Ws-DT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:50:55 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3V32-0004iI-Ny
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:50:55 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-861145fc841so26657337b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 01:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788770991; cv=none;
 d=google.com; s=arc-20260327;
 b=N1LX/w78pWldFM1wvL7LMQyiwTxAdNaqF4ksl7SobOtUml8446cEfiUqLp6yswJtFi
 7Iy7BOQf37AGkMn5Ifyuu7AroUJufX58dIrIlgFHCpKNfVevFBfO2HGFxW6X5ksyGovz
 BYQ5ieki7YVjouEbxc4/5Wf/PW59sttVYvBGLzSUXHa3Jhu1PPvcJJJPB+LMNlrys6oL
 Q486+icHrVOaNzEPh9I1MxYh7izpTV0ISLMc144hcTyqlKtk1eEWvh9bczztvt6Qw58B
 vrk/aJyu49lWlYJrm4tAHxCzP5biMx2n5yiFMAg+D8x/xwoFpfd2CVu61Q1snTMRb9aW
 wg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qW4G7OEwi0ISWEae7VLuLCQ+DDySvb+wENV6SUFyX20=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=c60EkKI1Xqa4KNAUZdH+73fSEymeKNRgN8KcVfAjfjDwB7qA+XpGVY/7xMhwBJlr5V
 /SSw/PiABhNZ3EFQ7JGFR2PjwSduNyirCL4KVGAwhgdaj/6y1HwVTz7hlBcXWDHUPIlf
 lSffx+JVsBZfYfYp+M9tOX5hERvk18Lvk5QdjXgrSJntVJTXlKzN1KNPXUgkWss21s6a
 MDinjgufnzsncGPR+84yb6ys64Tzm7l6Bqhzwnvcsd8xsGPQWxZGMim7ZY9fDYxWTsff
 33jItbIFwCJQLmJvl+YxmBbtjiGFE987H3AafFTTiIKEKbVTREpTyvBmQrfmNju5PSiU
 yz+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788770991; x=1789375791; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qW4G7OEwi0ISWEae7VLuLCQ+DDySvb+wENV6SUFyX20=;
 b=lguO7cGQ34YmrrYkuwfDZAmogGGeJy5b2peXwefEgQCbtvvxV5obiowqHzQOuPBG82
 Pzs9ReCJpe2CeixAwGR9TBQhw5+u7GNo/ezIYkj98kEU1BNCL/+tkL0sa5wnOvMsKbT+
 tfjJPK5mNkmkCgUdBXKFFBg1Jr9lEdpDvZo3nao54CIChRYZ2z57b3rN4PKY1xJqf80B
 GgMDDJ0fcsm+wHUOqVGN7WFcgtlh5GUBiycDszpWeUzMYe2Irf5MDROnjmvhrbFCDV1/
 mB50OrbvzXrxq+oRbJjJuRlFQnA+UAXmdjP2hHRPQrZRNUSy06I6C4UabkSgxTYtXMgm
 6bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788770991; x=1789375791;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qW4G7OEwi0ISWEae7VLuLCQ+DDySvb+wENV6SUFyX20=;
 b=m1py9iqrLIJQ59AbYjjEgPhSH9WEI7Sh8BYefav1HGLaHxqw4rak1ksh5Frfik5kng
 mAUT8vWXCpJf3MKkL2vzacqYgxymyjCoNaIQgRlGPsovwZ8MDm3aETcoxbzmIQb6NJav
 8CGP5Pq4FXWB0nsLT/tRKg0j7QgAYydFZSQEtAfzfO3fRa0Vi97JZz0tBXoKgtfXpQCF
 7Ez/5mZZC10bxKxalMwnM0LScgHBCN63VtdeWugZ/rgnqtWEDFEQ945NNLRXYwt/r2WV
 8/J/s6iqcNvMDrEWUcgAoMyaRI3So92pgPDzNBXgt8J0clcgUwy6OD7uTMupQbMTkYGR
 QBsw==
X-Gm-Message-State: AFuF++neeKJIwzrF+mbGs6QEiOmGOTt2ZhcKrJPTYrAogjILaRiKSTyf
 HrlqmoKCHIDx5EcpcH+Ct5yfpVBoCVovjwqD1ox8+RFCzUyGpjFo4wmwhGXX4LHnOPHJpQgcZ8d
 ryq3E3HDc1YMy7sRGXHycsBTfNK+lRTx4/umHniafqg==
X-Gm-Gg: AYBFou23KhO2QEmQA20HgKK/CiDA7gG3lfztdm/82TYIzxtbXY9RF0I8OjraOtfSWM1
 QqHkNpG1JVuBYHq3pceb0xY4SGfuIIiSvmY3ooruJKOeXIWSWYvPwknTlVIrY97SVY+73mblk0x
 uSbFfaTxe5DzMMaBUP0GPjLjK5j6eIveKSk0RqzSD1ZihxUZJVq6pADo09Vh8JpVe0MfiXmpWi7
 iyfIQdCZMRdIX7wpPZru+mama6EyNIMxiMwjSlt43RBQyJBDwuzM58hLvhHrPpg5GMmPG/NIijk
 w672Aid4W2Z5uD5AR4MTNf/oTJxLjp2ukZ6sAcbRj3XjaAlYP9+F2gZ51MISPifnhRW0sbW5PDU
 eCu7YyLulwz2/AB+SjUeR9VFApbTv
X-Received: by 2002:a05:690c:660a:b0:872:1e2e:b496 with SMTP id
 00721157ae682-8721e2ebdf3mr75090757b3.31.1788770991069; Mon, 07 Sep 2026
 01:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-2-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260906194438.93046-2-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 09:49:38 +0100
X-Gm-Features: AcwNN1X__Gm-NYND6TgbCBNpyxoWi1198oqq5VpBKzlteElhAVqXnlTLFf3GIB8
Message-ID: <CAFEAcA8PROO7xjG8DmqHxPXrPRjx_bHddPARyuFGejE9miOqqA@mail.gmail.com>
Subject: Re: [PATCH v3 01/36] target/arm: enforce Armv6-M NVIC limits
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 6 Sept 2026 at 20:44, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Armv6-M supports no more than 32 external interrupts. Its ICTR and Active
> Bit Register locations are reserved, and Cortex-M0 implements two priority
> bits.
>
> Reject Armv6-M NVIC configurations with more than 32 external interrupts.
> Add a check-tcg test that verifies the reserved register behavior and
> priority masking on the microbit machine.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  hw/intc/armv7m_nvic.c                   |  7 +++
>  tests/tcg/arm/system/meson.build        |  6 +++
>  tests/tcg/arm/system/test-armv6m-nvic.S | 70 +++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index a7651f831e..c1ceb7450f 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -2728,6 +2728,13 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7) &&
> +        !arm_feature(&s->cpu->env, ARM_FEATURE_V8) &&

You don't need to check ARM_FEATURE_V8 here, because setting
ARM_FEATURE_V7 always implies V8.

> +        s->num_irq > 32) {
> +        error_setg(errp, "Armv6-M NVIC cannot exceed 32 external IRQs");
> +        return;
> +    }

-- PMM

