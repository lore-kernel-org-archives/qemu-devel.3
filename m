Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32739C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjhH-0008L3-6g; Tue, 11 Aug 2026 06:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjhE-0008KU-6i
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:27:00 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjhB-0005H9-7k
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:26:59 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81ed073fed0so38664617b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444016; cv=none;
 d=google.com; s=arc-20260327;
 b=ot0309wgPGKp7DBAAHd/nh8NnhT++NQ8Iu7M6C5Z7WCrCsRyMC3Dq3xgkV1VhowVDL
 99smu8rS7ky3gapx9BlHa2KZaccVzzu0NkxgDyDHYiJjx95oQ2e4HPlHuaxgjUdan/zV
 UG6oL4eg/zRefaH+30afhcc7R+EFjTucNiPrUYqqnxdMYXB5y68daK2RJXRdvtf8Lj4Y
 igWi6eZ0jeNjDJHPWOAX5RgIAS3T39WvEgeictG+iK4L+FbXoaOiMv7T15J1hvirF+u3
 Ihvbhm/gjBTMYoFsMqkjA/STdmQy5tRAKsFSlTg3Pkv6tlWyp6xcpx0uSb1S/8dlEGQb
 g1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MRFbei7m/qQ8e1JmNSTblYVdLlTHfqLhhdqnJg95cyA=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=Ec5pEG9Hb9B5aXdznxpSZKuu2uRmfrSWrmheXCxg02v5s2/VcNrxX1IUcvbBRLEeCG
 XTkUxQtCzMJGr7RcpP543yqv0ax81YBvK47r/9b/Kb6tuqqYscPJ+I3OkTD6Rmhzao+Q
 SiYURigvGSIlATQdtbtVBhSymwEToBIA+DWV5uMl+R8x5oGauTwg8VQlu9JtGiF/9NsX
 9OA/7zsDyf+nwlDU6fTLCFP24x3d1z+lj/18AADZShnrCgN9bQFIGQUhD6RW3wSDa829
 kv+kKfokLFCeApKA8PgU7Oah9YYEB8blTzpWe/O8Vqce5ZIZgOeAaxIb64k7wXxjdeYc
 XNdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786444016; x=1787048816; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MRFbei7m/qQ8e1JmNSTblYVdLlTHfqLhhdqnJg95cyA=;
 b=PhOHyzqStaBDQHr2m0c+WpmG6vt2kta14SI3mehCF5O5gBZTKXuFNN3CBVSEh6h5F+
 yRO0JITpbSL8fWqo7ZjKp6I8zl6TiaZqfjs/wVM2gb6deVVi6QH6xhNlkFfbxdyE8JhZ
 QZt+0G1IFnj1qOs87w81s6TUnC/gvg//Cnlz1Dujnr0UPZg7SIvXK01+wJZAf9WTHKm5
 ZOEAgMnCYg5JkYiDx+IvZcMvNTpGUp6LtHil5Iji1JnOjYqFSkVKCBDkOARZv6diVhKU
 dq5skoe2xtOfcjrG4LZccPnjMz9jpkwg2aB1hmgDVD8KlPlTXh5m7dZ8GldFmeQJaquw
 3lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786444016; x=1787048816;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MRFbei7m/qQ8e1JmNSTblYVdLlTHfqLhhdqnJg95cyA=;
 b=GbtkfS5RpuZJHp0iVT6a8bHg4kO2vysuxHsXDN9ibcdyveZjBkkIaYnzQc+190hxn7
 F80v65lPpg5P0165pQG0JkPqLtVnqVkMRlmhrJG9Fia9Ajvos9NKUA+S+9BbyM7sn3PB
 qn1mD6SFWuMJ6By0YpS9OaE2FDWjWAu3RaavW1jH4tx7jaMubri71F9O9lz9zuwDEcs3
 uqEmTPKTdO9Vy5ujt0LbJ1q2lIQi3aKWBY2CtIlYFRu31CW7rOFLX4ci+kgpBWwTCqHo
 g1mrmmFKz4+986JUYuM3YnYSnlbdNwH+GyYWHFermHEXY75EwREsITilhJ0jAsKHB7jt
 T5jQ==
X-Gm-Message-State: AOJu0YyQBiYei4VwiboTCyteKDJ2k9H80KqM0z1QYBbnHVnbLSandN9X
 giB/X59M20LlecvVM4bw0QqcxTuD4p8RCfOw8PBofzRbWH90Fe/jlurRUDssPMrL/e1kd+0EccY
 ZuVAcfFMGGGmEM09Ed2PN2iGIbWhkCk3qk1d7QdxsIA==
X-Gm-Gg: AR+sD108pmCt903lgVB4FfFuliVgFL1bSG2g+SE8MMwhwCDbQ484KJTPvMFKFOOG80E
 pmWVbaDEv7AghmgRhUUQm82tfZsyAxpf16L2rvN7pVfF2DQ1rWBK7i14G4ix62HY+Qo2jiIceqU
 epHYrB/ADH2UICNgGRkFw1UnQUaN7Amzcf7S34663eAWYkxsjHZYM977fy01yvRAyDqb7jHIhwM
 TiVRVIVgjsGD2h4JgJJLN7lTOdTpxLoswEIxFhrSRe7KdmVU8kfKSUZvW4ulsZIziEpg5rZue9X
 7225iC5iXsFmHl2nfNavYvFjzqwWtD4wi1QWDRQ9tJNH38Pl3d9C73JnWewk0f6ZEvCyfpeU+4w
 DSyYpZjs49gVKi0kIzVXJxhXBKn/A
X-Received: by 2002:a05:690c:4b84:b0:7ff:87e1:34d1 with SMTP id
 00721157ae682-82f28509434mr15506517b3.11.1786444015917; Tue, 11 Aug 2026
 03:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
In-Reply-To: <20260805191257.11303-1-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:26:43 +0100
X-Gm-Features: AUfX_mxLaRxphh-pdFb889BaWYhIfAe0SPAcC2rtByfNXOu7sk4-ioALh8rRgDU
Message-ID: <CAFEAcA8Eff_HTpOxjkFBG4DQgss86zQbHvYQncVnuyBvkAFSyQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/arm: bugfixes for Arm SSE-300 and AN547 models
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 5 Aug 2026 at 20:12, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> This patch series fixes bugs found in another patch series and more:
>         SSE-300 SLOWCLK Secure Watchdog address was in non-secure region
>         SSE-300 PPU addresses were copied from SSE-200 and not correct
>         AN547 MPC ports were not correct
>         AN547 was missing the DMA ports on AHB PPC EXP1
>
> https://patchew.org/QEMU/20260723233605.805-1-simonxhy0404@gmail.com/
>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Thanks for putting these fixes together -- I've applied them
to target-arm.next, ready for when the tree reopens after the
11.1 release.

-- PMM

