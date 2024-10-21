Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0419FD17122
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wnI-0002jw-JR; Mon, 21 Oct 2024 14:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wnC-0002hI-68
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:06:11 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2wn8-0008E7-Js
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:06:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so37360305ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729533965; x=1730138765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=adOVEpwN3SehtM61Yol35EmLzyaay4Z2RtnvTBsdKMc=;
 b=FKZwBND+oYADHSOVgIeyYFewG4kGkspcimR9neeiaj7iZn86/Suqjxj6jJb3GBEH6b
 6UvigGFc2BqonRP26glRxKE0y/fmpyfRa2Q7tLsTwd1bmGDO1IqgxM2hzVeR14BPz2wk
 3rrZfWicr98RKCGbtwJ8fOIp3KNhOWwBTUtiR3VbxP5yDiXp5ZnGwjEXGpNGc/diJ0n9
 XCz4SrbQI8J+cD7wqTCbThBuYCUfnsXNT/IqNVhDkis/mwAUlbvgov8WOpn0yU5ATybm
 zjZqhJ85SSwlkbRi0NZbbEDMmnqdPUPAT93Z7he9RNBCBeksOwgfr+Ywz8ro2Lo6/Dju
 1pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729533965; x=1730138765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adOVEpwN3SehtM61Yol35EmLzyaay4Z2RtnvTBsdKMc=;
 b=mgykAlac6Z9JUqijXt0Mr7Pz3+dB1WQ9xcWDwZ+KCZTCuKg4cKlf8isgEc1mW13D3F
 5WWdOrIivl49FWxAEf2f+fhirtSoVpFlBuRLLPW/GC3/Jlg2T/Iy7EYbqoFSfF8fZXMF
 masfdX7ZQUZ01rB3uRR3QjdM6sFyja0VkP6tijn6I3tFR0yKZ0WIQLDAJhuRpDTkVUrX
 xkcrhaY0TrDfY37rOe2Prwlh/yql04vg+rtuiZQQVh9HXApqAc06hXT+DxRi47+C8quj
 nrWHA7BbcrsMFpnB/ocrubDiU7W2QDa6L6haQDFpM2hKSVztHrzE+h2G4eltMf4W9PeF
 GORQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSmLBHIs1VFRuHQoADsJR9ubvSCRgzeUAz1lWJQhHTeJSfoEUzJaoqQbwYb0kXhsUKbXABDTfudJSW@nongnu.org
X-Gm-Message-State: AOJu0YzIcK5JGiTQQR6bWUOuOzwcikdKg3WtPcOLnYO+1A2KiDXijzB5
 cKShHt1kkTXRF7in74h1Y2SVNq7nxmZopxmwwH+G0ZrgAyBldu9KYZmf01ivpKw=
X-Google-Smtp-Source: AGHT+IEPkByozEkXdIAoXy7jqtvcI+gtYrHLyveydgTDPjKAWhpN54y/y24c/2idZYuKz3w3L+rkpQ==
X-Received: by 2002:a17:902:ccc8:b0:20c:c704:629e with SMTP id
 d9443c01a7336-20e5a93e82amr200824085ad.56.1729533965000; 
 Mon, 21 Oct 2024 11:06:05 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd309sm28771385ad.151.2024.10.21.11.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 11:06:04 -0700 (PDT)
Message-ID: <89f9402c-fd7a-476c-96af-ad24dfdc3c00@linaro.org>
Date: Mon, 21 Oct 2024 11:06:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/7] contrib/plugins: add plugin showcasing new
 trap related API
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <1a2a379011c3636cfc516a3d246566acf14dd44f.1729355735.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1a2a379011c3636cfc516a3d246566acf14dd44f.1729355735.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/19/24 09:39, Julian Ganz wrote:
> We recently introduced new plugin API for registration of trap related
> callbacks. This change introduces a minimal plugin showcasing the new
> API. It simply counts the occurances of interrupts, exceptions and
> semihosting events per CPU and reports the counts when exitting.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   contrib/plugins/Makefile |  1 +
>   contrib/plugins/traps.c  | 89 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+)
>   create mode 100644 contrib/plugins/traps.c
> 
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index bbddd4800f..6085fd701f 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -31,6 +31,7 @@ NAMES += drcov
>   NAMES += ips
>   NAMES += stoptrigger
>   NAMES += cflow
> +NAMES += traps
>   
>   ifeq ($(CONFIG_WIN32),y)
>   SO_SUFFIX := .dll
> diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
> new file mode 100644
> index 0000000000..2a38dbb8b3
> --- /dev/null
> +++ b/contrib/plugins/traps.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright (C) 2024, Julian Ganz <neither@nut.email>
> + *
> + * Traps - count traps
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +typedef struct {
> +    uint64_t interrupts;
> +    uint64_t exceptions;
> +    uint64_t semihosting;
> +    bool active;
> +} TrapCounters;
> +
> +static TrapCounters *traps;
> +size_t max_vcpus;
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    traps[vcpu_index].active = true;
> +}
> +
> +static void vcpu_interrupt(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    traps[vcpu_index].interrupts++;
> +}
> +
> +static void vcpu_exception(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    traps[vcpu_index].exceptions++;
> +}
> +
> +static void vcpu_semihosting(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    traps[vcpu_index].semihosting++;
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_autoptr(GString) report;
> +    report = g_string_new("VCPU, interrupts, exceptions, semihosting\n");
> +    int vcpu;
> +
> +    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
> +        TrapCounters *rec = &traps[vcpu];
> +        if (rec->active) {
> +            g_string_append_printf(report,
> +                                   "% 4d, % 10"PRId64", % 10"PRId64", % 10"
> +                                   PRId64"\n",
> +                                   vcpu,
> +                                   rec->interrupts, rec->exceptions,
> +                                   rec->semihosting);
> +        }
> +    }
> +
> +    qemu_plugin_outs(report->str);
> +}
> +
> +QEMU_PLUGIN_EXPORT
> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> +                        int argc, char **argv)
> +{
> +    if (!info->system_emulation) {
> +        fputs("trap plugin can only be used in system emulation mode.\n",
> +              stderr);
> +        return -1;
> +    }
> +
> +    max_vcpus = info->system.max_vcpus;
> +    traps = calloc(max_vcpus, sizeof(TrapCounters));


> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_vcpu_for_each(id, vcpu_init);
> +
> +    qemu_plugin_register_vcpu_interrupt_cb(id, vcpu_interrupt);
> +    qemu_plugin_register_vcpu_exception_cb(id, vcpu_exception);
> +    qemu_plugin_register_vcpu_semihosting_cb(id, vcpu_semihosting);
> +
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +

