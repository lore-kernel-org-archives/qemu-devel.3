Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B7AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX42P-0001jP-IU; Wed, 02 Jul 2025 16:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX42K-0001hN-1u
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:26:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX42D-0007wZ-Gn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:26:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-235d6de331fso63151185ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751487981; x=1752092781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H/dpbltos80urwcioRExrd7JLKoRPWhSJHpw3Tr+p54=;
 b=WiSav74X+SkEDoIAd/QumvCQuL5OU3UVwPM8BDfq6kIDQiN0w6umX3j6KcRJilyPd2
 hWFdh8bhIudg2d1zhJPA5QTTDwzM4EyDJCoe0Zx/ekVpVl1V1iRBqf5xyc0gPCSGQZiU
 Ylb1VuP0feZiYwqqCT2cTGq0EJ9hag8wWPq7pC313UNu1FoBVLBnb3ZvbQF7LssyXzpU
 hMoqAWm4NQNZMWKcm3eb43IWyetKWsnJyCVDmgXS/BkylmwU4Nhj0sOP33s3JxXH+zZw
 86jvYF/iwjAk1mJOK4ph//sg8bOS8Ktac4BGzfgnav1XeKkTwo06f32kXSgUD30QAEqu
 y/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751487982; x=1752092782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/dpbltos80urwcioRExrd7JLKoRPWhSJHpw3Tr+p54=;
 b=u5zhEtEes7+RBGCPbCSDrV8lGL6Hdt6mGvtLUEt2L5DHStEahmCdyy6IuLlwGnV2Yh
 cX0B1RLRt9SZnI1ySc3tO6K1AqrJlEVanszfG5xUYdw1oU9L81d0pQzqj8T41gW5e5gm
 jDGtj6AI1GrgcLirFjszWP98xy1c06UCWEVM42pt6o29BXl4fPuCSJElykYYPRx6ECVq
 3URH3xKTg0Bbd1/tU9ROmUOlbZmFS0gbMNm5yeOYMgyfX7YjKUc7WA3Hqq+DugSA2VwF
 WajERQoFOyTYdj7D8LApUFRd+rueNycb3WJvtcmwLd7aFVDQ1MZTh1NnfCo7QwIWTaC8
 03vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3M1omrABkIY6rWW0UazCYGr7ZU7+4mNhPw7Ownpz9rn5IP1hW+JNdyFXLwXC6uqAnwv5A42IeuA+N@nongnu.org
X-Gm-Message-State: AOJu0YwahnYKuqEndF3s2dLb7FiCT5hpVNyXgF/Nw6QcWVaKiiOnuxOz
 AghPC4o48PbwlEZfx6rxwsGxvgQpYzWit53VjJW0z4XJptJJ0/KII6cyrwot0Hf3Trg=
X-Gm-Gg: ASbGncvJ8R2QRcWewOvwhxaw4XfyNmvcNowMWwFB+8kGGlgd665AeObHBlpgqs7xbYw
 BIgR9ISN6DAVX+eLR1MntOJeCnRKbtJui/jTp9ZFE6inKZbWRWuna2yHTnHJkDOCj8SXG+BD2OA
 eFMo5cVQ/blJVQ4Ojr8sZIsAb+UEOsfmqmVWZe7xaGpMf7ZRCbpd5edxJ7fqkmE0m2wJdx98OB+
 982ClxG0ocMkDxFNKr2Bi0rXGdrUnAQryFPBHWzjVfvhYTY+yArpWNUeATUZDPKFeDOBXXftDT6
 24xusoYbQpr2f0UPqxUpNOw4cmFl9PitOww9lLENAYkacvUTdSilIdRFW+gTA6s0M8FyopstPuk
 =
X-Google-Smtp-Source: AGHT+IEUARww65olXAb8Fauctcu31qpZOJ6VGX8NfydCFxJen7dk6JZcd2KUTLCYnoYTvDRJoUpRpg==
X-Received: by 2002:a17:903:41c5:b0:234:d679:72e9 with SMTP id
 d9443c01a7336-23c7963d9c8mr13422415ad.12.1751487981587; 
 Wed, 02 Jul 2025 13:26:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b934sm135269625ad.92.2025.07.02.13.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:26:21 -0700 (PDT)
Message-ID: <4fa5584d-865e-4e66-96ca-939ff3628f30@linaro.org>
Date: Wed, 2 Jul 2025 13:26:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/65] qapi: Move definitions related to accelerators
 in their own file
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-23-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 7/2/25 11:52 AM, Philippe Mathieu-Daudé wrote:
> Extract TCG and KVM definitions from machine.json to accelerator.json.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                |  1 +
>   qapi/accelerator.json      | 75 ++++++++++++++++++++++++++++++++++++++
>   qapi/machine.json          | 65 ---------------------------------
>   qapi/qapi-schema.json      |  1 +
>   accel/tcg/monitor.c        |  2 +-
>   hw/core/machine-hmp-cmds.c |  1 +
>   hw/core/machine-qmp-cmds.c |  1 +
>   qapi/meson.build           |  1 +
>   8 files changed, 81 insertions(+), 66 deletions(-)
>   create mode 100644 qapi/accelerator.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7128e0bc98e..5d6b337cef6 100644
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
> index 00000000000..1d2a83f1b22
> --- /dev/null
> +++ b/qapi/accelerator.json
> @@ -0,0 +1,75 @@
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
> +
> +##
> +# @KvmInfo:
> +#
> +# Information about support for KVM acceleration
> +#
> +# @enabled: true if KVM acceleration is active
> +#
> +# @present: true if KVM acceleration is built into this executable
> +#
> +# Since: 0.14
> +##
> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +
> +##
> +# @query-kvm:
> +#
> +# Return information about KVM acceleration
> +#
> +# Returns: @KvmInfo
> +#
> +# Since: 0.14
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-kvm" }
> +#     <- { "return": { "enabled": true, "present": true } }
> +##
> +{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
> +
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
> +  'features': [ 'unstable' ] }
> +
> +##
> +# @x-query-opcount:
> +#
> +# Query TCG opcode counters
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: TCG opcode counters
> +#
> +# Since: 6.2
> +##
> +{ 'command': 'x-query-opcount',
> +  'returns': 'HumanReadableText',
> +  'if': 'CONFIG_TCG',
> +  'features': [ 'unstable' ] }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index d5bbb5e367e..e4713c405e8 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -454,35 +454,6 @@
>   ##
>   { 'command': 'inject-nmi' }
>   
> -##
> -# @KvmInfo:
> -#
> -# Information about support for KVM acceleration
> -#
> -# @enabled: true if KVM acceleration is active
> -#
> -# @present: true if KVM acceleration is built into this executable
> -#
> -# Since: 0.14
> -##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> -
> -##
> -# @query-kvm:
> -#
> -# Return information about KVM acceleration
> -#
> -# Returns: @KvmInfo
> -#
> -# Since: 0.14
> -#
> -# .. qmp-example::
> -#
> -#     -> { "execute": "query-kvm" }
> -#     <- { "return": { "enabled": true, "present": true } }
> -##
> -{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
> -
>   ##
>   # @NumaOptionsType:
>   #
> @@ -1729,24 +1700,6 @@
>     'returns': 'HumanReadableText',
>     'features': [ 'unstable' ] }
>   
> -##
> -# @x-query-jit:
> -#
> -# Query TCG compiler statistics
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: TCG compiler statistics
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-jit',
> -  'returns': 'HumanReadableText',
> -  'if': 'CONFIG_TCG',
> -  'features': [ 'unstable' ] }
> -
>   ##
>   # @x-query-numa:
>   #
> @@ -1764,24 +1717,6 @@
>     'returns': 'HumanReadableText',
>     'features': [ 'unstable' ] }
>   
> -##
> -# @x-query-opcount:
> -#
> -# Query TCG opcode counters
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: TCG opcode counters
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-opcount',
> -  'returns': 'HumanReadableText',
> -  'if': 'CONFIG_TCG',
> -  'features': [ 'unstable' ] }
> -
>   ##
>   # @x-query-ramblock:
>   #
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index a8f66163cb7..0477696ff02 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -37,6 +37,7 @@
>   { 'include': 'run-state.json' }
>   { 'include': 'crypto.json' }
>   { 'include': 'job.json' }
> +{ 'include': 'accelerator.json' }
>   { 'include': 'block.json' }
>   { 'include': 'block-export.json' }
>   { 'include': 'char.json' }
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 1c182b6bfb5..5bdd837006c 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -11,7 +11,7 @@
>   #include "qemu/qht.h"
>   #include "qapi/error.h"
>   #include "qapi/type-helpers.h"
> -#include "qapi/qapi-commands-machine.h"
> +#include "qapi/qapi-commands-accelerator.h"
>   #include "monitor/monitor.h"
>   #include "system/cpu-timers.h"
>   #include "exec/icount.h"
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 65eeb5e9cc2..15ae5864d16 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -18,6 +18,7 @@
>   #include "monitor/monitor.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-builtin-visit.h"
> +#include "qapi/qapi-commands-accelerator.h"
>   #include "qapi/qapi-commands-machine.h"
>   #include "qobject/qdict.h"
>   #include "qapi/string-output-visitor.h"
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index ab4fd1ec08a..f37fd220c2d 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -14,6 +14,7 @@
>   #include "hw/mem/memory-device.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-builtin-visit.h"
> +#include "qapi/qapi-commands-accelerator.h"
>   #include "qapi/qapi-commands-machine.h"
>   #include "qobject/qobject.h"
>   #include "qapi/qobject-input-visitor.h"
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 3b035aea339..ca6b61a608d 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -57,6 +57,7 @@ qapi_all_modules = [
>   ]
>   if have_system
>     qapi_all_modules += [
> +    'accelerator',
>       'acpi',
>       'audio',
>       'cryptodev',

Good for me, in case a lower granularity (kvm, tcg, other) is needed 
later, it can always be modified.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

