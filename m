Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F124C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4i8-0003vT-Ig; Wed, 02 Jul 2025 17:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4i5-0003uv-VC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:09:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX4i4-0001Lz-C6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:09:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so5465212b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751490578; x=1752095378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWTioPkpn6vEIGgg/dK0712FWUBgwS82mHq2Xs59z8Y=;
 b=cxmbC8rOpm2tWePcabSeqxPhoZWO1b65pRryGbLyltw4rmK5s2PFox4GmqMHCi0SrJ
 wbzXPBi4zzZBR+WA/t0Mzj6QIAQWYrXN7F5KueNn068PsGZolcJcHEtrT/AiLJ2eb2T/
 h2k7F4xdBQCrhUnEw8Ejp63Wb2X8+HeZOWIY+1LExdwUX4BR+s5Uo8o3a3D+vZcLNZYQ
 hEqFGbQJKHXLc+pwn8VUaQOg1CvLewJSB11yF6nzi944S3qxwJdCxe4NpkSmBNhVJ54l
 d08PVnh2+F9CTO0JIHIpkF81LO5DgQb9y/iCos/w9Ucu9HCz0878Tkb9bH7eKHb93Dg2
 el8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751490578; x=1752095378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWTioPkpn6vEIGgg/dK0712FWUBgwS82mHq2Xs59z8Y=;
 b=rpra2tGsyIAEVdBMBSz8FTB9EgqeOzv9+ptphIg215mtpTjgFgha194uN32vU4VIhq
 RSBcccYBneoRYjFWVEpDWPYHGUNZZF6oKMrwhUiNAHyz5Lz1SGGzGRNsv27IriSesABn
 Cru3fzhOez2ZcPvnHvOKXLdgqcYKe/uJQohiWeZXYDmXO4Lzfl9A5ZlrMboM5eeljjr/
 wDOgL/TM5FPZxd6ZCvrtdpmY6Qz2rEERMWGIa2ykr+yTVOS0Sw+iMj/2y1BBo6aV4F1j
 0cMy38Tzp2ebMNzjGzT4zZ3lQwJH+5ZTmtVhxJqYWDnnmaDlC7n+OUFT3ZtKnY0bKWnG
 p7og==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+IoZYq0MvZ3asR79BA9OOPnPBxMwwAobl1zt2iUFlGBSia2+njcDrOP5hDCjGnilQ1MNl6SznV7eB@nongnu.org
X-Gm-Message-State: AOJu0YwsOeIEo7qFxJWWWWRXK28kYWJiSGPq0sRYs6fY+O0L4dyM/mYv
 +/UtNehFKgsIp0XFqDFNTC7xzoyfWuxjetaseVvpFuT82/riQ4ALrrLuJgPTihNa37s=
X-Gm-Gg: ASbGncvzxqVWsusLj1tlOsrp0sCgzNO8V0xoE9uAFehSxV1lJ9bG7TE/iMRDKevDt5m
 qDGGroEa+RXOxjy6Rn/Bx4ThpX57zCjj6ySucWJVLyBf3Tu9YeBBMZSpbNxpNR+MbS5094B0rbP
 KgRI5+OapTQqVARW/HffT40VmzcwrL+oZUgcR0C7C3PRa/4P638MpbmLl6oktupxtM70q8Bzqb/
 ooM8hH8s65odmSL84n5wG5UO1t9GMI3ilaknng7Qhi3RX8cRHaGbzW6tQQKVZQcm01EbUo/yA9u
 lEJsG1YuRPoIYoU9OGLjP2lSC+5rW0al+teoBORkSXF/09NfjDz1yq/rrgS1zFuxtK/gLDQOj94
 =
X-Google-Smtp-Source: AGHT+IE0Wff0g4UUwJz1AQk+F9sWVZtls4ht22hb8f81hLUNbb4VEIZ3qX77UapQ3CJlQovQ+xDAmA==
X-Received: by 2002:a05:6a00:4b10:b0:74b:4cab:f01d with SMTP id
 d2e1a72fcca58-74b5149bbfamr5664346b3a.12.1751490578419; 
 Wed, 02 Jul 2025 14:09:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c8437sm14578367b3a.115.2025.07.02.14.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:09:37 -0700 (PDT)
Message-ID: <5a133a79-00d7-4b6c-ab9d-cac3f1233013@linaro.org>
Date: Wed, 2 Jul 2025 14:09:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 65/65] accel/tcg: Unregister the RCU before exiting RR
 thread
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-66-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-66-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> Although unreachable, still unregister the RCU before exiting
> the thread, as documented in "qemu/rcu.h":
> 
>   /*
>    * Important !
>    *
>    * Each thread containing read-side critical sections must be registered
>    * with rcu_register_thread() before calling rcu_read_lock().
>    * rcu_unregister_thread() should be called before the thread exits.
>    */
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 2 ++
>   1 file changed, 2 insertions(+)

This is on par with what is done for other accelerators.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


