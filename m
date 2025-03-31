Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8473C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNSw-0005Qa-Gx; Mon, 31 Mar 2025 18:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNSp-0005PW-My
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:18:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNSn-0007xU-3s
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:18:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so32242915e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459514; x=1744064314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=37QQe3DP3hg1Pjvf09jYWhj2GFKwO4sbTp0yz2un5Vk=;
 b=Jewb6dloAyPjv7W6u/e48e0YVxY3cCcd9GtGYomPdsb0I6Dq/Xx553jErvpyIHI5qA
 7p/fTIvP+OyjIutW857D1xSr5o2UEBabx0GXuGgTlOxNr1QRHFJM1ksjd9Y06k9PAXrx
 o0z9QZOMRf30STkbExm3/fICJkxH9Q1oqlsz+yrnR1+4QMbd9/Q5sANKx0uIeWPUNd2v
 GFnXlTI0aRGiIgvIIsP0/zSiArQVLb21a1cTiQ/mY/qNxVD3gKdrndEQXJ+YQ+w8H51U
 5hyrxIURflNSmWkyaPw+c6OXUkGWNpB965elmHWgtfyv8Wd7MvO9K8HrQnKGuKi2n2xT
 KSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459514; x=1744064314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37QQe3DP3hg1Pjvf09jYWhj2GFKwO4sbTp0yz2un5Vk=;
 b=uaeJ2yBBIvT7+ozDoAw0WKNtlWn9dxEurvb106TGlU5IqYJD+sPu97PCyEWGDAVCwC
 HGwB+Tl+OpmGyInLUPCi9Aby+Am76TOLDs7inGzhEZp634kf1J90dg3nMlR0kX0Tt1Jm
 s+DcPUFGFjQ2Z++TpYJHxdVvERWGsLE5xIuNYNh6Rt+VXTMyatfLABAJC4IeNTUf8gxX
 RYl7r3/fsPbkHKhuAgNJ5OBs2qDrt2bzReeMFkJYGatNKBZyli5nh4zYZ+M3w3KvPkPY
 8lyR6se4YhMXOL8ZDG3qkN4KREmYsSbdQdDc6Qo5OTm08tJeLIaLqWm9FB/IUFUutTzs
 jRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWl0opqk4TaKKlbBB30F5ivAL8+ugFTLD7Q39PS3JrcmIS40nIMrpcg+NOcJiuJSQ40M2EKsd4+cYF@nongnu.org
X-Gm-Message-State: AOJu0Yy/tS9fFUsBZeTaZovHwrFl2qMS2bwm6nBDMu6YN+dPaCKTy9sI
 wbEEJm1RiDA5//5M9s321R5ErTOpPhXebNo82NmuqYOqPQ5L4Hsvi5eotTsiYYw=
X-Gm-Gg: ASbGncu0lvkxwLpvlUTu8018wJ+OxvTI/PX4g/F9dd5NyolavcFQK7CoWTImB2Fx4T5
 +xFfSLAskYCpGFLDDKiWQT7vsyLzzF+q/U+PRDfP4o9f0fomGVhDnMTOF/OZyV7YES8CJ4Volco
 VaGR7QCZdU4cZlWlcAAuBGNSMyeaTmebPMEWZJeLAnBR7NB1gpLTSgEvKzIZe9Qf/DjX6y78qds
 WnZU7ROY24pjhwlep+SSfs/fqt2RYzcG8EFBw+IYfsbffz07PCVEsS7bCjsMHB248DbncPGcMPE
 fA46ohBkNAAHakLxLxQYi4bHaH57U+CFSL24NFWcBqNWF5xF2vV482+jVLJgGKBAr6KzJgdtaSM
 F6uTKejaDmdH8
X-Google-Smtp-Source: AGHT+IENiE/0s7ea8R/qeCuPCbYXAuv5IWyI0IJtbhIJur6s94LuUWWo1hUcYdOu7FCgJ8MW83k6Dg==
X-Received: by 2002:a05:600c:1382:b0:43d:b32:40aa with SMTP id
 5b1f17b1804b1-43db61dc79bmr89216185e9.3.1743459514131; 
 Mon, 31 Mar 2025 15:18:34 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efdffdsm176469675e9.18.2025.03.31.15.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:18:32 -0700 (PDT)
Message-ID: <0cf698de-f8e3-48ac-9707-3d3ac5e6d6ad@linaro.org>
Date: Tue, 1 Apr 2025 00:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 Valentin David <valentin.david@canonical.com>
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

+Valentin

On 23/3/25 22:35, Daan De Meyer wrote:
> We have to make sure the array of bytes read from the path= file
> is null-terminated, otherwise we run into a buffer overrun later on.
> 
> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/smbios/smbios.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd..ad4cd6721e 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>               g_byte_array_append(data, (guint8 *)buf, ret);
>           }
>   
> +        buf[0] = '\0';
> +        g_byte_array_append(data, (guint8 *)buf, 1);
> +
>           qemu_close(fd);
>   
>           *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);


