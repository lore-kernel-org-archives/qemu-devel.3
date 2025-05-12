Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CA7C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 22:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEbuD-000866-MM; Mon, 12 May 2025 18:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbuC-00085u-Oy
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:45:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbuB-00019g-5z
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:45:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e45088d6eso64089945ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747089949; x=1747694749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzwUHhWNYoyY1y8OeA3qJS4ZNPC5WuZvBSYUofeSJwk=;
 b=SoCF+Xf1sf8E/hK86DN9ypKWDVI4xvmSr5cMxcjcYI0UaxwfeBuYXRjjccI94yyOD8
 4ZUrcLKIxcET1HZzGJWxM9Zc++CngDqBWQ7NUWJS4uvbnvJfQ/f/vltPygiFFspc4v3G
 J7JcDVgft4q86IQiZe1ynJNDwEZByr0yXI4MwVMOmW7yFvGytl7n9DZ0uj/jJ1youGyb
 bJtvw5jQQIjZQM/8DDwvd8sHe2Nwroc7fbvER3l6ajDYD9HHIcMeqW5vzWIIP6FPmjj7
 bHeGPQX47zksy+JuHCHkW8yk8mywFG/nU8Tng+X3941/7O/W5TKYEIjEaVexegGMazqM
 xhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089949; x=1747694749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzwUHhWNYoyY1y8OeA3qJS4ZNPC5WuZvBSYUofeSJwk=;
 b=U+MQmdTJSh/R9ipDbwpbrUofteyFVDgzPUx6Vhrfo7uxBJnOrGEJiHAI5XCnDbqeMN
 9EW53bUBDN6afnQktfjNuLgrjhVvFZsTne4WS21CTYZIqhAKECwSJ2B3peilwq8FPOym
 dMrHlpvtrTkkTiwTQ42HhE/lejAzXd5frOFZDXV5XzYrWqdbYPt+wavCibCBlqWtChoF
 CIDnz+HxTcdQY6Pg8MMf3PckXvC9LOTh8MzumcTkB4Oxu9nGtRwrRq/wJ71DnM0Q8zug
 SfUUc5TsnRPcWRS5GbRGrfo6o+sJ5hHmCYCfKwSCH9zctWo0IeGAxHoc3JdFs0gZPMmb
 Idwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUXcES/aEy44D4xqondYKZBbtbAVmKI8uUTouHGB0t1kD0y2bDHSB6tY0Uodu+TPdtcnucL4QmQHiB@nongnu.org
X-Gm-Message-State: AOJu0YyyN4xKjrf0hFHn0McXWV0RlWvTLXudGWAtZ6WodCD9eHP1xQLp
 fVb+Ya2b1ux4StsTPzqnc+AGDBvPjJnbY8M8dGGFFRPImTV7gRD/5snp3JMQaXg=
X-Gm-Gg: ASbGncu3cyu716Lyh4cruc5H3dulPLhzvgmV+2lJJsCuH66J2/++zETRzaAITFabgkk
 AeKDsvZaZY55Wk95uiXNwtS070ltq3DyoDWyhrOO1Mh168ZLXnvjFojVvSDEacWygqVGDycdhrq
 MS1FohuWZvXKPMClmMtMRPVsc/FJXTKwZbThM5/VEEXGByXq1weVJkmwE4l8+IvDwWQAkkF55FB
 pBubuAp61UWz25i1iI2rTrRj70KA6xxRIHoRiXwBTm8XOQ+FZVr+jsR2tcfisSlUOu/8LnQSsGG
 b/okgrcsS5Z2nJLGiIh8hiPLDWIoe8oNvR61OkJG/MfwyihlF8xMziIVxkf4mjsKoMK/T28BCJs
 =
X-Google-Smtp-Source: AGHT+IHZS/PYo2S5oRqUukxHaO3XvNOGFU9EurL6jGwFbAr1GuHo2A7K1BAgNYzgWREmeMvYGf6LjQ==
X-Received: by 2002:a17:902:e88f:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22fc91a56b3mr208812685ad.51.1747089949484; 
 Mon, 12 May 2025 15:45:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7743633sm68495695ad.103.2025.05.12.15.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 15:45:49 -0700 (PDT)
Message-ID: <fd63b27c-e1e2-4741-ab86-911c14a27bca@linaro.org>
Date: Mon, 12 May 2025 15:45:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/23] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1746968215.git.neither@nut.email>
 <4ed6d35c186719fd20d4abe5c73b80b0901a96fa.1746968215.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4ed6d35c186719fd20d4abe5c73b80b0901a96fa.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.25,
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

On 5/11/25 6:13 AM, Julian Ganz wrote:
> We recently introduced new plugin API for registration of discontinuity
> related callbacks. This change introduces a minimal plugin showcasing
> the new API. It simply counts the occurances of interrupts, exceptions
> and host calls per CPU and reports the counts when exitting.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   contrib/plugins/meson.build |   3 +-
>   contrib/plugins/traps.c     | 100 ++++++++++++++++++++++++++++++++++++
>   docs/about/emulation.rst    |   8 +++
>   3 files changed, 110 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/traps.c
> 
> +typedef struct {
> +    uint64_t interrupts;
> +    uint64_t exceptions;
> +    uint64_t hostcalls;
> +    bool active;

The scoreboard is automatically resized only when a new vcpu is 
initialized, so if an entry is present, it means it's present by definition.
Thus, you can remove the active field.

> +} TrapCounters;
> +
> +static struct qemu_plugin_scoreboard *traps;
> +static size_t max_vcpus;
> +

You can use qemu_plugin_num_vcpus() instead of keeping a copy of 
max_vcpus. It returns the number of vcpus started, which guarantees 
you'll find associated entries in any scoreboard.

[...]

With those small changes,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

