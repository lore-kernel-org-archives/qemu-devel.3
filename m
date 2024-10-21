Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D653D17123
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2woQ-0003eK-7g; Mon, 21 Oct 2024 14:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2woN-0003e8-2W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:07:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2woL-0008NJ-8r
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:07:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso3295358b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729534040; x=1730138840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JawWysb92gFUwqXce/svGIAl6+lEZQVuCrdGibHz4PM=;
 b=jp7D15+QYj7gvpjfbf6vabrcnVgSAdnY26mDkAZnHlHhrNW+frrOpmQvo/8O2BybtB
 51Ei1BmWP6xAFPil5GpApjLLfmeHky2Mfp3kk2eiHgvF8OqKhn/M5yqLJBk3uTbMSM2Z
 CR+zad1xFLGrw/2mWLj63/Bvt/LEWOO8nq3Wd2SNqYbZOcBLzxe8PaRIfAA+Zl1HLonY
 M3CgVC/swzej7P0Isv4XvQqkYaeTMgQrCPDMj4ZwlZczXp70NmxHHDbveAsYOTLwXyf0
 a6AySdpR3HcGzUHNaiW2xnZYSzrSxZ7bNVCcAyvW7ZyQvww7Pa0tHx0tISYhJbYAGRxz
 dFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534040; x=1730138840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JawWysb92gFUwqXce/svGIAl6+lEZQVuCrdGibHz4PM=;
 b=Njw7HJq7Zfn8Al/BrpV4/cxDj2lf/X+P9eFdzdIuZvrTm/LakN9pqH1bg3DmX2XjOI
 sEqAxhLZRRFHo1G978z2najzNDJrmir8vgzAChW9DUKoXkI5wf0FS108noiiW3HFUzvo
 MJNZZSiC0ncxjApSKIWasLZGg7YPPTEdlFSGsr/UNStG0cX1YeLoz2lhKCWLtTO+STLu
 uwoyqOi/H/P0NqvxQ0KVxPcuGsncyUFLJowNYDyrzI2ecbkPDxsU1rnAYRDfk4kfDdqG
 equZCp8g63XeHUdsystD/KQ3bFY3rLU+NzWXLLGeAlm+QhypAq5ejm68avF7kKTQoVfy
 8XuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNnDTocIqTCw7TckNCQ5sCpKr61RSavaLoVtxrY0o/phFyJypyj9RGB9Kus2mI2m3Io35ZqkLcy5Ma@nongnu.org
X-Gm-Message-State: AOJu0YzsEomeJYWCuzLmR1kvLv/h7b9TJhZTd0a3wC8bSJcJrrolyLOY
 E0muJ1yTQwuUvKz/mIPlOEJpt4I9Co0AY2jOhIYhuflOtQIe4usEjGoUc2m5j6U=
X-Google-Smtp-Source: AGHT+IHnc/0zM1V/UfqtXESc8ucbzFauWyejMLyBKNH/Obvn7Bhh7ZeQ3Em3HZGz6fzHOfdJBgoIZg==
X-Received: by 2002:a05:6a00:b4c:b0:71d:f423:e6cc with SMTP id
 d2e1a72fcca58-71ea314be4amr14600140b3a.8.1729534039818; 
 Mon, 21 Oct 2024 11:07:19 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1338c80sm3187412b3a.48.2024.10.21.11.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 11:07:19 -0700 (PDT)
Message-ID: <97f8c999-c6b1-46d2-aef3-3a81c2156865@linaro.org>
Date: Mon, 21 Oct 2024 11:07:18 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Instead of allocating data for max number of vcpu, you can use a 
qemu_plugin_scoreboard, which was introduced recently, and covers 
exactly this need, by providing an array that gets automatically 
redimensioned when a vcpu is added.

A simple example using it can be found with bb plugin:
https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/plugins/bb.c

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
> +}

