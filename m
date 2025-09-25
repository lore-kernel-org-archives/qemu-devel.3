Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F257CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jMA-0002wa-ER; Thu, 25 Sep 2025 06:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jM8-0002sM-Ly
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:37:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jLs-0005Db-I0
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:37:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso4724195e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796644; x=1759401444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FU0QooF1+7RmKDNJ+waHYaNU0BUHYnHkl4jRqcidB0E=;
 b=vH4dLzFdmrvNuMgjfyZF2iGIU0tZeochXKUSl1PVk4ewn4tJ4aB4bgQkG/WRe3z2BY
 Zum9tKIsQWA3XOB4VMB/UiBc0MPCxTeAmLzYCKmHXYNL+WxzWEDxGSY2u7pFrMIjykXY
 oC2xq4d4vkjgkA9ycQ0KoKpI0tGt4zyjvG7bgm87lc5SZJj0p1+/OAoJf3KwJVVuTfUL
 DEEe3FFHlOB5V+KtfLEQNG2BcxNieIadbhX/RcHeo0bGeML4SUHmT1vS0NZdMzJ1K1cN
 AmySiZ1rvEOElaEESuwvRhTVqozeY1bpzxHHgy0r5t9R7SEwBpjryc/xxi5bnyOClsIx
 Iyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796644; x=1759401444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FU0QooF1+7RmKDNJ+waHYaNU0BUHYnHkl4jRqcidB0E=;
 b=ipy9ofENCFsZSNiqsP+Uo1T16iiBO1ziZSo+bMP3MiHDk+jxyx8VZM2AfvaA6WdENb
 gO73R9ZXk/NtKa5VamabcBVUMyptvVxFldr/iR2uxqkBvhBv4Z56ith4Oj+M+A7/e+Tq
 AumZSbJ0DHtVh+GRQ0J1p4MUeHctgCnX4Xza3jXDs+JsZyHTxQoJbqn7dXRKPLSP8+CP
 DgRRML4OeRti6npFwrr25H2FLnP9Khtv4q8xNvYIB0SkUnlbyK/p2Vv6w1EFRk+VDPBz
 gFBFne+s9uUyiwtHhyCStX+w/hdyjM2gaBYcrdS1SNTvxjWBWQbMiGtOUp6fMoq5A+/U
 3GPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaJHNuwbWuLDOVnzZ4g01TOZxqUlw45eKGoOcHZFrxqgozGWfWlDW0Ds1mXAzjcbYOFCR6WOYILWdM@nongnu.org
X-Gm-Message-State: AOJu0YwoDYUracwpdiTk6SVuf+BEJFLwUBxW1bQboo3DO3fox+Egn1md
 I7vjPowclqCCEzuW1mRWRBso3MHIyc7OcUWJCRejYFMnmB456va68oyNrGyNgLIHuQ4eFpYkq1w
 JaQCu0E5xxg==
X-Gm-Gg: ASbGncvSrMAdxARhU4bHL10ZpnhM4g6yJr2VE1uXdF42aVOZ3Q0OLXMS4uUkzb3Jqkc
 QSp6WwdQjgC5HJdMnvlCwp5bQk+jHvoxPih1LXxkQOYN7yRv8HUgW674jn4SBFWqUUpY52NHgf0
 gVUXpFhzZiRmK4ARPrfByaloDQVb9PTduEJZ/TfTjEDC/bFLOZ1s6yJw848roVY2HPKi4Xb2PpP
 oaGHvvQnZtdGroG1rDWLJGAlz/9lTnlt+zVSJCPC/Kf88gU93A18912chgKJfBllBIp9Dr32wAm
 bD512SwjL1rdiNGmLvyR4S/ABjiYG8U8vLaFQF8ce8icw8SIs8v5eK2sK+3VHOlJ4GDTLnkFupL
 yKGR5byDGWx1xqiKsBFyehviG4UTScfl9SyXHvTean6VkR53L8Mv3vV0OhNO6YSTH8FyV6vOpoQ
 WG
X-Google-Smtp-Source: AGHT+IHUHOMfE4mGcXVuNHoUjpGjFSONaFWXHQmaJ0AatJPUlcbVbi/5Yeq93ZFHX9Yof+bo3OJquQ==
X-Received: by 2002:a05:600c:1695:b0:45b:7e86:7378 with SMTP id
 5b1f17b1804b1-46e32a1987cmr17804665e9.34.1758796643984; 
 Thu, 25 Sep 2025 03:37:23 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb1a3sm2485477f8f.10.2025.09.25.03.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:37:23 -0700 (PDT)
Message-ID: <24a761fb-d3c2-4f53-b371-e7ab162c0aaf@linaro.org>
Date: Thu, 25 Sep 2025 12:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/36] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Prepare for 128-bit fields by using a better query api.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h  | 10 ++++++----
>   target/arm/gdbstub.c |  7 +++++--
>   target/arm/helper.c  | 18 +++++++++++++-----
>   3 files changed, 24 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


