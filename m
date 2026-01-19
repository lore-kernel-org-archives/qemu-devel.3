Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99235D29C2F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqBk-0005wp-Vr; Mon, 19 Jan 2026 09:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqBi-0005vx-T9
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:25:02 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhqBf-0003Pu-6s
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:25:02 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7927b3e5253so34762487b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768832697; x=1769437497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iHEXYgdYrDiFmK48N+FJPpplW2jHumrtupIndSNh1k=;
 b=BKFhZzhzTNYh7F66YLcijw61GndJj7jqk714nom7nXPahghFprYRiaDNY/RvgYGbWe
 0JMdobf2AGA31KJnEzRruixd9bZU5RsCrCNHuWvMLrXq3tNyM0V4KFhNWE9NTC1ltiSc
 cgVi7pnzVkKASZyqF6ipUE+eCb1WJsI8Kunp3b69fXG27NenwJ+XvmPKTdFK/YR44ysc
 1JJxxOkhZd1KpU5gJQ92H/aV0vtiCBBGMtfxGcbTGeT6CubXydrxE9CyoWyKQQfOE5ki
 u351zAB53GFe7OP8A8lsW0PEj0Wh5btFEfVkvs+KLXa49n5ax0p7xP97psLkIGSQSPul
 GS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768832697; x=1769437497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7iHEXYgdYrDiFmK48N+FJPpplW2jHumrtupIndSNh1k=;
 b=no7qOE1nZIu+BtaVqvUsqGBW+0EYcQEhXOTUfoG7lfjxupF5tnvrbr8NnvpqLCwdXP
 +1kf4Ot9ssKVNiPWXhmk9m+JaTketxAFl0HCM3EV7N9P6tsfetTFpGIEGQhIv+38G1oP
 Ror96PWaBhHbMbgVPn5Rngo6XKhmaGw3by2T/1GBaQLQe2QLYPya5BeUHkLNRFQN9vmd
 QUCMPi7B4HD8ZoNLOjXLiIymvK8FYhhet2Hh9M+7Atc7FoQVVscMmvWxRxKwEk7DNAlG
 P9znmkyZ2rKnMUhfi235gyI0KwBAso7VyN8JnfqJxoNfrOBYz2KmvesAMKAGeJGBXP7x
 XULQ==
X-Gm-Message-State: AOJu0Yz0Y5sA26EnifkcfbUzmyNFFBRUzDvm5/9SqTAtASi7Pn4Vco7L
 OgNbLbOxKn6tiI9XBAWdD5oyXVCiQ+FpP+4Rk7OO8vKabM5K+xJxc2fdW3RAI73+Cog/MlHIn1I
 GnVxTQx0mPz1nsjxrRy2P38C+KWRYgIRVJ59YtkwadDDU0789PMb9pdA=
X-Gm-Gg: AZuq6aKuYw7LGH/VaDDYenFaAmRSRYuHHeyTzn+prkT5yNUubcyBTXvQG1FiYLYy4gI
 B47r85PM0T4eHOoxcmwf3SRj5zRuZQ6djmD4rIIz67zkQr/pgJr1z6ZkYJmNAoHzgWbFb0uccn7
 fObLFE4vzsNUwFofiviJCl1joiubvGe7gpC2m5g84dEjyYVbhOqlnBJk1ncvQG1HWrfbOEod97A
 D95Q4tRnh5uP4H/XqpRMxV3ZN6J28VoF/KHSXby8VB9qmPePhzYV+sGxbDuqG5TZofH2Q==
X-Received: by 2002:a05:690c:e3c6:b0:78f:8666:4b92 with SMTP id
 00721157ae682-793c52b5e5emr99095267b3.27.1768832697489; Mon, 19 Jan 2026
 06:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20260119120030.2593993-1-alex.bennee@linaro.org>
In-Reply-To: <20260119120030.2593993-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 14:24:46 +0000
X-Gm-Features: AZwV_Qik23CK7KMXmrVoHNbJkMHJrlQ3pHqjT4bwt_678Ha2bfhHnby2Vi52ggs
Message-ID: <CAFEAcA-VkFuVZrGDcpbvpmOEO8b62BqJ_sBUMSTw+7+heMRWzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
>
>          if (ret <=3D 0) {
>              qemu_log_mask(LOG_GUEST_ERROR,

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

Having looked at this code a bit more carefully and figured out
that the send_msi method isn't calling core QEMU code but just
one bit of our ITS implementation talking to another, I agree
that these changes are correct:

 * the kernel KVM_SIGNAL_MSI ioctl expects the data field to
   be in host byte order
 * the send_msi() method is entirely up to us how to
   specify, and "host byte order" is the least surprising
   one for a function call
 * write methods of a MemoryRegionOps always get their
   data in host byte order

So we should write this up in the commit message. This is
technically a bug fix (albeit one which only affects anybody
adventurous enough to run KVM on big-endian AArch64 :-))
so we could probably cc: stable too.

I also noticed while looking through the code that we
only seem to implement the send_msi method on the KVM
ITS. This works because TCG passes in its own MemoryRegionOps
for the "translation" MemoryRegion. But that means all
this base class code that calls a send_msi method on
the subclass is used only by KVM. We could tidy this up by:
 * moving gicv3_its_trans_{read,write} from the base class
   to the KVM subclass
 * having gicv3_its_init_mmio() not have fallback code
   for tops =3D=3D NULL
 * directly call kvm_its_send_msi() instead of indirecting
   through a send_msi method
 * remove the send_msi method pointer entirely

Second side note: kvm_irqchip_send_msi() in accel/kvm/kvm-all.c
also has a rather dodgy looking le32_to_cpu() call in it,
which is probably the inspiration for this one in the Arm code.
Luckily, we never use that function on Arm, and its only
callers are in always-LE-host targets. But all those callsites
seem to assume the msi.data field should be in host order
so this is probably something that somebody who cares about
x86 hosts might like to tidy up.

thanks
-- PMM

