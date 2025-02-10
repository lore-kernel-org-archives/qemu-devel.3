Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AA9C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV5e-0005E9-So; Mon, 10 Feb 2025 09:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV5a-0005BW-9b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:48:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV5Y-0002dQ-G7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:48:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso11158785e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739198922; x=1739803722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQQSm8l49PTTpp46FLlhIZ97JYHJRgRAdgT0775ecbo=;
 b=ygMw5MrUZzYizvhnqh06tpeTPEHpt6ecDXd4FqCs+Z4c7SdGbVLkmjJ7T776NMbDX2
 S0Mw+hyCPXYt7jMtoxWYF53IOY7InqeWvut9nU9iX3pnxrlIdFy0jM+V1hoI5PJbHz0K
 2fAE/zSO6q7lpsDcIHuqnZsNot5Im3SZcP7Cq0++3vFrTeLVpj1Fl1qobcgQWTWAYpp7
 0Xr3q5sqyWFJZncpTKz2fPPOeYFTjlIwhhK1z4kRnHWOfeU85wE7CgzLTs6p+yeI30Ng
 nABy+qqh1FJ8rBw6FPWCvQ8eGf1umhQZ2KQfadzteIniUEXi4NFgHa8ad4qjjd+vfMb2
 ZZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198922; x=1739803722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQQSm8l49PTTpp46FLlhIZ97JYHJRgRAdgT0775ecbo=;
 b=sWnIo9F7815UiWRWC4zsKTV2dn3YtUuDKjLoVxTz+LbS0iuMdD59zY8satDtFtAjfX
 kAPpSVMbysOTm3HzxPhJMfthICSVqN4u7Y76z+OyXshI3HSJ/+Pd+Zv3HAIzWq9U51yv
 ukCIapQKpkRITByEEdS9J3bGh99D0UI1BvjkIV38yyRUHNYVmoEC0FGqhpEMWvfhEH21
 yZZ96Goxkdd1J1uZfObeRUQ0lbCD+lcD4aIdzv65xp5jxxk9wmvgySZEHLSci7ZAMBem
 7HObXFJKE8VpM6J73v4eWsFcc97sjZUnDlYD5Dy2gQlIJi0vC2CL6mhVPG3OVvHZq3nR
 Oa6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYP3QfNFmdScfKlPdswrYoMK0jqRg7SH/a2vRnsce7Dqli6ID9jCyST6gUOsYNh57GYKNOSWKQuTR@nongnu.org
X-Gm-Message-State: AOJu0YwEzO0SAakPqfWjyyZCsIXaNbGRoSfZzGLAPSZFlc43QelkFgJg
 UeOlyMVJ8Al8xrIE4CvWYyx1nyWVtpwPPxfF8cIGtt7vhX0KUZ3Ok0ejqUA550E=
X-Gm-Gg: ASbGncsocUL3GzljEhSw/zEMxYu/OANzZ/9QwEbBcrvB+L2GF4I5XlENdeNPfhADIaa
 BjTTLaQ8BWP8LQMBgciLmIm8hSM3KHnheuLzAOhgZZJC/w9EeuMmv5BpwkRIh+LNeJuERapP5Gy
 wa/hud3HqYPdN5yZIEfhhSShRogodqZPkacDXpzhv64iQyv+x/SifScH92pHLXWXavkXJ8ONX/w
 dnFjxdx+umHYKv0QwOewmDFn9acU6xwXv/Or9WySrV1qYhkRiy+4fl1jYwg2gykssKGpb8YIIxi
 APjoAhLmpP26yem3EVmWHmD1PC96EjboIUZCX15gngw6CO0HZ2/zzG7Sew8=
X-Google-Smtp-Source: AGHT+IGImATETPLNyKOEAu2cWm7oej33zOp0sHQXFCs6+EJNRzOd2RqTRGr1oczxf0+7PRSNIM8aGQ==
X-Received: by 2002:a05:600c:1d8b:b0:439:3e90:c54b with SMTP id
 5b1f17b1804b1-4393e90c744mr45830415e9.0.1739198922615; 
 Mon, 10 Feb 2025 06:48:42 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394328fcb8sm38499215e9.32.2025.02.10.06.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:48:42 -0800 (PST)
Message-ID: <b47baac7-8ece-4ae9-80b3-84b7c9059da6@linaro.org>
Date: Mon, 10 Feb 2025 15:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] hw/misc: Support 8-bytes memop in NPCM GCR module
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com,
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-10-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206221203.4187217-10-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/2/25 23:11, Hao Wu wrote:
> The NPCM8xx GCR device can be accessed with 64-bit memory operations.
> This patch supports that.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
>   hw/misc/trace-events |  4 +-
>   2 files changed, 74 insertions(+), 24 deletions(-)


>   static const struct MemoryRegionOps npcm_gcr_ops = {
> @@ -261,7 +310,8 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid      = {
>           .min_access_size        = 4,
> -        .max_access_size        = 4,
> +        .max_access_size        = 8,
> +        .accepts                = npcm_gcr_check_mem_op,

Good idea to implement the accepts() handler!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           .unaligned              = false,
>       },
>   };


