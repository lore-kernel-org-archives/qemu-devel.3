Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D154CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGYLF-0000Uu-1R; Wed, 05 Nov 2025 02:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGYLC-0000Ud-7k
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:54:02 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGYLA-0006Hz-7k
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:54:01 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso382298166b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 23:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762329238; x=1762934038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=weVajfVoB0oq1Ka3/5ihH6xjQKjeJ/ryJ+5IvAwCj1Y=;
 b=kixDl5YwiWyTgu0fMMyMbW+3LrGTm+IFBl9FtJ7lU18V9XO+v/6LIr7Wt5dzY72HIB
 eOeliLw03gWqwqpmK+O/n9rdtVP3ec4wTN+39TR3xtwAIKSfd7xT1pvGxcHjJxqvBXIx
 3gMG7y4mEU7mn5Nz6TL6TJ0BWppE38IV4c4JFSDasS2MkmnaBQjKMO/rRJvPGFrr4zp6
 zMjdIDzShRkYZggFGYmicsQcCDhrB2IX6oXcdOt8yEcytGNrlt816SUmVmAFb3YC9hfT
 6v8Tf/tcPavwMOcLaZ1fFV08bydmkpu8Vw15/saD3v6Hib0vgUedIB8Vh3/2LvXkJsfq
 i+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762329238; x=1762934038;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weVajfVoB0oq1Ka3/5ihH6xjQKjeJ/ryJ+5IvAwCj1Y=;
 b=Zv9SibNGUclr1lN5YB0s/Exdy2DW3qkSc6hphXRgw7CalwvdXCQjEaEt9rW6AIsFOP
 P5mhqWT1pzb2QcfQejkA1SfT39BGOHqJ3Ln/F/NE1cPXkCKkEyIFlRuZs3L+2yZOIrrr
 DB9s+mfsuxvKYuSFoV91tYElatpk0Ec6/xGWnFY7FvnuZDhUX+1xvFWvhfPpuSZuPDcs
 900kiawRixrZSB6ZIQaVCjnrYJKrpOtsAYwWqSRaKFPtylQvBY+8LTG+sWMdy6VXMwH6
 T8Gh3oL97uIsaQbbu5Xe7K+q8TTokXMPnI+G64RH68YGtoxprOgjIS7uxSyYQTNwFKWM
 ZiKw==
X-Gm-Message-State: AOJu0Yy9gmaUo69SqzCKMKXT1NsuPewH9XicJpBFpTlvEDkqUCz7DQwu
 W50MbDE4phDgcQtNeKmkOGjnLZluhEfx+jfucHVmspsBKoG+vv/sECDesFMvYmh2BJwZFoDU08M
 +A9oBkog=
X-Gm-Gg: ASbGncsv2VOzszIdaZBqy1GcUmv9vy8Nd3LZsmWYAZADmaVst7cDVKZHO4IUcUCDGHK
 jELHvwn5ce32u8N2RJNyT7+RK0Xapyb93f4kXbpdxkbiGgDJNotkLJM1KkegoZY1gIBNh+zZiSy
 OqzpFttYwbjIh/+eWM5SLaqevdt1hEDWhqudt8mm1dWSg2qaoT26ZlXJGumffMtq+aP8DzmMHNd
 k6sd9+a1+wjDj96EqUN7yKt6IlRxrFNY7KTnwrP1zUgADLuRyajcbAp4CY0301oO7x0vKpSRFty
 kSBKuqRmgD/SBLyIM4ZknCaLplExsih52xwJD9ljypE/yTHonSQ0+NlQ6cSDk+Asg06RIsouvYi
 KjAXeMfO43wiruwerNrepJKFG/FRXefyxved5Rzp9WJtGoXMB4JOycyIdzyd5m7qMSW54o6Yfxb
 3K/xatYA5eea5TFkZtKgbhzdcbOZI=
X-Google-Smtp-Source: AGHT+IH6zCZa0A4mnlaMw5EFhy2syuEpedrtZAncDXZ6GCtynhRnZQbGbpAqPyKoGrVVdKXXaFg6AA==
X-Received: by 2002:a17:907:86a4:b0:b6d:7124:3d8f with SMTP id
 a640c23a62f3a-b7265195d1bmr181980266b.6.1762329238465; 
 Tue, 04 Nov 2025 23:53:58 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7240540d7csm411442766b.71.2025.11.04.23.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 23:53:58 -0800 (PST)
Message-ID: <059c316e-de3e-4c2f-bbc7-4a15b40b2b6c@linaro.org>
Date: Wed, 5 Nov 2025 08:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] target-arm queue
To: qemu-devel@nongnu.org
References: <20251103154700.4126379-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103154700.4126379-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 11/3/25 16:46, Peter Maydell wrote:
> One last small target-arm pullreq for before softfreeze.
> 
> thanks
> -- PMM
> 
> The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:
> 
>    Merge tag 'pull-target-arm-20251031' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251103
> 
> for you to fetch changes up to 5848d2c3a6c4cc1b37234db462b1b36bc0a18bf4:
> 
>    docs/devel/testing/fuzzing: Note that you can get qtest to read from a file (2025-11-03 14:16:53 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * allow KVM accelerator on imx8mp-evk
>   * docs/devel/testing/fuzzing: Note that you can get qtest to read from a file

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

