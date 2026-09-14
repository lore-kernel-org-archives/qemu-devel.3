Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAB3C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6245-0002Hy-3u; Mon, 14 Sep 2026 04:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6243-0002HY-Kx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:29:23 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6242-0003ds-Af
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:29:23 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43ac8d1fso8583357b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 01:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789374559; cv=none;
 d=google.com; s=arc-20260327;
 b=SF273IHXfnqwgCuGdCdRgc9u4DC59I9fmMhiTSZxxvj8FPYrVcAQYifVbyMdwQhH/t
 muFmog5KXtSs6ZfZm/rb1LeAESLEusA53HUsla83A4UcomJFRJ8rp4A+IiasG7wCeFJf
 KSmVz+C+HVhrEtSpOgHYkEB4bDds2c1+0wCxyFDrhT+LjKYYFkvuVVEY/GNJfX76zjCx
 WiNddR8JGVRBW77bDsIgYAYfsmZxMiSkDpeKg+spN+SNWUUiEDTkIGgRspcCN/EuYbHS
 2QTRaMUZTRXUbJHofTVPXRHeeUS4kg+gpcqMlZp+s1ChEa7R+ddVjHYybLjewuN0ZC7N
 wVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2Qr1COfbzbGjjGmH1u+AT1lOlz+gyQ9J8lsk9rkGL1U=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=ckJuzR4JgOUztl7UmsINDGLguTQ3rr8NlPSWW/pFEDPBILxC7XJCtokom59R51nlLe
 Qo4YLWCBKvWcrKksEc9FRgUBPudi63TgEPZWJdY6IksiN23FesARaxsgRcXXtgjhCC4b
 RidX2ZDbbjiU8WJT0nMvxAjm+MmrTZZoxbvfCIAaTeX420V9a0XAJokD480VTbn1lk5x
 +CLIkSbqErFFhF5sXqVhAeLHKpDJ5kdSiYqanVEFf0YZcCuyguw8opTEgZF/aLxgwQVz
 pMuA5vUW0Z+oXpkbpaDsJwut+Y+EI2zaTLelzctAJAu6+UpMw936muP24HQY/CbzLkQ9
 qLFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789374559; x=1789979359; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Qr1COfbzbGjjGmH1u+AT1lOlz+gyQ9J8lsk9rkGL1U=;
 b=dpmLylQyRIVY9mHPg49fwJIlpiIHWeYqMvq8p49NiphTM48APpuGqDZQTPNtVX7uvk
 9ZWlXhgu5yCL6t6duz7AdjoPEH+8qNzflbptlSgg44fWuiFDdI21tBThRsgAOy2tqsAP
 Y2JZaf+A2R2cErWoK5FeRHXR77VtfyScyKHcEJs4mzoU3H/xV02Mx1leOViAiLXP6G1N
 bZ/gclU+o//osFHNZqPipqEXA0WtWKBkolsKk1ouRD7fCYVtU4kHccY/JRownSnzVo90
 86DM/EDrjMQspXpfnQegjQ6KwqbA8lsFLhZ6ci1sTwKwc1pyRQldkt5Eas4BJwa+Yhdi
 VO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789374559; x=1789979359;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2Qr1COfbzbGjjGmH1u+AT1lOlz+gyQ9J8lsk9rkGL1U=;
 b=MM2cGxSLGZQgwIgW9Ddzqn75VwqGTfRC23YqkttZgqtii+rmln8Zh9ShP0hrfWyQ4K
 xPPLapw6XaSaUPA7mxyWSX1/FBbBxRKCK5w1N/q5brQe72cxlDBWYP2JwApOgMvYu8Zl
 e30jhkuA6PEGCZbKtZ07yENCLFc2fcAx/MIrFPr73yE6mhJAIRR0gSpQ/M8VXmLELtrQ
 XVdu+jX0L6DU0CGwAQrsfy8M4YuDl2ju6psa+E++QbOJPOmWc3ZZfrKneX8khN7YJh6A
 Eo72F1a9IESyaBVS1tvADDZ8wsxqeCGlOwt3TsvXBxTIcAoHt+gQgiNhBXagNMSiAwxT
 ej8w==
X-Gm-Message-State: AFuF++mET5qcmq/skLuD1AqbBdrtPRfXGEpx23XdFfR5Z87SA/vbBkNM
 DnkLQeUENw0FPzSjBB28jC2smjmITgt2zipZLmTCb5qJHsSeN3KgXHoKMRahcA7ho8BALAO31jg
 l3reOy4cSKtibOjZZdXqQwJ22iNhq9XTlc/yP5tKyXg==
X-Gm-Gg: AYBFou06XAzm6AFsz3txHvw0gnKtyS543lYBCNOFV29pI4gindTVAsB8iJhS3CkJHtP
 vWX6COWVXvJxpWNTtEPQzaxGleNZJTa3FGNnLsX12IghSn0Ie3/day98brUqiO+aFZvCYTbznw/
 WdQAfDNPIeUuLR2wuCM8z43qAbLOGIVXZlxoYqUBhg95ybrf4gjZ/RBCiKtblI4b9y2V2P2UjwW
 oojIc1aCQIeJqQEv2vpfc66NSyUaoRto/9wgcg10S2CuNjWr4JdB1xU8y1vO+N4t/Ep/rELAP4A
 HZrSsYi0KX9Fn8WBnmFyLrGx3KKe7K1z/mZbVdEDCSIfJqvvoBPPwSGC2Q4j9NiMBerxIhJ1U03
 b6aUIlBQ2I7FgQAT7DiGyPYszbpXTQXf7bKDWYTeQayDkzKgcwq8=
X-Received: by 2002:a05:690e:4147:b0:670:ff3d:e71a with SMTP id
 956f58d0204a3-6714e1de255mr258714d50.76.1789374553717; Mon, 14 Sep 2026
 01:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-3-gilles.grimaud@univ-lille.fr>
 <CAFEAcA8OYNNDn7tV8gzoVcKnpNc5MZZ1u0AmbbNpRfuzdoqfKg@mail.gmail.com>
 <20260913183157.8294-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260913183157.8294-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 09:29:01 +0100
X-Gm-Features: AcwNN1UX5MSQXyEtj61DZSVfRkkKtbS9pQKkFJudWPtskFY9SW3y2E6ot8i0Bs4
Message-ID: <CAFEAcA-g_NBjCJ-6YMwUZrppnDLm9pC8WOYspNk+4YLCXWh+sw@mail.gmail.com>
Subject: Re: [PATCH v3 02/36] target/arm: allow Armv6-M to set CONTROL.nPRIV
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Sun, 13 Sept 2026 at 19:31, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Hi Peter,
>
> Thanks, you are right. The v3 change incorrectly treated nPRIV as uniform
> across all M-profile CPUs.
>
> For v4 I will add a dedicated ARM_FEATURE bit for the optional
> Unprivileged/Privileged Extension. Cortex-M0 will leave it clear, while the
> Cortex-M0+ configuration used by the RP2040 will enable it. Writes to nPRIV
> will then be permitted when either the Main Extension or this new feature is
> present.

I would suggest making ARM_FEATURE_M_MAIN imply ARM_FEATURE_M_NPRIV
(or whatever we calli it) -- see arm_cpu_propagate_feature_implications()
where we do that sort of thing. That way we don't have to check both
feature bits.

thanks
-- PMM

