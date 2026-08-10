Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A5EC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRyo-0000Ud-U2; Mon, 10 Aug 2026 11:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtRyl-0000UK-7V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:31:56 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtRyj-0004gQ-No
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:31:54 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80bb41f7f3cso20565487b3.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375912; cv=none;
 d=google.com; s=arc-20260327;
 b=k6Z71TghHN1nmj5ZrwxjUbD/M6+tTahC7eXraA9WJfnVp3YkF2++mI2RYMSLuzvA9c
 L1wjW0nBI71+x5njYUyd2BZwXAVmNcr/df7Dx4i1cY2GbhHKjFlNIzj0b02NfiAFIKVS
 oz/DsswDSRpMPfk+ykRo69F7Oz36HMYYY8zLWgxdEUG2rqIXuejZSYTldiWuXQ3Lt9Ie
 VGP6hi+ixdUZgcJlS3h8QVbKHcODO1Lc3THX22IyG9Aqbmz9iqh6jCQ65A0HguWMfatH
 344AaJs3cygCg5b8Fu7P9NiKOPs8IGQeo1OkyEWgsLbuQK8O5qzXRc3bQdk23BJrxSrd
 D0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rMses8ntYDlGghtT4lnKPVhSwBUnfqq+VYmQiOYW02k=;
 fh=sa54kRfqZCSJoqqovfbLshesdcnvoIzhJ6jhb/uDQ0k=;
 b=Z26ibNh85dnP0PsacdiOKcJf++RiUHFUzDerMrBBvXVMqtL1zRmT6WkFZpFVMR4MOy
 JgEfogGdNAesU8UgT7Neb3skQQWDcXusBe5LxYRQ1aNYBbpZjejppJcNem64RKggQNNI
 lGa8VCE7vcNTQJzxPZMo0W4fTRJHZkIxJ4SMBZ3GrQrR1Y4QoO0SDvkrluc43zuJUMVZ
 fsrMFyvQFyCUP1oXfwAXKwtSAGk70ST7KCdE5qJ3jd7QoFaw7EgGgglhq4lqYhDAnAl7
 yJCkl7r9CmB76Dlxlg2vSuAzgHy+SY3HQF/XObH/HTMa8DiyFdai5D6uisaSOaangHsp
 GHuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786375912; x=1786980712; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rMses8ntYDlGghtT4lnKPVhSwBUnfqq+VYmQiOYW02k=;
 b=wxPoPh2gm0WmHT3pJMoe4/DLiJ4y1VbBeSsoGIDbDdhmzqCyOR84Z5gJIGhBhQK/PC
 kKF2rSYXbim5gvy7Mj0xYoS+8tcvS/O8YOYiVApcI+iGmchm+GyMOMrlgdIXzJvU6e1p
 PI54BLwkleL+//nztvomalujf3wDrjCnS5mmrjeid+e3kUmNEv/QU+FsFGBAUb78dgZZ
 Z8jNcwel34Ea6oVYz+pgvtH4njvI/099tcOojybaTucjBCKxTWIvexVduAmxAYylj1FA
 l3PrrRb7UzVmH2Y14H75aPqN8RI82ejtdhqGK7EHb26ocq3kMdN1GKeVHxYvnu9x2a0O
 mq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375912; x=1786980712;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rMses8ntYDlGghtT4lnKPVhSwBUnfqq+VYmQiOYW02k=;
 b=ZKegqyWbKDWrknhTNayzkUWcmG9EWD7j9klUegEXRqAwFCVlkr/CSpGvuE01Pv8tvI
 3+nsYkJt+VjMufFAeK8RNMuBMNHJuvzylPiOb8EAwV1TUUS/FVJf9LZ+iZodhWdNPfph
 8zHkXwyPNJEc/MElppc7uKST+8Megi3LwcdAn8ZdlR0tPoSfEzYORZvcJFSUXvHiDaJc
 9/bRUrPgAw/oChNw00dpBzkDCwRQ8rCPpHoy/wu0ecUoGEBw6+2bi9kNFmYgN25ZRSLo
 xYEYwMVgJd5oIPPBMp9WnmqRjLPbCr1OIU79FP2FdQ5+hsVFdE56mm8sMr5FO5mlLX5T
 jzVQ==
X-Gm-Message-State: AOJu0YwdS0YZBU2iaGvV83+UQ5BESdhostdg5jSsAYQqqfGlIawl+rHN
 j9OXWYDn05uaVnm9TvzaDUB90X4L0TFNfRZcCRcOkhKNveivD0I+bLPrWBFA4LGmYoc1Adwy+l9
 tPZvxKismJks6MG/EqXNRsPFZZoliQDqv0QtgdALhGg==
X-Gm-Gg: AR+sD12vvyioK5Bwfs7B7diBfXC9Gs0Rupqc9FNxPnyiACnvBMHZnTuGhSm/RGay/2/
 gAFwQ08k8R/J4B512u1yfd/xZ545UAdNBl2HEM26eSIGeRH2xaM4Q/ILWdXRc5FgtxRXJAWRBxm
 1yYdzDdvAjTimfAiByrVya1W7tH/thK6t/pryi2/rSVxq/QOqiZt1NjrtCZpKjqIyBMU9FtY8nu
 0TI089Yld8Ot1s5JjVR7NJp+0sThVWv7DseBpWDMAhELIpw36wk6qSSW7gFPPNvmbBjDdQVtG1v
 ayd7+WjrFM4GG/gGXGrUgPBk5DV1JdM7YeV3HiyRnfT4TTIE9gHvrl0ZRqY5fgWBRlUg2jQw0B6
 d1j9PMBae59KZe91insm39nWPIbJm
X-Received: by 2002:a05:690c:4f8e:10b0:826:9576:a284 with SMTP id
 00721157ae682-8269576b0aamr77251437b3.4.1786375912183; Mon, 10 Aug 2026
 08:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260713073033.3883619-1-kchiu@axiado.com>
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 16:31:39 +0100
X-Gm-Features: AUfX_mwWIK0FmzW5i-dr3j1J-nDdKoQk6PinVSqDYtdSqsrhgRSMvnwV_IHKAMg
Message-ID: <CAFEAcA_=DVVwQYdpwnhbzF_GwR9gZp4sJa-C97caA0i7zofADA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 13 Jul 2026 at 08:31, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> The model for Axiado SoC AX3000 supports
>   4 Cortex-A53 CPUs
>   Arm Generic Interrupt Controller v3
>   4 Cadence UARTs
>   1 SDHCI controller with PHY
>   8 Cadence GPIOs

Thanks; I've applied this to target-arm.next ready for when
the tree reopens for 11.2.

I made a couple of minor fixes to save you doing another respin:

(1) you can't use %lx in logging printf format strings for printing
a variable of type 'hwaddr' (it isn't a "long" on all hosts, and
this won't compile on some systems) -- you need HWADDR_PRIx . I
fixed some cases of this in patches 2 and 4.

(2) we don't require the "<public>" and "<private>" marker comments
any more, so I removed them from patch 7.

-- PMM

