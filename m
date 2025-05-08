Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E299C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvC6-0007rd-0t; Thu, 08 May 2025 02:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvC2-0007rP-8S
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:57:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvBx-0004y7-HE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:57:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso729139b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746687432; x=1747292232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rE0KKZ00LgsnIuSEFuwFYh77vMWcbiEnFlsp3T1SXTM=;
 b=U6rBCjRwWCoXCYhBh18NBG2JCSIpdSAlUoR+k0QWmUmHfStXA8pNpqNS3GiPRJG5ib
 0sN0UGPt1VRvVIhBJuTtRUfKpUBVSOorK9kzmWAIbJJVvn3MAXi3VtKnVPMFCvfLxnFf
 9DvMAWtAfjTx6t4iyYWiMcZVKT6XYal0d6kHgixm4BM9tJ0E7Hw9amudpJdka2q16prJ
 FIqUcmzjcKsfFVMwI0cZCNMTD07sLvxv3QINw5EYSGLBjvC9YWOJ5aMO+jPZtbBaE+cE
 aDsYXXgpXpexJt7MlIMGIC5v2Vl8oA3Nt8Iv6pBZFlArjqH1ybmVb1DHwfnNIrMNMvin
 xMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746687432; x=1747292232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rE0KKZ00LgsnIuSEFuwFYh77vMWcbiEnFlsp3T1SXTM=;
 b=tXjILxdAJ/yPc60jGqEL51QIMlAuifGkGlehUPUe6oqVx0Bunb/BSNKYEs+hFX9rXh
 pB4M5bYdBOc718+bdfgMtl5NtV2EPwKe8eaJx6AK/MXfLPmfqiWh33tMefIVJ6BTr/j5
 ALZ8kyktZax+/3wy9LQxB9fMmUFPtqKumx+J9SyjK7pTFFjLAGprVU0haZcmJVEdNJoo
 x9NeILWnIbTQ26YrG8lFsh+/GhsNdxfVbDfgRv9TRWxgkk04QvsUlXHizIlVWGA7j6nL
 9SfipUag/caM59A/MkwOaWUpksNwGrSn1X5PcHvOo6wyGKjCFbllfpfeGOeR/Ql/fWJE
 aUcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMGK1iaMdhe29X8lSuc0yrwXnZuRFqeYGRoRrrBxUGuf+prP4944Gl12OF8MUGQxFyOsrCPNeroY3e@nongnu.org
X-Gm-Message-State: AOJu0YzTMkf2Pi+Gg3xS2grZwj7DaI0eHA+VXYEDwaNiBXPkDe8tcvzm
 WrVzfLwff5jAw9Xk6M7Ykvlf4kJMPN7WmAxGHkVV0mMpr4G50okVWzX1Bj+3JI8=
X-Gm-Gg: ASbGnctquKT6L/kCt3+6XLViD99lOcVYPcW7UQbnW5sD6OnVKa/veRorpS5EGMJJelq
 hM/fUzBIgmvddL9skvkxnwLUzaWEI+K75boUj/8kDfzqhqzE1s6KjW8jkYhWwchxhwyrqHd/GGg
 1NL1/lmaDPRmYYk6fMpfXO8Dbh3hWD7PL3kNOuGFZrCwkCHyF/tlBbh6bb1MY12GPAWvlAHrSBY
 UB0zcnCZQtCI/BTNqI0hVZ0v+bGVkse8mB0gGDrgczaZnb0iYBJisRFP4xZkDJtTTTGmbjjWnod
 q07lvg4UFvG2t2HGBKhvcvL/jNMq2sGKOYId/DtRCeSWKWZwMc54ZjtgyRjjXfumjtk4b2mMIsY
 6j4SnCFTJ
X-Google-Smtp-Source: AGHT+IHrRR6ziW8ik2ECFxd0ZvAOhe4MCeuravHrhlZ5fShKypoyxc8Pcn8nJbLGDIWkvkD+ldIwUQ==
X-Received: by 2002:a05:6a00:4293:b0:736:a82a:58ad with SMTP id
 d2e1a72fcca58-7409cfb00f6mr7561343b3a.15.1746687432011; 
 Wed, 07 May 2025 23:57:12 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590669b2sm12503817b3a.153.2025.05.07.23.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:57:11 -0700 (PDT)
Message-ID: <30076d35-3452-4061-8fc6-d3eb9810d0b8@linaro.org>
Date: Thu, 8 May 2025 08:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] qapi: add weak stubs for target specific commands
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/5/25 01:14, Pierrick Bouvier wrote:
> We are about to expose various target specific commands for all targets,
> so we need to stub not implemented qmp_* functions.
> 
> MinGW does not support weak symbols without at least one strong
> definition, so we'll have to detail stubs per target. Sad.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>   qapi/meson.build           |  2 ++
>   2 files changed, 40 insertions(+)
>   create mode 100644 qapi/commands-weak-stubs.c
> 
> diff --git a/qapi/commands-weak-stubs.c b/qapi/commands-weak-stubs.c
> new file mode 100644
> index 00000000000..9734263c32e
> --- /dev/null
> +++ b/qapi/commands-weak-stubs.c
> @@ -0,0 +1,38 @@
> +/*
> + * Weak symbols for target specific commands
> + *
> + * Copyright Linaro, 2025
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib.h>
> +
> +#define NOT_REACHABLE(symbol)                                                  \
> +void __attribute__((weak)) symbol(void);                                       \
> +void __attribute__((weak)) symbol(void) { g_assert_not_reached(); }
> +
> +#define WEAK_STUB(command)                                                     \
> +NOT_REACHABLE(qmp_marshal_##command)                                           \
> +NOT_REACHABLE(qmp_##command)
> +
> +WEAK_STUB(query_cpu_model_comparison);
> +WEAK_STUB(query_cpu_model_baseline);
> +WEAK_STUB(set_cpu_topology);
> +WEAK_STUB(query_s390x_cpu_polarization);
> +WEAK_STUB(rtc_reset_reinjection);
> +WEAK_STUB(query_sev);
> +WEAK_STUB(query_sev_launch_measure);
> +WEAK_STUB(query_sev_capabilities);
> +WEAK_STUB(sev_inject_launch_secret);
> +WEAK_STUB(query_sev_attestation_report);
> +WEAK_STUB(query_sgx);
> +WEAK_STUB(query_sgx_capabilities);
> +WEAK_STUB(xen_event_list);
> +WEAK_STUB(xen_event_inject);
> +WEAK_STUB(query_cpu_model_expansion);
> +WEAK_STUB(query_cpu_definitions);
> +WEAK_STUB(query_gic_capabilities);

Shouldn't this also be generated by QAPI scripts?

> diff --git a/qapi/meson.build b/qapi/meson.build
> index eadde4db307..60fc958ec10 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -147,3 +147,5 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
>     specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
>     i = i + 1
>   endforeach
> +
> +system_ss.add(files('commands-weak-stubs.c'))


