Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93511C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6AR-0001gd-8m; Fri, 26 Jun 2026 09:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd69J-00014C-OH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:59:17 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd69H-0000lF-24
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:59:12 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664ae993e4bso98271d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478750; cv=none;
 d=google.com; s=arc-20260327;
 b=XQLWwklEIygaRqejO0j1lHxaN6z4LVvAt41yDc49WBJmhtv3E4ntvi5ITHWHwg9kE7
 7suf/tGXVMyvWBeR0yAwKp+ZxiixRD+tvFc6c7HsMMJeoKWhLgmS1jczoroaBMK9QavR
 NnUZnghG/7kyk5pDkCY54YSjnoGYPNTP97V+hWPU3qNA32oCJ80yOyJqx2U6mGXJEBQq
 roigWEYGmAm9zY1aaU1Jn6CNeTxEy+6JPWxhNTQBwPKgh0L8WJxD3Jj562Bu/5SSBQsZ
 EH1qagsp82jYDH3B9HGtHica9NdWNy4bOjQjW8MyNZJnJfkQRuDNd3Yr03q88IiA/rjo
 htHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dRYeI2UKL4Ikr299qX0SidZFzhgg+QmtK54BlgODc4k=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WHoK1FaLbwYVSLFkY78J1LLHKIfSulhDbhssDs2Eb0MOjWrqjz0x+JCZUxGOGKmhuP
 RYIPvursmS4lDIRz/B2jfDZsu8738bMPpJ1aE6JYtBpFu4YU0n4x3X1d5cr9x73YG6iq
 ySm3dexMt4s1MZ2Y5PtaRhP2mwZKQAcSbAkls0zI7TswlalJNN0rP6wCuelJ6Q/XKnvL
 Ixr3oB9earnxM/9tPxgQatF6SI6gVAiqCyDWXe3ucZ3uqZlbjEkW2DfKIPB0q0dba3bn
 hT3N3tuhKrQwnyiHYn/yPQ727HsT7uCIv7XB7egd2Trk36qfGY63GFiklVsvxpO3od0x
 TG9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478750; x=1783083550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dRYeI2UKL4Ikr299qX0SidZFzhgg+QmtK54BlgODc4k=;
 b=qCWuN0eCydzuml8h86tJYdRKX/b2dknH3po8EZYTnuRO3v3+kLpGKh4SPSQKVvVoSv
 NMqWc6fZs3CL6gvj9g6+KYiAmyPODa4E9tsXwRJyCahu57yRAt7YnUjYTrRW4ZyMyRvb
 qYMLMQ7Ds6HIBuYon027NYv3YKY2p8U0vd/j4Itt2q75m0MJS83PSH/lTckACYhXx2ii
 3z41JyeOZyaVr8o3On+BTk1OeS+NEvsxi9ulRrBDa+n+Bz6TkIjsNSgfdN3rCKZN5+Nq
 N0jWBY1AYnV4+1RW3DsgYpgkUu0qwbyS4tuKteOt3aRfXktZmF8bot/Rw8VGuiwxkBoW
 /gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478750; x=1783083550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRYeI2UKL4Ikr299qX0SidZFzhgg+QmtK54BlgODc4k=;
 b=RjO26kcCSHunZJqYseW4H2U60i5KdwPPSHbvX0hz2DwCxHrgO1hZwI63SAxtrXL89g
 XyWdhk34ewcHG+mwvEyzx6qAkdm96prX9bRT4ouz/lF+SGiL8rgtZifKCOR3R5EMdAPe
 fUbkrSnSa+hbi9ybNqmlPejEe3MOsb84H+38ppdNRBsFNxrnUESFhCq0B9RnIcpWVe0+
 QXZ5nZUpvMkCIyIgqTA3yJ4HIA+Y9TKy5TrrVR/jke/2fxILzFlDq64xU4vNpta+bxot
 B6OMfBYEuKfYdviWOrkXk2UN9veUBaKH+jLC/meWhwaa/oQV+9lJgDu2oE2KFOhJdBqa
 FGVg==
X-Gm-Message-State: AOJu0YwGa/H4RE+XOsbpMYYOp6mkVOWxi0hPZ7tog0MyzAIfy8DehhBw
 MQgEusvNFHDKN8LnHGytDmeows/fvohPFJFQOlzI1XxNHMcHojwQeiYOzHptNRqVsm9GQZkjFvg
 /gREoyAghBUuSBGtl8Fa2kUyEQNQ/YTKYffjmRCLBkg==
X-Gm-Gg: AfdE7cmMngyGefQPWD4LwZdHlvvnlws1o81CY2nIc/DJxDhabBkHqjnxQ5TecleBMbQ
 v2pB3kNe/AlytV/WsM59PeTbkljm7Kow0hR9f/F5EPdfV1+8Q2SP5N+1/0cIf9KukRSvttbMpuA
 /ouNGxB7+sFKNMoyt42gtv5VKYqkne5Ghr9WclIc/3DcgJte0EtsjhlVu20mKbaSVxhGH2pb0UY
 oy38rrfmUV6wKhG54h48OMVSYe59enO6yPKfX5tFNJyCmNAAFIRaoGU3NWUkb+l5doJgUK49Y5J
 /CbI5/ssmPaH12pl87tCjVsC7AzBmu/y6/MdLEi/QWSLWlQCWZRjhwXy
X-Received: by 2002:a05:690e:1441:b0:663:15ba:cde3 with SMTP id
 956f58d0204a3-66487956cf6mr4504620d50.21.1782478749796; Fri, 26 Jun 2026
 05:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-7-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:58:55 +0100
X-Gm-Features: AVVi8Cc0PKvhBxuy9vr5WqplVApxGbYcBZw8t6S0q-K4csodgUc_Yu6qcWEJqmg
Message-ID: <CAFEAcA8wARhWC1ZLBV_odnj=x7yo_qJBZUqd7=vdG_En3BPqHg@mail.gmail.com>
Subject: Re: [PATCH 06/15] target/arm: Implement FMOP4 (widening, 2-way fp16
 to fp32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 25 Jun 2026 at 23:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

