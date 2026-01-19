Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD54D29C25
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhowN-0007cp-BP; Mon, 19 Jan 2026 08:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhowL-0007Z0-Mt
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:05:05 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhowI-0002I7-7g
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:05:04 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7926b269f03so35843617b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768827901; cv=none;
 d=google.com; s=arc-20240605;
 b=MBi50zolTrFEuGO86snR2wTssPhYo0H/50TsZom3xD8Vz+S6cs8yhv/hb2pE0NbvLH
 8ib1ZHuvt0R581o1Aawhqw1zRd1SgRbOH9VSpfdReQU+FNercjQrFORMGWOWtVzi/o6B
 wcns7cQX4ppP/v6dBPruie6VZUMfLRU80O2Ai7GkpOhGRsjZLQPG0dX8pyDtcS7MfzP8
 gwLtTInXcT5QhutEZP0WW4d7pUpXmsaDrerelqI/nArl+JoZnuteXmK5ha+uH4vY6sdL
 TBXeutli0SMZ8M5CdAOPVBk68IZhsfPMNeqHdZi14iec6b6vgjaE3379PKsUTn/AHjNd
 R3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fvSoz863+pofqy1eH4DP7vwtOin0O6YjaWxufyzdyf8=;
 fh=wahW1+RimJuX2MiKJkK+njf/+j9C1d2Eihxe3z70jfE=;
 b=ERzjx1IvQmt8ENJrlhmvoLYkhyE2mKozvxtmjJ4/KPWwnqjs/Bfvy1gkMs9xXbDva4
 R7O2XrKRGtSGxb5wmx9dKSVSxIOOpBymdvNMoUe4B+dfQhcnOjav7QaN6vcBe80YrawG
 01NRZt8wG16wPWKxxGXpfGvYIb9Q/3JH9a5eTTKNu9S+jGKnrAGnc24e6N8+t+2o0qs9
 7mqwTSCCDplkzWqLVHw+2x7cq3yjzuTykj3lCoSTaNEBfa3qvph8JPuv8gpOefqhpR8S
 DHLdpfxB/hLEQEGjZO7LdSts+XNzOF9IhzAP05KN1UW5Vt1IOD+kdheSTdmfryJ1XQPd
 I7ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768827901; x=1769432701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvSoz863+pofqy1eH4DP7vwtOin0O6YjaWxufyzdyf8=;
 b=Mn74yiWEE/ezct6Sk+KtS9m25bL9vUrs/zH3A5E0drlJdZJe4zc84N2MqiNvZolsvY
 cfvzxH0xY8TqQ2hC5zni++AhEwhOC59mLQWCJ34BGnX9BIEJBB2gdTg6XaLebPSFdnOe
 GeHOoF0OgdVaKaXI+r+9bC/D3FtQfGXGkMlM3AXjppcGjlhaSf9miiVwahlpzycARuf2
 axvvqXJhTMHvWU2T0/+K6Iew6sW44vXFL5IbtRaesuhyaUxOPY2H9yNjjgYavDHn0Zvd
 vNcoxyPUfHBeGgN2xhz1yjMsWOT1EsZ/IVZsF0RhEaT/2E08eWp+izhM3MvuIW8RCHe0
 W8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768827901; x=1769432701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fvSoz863+pofqy1eH4DP7vwtOin0O6YjaWxufyzdyf8=;
 b=HZzTwgbrcz6ZYF9PW7o+9rlPT1gnJemwPxk+dqv5kqGlQjRyIHfFSpGyjLWD7/AWdA
 i1IRvz7kbNvGu5l6hq+Lfo8q26Kja9OLf9zMWmLtxElYhE9ZjsNrt7I2vN9LrN7KKDkf
 eYIn1sGFl87JBU7gQXucFDKxfPedjHA0eG2HJM6lPsff3CiTCQLirF9bdjYqJL58ixhT
 gqEqA6LV5IrqKFTYsAMy0FolwzNXdFbLj4HSUfktabufVEvdJJULqV+s5ptGVfvW8cp5
 dte+uYjnTHlgV1rsM4m0d2uh2xylhGWROFvjXBO9JR3zBLbTd7kG3h8lKWWjzKwQZA3u
 94JQ==
X-Gm-Message-State: AOJu0YyxTRVDlonI0ICM6aRETS8MHrFARasiwEitbgJyFJKrCB0tSvv9
 BQCMCdmaTe7AX3zzSqN7sTpwO+o1w9/kstCK1iCH8MCvsBOSnKspCf6B/uY5kOoj9RDLM62osSg
 nLIcpsQH9MyL2oxJ16sCp/0T4hOJb/mDJ0KvKPZzllw==
X-Gm-Gg: AZuq6aJJcoyc8QS1e+dLjqlPow4LgYJCB9H6ELYuQgomR+PkMi1RGkVSWYBGhFL3IZe
 n2E41ZXMoTyereK8AKuhXP4To3f+mlvkoIto3IPDb6A86G2OQBEuW5kzuCreCWoR0DBoiHC7qkg
 bcfE0OHpudXHj2jY/hDvFkidjuS1Qw0zxZv5S+GJbbwkdJWqXk7dKPHFCOiDF+ThQfqadnVvLX7
 ymE5JBb347jTCyMPowuhkH4XKFZNGzEmPhOKweG1hMcnST5syUVQSJ+6MrV8D26pcdGKif2wuHg
 D8mb
X-Received: by 2002:a05:690c:ec9:b0:78d:6c06:4a04 with SMTP id
 00721157ae682-793c523d4dbmr195035277b3.1.1768827900199; Mon, 19 Jan 2026
 05:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20260119120030.2593993-1-alex.bennee@linaro.org>
In-Reply-To: <20260119120030.2593993-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 13:04:48 +0000
X-Gm-Features: AZwV_Qgf1sucgZlu1IDeL5WSKjSsReA-PesTdz71syb-aze6UMvzQWAFmI5TtHk
Message-ID: <CAFEAcA-WNZsMuHu=3wA8JhjMf1agTBG6yXO8G=C-iX+ApY80bQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 19 Jan 2026 at 12:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This allows us to keep the MSI data in plain host
> order rather then potentially truncating with multiple byte swaps of
> different sizes.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/arm_gicv3_its_common.c | 4 ++--
>  hw/intc/arm_gicv3_its_kvm.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_commo=
n.c
> index e946e3fb87b..60a5abd8d3e 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -81,7 +81,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, =
hwaddr offset,
>      if (offset =3D=3D 0x0040 && ((size =3D=3D 2) || (size =3D=3D 4))) {
>          GICv3ITSState *s =3D ARM_GICV3_ITS_COMMON(opaque);
>          GICv3ITSCommonClass *c =3D ARM_GICV3_ITS_COMMON_GET_CLASS(s);
> -        int ret =3D c->send_msi(s, le64_to_cpu(value), attrs.requester_i=
d);
> +        int ret =3D c->send_msi(s, value, attrs.requester_id);

This change is either fixing a bug on big-endian hosts,
or breaking big-endian hosts. Which is it ?

>          if (ret <=3D 0) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> @@ -97,7 +97,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, =
hwaddr offset,
>  static const MemoryRegionOps gicv3_its_trans_ops =3D {
>      .read_with_attrs =3D gicv3_its_trans_read,
>      .write_with_attrs =3D gicv3_its_trans_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,

This change is fine, as all arm system binaries are LE, so
it is not a behavioural change.

>  };
>
>  void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops,
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index ae12d41eee1..a8d6d4fb540 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -58,7 +58,7 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t =
value, uint16_t devid)
>
>      msi.address_lo =3D extract64(s->gits_translater_gpa, 0, 32);
>      msi.address_hi =3D extract64(s->gits_translater_gpa, 32, 32);
> -    msi.data =3D le32_to_cpu(value);
> +    msi.data =3D value;
>      msi.flags =3D KVM_MSI_VALID_DEVID;
>      msi.devid =3D devid;
>      memset(msi.pad, 0, sizeof(msi.pad));

This is nominally in the same category as the first change,
with the exception that we know that any host with KVM is
going to be little-endian, so the bug being fixed or
introduced is only conceptual.

thanks
-- PMM

