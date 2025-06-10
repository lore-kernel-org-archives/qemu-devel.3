Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9904C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtPF-0007By-Dc; Tue, 10 Jun 2025 03:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtP4-00071C-IO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:28:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtOy-0002ZV-Vi
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:28:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4508287895dso37295255e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749540487; x=1750145287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+kk9fqkylNznWDdafQjNEhMNjOzmjPKINhIJOPveM4=;
 b=vFh6aulnrD70YGnKvSPGhKREiMcfrZNkSkYjU2oaysHFMduhaOPsFgv2Wi3+lcfROR
 5bVpsDVxOtIPlBQ9zXoMPoFdIu5BHjZfQtTNrqUvhCeKF8cUtop0+fyAJwj0TJEVPTVF
 9Txx4hCPh47vEz6u//cvD1odUwjMiH5N4ImMF8QrOuVZVD2f0A9TCzSAJAWajuWCsg0f
 TpTvLOQzB2V/HaBMFxS1zhfToWD1Ohj72zixQiwvxanF0RDvIuDd1Ba0LxXOfk/xOJRZ
 fpOssnSCgfKkprPAxuiLlEFnpJATyo3aoHROFnudhGIomsAdiWyQoP/ysoaTkaWhcMcQ
 mOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749540487; x=1750145287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+kk9fqkylNznWDdafQjNEhMNjOzmjPKINhIJOPveM4=;
 b=BKRSfTqaiaek2lnadie0pztQ9zLyiAhmt7VZ8MTZG7i2+32U0VoTzqdNYUZEtcRLOX
 CQh/QZBmcYsKyKkdpDfo7OYiy0aEf3mdqmdiIhXL+jBqBDtsv2ye5uSGkceC8hrI/6WI
 BCHznwvIPEDC/JjSYzbiGW3Ty/7FN2BgD0NF0u6y9M3qvM73hZi3rrX1wa14DDFFrKzU
 kO0l2/tLgUIeFTfwhFAqvHBA+wrntfG0rzBAuKZ0fMcmvL6VYz+tKO3o5ljY5THMNfIc
 eCyroLOUEQ+5r3iIA6L/0pGVzJoGFkK+L+ZmPcxJ11cNp7fsYvD4ds/ZTn57l8+Wpzpg
 Mu+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCl01Zq5crmOSlZ/Geci33rTR/wpXqOXVO/YatfxcYzA8XDoZnSkfd6/+IN5WYk7jTVQ/vOLRje96@nongnu.org
X-Gm-Message-State: AOJu0Yz3YL+v8Q2huUy1i+uCTEn5k4wxoaOHWoNvRJl+b/mcfPdYGAsK
 fKcfoi0bOcKkX8RCb2whcVwrj3Q4mAqQbwJpjUHSk+ejV3OL/elGfiZAMD4/iEtqOqk=
X-Gm-Gg: ASbGnctoZbA/PPcLLsDPoxQ28YThX9oCmy5urR+qZ+CWdPoiPxF+oEh50vB2Tsu5ptS
 q5g6IWsZH/jRof7hTk4LkJeYAOXFCcoWo7B5kEnHVmLFgR8itBvfro0ytMlm2Jyn2Td1FJ6fhWA
 XJlY1EsGOLKR1Qfkowvj3D5PSzwe9LquigaqQFKeWIhG8iS+xAXdYZLosoTf5EYaWwOlcCpaJxI
 rvwYuhwsOwmtkrZ9qhxXJWDJgjR+UOaRBLI9PH2zcGC2FHMTdj3+xJcbe/LrsMcAmXUcw6A7Cxb
 EcHJmfVXlpvvF5H1aACVA4HxI0Sr3xy5E8xpGpgPJzWPuHIbcDACyNApLcagG7J8P92aPHjAQoc
 TrMFPMJYl8TP8PyOsKe3+aczBQUSvymOZoQU=
X-Google-Smtp-Source: AGHT+IGhG6J/sJp9XvcUjPC7LIdRRITG64LSC81MzN+sVHaEr4/0n4rHyMlDK2z/+b0IHg/Vz2fGDw==
X-Received: by 2002:a05:600c:1385:b0:453:ec2:c7b2 with SMTP id
 5b1f17b1804b1-4531cfba2c8mr21361335e9.7.1749540487167; 
 Tue, 10 Jun 2025 00:28:07 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521370936esm132153495e9.20.2025.06.10.00.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:28:06 -0700 (PDT)
Message-ID: <8be517da-44b6-429a-8239-893df5b23b3b@linaro.org>
Date: Tue, 10 Jun 2025 09:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/ppc/pegasos2: Rename mv field in machine state
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746139668.git.balaton@eik.bme.hu>
 <d9b7948b91119474d6068a59b24d8bc47f1dffc8.1746139668.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d9b7948b91119474d6068a59b24d8bc47f1dffc8.1746139668.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/5/25 01:20, BALATON Zoltan wrote:
> Use more generic name for the field used to store the north bridge in
> the machine state.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 7dc7803c64..9b50cd3dab 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -68,7 +68,7 @@ struct Pegasos2MachineState {
>       MachineState parent_obj;
>   
>       PowerPCCPU *cpu;
> -    DeviceState *mv;
> +    DeviceState *nb; /* north bridge */

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


