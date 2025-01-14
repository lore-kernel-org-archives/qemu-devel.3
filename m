Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkGY-0003ys-36; Tue, 14 Jan 2025 11:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkGV-0003yZ-3l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:59:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkGT-0002AK-M7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:59:42 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38634c35129so4031956f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873979; x=1737478779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rGzuEPmeys8Mfel+w+2ifbAOgt1iOWNRPsXUdcmfb2E=;
 b=NCfgdHycRiA8zb4KP+8ektNRGiLV0/Q5JbLM0lWu5wPm1vNDqhdoNyjTe5LW5sOZ5b
 gUW2zRKOqUXn+FF/4Fi1CN76MlNIwc1c7dkjaAH4W4eWc3c3r5bUlEK28oBfJ9gP3UUV
 /BgxlyS4H6Slopb+KgTF2GRSvVLpHS7I3eRakk+Wno+6ClzERWvWndKEHrGcIlA07skf
 7/XqOPCeVxkSgUwjwHU05IZIUT6oiYV9tRQO6p75Wic1cuSUEcOGwkB/xOozb2YrcNqt
 eHWvjtp1Xu/oy/ar6cgwjhS/zbyy7Vis1kDl90oWhtzyMslMe284AozYIlpHzVuMVK16
 2cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873979; x=1737478779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGzuEPmeys8Mfel+w+2ifbAOgt1iOWNRPsXUdcmfb2E=;
 b=DDwiUUZUzgdqgrRXP5BrqluFZQbM58jPaF0pcCQUsDOgQihduRZp+VZscNrOiVomaJ
 qjB1OvzNBxA6TO7MtIFc5BuX7eTaS/YN6CDoIpOp369CceROgWHZILnHq+eO7+RYJfeC
 yFuXZ0JpSRsDGE/s1Dc/3qPiN4Nbrfzw85BGHkfnzDyzwvpbA6SsYkbRHGNkZM2UN5ca
 HBi7BqQ04CTZ0Rerzm223Fjhqt9gKDMr3UDDEmnKOvR5YUptDnHLipZEhSZCkhXIiKPF
 Ac8VkeFWWKxtekei5CVhEAVbwU85X9ZPuBy8dw8OmzEzoyLsdpVSdgAkDtnnnDiPT8kG
 7/Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJHdkZcZhBto0liTxTV/yGQThcne+v1nRz/00y1TUIyRKmRWN6m98GvJGBsarkij/qAHpEhCigxQyo@nongnu.org
X-Gm-Message-State: AOJu0YztR0YwK7NhRueFSW2VjwJmNMKrWFBvSIMFAFa8yfCHLdL6FgqV
 NpAuKLWIc57lI31mSqQkhvC1i9xkXDUWXUGCjzMoxtOxLGopg0E5Vra9ifD5QnY=
X-Gm-Gg: ASbGncvlokev0UDjL9pEK3HoW2fzWIYAf6MythY1ZCKTrnfawarzn4T1nKjmGNC6pJN
 +s6fEIn9v5H6dNnXoEqP/4x9DdiQsgDzMM8VXroE6L30+BFZ6cpwgCsLR49Hee87sptitsg1sDK
 xIIyjLRvSuDSc/5MfoIt7jp8qnm1OHEB6C9lceswYfJPHiMgx0O2ASkmGywlTDK3s6ftKOv3IE5
 Op/Mo25wg4uCDcKxg+8xlsWrIDI6VRf0D/sZamj1AAw+/i4QrIy1r1qBm8RnU4sJIFvP3/mPBEi
 22lPzldQNAupGlYPrP4wS6Ya
X-Google-Smtp-Source: AGHT+IGAZHH2ss4uOksdS6UgLxYE18NAuWPbPG25R6D1Bfq/T4mCb8cfGMdtyHqij+1S1LvX4OaYuQ==
X-Received: by 2002:a05:6000:1f8f:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-38a872fc43cmr21032644f8f.9.1736873978650; 
 Tue, 14 Jan 2025 08:59:38 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c1664e8dsm17938075e9.1.2025.01.14.08.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:59:38 -0800 (PST)
Message-ID: <a3c501f2-ebcc-47ee-8f9e-fc9434cff189@linaro.org>
Date: Tue, 14 Jan 2025 17:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/81] tcg: Add type and flags arguments to
 tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  7 ++++++-
>   tcg/tcg.c         | 11 +++++++----
>   2 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


