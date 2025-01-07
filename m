Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B0E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 18:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVEQA-0002TS-JI; Tue, 07 Jan 2025 13:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVEQ3-0002So-Kt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:35:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVEQ0-00023h-KJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:35:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283dedso157749605e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736274907; x=1736879707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=167vkgXi+p1l5XuKD9ozI0rWzBdU1wiwKN1ml5juTVQ=;
 b=iJGgYnas5dfhGAssRV9ooK4/FKJxJs7xTTEJPaUCCjB1TZj6VUR2ijR4Rpyo4vXmiw
 FUg7G85t+WxQjzgTWnQfO6rN4U6IEb98kzgHQLbKvZdHeUuv2CwdDH+ywrinFzwLBlga
 F2yoj4nb93ble1jmdlDoJv7NtuFhbgGSW8WF7Iy+RX0MvlYjovn1/tMMLlxZmDzq7ri8
 rJ0iG33b6uWd6y/XcZncIRjfhnNzIjWHTIDFmeFdmXAEoCtRUZf8V4ILop6tZy+DySOo
 dVHmqd2jiZ5Vg5j49ouaX8g6HDksX7VLZDRnOQaLBASD21Zar2cYho948/kOOPcHw2PR
 nStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736274907; x=1736879707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=167vkgXi+p1l5XuKD9ozI0rWzBdU1wiwKN1ml5juTVQ=;
 b=PUnU/JsK/XbbFgMwSyTcTjldhQ5T6cARaYefCm8f1+by2sszrtT+vRmtN2KBuGTqIs
 dIfsUOBqsZgDf8MTqwuztU59rOGPDeYv3oKadph4biWMrpV232Dh3fI/zoLggX+cZdyb
 0wIsE3gt7H6xDOGqSWMGDCni2gCGzVAm13Yzh+U9HP3kIJVcQ5muW2E9XWunDjm7U36W
 gdKdStQ0hIUeYbEVpoaVru1LfHeUfVb9miuXLIByY8Fs348yk8z3px/sXBz28Gh9rYQO
 IFzcHjL1eWfHa67XmteEWAxDPCUycj8v32m/gxA78rlkLlVl/B25sFUVDh8W9B92kn6t
 ecFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJG2SzrcKJrwOVhQ7yhJKn+xXQDi2g65uazGz7SYcfs8XrJk5KFHgInhOyBobXutDgNuXnG6mbYQp/@nongnu.org
X-Gm-Message-State: AOJu0YyOA02HQ1D5D+ImFKtz8jdoui0heeg5XkF4Sl5K9XrN3dtBWahg
 r6cDVAjCSQ1QQ2Behu7Nrq647bBmFksNab1hxucq0U1F8W5zobCi0yIqV1uCZiw=
X-Gm-Gg: ASbGncv7gKDsoN/8GfC3Xdwgj9W35nbMm4L244DGlyrDH4QEBEbJ8FCxzjQ2oIe0k7V
 5WKUoTGo2OROL7IWG1MvxY71KA5U3/xy4uj5llqbml03D7Go/PZTZsi6K/cVwVhcbYClivjCL5Z
 ryyq+50GRvY+CmV9tE91hhz3//FkURAPYaj7A7gNw9UueC8MRT8p9DqFeHLY9NK+zEntSUBB6Mg
 i5N/XplO0JiE8N5V5xiicBO5ZpbuxgbQ0LAkvCbrH0r9By4mQanjdL9CWwQ3nlDHTOC5rrbpvSc
 yIDRYYndvnLcpUcYQTtMIkWD
X-Google-Smtp-Source: AGHT+IHOMgFPJTfbscvpYOsBqU3NX1ecv4i9MYoxHQvhiApDbGSOmHbGI+XOfXwUouL3JmdSDpJ9Fw==
X-Received: by 2002:a05:600c:3150:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-4366835ebefmr500410505e9.6.1736274906846; 
 Tue, 07 Jan 2025 10:35:06 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a2432e587sm47157880f8f.95.2025.01.07.10.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 10:35:06 -0800 (PST)
Message-ID: <77ee967d-00e6-45fa-a8b1-42192e61b553@linaro.org>
Date: Tue, 7 Jan 2025 19:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tests/qtest: Add API functions to capture IRQ
 toggling
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 armbru@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
 <20241216141818.111255-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216141818.111255-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Cc'ing maintainers:

$ ./scripts/get_maintainer.pl -f tests/qtest/libqtest.c
Fabiano Rosas <farosas@suse.de> (maintainer:qtest)
Laurent Vivier <lvivier@redhat.com> (maintainer:qtest)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:qtest)

On 16/12/24 15:18, Gustavo Romero wrote:
> Currently, the QTest API does not provide a function to capture when an
> IRQ line is raised or lowered, although the QTest Protocol already
> reports such IRQ transitions. As a consequence, it is also not possible
> to capture when an IRQ line is toggled. Functions like qtest_get_irq()
> only read the current state of the intercepted IRQ lines, which is
> already high (or low) when the function is called if the IRQ line is
> toggled. Therefore, these functions miss the IRQ line state transitions.
> 
> This commit introduces two new API functions:
> qtest_get_irq_raised_counter() and qtest_get_irq_lowered_counter().
> These functions allow capturing the number of times an observed IRQ line
> transitioned from low to high state or from high to low state,
> respectively.
> 
> When used together, these new API functions then allow checking if one
> or more pulses were generated (indicating if the IRQ line was toggled).
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
>   tests/qtest/libqtest.h | 28 ++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 8de5f1fde3..dfe3139a88 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -83,6 +83,8 @@ struct QTestState
>       int expected_status;
>       bool big_endian;
>       bool irq_level[MAX_IRQ];
> +    uint64_t irq_raised_counter[MAX_IRQ];
> +    uint64_t irq_lowered_counter[MAX_IRQ];
>       GString *rx;
>       QTestTransportOps ops;
>       GList *pending_events;
> @@ -515,6 +517,8 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>       s->rx = g_string_new("");
>       for (i = 0; i < MAX_IRQ; i++) {
>           s->irq_level[i] = false;
> +        s->irq_raised_counter[i] = 0;
> +        s->irq_lowered_counter[i] = 0;
>       }
>   
>       /*
> @@ -706,8 +710,10 @@ redo:
>           g_assert_cmpint(irq, <, MAX_IRQ);
>   
>           if (strcmp(words[1], "raise") == 0) {
> +            s->irq_raised_counter[irq]++;
>               s->irq_level[irq] = true;
>           } else {
> +            s->irq_lowered_counter[irq]++;
>               s->irq_level[irq] = false;
>           }
>   
> @@ -999,6 +1005,22 @@ bool qtest_get_irq(QTestState *s, int num)
>       return s->irq_level[num];
>   }
>   
> +uint64_t qtest_get_irq_raised_counter(QTestState *s, int num)
> +{
> +    /* dummy operation in order to make sure irq is up to date */
> +    qtest_inb(s, 0);

Isn't it better to simply call:

        qtest_rsp(s);

?

> +
> +    return s->irq_raised_counter[num];
> +}
> +
> +uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num)
> +{
> +    /* dummy operation in order to make sure irq is up to date */
> +    qtest_inb(s, 0);

Ditto.

> +
> +    return s->irq_lowered_counter[num];
> +}
> +
>   void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
>   {
>       qtest_sendf(s, "module_load %s %s\n", prefix, libname);
> @@ -1902,6 +1924,8 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
>       qts->wstatus = 0;
>       for (int i = 0; i < MAX_IRQ; i++) {
>           qts->irq_level[i] = false;
> +        qts->irq_raised_counter[i] = 0;
> +        qts->irq_lowered_counter[i] = 0;
>       }
>   
>       qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index f23d80e9e5..b73c04139e 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -389,6 +389,34 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
>    */
>   bool qtest_get_irq(QTestState *s, int num);
>   
> +/**
> + * qtest_get_irq_raised_counter:
> + * @s: #QTestState instance to operate on.
> + * @num: Interrupt to observe.
> + *
> + * This function can be used in conjunction with the
> + * qtest_get_irq_lowered_counter() to check if one or more pulses where
> + * generated on the observed interrupt.

Missing to mention a device must be previously intercepted with
qtest_irq_intercept_*().

> + *
> + * Returns: The number of times IRQ @num was raised, i.e., transitioned from
> + * a low state (false) to a high state (true).
> + */
> +uint64_t qtest_get_irq_raised_counter(QTestState *s, int num);
> +
> +/**
> + * qtest_get_irq_lowered_counter:
> + * @s: #QTestState instance to operate on.
> + * @num: Interrupt to observe.
> + *
> + * This function can be used in conjunction with the
> + * qtest_get_irq_raised_counter() to check if one or more pulses where
> + * generated on the observed interrupt.

Ditto.

> + *
> + * Returns: The number of times IRQ @num was lowered, i.e., transitioned from
> + * a high state (true) to a low state (false).
> + */
> +uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num);
> +
>   /**
>    * qtest_irq_intercept_in:
>    * @s: #QTestState instance to operate on.


