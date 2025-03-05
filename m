Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A56DC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpf1L-0003vC-6s; Tue, 04 Mar 2025 22:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpf1J-0003um-Ob
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:02:05 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpf1I-0008Ll-6n
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:02:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2234e4b079cso115820145ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 19:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741143722; x=1741748522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVDL7FLxOjOebsqm4MqSe7HW+6u9dj8wBRiUq4/8XFk=;
 b=gxkT7xVNmmukKCF+ItYCcIp4gYrgNiGOrKFOllOwHPqI+fb751s/tY7p8JGSzZ9+9E
 2W11w+ek9s5W+9IgsNuZBq/33z9MEp6EaS0EEDxTaQH5ruJBwuW3pZKseTm05KzjaY46
 HjwdGopwizKqNquAreXRMcE5QUg8m5lS4ZJnP5QtRLiOEKWRT/ZAPhw4ZgIRUwRODT1C
 llpHdjvCUN1J36gCTi0WeLRpEHc3QHE0BSe4AEP76hn4prsyQcF409qWM/HJkMvEGNkT
 Ezr4TIhEkGSEFSaXfzUz8vnj3Le0yol1AVG/eWkXS6dVIpbAGlE2T+g6Ng6nFxFHj1pN
 hTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741143722; x=1741748522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVDL7FLxOjOebsqm4MqSe7HW+6u9dj8wBRiUq4/8XFk=;
 b=kOVH1N0ivtA2FwKQs2BL39kwRZ5bOna9pJ1Tetu5nvEtRbgMbRlWD0kMQX6169T3KK
 CapUiDRBJVSKZDOZEfMmspjH4udh2PPtAbijE40aKgvYUhDustvoKV0Gcrdvvd2vhl7Y
 oz2Zke4OPhxeu2Q2HkXJUSZVZB5UO189T9ZbhGCX1BrqIulCVW/FGTXpZfGSBH3ZB3UJ
 H8u4AOpVFVC+9nY/AVHpv5cKssAxcMtB2QxapsgaU9ENAWnBBp9Td70UYHZDRXDXPZ2r
 3hadKpbmoMWPXAzXWZQkV8vIV4l2M9A/6nUAsuOltGaGRdeH72LpgKgWd/ItMHP/eb47
 tGWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtuAKzSWgQiiTODbCGpgJ8p+O8PzFrOeFDC8lBMoXQIf0trkg73b5KFjaDhAuTF1iWRsPOH7DUiGWB@nongnu.org
X-Gm-Message-State: AOJu0Yw1aUvmm9lJr3nnzRwKdu5GgPCdVx3J+lEDRH4vS3Wv7B1Vtitn
 otlpJaN6O/XP8i/IOt56reNkOyJWTrEeQ/nwtpffdmP8ct0GPo8u9ro74aYfXcw=
X-Gm-Gg: ASbGncu2bMnSMCXykzhQtcrXH3s15rYGPdMQ23RwQGjhZCSfF4PTP4SGMbD/9BBsnPA
 YDWBAMroCOgjYNanz9+yaQz8Xb84BM8xCRnMo9lf2eKtVJ7AFb8rUbz7eRrpT7BMWXb7SYQwoA6
 Ahog24Gq1yRvBYO7CIhLy90wmOW5aVE2wwiKLH63DKyONjbSkjviOzDshgXYU0gJeYObbjkVK3Y
 CF0L0VwrTQC6Uz13xL/6WTNcMVYD0wuLpp95DRDkIs5a1sgp/+ZV7WmDDyZZsOoZ0Vgk0fEMBkA
 dTZRlewH4w+SxikhJeOde3drRJJOXvYZKbZDLogpuQezNNu6TIkUsLWgfW7r8vb7Uxh/ONg3kwi
 1DTggXTfn
X-Google-Smtp-Source: AGHT+IFuek9oFEjrfHECfHVoasmukbdcmUbjMH/SWXaF72SfBc/D4AFEfEoZcz2V7Ux9mc3uEzvn5A==
X-Received: by 2002:a05:6a00:983:b0:736:64b7:f104 with SMTP id
 d2e1a72fcca58-73682b5a3f3mr1739948b3a.5.1741143722262; 
 Tue, 04 Mar 2025 19:02:02 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe4894bsm12203365b3a.55.2025.03.04.19.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 19:02:01 -0800 (PST)
Message-ID: <f1660789-d774-43fc-86d6-12ff99b2cf95@linaro.org>
Date: Tue, 4 Mar 2025 19:02:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/11] tests/qtest: Replace TARGET_NAME ->
 target_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -18,6 +18,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/arch_info.h"
>   #include "qapi/error.h"
>   #include "exec/memory.h"
>   #include "qemu/main-loop.h"
> @@ -83,8 +84,8 @@ static GString *qos_build_main_args(void)
>           test_arg = test_node->u.test.before(cmd_line, test_arg);
>       }
>       /* Prepend the arguments that we need */
> -    g_string_prepend(cmd_line,
> -            TARGET_NAME " -display none -machine accel=qtest -m 64 ");
> +    g_string_prepend(cmd_line, target_name());
> +    g_string_prepend(cmd_line, " -display none -machine accel=qtest -m 64 ");
>       return cmd_line;
>   }

You're not constructing in the same order.
Swap the two lines with prepend.


r~

