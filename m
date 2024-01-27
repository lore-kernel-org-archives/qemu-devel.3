Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE10C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaRz-0003gz-Jp; Fri, 26 Jan 2024 23:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaRw-0003cT-So
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:37:49 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaRt-0007UZ-Sy
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:37:48 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc22597dbfeso1196818276.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330264; x=1706935064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hbdei9OReJaocPGtRiymUPhArrmngfyyl47Zzb/uLM=;
 b=Mxi+CpAKXuRc2o/8dVhOmkMLXOVnnS0xCyuPYmYkSm52UWLwWLF7SFfXbUe6DO3X5r
 MTFqml6HjEFn7r5PPT5NbMqUM47qgXBE8Ur+SpixrvaqerixhySg6OrjMnnOiu7GESn0
 OSMh8tp599a/dTSa942854qy382Qmx3Qvkzgt8uavCt+gr2rA525BPFPerbvyXOFMq07
 BN0V1N6yLB3hRCzV0OYWIsIZEavnN8bTzTq0JVkYfX7dVCpAgGo5/783aZZpHJPlSDP+
 vIwaWo2zUAJtFFBvPfrIVZs851VkdHbJkHGR/Oaupz/f7fAXURWHqxRbuQ8YvCwCrfkE
 TvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330264; x=1706935064;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hbdei9OReJaocPGtRiymUPhArrmngfyyl47Zzb/uLM=;
 b=r/AG33xmIN63rM+9WRHj/yWUb/Zsq1usRbSIZed0UkpBqLsvvgf3ayTihUUiLgXisU
 GswfjqfTyz82fUVv3CWaGosfiMyK4WKtmj0lVvnaQIkGJrXU4IER/t4R7N5VXP2NDgzk
 JNxsMJFucc/R/NDB9YyZGY68g8h/CJCz8yqK02aBqtQ6ii50dscFolq51mF0Ktjvf9XU
 d15XCepnn2ErYubZXf8vQOIKPi4PQB2WuoV1YN0aEtsSQvYXiXZhpYKjxI3aK11DmD+H
 559BYxqXjwMyeexBbYjQ7U2sQMBH1QuV45kYbaUw+acfjuxSHZUJzDhfqggVfXGTQBfX
 fbzw==
X-Gm-Message-State: AOJu0YyEzimDHmV05qjHpKQRIAdT7YjQ4hi78Q6tjUiMFa9yWSSvS+qx
 wC+prpaMYY44tujZG9MdE1ejv3Djtnm44i08r+FX/Pnx7ffZigPBsETcYuaIgEo=
X-Google-Smtp-Source: AGHT+IEFVotpCptazpO7wrVGq6P/eN5J+QvNqIanTNtENSbuM8j0IOzsJ+6zkjwfGDjXwoTfvxsEWg==
X-Received: by 2002:a25:6c55:0:b0:dc2:41de:b744 with SMTP id
 h82-20020a256c55000000b00dc241deb744mr953894ybc.32.1706330263973; 
 Fri, 26 Jan 2024 20:37:43 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p30-20020aa79e9e000000b006ddd13c09c7sm1924769pfq.172.2024.01.26.20.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:37:43 -0800 (PST)
Message-ID: <52d3f577-218c-4f3d-b099-ff423b986572@linaro.org>
Date: Sat, 27 Jan 2024 14:37:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] target/openrisc: Prefer fast cpu_env() over
 slower CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2e.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/gdbstub.c   | 3 +--
>   target/openrisc/interrupt.c | 6 ++----
>   target/openrisc/translate.c | 3 +--
>   3 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

