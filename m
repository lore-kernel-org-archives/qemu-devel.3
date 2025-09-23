Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E14ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10RN-0002Ee-UJ; Tue, 23 Sep 2025 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10RL-0001zS-5l
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:40:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10RD-0005SS-4z
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:40:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so3441965f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623995; x=1759228795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u8YM2IxWb3saSb+1fZV7H/zMIxhPS36gWBt/3ozk18M=;
 b=kSvw9+HRzlEMMVAhi6t4vzKVqYp2bwV0ykuJnhd5Bk0iDyv4ORBDxdc4zUX+xl/fwG
 hVbjtjN+rLDx2dz3bSeIiMUeOye6z5H0BnR00LTG1nGBFgSZ0bYoZKht29YucldoFKop
 8uWupE5oXGm/NyG7cm6Do/3ZQs9puGFYj8PuGOBZCM5+Zd/Hdeh7bsIydPFbIsKKrkCv
 qzWsWC+0NUfZuurf6uPN3TwXo51ynTNlt6rgWiRjWN1M9Obk/oWRAe+56yh7+uEB10w4
 QfXPwWBaY7QITl57gwci4OVz7Q3+SZ2xYFBKxFlB+lH4k2kOnBruxbI/33kuUccOOzZ/
 sQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623995; x=1759228795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8YM2IxWb3saSb+1fZV7H/zMIxhPS36gWBt/3ozk18M=;
 b=M5R0MuTxXIFqxcfgKPBPHRYlHq2VYVYVjP8B+L3fmM/k9SjutrTy1jZi9KxkX6M9YK
 IrtMEI+vB/19dUHhcYxuXn5mqn2unqhohDJ1APgYSpnZh9RUpAmzil5k4gGIFfE4qLyf
 1NuWuQ9YukpViNCLLqB2cU1qFiYtDPR5U/n5lXEkX3ennmzRTBx46JkK39ugc7hZBBO0
 Dp+5l+Pv3jpUukFSFOmj5wmhwz4J+SiaDZU4z5vih4+2wMCQ9pOxSHnE/upBwzKspRUd
 alk5TIN3h3XXnn0D9nk/36kyR23D1SZfAhCsH+5deDgZMtDLl67nzSff+xeOMoGs/6gm
 J8Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkQSy9muozEq3v4A6+vkHqwLPYoZ8c84L1pTxC+W+bsIydZCf1FZXmNcO1BO3r0XJSc5oXHPAo268O@nongnu.org
X-Gm-Message-State: AOJu0YzyLvs7ENqdGGlMj6wx8R6HhZmZZ+Xnuc+I0w+lpjLVWFpAnSRf
 me8tCPZLtWADemXfgY1T5+eoQJpkoaoTUBbVTWDOyh45r/tjhmlai9jI6zNja8M+GDo=
X-Gm-Gg: ASbGnct7NffZpZEjjUyLcRTtrBe3jdDmczr4J9H0263DYGPsGHSFVNYqjd+AaYKhG4d
 PTecL7EafYszUWG0J23MwK8h5QCW4Z7Ngw37z4x4G6L9kYeHkhDRjeG4ftfUK/rfR6b1yZbrjDe
 GveYEx0m44QbbGV+338nmZoJAHyeybU6KrwEpX0WXAWBLgL+hfKAH/J8KG/47tiPUu6v1WJPZ54
 z1eDuCZlFlFu4eQXZJdHUiNP7xcxuhWxRBpPzYMbNtuUPkzBcEzrfTLsTAF45Ek0Tx5Xtrb018g
 yBuH3/caEqW+9H3hSFY6+o1iHB9VPY1QNp17Gj8KkqSqTv8oDKJIPA2NgSv2OouqzkHxXdMPn6q
 /5TXSwu5NICXeTVmlFQOSNetlqlRTwP4pmK3X/zy0L5EhNX+FTY0Z+8/bEuZiYscx3A==
X-Google-Smtp-Source: AGHT+IHo7q5++QJUDrHr48xLTBou9FjtZUriGyQGdDK7HxS3cp+ZFWfi8cFj63qSZ6g22iL9ImkzUw==
X-Received: by 2002:a5d:5885:0:b0:3ee:15a3:7b9 with SMTP id
 ffacd0b85a97d-405ca76fe7emr1378520f8f.30.1758623994971; 
 Tue, 23 Sep 2025 03:39:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7460sm23740177f8f.31.2025.09.23.03.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:39:54 -0700 (PDT)
Message-ID: <f068ea22-9c41-4b50-98f9-5fe1a9150350@linaro.org>
Date: Tue, 23 Sep 2025 12:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/36] target/arm: Move compare_u64 to helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> We will use this function beyond kvm.c.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h |  3 +++
>   target/arm/helper.c    | 11 +++++++++++
>   target/arm/kvm.c       | 11 -----------
>   3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


