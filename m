Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D9CDD1B8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCk4-0007Tp-5x; Fri, 27 Sep 2024 11:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suCjy-0007St-G6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:18:43 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suCjw-0003xl-BJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:18:42 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f7ba97ebaaso23622271fa.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727450316; x=1728055116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d5zpyBCuYbyma/qRSkexAoZ8d/MhaFW2UdFO7HSxDKI=;
 b=bQ6MG02grRserzjrVqik3GQMZOJt8ztgULz0uUGopEQcWjuuX62mGxQii4lRkxHEpK
 Psxj6Xu31nrFSjx1Gk0u0TSzwh80Yi+cE1sYJYDnd4K7JyOqSTiHYNoXoasZXYhXZgPH
 FSTPB4+TkvKBtxOdIVPqgIGjrdP8t7Hsr0oii86Wlw/SItI6TgcNImTSb9JWk+Laym0k
 rhTHsQ6Dc9cE+Tu+YIGt0l2JbT+u+K0O30+I+f1Cau3fDj4Anr2imH6ujrj5a8qXlzCN
 slngTFtjE+1rFfVz1U1GlLwLfbf7IYLo4vQo9K9sjZBmAdKrEkVCERmFDM7tLrxnPdOh
 ipYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727450316; x=1728055116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d5zpyBCuYbyma/qRSkexAoZ8d/MhaFW2UdFO7HSxDKI=;
 b=LTNNV5fLCIjtQXlTDI6vZegOY45KMVuHvyCOlHSjk/7/HBXSnSZOJGOzzClbCzY5Nc
 jwu+ER/6S7CxGODR92PrV4yJWGxr0eUrHiOQDvQWpHQ7IK6R0ddrsHskYjtPnbFC5lPy
 YKNfeXCehJkZIYJiK2m9ZhdZOzR+kPU78dgHaGcbzDhdQMW2OufuQmNs5uD/YxaJD/Zn
 3A1jvqhICvcKCkCVp8rwmq9u5ElPdxtqSPCtI32uhIqJfg9U9Id+WCCYr/E51AOLGSvp
 S3m9yzflHRpemIKpIY88BwBkXLGBdaPqJ95aG+kurgzw3OWfhDqRX0c4EB0Zspg0JVv2
 entQ==
X-Gm-Message-State: AOJu0YyHgBwlTSzoUZHV83vAVf+TwwA5Ukff609NKfaLF0hZWSzP8Oon
 Zjlel6d9pytPKNbf4XQE03yg47wLzsW7mZAN2tF9OVIqcxMKqylj+vE+SjFXfpGv84AQ1fqovg2
 AC91M/Z7SW6gGM8Er7JR+jGWQBsfLp/0QEYoQj09WR1wSDyWW
X-Google-Smtp-Source: AGHT+IFSZ9bMNOv3kXztGV7lmGGQRz81RRnOObOfzfJi/hPWZB+mjTIV/wvzA3wh76C318gcpgHdGD8TCkt5t2Xtzys=
X-Received: by 2002:a2e:461a:0:b0:2f3:fa99:4bab with SMTP id
 38308e7fff4ca-2f9d3e61343mr18342681fa.15.1727450316435; Fri, 27 Sep 2024
 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240922120112.5067-1-richard.henderson@linaro.org>
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 16:18:25 +0100
Message-ID: <CAFEAcA-BehKodeV-KtX3nxbsb2R7dTQDEd01QeoF91okRQ-QiQ@mail.gmail.com>
Subject: Re: [PULL 00/31] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 22 Sept 2024 at 13:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>
>   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240922
>
> for you to fetch changes up to c4d80fa63e823dc8dbf094b29e39b6978a3073b6:
>
>   linux-user: update syscall.tbl to Linux v6.11 (2024-09-22 09:30:18 +0200)
>
> ----------------------------------------------------------------
> target/ppc: Fix lxvx/stxvx facility check
> linux-user: update syscall_nr.h to Linux v6.10
> linux-user: update syscall.tbl to Linux v6.11
> tcg: Fix iteration step in 32-bit gvec operation
> tcg: Propagate new TCGOp to add_as_label_use
> tcg/*: Do not expand cmp_vec, cmpsel_vec early
> tcg/optimize: Fold movcond with true and false values identical
> tcg/optimize: Optimize cmp_vec and cmpsel_vec
> tcg/optimize: Optimize bitsel_vec
> tcg/i386: Optimize cmpsel with constant 0 operand 3.
> tcg/i386: Implement cmp_vec with avx512 insns
> tcg/i386: Implement cmpsel_vec with avx512 insns
> tcg/i386: Implement vector TST{EQ,NE} for avx512
> tcg/ppc: Implement cmpsel_vec and optimize with constant 0/-1 arguments
> tcg/s390x: Implement cmpsel_vec and optimize with constant 0/-1 arguments
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

