Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D193AC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNzv-0006cm-Fu; Fri, 23 Aug 2024 02:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNzt-0006al-LG
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:42:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNzr-0007oO-W0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:42:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371bb8322b2so758327f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724395326; x=1725000126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ab1lZ6ALzabLfsNKA10O1rqTDvAbnO5lJaNDTwXEERk=;
 b=vW1S4ifnlOYWthTEiBkgU6rrdXFyxSYEnN8cEs5+Fn3o2CDeKN3YdTsybwqdkUiPp9
 OF2/Ejjoe+a/jDXyiQoCEfk0ELUl9dLiVr6o3owMGBtH1PKEXy69TQXsxw5sxJW++r0J
 ZDDFqJUrAbJTeWvWZMyYkHCz/YK+8Hv0y6gelmOgEOefmGOUknTmyMxO1gUIDs0DlvWD
 G4ioVhYOX83yTWgWlDVHPSpCVhoH8ehuQDo2vRqKo9to+oYTN/cYsnqtYjPW8p4Npx17
 hEUtxm4h6VkqvHobcwmSi9oINnM9IbMhxIbdWCoPz70oDT1plkKx6IN8PPv5sONGmAPv
 ct/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724395326; x=1725000126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ab1lZ6ALzabLfsNKA10O1rqTDvAbnO5lJaNDTwXEERk=;
 b=MN85vGe7O5qNg7KjsAcYaZOnTMJXGajav9DZRxmn+b5VXCinxqocEtKuVlZ9JFHJ9p
 rtgMBU9Ju+Nu+R3Ksz8PvDvbEabU8FYTfhkfOmKy6S2uiNIQodkorUfOw/N3X56JRa+3
 03Od1k8usadr1hsVt76PpU36JeZnJbd3gYimDzWjX9ExxtDWCKoetX9KQkgAbEjLQl2F
 a4Oqx80Lr6m/otMdV+nk9JZ2+VU7ISg80PQJFPGH00ww4JqCWH24foDcdFKqslvI0i9/
 duzlPvqGyEitQ2RaFjYAc/BppL+S3NFAy0fZH5kHXdkiQailr4MUnYJFcjoPjtSE1AiH
 oJIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4SFA4rH0BEQk6bXkYk3yTabX2uoVoWg/xvOWx7Q34RUdIpFo42KvFzputgAdfxNCWvGu/Xe/Z/5/u@nongnu.org
X-Gm-Message-State: AOJu0YwDuhEkNdZRoqzsffHjQsW30zSsr+Xytma5AZ2nerDUPYRD8hco
 tSbtCCjUNbGHEEZ3nPOOEzoCzxliLXn8R5/itSDJqmWIl6inqNc/al78ozL33Uw=
X-Google-Smtp-Source: AGHT+IGu8Q2lyFzeUZHnTus5soi3qgE+zbfsGQMjmu+lTHPccpY+Px/SONlvgGavxRmMXnl4J3dQ7Q==
X-Received: by 2002:a05:6000:196d:b0:36b:b08f:64b3 with SMTP id
 ffacd0b85a97d-373052b5082mr2707047f8f.20.1724395325782; 
 Thu, 22 Aug 2024 23:42:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ab87e881csm106351245e9.1.2024.08.22.23.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:42:05 -0700 (PDT)
Message-ID: <795d0c95-9bbe-43f5-bcd4-edcbe00cddc9@linaro.org>
Date: Fri, 23 Aug 2024 08:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/8/24 18:23, Peter Maydell wrote:
> In sbsa_fdt_add_gic_node() we g_strdup_printf() two nodename
> strings, but only free one.
> 
> Since the string is actually entirely constant and we don't
> make any use of printf's format-string operations, we can
> drop the g_strdup_printf() use entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> A small once-only leak, so this is 9.2 material. Spotted
> with clang leak-sanitizer.
> 
>   hw/arm/sbsa-ref.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ae37a923015..5cd8cd705be 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -164,23 +164,20 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>   
>   static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
>   {
> -    char *nodename;
> +    const char *intc_nodename = "/intc";
> +    const char *its_nodename = "/intc/its";

Should we use static qualifiers?

