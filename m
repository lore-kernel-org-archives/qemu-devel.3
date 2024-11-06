Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D74D3E78C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8coP-00070Y-3r; Wed, 06 Nov 2024 04:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8coJ-0006xe-Gt
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:58:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8coH-0008Qz-9F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:58:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so57699005e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730887121; x=1731491921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mecn889zDVoUW+q4R0eX3ElbkcxS7OT0MnSuiI5fVAY=;
 b=SWdJ2oGjADZN5hMJpxcq6YLJSnNEKkTSyAcAtUOtjwx2qoJ3zI6yy7euIqqpBJNIzY
 ko82/6qgkeDrRZIydQw3Hf8iInBw5Z1fKIgZCNPCgKo7bATfs3S7PDK/n0P+jp+dRUnY
 PRyPUWw58yA3J1sK60O7pfd0SDdZAqBBBqBCZCe2cr8SBJY9hV58Un37NyGoxPLs0jZ4
 T/oZ/yGRSMmJresbBiqwpSboUzWWzBdT8BSpQfqqLc0G8g+BN6iRv/ZwYA7uVNfFeS+n
 U1Expy8LS7TheFqRjpgND5aiyQvKWGjsGDzbtAG+O8/qIx2W4dxq/r1eY/jE3q3XxkXu
 rBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730887121; x=1731491921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mecn889zDVoUW+q4R0eX3ElbkcxS7OT0MnSuiI5fVAY=;
 b=fQXyAr3Ef16gmCAAxrfGOf8PHm/qMNsxQyztYHFr821GNM4aNE2d4GPIKutG6f8kbp
 DEm5mC9zbtaQBmrHUnLDEYeaznYEX/k08LCxW21qbUmVZTqxdOtjKmtoBg9zkt9ran2d
 9cyy+cMK/YTSxUt2jlqFIsnf9oZKsqsD8BetAW4PhxXUFAy2J6O3n98Lm5EDbkdQUVcJ
 q0k0hy3D2BuKFWI0CUJZxn31MjCihBpxtSTxm/B/fQPtVc+wKKBf/9ONR3ZHB35gZAhq
 wVa0CmNVkU/uoCbSC6a0JnPLwXpRykmDCibNCgYrPckzgKRy+CSw0jXVgnwOJ+aWhuTi
 35hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH6FQnonqRES7R6UGB1K8sGqIM8y4owydDmzc4cttSOTuAfpp+zeDodwqcjRYjfEy/pJi479xYYFsu@nongnu.org
X-Gm-Message-State: AOJu0YyLPVlP85+mNNUuv5eqw5C8Rqhaajy2T0aUftDPYH674q3AaXH1
 H6Z0n0tU4mcxjiZSXJ+tgYMtLA1v5J8hu7EIxDzP2zB8GIgPEZXaauObeAZLPp8=
X-Google-Smtp-Source: AGHT+IH5irNII5xH1WmUTtbfmd4ee9RpJQ9ph12xhOudVK3B2Jgo64X6iNgTCJSAejsOQ45VpYRHIg==
X-Received: by 2002:a05:600c:1c9e:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4327b80d3c5mr210706445e9.25.1730887121180; 
 Wed, 06 Nov 2024 01:58:41 -0800 (PST)
Received: from [172.16.23.118] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c6569sm16146695e9.21.2024.11.06.01.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 01:58:40 -0800 (PST)
Message-ID: <358104cb-e221-4c14-9ed5-3b165235a917@linaro.org>
Date: Wed, 6 Nov 2024 09:58:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix setreuid and setregid to use direct
 syscalls
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Riku Voipio <riku.voipio@linaro.org>, qemu-devel@nongnu.org
References: <Zyo2jMKqq8hG8Pkz@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zyo2jMKqq8hG8Pkz@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 11/5/24 15:15, Helge Deller wrote:
> The commit fd6f7798ac30 ("linux-user: Use direct syscalls for setuid(),
> etc") added direct syscall wrappers for setuid(), setgid(), etc since the
> system calls have different semantics than the libc functions.
> 
> Add and use the corresponding wrappers for setreuid and setregid which
> were missed in that commit.
> 
> This fixes the build of the debian package of the uid_wrapper library
> (https://cwrap.org/uid_wrapper.html) when running linux-user.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

