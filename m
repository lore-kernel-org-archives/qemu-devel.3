Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA1D59D62
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFekz-0004UN-QX; Mon, 25 Nov 2024 14:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFekl-0004Tn-Ss
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:28:14 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFekh-0008Mw-1r
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:28:09 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a1833367so5853505e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732562884; x=1733167684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pW7+uYwIghRYgAt49F1O0Ud11ZccwgTk6qQaLmfk6ag=;
 b=M0cMUmsf/Cmyat96mj13obSG0ghfB3NSmZv6l0oOVxSeZ3bKiSNwFpNQlWOzvY5pnm
 LTjUHD4gui8wjIDSAXUc234/tOQh7y2ehc4qJAPFVEDUOWqV9AsBrGYW8q2YJ4iZgEf0
 /VRQ801MuOl2nJ7sPnGt8TeG7JIEivmAroRkBugxlJEOmrWpWWH4fxwVLbgDK+UbBVtR
 9L76CB6V9U/TGqiysqgkH+Zjm32sDAi3XCfOydDQlG+Gai66zfFC2RTkLgdJzk9xuj7X
 i5S6L5IVFRtM/+Dz8KiGnNQqY2ZpQEYjO2+MJkrNULOBzakdPFrR3uE/QkSIA+FCUn0r
 Jong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732562884; x=1733167684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pW7+uYwIghRYgAt49F1O0Ud11ZccwgTk6qQaLmfk6ag=;
 b=td3pTp8NBbBlAftKE/lYfn+nxsg+1R8TU5TR50OmvXB6EwFcVXQNrCwKKItOTZhStu
 QRjruOo7tRQCp+2yLXU9/kJh9axQ6gTtON6RY3NJY0GOZe0pHWUxzfZPRSeS2yQjFQsT
 577kkXrj7zkGpb0cPkDshij7mMZcwdjx3xinnv9y816dQi1x7OPN/ZVfKdJLCJwatt6r
 0WUzfpt6VSMPWPK8er6HF9ItRkpaObGu2hhSxHBWVFoQO8zzoLMGnwwXu+F+M6CtbehG
 BdQNdO6Gu8QQZ+KYkZfc3kmQ8I7+GTNY9sxNUJGN8VDyXywoA2twasBjfLo4k/UxSEyj
 Vq2w==
X-Gm-Message-State: AOJu0YwAPENGYU4+3wzPTKb9pbCtQa1Ogypwj32Mzyn/xRB2kwRtGTNL
 /zs3w7PBLh/pSF/9wISrmtv1AqpqiOtEqttfJHPbgP3khgU2ZXVn07clRZRuarc=
X-Gm-Gg: ASbGncvp2vwji8pWTvx52sqTgpt9Oz+SgZAhSO9l7zL5FTd8YI/biHTyNhOB4/1pC5K
 nQXk4YZfSWUja2Xi7rFCCw0jnHu9XERmVd1tJBFRPAj2gnxahjtbdTTY8z+STgC0kHcHXkAR2qO
 UUZ40ORmhyMq4gkgOscuwmtBfbB4cu6MEp6SGs9Unc96eTGnigBf2Fb6baHoifym4hypogRXXLq
 iaKUlecEhZDGPYarfjboInckAVvUSDzcdQFZHA+rXoNNq/PBryCdzSnoBXb8X48iw==
X-Google-Smtp-Source: AGHT+IESWRV4aQuh/HB7FLNbtngESnFXBJwC+IvDaQt+OPUKboEKnqP0ZJ+5/8uH9kuhUdjWbTQNDA==
X-Received: by 2002:a05:600c:2248:b0:434:a33d:ba44 with SMTP id
 5b1f17b1804b1-434a4ea42b0mr5177785e9.15.1732562884557; 
 Mon, 25 Nov 2024 11:28:04 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd7d7sm206499415e9.13.2024.11.25.11.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 11:28:04 -0800 (PST)
Message-ID: <03d94b2b-4653-4401-a33d-8581ec022ced@linaro.org>
Date: Mon, 25 Nov 2024 20:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control
 region name
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-5-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125132042.325734-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

On 25/11/24 14:20, Nicholas Piggin wrote:
> By convention, xscom regions get a xscom- prefix.
> 
> Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet model")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/pnv_nest_pervasive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
> index 77476753a4..780fa69dde 100644
> --- a/hw/ppc/pnv_nest_pervasive.c
> +++ b/hw/ppc/pnv_nest_pervasive.c
> @@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
>       pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
>                             OBJECT(nest_pervasive),
>                             &pnv_nest_pervasive_control_xscom_ops,
> -                          nest_pervasive, "pervasive-control",
> +                          nest_pervasive, "xscom-pervasive-control",

Could this break migration stream? Or only RAM regions need to
have a stable name? I don't remember, but try be be cautions with
such cosmetic change just before the release ;)

>                             PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
>   }
>   


