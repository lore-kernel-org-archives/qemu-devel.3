Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47363C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublae-0001dd-KA; Tue, 15 Jul 2025 15:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublHe-0006p2-SU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:25:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublHb-00075C-K1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:25:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so3387541f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607541; x=1753212341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=epbtau3mfk9DJMdMl9jVXDpnXezgjmAx1/t4HCFUui4=;
 b=qYhXzhGbHiNhlvI5cnfoaVbLpmVAqEHbVmrMWJLwrXZmPT6eWLtnOVsoQwJDb3VEEF
 3yHYB7Lksppm0rQhhALzJzMkyqRBWXxdHyhqwBjZ9hbtShEqNpiPJarDnb3Ih8faQKVe
 J6bn364VeJ88yllqd1bic422IjHmC9+P3LOGt+YZKRBlD75OrkLeX0qxmGLOKvN/Q/pt
 5QrzhRVdQsDyq9wZdd6gbC5cHKlJf9uky1CD6cVP5VIFZFo2LDmLq6L5522ZMAShKhtd
 iKGzYBWD9qmcCX8CFYctawWZ4r2dsNXhnXKu5tyHU/5Qf4dQXS4cFnLmQjDC0/TXDx6/
 qlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607541; x=1753212341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=epbtau3mfk9DJMdMl9jVXDpnXezgjmAx1/t4HCFUui4=;
 b=W1363nWMcyxlxiMzHkNBo/XfIsb8TZaQYTqfNHE902FkERw384aa55d/m45yzIwOxx
 2YYZt0hYTbLrP7kO09LbEVGbMg1+QOTPm4LIq6jtRGbDWuNaNILkN2wHwEv+LV0pxJWE
 UeUAu4irPhL/X1B0l1yTPKlXutm2sQdhil4tEcuEQ1XLOw0eKxpvWRejw+/bf14dZXJJ
 qXPotbbcIBWHBjJYMVkgDj/cRMyvhBV2quHwKo9vUDOH9SgodYCx5EwabArqBDjB7PY2
 7qhBLXF+/PFs5M6jZh511p4nMtyiIDPc77kof/72bp3AhcptnptZxc4Cc9DMSwzCJZOS
 uGig==
X-Gm-Message-State: AOJu0YyvyMIXST9OojC0nhcMjGsmXSk0PCY9f2bzxVI7VvSw83nZFjge
 1AEiZEjKZV9fTxmLihxe+js10YEZZC7aeJ36PL7yB6OpjDydbVZeqvOlAXkHbd0CXPn6EPe8mzV
 Bc6cf
X-Gm-Gg: ASbGncvU4cltuldqiyZXVNzo0Fi72DrbOb0cOtzP2BMJ8qfmwNaW5CIKOd3r4+mijmi
 VNdbrbaD2jrcfENzM9Ma/EbNmkwJCAJuH3jXKvf+pbGyjoayN+NV2D4QuWQssiDoqDXN5nZ4G3T
 WyIykcPigPTYmH5slV+DvtHTJRIGjvFjWsvjVRyxXdJ2Y0BFfE8RayiWYWZXTcUMQ1YCDAd3pjD
 MSwPh5uaWPAnS3sYyHkQ6fOY0tYNnBS0vnOJxRKuOaQzwRcg62Ds99PdkYZtaEWEzXfzE7O/xFC
 pw2r8yrdg7CrTTYcnETYvVI/HxByq0faoxFQxGG6l/fK1wGhoIFnvwUtG1r/Yi4eGgfUtNLlIB0
 s27YDUzxOiLJqlKK2Ezuw3mwAzd1GMgiZHup4+l92usSC3dOfChyTKcJkcmMDgICs5AFHETA=
X-Google-Smtp-Source: AGHT+IFpze0b7WsXfdePVDOr1+gg0YPpVi33rfy6T+pguMPneExVvnAdiPASoy/Fln+H+OoB9yKF3g==
X-Received: by 2002:a5d:5e8a:0:b0:3b5:e6bf:5e0c with SMTP id
 ffacd0b85a97d-3b60dd95baemr277349f8f.31.1752607541370; 
 Tue, 15 Jul 2025 12:25:41 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032e9esm208334115e9.3.2025.07.15.12.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:25:40 -0700 (PDT)
Message-ID: <98715ba8-a2b2-4a07-9cac-cc6a40a9f7aa@linaro.org>
Date: Tue, 15 Jul 2025 21:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen/arch_hvm: Unify x86 and ARM variants
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250513171737.74386-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250513171737.74386-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 13/5/25 19:17, Philippe Mathieu-Daudé wrote:
> As each target declares the same prototypes, we can
> use a single header, removing the TARGET_XXX uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/xen_arch_hvm.h  |  9 ---------
>   include/hw/i386/xen_arch_hvm.h | 11 -----------
>   include/hw/xen/arch_hvm.h      | 14 ++++++++++----
>   hw/arm/xen-pvh.c               |  1 -
>   4 files changed, 10 insertions(+), 25 deletions(-)
>   delete mode 100644 include/hw/arm/xen_arch_hvm.h
>   delete mode 100644 include/hw/i386/xen_arch_hvm.h

Queued, thanks.

