Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A7D0D17D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdd0B-0000RF-SU; Wed, 07 Jan 2026 18:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdd02-0000K8-Dd
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:31:36 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdczz-0005NH-WB
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:31:34 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c363eb612so1882535a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767828686; x=1768433486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=evf9bTTXGdd2qz/UiCQ9NV0HZg3XYCXf9gTN9qSrbzs=;
 b=abuK0MF9tt+gXlwWYjZz5UstMyBB9ZhOpzYwpuWVqeL3vSJD/EWbhCHrPTmn6krWzZ
 W31M3Zaj4c0BDElMTFkBlWUVrH35tDE8qS9o2OwADpEqZtNkE12SYxDkLVxutJHE2Npx
 9eBI6w3x0xTLNrjfJo36W7LE7UgRHssQSQQQaQyjQLq67GKLw7Qd/Jp43a2Ff6DQ1uqw
 cMTAbFYS4hRcGzbLb81CNiLCXSa1/LqsMqXvdtmf0//lZkfHEZKoRDjjpPz/KnBi6q54
 fpcLHf6IeJqxfOrt/kzafBLEzhApbdGA/Xmz7dGkze5dgnPgFG7O6ZPQv0TvvYtdxMb8
 gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767828686; x=1768433486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evf9bTTXGdd2qz/UiCQ9NV0HZg3XYCXf9gTN9qSrbzs=;
 b=uhYc/a6dI5u+ouux8nN5iMbN0n86gfMW6EJNSwohHyG5kjZ/jjnc+GEV2688D2AdZg
 JhkxRl8Ld+jS+DFdMQev2s+MwNGZsq7SGXtsowMZWIfP3JPf9jPhsW6CpCt6sbFc4xbv
 nX+mJ2J6vkO1xBoo8Fc8faXg5ozhyesX88uRlrBn1V1RXlOYB5dU2cQAi6/tzYqnplsi
 enkbOYgEF9OnJOi/qZK+shUFh+4cxQ30aEPFKVB936d43oYJNfBSI5hBNE9bEXn6XxS/
 2ssEDMP5aHESi59pSxSbaY2M2OxAXQ4E3wrA/XzvWC0SAYOBQ+FQyIb5EDPCV8bc6bJu
 2iMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN3u/+nj8hLacTrs/qKXfaXtBCCpLVkJJ8QJuAh76h+h+DDBt+H8WoW6FAFgB7AjF/wEZKvI5Y8+f0@nongnu.org
X-Gm-Message-State: AOJu0Yy3LKB0X79cSQa5p3l9dWEhfv0fqzKl0UVXOwrrPBb042B+FBio
 gLJp3BKs1TgcQ4ftvhj/b0MpbiAGRMASUNIM03Lt24iH5IT4fdv5GCGS+7l5HfQCvQUyy0MX2HC
 kxwaoDZA=
X-Gm-Gg: AY/fxX7N9DppThkkY1aXo1Cc64ZDrq8QMe5hZLqpcOvXxLIERaiMmaoERbceV/shJyN
 ju0bB14wzMtlgh41BPsJDLMcVG5+ku9L5OtTtLK06jMR/aOoIMv1zvagXWIOEIXLI18H2r8AMp8
 OhE3/lcsai4pGJ6hBfakjRS4FYce3+EC53wLpJrQX0cyZXY2Y+EZj8WBXFFefZ4zr8DWCbDa3O4
 xN23iK9fLDKj8gYtJe1VD4DdFWYMfMqokx7WczrNTrH5Ba1RZ6bHK7T/QN9ChjKsh0jW2t8xat3
 0O6v6MF6IDawZvng0o1ouoNt1Kic6ou5VFcTVlBayHquDq9aTFzdPZoYYdlMMAmZCJ7LgRW6yK9
 dCiNdhgAuT6PYmx8XznDFy92w1LHnjEM50ozSeQzaxFI0v+NRfNcM4ckmGqDUGWUGk7vFEV1i4B
 3m9Pra7gcq8kRlFt++gZSLw1KGahvzxw==
X-Google-Smtp-Source: AGHT+IFSYNir+lhmA2cJ5BLFoD/P/W3iGTtXZ1fsvvyVigOti/dkm6eKa6/VokN5DK0qdASKkkMmhw==
X-Received: by 2002:a17:90b:4d8d:b0:34e:63c1:4a08 with SMTP id
 98e67ed59e1d1-34f68c001bamr3628089a91.20.1767828685859; 
 Wed, 07 Jan 2026 15:31:25 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm1348596a91.0.2026.01.07.15.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:31:25 -0800 (PST)
Message-ID: <d72d606b-eaa3-4d59-b776-8a589c8f829d@linaro.org>
Date: Thu, 8 Jan 2026 10:31:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/i386/tcg: do not mark all SSE instructions as
 unaligned
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107151400.273916-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/8/26 02:13, Paolo Bonzini wrote:
> If the vex_special field was not initialized, it was considered to be
> X86_VEX_SSEUnaligned (whose value was zero).  Add a new value to
> fix that.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  2 ++
>   target/i386/tcg/decode-new.c.inc | 11 +++++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

