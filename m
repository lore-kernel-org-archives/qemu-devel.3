Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79744EE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMBJ-0007j2-74; Wed, 11 Sep 2024 08:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMBH-0007iZ-Vc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:10:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMBG-0006l9-2x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:10:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so416719a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056640; x=1726661440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmF3JZ0LDwiZuZ3Bw6lXDfhVx4DeXElvEe1kYSYnNco=;
 b=QLwqFai8Bk5elta6y06fxqE3LD/rTj04V6J+6VOx+CWLhc7KIvIgGZ/MV85b0f2a7m
 Ka9z6Gcy+EyW+1FaZnnI80dX66n3QgC2HkPIOIv+nDycX6Dyg4GX7navnGmYgTPT1ffT
 bivQdTQZVV9VgCzG1Za3OT7Hzpv2q6UBY655CLGIeUxsDm/WAtudeeP1WJ11feTGiqvy
 ZPVLzci0oSTXr/UDZY+ft15Vy1UFUDd+gN5yuPp/0FiMbNxtUyaw5ZWbUASJbIoX4z/g
 J/p2DGoo6NITzq3ADYYC9d9IecgfEgwIqlpqiQZJvlQPQRkAo5BwVqxrYCCpuQgMub3H
 DBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056640; x=1726661440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmF3JZ0LDwiZuZ3Bw6lXDfhVx4DeXElvEe1kYSYnNco=;
 b=Kof0W+3gyzo0J/Fe8RzouTSgCxu2pdH0u/8SfIqKR7nLjtTeCCsETLcMeJkHjyoTIe
 9uKFUf+05nWRBmchDjjWW/YBhm34boQgnhkWuTbDRKoiWwfl6EsID3NsKpL80JiP+v1K
 Z5P09+o3rVnVHxmiSaRgzMiI2mfXNy1IeC64+iNvDn2IfDn4jSTDPwq4avuz2sXSh0vS
 SPkHFLnBCErHvwAsPEnZ3rD8GYWJYrTsHMOAm3G0Qcu3DF6XKa86e4cUFwDUKIUzd4OM
 QGNSzV6ILFTnDa1HCtirz6AJ9KajzgOp0hy1CbyVHS2GAgMXbISENCF3UfrasYB28Zo7
 1ozQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9lSDS2t48CXhvJBgB0XSSCKLl5xTKIj0wTM5FnYBBPW40NIN1QDVMcBofjHBAWMUBAf5GIiM8MyaF@nongnu.org
X-Gm-Message-State: AOJu0YzLFUXaloBZPZ/tw4WyCahgm6oSqPooyCFDE24wGlYjvxEmbeAt
 R6qtMBk8Pn7if9u1Oj6of1RK/4b9JaXDt9wcEf9lVgeav2tUKeapMS0Ma3K9nCKtmGlYVuu12tm
 4
X-Google-Smtp-Source: AGHT+IEiUZs6t1DV3vDLxnbddQhWK2Qq7g6+5OOR5GQG5N5HKfqQtVUsONSSPK5b05lXvjpN+mhzmA==
X-Received: by 2002:a05:6402:40ca:b0:5c4:4f6:c498 with SMTP id
 4fb4d7f45d1cf-5c404f6c568mr6356768a12.17.1726056639470; 
 Wed, 11 Sep 2024 05:10:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46819sm5308342a12.31.2024.09.11.05.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 05:10:38 -0700 (PDT)
Message-ID: <84a87c28-5175-4885-81bb-1ce17691833f@linaro.org>
Date: Wed, 11 Sep 2024 14:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/ui: set swap interval explicitly when OpenGL is
 enabled
To: gert.wollny@collabora.com, qemu-devel@nongnu.org
References: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 11/9/24 11:14, gert.wollny@collabora.com wrote:
> From: Gert Wollny <gert.wollny@collabora.com>
> 
> Before 176e3783f2ab (ui/sdl2: OpenGL window context)
> SDL_CreateRenderer was called unconditionally setting
> the swap interval to 0. Since SDL_CreateRenderer is now no
> longer called when OpenGL is enabled, the swap interval is
> no longer set explicitly and vsync handling depends on
> the environment settings which may lead to a performance
> regression with virgl as reported in
>     https://gitlab.com/qemu-project/qemu/-/issues/2565
> 
> Restore the old vsync handling by explicitly calling
> SDL_GL_SetSwapInterval if OpenGL is enabled.
> 
> Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2565
> 
> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> ---
>   ui/sdl2.c | 1 +
>   1 file changed, 1 insertion(+)

Queued, thanks.

