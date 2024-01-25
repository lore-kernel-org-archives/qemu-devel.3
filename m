Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1146EC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 15:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT1OV-0007VN-PJ; Thu, 25 Jan 2024 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1OT-0007Us-8X
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:11:53 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1OR-0003WD-Jw
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:11:53 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a50649ff6so7565658a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706195510; x=1706800310; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s89qc2IuPrmSVnfyJ6Cc0sT6CMYQNYh9BN1AJpZVRCs=;
 b=Wtfma48iFGDehv5gt7LWqRdLd+MhnW7RaqC6IatbYZQkLVA5u13HgJIE2Mps+3iQOZ
 19A369Pb/bZ9Zm2sIiXRMd68qEmeaJZuZ8sPtHRcvIhggUXULQDy2yAsVNkNiREZU53k
 nYKdUzSkuBSjrCREGuOgRG8S+HHh3UYK3e1zzZwp+Ir9cdEoIxt0Luw4Na1B/EJGqFvh
 bMmF9ffQ6/d+54JsrjVPMQTfxFwag9S7cmg8qHhKLxVHvEyIgSJVf9ajxmQn3HgJM8xA
 QOqaGM4OocXtMuOEBbcf41y2YqE9myifbqeGM+SATZAHHzhd5hbrcoJaq48eDa5AOi8Z
 0/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706195510; x=1706800310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s89qc2IuPrmSVnfyJ6Cc0sT6CMYQNYh9BN1AJpZVRCs=;
 b=HMo0LEkzNIgtN5H0L0SjxEu0ZpjOI8Grk474ELKxjeXYpI+nLV5XbkLgGtkTLXegWb
 f/ZMZu6eq/h3RFTi5zl5zUGgPg46SBZg1gHypEKkqqmuAKDKGzUJZJIA/PyZNVPnrSzc
 yoz8PGQjnWAcP6TVqkwudwWrCh0VQovW8AY8wCBgA8g48vXGcKFZ/w2GenVxd6Sws+Rn
 m6qr3SfH1Mv7KUhNjSCDc9fCM4bYaq+u0rumGhiyh5VL/U9yJuFmOlf8HIajV3uK+3K4
 NuEtlQj/Q+DMDErVzWe6C0nTeiqFvBpZx1VNUaAn0cSXd1tinhDgSuIDOhx8tDG/+epm
 oZ1Q==
X-Gm-Message-State: AOJu0YzfUAJNjv9hT/DGk9e1Uzk00KtohrKp3ahyiipf9GpKZ9zVjJlh
 fuVZfkGd/lNGXCuKT8vhqFA+9MO7Ez3/omo8lmGUCE6moV/wa3hMAoxe5mrYkPXh6vuk5SZS0Rs
 MlITW5l+7bQXrrNp6UsDLqBBQuS2ganYOtPRX3w==
X-Google-Smtp-Source: AGHT+IFsNDmDiIWUVlAFABYJsJH/ZMV6Q84Wvzfa63SAt6tgoTbxUAfkwgi101bGP/2QLEHdlIuyeI5FMnC6f53ykoo=
X-Received: by 2002:a05:6402:1a2c:b0:55c:c66c:271d with SMTP id
 be12-20020a0564021a2c00b0055cc66c271dmr673303edb.17.1706195510238; Thu, 25
 Jan 2024 07:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20240123102412.4569-1-richard.henderson@linaro.org>
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 15:11:39 +0000
Message-ID: <CAFEAcA_LzB3gGw1Z4aMa_LW3UdS0QGOjL7+TbHCAMVf-k3rgqA@mail.gmail.com>
Subject: Re: [PULL v2 0/8] tcg pach queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 23 Jan 2024 at 10:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Dropped s390x test case, which gets mis-compiled with
> some cross-compiler.  Add tcg/arm fix.
>
>
> r~
>
>
> The following changes since commit 09be34717190c1620f0c6e5c8765b8da354aeb4b:
>
>   Merge tag 'pull-request-2024-01-19' of https://gitlab.com/thuth/qemu into staging (2024-01-20 17:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240123
>
> for you to fetch changes up to 9f6523e8e4689cafdbed7c10b7cf7c775b5a607b:
>
>   tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct (2024-01-23 13:32:10 +1000)
>
> ----------------------------------------------------------------
> tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
> tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
> tcg: Clean up error paths in alloc_code_gen_buffer_splitwx_memfd
> linux-user/riscv: Adjust vdso signal frame cfa offsets
> linux-user: Fixed cpu restore with pc 0 on SIGBUS
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

