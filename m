Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB53C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HSm-0004lt-97; Tue, 22 Apr 2025 13:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HSj-0004iC-Pd
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:31:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HSh-0006uK-Us
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:31:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33e5013aso63150745ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343070; x=1745947870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVp/ZQrN0WZYwvfW0ittshVVvxuL0ikRvmBUDQwaEjM=;
 b=OgTfPojwXi1jgsOyKin50sTLFDlfHMXs36aQNsRH7TM9DD8Z0KfpQLGdxr1MPa3B4O
 +tHeJNG/+Bf1PdQ0AgjQhRtJvYdOhNf06CQGwlBWwfdSVI0RYF6Yk4NY2KTljCf03Bd7
 /7L4aNWt/TlnE0T0DjuJlxjAve193ES7xGJtj9R3NR4fH22DuyCY2E/xJtRtwZmIQf+9
 RVNNd6YasSXu7QMMjtuD07CYov+hCLNFNa4ynLdsWLiN3Yhou+EybYOxFXUgKRwOhCY0
 YSiv/3bh6eZo0wha+qQ6do22wU7Lj6V3xK6AOJcFk3GUZARmD9VH2qbQWGBHi6jTgJzz
 Fl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343070; x=1745947870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVp/ZQrN0WZYwvfW0ittshVVvxuL0ikRvmBUDQwaEjM=;
 b=jZ+wTQH4fN+0f5Dz73w19Lakf70kuXVXNRvx7A4B7V2mPiv/lINKj2A+QKK6zaZN7n
 fs3gN3VWMLZPbM5Yatcg7LPP/TaAgkugiHLecrKNwbMBrbeXMAxVXmwje2yPg2BejYep
 69+fVy4s/ywQ7gy1FkHUYS4z8PbU8l9N6GW8AjRhnA13VJDJ4fYwFiXNaS4iOPhoBY+z
 IwnUwx/ccIS6jRrxuL/N1iWRfC6QwneL8xoMcGHjXruTLzJUpqELgaUckyU3n2IkRRbx
 OC/EBBp7p4jMxNs/VeAeMrQpblfE52+GTrggyVRRVW7GXTjeezw66jPEOaJ2lDDmo/PM
 9DPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzrAINhr4LxNxRNvavKDINyt1NVkf3+UDgxB7NE9a5FEdHekMLSTH/4BaiYKCHjnweyGXnaZW1T+Su@nongnu.org
X-Gm-Message-State: AOJu0Ywq7pUiMaP0MCnY3ApRpdOjAxazHCX4cZiq2VFKfg6AwHokmnPv
 6IZ0cRsz4iFO49byFOrcxE0ohVockzbv3jZfn3Szk5V5lkoRIGw/xASwjUTSrxA=
X-Gm-Gg: ASbGncs4IcgNt5jKj/UNRY91L4ZqIHzLSjq7AEr41zd0U4zLGqScgsA/RcubBrdGg6W
 Ol22trtCsyvJ+C0LZvTzB57VCmokPgUDDd6Z366bZw8vTZgusggw8J7T4/Ik97/PBlwDOYY3oF7
 wr8c2Dg1vwzoXsCr0QqecL6fsQpJjX6t7FXvevMwzchdKsu21Iy4p0lGWxf7gyd6+oYKO9fbCco
 uc2Ij1/gXqENyuRv0vZuLqLSRgqmsU7DKJXK8GiyOjBdHPovMMksacj8d12iNIwlJCtnUB+fTiV
 fcYua0yg7BRR7rpDij5qlc0rPSNc51g/lJNFeHjRdKmTOLsfvF+xcHdWcipXTzMjhUjCmQCBa0o
 wyICuCmTYuJGSa64o4A==
X-Google-Smtp-Source: AGHT+IHIvTkBeZYTssewmEQSyaacrmFKyFMP0z89WniRC2PHNQzY+UD/8kanLgIFikoQh+NWjUmK4A==
X-Received: by 2002:a17:903:2a90:b0:223:64bb:f657 with SMTP id
 d9443c01a7336-22c5362cc3emr236024935ad.46.1745343070079; 
 Tue, 22 Apr 2025 10:31:10 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb535fsm87745045ad.126.2025.04.22.10.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:31:09 -0700 (PDT)
Message-ID: <d35e1770-4595-456b-b560-058deaf7cfba@linaro.org>
Date: Tue, 22 Apr 2025 10:31:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 04/19] hw/arm: Register
 TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
> QOM interface names to allow machines to implement them.
> 
> Register these interfaces in common code in target_info-qom.c used
> by all binaries because QOM interfaces must be registered before
> being checked (see next commit with the 'none' machine).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/machines-qom.h | 18 ++++++++++++++++++
>   target-info-qom.c             |  9 +++++++++
>   2 files changed, 27 insertions(+)
>   create mode 100644 include/hw/arm/machines-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

