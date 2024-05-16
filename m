Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF95C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7YZn-00028H-VW; Thu, 16 May 2024 06:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7YZn-000285-5N
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:43:07 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7YZl-0002j5-Fq
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:43:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f71e4970bso718874e87.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715856183; x=1716460983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNBa43nVOcQQaV/zgssmf6pePZYpJlGuksnS9oe/fBk=;
 b=JOejHqov7WdwKEqRI7FzPh7kbMGw8586Ns4P7mTUYMOUdm7kQJTiz3e62+H/1CF4u9
 gXqPsGKl3/buzB9QskjpjtUaCwWzyyLo+L0vQ8SeNTgYxh/Wa+thrMpm+prENMbpMpCg
 aJr/g5PXPiesv1kVXlJLupXKdhm+oRkZinOk42tVomdJ7q9lEVyevjTYzOvuIQv0HSEY
 eeOPvGfYuk9FZ+97pdhKC78Des/ihhaoXkdsvbxrNHbJjcRC/bo9bPrS7nsT7NeMjRTo
 sJVAW6M7fKPgK5ZNx8RIqqTFD+CNAcY2T8BozJYMw03ACCsQy/j0w/WNgr2Auysp7GY5
 MG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715856183; x=1716460983;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNBa43nVOcQQaV/zgssmf6pePZYpJlGuksnS9oe/fBk=;
 b=qzyVaCZHByqaisVnhqMnMsEv/RtsqmSdAD7SD97XPLABmlwpffKZZ2sQ34LE561jTT
 4P00YXOdjh/qE3ygMrkKMXHyzO1g7T67VmX7Gw3AH/Vmx9dH4PMCXSY86eqy7BkM/sI3
 GI+7UQVPp68bOw+V4eLtHeioNT69uijcpr1n5U4cpI0tfXYl/YRz4n6ssJVBGqKbNACt
 ph5SojPJqfA66C3y9w3cG1yhisYEwkhTFen6CQVPrLozmNXJNo21Bk+bLsNtXsLcvEcG
 EuR17smmqsKMBV8w5eMCjZVcu90O4lixAKvxojSAspd2+R+dG4gfUOKMqAH+vosJ516i
 /Eow==
X-Gm-Message-State: AOJu0YyufZl432lM5HAOf+nW9oRAU7/XprSwvP2oPDvQs7CZV0oZXkYk
 iWnczLBf76SWWA9gDUFNUbsDkdrHq2YFQciN+7G/FLz8J8M18pN9TfX5Unw96OE=
X-Google-Smtp-Source: AGHT+IEBj4UManSBG7xoRv6mKpIhpFZH5VjDnegToBh7UizTk7rBJF0N/EMjwN3u1uqxxbL8FzjujA==
X-Received: by 2002:a05:6512:3b8c:b0:523:2984:7a04 with SMTP id
 2adb3069b0e04-52329847d08mr13078151e87.36.1715856183286; 
 Thu, 16 May 2024 03:43:03 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fa9dbab53sm278604025e9.13.2024.05.16.03.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 03:43:02 -0700 (PDT)
Message-ID: <e8901da5-cff1-447d-9430-c74012487efc@linaro.org>
Date: Thu, 16 May 2024 12:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] gdbstub: Add support for MTE in user mode
To: Gustavo Romero <gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515173132.2462201-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Hi Gustavo,

On 15/5/24 19:31, Gustavo Romero wrote:
> This commit implements the stubs to handle the qIsAddressTagged,
> qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
> subcommands to work with QEMU gdbstub on aarch64 user mode. It also
> implements the get/set function for the special GDB MTE register
> 'tag_ctl', used to control the MTE fault type at runtime.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   configs/targets/aarch64-linux-user.mak |   2 +-
>   target/arm/cpu.c                       |   1 +
>   target/arm/gdbstub.c                   | 321 +++++++++++++++++++++++++
>   target/arm/internals.h                 |   2 +
>   4 files changed, 325 insertions(+), 1 deletion(-)


> +void arm_cpu_register_gdb_commands(ARMCPU *cpu)
> +{
> +    GArray *gdb_gen_query_table_arm =
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GArray *gdb_gen_set_table_arm =
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GString *supported_features = g_string_new(NULL);
> +
> +#ifdef TARGET_AARCH64
> +#ifdef CONFIG_USER_ONLY
> +    /* MTE */
> +    if (isar_feature_aa64_mte(&cpu->isar)) {

Can we keep this code generic (not guarded by #ifdef'ry)? We
are protected by this isar_feature_aa64_mte() call to register
the MTE feature.

> +        g_string_append(supported_features, ";memory-tagging+");
> +
> +        add_packet_handler(gdb_gen_query_table_arm, qMemTags);
> +        add_packet_handler(gdb_gen_query_table_arm, qIsAddressTagged);
> +
> +        add_packet_handler(gdb_gen_set_table_arm, QMemTags);
> +    }
> +#endif
> +#endif
> +
> +    /* Set arch-specific handlers for 'q' commands. */
> +    if (gdb_gen_query_table_arm->len) {
> +        set_gdb_gen_query_table_arch(&g_array_index(gdb_gen_query_table_arm,
> +                                                    GdbCmdParseEntry, 0),
> +                                                    gdb_gen_query_table_arm->len);
> +    }
> +
> +    /* Set arch-specific handlers for 'Q' commands. */
> +    if (gdb_gen_set_table_arm->len) {
> +        set_gdb_gen_set_table_arch(&g_array_index(gdb_gen_set_table_arm,
> +                                   GdbCmdParseEntry, 0),
> +                                   gdb_gen_set_table_arm->len);
> +    }
> +
> +    /* Set arch-specific qSupported feature. */
> +    if (supported_features->len) {
> +        set_query_supported_arch(supported_features->str);
> +    }
> +}


