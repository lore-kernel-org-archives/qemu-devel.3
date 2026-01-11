Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9672CD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej31-0003ks-7u; Sat, 10 Jan 2026 19:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej2w-0003iY-FK
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:08 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej2q-0008Lk-1n
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:01 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso3068604a91.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090259; x=1768695059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=exXfKsggPPWs6i4ttu61+wjht3D7pjGjN4PpFY8WEXw=;
 b=kQAHPuagRmVeRrH01G2QF5IL2XeCYMetI+bX5Wfus29+uLupyZ9pOU4dZh7vWQD1wR
 zohVT+IXI+GJsFto3Ip3oaUZZ8HDky4JO8GA1rmH3S4DSg8xw8VXEOCGIQ3EJLLL1vQs
 lqmhpUxd7mNE9HqFY7uR1lqkLNWaa3ajN53ngmRN1b2NhD6LLNq7Q7Ep+pUL4eRdoS1M
 sfJjKkP6Lcco02wzSmiNGt1j5Tn21f8ag5unx6nTnrHeXa+gEzQZdVyx8qeQ8uEOZKH4
 teEOiYYS4ByOD4cdPNX+sWrspJllqObt7uc3x4RoFw/kGZ8tALE+PcqYNFQ1lnqz4Uiq
 Z65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090259; x=1768695059;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=exXfKsggPPWs6i4ttu61+wjht3D7pjGjN4PpFY8WEXw=;
 b=J7aQxESCx0I7XPJI85PVTEmhDdRfkTRljQJkBY8qW5qyWtHtJUngj1o+Au9M0tLWZ0
 sqlk1cDuQa4JoyCF+5xlH1yydTcLCc8ChLsTZd6roPAnJkSiAwkNJxeBvamIKME3sSiQ
 vVLdCGofVHATtUlqI7iFkIN6Ye71Xi4FSQdNg+kMDFAS9BD7YTF1j+VjJx/TNr+m1Si1
 jfI5RQJnpEnaivaJsY27m+Sz+SG2BGaAjHzRDBx/vqoH3yOPeChBvrjCrhlZkYaMJArT
 lGIWdGOFCc4Rd0doRqBagwwI5ZO63XWjWnC8ieIPs0Q0qERAvxEFJiB7BrQhffXav9e4
 DwkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW94uNz/kuuB7Arfdl5jEv/hCw451N+waX9D3ZKGGW6/wfVRBtblGYuH/2ZBHR6xUutudLuNzysQGyC@nongnu.org
X-Gm-Message-State: AOJu0YxgeZUUYmtBxgd+dI6Nsy2VOnyh6jW7cEhX7Z+nw4yUsHlZEvua
 z+dBUpfhkHff52HS90EXVUyPQ/K1SxPbl1Ota/GhXMgWpbOwc/A4HtJCdabNOIQz8aY=
X-Gm-Gg: AY/fxX5DK8tkV2V8se2vO3tk+QCJMyP38mNHV7bYbYOp0tlZNhEAGCps852VUdYI557
 mpRcC4Ry+TGrezm9VhEE8OW29SesiUSAahZxV1MDOdr2cGrJ1Zt/on7Y8o1JUbgQW1duvGjQ4/0
 yrY6ZC2sBZeEqBMVfpHMd/pVph8Dogj0nXneiedBeDsdaSTWU+cKgx+E9iRRRSItDk1WpU686m1
 wZkdC8f8Qxy9HYKdep8uGuhidRgR70+r3Ldq5Nlol51RKLJLzy4Lw4ETghd77lyIAFYpupWbMMI
 B5ohDeM4Gnt8z/e8SNg6mmT2foeTvoQZoUx3g7xHFIm3iUj3a7WIOLTdvYZjyV/U/4zuAUHd1KQ
 xs5teFS3m+kW7LFKv9J622VEFGOwoY9MC1Roel89RfnSQ799YaseoGjWMF+3R3FkhfwToL+3JrT
 WnAUCtUIypp+lqBO0O5Ul6szi+qQ==
X-Google-Smtp-Source: AGHT+IEM9h2kw74bJD19ALsxcsi79060eoX1bG5H51QnTvnpvRWVQJNtqSwrLGnm7LpZWKM8fKESHA==
X-Received: by 2002:a17:90b:5786:b0:34a:47d0:9a82 with SMTP id
 98e67ed59e1d1-34f68ca474cmr14584221a91.23.1768090258616; 
 Sat, 10 Jan 2026 16:10:58 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa78f71sm13624737a91.1.2026.01.10.16.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:10:58 -0800 (PST)
Message-ID: <1a8dc275-f86c-429e-8dcd-33d39b95e7df@linaro.org>
Date: Sun, 11 Jan 2026 11:10:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/openrisc: Build system units in common source
 set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> Since previous 2 commits and range 2795bc52af4..5b67dbf1dc3 we
> remove all uses of the target_ulong type in target/rx/. Use the
> meson target_common_system_arch[] source set to prevent further
> uses of target-specific types.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

