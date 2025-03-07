Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC3C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqecL-0003d2-Np; Fri, 07 Mar 2025 15:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqecD-0003cC-NO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:48:20 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqecC-00052b-1H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:48:17 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so4379795a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741380494; x=1741985294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mP0ey5gOmHtDhYxtoP2ViJ36qFqdu5yKgOMz6cPBmSY=;
 b=eheEt/NCQANXL50yeW3qC/41r+LtlCd/J1DhYpHMCIVFOg5VgJaQg02whLjg7Zhh66
 mKKhqNOhuGURNJ5T/j4O2IuXP17w0HK6KjarY+aXEBEeutrhZcPEDffzhOa9gpqy6Z3a
 TR5kyWV3vj6VLXlmQh1ExLunprEfOMdYUDxNdhAShjujtHU47fsY3eUbVwP/h5dbcn8k
 IKx1IE6q6BrVG+lV9xRN2CDscvtSfqCwFvUJufsD1PQK8xSTom0a0mPCv5TMzp3g1Cx+
 x5L0Qa6/4z5fQr5ZPY/oqrN/ooWN/xqMmcD8WQ6EbU5F8E1FSr+Lm085UApFmIspeclm
 kolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380494; x=1741985294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mP0ey5gOmHtDhYxtoP2ViJ36qFqdu5yKgOMz6cPBmSY=;
 b=ZY631lPOjZtTiaw687nj8yLH6e7xnLDRaoa0Ey2Rm0LbHBuKi1p+vil3b/FNJk5Nar
 kymtQTqCf3FNnH1a8gmsjPxIS2LgQEh3w4QNLwQIb58MHmdMwoJmHbe1ctpvMWwsw/VJ
 KAGeJAySVIea0AMXW1QoPQJ+RH8BWXmvJBBsfwIPHyvBwvtTGO2ifgc3UhWHt5xIoxaG
 CbX/BXcMiM3jHJW96LOFvJQjE0NZTMWUt7PXSMTLOaKIWkS4oXlfi9TMiSTkqQG/ymx6
 jmVMe3QISJaVxPiFhoKCQ2rbWb81a/6ebJV78I+zc3BfKV5FgEjYXQ+qckhZ8n3XzZRz
 D+zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWedPZkBQuJwQ+f9Wu/c2DY9kCju5+sEw6MrgJGWkFJdOR1rHAxrIjSqY72LGYIriTrFdG0BRO63NBC@nongnu.org
X-Gm-Message-State: AOJu0YwGlISKHrcCsWl1ehq8+srZSPub1lS0DNIIW6lL/n/UznFGvxm9
 yVLRjsML8x/5cfIFLK5uytYSk3ds5Cm+ysN65tjJzvb2vOmNshnYJ5MXE2vqpvA=
X-Gm-Gg: ASbGnctbp7iIH99kAUC50NI8CEEZoqtFEHrWQkRYF5awZiB9BAC/6IaML8OTDcXbaXa
 1yYeBL3UdCNOFdgjX679hTJbFpOmXUjRV50xRt0CRcuegpzHjomyqjkXRUaN1sd9a5cGiRqvDEH
 Mt/rNZbh+ohBloXrqytW3BfAGtWwaANgRU43k39rXPYu16NA1xrp+aUL2V1++uIfyt2TftNdYPx
 fin4DXvz5RWZHkAZLRGktvzk4Q4iwiHFIFM1PJ2zs+h1LBVQb0kxM5m0SgGAKVsLt6/yYdDtI4q
 sxCN/FE217hz1+azxxg5p3Ub50ylo0GGgagsSDRHoO+g9YEvdUz1pA2XGu7JxMmYVOrMrdRuQbl
 wft29B/ru
X-Google-Smtp-Source: AGHT+IEWkQlrdetRd94fT+hOzz8JRKTvbKVL3l4M8roPMIfPg3hSlPN7m+QLOA5e070tYHII4qe9xg==
X-Received: by 2002:a17:90b:17c3:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2ff7cf4809amr7523764a91.29.1741380494492; 
 Fri, 07 Mar 2025 12:48:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e823b98sm5398968a91.46.2025.03.07.12.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:48:14 -0800 (PST)
Message-ID: <4e5205b8-128e-40df-b926-104a5da33e85@linaro.org>
Date: Fri, 7 Mar 2025 12:48:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/vfio/platform: Check CONFIG_IOMMUFD at runtime
 using iommufd_builtin
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Convert the compile time check on the CONFIG_IOMMUFD definition
> by a runtime one by calling iommufd_builtin().
> 
> Since the file doesn't use any target-specific knowledge anymore,
> move it to system_ss[] to build it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/platform.c  | 25 ++++++++++++-------------
>   hw/vfio/meson.build |  2 +-
>   2 files changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

