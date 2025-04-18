Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C5C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pc3-0008T1-Dh; Fri, 18 Apr 2025 13:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pb9-0007tp-7g
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:34:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pb4-0000l9-HX
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:33:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso13943945e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997627; x=1745602427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h8DSwifdvjPYS0Ns0o9vim61Cd+Sb418wEGt8AAMb6M=;
 b=XLfFkoYVtkU5e56JcR/CyRmRHTp2qazTdTufUHtHITHydX6kKo9LMTz08FC9ntjYqO
 ymdQBAVyHN2zoRTZkpEKWDIX6608bdSvjUGhqaWIjF7SpUVrMIRiJuA8tltvfc5VkELB
 sqTHZjs282+fn13J7DJeUfEtlVDNnqdEcCYV85GyvhPC5zuo01TQtFFVknChURUUMQK6
 i9QZYsbMXkJWx/CYp3dCfHVAOCK/5Yj4xEV4o9aN0kqaLQnghnOz8+77uVyAV0T2RIkW
 iMnue94dVuIl2o1QLxlJupJJnLnm0DMUvg0/PjJe10QFFDHe2t1xVIYqaMUVapIg3lKq
 cQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997627; x=1745602427;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h8DSwifdvjPYS0Ns0o9vim61Cd+Sb418wEGt8AAMb6M=;
 b=h6uhKI2EWHAnaaS5akCxoM4ahFj9HGLTBZdIJQjzFlt2Ab3J6SkZBLZCWec8V3UdV3
 pHZV/EylhwSONHP15RV7+5UsSAPmb90+fPAsNavOSbjo0YX3fH+zvKlDgRSBeL332BTN
 TefDw+hWgpccEmDuE/K6LE8cfwvD0jGBuXAsiKKhR6UhQbdKFOmUBLxJllBhqTK+XVGL
 xnlqJLeX7EWATzQd7nJmZxjM/tVfaqR1t98hcMX0Q5HmjrYgIX1nQ/Q4vytojLy2hOcp
 iEo9PR/pvATdIvAPBZ71xkfYy1vf+aexDxKhUjCUxwdaJ1dChQLHKIH8SvhZ3Wr0kgYs
 B7mA==
X-Gm-Message-State: AOJu0YzZLPoJAnxRe0vDqePwqIVMK9rMyVl1KkB0J027OGYZ6zg65lL5
 7+A6fLNbWWhd9bDN1HB8Aa9SPHLSSSxQkA+I8DaKWedcMrsdHQZ09PjNbWeKFaCseiVhmECxGDL
 b
X-Gm-Gg: ASbGnctwFsguIScPsX26Nh5BOabWoTv2LlG0iuTM3CkHuTK0lL2aNwkEgFxd7dNdWnK
 x8bmZHXfBmazIMBeSQhJXz5t9yeqVoYRqqwfdOu4nrrg2CNeuSo2+HybxllR6KGtVgY1ORbdEN3
 Ke/q6zN8wKfcwuRR9MGCvARIZerhQWuDeTubzFpwd+veZeRQAPpKw0Ki+cKcCL+p4yiSlULa326
 ltpuJD/zuXbsh9mqRp/gPjV2xV2SafPP+gW1VHGKbwZTeg3a+B9hxZDW8mcP2agV4uCizuGwWFO
 RrSth3b8heRhob1Ao0hNIQ0txPtVYJSBlYklz6Fe2Tjp+Oyc5AB0k9HBk/nqS9/aYg755lrwCZX
 LyVFgR+5/
X-Google-Smtp-Source: AGHT+IG63xtKJ7Znm3umcQX3M/si0y4JD1JwAcKSWStP7Vw6Av07RDfU3la6cLwC2phCpJuXD1Q/dg==
X-Received: by 2002:a05:600c:8716:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-4406abb420dmr33148625e9.19.1744997627044; 
 Fri, 18 Apr 2025 10:33:47 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcb6sm29198775e9.18.2025.04.18.10.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:33:46 -0700 (PDT)
Message-ID: <73415609-5a88-4c85-b16b-0adca4794e92@linaro.org>
Date: Fri, 18 Apr 2025 19:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250418172908.25147-2-philmd@linaro.org>
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

+Daniel/Markus on this single one.

On 18/4/25 19:28, Philippe Mathieu-Daudé wrote:
> The QAPI-generated 'TargetInfo' structure name is only used
> in a single file. We want to heavily use another structure
> similarly named. Rename the QAPI one, since structure names
> are not part of the public API.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/machine.json          | 12 ++++++------
>   hw/core/machine-qmp-cmds.c |  4 ++--
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09e..3246212f048 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -275,15 +275,15 @@
>   { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>   
>   ##
> -# @TargetInfo:
> +# @BinaryTargetInfo:
>   #
> -# Information describing the QEMU target.
> +# Information describing the QEMU binary target.
>   #
> -# @arch: the target architecture
> +# @arch: the binary target architecture
>   #
>   # Since: 1.2
>   ##
> -{ 'struct': 'TargetInfo',
> +{ 'struct': 'BinaryTargetInfo',
>     'data': { 'arch': 'SysEmuTarget' } }
>   
>   ##
> @@ -291,11 +291,11 @@
>   #
>   # Return information about the target for this QEMU
>   #
> -# Returns: TargetInfo
> +# Returns: BinaryTargetInfo
>   #
>   # Since: 1.2
>   ##
> -{ 'command': 'query-target', 'returns': 'TargetInfo' }
> +{ 'command': 'query-target', 'returns': 'BinaryTargetInfo' }
>   
>   ##
>   # @UuidInfo:
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3130c5cd456..408994b67d7 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
>       return params;
>   }
>   
> -TargetInfo *qmp_query_target(Error **errp)
> +BinaryTargetInfo *qmp_query_target(Error **errp)
>   {
> -    TargetInfo *info = g_malloc0(sizeof(*info));
> +    BinaryTargetInfo *info = g_malloc0(sizeof(*info));
>   
>       info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>                                    &error_abort);


