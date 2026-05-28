Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E9CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZzw-0003GL-Uh; Thu, 28 May 2026 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZzu-0003FA-QE
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:38:02 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZzt-0004mE-9x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:38:02 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-660463977b1so317225d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971880; cv=none;
 d=google.com; s=arc-20240605;
 b=T+HUbIiAfHE6BexQWT7UAjpBHw4KvQT94tvSAB2RAgKWzm1jy6b+mVFYN3e2CwbljP
 pmPotBOg3OMkF/XOi66naZuE9+JjkmexX7LTdAaleX3slqmtMLCtGRe7cBkntxXvn0hb
 dM9wKqagPJodaPL5f3gjr/JRn+zHFtAdtzYvy4PT7LxN290wREGA2CqO+fvcplcFwiy1
 cEZRxEuJRkLr69ZLL94hSZgBli5vCmnLS4kVozQAyymlz/dGyAY1mMjsm//KDtfFcTXS
 5kPEGGTDNWISx9DJizZj75yDYMXzDOmOk90af41xji6Jd48ePovonyF6o+TEyTcA8tOS
 f+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V7HSQI3HABfV3lbYNyFf8La0erSfo+jTRHzPAU5T7YY=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=en0bw2HQEQnnp/RCYxp8LS7XmVct8GAMrdBcUjOxbHsfmpczur8DgcXWsjArCcS+ci
 TvrAOp6xUv8uzOh5PWa6sbFrKS1j3WHvz2EQaaKq3T7DvjEk046i4YWnDVOiNKMZmXWB
 j/FZktgMUTDF7M8ERQJvWYSHBK2ObnkcKC+jQlNWOIConQrG5PUqf/BwdVKeOPBeGBIv
 Npz/WzencldRCxmeq9Tfy1Jv8KNEvSP+WYDCtTEZ2GkovX7JnoleyuVhprul6zpHzahf
 vnIZANkLqPdJ7N3u0KoDFEfITo1itQvQvjn2jcj0qx7zbSuvBQO5zmeYr9dzLe4T3kId
 5kHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779971880; x=1780576680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7HSQI3HABfV3lbYNyFf8La0erSfo+jTRHzPAU5T7YY=;
 b=IfXAv6I9Lt7ch83pW9ZXAJNEE1m6Sv7vqlS1g5Ek6rxtJggbSWSXU0RuOpsFfmZDW1
 EtwjhhRl93Wd9VEr8+re3maapf7sq/RvjemOKCwmZbb5mstNqyssFECx+dLJ/ghQjzZI
 a2URp9N7Th+vemB7YBZ1d/gDO6ftTnZMMKVJyry25fzuUuf0KYFIjrHQ+A4OXm5EyDpG
 UJduGrNgB+4oyn42tC9yixr5tKGKxuj9TzLnx91Ub+ORidKaPYB0oEhgBqRAUuBBrkaX
 JjQ/ybVG44JV0Q63NHK3sPvw6siQmF/LzMOKhgfhuECk8pHb6T9eGN/R2ENrJ2t1r+R1
 Xycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779971880; x=1780576680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V7HSQI3HABfV3lbYNyFf8La0erSfo+jTRHzPAU5T7YY=;
 b=J88T7WWCSPsS3I6hhzqAx2eo+p1xeYMHGXe5RbLD28HHVK7EUnIu+1FiHzEUa/uHxR
 /ldNBKIG1AQ0klm5raSuf2QjeA6kNGwqQZLt+LdDKso5t4GKWYHrY+/meJmpdbMTa3CX
 NtU6oxAk+QsWQU3er3JizdbIvSaa7pOcIcDRsb1UWY0h1+aLLD8oy0c98UCs+bTX5MNg
 0Nl1h89OvLVDjBCuPHGincWwjSsQOTimyExkntuFEjFdcmPFSupvUil7Gwfhh2zbdO1v
 1N2BtxL082rUzWisIxUPmFmVVpejTWrImZ80/HjF2Zt+dOlQPBQ1I5CQMUe+YitM+vXV
 s27Q==
X-Gm-Message-State: AOJu0YxAv//nGd2fGPHuh1zQXeH+fZttDI3+698qjptAMThmRT049H4y
 sdEWfr+YptBjRMaDYjFF4gvrdKfpaCF67X34f67NO9rJsBfVgvPH/sQXT6zmxAmeIGPK7QUCxyd
 xKZyD9XTb4wH6j1XAhzR7GmOcJEk85uLzf838tOBNvOIXnZgYR6Sk
X-Gm-Gg: Acq92OFLWy/QE5MIjTWkmhxNUtimFiZ+QwNV8xUPY3K8k9RQSSkHjJh/pgGA3oYhaLI
 q+13qIwiOn4Uv8I+EqvwzYjqsGz6QPE57cC9MsguDg1Y+zULZzhegHa1M0bOKjMO6fkYMAgcHBK
 Am2wnnr5hpIWctC0Mzy++N3ZSZQ3oY2mptuCubU8hZGzjv4q4NQNXV3BzICVAhGJr4k5tr3n86F
 5fjF9ugrMBoEwuROm5HWjJOY+BooPUD+ydcRcZEPj/tv4tAOIjwX4G5LB5BH5w3+1c6gxIfIimP
 KwD/enuSB0QlcjpZsWo+G4eeMu2jn8opnzcfUbITZx1XPQS4RpX06BYe5a8yq+reT5/U6Vzi92I
 Zv8gwmP07TPw2
X-Received: by 2002:a05:690e:4287:20b0:65d:bbff:41c6 with SMTP id
 956f58d0204a3-65ec97dc2cfmr21627007d50.24.1779971880065; Thu, 28 May 2026
 05:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-16-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-16-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:37:47 +0100
X-Gm-Features: AVHnY4LZLdcMhmAu_fnB0Enrx4F8ZLyE0sDMTo-42CjgXrnIz1peAo8r17Pwcpg
Message-ID: <CAFEAcA_JWn8SDKVgca_o59dfxSfqu8vtAA_XFb3Ew+pb+_HW=Q@mail.gmail.com>
Subject: Re: [PATCH v7 15/16] hw/arm: Add new machine based on xilinx-zynq-a9
 for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Introduce a new machine type 'beckhoff-cx7200' that inherits from the
> xilinx-zynq-a9 machine. The CX7200 is an industrial PC based on the
> Xilinx Zynq-7000 SoC.
> The machine preserves all standard Zynq features (boot-mode selection,
> SPI, UART, Ethernet, etc.) while adding CX7200-specific hardware
> components.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

> diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
> new file mode 100644
> index 0000000000..6e27515886
> --- /dev/null
> +++ b/hw/arm/beckhoff_CX7200.c
> @@ -0,0 +1,80 @@
> +

Stray blank line at top of file.

> +/*
> + * Modified Xilinx Zynq Baseboard System emulation for Beckhoff CX7200.
> + *
> + * Copyright (c) 2026 Beckhoff Automation GmbH & Co. KG
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

