Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5D8D7833A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAH3-0006yH-CV; Mon, 02 Dec 2024 12:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAH1-0006y2-F6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:51 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAGz-0001fY-OZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:31:51 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea4f9825f6so1946254b6e.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160708; x=1733765508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVRbtBMpT9Pl4abyCO289m/wQ1u1XGVEpn8gl1amAjg=;
 b=nHBw8duGe4HJg6Q6lSdOgM4EXkrm5VNJqwp+NTZFJ4kC6mLGg1yERwAWz1EpQAvUsB
 C/HNskMRafS/UA8nzqLBvQh6oPX/cudSga0I81QJhEDPrbIuRqGu2gZ1YJcnb9e+MG/i
 2Bk541I7k0lb4MFwTcUQHm4yUJZ0Ge0s72jaSYFhI99l/vNoc76di12yZLcPmJH4GL7S
 Xptkk1YvD8KysVT3HJFgHA1PlkhH9LxjFkAT9LoimcXb86O5mvIjop9BHhXvx0upb321
 bGNe8FQmhecX0MwMtybc1I/QbY48+MQX3Vjc2hLMrafbEsuIry8qCt+mUgGRBMrE/Bgg
 zQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160708; x=1733765508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVRbtBMpT9Pl4abyCO289m/wQ1u1XGVEpn8gl1amAjg=;
 b=iH5YzUozNJj6Ut/ByZ3Teejn6XpRvr8LYWcbTt6gCC/YytqgzHFPf4OwqrTEXMydGF
 OHaqxYrYm2KEcr9ssCl6NdITyg6o7anovXTo9HCU102QFfe6vv1VD5v4wPc14b0wepzu
 pgncVVWj9OBC+BpmLJCvlXvRPn430M/z8pUc7xD18+/PQ89eqJsS5apGWbsRyt+IfAEp
 IeYSO2It8GtZFxjq4ARWxfigHq3NcrraOVz1/ugDcVtQSD7BhYey8OzN9gsNFYq9+JjH
 bbZf/bWllyY01rxIkz/miYVnL/yjcw7/3q4Q6qSHxXoSSp8jrcSc83HdqcSQNyRYM+BQ
 lY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpXPyHH4XPCeCUwB3KL/Us5kb4vkNhxMXuwy3Uaqpsls2ViCcpx1g/KXlnJ4K/nl4d3/J9XB2inyNC@nongnu.org
X-Gm-Message-State: AOJu0YwLMNcFrnEsMM2asVRVD+4wt80ZFUzT3RIKTdlo5aiiG4V6krVF
 6mNURxv81WpzuPrcfJg57ekRDmqI4VkXMS2ZCyC39qTByG+421sbRKn7UnK//W8=
X-Gm-Gg: ASbGncsZrQgRX+oik90YF74TP8WrBeRRmMg35FAj4EJH/P7FIS9e6bnvjyd/s6FpBQ9
 zD73g6IMWUAtsum9Kqq6SAthCvdyZeA7HzkpUQnU3ejv+dFPc+f6wS8RtJjmr8e8vG/LMRuAhcl
 E1uuzbUXKWH1N+k5fqlVbDI3rHbAQ/qYIL3NdesMBb/8NmZyJWsSzTranNjlqSpj1COPo09z9Ua
 Tac4IrTdeKKG3cbt5mQQ5o5xSPdAHCTw+e+NbfmCv6QCeprHw95a445VFNf/Rf9UgwXmT0=
X-Google-Smtp-Source: AGHT+IGX7KHQogLkxKX79PGljGXpdY+uQZKsRtqd6EO5GFjioHla9fxd+ByMUl6DN/21D11Dw/7FgQ==
X-Received: by 2002:a05:6808:18a8:b0:3e7:61e6:8113 with SMTP id
 5614622812f47-3ea6dc278b2mr19937289b6e.23.1733160708557; 
 Mon, 02 Dec 2024 09:31:48 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86346f18sm2381778b6e.49.2024.12.02.09.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:31:48 -0800 (PST)
Message-ID: <ecae2fb8-e421-4836-9d1a-d1a6a7bc56e6@linaro.org>
Date: Mon, 2 Dec 2024 11:31:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 44/54] target/openrisc: Set default NaN
 pattern explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-45-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-45-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for openrisc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/openrisc/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index b96561d1f26..3ccf85e95f0 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -111,6 +111,8 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
>        */
>       set_float_2nan_prop_rule(float_2nan_prop_x87, &cpu->env.fp_status);
>   
> +    /* Default NaN: sign bit clear, frac msb set */
> +    set_float_default_nan_pattern(0b01000000, &cpu->env.fp_status);
>   
>   #ifndef CONFIG_USER_ONLY
>       cpu->env.picmr = 0x00000000;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

