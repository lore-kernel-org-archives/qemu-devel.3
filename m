Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA7AC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 23:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYDjJ-000766-CM; Sun, 28 Jul 2024 19:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYDjH-00075c-GS
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 19:55:07 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYDjF-0008Tw-G6
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 19:55:07 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-709465248b7so834495a34.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722210903; x=1722815703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rPhc7fjbjUAgvLI0aIUhO0XtOFAP6WoB4NsY95T7stQ=;
 b=Xuw00M9Sma+HKnKNfONoiT6skUsFWbq3auxMDX9JLEf3f9FVsg3Oilx542LHhjzS6C
 dqWJoOl6iho6epVkjnW+MlksnTfAD7QaKEMtKFDpmaHd2b9aW/iU6FEgLyBcEhLi4UCt
 OMdrqvI9TYd35Q3av4ni2p7+FTtaQo6Z4D+71+AdaIVNSoVTShXsTQydL53TnBE6BrcM
 KBdl6xkAnSRiZQQjBth8tFqDMiPhDNMnZWkkfPOekgFrYiyPQevatGtffcHHxcWJN5w3
 k87CsF16pA10s265RtuulAoQeiUo42/UCm1kcRDPUwfw919/0Ilmrolg2pk9NctEN6Wl
 myxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722210903; x=1722815703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPhc7fjbjUAgvLI0aIUhO0XtOFAP6WoB4NsY95T7stQ=;
 b=H4LZvXqRUcEXOILBFiN2vnDLsG98f2tjt+n/vLeJqwQI4Lx2rc9KhpoZOxJphX24RC
 DMq/e8zsms8cmEez/7fLoKWyiqIDLV2Xe2nu+6RBoHtUB6pjdb6L97bUMerovjDBuZBk
 /reEPkpQ0Xa4yOXeKl5rx9AFC3yRzVdFVZsfILERCpTWSDlNEIQjdi43Aq+I6duHRiid
 DlvvonWH4W1/Ae+xIiGVJEYl7cyiAVpHaw7vwdGSscMu6Qdg22MffaMFNZY3eSrq5LAB
 RYm95JW1Uz+F+J6abJpQ1aNS6uT6tQj+gWUShbFuGr3g7i6TpYUYw5dG0d+QyU3+0VGJ
 KRMg==
X-Gm-Message-State: AOJu0Yx9PspKZQwGlgdwWV34UYbB+ulVZ8uNnUIPX2scFemkaDnl5oCe
 Id5aENHXl/bfaTbCYNBy+wf2RQYlq9aqSmve/K3jjhWy87PsBug4lO0TFJmVSroW3wxsVMX6Uz6
 D3SOobw==
X-Google-Smtp-Source: AGHT+IGxNzuczQ1TWrfbqVb7n0diu56qwTTX3YLspTTe8Ewlbh6gB1ugW4/6kgwpoNGJymdpxRg8UQ==
X-Received: by 2002:a05:6830:6f0a:b0:703:651b:382f with SMTP id
 46e09a7af769-70940bfe06amr8516414a34.3.1722210903287; 
 Sun, 28 Jul 2024 16:55:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb73b0760sm9249221a91.14.2024.07.28.16.55.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 16:55:02 -0700 (PDT)
Message-ID: <904ecb53-afdf-4818-88c8-8036366e3d62@linaro.org>
Date: Mon, 29 Jul 2024 09:54:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson: Use -fno-sanitize=function when available
To: qemu-devel@nongnu.org
References: <20240729-function-v2-1-2401ab18b30b@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729-function-v2-1-2401ab18b30b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 7/29/24 01:44, Akihiko Odaki wrote:
> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
> -fno-sanitize=function in the clang-system job") adds
> -fno-sanitize=function for the CI but doesn't add the flag in the
> other context. Add it to meson.build for such. It is not removed from
> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
> does not affect --extra-cflags due to argument ordering.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Dropped the change of: .gitlab-ci.d/buildtest.yml
> - Link to v1: https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
> ---
>   meson.build                | 1 +
>   .gitlab-ci.d/buildtest.yml | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 5613b62a4f42..a4169c572ba9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>   endif
>   
>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
> +qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
>   
>   add_global_arguments(qemu_common_flags, native: false, language: all_languages)
>   add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aa327824052d..d83e50abd933 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -430,7 +430,6 @@ clang-system:
>       IMAGE: fedora
>       CONFIGURE_ARGS: --cc=clang --cxx=clang++
>         --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
> -      --extra-cflags=-fno-sanitize=function
>       TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
>       MAKE_CHECK_ARGS: check-qtest check-tcg
>   
> 
> ---
> base-commit: 93b799fafd9170da3a79a533ea6f73a18de82e22
> change-id: 20240714-function-7d32c723abbc
> 
> Best regards,

Doesn't work, because --extra-cflags comes last and overrides it.

I think we need to drop -fsanitize=undefined from --extra-cflags as well, and use 
--enable-sanitizers.  I think it should be ok to leave -fno-sanitize-recover=undefined in 
extra.


r~

