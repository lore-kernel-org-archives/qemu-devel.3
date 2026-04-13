Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E385E93813
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC97H-00025j-EP; Mon, 13 Apr 2026 00:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC97G-00025J-0w
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:41:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC97D-0002MC-EO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:41:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso26315815ad.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776055297; x=1776660097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QszutIL7wDTHLCDNTzcTvkrv//j2mQDdIveZtbTBtCI=;
 b=wu98b1CKnTBpisuaSaj1lGYAIE1prcX6oWbTQoXeOt+cl6vYFdl9bK6j2uSyPTpWPr
 6otwinheWoTz65W2Q3z/Wn03gZ29Iwzx4egP9rI3jZUA3kg9zbf/jItpTJfrg/I3uEoD
 gVXkvV4Lgh4zDn5o7ukSqhwEmPeRvDY22lwuzBfgg7IovO2DJoiSbXBAYzLhjsXR9saX
 vyqgE+KvBVKCr2DQV4Qjr2c2O+W6XXUcydAAp7OZUK/T8lOlO3Cx7YoVEAxqwab1u/vN
 Se77AESoYwz1aX8TgFQ5pD2ceDC+oPWtTgosdhRkV9bd1jgoG54/AhZ78C2OY/RQk/CS
 NL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776055297; x=1776660097;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QszutIL7wDTHLCDNTzcTvkrv//j2mQDdIveZtbTBtCI=;
 b=OW8A2i6W4aKQdoQFEw2zezvIDK1KUpKit1jV1CidB8uNSTIw4oYsvXHnFiQFLlk90K
 ypQOPhCNW6xcIr/caPP5KWA6yVBy6+iiw8CYGuwDYAk+RejfkdLxMWJr4+7FqB5EFqEe
 sIRTvYk/OHJJLdkXbYfJ4veZT3NyfKLKBYtfVnucmE+37yizRDBw7UJD5RFzx9XDWCQU
 BqIeIcSZlAIeTzTfGGXurfGm5RVhfszP6EOzHzpLvjUwgD0sA1IvWhUua0EZt+o5gJxk
 Y3DbXtS5pRFJgPmVglRV/j9FBjdbROXXCFIS9A1meA7Xt1GI9JSJ5eTEqqsN+gIgReI+
 tKpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wq4s1TQqHzUiuFpYBfkBjYvgd8Fk0olDuClX6yi0D7uVaD4Y3UeQsQ8f/8iqAOHhZ2UzL+CNxq4/i@nongnu.org
X-Gm-Message-State: AOJu0YxLU2Sg8tTn9SSBugo+ZQSO+fxDaS1xml1HwMdFK1kZSoVwKcq4
 4XBT0hhJ/d+emSoair8MEKEtH8ntXhv/eZKpK2D0bippZ1qEbUYQl9q9t9oOWDZgkYA=
X-Gm-Gg: AeBDievbinJZnz51d6UGraNFfIOSuV8Ho/spUka+dYkcjaodVPD2W7A9qFInvibncoP
 YfhUplPpf8IY4MIw1vkw0YY4c0uLrvExwT+bvJoyXGyWLwEjHjt3wt9bHu95uiHaJJNq1VdwFy2
 MzzU89JF5ldX9rl8P5/CCUR52vcCypZqkGyggaukZ1i7gIv92NQOkSZy8JRY0Seg4IK33X+hcHH
 JM5tMkgzH5RsBZnY+9Hoy88/oASsO+Ld2yswNytAbw7n6uXlrNslnOEuBmG5+A0ZOILydC8iw5N
 nQkARz8nznhXP0ys3iwTfC98c7osl0kyTPeQVjKQaZDfq1r9T/aEOPlxEDgGlXrV/MMeUFj9XN8
 VDJ5EfbC+k4KK9HECEvlJCQs3C3y+8lsfVLyzM+Hk1JaAyy2VjL1/ZZkzgi4pjfekTiF4/tFEQk
 HFoET+bEXanXvOPN8msF5LAfnAJk1twbrex7cLgMw1GhpCDcFKxLv3qH9RCTwn2KyRNc5bAVwek
 lpKVmOVXCaEAeodi8XIrMr1vvmTSnHC4dLO15NSRz41s4MOFE+N1q8=
X-Received: by 2002:a17:903:2c50:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2b45cb89e2emr30003155ad.27.1776055297031; 
 Sun, 12 Apr 2026 21:41:37 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3a8f7sm101698425ad.71.2026.04.12.21.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:41:36 -0700 (PDT)
Message-ID: <cc224b46-c705-46c7-94b7-b5638bbe3a0f@linaro.org>
Date: Mon, 13 Apr 2026 14:41:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/27] monitor: Introduce HMPCommand::arch_bitmask field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Add the @arch_bitmask field to the HMPCommand structure,
> allowing to restrict a command to a set of target
> architectures (represented by the QEMU_ARCH_* enum constants).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/monitor-internal.h | 6 ++++++
>   monitor/hmp-target.c       | 1 +
>   monitor/hmp.c              | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 3ecd394ecf6..78281928e7a 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -74,6 +74,12 @@ typedef struct HMPCommand {
>       const char *params;
>       const char *help;
>       const char *flags; /* p=preconfig */
> +    /**
> +     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
> +     *     Allow to restrict the command for a particular set of
> +     *     target architectures.
> +     */
> +    uint32_t arch_bitmask;
>       void (*cmd)(Monitor *mon, const QDict *qdict);
>       /*
>        * If implementing a command that takes no arguments and simply

This and coroutine could be placed better to avoid two holes.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


