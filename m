Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B141CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 17:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umyVU-0007v8-Dn; Fri, 15 Aug 2025 13:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyVS-0007ui-7f
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:46:22 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyVQ-0004UP-NT
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:46:21 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e931c866031so2272368276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755279979; x=1755884779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c0OAUuDxPH4t0qR8Ah82zH2za1yyknDhnYxTZY6+ByU=;
 b=pjrVFn+AAEg7OqO1oFX/faQJAhVuKq9o6o/ZR9BXaNJayzV2IUjNTCp2TdwcEYYlGT
 IUBg6sKp0cQifkWQ9zwNeIGHiOJcY3PNvQcLwkQlVE2hB92fhib2B7htUio/bz0SBrKj
 8PdLOniNfMcJXk4UMBkf3HGaZqpEJ7K8WoLbJoZDhjF+/TOsLNO/EqcJWBQ1HF8o/siY
 I9QdMzRk5y5sBYJugY79JIZt4RKva7Xl5/IEQaljO6Q+vaYp+b2wi8z/cPIlmGkZW8Ft
 1evZl/PUlw7e+YN4LKfTPI9Is4faSj09yDRvP8+Af9Ubowfb3uWxhAag4Whkjpawn8vI
 aqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755279979; x=1755884779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c0OAUuDxPH4t0qR8Ah82zH2za1yyknDhnYxTZY6+ByU=;
 b=ipqoSS8mvy6b1bExvyYVpsTQj31Or+X04yvEWYn6Eo5in3HUuKPAz07T4M8E5e1+Nq
 4EsF3yuN1+OfAX12WtpuYgXLtIhpcvVJ/F1ZhX7JyJFZoiDoa0Z/5BOaDmaFoSFqpc0l
 KUbI427de/pbLVIl0/i28mH6oiKhkdHqeDOyErMIqa9bVsMmA2dQ70MNzBqaiU5PyuGU
 tpe24IIO5C1rO8htxWPEMJQosBFdVlU7Wu9BTIRms2resXhkj0SamEkNlc9jf/W/od26
 FeEdWoQ4IrI4SsD5+5yTDJtJUI5Nw8+Yfs6+zI868bYcdF4LLL/2Oteg20olAGCsGr3J
 6RRg==
X-Gm-Message-State: AOJu0Yw/Z25nRwo4v7oeklbXynrlHeHMjJJU9AxdvGeDehG6ugOCEorZ
 NDPGDkcN5jjpsAhGjeHYTteQiFhplPm2kDLgU6JPj4aQl9gTIOjgDMz25ZmPnASrp6C0pdCcN7U
 DaA8a7Tl8AeOamKY63Y5Qn+46H5NBrd7EdWtKuIHiCGMqo/KLEepW
X-Gm-Gg: ASbGncudg4mJzH1iw32b5mg2/q62JW1PwIStWpqJgJ6bIRsZNRqahSwzdI/qbofms/r
 RbJ4lDYpdNkU6n33hplUlRpGXDzOPm5IidavQ23Ht7Pno6HGZzD+yNzicY1QJ00LhemUP/bZ0F2
 tUpPHprBeLvUY6DdjRlcKLreD6aJU1mhqw0nM2S/QBs2lW+qcRZ9iujErzLRNzFIVc85zCyIHkl
 GyXomvl
X-Google-Smtp-Source: AGHT+IE1n0iaqgI/LgKD1cC8BTk9wxxOa0RRgbpxojJ51e6+TcUdXYdFO/v1RiIasF6I33MnkBYPSVFZlQFl/T1bkpk=
X-Received: by 2002:a05:6902:6006:b0:e8d:7b84:cb46 with SMTP id
 3f1490d57ef6-e93324a0758mr3559892276.32.1755279978864; Fri, 15 Aug 2025
 10:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
 <20250721201134.13270-4-fanyihao@rt-thread.org>
In-Reply-To: <20250721201134.13270-4-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 18:46:06 +0100
X-Gm-Features: Ac12FXxFHdUVPitcGHoqof8MxPArvutbVzl9jyo_PvMEABN1ZKe6JlCIcbNJZfE
Message-ID: <CAFEAcA82eVxnvGomgzSegXBBqcc3_wtPQhV3b4cLcxikfTK13w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Add STM32F4xx USART device model
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Mon, 21 Jul 2025 at 21:11, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch adds support for the STM32F407 USART controllers device model.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
> ---
>  MAINTAINERS                       |   2 +
>  hw/arm/Kconfig                    |   1 +
>  hw/arm/stm32f407_soc.c            |  25 +++
>  hw/char/Kconfig                   |   3 +
>  hw/char/meson.build               |   1 +
>  hw/char/stm32f4xx_usart.c         | 236 ++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f407_soc.h    |   8 +
>  include/hw/char/stm32f4xx_usart.h |  60 ++++++++

We generally prefer two separate patches for this:
(1) implementation of the new device
(2) add the new device to the SoC

> --- /dev/null
> +++ b/hw/char/stm32f4xx_usart.c
> @@ -0,0 +1,236 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +#include "hw/char/stm32f4xx_usart.h"
> +#include "qemu/log.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "qemu/module.h"

This looks very similar to the existing stm32f2xx USART.
How different are these two devices? Could we share
code by having them be two child classes which adjust
what features the device exposes?

thanks
- PMM

