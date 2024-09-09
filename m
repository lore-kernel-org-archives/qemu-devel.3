Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE489ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snies-0005WL-H9; Mon, 09 Sep 2024 13:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snieq-0005Ly-W9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:58:37 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniep-0000oG-81
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:58:36 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f760f7e25bso18150271fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904713; x=1726509513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RGdyl/RLTjhQ5jQlVdPjCZvOYkDGKKpxchPklroK5W0=;
 b=pcksQLQI2C78FMTLOF2VpgC5E+lVLV+gUvLL44nMGeLixuPPSsYcL6m8esM5LW0rHj
 Xse9tlM3+dHeYhNI7q7CwSi0tYtz5yfQynU8kx5mf52oQ0tExc981h+SWsmvKzl4f/su
 oj/bS1GEVOAmjdfvTrXaewtX7wo05uJ0riBt6DfIj+uEqq4AMgYfwkiH73zpavySpAnD
 ZkYAwOJ6uLh7dkAAqfFTKWbuhAA9tVXdA1DyBLYefYbY1E0c+nqvqgMI3X8w0fni0Nzh
 C3kx7PsofLACkwBXE1O1K7GM5m2twYPmm16IaXXzqcxEC2Z0hUm1QAd8nG1BoipxQUXJ
 nC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904713; x=1726509513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RGdyl/RLTjhQ5jQlVdPjCZvOYkDGKKpxchPklroK5W0=;
 b=fOwSqfcsfRnaSwKPDjSJYcdr8dl702SHnJwbKZDjUoesQcF14UpXgWPY00Z1Warts6
 gm4wuuHZWiy6X6pYUpDUMHfGLggBw4MiGCt+bEJXIDv0Rj1x9mS3qM1WtMPR8tM8/WEA
 +d/c0e2U6iEQfiwL+N7guOTfxRPyMtHWkUCQi/7LOMrOGxFw2/g0GftyDOVINOpmVT0w
 /Uo8ww4qESlLKTD8drD7ZmvP/JmJg5WM3rs9zLazuUBJ1dVlgrUKUlQkMs1RR/O7Yx64
 di3IgieNtJwKbSGA/whpY++e9XPKmk1YkrzkRikbRKs8ag6cb0RrRYhc/lH8Rva7gIAx
 Hk9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAgEqGdYmydOV4TTbotOXhMPpZfsjHxp2NmGB4+zzCqcYPWrVgD6JppQG1oWPbjaqzuORZSbLg2p5c@nongnu.org
X-Gm-Message-State: AOJu0Yzaln6Z73PsXTkbVT24lpXuxqBHNdlEfm/q1NxIgJ/h7Wm4gT6y
 QJGTC6plNoDOrVlI7kFrC1+gR3Jw68EKPF49Ir2xT/18NPMiNPSd+7Y97YCZtSc=
X-Google-Smtp-Source: AGHT+IFpLSwz7MBicTXHXv3ukb527xubzj3JqQmB8dlJtYQPKO/3qiCxKIyexYJvRrOpKFr3kJxKYQ==
X-Received: by 2002:a2e:bea6:0:b0:2f7:4c31:acae with SMTP id
 38308e7fff4ca-2f75220a042mr57623441fa.2.1725904713061; 
 Mon, 09 Sep 2024 10:58:33 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467desm3231517a12.40.2024.09.09.10.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:58:32 -0700 (PDT)
Message-ID: <4b1da1e2-03d1-4c14-9a42-03493b84933a@linaro.org>
Date: Mon, 9 Sep 2024 19:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 53/53] hw: Remove omap2 specific defines and enums
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-54-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-54-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove some defines and enums that are OMAP2 specific and
> no longer used anywhere.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h | 207 ------------------------------------------
>   1 file changed, 207 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

