Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEEACDE008
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchBX-0005ad-V5; Thu, 25 Jun 2026 06:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wchBO-0005Za-DJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:19:44 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wchBM-0000lA-Al
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:19:42 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6642887c602so2105620d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782382779; cv=none;
 d=google.com; s=arc-20260327;
 b=cj3Ud9BX6BrVrTQrLQo9PL8wIpYjerYJL7owCVNn3G6zuZsl/UOy/EW5/bkbRujf8F
 DuyFz9rmMt/dlLPfbs8xiTK92P1Sj6gH5+EpiHHXu4UCT+pGFjwtAJmqrjUlp7Jia9hl
 P8KzwyHYYVX6IAlMwi7LEdthYHRyhFLSolNqk/y8EDw8TCWtklW/0sZbe0xZxMQ+S3y2
 Qws554hP4WuKH2NVc4yeFnwWfEhD0mJ1elxn98eelOSLF9rK89vKo5SzL+FLPtIX4Ojv
 QUGCF4jRgobFFWdA9lC6t4KTUsyNxHClv1w6KaSGJGwxgZBEXtK+qtHNnF/k68/NuAzS
 e0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oaAzqeAzZY7GNKiLs4DAejh6EqxG4sx3r+N8tUvF82o=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=dMc1z+HvVnRSTCAOk89VS01oaFDcqiBqnxsZC9lAqWn8onoYkuR1NNDbYw8FT2nZi8
 Ik17/CmfbSJpXQwjH+IsP2HN2MWmoTRiafYRmQ2lCHB3lVz91X1IajVFvVqM1wgR1wOK
 eXlva9Hs6M9tW6APvpCazQE8anxZ9H1ClDze2dhT/IMXJb18ULbCXmEcm0G4hMMnND06
 kcx4bUJDwQD6kH1CWx2E88DYGg2xYeTyotn99GfhS4/QFHpP9vJWBQx2vxVztzYHRh7I
 dDD0b38uLUZoBWDTX5HftDV28zZaMYaWxywm3ikNu1CxIbeqYgyV/5SBz5Q+unKYUY6Q
 IKtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782382779; x=1782987579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oaAzqeAzZY7GNKiLs4DAejh6EqxG4sx3r+N8tUvF82o=;
 b=TAqaJz6A7wSkvAptPajQskFfrad4KkB6vrUJWhd4Bfh5fGgjzJLl+dQv/Awy8mZhjD
 S336f11gBqMoG8sQWdj8FelDHU/fXzdJZcR9E8J2j6smKdhpsI1+xKQoEFW/jENCbZIL
 9xGjLMvg25LDDFcmPtU2NyTTzuYePC8jxnLKVkgs8EOT7FT9o5Xy6GBqI3VzIrhgm6Jn
 F4QyCW01Ade4qI1qHcgrf6Okjf1qR5wo6za0sZjPS95/TUoqcylHWz8Cr2Cq5oXFiyeF
 7z61ijuL99o7vmchr4sBe6G1Cm/l+zjkxJFTydbecs5hyoIBNcSu7Hv+GOhtXMB8XpUR
 yScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782382779; x=1782987579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaAzqeAzZY7GNKiLs4DAejh6EqxG4sx3r+N8tUvF82o=;
 b=WLaHCYt39qjJ4/m2Nh6SiR38jrmLQ1mH2LhxZcoFCSaNF9pWX8vAIUeUyCXkC3SHGo
 UajUYvnUrmIvQ7sZT4PPmqpd5kJucO6NUg+WhZ1FdeeziDAkzhh+68EsDHGhBWUVVnJ4
 19zPb2y8veZkWVxBijNcDyrKJsdIKPJppylvkxWiuTY5h3qROSf0TmNmYJx9URVwWDIu
 lQ+UsADMhwbldvqOlPbTh8sD5H+WyuofN4jDykrZX62aaonpoFTLVCNq4/ywr4wxYIcm
 qXCxUOK/z6xEA4Yq4iTnnvfjnRuik0za5UK1KBxkhDrJ9dF/erofVtb6Ksh6clQNnuTp
 ishQ==
X-Gm-Message-State: AOJu0Yzg8bFI3AzbyWd2icbLAcsm11nG1SB56dyi2oqvpUyj7vlY29Q4
 lvpJZ+pI0laPJohFg7m9KQdzdeQ9IrYaTypawvrJ4yon6U49r+Lpc4GqJdBy7go9CEa7z2aRjmD
 kTSWBkczPglQgfom5M+G5o0BVG6Vtn0LkLmU2sI50kw==
X-Gm-Gg: AfdE7cm3lS1uluwvGuSZ2jizqbcqhU6I4nCyCVhSjTGI2hvUqSBYSJLGyD43hWy+Dh8
 JYJBGGrFgRWuq++NGnDkUEAoBo/+Cpu0x53+x5IZ9V2CeoshaR9lJyPeMUxMEqAqLL6L3mu59IE
 G+PRf1XU5cwABGufMoc6hRYUSk5AWbe5cSv270uFyO1+yqVMYSiryz/L1blQFuJM6yvAq/6aF/P
 iUxSWLpu+ffeyjv8ZYyi1SQV2KcdRWaml71/+7Jf+DEhj/I5aLAB6dmdxl9P5+WTKZYxt3ml/6r
 PT6Xd6l3C0wM6U6wyhOV8Llr/g0IvzK3gZiTBTFFHPOxYEOJG8P/Pl2j
X-Received: by 2002:a05:690e:d0b:b0:663:209a:a6f4 with SMTP id
 956f58d0204a3-66488366246mr1188044d50.40.1782382778926; Thu, 25 Jun 2026
 03:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-9-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 11:19:26 +0100
X-Gm-Features: AVVi8Ccvqg2FEfiZ3LPz_jXLSlKWMaobbMV9NhpG9UsdrWbAIpyVfZIyFEi2JKA
Message-ID: <CAFEAcA9JzhxrBhs6G_Dov3zanQBBPPA93VErEfiKNyw7ni0oXw@mail.gmail.com>
Subject: Re: [PATCH 08/10] target/arm: Rename FVDOT pattern
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to FVDOT_sh so that we can introduce an insn
> of the same name from FEAT_SME_F8F16.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

