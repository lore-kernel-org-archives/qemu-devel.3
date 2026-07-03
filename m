Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62FBC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaEk-0005XP-IS; Fri, 03 Jul 2026 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaEi-0005WX-8z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:31:04 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaEg-0000Lg-R6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:31:03 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-80a123ef90aso5646837b3.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783071061; cv=none;
 d=google.com; s=arc-20260327;
 b=azChS8QRYYy8fBOntsTpvZynUDkAxUS40dnT2QtQPG8BunXQXAtrxKvfs7Yan0hNXV
 kv8VlLlETQL+9koAZetKJ8lOpdervXl+cNxiDnq/mrgeCPx8Hsh8eshUb2iIunqgO+2n
 jfe6EIfGQVYdD6nhadRO3QYA44+DeH5AQKXdZQQBcDAkA6th4WU77wRA9KcDMMZJj2b+
 fYaV8HtIkQZ1ohN31tJgKBWEUplYlj7DUQAm4F6obb43V0AZFTJ2RxQNk0v7RFguYFos
 M2JHVqwfV2RIV6hWfCmQgE5itoAimvn371+GO93Dehjf3QbSlnmiV3vETtuvDPl1szbt
 bNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FdWBZixmBsP+1di166ud9LMtZpPssKVltwTPsHp1lng=;
 fh=HycL0dBvNlD96nvbpYNKtj8Cja0HdIu5dYQa7Inkh/w=;
 b=elowfOshFVF9TvnAvNbBB1HWWCfxREfXZwqlElDeh+32bpjj1wVSLtp/vxfT1TqHrs
 NONHWKzY1wL9CtFDffZYcCHYrpuULhA9tOKT2pE7dLJg+N5ile1GsFXHEuXUMNxN7ssj
 /o7irW96p8aDbjvklN5uLyqpbDjqESGDTlJC+3nZrP2+9bcd43mwFRmk9cjglBr4gQJD
 +6yxhnwhGjGPaILNoNOFKFYZW9Uoqu+pm9udX8X2wGldTi+KxkxVad+zPlKWby9NZCgj
 s0MxcasCjmqa/7mLUWltoTpoT0D3GbjNQKInp7h58TMZfvHnHT5dIvhZMko3b8MePpLL
 27ng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783071061; x=1783675861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FdWBZixmBsP+1di166ud9LMtZpPssKVltwTPsHp1lng=;
 b=PU4f+YZ8/Iyyj9mwrEW94Q00hUsSHZ3PU8Tj/SnfqEUHv2hAD1/a0xxKytXGbhpzIN
 3qSGp1p0J1YUN4Hp47fqSONQjCWScDGimjcrHUroIT1TUEUtm2bcd55TuC497sXajBrT
 Js4svWyRXrUjikWs6ITjsQwgT0mCQ7pvvlH5sQi5BjMdCMhD93sGs589+pseAnUsDazL
 YohNVrblycOKQhhh2Y4Ck0GwQyxoIMSAJ+WP3JLTWm/srW4uP9P5JObKmr+mBShQaEy6
 4KICHIRqLIpCUtkSuUjuWVy35uI7/KgCTLe+I7bLTi+B52rZ6wiGuM8Ea0IwcLFpFniA
 E14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783071061; x=1783675861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdWBZixmBsP+1di166ud9LMtZpPssKVltwTPsHp1lng=;
 b=XJr2q9P9YV1qzI4GKv0KeZfYcSB4i9wYdUeMnjFAX0FdBhSfkdG9wI4OCX3TJmvku+
 KrSoxRykZFfIxN2lrmhm5/kwlfRuCVWQCGzCIwvkAiCdXUF9GWlHvzJ8f2PH40swAp3p
 HLTuJUovgoFqtTjzswniP1K+DTL8zBHCT1ZdMkAV1CR4Sp5ihiPd2g9OTp2hbI7glHFP
 bDhYKgorr/bcnXBphl/kIWmQqPIu1YfbnwHlYWWwDgay21IGYqE46onzugvifkw28eBe
 QgijEnRk4qBnIqyAWVRkCmaBacmvbzYkvcyltkEkzpOzgzSbKmfINtlmjNw/l8kP7iGd
 B74g==
X-Gm-Message-State: AOJu0YyT//ojigM+CuIgskvGw1shVDqiTCXFsPx+xYs6swzsnM174Zzw
 wOa6XawYemy73+KXaeSGK3NksAQOAgtmo+o8L7yqi5C2XkyUKAd5cFtJ3zH/6klDYwuczjkq0Vy
 tS1vcCcwz1LFUyt66Qkin3siC1y/ZOseRi3NSMe9aDg==
X-Gm-Gg: AfdE7clNvSFKuylIJBch2WqzxQ7saseCAssgszR4aadOSsp/+VxmVAnqD4z7xa031bw
 MJlWPKVo1qGG3L5ASMAvvNQMflLlaaKrN+fHvgEvS9Rk3cnpdSiVkpwnE7loGHXPPqHRvNWgtM/
 G9wFDouqqzut630HZiDAVcVcYrvU3XCtl43CF50Um28ghhT0xlyYQEqm3468YydAc8ScGIP1OcR
 aRJH1RMxIPFE0/soIVyW33+gTjo/cB9gU6J0rvx509eNC/NrPC7vnrHgvbeSx9VX5jU5Gb2IB58
 da603BKclUVG+ygwxjNLDHpKs9sbo9JeuA5eR7qAnGMdI30ollshEIfX
X-Received: by 2002:a05:690c:e184:10b0:7bd:9a25:f39f with SMTP id
 00721157ae682-815ba02e8edmr23346737b3.4.1783071061378; Fri, 03 Jul 2026
 02:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
In-Reply-To: <20260630-jmac-fprcvt-v3-0-f4840d5e0a7f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:30:49 +0100
X-Gm-Features: AVVi8Ccm8X6K1aFq9aJg0bdFYb5jpL4O8FdxN80N3AY33csxKl9lfoI0z3Q95jE
Message-ID: <CAFEAcA86JezGW8ZDD3snWcM=7nRnJPj=vhcBRrxXCa0TRELB8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Implement FEAT_FPRCVT in cpu_max
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 30 Jun 2026 at 14:17, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> This introduces new forms of FCVTXX instructions which convert floating
> point to integer but place the results in SIMD & FP registers, and
> forms of the [SU]CVTF instructions which convert from integer to FP
> with a source in SIMD & FP registers. The logic for conversion and test
> values are otherwise the same as the versions which use general-purpose
> registers.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

