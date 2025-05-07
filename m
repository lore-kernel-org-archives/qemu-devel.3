Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2B9C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCmFe-0004Xl-4D; Wed, 07 May 2025 17:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCmFd-0004XU-42
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:24:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCmFa-0007rO-Np
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:24:24 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1fde81de05so135783a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746653060; x=1747257860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9wSbNtcYIATn3/CCIOmNLAP+ZutI6QPzA05RlF2E58=;
 b=eInO1H8xZjbC9ju+Ljdb8gD+yR735FAOGwbB0CIqJQd9C96riOwwJH5jj1wFOIpEj8
 mRbqg/mFTQzxJrPYuJm8JdrLiP70s8nawwA6k83nOztS20pf8IAlYhK+yWfkdAN4n2gL
 PZ0uS2m3e+qqImWGq66w/HvUqadZHKSweMaculYEiZDOd24F/3zN/eru8z45cse7u4if
 MQDNE/uEKGY2kXfR1FaCKvZTczvdafGp/URrsSSFZwnOqfTImb+XX23IQBTUZliiy+L/
 gTPgQRmU0wCoXw365FZ3pi15KdW+DP/SBbs1M+lpzv25Ih816baAqhwRGOqqTMoHcfnY
 b9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746653060; x=1747257860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9wSbNtcYIATn3/CCIOmNLAP+ZutI6QPzA05RlF2E58=;
 b=PndKvEtDoBCk28cYUevrhgxHWHt/mcXEQx2An9N5ZWa5zwDEuOH3uOk+i73/IoipOw
 maGlhSk8xBZXML07ghtxImxXlRXAlYNhAb+hrfCENFcaGOLsEV5tqsvscs8GRRZLuwq4
 A8KB+TYZnGSM9IxB00PmsI1slbZH68OUIir6r/JFZZxS3VsMcWeVD0Sxgx0am+2D9ZYA
 5G/MOGNiFRWpB3orDaN70PewvtnoHrkwb+uZMQ/0bE2WgBSFNaC+yEgMVtEdeegr4sd1
 InkUyFnCUHYZfFltSxdUsbXnnAV2mRl/fvjgjwloPjnZz5ks/QM23nvhF/u5ULqWdUnP
 z5ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wTXWqbtn8ljcbsmLxSJ8jaLorRJN/tHEre4WmkZOIBpsZUSpnnP73i/FY3YhQSRGeyu8jZfqC+/W@nongnu.org
X-Gm-Message-State: AOJu0YwPIaMxtX3KVs1yVu7u0leFLIj3KXn5zeF2BmufPgdclLBBbU2T
 d6GaeZ8cc0SkqgQwRzd/GYM6VexM5n01zjyHaATzgYeZj4N8oK5QtdhSUa/Zy3c=
X-Gm-Gg: ASbGnctblnn65X2pTrK2RrlHhbnudp4WqBWPjIsd/s7cqfbmrNWYs2yVewCj5NOlV5p
 vDrw/eotFY4Z5asbNj5Jaylq2uaN0eNXYUwJrdStjmfqmA7COJd+izijGYiB2dopjqyEWR86QbQ
 T9NaL5SJg1G8udaU791jKUZWeD2eZ+wUYOwtHhbLhE0RTRAMI+/pjW94kYMGWfswxeZrYWy9E2I
 mQfWhG10Dfrpe7FON/JMcHBpvcXbbim95po+JwlLXXoHNr4cwdRBDHiOZmWGBwOx168dn3wTdgd
 eNNTn4awH0fOpHBosGeuITqLeUk4XOtlv0PPM/s0qtE8GPRSOrQcJa7HBSf1/Tcb/S9SlDGjDTE
 ifVbpNT2O
X-Google-Smtp-Source: AGHT+IG9OQYyismC+aPpyYezSYCrHN9IBBy4qVV/tHH2qSvwJsqlgCVSU/dfUo7PBK9S+6t5GbFuAg==
X-Received: by 2002:a17:90b:4c4f:b0:30a:3dde:6af4 with SMTP id
 98e67ed59e1d1-30aac29c154mr6321209a91.31.1746653060386; 
 Wed, 07 May 2025 14:24:20 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4ffb545sm781114a91.45.2025.05.07.14.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 14:24:19 -0700 (PDT)
Message-ID: <e91774b1-b950-4930-9b85-1fe52b1b6cd8@linaro.org>
Date: Wed, 7 May 2025 23:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Fix typo in comment
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com
References: <20250507204626.139507-1-gustavo.romero@linaro.org>
 <20250507204626.139507-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507204626.139507-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x529.google.com
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

On 7/5/25 22:46, Gustavo Romero wrote:
> Fix the duplicate "of" preposition in a comment.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>   linux-user/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


