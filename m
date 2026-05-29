Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FAECD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy2d-000164-VM; Fri, 29 May 2026 10:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSy2c-00014n-4N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:18:26 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSy2a-0006ZV-19
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:18:25 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so2101854866b.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780064301; cv=none;
 d=google.com; s=arc-20240605;
 b=gvY/u4syRt7xOKP+iU7Pu7BeH1sXNui7p/JgM1kVY1PjgA6uL6n+ATYjtE++ToGaGW
 oIskMsBTZ1sWRvTvaOBzyZHii620x8RxLDBjq7C81XcI2N8KGMLLUDoiznj+4sa0rCVu
 U5k3zzWydQ7oUex7EmXxUWcpx0JogSEgXYRDJ/9su0uMrpugZOAeN0O+7r/qgfoSc94I
 NXaeFuKdD9rC9attH0kXfzqtF78a0zeW4WnMUgxHPTfk+3yet0HHUO14/AiAa3/6jzJj
 FBAWVHoHBAJF5P5cnD1jF8YnEVIdSaSRLcHc+Q3nxqAg3mmX3XKhj+iilFvmflFhbYOe
 +HSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L034eyAS3knVaCPHojkItpR8TRjlkNLEyF5wzuzwJkE=;
 fh=xXUECa7x/m9222uVR6doJyAafWA+wMRf05AlemDJ3Gc=;
 b=hmvNq6EDn/51upPo5NjAgFqJ3DxbAT0szX8KdbfXLuIYOKJSgD9jG24ykk1FTafA4D
 Nez3zPhaY+rMxirUKoSS9J23PHK9VHX0LPVpRNwZeKqeTxCKOtSEzhjmeWD/xYllpmKp
 KSEgr+IAzYNrwiqtmky76KdasA20qqyabuHs1iSAzhicRZS2A59qmL35VNlWtg2BTcwK
 Qy9W7Kb781jnFKhV1yDJTidXjrsevrZtqxwAQABW8KxtYr2/fjtPoqprhQijzUqaqhn3
 8CXIdUz27GzJ/IS7yPRk9HxT2F42hBlfAM60FuihZGiJsBXFuDhPgitvK+WI1ulj5LMm
 W/3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064301; x=1780669101; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L034eyAS3knVaCPHojkItpR8TRjlkNLEyF5wzuzwJkE=;
 b=kdZK4yja4FxYPeVx7jHPBNIDzXBbaweatVL/3sGSF+e8tYYOhfOMqmFS4jYMKW65vz
 11Y6pR5fD+iT5qN//V7dPsxXdpPqjuWeu134W8kMhCRGLD6jQZwNnVyRvfZw+9HyVb8M
 AK4imiV+BKtiqkHvy3j5t0oODA4wfu6LY/OxQXVoVYRInjGqkjk9Bh3c9YxQscXAg1FI
 sTx0+dGbu5KULZD99KmkavFKKzOOVNY1s39Sx9wyk3gVPGjqnk5Dq6d+xy4AbCehvpKU
 GiQVwPPh/GKJmcHPymkx7kDktmNmxE6vKsKT+bQHPdI4iSBMfoofEiCfYFfEW5eY1rsG
 zhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064301; x=1780669101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L034eyAS3knVaCPHojkItpR8TRjlkNLEyF5wzuzwJkE=;
 b=oebHQIZ/l0SkCcOoZuOF4Smb2Xsar1O/H3/ryFdIOO3c2eGJBi1ayC9+PDC3ZyWzqZ
 tYg3EqjANQHwZ9xUUxPHGsSGIvqFL62yJf8WK9y+6BSXGPxMeHSNm5v2cdUiOvsoCGlU
 9Pn339cd6la1iBtXmNkfIThAcMeIcQWZ+DF1dj62vq2aE5kAvwBz+D5zJ0RVg4ZEnAD4
 jijLmiKIENPFkHUSNjdyXt+54jAOtmmv4bXnz1ROeHDS7+0FE1o4ofGRe27NxPR8aqUG
 6/yvDjbOjcEMEiy2bh9+ZCe8V0tLMWIlmpIUbl/spUnp6VAFwBWeuV1KvEBnuEw2Ahdg
 HCPg==
X-Gm-Message-State: AOJu0YxP8qjbnUddTjofwDxL3rmhr1fzrOBZ3ibUS8L/0rHx8ITgAM36
 Wri/3qmD48qoUJizOkJcXR+i0X8wmo3xY9ugmdsIK1Id4tO5xgsuw7LwM3nz1w90bjoPDE9jPKX
 Pf7B/zNQGZUAvpkcrgqTvmzZQKDOJfjxHISY1iCH0qA==
X-Gm-Gg: Acq92OHL/16MfxjboxlEG0YDbdLVXNdfIsbMGxywfGHcOQIzrxTZnxfGE4JnXuNTfFj
 zcC5xz5kG1IweyzAP2d6+bYvI2mMzSyR/yQGauVT5TJ+BEw4m1amy9Bv5EUnURuhawt31P9aQGh
 rduf7halRz4w7ymS6bsXv5MwX3GYe878aEJs5b6t/AsX+ULpbArWSVtLtdjzZY/P2ye5gS5IIV9
 RwT/EYRLCYIcH/QOCV/hDK+uz5jhmZL1cuI4KRrGI8K+4eUt8mw+Y/eFeQtZqYBeq8yVkXuwumP
 iLE3DATDF57TxeBWQdS2TJa/3iEPyxHesa5RJYseFkjAoYjTWqb4GqQqpgoS27lOWYgJhobbrVs
 vukV8stZxmWGT
X-Received: by 2002:a17:907:7b9d:b0:bd5:bfb:397e with SMTP id
 a640c23a62f3a-be9cce776c8mr198046466b.9.1780064301369; Fri, 29 May 2026
 07:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <rxuL-6ZdTjc0-X6Ez2rU4TPEObWUUb4HjRf6X2__bLs3i-9N2d5NX3HbQK2Zyrh5V2c1szltCX91cL-s-WHxX1XoBDSyx5_m6FCvmBmblIY=@proton.me>
 <ad4b1u-MEfso3miW@redhat.com>
 <0NssTF_XyAbzwx4DB1ecmeaWsoqoRMwGSrf6SCVUaBsAR3aN_FinUY8ucoU3PrTya2Jdf09HrEMWR9mwdFI0HW_ZF6SBe6gi6aIgrVpZd3g=@proton.me>
In-Reply-To: <0NssTF_XyAbzwx4DB1ecmeaWsoqoRMwGSrf6SCVUaBsAR3aN_FinUY8ucoU3PrTya2Jdf09HrEMWR9mwdFI0HW_ZF6SBe6gi6aIgrVpZd3g=@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 15:18:08 +0100
X-Gm-Features: AVHnY4Iqi6rXWFqKxoI84ChWny4UZKG1WulfKtzPU8frabwWsagKFVfLT7n1bPQ
Message-ID: <CAFEAcA-BW-W0tD=_Cy6AR-E637h_Ryo0JBTHTzXqB3o3f71Rxg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 15 Apr 2026 at 05:08, Feifan Qian <bea1e@proton.me> wrote:
>
> The TX Frame Control Block (FCB) is prepended to a TX frame when
> BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
> fields that process_tx_fcb() uses to locate L3/L4 headers within
> the frame buffer:
>
>   l3_header_offset = FCB byte 3 (0..255)
>   l4_header_offset = FCB byte 2 (0..255)
>
> These offsets are applied without any bounds check. When the
> UDP-no-CTU branch is taken, the function writes zero to
> l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
> write target is:
>
>   tx_buffer + 8 + 255 + 255 + 6/7 = tx_buffer + 525
>
> A malicious guest can therefore corrupt up to 509 bytes of heap
> memory beyond a minimally-sized (16 B) TX frame.
>
> Fix: reject the frame and log a guest error when the minimum
> required buffer length
>
>   8 (FCB) + l3_header_offset + l4_header_offset + 8
>
> exceeds tx_buffer_len. Move the l3_header and l4_header pointer
> declarations past the new guard so that out-of-bounds pointers
> are never materialised.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Feifan Qian <bea1e@proton.me>

This bug just got re-found by somebody recently, so:

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3517

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Jason, are you going to pick this one up, or one of the PPC
folks? (I found it didn't quite apply cleanly for some reason,
but I don't know why as that file hasn't changed in ages.)

thanks
-- PMM

