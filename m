Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E1C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWOd-0004PG-F5; Thu, 01 May 2025 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWNa-00037P-5U
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:03:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWNX-0004lx-Jq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:03:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so1343825b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115394; x=1746720194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSiknBL+zuNYB4hZSadNmAyfJsgELRDWKcB7g8qZOrQ=;
 b=msV8A7tD9VHGfQ5YSRcpOneRlDvvmlmsOeMPtKO41bFw8DXhcP6zjiaojZ3c+lDGRL
 7Jpr6dtSIqFWnFC8Mv3x31cUq1MjK9oqma4EmUd0G57DLPQxdKpj6T3fwGsojhFUqSW1
 7qWbFTeWD3Whob3CX+1yY049yqzaxZwOVILx0RxVUzBij2ChjVjQPy73RV7+F60hjjNA
 MWDgmUakInk1m3jfuKWFakhEnkwpYKC29i5laGUqLbJIrzLkC+EoHAvTi07Fn98xHbMr
 W5RbOITo8W9KA+RKyYScNx5hfhZsbY+fjVf1GXYASYTAWQWI1xHTaDgnvII9vWeVhUyw
 YTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115394; x=1746720194;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lSiknBL+zuNYB4hZSadNmAyfJsgELRDWKcB7g8qZOrQ=;
 b=kNu4FY70zOVOYqs0sSEhqdwxVgyeWl/WVfaIJ49pT1aDYUB+Z8ZMy756IRV4a4ZrBt
 p1RIfbw30eex3bHRXHHcLRyeXLOEyWFoSV3C1usNk8z/mmCFznu0Y0lgIuCasM9F3Fhx
 aAANIloaL6+xAZ4ZOMxIka9dE9xVnILh8JexrC4BxibzcRa3R/qws+uVyuOnpwyJ8bDp
 UPVs+UGq7GYPIGoBPEEbZAbwoAGkTTaZIboEItKRGKijLaCHsj+j5k/jXUWpDPXz7Gui
 3eYjHf/o833TSFlBtp7XaV7pW75CG1lkWNBCEIcuXdJrNKLKBD6UNq5z8/NaM8wfMHtE
 8znw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE2GHG/Em1LYS7fbYHsBamMw/LNXWsj8sxOe4rElDPF9X0cqn8z/peXUCbudS3wW/UFg1APfQ6snu1@nongnu.org
X-Gm-Message-State: AOJu0YyOIrJrWcS4uu7xNf2greaz71+Q0652cZmnsxO1WJbvfahtgLOI
 OT6NAkINDYv0hIxesHGh/D1SgKqUHblgo8ik6zbxuo17i05FqgzvpA+0W+onDPQ=
X-Gm-Gg: ASbGncsfHRLzOfGLA6AW07C0lLprb1+mj7bdNUsp/JRuVfT45lBFMPPDX58KJwrUjkR
 xoK7HKOtXigUQtZZlb1p/3Ey8nQrwdm5fksBeOA8437u4Kr+4e3IAXH6+arFXhguF3sf6wDOjGg
 CWGX6EKbBiHBziMbjJZuBWLX2bLNU/gecKGn21RwTuvH5qSAfH8xaGAgA5Rfg8c/HEf7tPjPEKv
 lgFviMS0N6tE+NQx4Q9z3GOhi4qKnzQ77wJ6mnuc6AF/tot+2hqdhb4qpBBclJnFsI5oyo/mijN
 B/mNl8OthlEL1R3OA96yK6zFr1dCR6lZ1M0vYBAQAZqUsMyMvqv93g==
X-Google-Smtp-Source: AGHT+IHW9RmiExvk31GfYhwFD38VH3sTyfug39nZG6obmnlQhjWroMobdNneWrdyXEP28rBnLslAdw==
X-Received: by 2002:a05:6a21:9985:b0:20a:761c:72a4 with SMTP id
 adf61e73a8af0-20bd8644c76mr5103213637.35.1746115393837; 
 Thu, 01 May 2025 09:03:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404fa1f28fsm992385b3a.130.2025.05.01.09.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:03:13 -0700 (PDT)
Message-ID: <fc2c3a5d-712e-4592-828f-9a857a330ea1@linaro.org>
Date: Thu, 1 May 2025 09:03:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] include/user: Use vaddr in guest-host.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Replace abi_ptr and abi_ulong with vaddr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/guest-host.h | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


