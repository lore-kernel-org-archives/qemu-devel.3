Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478F6C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 05:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiZD-0001fN-Oh; Fri, 01 Aug 2025 01:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhiZB-0001cs-HE
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 01:44:29 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhiZ9-0000zz-M9
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 01:44:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so1120714a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754027065; x=1754631865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9C/JkD5xbEvtgoXo6+u+Rabvz3jyfICkFaWw0p1jZcw=;
 b=RrGHwrjbXqtModaTQQMLHprLk00vckBYlll/kUANzr1XDqQnj0cbZE4PKO+oUR/ZGU
 4Hvdo/g82lJZrfVbjnA9ckCQ91TyNnxZHqD4GLzspTsLGZFA9RsfhJ/LJg4ir2CQaYWV
 XuDAwLOwOhxOqYcVi+SBZri8OOMYJOOn8U4aC5izvDF9MU8LfTWqhPY7uw5Ok/lTXx+N
 kzHXJiOSUJwkboOSUEb3KSixzKMmOdHIV2NEtNK4DFI4Zz43YDTyBejAaUQMRhzG7+iw
 p/4Xfea6a+g/TsREc/k0nEPrwktF1oYVfozHskvccBl6dRVMCysbQVC+AJSaKlyW61dp
 8ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754027065; x=1754631865;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9C/JkD5xbEvtgoXo6+u+Rabvz3jyfICkFaWw0p1jZcw=;
 b=DooIbjmgN9ricQYLpRaT8bCR15mo8H0UFmwDBpAqWNZKJF3wFOuxcHSJs5oWLBDUhW
 ktLKPlqJwfJNKjy0i5RLMACiXb8i4sdgo12qy6u1Xm+PnIPa9h9phe6B7zlUpnRMWdih
 d/1oggcApglcD2Ngcr3JBLeMMp0C6POATHBtez5eNaPQo8Ac5dEKiWZaV8mXvZJVPNfy
 NHRqmidoR7ML7pNr3TSMi3o5uT43UxV3YN9yYawMphI7xkeged3lTWYbFIC2FxjmH/35
 iTqeRrh9Ge3aW/6D+agdg6WMq9M0Djso6fm5EThhGPhle9rf9Qwyo8mIqnWuJVeNVNAx
 Hrew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLF8x/hu1rdITaf1qcEGeeVukaZN8IyD+J0zyHmRrq4XlnHnuiS+oN0VDtuQqJ44OKCD3ESU7TWzgH@nongnu.org
X-Gm-Message-State: AOJu0YzqRRQbjDdvhIC5Rv2qxw8L2icYar1YnRSfjPDxqvQQQXX8MT2g
 ywWus7kiq9epJSrE9vz5wuLXirw2D300lx5oN+5ZdoWrs/PePi5oemahWAA/jDT/M+k=
X-Gm-Gg: ASbGncv5ZgUnbZ/tRjHbYJ202AlNOCBt2qvnUBBJJjw0lixHbMfAwjEcnAYFMpO2h4g
 w0/k6MVxe+bbOYkn3l8F/xGUMzt+QZ0GkfL8u6F4Aa7pBBeaXHLGeDgUHqVdRsZQy2yE3Nm+3vI
 1j7uw8aXSwlu8dUDwt0kWiHs+GjxWzL8xaILWZdCBUOSh+qX5k5fS3hrNa/gJes2cRx11gcpoYN
 SVc4CDCbTULEB9gNRjaDu6THGw7GTvvqPh7DNZ933gnzmUMOB8JbaxLGG+TnF4dQP308TfGAyPY
 W27nTidhqROgPmhXnBcURAT9Hoo52abXYBRsHX50J5syoNZp3No/4BVBpAWVLTWiFmrHmeA3gek
 IA97fJyeoWy2fnN3XO82G8GiHfymcxGhowbBxOVO9eM0UzXbJsvg=
X-Google-Smtp-Source: AGHT+IGiWOs8I1nsNzA7C9xFXckCp3vuXjp6ZwthbYWySM12XSP8tRS/SRCwl2V+OJJKKWOi3/1TXg==
X-Received: by 2002:a17:903:903:b0:240:3e72:efb3 with SMTP id
 d9443c01a7336-24096b3cfcdmr146630135ad.43.1754027065496; 
 Thu, 31 Jul 2025 22:44:25 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89769e9sm33495525ad.111.2025.07.31.22.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 22:44:24 -0700 (PDT)
Message-ID: <4ea65cb8-f916-4cbf-9540-a2af7548dd09@linaro.org>
Date: Fri, 1 Aug 2025 15:44:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/9] whpx: Move around files before introducing AArch64
 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-2-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731052753.93255-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 7/31/25 15:27, Mohamed Mediouni wrote:
> --- /dev/null
> +++ b/accel/whpx/meson.build
> @@ -0,0 +1,6 @@
> +whpx_ss = ss.source_set()
> +whpx_ss.add(files(
> +  'whpx-accel-ops.c',
> +))
> +
> +specific_ss.add_all(when: 'CONFIG_WHPX', if_true: whpx_ss)
> \ No newline at end of file

Add the newline.

> diff --git a/target/i386/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
> similarity index 96%
> rename from target/i386/whpx/whpx-accel-ops.c
> rename to accel/whpx/whpx-accel-ops.c
> index da58805b1a..364d99b660 100644
> --- a/target/i386/whpx/whpx-accel-ops.c
> +++ b/accel/whpx/whpx-accel-ops.c
> @@ -16,8 +16,8 @@
>   #include "qemu/guest-random.h"
>   
>   #include "system/whpx.h"
> -#include "whpx-internal.h"
> -#include "whpx-accel-ops.h"
> +#include "system/whpx-internal.h"
> +#include "system/whpx-accel-ops.h"
>   
>   static void *whpx_cpu_thread_fn(void *arg)
>   {
> @@ -80,7 +80,11 @@ static void whpx_kick_vcpu_thread(CPUState *cpu)
>   
>   static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
>   {
> +#ifndef __aarch64__
>       return !whpx_apic_in_platform();
> +#else
> +    return 0;
> +#endif
>   }

Better as code movement only.
Save new code for a subsequent patch.

> --- a/target/i386/whpx/whpx-internal.h
> +++ b/include/system/whpx-internal.h
> @@ -3,8 +3,9 @@
>   
>   #include <windows.h>
>   #include <winhvplatform.h>
> +#ifdef __x86_64__
>   #include <winhvemulation.h>
> -
> +#endif
>   typedef enum WhpxBreakpointState {
>       WHPX_BP_CLEARED = 0,
>       WHPX_BP_SET_PENDING,
> @@ -97,12 +98,16 @@ void whpx_apic_get(DeviceState *s);
>   
>   /* Define function typedef */
>   LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
> +#ifdef __x86_64__
>   LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
> +#endif
>   LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
>   
>   struct WHPDispatch {
>       LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
> +#ifdef __x86_64__
>       LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
> +#endif
>       LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
>   };

Likewise.


r~

