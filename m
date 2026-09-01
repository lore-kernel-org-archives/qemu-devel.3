Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33490C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TFQ-0006nn-IO; Tue, 01 Sep 2026 14:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TFP-0006nS-FD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:30:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TFN-00049d-It
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:30:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso678585e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788287412; x=1788892212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KfjqZhErL/EdtsvfbBVory2WLrTqH+TJKNOungvW8G4=;
 b=l0uwl6zeLfG416z6NvJnc083lKKyTTXdqqMzMaXyA3AoGjw4vYJz8jdVu/26kgiCu1
 sDsYTDFzH4McuQq7AiSYlmEE9msstzaAk08BGkTxHTKPlI6EBF8Byen731eB0fh/zKdm
 ubQP+Ui4LFOKMz8+rsMMHar8TAWe2NOgfx5O8daQsvO018hsX3ij6X7F9hZfRNlRygTB
 9Fa1oS0xWT2KRkRmmJ4/rLQIB1u+gvZdZ5dkoEInhl/FinWiAWHEDpw2zAfpkU01+vTt
 H2P7aGvm3KBQRWLc+8WUDqRvlU7IBQaVo7oAtwCeRhbijVxoAfo1+bZt38eRGKqFRBeT
 8YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287412; x=1788892212;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KfjqZhErL/EdtsvfbBVory2WLrTqH+TJKNOungvW8G4=;
 b=IC09xPp7e2Wnb/ciG0ljwTkV4B0mxxnUF151W21250Sonj8j7jj73CN+yyY+1REaKw
 qpG6AoRgbowruozuz4syL+Fbos50neCDXl7YMl+fdQ9LAon7ieY1pkG1ZmQk4vTtDfsF
 tmJFkh6sP6/AZH4fAh/Xsld1CvX5CUkqBn8C92jQvjc3kLA2K9KrMdDFAKWTpY666v8J
 JsF2IzrSTnQez019rqP1p0cnOXsAtJeOYEeXghNZNGT+ZG6v56R75wDOs2oVe71z/iEX
 LXHMcKPFLNFzPMq0oRO9K3XEwTDnhIvb0wAKpa+zmQwOM1TWzCyvWD8pVprZjju+4Oo9
 UMkA==
X-Gm-Message-State: AFuF++nxKW1pZlban1ipXH7WaSJCk86uZjkno4t+Ll7Pv0QsjMjjkl9Y
 3NPOSglNGcZSQipbznlqfDZa64ZmERZY1zIJ42aX0PTuwhl19Wtd/sYOLJNKMrKgKYc=
X-Gm-Gg: AR+sD13yX5TRwR1Utckp0qef7CVdshD6WmzxE6vlunyUfwKujH/EuFyxmb70ylJJJq9
 5EhnSi2OrAgfn4JlsSPu6NcKSPl57MgrOfuNUU2qHgZW5Rwf3wewlU7B2sl6aZepMt7niCCxCU+
 OcyBuTvmrQvelGJjUhKv9tHZUeQ07iff0cvdjK4+3C9H7y9JtLvT7VwR/yQ6BuZGc5SE4aQ9GmO
 lfV1U6OuLctGEw1p7Cq/p3+geotHIx+fRBZM2MEeC811idK7ouI08bTrQTNSqqBIMxSlX6ilahq
 K7OmM5SBwi0N4Q3kBRq+MdVIasm2UGoyCBaySVCpL8VdRCRGRKf29+zP2h0KG4+HnQo+KAwJU0e
 llC+dyFm6Tx4c5oHNwG77YbqIbTb3kJQLPGaXIzP1vg5j9/zJT97y8iu5epukKaUTxmJu2AsGKW
 6H6Ih6pzisZNNW/ZY+AygSjFI4e/FTr7tlFm/KwfN/VMM11UmOEWiVTNXVmNOd
X-Received: by 2002:a05:600c:3b20:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49b91bd78cdmr478656905e9.0.1788287411775; 
 Tue, 01 Sep 2026 11:30:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm690916f8f.18.2026.09.01.11.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:30:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED85A5F829;
 Tue, 01 Sep 2026 19:30:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v2 03/30] hw/misc: add RP2040 diagnostic helpers
In-Reply-To: <20260829234308.33725-4-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:37 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-4-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 19:30:09 +0100
Message-ID: <87qzjcu8ni.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Add shared helpers for reporting unimplemented RP2040 features and regist=
er accesses. Keeping the formatting in one place makes shallow peripheral m=
odels explicit and gives their diagnostics a consistent component, address,=
 offset and value format.
>
> Add a dedicated Kconfig symbol so the helpers remain disabled until
> selected by the RP2040 SoC.

This seems over-engineered. What is wrong with:

  qemu_log_mask(LOG_UNIMP, "%s: ....", __func__, ...);

In the various call sites. Most of the funcs seem to be prefixed anyway.

In the meantime you can instantiate TYPE_UNIMPLEMENTED_DEVICE for any
memory regions you have no implementation for.

>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  MAINTAINERS                  |  7 ++++++
>  hw/misc/Kconfig              |  3 +++
>  hw/misc/meson.build          |  1 +
>  hw/misc/rp2040_nyi.c         | 47 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/rp2040_nyi.h | 19 +++++++++++++++
>  5 files changed, 77 insertions(+)
>  create mode 100644 hw/misc/rp2040_nyi.c
>  create mode 100644 include/hw/misc/rp2040_nyi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55f6f2e3c0..db641d9c4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1035,6 +1035,13 @@ F: docs/system/arm/raspi.rst
>  F: tests/functional/arm/test_raspi2.py
>  F: tests/functional/aarch64/test_raspi*.py
>=20=20
> +Raspberry Pi Pico / RP2040
> +M: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/rp2040*
> +F: include/hw/*/rp2040*
> +
>  Real View
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 46e3c03cc8..de7a0f56fa 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -101,6 +101,9 @@ config FSL_IMX8MP_ANALOG
>  config FSL_IMX8MP_CCM
>      bool
>=20=20
> +config RP2040_NYI
> +    bool
> +
>  config STM32_RCC
>      bool
>=20=20
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 54e07aacda..8611d59437 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_cprman.c',
>    'bcm2835_powermgt.c',
>  ))
> +system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
>  system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-d=
drc.c'))
> diff --git a/hw/misc/rp2040_nyi.c b/hw/misc/rp2040_nyi.c
> new file mode 100644
> index 0000000000..7e9e4c09a1
> --- /dev/null
> +++ b/hw/misc/rp2040_nyi.c
> @@ -0,0 +1,47 @@
> +/*
> + * RP2040 "not yet implemented" diagnostics
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/rp2040_nyi.h"
> +#include "qemu/log.h"
> +
> +void rp2040_log_nyi(const char *component, const char *feature,
> +                    const char *detail)
> +{
> +    if (g_str_has_prefix(component, "rp2040.")) {
> +        component +=3D strlen("rp2040.");
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "Not yet implemented: rp2040.%s: %s%s%s\n",
> +                  component, feature, detail ? ": " : "",
> +                  detail ? detail : "");
> +}
> +
> +void rp2040_log_unimplemented_read(const char *component, unsigned size,
> +                                   uint64_t addr, uint64_t offset,
> +                                   uint64_t value)
> +{
> +    char detail[128];
> +
> +    snprintf(detail, sizeof(detail),
> +             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
> +             " -> 0x%0*" PRIx64,
> +             size, addr, offset, size << 1, value);
> +    rp2040_log_nyi(component, "unimplemented read", detail);
> +}
> +
> +void rp2040_log_unimplemented_write(const char *component, unsigned size,
> +                                    uint64_t addr, uint64_t offset,
> +                                    uint64_t value)
> +{
> +    char detail[128];
> +
> +    snprintf(detail, sizeof(detail),
> +             "size %u, addr 0x%08" PRIx64 ", offset 0x%04" PRIx64
> +             ", value 0x%0*" PRIx64,
> +             size, addr, offset, size << 1, value);
> +    rp2040_log_nyi(component, "unimplemented write", detail);
> +}
> diff --git a/include/hw/misc/rp2040_nyi.h b/include/hw/misc/rp2040_nyi.h
> new file mode 100644
> index 0000000000..c23805973b
> --- /dev/null
> +++ b/include/hw/misc/rp2040_nyi.h
> @@ -0,0 +1,19 @@
> +/*
> + * RP2040 "not yet implemented" diagnostics
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_RP2040_NYI_H
> +#define HW_MISC_RP2040_NYI_H
> +
> +void rp2040_log_nyi(const char *component, const char *feature,
> +                    const char *detail);
> +void rp2040_log_unimplemented_read(const char *component, unsigned size,
> +                                   uint64_t addr, uint64_t offset,
> +                                   uint64_t value);
> +void rp2040_log_unimplemented_write(const char *component, unsigned size,
> +                                    uint64_t addr, uint64_t offset,
> +                                    uint64_t value);
> +
> +#endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

