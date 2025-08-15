Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518D0CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuSs-00049j-Q9; Fri, 15 Aug 2025 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuSh-00048m-LF
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:27:19 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuSd-0000Mw-Hh
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:27:14 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e93265d07b5so1185383276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755264429; x=1755869229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqnRzV7s1N9jHFKdRP6fm6kcv/FCXOcv3Bt3/lnvHMY=;
 b=iK7UkAiuVlqOixQOF/j1Gt2bjhyjCGGQaxKpFFTqs0AfT9sQFaMxeoge6ggwlNpRAa
 9MHkpSqHKE1FyMoUGagqbYDQ0gBD2PXfw7B8GINKgi16urVi9N5XR+RP4ge2JmK0Zx3l
 Xv+8/hSMpnbAuwaTrAlm8OWyutsHnSLpuEr7K3R+JBY8IClC78f7/Xj576CEBV5nKsCd
 +WyvW17hkWhlk7qVoYyMFUeiLiDCZc4WWn1xcXr16sHYrg8C8r5+7kmZqiAM0sgvhG5a
 OHzNkdLtfF9FegpXpXSRuuUKzJWhkOwrmIsQAlnFUhXeUKCL1L4TlOts+FiidMMoZlqj
 meWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755264429; x=1755869229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqnRzV7s1N9jHFKdRP6fm6kcv/FCXOcv3Bt3/lnvHMY=;
 b=VI/uA2riXz701Mv7qymJniu/so8j1nkV8eie/p8YF7Ijirfvb2OFPD2elvh+cLOGHT
 9cWmuWZPmSr29JwYCkOE4Z7QOO3XCc86iAH3Gtmh1MyzmEhpLSbczQ7aixdtLBHA1Pqk
 Uc38/cKAZAh3AVmYThYxM64fZxfEoEkx78Iu38m1I5CLieD62rfC9drv6UNjw4E5K7gl
 b1F+A3mku7kLjCgtcMlJGOApIrOjjOtq9zuXFTSV4IMj5mUZjt4kMAB+de9zu1gt3XSe
 kIDheHYmQhZ+kU/B1wUYhG8y+yWUqWS7yMq3MH9VJe+fg8f2LtBoG8ZHmAyo4U3d2BkB
 ofqQ==
X-Gm-Message-State: AOJu0YwnASSLWxpvqmnpXTEJYIgZ2XradYwA6lwz3eQmrJxVfgG/1vev
 W1HLTxjACVIk+l+t42FaVMpprrkejVQQQoYhCMXOxdcsLsXreEAhbS2i+wb/4fvxeb5f8rCZqzx
 F9TjzfxZ3lPIibNjgQ2ttDUKRK6a2TxHtb8CBn+qhYnvR+LDOp09y
X-Gm-Gg: ASbGncuJ9j4D1uM6iw6XVQRS6sDj3d++/2YIbbIYe2J+VQALXbFJkjX+5+QMS+hwkTP
 WgTG1XhoxYefJ+dzXqfBcSyQnLOr4dClZUMDNXGbxsKBE0AD8ERIkgOvdZE1VGpWcPtYQInwhsA
 Cxkumzf+BpOeTl0Hk7HgrGB7mCxg9b2BDlr1ik0oyi41DLjVgO2BblSZ3/zOYC1u39scfzQqDL5
 gZ808nv
X-Google-Smtp-Source: AGHT+IEOd1655jx54fNrs9oD/nRMi4nQWbyFKxMk1XnGrDMhksQTWuTbxdJfm/QfkUek4iR2KoG56EZSE/jFTlQjpQQ=
X-Received: by 2002:a05:6902:3310:b0:e93:cbf:d675 with SMTP id
 3f1490d57ef6-e931ee69dabmr7699286276.9.1755264428949; Fri, 15 Aug 2025
 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-6-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:26:57 +0100
X-Gm-Features: Ac12FXwheyiN_97YS-rlTtRA17HFTkDgm-qlY7vUzOJpEcwmU3AOaYRfDnfCixw
Message-ID: <CAFEAcA_Ea0=n4xB0BuJn5qODTd1uhrjqGCLAHR+X5BsK+GYhsA@mail.gmail.com>
Subject: Re: [PATCH 05/11] target/arm: Implement CTZ, CNT, ABS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Sun, 3 Aug 2025 at 02:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  4 ++++
>  2 files changed, 35 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

