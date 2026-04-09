Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F277F364BD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAwUa-0003hv-Rf; Thu, 09 Apr 2026 17:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwUZ-0003h0-3F
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAwUW-0003ov-VO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so14435025e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775768443; x=1776373243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xtdJaWoXSge7ijuVyU6eWPI/LUrb/2r/ZVbci45zRak=;
 b=jnlrsQm5i2ahiSpLxMnb4s+l3L0nOCNio9LnNwPacEDnBw+2K6zHBZszr0/FF3zY3F
 C7F0LS/N128qnnm0x4UIvmHIUeImzu/xk4+nD7Hh9BZN9/yqkMhRCqiE+UynkexUSrXk
 lT4ulnz4xAmk9ttqIcETy1V+D3Ea2Gs4pnbHsuaWw+8M77phl6MLV+Dx44xO8aHyJAda
 SR/qRLQV/SnWDw+ea6OapSNo2ESIaI57muo9S2ozFc4XUnx1OmJ/DgXuo0NwEC52DcYF
 4fJt/bvyx8+SH+F87YeYnQVfZZuj8C0brsMGP+z+6kwRIoFuJFsCbmErhMbpsxAeyCTf
 20cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775768443; x=1776373243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtdJaWoXSge7ijuVyU6eWPI/LUrb/2r/ZVbci45zRak=;
 b=hwKz28LXmpKCDwzGS4RABdi4Kmd9YecUy391b62xIVQUYro6YEJ9p/02CcS0+SCTBy
 wGO9oDXpqMA6RU93FTiro6q9VzI9j33hsWaTmCSYbEe+goyBj7TGTSLSMx3EJXE1zmAe
 o5K9LfbPl4ZOcLBtimfIm5xIpzhX2KUPvf3F83gH39CcaAsYGUdHBX87wckADBhCp4o8
 s2GTZ/Zal3gKmEgchLmyrQ1BB1cDnQAZUsHVXnSj0jMlPcU4uGuQ6Dw6wLkUpgwX8fIs
 TemMjDOXre6cN9qdfMTqT6mKCjwEG2hZbyic6QbflQBvEjNhNS/n7eRHjSPrKdh30JG5
 +q/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6TFiDmN0HsGb7IP3l6ck9fq/hUNyJ0kgdqlCETiBP6JENho+Tidl6NobQZ+iDkoZHCAjEscPfKaex@nongnu.org
X-Gm-Message-State: AOJu0Yx4bRR8H2Tg49zm4o74GXe8wzjGxdBRNFNeydWq32nSc1XPR3WN
 yUsJYCipbSB9DP8ngkQJU0T7SwDVnJDjqWYaChcryHphLVwW45Ugyi1z9t00Jn8SiR4=
X-Gm-Gg: AeBDiesW3GTZuD/6IS2RgQAE4CmJg9spIJ8UWhHZHZ+D0xJITzS1tf8MwbZde8t9fJy
 jmybGEw7ojLm2qPUg5NHek48FNXAey4encgyXx4M5C4M9ue5fzo7DkB2/Nw4soEk1ViEmgXCNCP
 ZPuibXmRhAXL1zstaNNXl3iVXsbjSqKQiwk4AnSzrIfdnYiib5oVpIvWx3K7eCeK4Lgnp6IQzR+
 sz36gmu2M9rUTBFbCi8AoA44+qMzyDT9HOt0JiU000jHUAKl3xZt/lzvEjeYb26gXFkAsGjLJxA
 tsJAvWm+EfBWBMoI3BuN31LSsofdTWNtVaGEg6Gp+/msBeXDQqIV0ozmbgleNLZjSaZVlzizHAD
 R1OdfScIrj43l35q32r3fwRPS0W9Pnz/pzcDct4E3iCjh4y+l46E6ODF+zvAGjFVwQsGWCsEty4
 Rgx+5sUin6o6CZkS+CZAJR/u+NOlLJ3u+I/kqbCMaX2W7r8qR2m/6ywdDUTkbYGt/DuA==
X-Received: by 2002:a05:600c:c08e:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-488d6864d41mr2559745e9.24.1775768442608; 
 Thu, 09 Apr 2026 14:00:42 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f229sm32408275e9.3.2026.04.09.14.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:00:42 -0700 (PDT)
Message-ID: <9e3d8ee8-0988-48dc-8cd9-938a21c7dcb2@linaro.org>
Date: Thu, 9 Apr 2026 23:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] hw/hexagon: Add machine configs for sysemu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Markus Armbruster <armbru@redhat.com>,
 Mike Lambert <mlambert@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
 <20260408042149.1902796-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260408042149.1902796-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Brian,

On 8/4/26 06:21, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Some header includes are modified here: these are uniquely required for
> basic system emulation functionality and had not been required for linux-user.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                            |   2 +
>   include/hw/hexagon/hexagon.h           | 150 +++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v66g_1024.h.inc |  64 ++++++++++
>   hw/hexagon/hexagon_dsp.c               | 161 +++++++++++++++++++++++++
>   system/qdev-monitor.c                  |   2 +-
>   target/hexagon/translate.c             |   1 +
>   hw/Kconfig                             |   1 +
>   hw/hexagon/Kconfig                     |   5 +
>   hw/hexagon/meson.build                 |   6 +
>   hw/meson.build                         |   1 +
>   10 files changed, 392 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/hexagon/hexagon.h
>   create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
>   create mode 100644 hw/hexagon/hexagon_dsp.c
>   create mode 100644 hw/hexagon/Kconfig
>   create mode 100644 hw/hexagon/meson.build


> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index ae980c087f0..15258a203b3 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -32,6 +32,7 @@
>   #include "translate.h"
>   #include "genptr.h"
>   #include "printinsn.h"
> +#include "exec/target_page.h"

Why? Rebase left-over?

>   #define HELPER_H "helper.h"
>   #include "exec/helper-info.c.inc"


> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> new file mode 100644
> index 00000000000..7b9577f68f7
> --- /dev/null
> +++ b/hw/hexagon/Kconfig
> @@ -0,0 +1,5 @@
> +config HEX_DSP
> +    bool
> +    default y
> +    depends on HEXAGON && TCG

No need to check for TCG.

> +    imply PTIMER

Usually you want "select" here, not "imply", but
I don't see any PTIMER code being used.

