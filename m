Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D52FF60D0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7STa-0001AF-Sp; Tue, 31 Mar 2026 02:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7STZ-00019I-5Q
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:21:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7STX-0003ui-In
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:21:20 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2adff872068so21914395ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774938078; x=1775542878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ecb8Ol654cIuggJMxMGXGpu8dkqDzuZ0qbr0UMGyqe0=;
 b=jK4JnZUoBSW6UQMXNxyKN22OYNlATqqdmlyD4mNbsb2zxTzG8+Qk5MMqvVREL4Kypt
 Xeb0qkzAWVOcjTvSrJHF2xlkBcKChfAo9q0i8Xk42/MoEeCxHT4tUb4Z5zUlfifA+IkD
 2HDEbWcN0a/S7fLl2boPJr9SwkYq4kt/vU6GJQBnBgS0U3KET44E4WR/4xDFVgsEl48k
 MFTM5IO9a3QKN6LzOL+E0quPbLR1AoOOBKxAs/dmN4pagJgZhh28+o12t96678D9kJ1L
 dVG11ceguD1/7okxtm2l5ojRJGuduAwq5NGNswrdLDUlF6h4bMwwhBo7S59AIVRdvSRR
 wLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774938078; x=1775542878;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ecb8Ol654cIuggJMxMGXGpu8dkqDzuZ0qbr0UMGyqe0=;
 b=h9nCdwZc/5IpZGbMP2LcAlZc5yF+g/srluBw4wdS4WgRXOepqKpCzg7YhJHtmYrX9h
 ykdb2FbYstLkMJX8HN514FpGM2lj4jPyBjZNscTF1pZZ+pvilHJ+Q6JGA/eGWjLkP6GB
 RZEVfSfwcpbtn7Sbi/1xEKXkMqcx9wdgekjfdHb2QKuoPCWVoGcYjb1tKmUvOYSyWTTc
 Nw0euTTAXjK9AdCtToe4zqmuf4YI5eGm2J6ZHoDAoUGL6Vu0LBCkIu1pmVpeo73HF+yO
 5eAOirSnnRIVFIap3fdW1eE1hVtVEDteufBomgNZ5wV+4536WshhByF+TjYg8ZFcVyPu
 eobA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3+iLg7DnwQ3Bc4XHctWMNI0f0QMFnD/o/w+DcXpB33gTWV/XvqUnQPocKR8b7gYBOay0AHoGTQqn@nongnu.org
X-Gm-Message-State: AOJu0YzO7yDWxyf7p1rnFSiZ6+dwVkfs1JE+GVbBSz6qQKYhMV84zv8w
 CuLnGKZLYXmhystRJ8BcD0HAl9FhVgMeaMNtReukz4n76o1wWTCapFVQyhvGWXpFBCQ=
X-Gm-Gg: ATEYQzzyblbNEfDIRAIvO1VLBVRAh3rc4nFwgQsyxI2HOoOI90U7D/mnHQ73sLXnwW+
 gSMsSf2UDnxgzaWFZQDGgH645mSJCYo6AOFXJNArhH7pNXi7XDuPN1Nnn0OKTnFdIFHkxUkSJHc
 surQ2AU4xS447UQm4hFai9jJHazUBXTRRMBYgn7BgUVpyaQKtdSkA0rVX9jE7i3uaEkrf7Zogso
 AjSE0tXhjlwE63Ql7jA2wP9HjBdwFzPwVM6lf1+cxJLC4vsGHGYMoTlX0BgWPqRy9pqYSeADEt7
 wmPogCso3FfnoEnir/EmQ1wpKuj8X3zXxChP/usAJrdf5F/PoCc+C29T2pE1S0KF3GgSP9drL+z
 CG1BGyNeSmQjxNPXSy/pnYfNyASwQ09lv2vq6yuwVNiWEAVMQqljvAWJEis39vV0ykYsxwnPu9F
 YRkOBg5MUF+g/e6vsX0HE/aAo7+C8Ptsw2RU/2uKk=
X-Received: by 2002:a17:902:e952:b0:2ae:803e:6c12 with SMTP id
 d9443c01a7336-2b0cdbf704cmr160813485ad.6.1774938077818; 
 Mon, 30 Mar 2026 23:21:17 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24b3a82f8sm70161625ad.63.2026.03.30.23.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:21:17 -0700 (PDT)
Message-ID: <0420e883-38e3-4aa7-9b63-f2a884045965@linaro.org>
Date: Tue, 31 Mar 2026 16:21:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: Don't include guest-host.h in cpu-ldst.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260330143123.1685142-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/31/26 00:31, Peter Maydell wrote:
> We currently include user/guest-host.h from accel/tcg/cpu-ldst.h.
> However that file doesn't need anything from guest-host.h, since we
> removed the uses of g2h() in commit 9b74d403b30e ("accel/tcg: Move
> user-only tlb_vaddr_to_host out of line").
> 
> Move the include of guest-host.h to where it's actually needed.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This isn't needed for the following bugfix patch, but it made
> it a bit easier for me to understand where we're actually using
> the functions.
> ---
>   bsd-user/qemu.h              | 1 +
>   include/accel/tcg/cpu-ldst.h | 4 ----
>   linux-user/qemu.h            | 1 +
>   3 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

