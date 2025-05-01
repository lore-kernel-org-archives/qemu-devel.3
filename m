Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A46C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWNZ-00033Y-J1; Thu, 01 May 2025 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWM0-000298-Ma
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:43 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWLy-0004KN-8m
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:01:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso1069177a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115295; x=1746720095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2B19jhquG/l85tZJsyd19Va0wUsU5mM6TUzaopAdEQ0=;
 b=VyIIGIcAqm7FVc8X0OcAKzYp77jPfzocVQ45XM629FXQ4a0hB0rM/nIU4q0JWZLAOI
 g18BlSyxd8GR/XISMDy9kgHdp1S/rUZiPzytIIMYpU43iW/MH52fGSj0ZPMKBUG1FyE7
 cB3ANKtYWcoYeXNUHXQyM4JW+YZrs3tFLQxndfTCD6ME1PyvLbdP+qYp8ghoEH2T+kyh
 LpXc/ORu0MegDLeci6PHzzBGEhzmTOEd0rHKEY4muzLhplEUfQeOFMpk2cyWuvCQFDkp
 by+QNe8CmW4Q4F2gO2G/VgxJYyqcqceskk3lB+hJ04qPJXxxmPK0xUBRVgpB7NCxBEnp
 mzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115295; x=1746720095;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2B19jhquG/l85tZJsyd19Va0wUsU5mM6TUzaopAdEQ0=;
 b=mOEJeN4umqCNZJ7zSmDvlO+u7UD+6rxSpYzVyTCOnVYm+6VOrcKJODpoaV+6IbgsPZ
 TFrW+I38rydCmX3TT3ln9M8uk6dayPquDBJ8QTp1l9E8srZ/6gMu9dje1XWL55NTYXAe
 TUI4P9lHoMHuhuo/dgO4sq3/v/9R9SiuY0y35uz/+Rb19akIG4vqE4L/2HVlkY9CW1BA
 lFLfigoY2vfnuagQM4QU301tHxB+RcEmHXxQCmEkcvO96shLCUyd1eLHZyrT9K3tPWyZ
 iAoiCDi2OJeoYYGQ0d5Hoqws5jYXnrHyco1CBV6BSk7lpYtTV4c8qxnei3tBkG4RRn1T
 IzvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00P39VFJyFBzY9+pS7Msw6toEgzbkGUAhEUUo94ar4DAqicNrkb+qV1Qr4R3YYPEm0UW0hfZqKZgH@nongnu.org
X-Gm-Message-State: AOJu0Yxxf3Ib/yN9anIa7Muhc0cCrdkLL9RswDIIgRKobftvxFlGnX8M
 vQUnqkWzTVlweOUqpoQDvAHqAwwTvuB/HmqsxLOLZStcLh1xw5AkQAbhl93ctQU=
X-Gm-Gg: ASbGncvr5vgFpjMPqUuHwMkk2urDpIWY0l7Xq7vWfKeft5IiO/H8wjdYBQdhDaoE/3H
 WM0BYYTP3w8d1CmmlF3h9vS0KB7cuLof6KAe4hxh+rid4cbyuHMT2b+gHnvrc5Yz+th5avMJI39
 7PuBAy/YkXXR9lQ5lEQX8Hw5M+vFcF8PepbC3fpzc2EIX7QhnGDtMP+dBZRj0ZK1YUQFoCiepZP
 uv4O0+kYn/A67E1qAwcaJp17CR9i+4dW6EPTBy8J3sR80OJYG432pKoeaT9ZrtDuzVphy5pLheS
 OOzOs8rRrvRHBksHiNilNZnENqG8iA5qRdEMA3S73nph5Gr7kS4xWg==
X-Google-Smtp-Source: AGHT+IHXuUWE6jbDgAvz4MUMqCOb0R8vht6MW29+SCAyST768MK6e8P4+SA9qkxkKValmS0gFRFsHw==
X-Received: by 2002:a17:90b:5704:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-30a41eb40c1mr4434244a91.30.1746115295436; 
 Thu, 01 May 2025 09:01:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc86894sm8288855ad.210.2025.05.01.09.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:01:35 -0700 (PDT)
Message-ID: <c8742f98-36a6-4da9-89c3-c866e36d0747@linaro.org>
Date: Thu, 1 May 2025 09:01:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] accel/tcg: Use vaddr for plugin_{load,store}_cb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
> Avoid the use of abi_ptr within ldst_common.c.inc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/ldst_common.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


