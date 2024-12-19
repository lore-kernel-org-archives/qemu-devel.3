Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC912E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK2o-0006QG-NA; Thu, 19 Dec 2024 12:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK2l-0006PQ-KP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:10:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK2j-0005TQ-Cu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:10:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso13855505e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628231; x=1735233031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+TYAukc6iRRNb5sOg0qlc1adS4Tt4NhRkMzPKG6l1i8=;
 b=tJvbTP/gbQwHQrVxMGkLL18egxo/sNN8EMz7F5gWuo3zvuYUTTMtIbGrP0ae6WRZAi
 v5kZD9+14k21STd3GJCmdXRFw28qJ4AJ+WHLD2tEVAe+1RJ2v9OhV8ztf4fntLiblmbJ
 +znnUpDnX6c0eqhcMX5XVtj9t3/Th3tKfBsN8wXA4UiBAbiZYMLYE5hL5tRRYYW3Oxu7
 Ll2mclkZNSpPn6CPPHtVAcZc5S7nXcT+dExxsn8J4Lm6WOkkPO8QiA/O2MKFiwWIQ7bl
 bHrg9CeCwcBSxk75/P8uDOe6QUlOB8yLFhBwRTRGiXED8DrwTtePzawlB64KwNaqogWM
 F9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628231; x=1735233031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+TYAukc6iRRNb5sOg0qlc1adS4Tt4NhRkMzPKG6l1i8=;
 b=DmzXvLOvE26KyVcWEFA/xPg31fAk6SEJs1BLpZMkx5kRxcKEcEh8Kspf7pzL0ncYLd
 mqrEWnr/SAqQB3d9nH4Q6G3wzF8hdB2sFB+940y/xDIAIfWQUYj0Q+F4KLpb5mpeyRiA
 7GtPlmmhK0LgwMTsM6O+GYftCVQC0bSKsHAJF1TyJzbxOSXTHHSzAnWxv03+16o4UBPf
 WRtUI99R0QRmh+xijF3D8mn6wlz5ijg+HHYnhDrxYKR07pCBfsgDSYQSR4P54YjfaTT7
 /TyJqkrM247Z2jOJTQKHb6twXLu3IXK50AdkiUkRY1sZvR2OPW+hqFbi/hCGyhdv1Y21
 MAcw==
X-Gm-Message-State: AOJu0YzP2ABh+4x04mqLscHqA7SfXbUpoSsUDRrsays+690PenVkoIdg
 J5zL/PAIYnHXv924/0mh/bmzTWLR/I8viuW3N64UmAE+WioVYxCBnf2d3ARGXUcubj4pkPg73g+
 z
X-Gm-Gg: ASbGncvPKelvaP7GHBBD2MPNMBAJtQsg6IPFQWXAv4+qIC2i/b5rPgRrx/kusQO7CyT
 qiCYfwYvR7IHbOLlM9MW1N06yaXCp/vcPvwTm/9+BZC8G7OyWeBDsnc2gDcUNDdE11URbPHA/yQ
 gfSnayGx2b079fRDpX2HRwxTVaMQrGUxqinP3qXe32/V8jhmz/U6COOGDNXZw9XpEmvCiPXxVBO
 x0VsUdAnAPi+HkoxXy0rqwrb1Zml7L1dae4vEqChkkajtKA0G2wy9hq8MOxwuMipz/E/qI=
X-Google-Smtp-Source: AGHT+IEbphGYZcmiXYPvtFPSD2jPJzkcLJlggdQX1m6CanxfYNFPlZ2ZWZ7S6fwZSeE+7H+/nagJVg==
X-Received: by 2002:adf:9783:0:b0:385:fa30:4f87 with SMTP id
 ffacd0b85a97d-38a1a184845mr3257070f8f.0.1734628231449; 
 Thu, 19 Dec 2024 09:10:31 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm2006748f8f.79.2024.12.19.09.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:10:30 -0800 (PST)
Message-ID: <bcb5e1b3-dccc-41a7-ae50-ba7ef6a302a8@linaro.org>
Date: Thu, 19 Dec 2024 18:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Declare cpu_loop_exit_requested() in
 'exec/cpu-common.h'
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241217140648.98538-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241217140648.98538-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/12/24 15:06, Philippe Mathieu-Daudé wrote:
> Move cpu_loop_exit_requested() declaration to "exec/cpu-common.h",
> along with the related cpu_loop_exit_noexc(), cpu_loop_exit(),
> cpu_loop_exit_atomic() and cpu_loop_exit_restore() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20241212185341.2857-19-philmd@linaro.org>
> ---
>   include/exec/cpu-common.h     | 18 ++++++++++++++++++
>   include/exec/exec-all.h       | 17 -----------------
>   accel/tcg/cpu-exec.c          |  2 +-
>   target/arm/tcg/helper-a64.c   |  1 +
>   target/s390x/tcg/mem_helper.c |  1 +
>   5 files changed, 21 insertions(+), 18 deletions(-)

Patch queued.


