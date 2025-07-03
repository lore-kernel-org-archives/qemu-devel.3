Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FEC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXN0t-0003Tq-Ie; Thu, 03 Jul 2025 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXN0q-0003TV-Aj
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:42:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXN0l-0003e7-3h
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:42:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so233216f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751560929; x=1752165729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89VdT6B6Uu37n7jCg16nfxI1G8F7uZUBb7nUaferbJ4=;
 b=P8orES6N2yhNvFsT8a3+rpOArQl4mlUsQkJ/Ypxf7a2cU1+KInX4WiT/ROXc4CvuOX
 wOLFGvR6IEM4Ona6yOxnRkPtMpfs2o7oFF9RAsBmIwVSt5eYe19+eS3heUWlFE8hC4K7
 311aQstQIfoMIiV5PU/FMQkj12LrxmCQZ1Byb8E00fm76OTOGN9koD327cBCvP8GPUqW
 OOWffbnNq0UEghpWSI70RaCp1psE0uOSyTAoV7P5Cb2/RZD4vijWlvIMQIC03WrrZ7Ja
 Hyq7a72ftQ8gtgmOlYp4dY03o9OTbRBOqadS+IYLNXHjLCKm5DWiYkqyhlb708Cs31lC
 y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560929; x=1752165729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89VdT6B6Uu37n7jCg16nfxI1G8F7uZUBb7nUaferbJ4=;
 b=FvzLtcKuix1uv/h+52uBFGPSt1/iVw/E3XWXQvztiodaGUVpMouF2SAgX2Eq/9cfjc
 44t5LWtOzEqDrOJKMENWW8A/4G3y2vtD3SlFmwClTy2yt93TxnEih7YKSKqPCWv9D5Y6
 80DpWWEPYNZGiEf8Z8oj+pcSm7zMEaeigrC6lTIRVXHixKRPK/WhC79NPRVFbBh4ByMb
 hUCwrBSyEhKhDWKAbrBYMcOdjM0AxyS6bizfM5R9iutMUxDbvCxfM68pf18FphTue8uD
 RMdTxCLM+rfn/hgBYe+kirs1Nr7w71Q5TXm9gSGcZcwhNjeRJjN+/k6b8ni5yt7f5i/l
 1lag==
X-Gm-Message-State: AOJu0YxxVBZdOQ2i77P4u0tIdJlmJ9ULqJfO7H4oqCXMY4uMoQ50SADo
 aaQqaN9dJ1bfsj4eTAhNF8KZkFqL+6xhrQeGPGrrwYH0mimHntZg3lDiVh+6Np0x4hUJ7MHgQOQ
 BDwKyl24=
X-Gm-Gg: ASbGncsCaHfDKow8K7GVBsQ7FleiUq434RlWyqI9VCyFjRJdHBoLcDXczJQnKInmFSv
 n/urlmbOYKrUeRpR9HELy70rlvV0FVvkljIsLKoxH6up7FphtWtn/H1Y5zQFtdUYeLCK0qfZHEK
 awoaWnnRYkrs+CoKVB9AO/6C0ftjduYlTve8xpZGKeFKBWIEuAMAyZeTYsOaxKwN82Yx1By5SC8
 GE3TmAv6GA78868TAGG/GH2pIBmtQh9WRX5Ds0nlTFNEgOEI5A6Rewivmkof7VMn0RpF+hcyzrR
 iydS4rqceDtJt34G1LPZDiUM3b7vdN9AlNMwkd0eAptMMyHLfVNw3LJjqM9AhgNCae/luSlWyxi
 StrnQRYxXSBa/tPBglqLdEunWe4MzXA==
X-Google-Smtp-Source: AGHT+IFlo21nZ+3+OnFGvk4QC6mGpvQXwaYFctOTQS0MBUrwjRweS7+YpfJBsCMfUFSoXbSSr2XgHQ==
X-Received: by 2002:a05:6000:490a:b0:3b1:8db7:d1fc with SMTP id
 ffacd0b85a97d-3b1fe5c07d4mr6498213f8f.21.1751560928626; 
 Thu, 03 Jul 2025 09:42:08 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d099esm235255f8f.21.2025.07.03.09.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:42:08 -0700 (PDT)
Message-ID: <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
Date: Thu, 3 Jul 2025 18:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/69] qapi: Move definitions related to accelerators
 in their own file
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-29-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Markus,

On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
> Extract TCG and KVM definitions from machine.json to accelerator.json.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   MAINTAINERS                |  1 +
>   qapi/accelerator.json      | 57 ++++++++++++++++++++++++++++++++++++++
>   qapi/machine.json          | 47 -------------------------------
>   qapi/qapi-schema.json      |  1 +
>   accel/tcg/monitor.c        |  2 +-
>   hw/core/machine-hmp-cmds.c |  1 +
>   hw/core/machine-qmp-cmds.c |  1 +
>   qapi/meson.build           |  1 +
>   8 files changed, 63 insertions(+), 48 deletions(-)
>   create mode 100644 qapi/accelerator.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1cbfe115bc..c3ce0d37779 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -507,6 +507,7 @@ F: accel/Makefile.objs
>   F: accel/stubs/Makefile.objs
>   F: cpu-common.c
>   F: cpu-target.c
> +F: qapi/accelerator.json
>   F: system/cpus.c
>   
>   Apple Silicon HVF CPUs
> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> new file mode 100644
> index 00000000000..00d25427059
> --- /dev/null
> +++ b/qapi/accelerator.json
> @@ -0,0 +1,57 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# = Accelerators
> +##
> +
> +{ 'include': 'common.json' }

common.json defines @HumanReadableText, ...

[...]

> +##
> +# @x-query-jit:
> +#
> +# Query TCG compiler statistics
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: TCG compiler statistics
> +#
> +# Since: 6.2
> +##
> +{ 'command': 'x-query-jit',
> +  'returns': 'HumanReadableText',
> +  'if': 'CONFIG_TCG',

... which is *optionally* used here, triggering when
TCG is not built in:

qapi/qapi-commands-accelerator.c:85:13: error: 
‘qmp_marshal_output_HumanReadableText’ defined but not used 
[-Werror=unused-function]
    85 | static void 
qmp_marshal_output_HumanReadableText(HumanReadableText *ret_in,
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

We previously discussed that issue:
https://mail.gnu.org/archive/html/qemu-devel/2021-06/msg02667.html

where you said:

"conditional commands returning an unconditional type is a bit
of a code smell". Is it however a "non-smelly instances of this pattern"?

Regards,

Phil.

