Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0540210F3DE3
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 10:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6RA9-0001Ba-Np; Sat, 28 Mar 2026 06:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6RA8-00017h-D2
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 06:45:04 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6RA6-0000L5-TO
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 06:45:04 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64fc6b21789so2203708d50.3
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 03:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774694701; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/ewwiFTTHtHOmjzPUnUD8Tro0OfH+xjV/ZO1ZZzEZDu38L/7JCS4GVPNMAGBM99kz
 HYjyZMp5Cyuw1RAtgEiwj6saJON+G0OylXPyl6fqjjChkb2AvafnJH2eBN+tvIBkzdR7
 C7qjoPQDt3dQFnPh3SMlc1JXMpT9qHlazB6gMcL230oCtp4TH01aFfNE0Ddv+E4Avpku
 9P/XIARQT+vgExUDirXT6EBNfWAP1PBzDw0xYrqVUseKcznPaB+DN68lwMxvdld++1mL
 NtRl0MX8oY5vUo/oTBMuYLG06XRMet6xKq55hzzlefH3y54z8qIeYvcKKmAhJVTSv2ie
 H2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y0jvTgUwG1awVyECYlbFaK8wuV2RmtvNy8DZCijlPgs=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=Yu4JatFgUcMYitXXKB6dDijXjdTMj49Iinzk6nzpU+neE09mPNvWLLIilC9Vod4wP8
 +wDX66eyDZIuoDJptiOdsY+zpC0of/FYqxzuiAs9W/GE5+xvfVCdRi4VcQ8npKDRppXr
 L4Sr6/kQT18fPTSXwtzTrzuUfVEXRFFdWhN2YciCJEOyBNrF4/2HLxZMCLwdgmXOmsRB
 uBR0LHjuPB2/75J1feQx49MRTMWGhcGVfQMx1PAT+m0sowTx7BvL1NNnwX94ecsKGJ04
 UZVyaOJKBnzFjNDT0n/Q1Rr1dnQMD2Bqkusdg27qQZTfqrUJNOJKByYB7N7DiuAjYLh+
 5UVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774694701; x=1775299501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0jvTgUwG1awVyECYlbFaK8wuV2RmtvNy8DZCijlPgs=;
 b=TlSfVERqglvV9mhvntWcJSzVMJNyxKz3c2JiJT1fIvsTotTJlh6Dsn7T0TFZpFHepU
 ow64cfMC9AmNZJnVcTdAnxTao0CK832t71Dm5DsxZbAROb6cYTCy3QfRjVhypfxBcWtu
 4rSChxiJVA6Us4SOBY/xYJGMd+aWeF1jiOX8RPV1/iFU2vQf706w/AZNHUoTBBFmPQuO
 h7MjsRydta8ElNQVO8qhs+dyqqqP6ngRs93YsZTQJPOk9ZZ5NoEFnSyRyAC20t+KEAOr
 JFuTXsl1pIbF3v9VffRJFaTzOuRASNd/EFqlCw2GpcqfZQqbnUvM+Fc73fVi5eKier3z
 4vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774694701; x=1775299501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0jvTgUwG1awVyECYlbFaK8wuV2RmtvNy8DZCijlPgs=;
 b=Qh8q5ofF4jSZ/zWYOTiV4DWR4l9SnxLXfL2SSor+86wfFMg2HJn7Q/wfoP+GNWPJLR
 iDEMQFvl3uOW5K6hCp4wEwEXdlT9n8cIB1IU1vJcSw7LbVaCeRj/3P5swGV3IivooJPq
 j21qhXrcVXQ8hcrENw0o/rk+y6zm5l+1UCsY+1hAzMZG9dqzMq4zMtY1pypJlF2jbwVi
 4JvIsdg+3GuORM1HuaC3xsT7xXu+olqm5K75O98AkBbkjhB3HD2BAcV4xqArzARE625c
 PIsL7uI9sGocYRU8LS0WR51qfRbySOt30b/npjKoHchSrHCnF2LGtusUGYl2XMMFpxd1
 65KA==
X-Gm-Message-State: AOJu0YzmRo/r74BvZ9l32XqNtwBJGYRgbv9Bq91NORf9q4evdaHufmr/
 xqp4yZxrxGlTfsOO/ZIGIfM44GXFOp20Slw9ENAHkOmKWMvjpXSUuSzWi5g3J95tZh2/jkauuIE
 KtR/2ju7ix8usiMmrTHLfcVq1OiRgMz1mMACfCftoZA==
X-Gm-Gg: ATEYQzyxdZaD662QroEHI4fnDPylP1q8z6wyCJqHeDMoBaWauFjwL/WsMnk8RwZAFHP
 hMMN1iIV/DCjkO01y/9Ai1h91yYlUa7w1mbMQWAINfPVyw2G0IndapRecnfAEdbhk9nEozfiMjW
 j2Q0crdJK2XIW1ywzsKUA6Q1IyVjq4LgLbPifF0hvUFmFwLx0b4mwckKf1kXxJlPkpCid0k0XhE
 40Vng+l+qjRgpwdvIsoJJTkN9aRZa4cdOgTeaT6dmhZ9whJObudUMfWGfrKyS0gE10gNixgsQDx
 3ZU2X+y7/nPKduQcArkHxCSvSv0pA7YNY18FHvQmJFgMOhpovV6Bm/9RTPZ/MefUPJE=
X-Received: by 2002:a53:ac88:0:b0:64e:def1:31c7 with SMTP id
 956f58d0204a3-64ff7466580mr5881180d50.73.1774694701540; Sat, 28 Mar 2026
 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260327204704.424158-1-pbonzini@redhat.com>
In-Reply-To: <20260327204704.424158-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Mar 2026 10:44:50 +0000
X-Gm-Features: AQROBzDAyVeUDNgnxfDqpuboXWxOJU4luavvmS7tB6G8uw0L3y5RZ9Xji7Tez9M
Message-ID: <CAFEAcA_2bBZNg7FW8L8Z8h_GZ_10Dm5qRQjtoMUHczr9jTcP=g@mail.gmail.com>
Subject: Re: [PATCH] hpet: lower HPET_MAX_TIMERS to 24
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 27 Mar 2026 at 20:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Each timer block occupies 32 bytes, but they only start at
> offset 256 of the 1024-byte MMIO register space.  Therefore
> the correct limit for HPET_MAX_TIMERS is 24, not 32.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/timer/hpet.h          | 2 +-
>  rust/hw/timer/hpet/src/device.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

