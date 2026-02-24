Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DDF4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuw67-0005rG-5u; Tue, 24 Feb 2026 12:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw66-0005r8-7E
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:21:22 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw64-0000g6-Lv
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:21:21 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9fcc24b3so747128d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953673; cv=none;
 d=google.com; s=arc-20240605;
 b=THPjVThcBeUtnWpmei0WNEG0XPtDyIp/5vqdoNJLUAVbgpa8dHgYV5r/aXULtK6LE1
 ryEnr5Z7CajoO0/wHs7E73TNa6s5MUT1wb0VVY3ky4EgUq8TyK5oRDx8RNibXQiJhzln
 beE9H6UBAa9LJgZgaPabSqaEl8K2aY3cYikNT3/Ht1p53uamDeV44Aonal84wIbYDm6u
 VdWgBVzCB2XudqAQ0D2alUHjnL4N2iqgTT+gkZHmvk2KMKdVXtflaEYJ/CNtXQT1swjX
 PWZQNUtMswONHtRiBbkSr5GtibzG8a1dzwdHcPc+r5073eX6IjjQwCeMiQZjA1DQxd8L
 WYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jvgpfhrOu4QU9iF5dWBTmgofu49OmLBDsSYvxxDHXpg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=DRhKSSbRniC7x5vy0qmJEvah07lIf17/Dc71n2qEDY16Yh/I0Kk+gOjjs71J9G9Mi2
 2jS+C/nI/XEqaQpg6IEvziSXG5v6/NwUA0lSa1nrvJ6F83LgqKOHznVcRWNXLz8MxBwF
 7TB7wEPodyYgdGtypLPZ/udwu3i5dnr7EEvkO2UThAPVMXE3dC/pNRwV9sgZ6xE2QRcP
 8+jwEabBGJ89HebV5MqoJ/1z/zyI8oQ6ftsy7n+LcFxK6/OCaAyY5pyhYdHn+fs5oEuo
 VQR82t8p3DWhkaeEdaE2UZswD13Y4X+31DKJMY4koeP0KPvfmg33Ygdj7j+jDnx+4Avy
 4JMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771953673; x=1772558473; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jvgpfhrOu4QU9iF5dWBTmgofu49OmLBDsSYvxxDHXpg=;
 b=hZA/EXQM6360sdIk/eB9PctCxF+ahz+tWga54eY+eVuc8gJ5gkNW8fAf4Lz1Gdvfnz
 EZ1/u30PWvQ5i11OTsm1Nb7icqdF3jRD51CeVEQwHH4dfQhZYu70tuj0DEurKjhiD303
 UjeJ+cePkj4HPsBmVzPxdJ03up802KAFzpOymlaeKzKet+286lyqgSvCq4XGFdedYyUg
 JYoWoti7dES1jtNmJwmEXzouPIEvoaf+8T4bmvpwYgk1xuK/nbZ2+tm+C0rAfT6zLxH0
 TvQtjYmVYUuEP7p9dvZam9uLZXaqj1r+jgKxIWy4YCBeMAVgWIBzSzURghGa8rLMvlfy
 qjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953673; x=1772558473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvgpfhrOu4QU9iF5dWBTmgofu49OmLBDsSYvxxDHXpg=;
 b=DdbDmxn7gPTsJz6MvTspnrmORUCEwCGmyimLSgaogO0Zd5I9el8l6IOKEJZgdCK0el
 w9KGY4ITgL0BUBOVr9lCffxmsa6aNSD2tZ61rsIViLcNjOiKYkj+KD7OSbkROcdH1oqx
 ADensZQY1mjaBObwn2WHG+4HhfMGy9199KbRzhtJ0ujqzbPJD5YACzKPbr+1al5gfHnT
 551rxMjftKQt7tNvownlwBok8Be5CSp9qmEG86OXQrtlQDnH7NzWJc4rxL9u1kX8QG7Y
 KHRIu8g4ynCOgkNcbH0fOxA+PwroKs1pAemjlD6AVTGB5qmKjJssP45aQkVjVvtjbnK5
 rKig==
X-Gm-Message-State: AOJu0Yz3RWvuGccnaJhIxja9EMf5UIBYtJwUp1ufA1f35NnkvMTGmVBo
 qnELD2IS7Vi1JKPrrVmg4cYP0q5UpchDoDGgLe0ANshnV0acmIgHNW9Lcw03Cz8PUL5e4XfWrpT
 vuqbSeasZU8id4TAPK+Qpx7J3ZTRTjyvpQ+i4Ab/16llv7oiREFrH
X-Gm-Gg: ATEYQzxqyk9tmSDLDWZ0vPilGnzvV/zmMF8+Pf79fgPD7iPDUsQ4NR03nFJnPq/M/TG
 r2VouGDhWhz8hhybcatjLnSy8uccaJCDR2c5cVci2zxIuLf+AGYQdEk5Zeys1yROUtu5+Ktzg5r
 ZFkLYbAjmkezFb9kLAEiA1J+MiaVkeWK/CTOgov3TAEdIBpHOASmZrrqKHtnnHQiJcwUQc1YcL4
 Eq4fp2gHe+3jlw1fdHWmAL6pB1S/KNupLwkgl4q3ift07Ok0mxWt4Dd1IjA3FdUBLaaXsVGxnF6
 H5yJ2mKV+CyRxgKpSzRJZLcdfb/r1+/DOgnzw9JC2z1JJQmYXGQwoarbIU2lNpBXeCS9FYtIAJZ
 oEg==
X-Received: by 2002:a05:690e:14c9:b0:64c:9f87:ffc8 with SMTP id
 956f58d0204a3-64c9f8802dfmr2110410d50.27.1771953673402; Tue, 24 Feb 2026
 09:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-6-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:21:01 +0000
X-Gm-Features: AaiRm51zLXNcnPK21CXbMe5JehGOyrrXFqlHzH5iX50w7LS_fJXGqcYhc3krQmk
Message-ID: <CAFEAcA8p7WnRZ-T-j4inz6UF8-SBbx9HY=h7njGLggmyAB0-pA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/13] target/arm: Move kvm test out of cpu_arm_set_sve
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 16 Feb 2026 at 03:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce a set of stub property callbacks for when we really
> don't want to be able to enable SVE.  Register the real or stub
> funtions in aarch64_add_sve_properties depending on whether or
> not SVE is available.
>
> Adjust aarch64_a64fx_initfn to initialize the set of supported
> vector sizes before calling aarch64_add_sve_properties.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

