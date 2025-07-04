Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C08C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhTg-0001LA-80; Fri, 04 Jul 2025 10:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhO1-0008QR-3l
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:27:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhNy-0000iI-Jz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:27:32 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e4043c5b7so8331627b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639249; x=1752244049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvElrBv4S3LZZQGTL4BtOGuUOsWbtLOuW+muuK2sDsE=;
 b=OMWIllw7pCm8DxtgTx8ujpD3KwcPH+00H/YjCkzC/pVSaSf71UEg2SMiUt+9ap071L
 JQY3aFB4JEU7UoGAkZUXP+Iw/oksmoWcL50ct34sd75NBTXEMUj3TdgHHFY1IdeSyapO
 EAwHPfbGnT9+YjUXpM2hR3Sdm93fHlK6aMJBraf2IgoPJ0S4G3mSCTCUBU49fMTJJprQ
 mitZXYJ9z7Is/YV6ksHGmDrfkW1wj20NCvNMeFr6jozxg5YToFN0L52GTlN5mibxq7Yn
 YdReXBxVIcCuTqmVBDQ/E0F6vi6M85JXZnI6EvARCzfWs0j8L1QksIR0M6Gw3lNhcxF1
 qCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639249; x=1752244049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvElrBv4S3LZZQGTL4BtOGuUOsWbtLOuW+muuK2sDsE=;
 b=MD9SZjHrDprnMg1Ob6LitYl/Z/b1LjEiQRq21mqvbdvbOE2E1WxsyDafMimbnY187f
 SJg6n+gXGLO7R+a8IYArt/Xx1UroqOlEgZBNMHdGyZQmP0S+cygCJ6DZoGkApQO8a54n
 XYnqpXVK7d/XKYVRif5YrRFULVCZ+gaP7WXP0NPsJ7VcRYdFvw2Pcz/xH8ZQgYv2/and
 Okc5Scrb2BjEQgnUS6Uzb571sUBDp5no++so+FOF5PzC5Mc7QSLTpG3JmDSoiAEMq23F
 XJWIX7PTMtmk/PKqo/OXMhFanBZ284fg9f8NNIvQH/zXu50YCDAuOBOQuJO2jy9kO5pI
 FpJg==
X-Gm-Message-State: AOJu0YwiRdTIZqe30zaaPJH8V6zilJN1iY2eLB+0f2Or8SvLIy7TlkVS
 dB5b4NaA8HCgK3dFF2+pUaSndSbSp6q8ffGTcRTYv2TtjkhkEnQ4DioqJG+rrWhgQuXMZgYTAct
 WyMxGyVESNOlS3+SsVRfWl0Ct5V6j4IsX5lSFgDf1kJHWQjqaSgik
X-Gm-Gg: ASbGncsVHdKE5hUner3ynBMKZ36BLI2KM+mB8M3azwWQE7HFvq7GN3tIEooPtIcJCGv
 N72MLs85CIr/1P2x4lRApUUa8mZoCL3D6KVOzDa0ZSSIVjyTDX5tRyYe7yP8OiMQ72LvcmcQSx/
 9Eh7OgApKEvfQxh50ZZDie6SLDm1hjDB8lhy0KbJTHvLYl
X-Google-Smtp-Source: AGHT+IEQm77Yx5nHVd/XqlTota9iUrZblgHmEMAX2IkhyvcrcAQ4bPWBScOQNMWYKfrM/23ZUK/wuXw5wl6Dwzu3q8U=
X-Received: by 2002:a05:690c:6611:b0:714:349:583d with SMTP id
 00721157ae682-7166b5db42emr24805037b3.8.1751639249247; Fri, 04 Jul 2025
 07:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-60-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:27:17 +0100
X-Gm-Features: Ac12FXzRGJNlPmPLQGfHEoj7p8j-oGJHSalPxr_BfdCdxktt_0Jn0hDwKX0HzfY
Message-ID: <CAFEAcA9SBty4fj+gY7XaULs+kRHm2VVkFpAPkYt31+gPJ8ophw@mail.gmail.com>
Subject: Re: [PATCH v4 059/108] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  20 ++++++
>  target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c |  35 ++++++++++
>  target/arm/tcg/sme.decode      |  22 +++++++
>  4 files changed, 193 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

