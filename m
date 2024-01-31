Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC74EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVADk-00045j-8M; Wed, 31 Jan 2024 08:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVADa-0003yE-EB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:01:32 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVADY-0001kw-Bf
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:01:29 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55f15762840so3262444a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 05:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706706083; x=1707310883; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mTDbCgLg1TvA38YsJrW2PZsvTSvfSNldlqZiOf1PCxU=;
 b=aeFctrtuNgSYdJydNi8yMcHAikW6n4LEx572e/Ag/ztIN+yX4YUyyrzrzP7ZVp9XZ4
 gRP8zt3KNw66zvx/vATLUtqlaExCmKzi5S4Rv1iSxhtVXf9fYelGeUYQ4q3+5hs1urwC
 xgmp2wfxgw+O0Lw7ibPAMZ5zUYf1dFzcl2vj1QOhLyyvphN3aRzgIL8yKa6GSu7JFfGC
 5g0UwbbS2tfRIHZICTymjpRu3cF4i740W0DwJd66mNXIF5lm+GUMunrnxVd/MNdEr2zc
 u1qht7CdAacBfiv3CCyiT/cFkHEAbXWaJNt6tp2d5YZFHUiVf2cSRnD+BvBq0FR8CFGG
 b5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706706083; x=1707310883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTDbCgLg1TvA38YsJrW2PZsvTSvfSNldlqZiOf1PCxU=;
 b=vjTfSbzVlJt4xK1mF92fffU4WVp/voVEZfPgL4LgH4jgXJhP1uffdBaHENVHs2eerf
 9WM66k27pNXPO5gqf4TQsWAFPcNTydKfJuqOPrcQ2KgZh4Ozn9zSIIWmkcBu8tpSsNGv
 dWDpbD4+iDflskbfqNqo1QbMO0NzbRvELQvf9ODK5rlCRT3ABuKtKyP64L1mzdYgR0+P
 sbIQa7/Rd1CbM+IWSsigzldpCY/O6I+dhoRdnb3k/R2SQTnyIGVzcGg9vJQJY/b18bzq
 N/D0gAbJxZ/hEfREDD8C0Qf1xPZ8aarazOCySWpaO0dPX5lFbUEa8Ik5iC3ziXOJBZvr
 XwkA==
X-Gm-Message-State: AOJu0YzcGIbYa0fCEcu2TSTox60gX95/RJTgsOhlMxgBkKMr5+5VvVUr
 W5sUewWyQMn0sPK0ySHGjyU5Gk5879A4WUNvbVDel9ihHpmmpSR84ZDuiuz8EHnnL1Wi7ETRfWE
 ehlk+NGSbrQqe4XYTWrV0AGGPP0hfXnt7a9mEEo1uPGvktURG
X-Google-Smtp-Source: AGHT+IHoTKZtmlQBT2ncOHzIQOmF50uw73dqlGl0ntRpC1bK/cDGQiEGk9LuLfW3z+aWXEGhj6TRp0SwFI52aYrQ4ZY=
X-Received: by 2002:aa7:c0cf:0:b0:55e:aca4:aab2 with SMTP id
 j15-20020aa7c0cf000000b0055eaca4aab2mr1090282edp.19.1706706083338; Wed, 31
 Jan 2024 05:01:23 -0800 (PST)
MIME-Version: 1.0
References: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
In-Reply-To: <8e838817-8b55-4275-a199-0562216d2d1d@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2024 13:00:53 +0000
Message-ID: <CAFEAcA_qxALhqHgd0zO6v6ufTaHvmiyyHuCDcHZdxRvbh+x_Hg@mail.gmail.com>
Subject: Re: why various devices are loading x86 roms on non-x86 architectures?
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 Jan 2024 at 10:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
> qemu-system-aarch64 -device virtio-vga
>
> this one loads vgabios-virtio.bin.  Why?
> Does this bios work on aarch64 (or any other non-x86 arch)?
> Should there may be some conditional in this and similar places?
> The same is true for x86 pxe roms and other x86-only roms.

For the same reason that if you plug a PCI card with an
x86 BIOS ROM on it into a non-x86 system with a PCI bus,
the x86 code is still on the ROM, even if it's never
executed :-) Mostly the ROM is ignored and the guest kernel
drives the hardware directly without it.

For stuff we control like virtio-vga it would probably be
helpful to be able to drop the requirement for the binary
blob, just as a practical convenience for users.

thanks
-- PMM

