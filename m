Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE831C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 22:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSNww-0005rq-HN; Thu, 19 Jun 2025 18:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSNwv-0005rb-L0
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 18:41:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSNwt-0001lE-PY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 18:41:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so15563265e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750372893; x=1750977693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JYqfIDOo4Y81fOUls78kxCDhUADzm0w1A4KbE+kV/I0=;
 b=E+1BS+R92B7SRoJGdLeJ4IlV1Jvpbw/Ert3AAAeA8pk3aQm8kMs/RLmnxvV/9hYogL
 KgsSYOy2hVamTKQuJSpXh3dl9zEQR+BcL550uuAW82zugmXgDNcIVn08pIpquuOOtkJz
 JUNywCv5+Lk+7JBgTu8a5pzAXOmFTkKriU6GOPNVd90+lyySnngRftNz1GebffjRI01D
 KtSCoGwSmnybhRmBv7QQJXsTcFUa62DDCgc7Bp/1eLUm8vaA7NF4jVbteIcraJiGYx0d
 hbnJmnjgSsk4YNr8Xfmshq0lZE9T6I9aC1781wM4+dg+euieon4u7RAeeVm4BYvjdAks
 glEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750372893; x=1750977693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYqfIDOo4Y81fOUls78kxCDhUADzm0w1A4KbE+kV/I0=;
 b=hu2Wz/ZFaWQzh3iPf9yIX9lAN5oqzTTgec7hJsNvW12o1WfJLNySFW1kZEh9Bvtq9l
 1bT8Ei364CreARtAfWiXs7P9tkMoTRhcA0e2epD31Sr5WZ0ppMD3jSJYrfCLhWSjFpg3
 IBgF4mA+4RoajkUf6OfVEKq37kHIJap3pmmZ7kb+MrF9iz2i8wmE8aXrWFKgBXVK3IUb
 793fQ/fkmBBAyrjaYyRvBB9FyLqXR77jw1SD+DpHNBkXAPzfWaLLoo4RKRB4OKDn7liC
 EmX84w3iPICiF1lUFfCMClFa10oann9FhLJpJyxi56zprkpsf/5/amGGkwZyETYPo7l/
 zdYA==
X-Gm-Message-State: AOJu0YzOolhJW2EbUFYeoU8yGlKAPA4FysRM6Y0odtSE0Bc9DS4HR9r0
 rDBlXhq1fLAdNYWxM9SqVp1WnBrhbCQHvKOGycKAV2giao0oQaVQJXCmfh+snjIuE4pU8zU77CZ
 AhNSgcCw=
X-Gm-Gg: ASbGncsnDmPwxbjl4xDthbkAOWQrqkHMjn2mA8hA3hPmcuxWq9Xk33Ie/Vs6kHrAtHh
 MyXR5tLU9dEIfGw7KHirZ4SOCHQFeoUfxa6rtu5BvlIeMePQFzPJ7paEJi3XDjgt6gdzIXtO0E8
 FwlZugfjLSxJhBxQQxa2bjwq5lTSf/hnN9g5+oagzfNBGjaFRXCluaSQEE2Cy052TTZEXxp7tBb
 yomvQu+s6ECNK61IY/D0yYaV7mHYphAcOGDWRXdgVaMoFqGpjwMF3/EtrNkJSf19KZ0VvRxwkMa
 /viNmBqGzTqiXwN42UFIDjyJMq5V3t7g5BwMGdq6VwRK1s1Pk0VR2kY17PnNnaF+WLYXrUB0164
 0C9dEb4cvmfxyq33nbcRamES9u7Pg8W6sAQAgi1qw
X-Google-Smtp-Source: AGHT+IFOG69Fu52xgibwQRh423sguVXqU81Wbdf1PctRsPGbOo+7PRS9kZaDB3bYWW+JSGHhTFHzFA==
X-Received: by 2002:a05:600c:4f81:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-45365e42db3mr877825e9.1.1750372893345; 
 Thu, 19 Jun 2025 15:41:33 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c16sm40202245e9.19.2025.06.19.15.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 15:41:32 -0700 (PDT)
Message-ID: <47990a06-6867-4f5c-9c52-2770d2bba472@linaro.org>
Date: Fri, 20 Jun 2025 00:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] accel/hvf: Trace VM memory mapping
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250619131319.47301-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 19/6/25 15:13, Philippe Mathieu-Daudé wrote:
> Trace memory mapped / unmapped in the guest.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build               | 1 +
>   accel/hvf/trace.h         | 2 ++
>   accel/hvf/hvf-accel-ops.c | 6 ++++++
>   accel/hvf/trace-events    | 7 +++++++
>   4 files changed, 16 insertions(+)
>   create mode 100644 accel/hvf/trace.h
>   create mode 100644 accel/hvf/trace-events
> 
> diff --git a/meson.build b/meson.build
> index 34729c2a3dd..5004678a26b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3633,6 +3633,7 @@ if have_block
>   endif
>   if have_system
>     trace_events_subdirs += [
> +    'accel/hvf',
>       'accel/kvm',
>       'audio',
>       'backends',
> diff --git a/accel/hvf/trace.h b/accel/hvf/trace.h
> new file mode 100644
> index 00000000000..83a1883343a
> --- /dev/null
> +++ b/accel/hvf/trace.h
> @@ -0,0 +1,2 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "trace/trace-accel_hvf.h"
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index d60446b85b8..b38977207d2 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -59,6 +59,7 @@
>   #include "system/hvf_int.h"
>   #include "system/runstate.h"
>   #include "qemu/guest-random.h"
> +#include "trace.h"
>   
>   HVFState *hvf_state;
>   
> @@ -97,6 +98,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
>       if (macslot->present) {
>           if (macslot->size != slot->size) {
>               macslot->present = 0;
> +            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
>               ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
>               assert_hvf_ok(ret);
>           }
> @@ -109,6 +111,10 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
>       macslot->present = 1;
>       macslot->gpa_start = slot->start;
>       macslot->size = slot->size;
> +    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
> +                     flags & HV_MEMORY_READ ?  'R' : '-',
> +                     flags & HV_MEMORY_WRITE ? 'W' : '-',
> +                     flags & HV_MEMORY_EXEC ?  'E' : '-');
>       ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
>       assert_hvf_ok(ret);
>       return 0;
> diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
> new file mode 100644
> index 00000000000..3c11f69f305
> --- /dev/null
> +++ b/accel/hvf/trace-events
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# See docs/devel/tracing.rst for syntax documentation.
> +
> +# hvf-accel-ops.c
> +hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016llx size:0x%08llx vaddr:%p flags:0x%02x/%c%c%c"
> +hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016llx size:0x%08llx"

For some reason this is still cross-built as 32-bit (although HVF isn't
supported there, see commit 7f800d34aa9c from 2021). Anyway, please read
instead (and thanks Pierrick):

hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, 
const char r, const char w, const char e) "paddr:0x%016"PRIx64" 
size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" 
size:0x%08"PRIx64


