Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9161C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ehf-0006RC-EM; Fri, 11 Apr 2025 09:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3EhV-0006Py-Mb
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:45:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3EhT-0002Zy-SU
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:45:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso18073135e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744379142; x=1744983942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iFE6na5+1WuN0sT4F1WllP0/etgKAUZ6MGWqK/HtPuA=;
 b=fOemuSMvU56GLLDsu/ShSlxpSShbVEOfMHI9/AzYrCmK41ed4Ao5dVEzSLruDqLYSO
 BPE9Qecj6tFZhgN388c/sm6n0gQ7ESKrmdSNCPDrx+e87RHoolNZBQwTF+SCa+wj8iOt
 L7cT+Hm4a58NAud9WWhviv0cQrkJp3Mq79VE+DNFUGDhpiehx7voVwrvk0vpE+UEpJfA
 4L9eK9q8oseOyCJ0GvYNnwQGHecNCtpK4kOLa9bDJDbRli1fRIZC2pG0fEoC6yBv/jM/
 y58Y2oWtz8MY4H2aBYpJUAwMweHa3bHrU7ndbLR6oiPdR+AO58CI1R5Xl7NRyWUMCqfK
 mOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379142; x=1744983942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iFE6na5+1WuN0sT4F1WllP0/etgKAUZ6MGWqK/HtPuA=;
 b=gHavh4Lwl+BMFEqhlPBK2kSlg8b2x0yNqe9L5WAqppqL+cuUc4A8qQxiRaGs8RJerp
 jfl6U0Ybzp9kiqIhYLSLpWLRu5/ka5PqBomA/ykaB7xMihnyUVwbkDPuzdSdJgDlMpmn
 dAUM3v7NJLu5+xp2uBJkKboEMI5tPqDSQDZ1srM7idW3gddOTR9MBP7LYhLcFVjntDCj
 Xm5ZG6uUP8VxW3GHD6rxWTRQ9IIagGRx7BcyqKFYKaDTYGg0XBBEM876AuKuffQ/0DKs
 S1JeR2VVfmdl4ZUbdAmtttRzrld2k4x68nvvUkwp4eY26D4mWASK6NfdAsWD5valFf/V
 4wHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkhszsl+JMMERzwtyDpkvo3EHaPkhWrSvMy1fI6Fs84/ANv+SGytJryt2X5HHm7+IUnbBAXqhvJ+6R@nongnu.org
X-Gm-Message-State: AOJu0YxLUwHRDIWbnW7KA5A2mBxegc6vsETv78ye8tL0wxBd/l+3kHPd
 1YB0K9mR3RosKsVmmAQjJdSZedk4Y8G7e/0AFVjJZtJmStZ3BJbjaQWeT+4WoSE=
X-Gm-Gg: ASbGncsFipJnxWHpCUUBalXg64g7bSoeTt+1enHYm+rkdMNRhMoDXMZeNT8Xpqr1v1+
 5Gclpn2XP4h6Ioz0pQSdXDw381vTDHHymXf0tCTpxlXaWvX7hX2gMTIwFnnv5EHZtSRDyJjYxCr
 N/MbvNV/kgMS1H9vYMFrJ6KewZ3xF9IULui2v3tAWRpIexP2ezJWDh13ntVePwZuBwq5eLO+ZKO
 G0HtsFoxiUoar8rxlQE9y26IJmOwv2T+A0BINm/I4mGgHGVVm7ujWneGLenW6MpUnK0zUKrkoHk
 z6sD7aaYQ6QfXaI4f4AGCqIL9OTybTDRLz6PEhYzBgyMcHrGoXMOgkskVYOfahUBym8ia1gwTW6
 VeEUnB7NJOm+UTQ==
X-Google-Smtp-Source: AGHT+IEJV17QnlYb07AiVSR7htKmERFpL27QZ5VyO22hZJpP3t7zPW5QsahOya7LY+qLX8hVL8HGAw==
X-Received: by 2002:a05:600c:5008:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-43f3a9aa623mr23921805e9.23.1744379141939; 
 Fri, 11 Apr 2025 06:45:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a273fsm83125745e9.9.2025.04.11.06.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:45:41 -0700 (PDT)
Message-ID: <fcc6f187-5030-4fa6-8c2a-12382b91276e@linaro.org>
Date: Fri, 11 Apr 2025 15:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/arm/ptw: extract arm_cpu_get_phys_page
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 qemu-arm@nongnu.org, Yannis Bolliger <yannis.bolliger@protonmail.com>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
 <20250410210022.809905-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410210022.809905-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/4/25 23:00, Pierrick Bouvier wrote:
> Allow to call that function easily several times in next commit.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


