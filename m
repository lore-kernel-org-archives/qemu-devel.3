Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABBBC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl54-0000No-6w; Tue, 30 Jan 2024 05:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUl52-0000NW-7j
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:11:00 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUl50-0004O0-MA
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:10:59 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e112826395so1816015a34.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609455; x=1707214255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6+BBi6CCXU4BmP4U2guSGtvv3oi3jDkISZ3NIf4LtY=;
 b=NSjtga2oDoEGQz2tXj1RopsD2MUK+lbcz5Lvln3cKA3HpiiqTwuqZpchL5MEJauJzp
 ds07yG7ILYtZNmRLkU/d6KRmsAwOfjWBuOc83HTIARDq1oNMWGlZS7KgTX7a2f/SyCX9
 w4ykvBFMnKdy07Ds9lEu1hABOQ8QN1ciynn3v0JMlOXsslL6iJGOnOjQZ+Q1D4ilwepx
 OZh/edkjmV/49hnlYpMUW2TgJT3SHmVEZuQp9veeqN6v51WFXZm8/9oZJ9CE6N0WRUwH
 1vId5Qf3LtavQa7kM4u5eO9eq8FeSSC52jULeK3sIPfJmforGvxwcxPJQmTbJcJUrQGd
 iEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609455; x=1707214255;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n6+BBi6CCXU4BmP4U2guSGtvv3oi3jDkISZ3NIf4LtY=;
 b=gl6Zf9pljAIuqmKhGcoZ3J6FbTlsAoHfyXnWg49Pc0I6+AuswtTbeslsTaCVKKo6zl
 04ms10+up7K2WzCGqOKXONhURSC/EWpgXdnSrKCm0qpfbkydGM/gTTjwsi1jgQiWeBw6
 4hlMIKn1kWPtqfLB+ctX6++OjvJ9fOmkVqqCaZVLL+4vUdzfK5SJDxisEe6SuAFcTtPM
 NIbRD81Pl3opAPcf3Tyr/wUnP65GyDBgpgTQeIucUFt5poCNfm4tc1MSOQ1Rale5ZL2q
 L+3AGk7yraszy9CYWPvAE4APMBEIKZqfktE2WB3hJbFzkrkm7ghP4huRbhdtN+7XPSF0
 CEpw==
X-Gm-Message-State: AOJu0YzlOevhEMwIo+U8wNTbrP3n7FxwHO7309ytWH7Z1q955ZKSfhzU
 tQOv4lqraLHwx9bl9pU8DJohI0Yjjjekz/TxOAJTb7Qy6QVwC9QzcI6/lXTshBc=
X-Google-Smtp-Source: AGHT+IHajrBdE6XCzLLLjbds5/vXCl/Va7wShc3dOZGyUkaA6f8pcyUL0GxI0TYBdf4MsPfCCld6IQ==
X-Received: by 2002:a05:6358:706:b0:176:939e:9b6 with SMTP id
 e6-20020a056358070600b00176939e09b6mr8833033rwj.17.1706609455593; 
 Tue, 30 Jan 2024 02:10:55 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa787d5000000b006d9c216a9e6sm7445295pfo.56.2024.01.30.02.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 02:10:55 -0800 (PST)
Message-ID: <ad4d8b27-c7d3-4d73-a363-1bd27b3c8394@linaro.org>
Date: Tue, 30 Jan 2024 20:10:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/29] target/i386: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 1/30/24 02:44, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/hvf/vmx.h                | 13 ++-------
>   hw/i386/fw_cfg.c                     |  3 +-
>   hw/i386/vmmouse.c                    |  6 ++--
>   hw/i386/xen/xen-hvm.c                |  3 +-
>   target/i386/arch_dump.c              | 11 ++------
>   target/i386/arch_memory_mapping.c    |  3 +-
>   target/i386/cpu-dump.c               |  3 +-
>   target/i386/cpu.c                    | 37 ++++++++----------------
>   target/i386/helper.c                 | 42 ++++++++--------------------
>   target/i386/hvf/hvf.c                |  8 ++----
>   target/i386/hvf/x86.c                |  4 +--
>   target/i386/hvf/x86_emu.c            |  6 ++--
>   target/i386/hvf/x86_task.c           | 10 ++-----
>   target/i386/hvf/x86hvf.c             |  9 ++----
>   target/i386/kvm/kvm.c                |  6 ++--
>   target/i386/kvm/xen-emu.c            | 32 +++++++--------------
>   target/i386/tcg/sysemu/bpt_helper.c  |  3 +-
>   target/i386/tcg/sysemu/excp_helper.c |  3 +-
>   target/i386/tcg/tcg-cpu.c            | 14 +++-------
>   target/i386/tcg/user/excp_helper.c   |  6 ++--
>   target/i386/tcg/user/seg_helper.c    |  3 +-
>   21 files changed, 67 insertions(+), 158 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

