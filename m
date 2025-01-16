Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46586C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTvc-00030p-85; Thu, 16 Jan 2025 12:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTvU-0002xE-Nh
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:45:06 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTvT-00049p-33
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:45:04 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso1743055a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737049501; x=1737654301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2p028+TzlTag208Tw2/r72TojuK8xQe0R+xDI7RPPCQ=;
 b=a4QUEBPGjfHzIBWI2Wuio10r2oSBd9h0dAFLwquCs9apJIjWHNm8/zNB75nloN0G23
 ftmbxEhZyf2QH517yUsjILLZl3Jqar15NqsrocsM1Bv0Jt4Up+3qkgzFqP2aajHfB4aY
 KtN5RK0oMsLDkqQKi0/Bxk9OyTN7Ow9k11HMCRgCdButFyRaGBYc+Pbo0RpNJuIhbA2h
 g3FKOrTkku4bRZ1TOm8NHRPgkAl15YhEGRC/r3Y7qaR5zgnclHwJrI6g/2ZXTicHr6vl
 xOGekSb0xyPkf9e64ZagdfQrj94Xmr3/KoqeeTKQ8vMlnnbudanGNhBrofXxfEP77ZDO
 xllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049501; x=1737654301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2p028+TzlTag208Tw2/r72TojuK8xQe0R+xDI7RPPCQ=;
 b=ltylFx3+/8RsFEvDZszyFhVGbDyj0TlkcQoYq/6icmZHuHNqOU316HIYyQRE9z4L+m
 iuSgAd74A33j7GtnBtsFokOeSmLLM3GadZqlseTjd3kBoZ7clw8gUIlJ54RV5DXGUV0U
 41aKcryN/sSLBEGJp9YqMrEZod5Xg6CXiyYjPGyEwpDm8GQqHi1HcejtbPx0WlJNPf0s
 CCpw1JsgL4FP4yb34rcx/QbZFXlD9lNo4rHn96Xz3VCZChXVLLJaUqKt04niaORiju4M
 wBdmTPZffpU1VlNslsvqKwYykYpgNZ7DKdc3fR+AfgDh79cx9dHzYnil3ZWPLdKQxOr/
 O2lQ==
X-Gm-Message-State: AOJu0YySRgq7R6615ZmgJ+NnghdiYbH1vCHjx0UV7xbnPabOlfkhimEo
 pfIKma9BzJCnbKoizyJHBsy7wVVcYwAWVOcQykYn8T6YTGUttL4M8181fRN7IFUm99NI64K4Whc
 G
X-Gm-Gg: ASbGncvhOjhpwPU+aJgfOMMAQ+wwodB8odXWp0QEOLhrwF41GKR938y8BVe9KvrPZ8Y
 J9mGwoLZt5qLVxDvDMbz8hI3bDlmNmJL1VfmInb4S2D38Yg5AdZs3xXrjcUahIcj39vM0TJLhrB
 B1T2sEXVSf8IgIYuHuy2QlGXh6lUUFd7j9he0itJmE6plvmRDTdN3C4G4q0WwilxjLxGwfrbNmU
 pO5yEhVK19N8jBCvVVYv74SqtHIyECcq9KoJ8oSDIHKqCcUEnQxDBJd3cJzMm0WaOld7nT/iZkP
 XM/vutM3SMbNZGTynb5s7Ew=
X-Google-Smtp-Source: AGHT+IGD82E+88oquHIAAfG3MOB8nqeBQgvRqeCBDJaCL9Jyk5jqwuzdg1doD1tAmXCGbF8Ky/lNJQ==
X-Received: by 2002:a17:90b:2805:b0:2ee:c6c8:d8a2 with SMTP id
 98e67ed59e1d1-2f548eae525mr53292420a91.14.1737049501539; 
 Thu, 16 Jan 2025 09:45:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629acd5sm420734a91.37.2025.01.16.09.45.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:45:01 -0800 (PST)
Message-ID: <8cb692fc-cc3b-4581-a91d-ef77e25e6894@linaro.org>
Date: Thu, 16 Jan 2025 09:44:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 02/13] hw/arm/virt: Remove
 VirtMachineClass::no_pmu field
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::no_pmu field was only used by
> virt-2.6 machine, which got removed. Remove it and
> simplify machvirt_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/arm/virt.h | 1 -
>   hw/arm/virt.c         | 4 ----
>   2 files changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

