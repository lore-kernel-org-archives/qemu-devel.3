Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B5BCF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 16:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOHl-0004uq-SI; Thu, 03 Oct 2024 12:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOHC-0004hn-Uy
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:02:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOH7-0006GH-V0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:02:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so11276465e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971314; x=1728576114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wsMiMT8c5c05sktyAKnP1D1u7YYmXbDWu2JfmLDGnWA=;
 b=hDhbG7pTLe+3KOapXpSNviCYvZ2nx8nU82G2vxMsPpkvK0hESOcwfPVRfNP7/qtuaG
 NT5xrNv15KCkqLmqa4diY/s2Bh5BkWbJ8BxyCC7QBEpce4+6A67iX7a+piDT+8x13PmM
 oNNwGYT3uFqd/W0yuk/b3ZHrC4KcfJFqWdy89Nw7LCOwK5uyYYIbciWZAO2CBNd+cN+a
 iYobL3ZvU9pGdEjn8B0w0p801DYsSXeLGDeh6kpOzOQf7aI2BPxqiIRnUkAn5nL2q908
 f5REmrBNzu+4OOCSffPkYZ2JXofvT4PmVUbjxHrni+bRhU49meqg8PH4i5sZuvshhSo9
 IQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971314; x=1728576114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wsMiMT8c5c05sktyAKnP1D1u7YYmXbDWu2JfmLDGnWA=;
 b=RyYHgpa50kQOJqohaYvj1Ph47abTlI8jxlk+m3na1XzN7u99DSeOABNZ3drRnRMtRy
 wxlv2g/9caJ0jZp6xr87oMqPHWvYbrk+W/gncS696nAxA/pCv1rbIDDwFFWthDu+rHWa
 gLP9o/ztYrjEum3Wez4cyjVkuhNYp7yjYaFZO5OADd9oVXzmB1noKNyg52LhgiKN/mS2
 Qv1Tr1Bp246k2o7H7Dw7xOOjAYDd8pkEEVfI13Fn0XKcGr9LE5LjCtJDUcxw7vFtLd6j
 QlmzAIuD4WeO7gVLwbiq4lQ5+id6m2hjg9/HT5gkvQjrqoyRB8cJn+opVHqvAMtGWxDU
 97Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWunOWzcCd7NegipU29/2UHV96MJWmfjkWdHmyrIDPHnqPEqpCrVt9ycSKHhRJ76+Y6Inbz3IaUzgsR@nongnu.org
X-Gm-Message-State: AOJu0Yx/DgveCeTOL7+avQNvnLPGb4vNGZSEXeciBoLdn9JRCqOu0hof
 YgE8IBki+69o+naI2mY+TeW7gyoIpPhjOvl86onqoXbp7yOkafpNyqEQQ1xy7F4Cp8HvGjSmZ8u
 XnRk=
X-Google-Smtp-Source: AGHT+IHi5aZ/ZhfgjVyFeor97ZAo0syDX9O5zVgmtO+9Xf2s9L46XBuik74YNKKxuvkkoXiwepLJJQ==
X-Received: by 2002:a05:600c:41c6:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42f77947e1dmr57384515e9.18.1727971314021; 
 Thu, 03 Oct 2024 09:01:54 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02eadbsm48374415e9.39.2024.10.03.09.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 09:01:53 -0700 (PDT)
Message-ID: <bc7f9c41-2b69-4536-bc5a-218c1efeba87@linaro.org>
Date: Thu, 3 Oct 2024 18:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Mention post_load hook restrictions where we
 document the hook
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20241003143401.1676548-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003143401.1676548-1-peter.maydell@linaro.org>
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

On 3/10/24 16:34, Peter Maydell wrote:
> Accessing another device in a post_load hook is a bad idea, because
> the order of device save/restore is not fixed, and so this
> cross-device access makes the save/restore non-deterministic.
> 
> We previously only flagged up this requirement in the
> record-and-replay developer docs; repeat it in the main migration
> documentation, where a developer trying to implement a post_load hook
> is more likely to see it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This came up in an IRC discussion.
> 
>   docs/devel/migration/main.rst | 6 ++++++
>   docs/devel/replay.rst         | 3 +++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 784c899dca6..c2857fc2446 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -465,6 +465,12 @@ Examples of such API functions are:
>     - portio_list_set_address()
>     - portio_list_set_enabled()
>   
> +Since the order of device save/restore is not defined, you must
> +avoid accessing or changing any other device's state in one of these
> +callbacks. (For instance, don't do anything that calls ``update_irq()``
> +in a ``post_load`` hook.) Otherwise, restore will not be deterministic,
> +and this will break execution record/replay.
> +
>   Iterative device migration
>   --------------------------
>   
> diff --git a/docs/devel/replay.rst b/docs/devel/replay.rst
> index effd856f0c6..40f58d9d4fc 100644
> --- a/docs/devel/replay.rst
> +++ b/docs/devel/replay.rst
> @@ -202,6 +202,9 @@ into the log.
>   Saving/restoring the VM state
>   -----------------------------
>   
> +Record/replay relies on VM state save and restore being complete and
> +deterministic.
> +
>   All fields in the device state structure (including virtual timers)
>   should be restored by loadvm to the same values they had before savevm.
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


