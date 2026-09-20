Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32578C982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 21:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PZL-0005K3-2n; Sun, 20 Sep 2026 17:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PZ2-0005EF-IH
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:59:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PZ0-0000ZK-7z
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 17:59:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2dd68a16955so31439055ad.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789941547; x=1790546347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yx190G5OF/lvBL85Vt02/RyLAymqycb0lySppG1oMPI=;
 b=GIpEXQQ4t24AczWL4wXZ0QzhrBscHYJIhCD4XYuhNZ6RIhtpQH9EOiO8U72lL4z5sy
 gKSUWPXLEb6Denpr4e2H2qu2tU/0RlBAhI4/uRNkhoulSK/YJ1SqF380s3TGhs/VtY6a
 tZiD+DpsxB2MjBJ9EvfOP0jx513RxGb7vlWfUjMLbde13no6B+YxnoHLAqZEGzYMIDyw
 MJYTXg/bV1AEjrQOBpOwvk38SmMlR/GN2qm8tVJ6lPjR6oHVxt4U9/YQCEuF5uhLa7f8
 aJ6hsWFq9ak/TViK4UVvzyP8ABc0hnNbWCGTQf2XmZLpJ9Wg22JKwIzQ5BS6PjT+QtVd
 JHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789941547; x=1790546347;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yx190G5OF/lvBL85Vt02/RyLAymqycb0lySppG1oMPI=;
 b=1MYFnwVR8zw8SHEp7fcVyQ8C8CSU5kmpezUIHPgys0YUQ3exm5a0CvLCAX9UCXX7cS
 CR+A3+ghqx+0v/GRzlLOKQsXhradljBPHPZ9YqJVlGDy3qK061URyLdGU1bgtZ5Xm+6n
 1/wD4i1X7F+TFvZH2KucLYRUhXcV3lqT1bKo6FapFlyycLNYjjJGtD7x2kKQX6BAwxJS
 gxAY7QWO5ucnB36F4N0BGlFxg9vY0u8NqfVER4B2Eco+QPAxeoUwW6zBL65ZU45BbxGA
 jgMV5EhEk1g8jVeV3r8J34m1euy6+OZZbxVy/ClSnzxx6dUoLWg3UNP7NTz+9kzs87tj
 qx1w==
X-Forwarded-Encrypted: i=1;
 AKwUvByTdJkph/yWHBpqV6hiFKEvYRn7g4ATdRMVPGvqzQ5rPSlh1tZ5xQBbP/iqk2Ufjmt6MXtMwQ17vjis@nongnu.org
X-Gm-Message-State: AFuF++mcDK+VTIx3hgOYzYuGrNyd9g1VRMxz1rJymwiw43FGKduBIrQr
 fUjbGUldWp7v5zx/m0xQevhPLf4xYVAKo3fqh4nS0vTq+t/mkkJ9JsItreb1bcZ0Kjc=
X-Gm-Gg: AYBFou0+fVbV7DXzNZY1rfhOPHCl1RW/xjQ+KFbuu2Imaf5DnBK23ei0KGUg7QWFc0J
 7eBSBiuSXTK41JMbqojnPukpQ+XuMTth5+C5DJvqs286zhilAZr42KWHkpCLtvGQifBSkDoc/3f
 TfyxKpGIotexzdA8Nh65RZplZzc+y4gxJBKIzHSV2z+CkiVSzp3XswLoquyIaOmH/VjZ1jrrF91
 n9EIuhVMbwsBF5nE5mtuk9CIlY45Rro5UcYSvcEJO1/DvhMNcZpUZ7r5yx1XV3gJqpXhCpTAYRc
 JTtfaO9Q0Q2760dWEVsJaV09HzbYweOqBWOSqWa1RxUrg7Eho2I6POYic5QMFzckAwjLbMzXRnc
 f6LCwqPdVAU9TWY22bjdXzG1cGT96mtW9anEeMxRYlosVPnk6FWNvxxj2xsiFWowFCgXGVHNyUP
 jY244UYo2HdFXIRjU6aOKrc+4++8t+h1nylk1gnjtJQ5KZM3S5ZRaMG31tK/ihfRpaof4r9MT/M
 T4aXbJJhSSWsMruTfIS18SGD3q1DljwolkSGyIpipQIDNfoehDHYSwXGW1FdA==
X-Received: by 2002:a17:903:2444:b0:2dd:ad7d:72e2 with SMTP id
 d9443c01a7336-2ddad7d7516mr110968305ad.25.1789941547330; 
 Sun, 20 Sep 2026 14:59:07 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331aef90sm13342083eec.26.2026.09.20.14.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 14:59:06 -0700 (PDT)
Message-ID: <323eca66-f938-4373-9e4d-5cd3810c12c9@linaro.org>
Date: Sun, 20 Sep 2026 11:59:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] bsd-user: Flag shared memory as needing atomics
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-3-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-3-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/19/26 19:20, Warner Losh wrote:
> Catch up with linux-user 228168cbb7c:
>      Signal the translator to use host atomic instructions for
>      guest operations, insofar as it is possible.  This is the
>      best we can do to allow the guest to interact atomically
>      with other processes.
> 
> as well as subsequent tweaks and adjustmentst for bsd-user's code
> structure (we don't have one exit path linux-user does and could frankly
> stand to resturcture a bit to match the evolved code in linux-user). On
> non-private mmap(2) sharing and all successful shmat(2) calls we tell
> tcg that we're in a parallel context, which changes how it does atomics.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-mem.h | 8 ++++++++
>   bsd-user/mmap.c    | 9 +++++++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

