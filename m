Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E42C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKGA-0001ck-JW; Thu, 03 Jul 2025 09:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXKG8-0001cN-7e
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:45:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXKG3-0003bg-SX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:45:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so44890275e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751550345; x=1752155145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bzgfIYKT0pu2euhC4Y01ktX+iPTZDzQ4TCdcNhT2AOU=;
 b=FdpcLM4+yZ5EaxvyUSAVXm9jT8KXPL/sVouoZSydt0kxKF4CQbZHuYlE+n47PzdztM
 CssBZoUJe6Glk9jYDym8+lHRwDKkogE1dn1oWwFuwsLSlgU1+fgptMh9Rmf+pD1iRUY1
 FJdY4b0IE+tLy2X43Kg+nU+6yb1MShUFSmsEATd9ltuF6UijOkRJCf0Bm4t20SIdjR/X
 7MiBeDnycdlC8vE1xYFZOrIxznE1umizRGquRonwhMT8r5MJrhbPZadWMzbPsTyFVl/j
 I+yPo3Krab5dr4Mi3l7IIdu3yEIqTyW1l7OBNZ/fqD5V7PWjBWW9uI8oXPOB0TJ9P7uo
 w5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751550345; x=1752155145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzgfIYKT0pu2euhC4Y01ktX+iPTZDzQ4TCdcNhT2AOU=;
 b=h9nCTlQ/jlrBw4CoNQOtDW+LRFWXvFRB81wtwsiao12r4/gL0v8aJro6SmM1YBMhMK
 Ya9JmTC15li6oLNexe/k8jZXADlEU3HVVMe4J5bqJvwKbJo4+5KJqtR2pttB+V8q4B2v
 PJKbDPrfVAf+biSmTHsz0tdIjh2JqyxzqO/UdbgCslGMDgZqQy7rjhqzZDbitdTmUF9o
 d3NM7WrSp0ZI0Qndbtr8NtXd870YPsvEk5DpYCcAOI+BdkgvAAqJ9Z4xWcNNnxikkYA6
 w6zh45N10OMR9BY4+8SWtxaD/u2pSFl/kEz9C8MhfvextwMPq1VZNBZgFDZtRvqJjfKg
 c0yg==
X-Gm-Message-State: AOJu0Yxv4v/otOeDJo70sxoch/fDxg95UNcUHoJ6oQ3bq1vy9j/f/Rsl
 qSM6aqIRvuko+rv0xQhhCEFaxgtMQ4fx5nGURWnZlc+hfsbPotsW5g7YId5VyVuVf5upaXlWImy
 NZs+GQVo=
X-Gm-Gg: ASbGncv2lg1KZqiBNVdhBTgoVD+eW6hX9Ed1gIKlw0kB03ZqIMzqLcvuyRCz71HMhGB
 MuvYwKFbNGf0TcEyCRwmf5zkqlO0Gf0UZz22L6gY4lI+SicpCr2QFx9oeOWbyBpB7Xuqy/MEoKB
 gHa3NGka3w5raO/57k4bhNzUZvurhgNeJbtMuoFEjcJOqyBtPHwg2a7/MEW6r/b9vg4JA0Gzs8t
 VA3gxWYp7HMi7FWjD9GEAqkEIm7PM6HECvOGhq983v/rP7Zhx2/IYtsDhiH7b8bHB6PGrU2m/5J
 Qil3jpJgT2Tk6Dio3tGd82Wwxb8W0YhNpC2zEcc2R/JWzfzb7AkTMP/rgRpstWWXbqrOTd6s3bn
 FdO/+gZA3VWs0XO5CWNq1zu2K5FfXOg==
X-Google-Smtp-Source: AGHT+IHIBfzPNtmnIof400Agn8RwX1HvW/bLZV3KILkNnKHgCIfoputch4xZsSGQwe362Ldh+mT2Sg==
X-Received: by 2002:a05:600c:8b10:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-454aa80da70mr34354995e9.12.1751550345370; 
 Thu, 03 Jul 2025 06:45:45 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f34csm18323235f8f.85.2025.07.03.06.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 06:45:44 -0700 (PDT)
Message-ID: <364dc354-ba78-47c6-ac65-2c0282e28733@linaro.org>
Date: Thu, 3 Jul 2025 15:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/69] target/arm: Use generic hwaccel_enabled() to
 check 'host' cpu type
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-48-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-48-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/7/25 12:55, Philippe Mathieu-Daudé wrote:
> We should be able to use the 'host' CPU with any hardware accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c | 5 +++--
>   target/arm/cpu.c          | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index cefd2352638..ee5eb1bac9f 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -30,6 +30,7 @@
>   #include "qapi/qapi-commands-misc-arm.h"
>   #include "qobject/qdict.h"
>   #include "qom/qom-qobject.h"
> +#include "system/hw_accel.h"
>   #include "cpu.h"
>   
>   static GICCapability *gic_cap_new(int version)
> @@ -116,8 +117,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           return NULL;
>       }
>   
> -    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> -        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
> +    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
> +        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
>           return NULL;
>       }

Consider the following hunk squashed:

-- >8 --
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index eb8ddebffbf..bdd37cafecd 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -456,7 +456,8 @@ static void test_query_cpu_model_expansion(const 
void *data)
                   "ARM CPU type", NULL);
      assert_error(qts, "max", "Parameter 'model.props.not-a-prop' is 
unexpected",
                   "{ 'not-a-prop': false }");
-    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
+    assert_error(qts, "host",
+                 "The CPU type 'host' requires hardware accelerator", 
NULL);

      /* Test expected feature presence/absence for some cpu types */
      assert_has_feature_enabled(qts, "cortex-a15", "pmu");
---

