Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA0CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnXY-00051x-U2; Tue, 26 May 2026 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnXW-0004yi-Lj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:53:30 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnXU-0003sU-GX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:53:30 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651c5d525f6so10274917d50.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 01:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779785607; cv=none;
 d=google.com; s=arc-20240605;
 b=OjvNtjEK6dBYtDk1aJzKuiiz+Fxpgzj2xRxV9U1DCt/RAe4qn/sAxRe57he1S9ohaB
 51RYINCHYLvUcA/ce0KAEX0WEFYSmw8wISu/KDOFPH9GMW784O/pPzabDCq4uwYE9SvR
 9xA5zyQjjJwFZryZzEcD8GeSRNRcpF8lCaMjRdccajFCWeuTxI0nj0+KgKF1FamiiAET
 144zddqDCX65cE5l6jsQPXcoEnXxN7IFzjnCr48D0oE5SXg+esymOO/14wxABqvLAHAs
 oRXfWE5VUKq1bmZ7vpmzkqzwXMsqH/PQmDaZ2KqyMxnvh4p2y97SWmBaiMPHM4dY7l8L
 C+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1NNHncz1NjAw1sIvNY5wj7FYjfWqTU90N5K7IIRi2fE=;
 fh=twdMwO8HtYA0tKWE7ZrcLTTV93JyaLUwFo/XJNgsMPI=;
 b=JK62nGtlQBIM8ywSp/nHnl2mWlXLaIb3ZylQfBMO43D5mLwBdoguvMkHWWbiC6I3WR
 xij3RBerftfofa04QXgvJ3SluO3d0pwe/HMAKmEkmAzgrav8bqF+rDLe7XmGM36/srct
 iGpnOYEgL/YlsR4z34ktJCa4BS9FDr3jSdunoG4XKxCMbc8JG+mxU7+Qvw8eWvf1T/iN
 n83dMETqNnw+Cgbhu+GYZLAbvTHqKuTO8DbwSydtks2oBo3KujeaahOCtawJqY3P3FCz
 rI0Ztnpgop/VgjLqZOTibRBhHqTUPz08ekwjgT5pO3vXr/zjpWD1wNR8y4EenBhFLn+q
 afoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779785607; x=1780390407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NNHncz1NjAw1sIvNY5wj7FYjfWqTU90N5K7IIRi2fE=;
 b=Fxputrbslgn3j2HhD3bv+TbwuOeAImwl41qSSWZx8OU4LEjJQPRrf3q46rAXO7kL+j
 RLItPQ7Nue8uTQtxGWKfYM+S8PAxn0dQfX2CH0GJFYrho2B6OZSzRzwwaw9kj8b6WHPH
 8NmbS/bXtMHRSLvQhqiCQOb7ff0Sy9uRNO6o/mDx2HJ8IZlDaq9XraO0YyPHv/uVw3zq
 s1WXfkePk4cz1ZiWfOALN+Cuh2TiMrN93XWDcwjqqXg3EorXhhN62wKcVCVem3LdsJEK
 lKr9Ce1aCal7zG+RwUdmeTuBRDb5Sz9KaGbmWb+6GNcuu+2mdj53r2fJjyxGIr415387
 a90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779785607; x=1780390407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NNHncz1NjAw1sIvNY5wj7FYjfWqTU90N5K7IIRi2fE=;
 b=TJpAmmTRWjgoddrr5nn6sLjQsUFRu4RLLr2UW5Dyhq3P5XfWpUtcnL3gZU8I3lU9vE
 neNI7WpGuboRdLXcvv7cz7LpaGVgcG/s08E5uRpKziwcoxjL7HyLvDOkdYiOsV9C6Ij2
 23pG85fglMKLOqdWjqXiyXblCn8IJJ8/PaymsWt59eLRVpk+cUtUhePXrvobg+9CNfg8
 d8hlucEVvkb43oh+i/LTwsbeSdr/aAlVEY/CzPCQDsznRB1lqBpmEucXGyDZybbc4wNr
 XC8j/u9uU4BJP8cUXYurwO4KGav4DBUvypY8lvmgk7nwpl9gGzNLMXI8bCzQD/1tx0BQ
 I3KA==
X-Gm-Message-State: AOJu0YyhuCK+CwTQRjPw/WKzyWeLN0GlmKVQGOjA/fAXeuCD9tz/AcAq
 tfX3vzK+RToW9GSZOlFHGA2gdgE387hp2eW+aRBs+IcKQCMNbP18+163zo4OKgdf/1rzFCfokpK
 qk4neocNDmiiPRxqwbcMZeYuJ3QsiQFMGFwDgnDSESQ==
X-Gm-Gg: Acq92OENcieG0DcCEYjn/kA7U12+vx06BS+aw40g8pvPV2fzW2N3QekDHds0n961qpa
 ydDpUBlpk/ke0qh0sadVnbKvlWm10MKOtAogc9zwF+xeDtC1owM66s4Y8jJR+3cjdcCzlAZk9IF
 mEgscT/mEDmFpiB9BptN9dGiTLZjdW9eWRH6+rFQTlw5DQv41Wq2oEZziF5BSTiCeRRBFcV9gUh
 tH/OCQrKW8JSvoMpqI+AbVMjlgo1+V5vofuHB4DNifpJl3ad0cbG9GsS3ShC/qz3yu1Ru4BHyqg
 yHO58ueVJr1oLBfTObVrLQ6Ezw3cyGIhcM/erMXTQsaesYXA0UcDSB7vquDHDgHXD1NE03ldsQr
 o4w==
X-Received: by 2002:a05:690e:1545:20b0:651:c38b:e60e with SMTP id
 956f58d0204a3-65ec963388emr13989922d50.4.1779785607158; Tue, 26 May 2026
 01:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260525230308.137009-1-deller@kernel.org>
In-Reply-To: <20260525230308.137009-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 09:53:15 +0100
X-Gm-Features: AVHnY4IcPtpCyImCntBkVeIgBU94CXJ01HEJkP1Df0WrTvmq_-e1E-2xZBDJS9U
Message-ID: <CAFEAcA_ZOwXRGRTnYHrf6U5=F1eioX5oLKQVCtOamhz4AOr3Sw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix loading static ARM cortex-m55 binaries
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 26 May 2026 at 00:03, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Static built ARM binaries for Cortex-m55 may have been linked to have
> their load address at address 0. When qemu-user is running as non-root
> user and thus will try to mmap() a host address which is smaller than
> mmap_min_addr (/proc/sys/vm/mmap_min_addr), it will fail with EPERM and
> as such loading those guest programs will fail.
>
> Avoid this EPERM failure by automatically choosing a valid starting
> guest_base address which has to be higher than mmap_min_addr.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890

I just put a comment in this issue, but the reason we don't
load this binary is partly because it is not a Linux binary
at all, it is a bare-metal image. So the extent to which we
can run it at all is a mix of luck and "we like to let the GCC
developers be able to run their semihosting test binaries on
qemu-user".

> ---
>  linux-user/elfload.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0e757787d2..152c122a23 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1033,8 +1033,9 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
>      uintptr_t brk, ret;
>      PGBAddrs ga;
>
> -    /* Try the identity map first. */
> -    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
> +    /* Try the identity map first if guest_loadaddr is above mmap_min_addr. */
> +    if (guest_loaddr >= mmap_min_addr &&
> +        pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {

pgb_addr_set() is supposed to return false if the identity
map isn't suitable, so I feel like it would be better to
have it get the answer right rather than work around it
giving us the wrong answer in this particular case.

thanks
-- PMM

