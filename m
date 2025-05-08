Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1736C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2ky-0006gA-Tp; Thu, 08 May 2025 11:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD2kx-0006fc-9w
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:01:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD2kp-00071N-6i
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:01:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso978208b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746716498; x=1747321298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfcwazXNETPiDaAW+KwmMQ5+ZElvDbQDyBRLL7+wMjc=;
 b=Ouf0rfrSR2PI5onll+2YMKZhie2oJgV6RCoOHiNjkevQbVyu617sWphGovoV+oUET+
 pcho8BKtYYfmL4AuzloaZo34pGwnOLFtwGFDuHPG/bXPkT5OGVc7It34ETFnP7eb3+Lv
 n9NNyADHHd3gwJe0BZ+7ItYpCJ3EUFkNaGgOq+dEpfPUy1cZqb/Solx+qWq+2KpJ13S8
 iXgYk0kkZrBuots6I7LDK53Y57Ub5vk6pW/TnF/ZPeTvR5SufY3H10UzWpoxgtB6I0vx
 MdraivAQ5hyLfmrnBNKyuR1UhZxQ6lKOkRldFFqQkqcZI5roafyy1GCL6MO3Xf4EfQEM
 enRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746716498; x=1747321298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfcwazXNETPiDaAW+KwmMQ5+ZElvDbQDyBRLL7+wMjc=;
 b=F193ZXdx4gf76KZV86LAW0wms5T0IkQvq0KKeejVMfmtWWSbkXCKFB5jwUWRZNaUqT
 +iTvSH4AtT57ipoNIbHyizxQRkK4kovqtOLJDvWA5KGJDXSFRvEwMWNqEfutsnTz5N9y
 hpz5YlfaPogGDfQ+g9MMTsJCeivKfDrXrn1tTRKu5Enb/1WB32jaFB48tJ7L1TIY14Dk
 KfpgeNro2fn86IHDV+9wSpXB3xwmMW0hu9GedOge6jlR8hTcwszvjeipIPo0iAHe737p
 FlUWlJjCUnR+d6/SL01iFuPup2xiyLdhcBfCeoZlZh8XQfHKNhFv2K4nTX3DBsWS6aOR
 oUPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXib77tOUKlXqDdtw8qObiXc5dzMPJU3Dp71JXAEZpZxuzfzMgFM7O9BvbO986T8O0hTfsButcg2kBo@nongnu.org
X-Gm-Message-State: AOJu0YyB1jVPSNBBalJNPdjC3+/dFVRGshCxxztzbuL9YXMF6vucdK+4
 AJ9cWPnWO5Wlc62XvpdlbjQjcZF0cihitZKJZKeoxMu9fWqJRKTKdqxbe4Wpaow=
X-Gm-Gg: ASbGncveuzaCquToG815wnQuPf583BiH6wXtFnBH9Ow3qPuCtq4Y7zkA8bFNSNAwfHK
 GfLfNlJGqjHYDV/Bawv4x4cUeDB7WN5XEWSYOKWErB+m0RHK75u+r5zBYgTYMWUSh7s/pvpCCJN
 0vJP9nMD8HKm3fJqe0V9uv1Cha38Z6vgoFx/0hHzFenS9N0kBy/JD4JmwSVJGjvLHsz6iJp1a8e
 Tn1X274jLRYj0Z1HMUVD8quk3avQS/Ikyw5fC0knuU9WXvJLfCHGkP5c/ZrpdsgdsQX1xb+O4Kk
 OUxO7038klJRimrIljB36zzLcQbm9E2Lh4agDrNZtu7EYN497C3jwjf4lwHjZ9N7aQaGu4bq22A
 N70I8Bv3X
X-Google-Smtp-Source: AGHT+IFBZcOkrMeQVV9KOpImr95NTXqtfLpXafMxIRNyzvGzDFhwEZ/YyHQKkT0qgrGWlwGZL8SNHg==
X-Received: by 2002:a05:6a00:1b4c:b0:732:706c:c4ff with SMTP id
 d2e1a72fcca58-740a94e60d7mr4624025b3a.7.1746716496289; 
 Thu, 08 May 2025 08:01:36 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237736e4esm89257b3a.67.2025.05.08.08.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 08:01:35 -0700 (PDT)
Message-ID: <053d4bb5-a532-4133-9459-cb05a46a43db@linaro.org>
Date: Thu, 8 May 2025 17:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] qapi: make Xen event commands unconditionally
 available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508135816.673087-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
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

Cc'ing Zhao

On 8/5/25 15:58, Daniel P. Berrangé wrote:
> This removes the TARGET_I386 condition from the Xen event channel
> commands, moving them to the recently introduced misc-i386.json
> QAPI file, given they are inherantly i386 specific commands.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/kvm/xen-stubs.c  |  13 -----
>   hw/i386/kvm/xen_evtchn.c |   2 +-
>   qapi/misc-i386.json      | 107 +++++++++++++++++++++++++++++++++++++
>   qapi/misc-target.json    | 110 ---------------------------------------
>   stubs/meson.build        |   1 +
>   stubs/monitor-i386-xen.c |  16 ++++++
>   6 files changed, 125 insertions(+), 124 deletions(-)
>   create mode 100644 stubs/monitor-i386-xen.c
> 
> diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
> index d03131e686..ce73119ee7 100644
> --- a/hw/i386/kvm/xen-stubs.c
> +++ b/hw/i386/kvm/xen-stubs.c
> @@ -12,7 +12,6 @@
>   #include "qemu/osdep.h"
>   
>   #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc-target.h"
>   
>   #include "xen_evtchn.h"
>   #include "xen_primary_console.h"
> @@ -38,15 +37,3 @@ void xen_primary_console_create(void)
>   void xen_primary_console_set_be_port(uint16_t port)
>   {
>   }
> -#ifdef TARGET_I386
> -EvtchnInfoList *qmp_xen_event_list(Error **errp)
> -{
> -    error_setg(errp, "Xen event channel emulation not enabled");
> -    return NULL;
> -}
> -
> -void qmp_xen_event_inject(uint32_t port, Error **errp)
> -{
> -    error_setg(errp, "Xen event channel emulation not enabled");
> -}
> -#endif
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index b5190549a8..dd566c4967 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -19,7 +19,7 @@
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
>   #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc-target.h"
> +#include "qapi/qapi-commands-misc-i386.h"
>   #include "qobject/qdict.h"
>   #include "qom/object.h"
>   #include "exec/target_page.h"
> diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
> index 0ddc297ccb..3d3f373a6b 100644
> --- a/qapi/misc-i386.json
> +++ b/qapi/misc-i386.json
> @@ -370,3 +370,110 @@
>   #                      {"node": 1, "size": 29360128}]} }
>   ##
>   { 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo' }
> +
> +##
> +# @EvtchnPortType:
> +#
> +# An enumeration of Xen event channel port types.
> +#
> +# @closed: The port is unused.
> +#
> +# @unbound: The port is allocated and ready to be bound.
> +#
> +# @interdomain: The port is connected as an interdomain interrupt.
> +#
> +# @pirq: The port is bound to a physical IRQ (PIRQ).
> +#
> +# @virq: The port is bound to a virtual IRQ (VIRQ).
> +#
> +# @ipi: The post is an inter-processor interrupt (IPI).
> +#
> +# Since: 8.0
> +##
> +{ 'enum': 'EvtchnPortType',
> +  'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'] }
> +
> +##
> +# @EvtchnInfo:
> +#
> +# Information about a Xen event channel port
> +#
> +# @port: the port number
> +#
> +# @vcpu: target vCPU for this port
> +#
> +# @type: the port type
> +#
> +# @remote-domain: remote domain for interdomain ports
> +#
> +# @target: remote port ID, or virq/pirq number
> +#
> +# @pending: port is currently active pending delivery
> +#
> +# @masked: port is masked
> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'EvtchnInfo',
> +  'data': {'port': 'uint16',
> +           'vcpu': 'uint32',
> +           'type': 'EvtchnPortType',
> +           'remote-domain': 'str',
> +           'target': 'uint16',
> +           'pending': 'bool',
> +           'masked': 'bool'} }
> +
> +
> +##
> +# @xen-event-list:
> +#
> +# Query the Xen event channels opened by the guest.
> +#
> +# Returns: list of open event channel ports.
> +#
> +# Since: 8.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "xen-event-list" }
> +#     <- { "return": [
> +#             {
> +#                 "pending": false,
> +#                 "port": 1,
> +#                 "vcpu": 1,
> +#                 "remote-domain": "qemu",
> +#                 "masked": false,
> +#                 "type": "interdomain",
> +#                 "target": 1
> +#             },
> +#             {
> +#                 "pending": false,
> +#                 "port": 2,
> +#                 "vcpu": 0,
> +#                 "remote-domain": "",
> +#                 "masked": false,
> +#                 "type": "virq",
> +#                 "target": 0
> +#             }
> +#          ]
> +#        }
> +##
> +{ 'command': 'xen-event-list',
> +  'returns': ['EvtchnInfo'] }
> +
> +##
> +# @xen-event-inject:
> +#
> +# Inject a Xen event channel port (interrupt) to the guest.
> +#
> +# @port: The port number
> +#
> +# Since: 8.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
> +#     <- { "return": { } }
> +##
> +{ 'command': 'xen-event-inject',
> +  'data': { 'port': 'uint32' } }
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index d9368a1f21..6c2f4e71d7 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -3,113 +3,3 @@
>   #
>   
>   
> -##
> -# @EvtchnPortType:
> -#
> -# An enumeration of Xen event channel port types.
> -#
> -# @closed: The port is unused.
> -#
> -# @unbound: The port is allocated and ready to be bound.
> -#
> -# @interdomain: The port is connected as an interdomain interrupt.
> -#
> -# @pirq: The port is bound to a physical IRQ (PIRQ).
> -#
> -# @virq: The port is bound to a virtual IRQ (VIRQ).
> -#
> -# @ipi: The post is an inter-processor interrupt (IPI).
> -#
> -# Since: 8.0
> -##
> -{ 'enum': 'EvtchnPortType',
> -  'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'],
> -  'if': 'TARGET_I386' }

Interesting, this ought to be "all {TARGET_I386, CONFIG_KVM}".

> -
> -##
> -# @EvtchnInfo:
> -#
> -# Information about a Xen event channel port
> -#
> -# @port: the port number
> -#
> -# @vcpu: target vCPU for this port
> -#
> -# @type: the port type
> -#
> -# @remote-domain: remote domain for interdomain ports
> -#
> -# @target: remote port ID, or virq/pirq number
> -#
> -# @pending: port is currently active pending delivery
> -#
> -# @masked: port is masked
> -#
> -# Since: 8.0
> -##
> -{ 'struct': 'EvtchnInfo',
> -  'data': {'port': 'uint16',
> -           'vcpu': 'uint32',
> -           'type': 'EvtchnPortType',
> -           'remote-domain': 'str',
> -           'target': 'uint16',
> -           'pending': 'bool',
> -           'masked': 'bool'},
> -  'if': 'TARGET_I386' }
> -
> -
> -##
> -# @xen-event-list:
> -#
> -# Query the Xen event channels opened by the guest.
> -#
> -# Returns: list of open event channel ports.
> -#
> -# Since: 8.0
> -#
> -# .. qmp-example::
> -#
> -#     -> { "execute": "xen-event-list" }
> -#     <- { "return": [
> -#             {
> -#                 "pending": false,
> -#                 "port": 1,
> -#                 "vcpu": 1,
> -#                 "remote-domain": "qemu",
> -#                 "masked": false,
> -#                 "type": "interdomain",
> -#                 "target": 1
> -#             },
> -#             {
> -#                 "pending": false,
> -#                 "port": 2,
> -#                 "vcpu": 0,
> -#                 "remote-domain": "",
> -#                 "masked": false,
> -#                 "type": "virq",
> -#                 "target": 0
> -#             }
> -#          ]
> -#        }
> -##
> -{ 'command': 'xen-event-list',
> -  'returns': ['EvtchnInfo'],
> -  'if': 'TARGET_I386' }
> -
> -##
> -# @xen-event-inject:
> -#
> -# Inject a Xen event channel port (interrupt) to the guest.
> -#
> -# @port: The port number
> -#
> -# Since: 8.0
> -#
> -# .. qmp-example::
> -#
> -#     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
> -#     <- { "return": { } }
> -##
> -{ 'command': 'xen-event-inject',
> -  'data': { 'port': 'uint32' },
> -  'if': 'TARGET_I386' }
> diff --git a/stubs/meson.build b/stubs/meson.build
> index f2eb488018..0ef11976a2 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -81,6 +81,7 @@ if have_system
>     stub_ss.add(files('monitor-i386-rtc.c'))
>     stub_ss.add(files('monitor-i386-sev.c'))
>     stub_ss.add(files('monitor-i386-sgx.c'))
> +  stub_ss.add(files('monitor-i386-xen.c'))
>   endif
>   
>   if have_system or have_user
> diff --git a/stubs/monitor-i386-xen.c b/stubs/monitor-i386-xen.c
> new file mode 100644
> index 0000000000..95b826f979
> --- /dev/null
> +++ b/stubs/monitor-i386-xen.c
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-misc-i386.h"
> +
> +EvtchnInfoList *qmp_xen_event_list(Error **errp)
> +{
> +    error_setg(errp, "Xen event channel emulation not enabled");
> +    return NULL;
> +}
> +
> +void qmp_xen_event_inject(uint32_t port, Error **errp)
> +{
> +    error_setg(errp, "Xen event channel emulation not enabled");
> +}


