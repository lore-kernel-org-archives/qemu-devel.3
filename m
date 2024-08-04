Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89ABC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVbj-0006gx-Er; Sun, 04 Aug 2024 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVbh-0006ff-Cc
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:24:45 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVbf-0003RZ-Q9
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:24:45 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db130a872fso6632875b6e.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756282; x=1723361082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+HMgu+Ln+10CcO5tpaDhcaNT+HQToInF7AUMA8xn98=;
 b=o++D66cbJIm67clAdX5ci7hyuFMLyoBYWri5SulPjk6CfNbpmmiQiqq0Ac/B24X05Z
 Jb0hPt2Qvzi+aWl0rn2bZQxAwJ+xeKwi+2AKJD0hDXqI7UHPSfrdSzcugmirYIBd1uP8
 lKTXBHIzXRMy+is7le1GX31usJstvS6dfjp4cQaOGRhVNMw+GPlMBlaTgDiIp+KY4ZwP
 DabeBeiws0+qfVGoLx+frgncmJWi5l/84Rddm7JQUyXj5b4PluNVTGq3/vG0NmbS7hp+
 ZXUn2AfEacAsXR8CqvvPgyN9LEnR9j7qXZ7EInOHMkEtuMNB4FG9VVwb8BpFPjYiPdqD
 ggXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756282; x=1723361082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+HMgu+Ln+10CcO5tpaDhcaNT+HQToInF7AUMA8xn98=;
 b=D9S6hNj9rgipvYmm29zOmDFnHkg+lrbh54lowHP8Jx7VsnnxL9ns2tpKt6Yo04FyUM
 LIQoBg3PRuXTcXxfrzovzwqXOmwp1JEn5TZgoL97up/dHdYDryAGcDT6Z3j6TUcjXjGk
 widehKkiAaBULBUWzr0m2LJVGLuoDfuAl/Tt6r00b4FIet4NIFAy+UO2CbDK/otIPtoy
 qBBvP8qi2TNV48vF55HRo1FvF57v4GiJwFUqfBlbz+D8dskWeVyZWtcEnp5eagjE4A3P
 yHbPUDQYjtABMW+J+p5dhX7bTVXqCoeRgRLRC1W97Z1OYHblqJM5qAjeSm0fSVhSP3RJ
 S4xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEEKp8Hi+XiJPBaoRyObvin0h0AdcByt1nre+N/xR+uCAvCdTSnu8/kiilOb/102NxYeCWuF4zhqjdtTt1gHMuLxxIkOQ=
X-Gm-Message-State: AOJu0YyeqNx08NZnQP/3jqgTDW2ghK5ZwXY057kPqMUylp7Xm2Rwut6Q
 Zq+0AEGcJhGLULX9yw7l8+6GG7GOEWBEbVrlzcxl0YehjS/tPfDXzxF0kIAVMAU=
X-Google-Smtp-Source: AGHT+IHE1a8Tv3xAkuKai1w71Mw7ZN0V8a88+sg+exrZrFdF6uVSqR+EAF0oYXU0iazRdn8OgugEWg==
X-Received: by 2002:a05:6808:21a9:b0:3d9:3f51:f351 with SMTP id
 5614622812f47-3db55800d3cmr12170421b6e.11.1722756282339; 
 Sun, 04 Aug 2024 00:24:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f2a159sm44936995ad.3.2024.08.04.00.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:24:41 -0700 (PDT)
Message-ID: <79c5256f-df62-48ec-bb96-a6b880a2a675@linaro.org>
Date: Sun, 4 Aug 2024 17:24:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] bsd-user: Implement cpu_copy()
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Stacey Son <sson@FreeBSD.org>, Justin Hibbits <chmeeedalf@gmail.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-5-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-5-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Catch up with 30ba0ee52d15 and implement cpu_copy(). It's needed for
> threading. Stacey's original code, with bug fixes from Jessica, Justin
> and myself.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Jessica Clarke<jrtc27@jrtc27.com>
> Signed-off-by: Justin Hibbits<chmeeedalf@gmail.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/main.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

