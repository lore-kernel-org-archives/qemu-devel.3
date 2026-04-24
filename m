Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005BFFED3D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIv5-0004AJ-Pn; Fri, 24 Apr 2026 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGIuz-000485-5B
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:58:14 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGIux-0003s2-5H
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:58:12 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651c366f7efso8416665d50.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777046290; cv=none;
 d=google.com; s=arc-20240605;
 b=iCD2EezLDCi0bC3t521OiyXixxGDl+SzJXMWJLXNCCsXQcYdvJwSH0cY6vNLBWjh5f
 WSWB8ocShPhjcGPeMYNuuuz47dCUhyxtdnL4xhrxQZGmxy1xBIAU2PR94weOnp91sGlC
 ePH2o6uhs0KDSUH3PeRLbSDuZATp/jGq45HNHt3jG1o1ddGTb9dhqstV4H/iGHPaNJKf
 c4n1Czm+N7qZSf3Bm21Fp9a2wP83WBR1ZuRA6XV6bpQAuRZMWl56wT37zalkr+F+TCYm
 r8aIangCI0gkGdy3ShhMftuxovNlBWM2za0cKclkBmFcVQIFEvMOA5zTlNHUoEtxIGGi
 wLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3fHju/rywQ2hs+X8YMVNSxO/PxQfzdwsy2MTviTNEoU=;
 fh=2MUhVyPoVVGVao366UdC72zH6OhfSgCBy1rS/0kzkqo=;
 b=j4AgciTKnlF13w3r64BtVtV1S6p0jHNepDWyuGv882TBDn7K6ERRpQdnr3hWu8Wf7M
 G1c6rIGP846ZZGTrsMXMI5bEjz9Zui8psBJ8kCjapxnhNGetyYszfE53oPIGNsXpE2qB
 HPNq8kybLrS8qSvZX96dlF3YmABzfELYCiptAezZveKhhJw9aWp1x4jtp/QeJN6Lrgrp
 hT5/9GQhi1MmSsUrZB83Hkx79MDQF58iRfmYjECRk+OYnwB2JnLgVeSYm1KN9si5yNRx
 hnOy5MAXm1g9/KKzBoDpJs875C9ip0U3HDziKftnU9IhDt8ZZxJJAr4Zqfd6WBlZPj2n
 DcLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777046290; x=1777651090; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3fHju/rywQ2hs+X8YMVNSxO/PxQfzdwsy2MTviTNEoU=;
 b=PPTv2b9FJQVmM14jkae6k1099h/cCI9EZjK5A1p+qnX9+Z3V0Y5Bzj2F6gP/M8Agdp
 wI5v4i8wDj/el29BVvf03v0W47Jr7a9rK9/RXGtS7ESx0UCaGqxFrxYLGr80et1UuEJV
 rTECV8aMHqXrxw8lx4+7eRTvucDaWuNw26P1Bj/qyUh77t858crGVex6nQ47smUrDEEL
 mm/016yqAoLJRr0UY9/STUqARpDlMBL2eobcYRjrrSB+xuDC9ytd5V+8XohyIFV08/Hv
 842tRte1mh+Yy1CLDujUd3Q01A299nUorNvb3vvnXGCHd+r30zjnRDI3Np5QGL+iHS60
 x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777046290; x=1777651090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fHju/rywQ2hs+X8YMVNSxO/PxQfzdwsy2MTviTNEoU=;
 b=owhSdFoxTSH60CE9vUtYhK/QSogC+K/HBVm7waf9F7N3gvDJE9DiKYMS4EwpCOzc5K
 Zho5WN2phC37WgFf6Y7AOHORRqD0vhbnHqju9p9AGQgfREhd4zNLJ6vLvS0JwdMoVXM9
 u1QKFcXtk9xGWVHGBcTjEpZ6EBgO/bR2q/YBQYMFpqBsh9kalWGSXEI1PcqKW3gOBrN/
 oop4rTmq6fDjkqLattqodR5vK+w/CU5r5Es6JxEGvm+JYkMt3BvRcGoDFC1gr+bu9L/s
 wTelQZ4UZJqVBRgprsZmsMkAbtpeFp5msk791p5nZrt+qVZdddXy+yhsbd2iV15VULyB
 LapQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YyNoXvb8Q8MVXzoVBoqoUSPEMfX110zAP0aPCQBVM94iHczgaQ//UX/1Hjlt6ZBct9D0euuI/GKnk@nongnu.org
X-Gm-Message-State: AOJu0YzSlwHUu7FDngZ5YiqUsDw/XnFL1EUia0cfTDaGBhThQPu97rL8
 K0FZG+DU+wF5xzPILRPsAxfEq8yD4SuXN7/0WQhqGcq0Ps+cT29PCKktZJHK0QlcCTuHjuYZSHa
 rWEseBHkhkP9dA0iQu3OypGvmxmItwBZB3tRSqka7XQ==
X-Gm-Gg: AeBDiethIFi/BVxsnNf91zymtTPiiko1Od8pmB0FmiPrnJVa3JBPDjsE/fK3Epgxbl5
 QKRZ3WJj8GofVMozw6xuwP2gQc0A02Croy4hsN3CVljn5VOITd74qtP9intpw2iDSo3OVTNoIL4
 nVryCu4KSfGvhvQmVf7NzJt+1vVoiY0JHT6Zy7ftbPZaD5XlSxA5O3Fw92hbEoTzbH1cyn3NgIC
 SoksmbpCMTj4hfXRPzdkVnrhFF57cT+IUUxMqIyuEt2eoDOE/nloSpSbSG6wNN8Ty4iLV0CgRbu
 RMCXQ3HtUZ3YGfQ9gkXvDtXi2skikN6LwODC8RJ/ThGg5/XTvOH73zXkY7o9BgpTRUmNq731uX3
 K/A==
X-Received: by 2002:a05:690e:147:b0:64e:a969:fd10 with SMTP id
 956f58d0204a3-65310a1267cmr22256650d50.32.1777046289835; Fri, 24 Apr 2026
 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-3-clg@redhat.com>
 <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
In-Reply-To: <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 16:57:58 +0100
X-Gm-Features: AQROBzASYHS4sX9SZcWEReuIrVmVYyHkHdzbas_s41zzQbTB_SNmUaovveuP4H8
Message-ID: <CAFEAcA8nyngyeWi4Vb=ZWJfxNsyFfSqFJMnWnYG2ce95xaCfPA@mail.gmail.com>
Subject: Re: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Kane-Chen-AS <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 24 Apr 2026 at 16:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> But here in the prog path, we use the address from the guest
> directly in the call to address_space_write. This means that the
> address the MemoryRegion in the OTP device sees is not necessarily
> 4 aligned, and that it can have values that exceed the valid
> size of the OTP.
>
> The OTP device on the other end seems to try to account for
> this difference: its read function uses the offset it is
> passed as-is, whereas its write function uses
> "otp_offset = otp_addr << 2" to convert the offset into a
> byte offset before using it as an array index etc. But the
> write function doesn't check whether it's got an overlarge
> value, so I think it can write off the end of the storage.

I found a repro which triggers a clang asan failure, so
I filed a bug:

https://gitlab.com/qemu-project/qemu/-/work_items/3436

Would you mind having a look at it?

thanks
-- PMM

