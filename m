Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6DFFED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIk8-00013G-Ff; Fri, 24 Apr 2026 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGIjS-0000om-8U
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:46:20 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGIjP-0000CC-DP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:46:17 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651bc83e74aso6701502d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777045573; cv=none;
 d=google.com; s=arc-20240605;
 b=ej2Wh909m+UMgKD74oWICpVudHwA0gAnoJmwoKGCiCrPa9UlVzXIxcGTrh1l7uZMUo
 6gKdpJ36LDqxGGtfEuU/vFNTT/is6XJZQALnuskWYKW9A92T05n+nbcR121Xut5UVpIm
 ikoVkMR4p0F0iLYgmWDKhwxaA5BKZw0SIrCmXD+/h+zSgj0Yyjndt/hDcxQ1A14AYJIX
 Elxf7jwYjpkuuxGRL5Avo2ZZnDYnBUgN2nhJVQbOy4c94Si8Ew80YMtbtjefGX97MpuZ
 cvDynC1c1zcXcpeqUY4ROgJ+N9KBx86o83hI88iPNmLqJ0ON3S97IR6inXuxyQkBWhV0
 8rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2cwi7wIQXzCJrOOFdS9mM1CUc5W4Lf0OpCdD9x4zH/E=;
 fh=zaf6uXpW4q4keUOIaKh828KQIowEckQIR55M7USidB8=;
 b=F2YHGAmhCfQpVIZIjo938jOTKsHRnGEDoIpbMmKPymowC3ba5FN1GwoM6j694l9gmm
 7Vr/HpiTI+IbHFqqevY1kY6LEvIEMtmu8Efw5rkBiMJKiorNNqc4z0XyPPLdnePQUTXA
 Tisa8l3+n0AjEmnCmpLo1QwEeUmMBe78DeMgGJ2OjpAXGCpbhnrGNyWgpOKLbcau/NNO
 DpYOLPYi0c1sXajD1XFgi6JygApGz7HUzWcm2ji03kqAwaVzrXbUUQqS2qzNVbat6Lcf
 PJpwkTdgAIrvlnLE++Z8MrKNG6dhm7Ea+rIbFZp/Cgsb0EpP2RLHc2so7Jw7LAQuBek2
 mfZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777045573; x=1777650373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cwi7wIQXzCJrOOFdS9mM1CUc5W4Lf0OpCdD9x4zH/E=;
 b=Fwlgy76cYvqmatrRJFeQG0kEMRhjDM7JdZ/i1qSDwlBAgSFSYbcyU/B4Q7d4gPtBjW
 JyxvMLFKYEoT3LbVleb/1woSSkpgwQZeWF3kWXuCj6GRQywDwYRR1sNHb2XfJbz1YDlb
 BRBYkW1p/2c53QQ4B2trf6iPV8yXgPsi3JEq4QT3/anXglwd7BlZE1YU2d7blGRwTreg
 dei7vJNtRSiBGfko2a3jfYxLJegb1OGyraH1Dky3zCW5VcQba67yl/0t1ABSjc8RS6mW
 NepMA0XC3Nqy0thY2wyai+uEw5I+AoV42AfJcYp5BgjMcl3SjJUuvCC6Pa1amMzawVNA
 4TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777045573; x=1777650373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2cwi7wIQXzCJrOOFdS9mM1CUc5W4Lf0OpCdD9x4zH/E=;
 b=YAvKV1SmZRLdQGKUyqMl0EVh+HeR9pGcBVtfAmsUOdN2IHC0aWZ8Yzr22MlA4502iy
 cpAKbv+oNwiBpx3RyyyLs5Spr04pVjJgu1gNqiiITKJIg3E/Uz0XYe/eauXPTwveeYs5
 G/YvOyZtL2TBGC8jtldtLVzyFNeNVArCUA+QRe2C5bQ6OIcwwpAUPhO5uzp+OAvg7LAr
 5NLAeLVM3fH3wrGv4d5LiIIypOedY1PKhwV/VtrB3C+Tc/qhBp2R1xVNhR9YB70RvoeI
 OlxDkDK75PIMnvYgWMd1zmZeW8i3jOly3jm0WsmDt8Voory+BNJCYJKAzUfO0teLz2yI
 7DWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v3q7D4EKfyQtkMBOoc26mZXO8rpRnijOxm/Qro+xNsZo967GEFVnEUPqZEo3X6utBvuH60bNcWW4A@nongnu.org
X-Gm-Message-State: AOJu0YwVh1B71Ki5yfWTs+Ik0pLHYaMlhLLtXV/A4khzLp7w/gUJKkD2
 cU03sB6Kc1EaIQw6177buMKnDr+X5eE5gd0IAHuHyMi6dnSxJi+A/1LpX2igJf1SJ9DKU1phdGR
 Wb2PZcGfxvRpoMtfUMURXVm0Nnky7FLOVnQ53FXRgPw==
X-Gm-Gg: AeBDievFzjhXqemrfvirc3+FSAhpZFcxVtB4ePuSj0sSpJc/E7C5VnGJak+K75XhPBL
 sMHi9fMUVQ2xmB0hc4u53MaAV+yQjjnESjlIWd5qJdqop75dXbDYRA54F5QKZszo9GKD+l+/rEp
 FMPMV0DgLUlOh6mFxa0x7N69zV8Q+nZ3Hf7P2gGzpUbizphia29HcpzdrGbnbvkLe/87igKfk9T
 1A9xc1kNOBfBLOTBaE+UvvfHhhCtzaHvltz9nFf/vNhzxKLndwX6vFM6Fi8Z+GfFPfEAuaqcuaM
 Zwu7MnbqZ0Ay1cNOAZNeTJNZYcmfmt3jbAHks2Dp3TXExfohdXaxG3aTn7kV8kjiSzBm7UELhMm
 7+A==
X-Received: by 2002:a05:690e:b45:b0:649:b31e:8f54 with SMTP id
 956f58d0204a3-65310869ad1mr30026063d50.24.1777045572778; Fri, 24 Apr 2026
 08:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-3-clg@redhat.com>
In-Reply-To: <20250929165230.797471-3-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 16:46:01 +0100
X-Gm-Features: AQROBzBxq8UbBsZloy7nTuqIIlYXBdO-3p_ITIpSNk_ELu3vvYKymX51Yp3ZG3c
Message-ID: <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
Subject: Re: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Kane-Chen-AS <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 29 Sept 2025 at 17:53, C=C3=A9dric Le Goater <clg@redhat.com> wrote=
:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> This patch connects the aspeed.otp device to the ASPEED Secure Boot
> Controller (SBC) model. It implements OTP memory access via the SBC's
> command interface and enables emulation of secure fuse programming
> flows.
>
> The following OTP commands are supported:
>   - READ: reads a 32-bit word from OTP memory into internal registers
>   - PROG: programs a 32-bit word value to the specified OTP address
>
> Trace events are added to observe read/program operations and command
> handling flow.

Hi C=C3=A9dric -- I was just looking at this SBC OTP code for reasons
related to unaligned access handling, and I noticed something odd:


> +static bool aspeed_sbc_otp_read(AspeedSBCState *s,
> +                                   uint32_t otp_addr)
> +{
> +    MemTxResult ret;
> +    AspeedOTPState *otp =3D &s->otp;
> +    uint32_t value, otp_offset;
> +
> +    otp_offset =3D otp_addr << 2;
> +    ret =3D address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIF=
IED,
> +                             &value, sizeof(value));

In the read path, we take the address from the guest (in the
R_ADDR register) and shift it right by 2 before using it as the
address to address_space_read(). This means that:
 * the address is always 4-aligned
 * the address the MemoryRegion on the other end sees is a
   byte offset which matches the size of its memory region

> +    if (ret !=3D MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Failed to read OTP memory, addr =3D %x\n",
> +                      otp_addr);
> +        return false;
> +    }
> +    s->regs[R_CAMP1] =3D value;
> +    trace_aspeed_sbc_otp_read(otp_addr, value);
> +
> +    return true;
> +}
> +
> +static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
> +                                   uint32_t otp_addr)
> +{
> +    MemTxResult ret;
> +    AspeedOTPState *otp =3D &s->otp;
> +    uint32_t value =3D s->regs[R_CAMP1];
> +
> +    ret =3D address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                        &value, sizeof(value));

But here in the prog path, we use the address from the guest
directly in the call to address_space_write. This means that the
address the MemoryRegion in the OTP device sees is not necessarily
4 aligned, and that it can have values that exceed the valid
size of the OTP.

The OTP device on the other end seems to try to account for
this difference: its read function uses the offset it is
passed as-is, whereas its write function uses
"otp_offset =3D otp_addr << 2" to convert the offset into a
byte offset before using it as an array index etc. But the
write function doesn't check whether it's got an overlarge
value, so I think it can write off the end of the storage.

Is there a reason it was done this way, or could we make the
write path also do the conversion to a byte-offset in the SBC
and validation of the range, so it matches the read path?
(That would let us mark the OTP device's MemoryRegion as
not needing to deal with unaligned accesses, because then
it would always get 4-aligned 4-byte accesses.)

thanks
-- PMM

