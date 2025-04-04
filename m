Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371F7C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0i7F-0008Ns-TH; Fri, 04 Apr 2025 10:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0i77-0008Nf-PH
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:33:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0i75-0001gv-Qy
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:33:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227914acd20so30825105ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743777222; x=1744382022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8D3mWF9GZKN5Jvv8wQEoblGu7xylnprNzvjb+81LPFw=;
 b=SHLoNhkO/+fX/tR04Ocq/81xmzO2T8/rnin9EinPyU5Jfb8bvs4xEncpV7h8CfUSsE
 4EjtX80B03lU1bwy17jpDHtxMXs54YJCoDSaCt3LMXPWYKsa+lJM1gOFj8Ufoj4iHTOS
 rjotygiuRNT19WoiRBr3zgtV/9mZbHgwbUENtwDnP5XOmUdsd6Ww7x3U+apOngHe69FU
 1VxfKKrP+QGNRBiptTHi0h3MgW4y1PLiL07hHBc2EbRpUg4i5Esqn/oKqh5B1Htda8TV
 OTDAlEhJ0516ry3JtKHwoWsqqE2iGTXyuJvX9GT0Xc8x3KuVGL6JscgYScs3/w/vjQBj
 Jycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743777222; x=1744382022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8D3mWF9GZKN5Jvv8wQEoblGu7xylnprNzvjb+81LPFw=;
 b=ItQ7TbjFhc78SKggT8cznZxAgQ5TzFHLp1WjqherdXP8+ZFNTgGrjRGvA61qfsq5EV
 ZnlgH/2lfZ4rd9kZc0j7QWhMhW80z+gHXFsTzCLWQx3x7ENVbgrvmpADMOOOx/3l+ppn
 7UNbqcds9PPJ+qQXxqdyACgIRQk411924G7KqUrsDA2ax0cIcSrQdY7Q0i1XaQJe/87+
 3T77xuZJEKr2m9GNLkjdlop3MALcpn9MsOL2gEbZSlmRfvb46OT1EZMjBsxeTPnOPjse
 hUDVG/6nErsiZY7aRTa/rDBLWthdl5mCbGnHPAPIYoQDNVCx1kokzxIL2tQgDRekluj2
 dYDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdEHTtAgAtbQKijn6XBf4sX0V7qCU76Ugfux2BujVRKcvxnWGz5+DJEzNw7P2EnnMd5IdpmJZNR6/l@nongnu.org
X-Gm-Message-State: AOJu0YxVR1RrXZuYNbuHTOomOW6hiAJl6MWTyTIDEVFN2Xn6ByWRQn1b
 QjQ66JfbQOaekA+M+/xr6KiG9rvXt/KD8Gg9RnwHUIkXrq42plRTTjaGpezA73Y=
X-Gm-Gg: ASbGncuqmPehGE5t0mi4PjQrHZxjf+ta6HEXr4DSoVhBH7CVT5kYKuHhMOhvSkQRrTI
 PTD3DCPr0PY10jhJEf8h9Q0vWTBxmPjVC30BQ8Vt7+rws7ycGyTCO/wfx+Myn5RVt0P7SGZa7Ej
 lJWJmoFhbaWl9B21K6DHBO7oIJJGgVwsgZ3V3gpwU/Che71OjPIHJcjBB9WuFecdx2ozqrCe0IY
 GkYYR9swRavHpIHk/N8uvc9bGc4Y2pxHr/gxGkOhwdtg/3h9p8chjq3Bpbn5zL8kEdwFQAEto9P
 j8fLJUW+P7rbch4Rt0KHtN8dSbgrKvf3ROjDNEajmK767sFtA7GAA5oCJzhSDL5G
X-Google-Smtp-Source: AGHT+IGL1oZCzkaXgAy1mkChz3IJ0sVD9iUm7sA0Dxb0uJLkrGGs42HdJaX8++GMKPeWkW16PNHN6g==
X-Received: by 2002:a17:902:ce8f:b0:224:3610:bef4 with SMTP id
 d9443c01a7336-22976733d1dmr108050815ad.25.1743777221575; 
 Fri, 04 Apr 2025 07:33:41 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e1bfsm32802945ad.168.2025.04.04.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 07:33:41 -0700 (PDT)
Message-ID: <3b0711cc-3747-4cba-a759-8a74de500e0c@linaro.org>
Date: Fri, 4 Apr 2025 07:33:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/hexagon: Add memory order definition
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
 <20250404025203.335025-7-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404025203.335025-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/3/25 19:52, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu-param.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
> index 45ee7b4640..ccaf6a9d28 100644
> --- a/target/hexagon/cpu-param.h
> +++ b/target/hexagon/cpu-param.h
> @@ -23,4 +23,9 @@
>   #define TARGET_PHYS_ADDR_SPACE_BITS 36
>   #define TARGET_VIRT_ADDR_SPACE_BITS 32
>   
> +/*
> + * Hexagon processors have a strong memory model.
> + */
> +#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)
> +
>   #endif

Excellent, then we have that covered with

https://patchew.org/QEMU/20250321181549.3331-1-philmd@linaro.org/20250321181549.3331-2-philmd@linaro.org/

and the follow-up

https://patchew.org/QEMU/20250321181549.3331-1-philmd@linaro.org/20250321181549.3331-8-philmd@linaro.org/

which moves that macro to a field in TCGCPUOps.


r~

