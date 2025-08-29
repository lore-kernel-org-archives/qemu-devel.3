Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D45CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNio-0004jZ-DF; Sat, 30 Aug 2025 11:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7OP-000099-GT
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:16:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ON-0000jQ-N0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:16:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso2301856b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756505777; x=1757110577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgjK+o9o2OLJsBDAjXnB16iUe+9ELWHiBaAPDWPOFzc=;
 b=MBhgM3qqqtkdkeKy05XEPHPsS/EvS0+9cv/+GiiZJcloog6RiPXXp6JMyBrQ+wAF/a
 803vol7o9RbN9+UPR43s516p7M7oq4tvBoO/ZK7jOmhFr+NkIMB8Sx7HeOucjFUlarz/
 8QAbICGUKHpbCcBFzjyDqKhsmAnt4mRY2SONdMnRPdvyEbLS1vexRbMT/KNTZeLNvpVD
 0r3AKmji5UlszBg1vvxjA5vkQbIbkCaxdZUJ8I7ZdgrXT3uXwnXs4Suk4fMQrmQsbP9L
 QSpQfc/mLR+9ygxFPbo1GCl0zmlHNpNKtuIKM0SJXN8Zncqd0lzIwJLC0aP9+AB5WlGN
 41dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756505777; x=1757110577;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgjK+o9o2OLJsBDAjXnB16iUe+9ELWHiBaAPDWPOFzc=;
 b=C87CaO+Reioxn56MzR/stPRBqlE/LN0wM6qEqyDnIyKp69W+XAWLHns2FczordCBCa
 hgYPtANE+4Aqb7DbzjyN7QnVzySqCl5d3kBxYCLStMVYY4E9/TQsQL7ilp791O4XXSqs
 O7tN0MwiKkF08P6TakwO8j7pavIIp2Q8KuRG3kzd7Zr3DcnqguXXAArQogowD4ZrgXmv
 jb/RCcCezOmJtXTsGxLBeIadiAthSEnqetghaX4nahrIclWx9Q/12CTmhp1pBVN0UydG
 +Zqmksp2BBX8yJa9wQJ8Q+/+E58nHEz88hc+9AZAs7WUEGZzotlfifXOwLjTRsFZw4Tj
 E4vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0POgLe9f+Tk6gTEbFCD2JXCNhB0RONQs35OssaqNi/Zk1/ywDO1NBCe4rCFVuf4ldVnMsZy9ZYvZu@nongnu.org
X-Gm-Message-State: AOJu0Yy452KRexYiFIu57TS7IW2701rzEz0/0hqiSHx2z2RT2fjXnO4T
 V7bKyS9EW3x7D9Z8cJ8yo9jHscKHfRcy8nDt1w1XYDoLRfb8oDZgVs5vNtXz6+ycYMw=
X-Gm-Gg: ASbGnctUWdgcQskd4LhSdum73iqfZlqoHpkiA+Hx9pIUuBEMCEAZBC/bmjTP0jTv357
 3p98sF4K+HxN4TXoMfk740kGt/eyaFt/UQYy2EzIKXuY1RtwnjX7n0kc746ziO0d1mlHlIpfE4A
 ZsV1lljLqcok6lwCnBqLoLYRqlfrb1uZQrwQmtindkh6PMjQwCxsnzK1jlt1FjtE5TrfGFSXFdE
 6x2+5KdcK9WSnm7WeoPqnjA+aHMJCGAMVf4BsVG+EBEMaGFDxt/GPz/tohJbLWsZ//+CuhKSSa/
 hEO5iikR5rnHyPv6WoZARZCAhBUvqo26GK0/A2nT1aBmRHIkJiMGOc8Cw1VQbWwjd4Tt2PZdb1E
 mKy9lAfaXq6Po4JuLIBo1evhaz7EmKSxKO9oPMbUMEbK2FfweliLwDjSocHEa3NqHLAF5Eg==
X-Google-Smtp-Source: AGHT+IEx97hDOFVfLhGuXY+x7DMdmsDPVxJKpggcXmMyk5S8Z9WmHDBWFwgGthugmzj+UoEU7sKdpg==
X-Received: by 2002:a17:902:dacd:b0:248:e3bd:3393 with SMTP id
 d9443c01a7336-249446d2ea9mr3342615ad.0.1756505776943; 
 Fri, 29 Aug 2025 15:16:16 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249037285b9sm35224535ad.44.2025.08.29.15.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 15:16:16 -0700 (PDT)
Message-ID: <7deb3e06-96a6-4ad8-ac51-6387b5f51ccf@linaro.org>
Date: Sat, 30 Aug 2025 08:16:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] accel: make all calls to qemu_wait_io_event look
 the same
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-13-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> There is no reason for some accelerators to use qemu_wait_io_event_common
> (which is separated from qemu_wait_io_event() specifically for round
> robin).  They can also check for events directly on the first pass through
> the loop, instead of setting cpu->exit_request to true.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/dummy-cpus.c                |  2 +-
>   accel/hvf/hvf-accel-ops.c         |  2 +-
>   accel/kvm/kvm-accel-ops.c         |  3 ++-
>   accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
>   accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
>   target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>   target/i386/whpx/whpx-accel-ops.c |  6 ++---
>   7 files changed, 30 insertions(+), 39 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


To-do for myself: It appears as if we can reduce the number of checks for cpu == NULL in 
the rr loop by moving the cpu=first_cpu assignment to the right place.


r~

