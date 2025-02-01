Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF81C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 07:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te7zv-000627-4R; Sat, 01 Feb 2025 02:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7zt-00061k-2A
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:32:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7zr-0002Aq-Gi
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:32:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so31991125e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 23:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738395174; x=1738999974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eAv2b0Ml9xVUwhy51rqf3bFg1hU8g4MiaooScBWE6KM=;
 b=OSMqtMqkTVniJ3ixmmIcHli2pkUcUkJV5ocm9eW71oBxIoeMjzWcXQuVy8u0m0nWYn
 xjQOgGN7kLymRe2VRPDVpvueKVgQtwd9wCVnKhIVsVF9jHfUnkNeuDtwsP8bMFC9rsSd
 lZlsUblNhrnF5tt4Dfa8UkTXgF/9jBudkHPPFZeQDDd4YBUQ54n1bneVa3aSlPFQGiPe
 mXtXlw10yy6gsavkANKrVYejJfB7+kbQPmUlkBgYu0+MLHr+hG/uw6OxQNCqXKlA7733
 8L7nSydAAqu0olZa3S+Wlo4Q0/ccagWj/saIXpyVLKhXg3+GXGmGwtx2iKZZoYHeUaQT
 ifiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738395174; x=1738999974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAv2b0Ml9xVUwhy51rqf3bFg1hU8g4MiaooScBWE6KM=;
 b=r+tFK4/McHCKX4D/FMeti67KtLFGOuIbjsO2B4JJsXG6uPdyboTDZnwoQAPnx/bHVw
 4gG1A34PXMzFAzYVVQcunfvzEV7nPm979cOg28UvvHyYlQvw4IgjRAq9cp34hut67bZt
 84TignycsPd5/Nr0HlXdwF2Oq8YTZjCTdzXpAIPQ3qI7hMiZtidMGzX4g1VKbVEn2dly
 SsJd7PoPQjs8Jn5m4RIXOP/+ni1NKruIMis1a/vTi/EuZ9O+ekPNiacCrk7wAKz3DjEm
 HOZze8Nm6nGSbYq/058iIOWkYRC+ZJMLggh1J59Qf50sYo5MyLyxQuBnCAxDSdpbV/Q2
 a+MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwxg9B6Ah6s5iCHyokVZKWhLiCc7stkGTIwy6C0zxFIqZr+f3Xtjak82l4dKZUR3dx9wpEiq9xOotr@nongnu.org
X-Gm-Message-State: AOJu0YxC66dvrd3giEPhk98JhUElR9ZPQ8X60SZkuHOgEvUi8HCHTIdX
 mPkb1lu0VMP7tVAU/lGKKWXlRMwKi74seS6p1rOayUVH75aTRbJNu5aqa3As04s=
X-Gm-Gg: ASbGncucGO/3l7qf6vPIs5pZmHIyqFAibB23Z5P6bH212hmPcTDiMpgD4Hm434EZLYD
 tiX7tDBckK3ps+gxrnNCY/FlNODrFmojE88BcpR5XIjlMaOOyGpQCkyBs0TZAv5Z1A4FOqKPEvQ
 oxX3UNU+uD2cl9paO4LIKV6v4eny2m6JGttnWu7LnGHLKZEt6WcXJbud1OQI994rMAkXPVCBGhb
 AfZpWNTcLP7WXqIJiKY17vYMiMR7TdyDJV/mybcXSaf3WODlKhjV5v3aPfsRDd3y641+hh27D+2
 k6/9grkX2NEsc0rujb2pwUW4ON/c
X-Google-Smtp-Source: AGHT+IG+GT+3AH8S+vWN/U48AHjJgorm+2y8xgxW5i+RWXc0ScFg00isLDmQAK4VwDpZQhWvRVCMiQ==
X-Received: by 2002:a05:600c:5486:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-438dc40d3fdmr133383545e9.21.1738395174030; 
 Fri, 31 Jan 2025 23:32:54 -0800 (PST)
Received: from [10.1.1.154] ([45.93.146.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec7f1sm6499911f8f.9.2025.01.31.23.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 23:32:53 -0800 (PST)
Message-ID: <828d1c4e-2271-4c3b-823e-df73053a91b3@linaro.org>
Date: Sat, 1 Feb 2025 08:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to
 CP_ACCESS_UNDEFINED
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-14-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130182309.717346-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/1/25 19:23, Peter Maydell wrote:
> CP_ACCESS_TRAP_UNCATEGORIZED is technically an accurate description
> of what this return value from a cpreg accessfn does, but it's liable
> to confusion because it doesn't match how the Arm ARM pseudocode
> indicates this case. What it does is an EXCP_UDEF with a zero
> ("uncategorized") syndrome value, which is what an UNDEFINED instruction
> does. The pseudocode uses "UNDEFINED" to show this; rename our
> constant to CP_ACCESS_UNDEFINED to make the parallel clearer.
> 
> Commit created with
> sed -i -e 's/CP_ACCESS_TRAP_UNCATEGORIZED/CP_ACCESS_UNDEFINED/' $(git grep -l CP_ACCESS_TRAP_UNCATEGORIZED)
> 
> plus manual editing of the comment.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  5 +++--
>   target/arm/helper.c        | 30 +++++++++++++++---------------
>   target/arm/tcg/op_helper.c |  6 +++---
>   3 files changed, 21 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


