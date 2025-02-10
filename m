Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7055AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYnp-0002vR-1Y; Mon, 10 Feb 2025 13:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYnW-0002sU-OV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:46:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYnU-0000fx-J0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:46:22 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f62cc4088so48264935ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739213178; x=1739817978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGFemVQMQcoNIsaaDMc/XO2K+ag+kv6Pu7SxhV7ZQfo=;
 b=QJRE2KihN544TtR9mOFJUmWOOMOFwlLkgiguDfW69Gi0M2w4tyyYwuyOXhVNroXSWQ
 thfGwszw0vxqzUvhIRr5/tz6eCBs8r+kH/kgM1nplw7lQxYash2P4TquFkQ40BE6PsL9
 fIa3ELJI2HVYS7uDHiXH1333b6qkWKwLisG6N97uPwQ+uZJVTk6ziSKoH1F5kv2eaeow
 QVBIzshDPoGkP9/3iTXMn0ng/dpDPTQbLSDInWUSi6U3a+7D61Ig8WSddZkM26ZwsFG0
 Dv+bDGMZ4n8MGro4oSXdSjK2XLH7XH84Xt9lsJlgW4OVTPINqigTOiLUT0lPfONrE8QB
 SFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739213178; x=1739817978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGFemVQMQcoNIsaaDMc/XO2K+ag+kv6Pu7SxhV7ZQfo=;
 b=d3DBY5GKQ6QCr8KOZRtPii1ewrDSJfHzX7pphWMkYgIkkEAQAcgFXPQexNmW6h8XHq
 GrRe5c1pZP1e9eZW6zejSbZdHEZ5EY5KNx5rx9ixEBSwg+OmXy4XiP2NORG3dPGQBjTn
 EGHAVbPJmgqu7CDevH3gbeF8V/AceZ3Gk/XanaIfHHH66yNw/EjNe0x/vJasmSVys0hM
 ZSE1SU6zG7F3W6DUMtDdTShTWMUkxFXWSrNDjiAKZW9aemU7J/THCg+LBnt1CplaaiMv
 /FA17wnKCN3nJRjCmPeA2zuGOfP1CuI5eFoTi+D9ycmRuTL8BuKWvfxVBYKEHLB/slAw
 wzbQ==
X-Gm-Message-State: AOJu0Yw0oEBnMs6FzeQhfsKvvunkFYk4VKlksD1kF46N+pU3hW2GC82m
 +2goJP0BVXqOLMfNaWO2TOjt88dH92qdhokQqPtj85m4vmBLIPmoVbuHVtqWGMl3E9AhGtZfi1K
 B
X-Gm-Gg: ASbGnctvEhiSCXBDxUzAMJKTuDEXLrX4/JRT6Nq3IkmkcZcG4zrVjy4x0bA/1XsAuwC
 vgGP4DOZSUovIsz04a+hUtIDrv7mIS/dakC/dn+XDN3fj+OwZLOMyrf9IEuUf8NDueSysHywvRq
 trrqkuAae2iOwykuJyG3z4UanyI056ag2mR0MrPQ7P0TRUtimn/E7PXok2qHOYOGJM3b41ebMC2
 Yg/TI95Q81cK19EZZuU5FSNYpu4JgYFxbwgjffe+ESRMJZDNMxSds5qz0Z3xocA6tC/HGsQ3qek
 oVBtU5h04uWuhx2mOW6WoAQ14PV4CFRaoEkdPUl5db5+w0d+7ZHpJ+0=
X-Google-Smtp-Source: AGHT+IG+1WtTdcTE0oMlZnlnwOEjDCzgHAdTKP1tpuSmSFN1SagiCf65w1QUealoLfKvXVxBJUwmZg==
X-Received: by 2002:a05:6a00:e15:b0:730:91fc:f9c4 with SMTP id
 d2e1a72fcca58-73091fd0209mr6646072b3a.24.1739213178019; 
 Mon, 10 Feb 2025 10:46:18 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf133bsm8008525b3a.94.2025.02.10.10.46.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 10:46:17 -0800 (PST)
Message-ID: <df3be491-0376-41ef-8a06-9ec0c06a03db@linaro.org>
Date: Mon, 10 Feb 2025 10:46:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/arm: Report correct syndrome for UNDEFINED
 AT ops with wrong NSE, NS
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/30/25 10:22, Peter Maydell wrote:
> R_NYXTL says that these AT insns should be UNDEFINED if they
> would operate on an EL lower than EL3 and SCR_EL3.{NSE,NS} is
> set to the Reserved {1, 0}. We were incorrectly reporting
> them with the wrong syndrome; use CP_ACCESS_TRAP_UNCATEGORIZED
> so they are reported as UNDEFINED.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 1acd00ef1410 ("target/arm/helper: Check SCR_EL3.{NSE, NS} encoding for AT instructions")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

