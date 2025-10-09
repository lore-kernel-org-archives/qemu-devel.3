Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBCCCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wv9-0000NK-Bg; Thu, 09 Oct 2025 16:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6wv7-0000NB-EB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:07:25 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6wv4-00065C-TR
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:07:24 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-330631e534eso1579600a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760040440; x=1760645240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfRFv3NWczBeWgLVV/UAE4Ev6bIX1V5WX9MAku99Hkg=;
 b=fO2SNRAQpvJ1H8HE9KA1RILM5Gmne7Gn0PENh5mF3ekaWAS7FRPUqtCOWIkJPJ8eJN
 i8LcJoKDJKM5roLkm46aiXmcNN3c6Ln0s41pm+pu/znBSdCoCCjxiHxqEZmqSWL5wq9B
 qFOAy8ql5jUH4wlOFOaM96+Ex2CPg3ov7Xs1qUXXtTk275v8xVhuuPe2LoUgjTq0n/J3
 ApyTdZWuh+CaW3T8UFRIlUFcqNp2hRPhG6vR7Zwb2p2gLWRJVboRxgkjkNQoGyff8tO8
 7AcVYapItgu//IpkWLibreIgV+GHppMzgT6yH5IcO0yfO/V9pXgGpDlT8jjMMIHhUAr0
 228A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760040440; x=1760645240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qfRFv3NWczBeWgLVV/UAE4Ev6bIX1V5WX9MAku99Hkg=;
 b=oXpl7xwV4OtysYAdclpnqbaYkRoXU9H9UkERnC+h4WnGvNQIFhHbsQ4lQXUD4SYL5K
 Nvfap28rptlB4/5Z4FTJbE69/CLNaiwuSZ+QULb13hYyVV0pp05aeeHGJZ6xMI8WATlm
 cpWaY61fnUTy+eNZA7RrZPMN9QIH9dLTgKXwwQ+0taUusFZHQqQ3l3+2NYZ/v73vIW3X
 6HqHUa37YZqQLSQYEC8emHz8zw90jMTtC0LJaH+lLHVu3ss87vsf0phuNZdtu6fCpCcA
 azz26AAaaE+3G044sY50g6AY8U8SqbcrIKLQ04w9yEVM09KNzUFi0c7xOtXKxm4MXcbk
 eTpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjVZmewzaM3NVpMeUWd8KpigY6oP5z4G/kCDBr463mXXuUf70Lv+33+NpmySNUGhePgSz0AeiCS0XA@nongnu.org
X-Gm-Message-State: AOJu0YwM6vgB6AAPFBhr86Dj3fqnsqgAcEkpPwk7cF/1sXLi3PDMwsr+
 Lh/yHOO3DyU3abjYF8GRNyb0W9cDelTaqkUOP2xd/g6luyWzPXXfbDrdQKtHMbwRrO8=
X-Gm-Gg: ASbGncuiJD7uHl7uiZFVg34b8I3zmLFgXMIWhw96orPkx+8f5VrXtszqC0MpEcf7CxP
 Hd4HOahOb9gwCo9jYyEuFk6ttYEL1KeDV79Rr5730keWuQp820IS320oM15DheF44UOIc+2nsSg
 n3+sCdthW8dJo3dOgbcmH7L692HGZDWhi8IslGnPAgmh/kV7hAF2Nr1cFC4nhf0iwPjIlIJDQHy
 Snf8D2elICb3tkQ5aL83EFmbRm/C2kDk//u6putkVdYZdJz6sU+zSoSIA5/BIYtiCSaqtZjWnDB
 KERF9t1c7MJYmwduPzygv9hxoaF9GFvLr7ee1P9xT0rOJIByqN460UXhdUhqW/cM1rsrH0kTFe4
 c9XxiW8NCyEvNODTDaY77N2woF1YZOUy8+pv3Fd588tf2dp1c7rp87tol6eTZhTIa
X-Google-Smtp-Source: AGHT+IEAzfZC++2qnPjm5Zp09rWNedZb1rOeqcqQRvku3ofouShUA1jeBOUhakV2kpTiP+EyYCPECA==
X-Received: by 2002:a17:90b:3844:b0:32e:d649:f98c with SMTP id
 98e67ed59e1d1-33b510f8fc3mr11409334a91.1.1760040439521; 
 Thu, 09 Oct 2025 13:07:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626bb49esm391811a91.12.2025.10.09.13.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 13:07:19 -0700 (PDT)
Message-ID: <aee36f07-1ea5-4364-bde7-1ebcc482ced5@linaro.org>
Date: Thu, 9 Oct 2025 13:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hexagon: Fixes to sigcontext
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 10/9/25 12:59, Brian Cain wrote:
> Revised from the original series at
> https://lore.kernel.org/qemu-devel/20251008014754.3565553-1-brian.cain@oss.qualcomm.com/
> 
> Brian Cain (4):
>    linux-user/hexagon: Fix sigcontext
>    linux-user/hexagon: use abi_ulong
>    linux-user/hexagon: Use an array for GPRs
>    tests/tcg/hexagon: Add cs{0,1} coverage
> 
>   linux-user/hexagon/signal.c        | 184 +++++++++++------------------
>   tests/tcg/hexagon/signal_context.c |  22 +++-
>   2 files changed, 91 insertions(+), 115 deletions(-)
> 
> --
> 2.34.1
> 

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

