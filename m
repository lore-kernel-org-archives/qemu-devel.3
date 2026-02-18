Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0902BE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmoB-0001yz-1R; Wed, 18 Feb 2026 14:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmo9-0001yc-45
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:01:57 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmo6-0005xu-V4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:01:56 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-797d509a2f5so2186387b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 11:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441313; cv=none;
 d=google.com; s=arc-20240605;
 b=ObBaEIjQY8wu+WZ+cPI5Z5gxwj32Zh+Rb0WS8MFuVZoNmn3mFoXoIEBpaQcRTwvhzs
 tTjpmaibvdSR9sW5CXEEi46md2Rd3+5ORhbTD3KoPlXjAql7NY8RAYlF/qe9bnba0GHx
 i6/ZZ9LLwrY+mtsA9fe9/wO31MRuPtT9n4E6SuGPaPKo1+FR0M45fKfjQlfWvjiI7S0K
 M6XgHiM1dDm/pqy6gTTS/++j2zfueso1lldvWFKWUPlR82VTuKnA+YkljtZRJezFUl1u
 awehsR0sZGsnx0TiM/ibi8u1kqkgxDIztulO9Esp/O+4ztFIdBp03WTretmM/96gYbQr
 C3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iRQW58jUjd7vqT9HNmwPUqH/1MRqYRFTjLXvnPOklEI=;
 fh=EW9hBPmu06DRmAd6hMxBcpY5XawM6U88N8rDhpCGN1w=;
 b=F0fP4Fra3WnBejnZbw6qrfi0JuqBzieBo5ZY3FdNbtj5XyWp8QjyxU30AbHWsyxZ6G
 FQJ6beXnN/srzxmIcbRMz8R3nxP5NiQJcbmLaSEVqWCz3NBvSC3/V2QotvoJyKzb+nt8
 WljgrxGYnpxqzWe9XLq9mqNR2N1tkRMCWcccl47xLjoSHNX7YsR6WBsFU6t4Ks8IF3c/
 vm4Nh4x0TVPy9cHG+ch/1fvTfs6MGg40A1Jb/3jiUX6YreRX0JsTRMAFgS9GJxjr731W
 cUYqATNwlgozPqjIb9l2iBMseA1I22qqSkUXtAeVYWf6PgHzFwGlz4NDf63+Mc5aOOam
 kU1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771441313; x=1772046113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iRQW58jUjd7vqT9HNmwPUqH/1MRqYRFTjLXvnPOklEI=;
 b=UeR4HWmIBx7hvWZ52Q23m2ApLRk3WpNt9aPl2OgZAIqpXMHIG6DCEEVI7rrZCf9lPc
 1OBHwfLO2OryjEb6CqvpaU+5G0Fd5ioC9BUn6vOP2qr8yObqhN1RGErWjSZdK/QY5fze
 NcC6I60Bwd2pf1i1NHi/k2iHMEEmk5mFFiP+I11EzwdSIu4U4I+rZYLUhRtmOFVe5Fqj
 2fuTSpT8v8a4KWPSVQyc7xJpUxT3ymgmy7SltEiqYZDJIPFAJkL8HP8pHClX9yDHHvDL
 iKGNttUn+itA2clAO5Y2d+IPGOTlNnjnQ8N6iMRzkwBU/Brt/hPflmp+6Tgo404vSnxh
 w9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771441313; x=1772046113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRQW58jUjd7vqT9HNmwPUqH/1MRqYRFTjLXvnPOklEI=;
 b=IzL7OhKqnrXgdNPLkIVnqSoVqGOl9od2XI0yVnOM8kLszXx2m80e2NuZB/1z2GdMSB
 zJ5CZyiMt66HVhK+VtOmmDIerzVG1UH7Qa4B5YJC9NQKNuJZijEkL59v6c5xhgDllJTR
 sTv/vHN5ZtgQaj486t9v1Ib3E8FVEI4cxKKS959yP/YJZXmoAF6GEeKk5diExXo2sWq3
 0e1G8xjlNmPWmvYGldXjShV9cmz0tXknakm2xLlw6zx3XQkiw7M+ndj4TEttDNjs61U6
 qlIhryigo4L7/nPdO2VW+qun43zg6zuWCRTAZgQDsd5PwSLBJVMWl5WgB/sl7j1KvWGb
 linw==
X-Gm-Message-State: AOJu0Ywdn7mByd9TLdr34dDou6AqRg5p2iOzMLpBpgTU2fkl1OvK/Syh
 BSRNOF8B5JPTeaAOPVFEIxenR80G11e7W0Ugd9g2cUTNiS6BF7w6GmpDRq9XclfIHVnvV7RdsY9
 PEJHiLZMSpAi666K1zKjhg6UXU/zLNxS/8omkmKquBw==
X-Gm-Gg: AZuq6aLHwZiPwIBJ73RMgMuukJ4PdglyIoYxgDAXMC9qnu8xi5pIRTyHOhRaA9wBtv2
 ZvqiivX/WrOYCW+rMiBaSOQHFz639dFrI6Auyi2kLb7UsKVmtiiGrgtoX7fsZEh9RTAs3k1EgLh
 Eb3JhJkAD0jVSMZJIcAGFQVtcdmTqTKJ22h4jzYJWjh4T7sPf5L3BTCFuzBsbBMbzh+nLTX44dJ
 4/hWLXYurhOxfvN1+rcNESy+A8lZ1pWG1qhjmC53KL62ew7699zppJ8FL7c9+ZB/se51IqlQQtM
 EaS8QBaROPAweFTj6YR1vlR4xJkhQl3Oxh3AibEctH9Wa9CZNPfHCzRo2a2mWtAI+y3pO8lo6zE
 iAA==
X-Received: by 2002:a05:690e:128b:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64c55572233mr1785674d50.20.1771441311307; Wed, 18 Feb 2026
 11:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
In-Reply-To: <20260211122759.125094-1-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 19:01:38 +0000
X-Gm-Features: AZwV_Qh5_c586UujLxy3iUnKdj9MHyuEGviGeKU4tVsmoNrMoXW92DIAY7ZL_SE
Message-ID: <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, cohuck@redhat.com, eric.auger@redhat.com, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 11 Feb 2026 at 12:28, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> tables even when no backend is attached. This causes "Unknown
> devices" (ACPI\LNRO0005) to appear in Device Manager.
>
> Until Windows fixes that by supporting, adding a new machine
> property 'virtio-transports' to control the number of
> virtio-mmio transports instantiated. The default remains
> NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> Setting it to 0 allows users to disable virtio-mmio entirely.
>
> Usage: -machine virt,virtio-transports=0
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>

Applied to target-arm.next, thanks -- but please could you check
up with the ACPI spec about whether it says anything about what
to report for empty transports? If it says we should or if it's
just vague we should probably match the x86 microvm behaviour
of not showing empty transports, since they can never be
hotplugged after startup. (This might need to be tied to
a machine-version, not sure.) Maybe we should also not report
them in the dtb?

thanks
-- PMM

