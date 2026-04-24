Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA9BFED3D9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHvK-0006ms-38; Fri, 24 Apr 2026 10:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wGHvD-0006mR-Su
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:54:23 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wGHvB-00060K-Ma
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:54:22 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso8739742eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777042459; cv=none;
 d=google.com; s=arc-20240605;
 b=jcR2ObG/NHPaz2BfyKZzCaFcJ90jvnGa+11zG4rWBWCKS4006c8M0WFjFoEP+Gp/Kq
 nSPBxAZBRRUhzSMvO7xHyHZstDX/ArBICU0vFSC4cw41pPSS62rZ8qYZpVGAvd3g8V9W
 BKGErsFmL4v5ZvF0FEICd7jeUeCat1t1a4DUKaU0uYW69pMyMChf2LiQ7N3S4STMriRl
 duWQ6nTDIK5zgUz6hbuEMlXn9DY2fyavDKU6SSY2xZ4VT5UxM6w1JoZM1SXpFGE489Qn
 Inkco3PQaXl4yw5HS2WLNpQzDFE6uw7KG/qENh7xid5GHO1d+E6jqJ2QzE/UOc9Axllp
 Wr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KbttfDnZFk3c4YOKbtM9vtEftSzEKA72FNq8uEMrsmk=;
 fh=hooBudXt5esqDtb27qV8/EVQeN48ikwKCqnHqctkwwU=;
 b=Yixe+WYiWfZ6/SjihrFDcknugd1fIyf3LgX9o3XoU+/cBEAgFLudyRfuUoMDB/ISuh
 f8GUzFIdxxza1pLdyBk0mIz5gTeXo9b+6Xw/3nrC4p1b+FpLi0tmLSpcCvl1alcabqcj
 3vzJlDk3Q3cCCFIwcTTXlz7NmBVg8yca5uduYapqysCyvyXZUNgxry2YgB61FJvQpk1f
 1MhR+1VNLSxgx98m2IIe4SlUtdOeFmdox41EdiWnUCa39ZtT9SOYlVfrb81poKoDbqvz
 ljkASfD+Vg5GFmc7r99at01O4/c/Ue7NdJnEdMUdypqqpm5x+Kh0EJ/gzmAH2kL6PDH5
 9Lqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777042459; x=1777647259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbttfDnZFk3c4YOKbtM9vtEftSzEKA72FNq8uEMrsmk=;
 b=kp5nQpeAf+P7wA0TD5cUXnij9hzKu1X1v2EtmRcNVhzrI97VOEcuLs3KCnC6khLZBp
 kZhq5Go3c/G9/85QcvPTMsmittg4jnBntSVPGTUEZJFdJrlxOeFSpIcha82fxE9BddY5
 gRdSGvtckSRFHq4bGXiM794isganUHYm2QHA/Ywcn29ObpqI3zm20olR9OGH798fCD6b
 TigWNDQUL9LOUsqWt3xkdwgXnnT7VfGmuf/fDYNu7mtLQmfZTvOezsizk34NtqAFMMtL
 zF2rRL1AAVBEErUaZ8BsA3azibbAXy/H9j2ynD50fXzOoZg19rCC7eF2rNTY92hLgaKQ
 lnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777042459; x=1777647259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbttfDnZFk3c4YOKbtM9vtEftSzEKA72FNq8uEMrsmk=;
 b=BHNrdJi8RtMHtM/QfbxQsyOTbuDntWZChgyaxTfZ5LBdwHqzcowVEYnSidSptHKpmi
 ItvaY42br9N2fr6nJ44F8xF3/zPqxK1+WZq77YfmwuN7oy7Ka9ulwFKF6/Tek4jfQz2o
 tj7WnmfgvgV1okCin2ov1R3SXyVMdQavQiC5USDRtUVH3o7+jqvA4af2POtGmbK9lawc
 Cn2ESdhRnmcWk5NSzk/DbIDecwpYJ9u2fSCbKkotwowRisSA2rM6yHmvC+cwN8snyRIo
 LWUZmDS4i5dxAx4iUZ80bXseqQDxikGx/XNl+CfFU2IPdExgzz1S0lVCVZoS8jGZNK6H
 Tiww==
X-Gm-Message-State: AOJu0YyN8FQxG1+qtBRarbTPndXQ/KKYajGjeS/oEHFBSeDUhwynhR54
 8xfqdr7mpvK9l0pgk5RtKzGur+awS0KGBWvySNxFtLGWhcaMhNnWVq2d43qd6uF/ldx4OaTOuz2
 Ln7GA36TAaRBe/HYnvzUlbFqwb4xq3qo=
X-Gm-Gg: AeBDieuBzmsmbzGTFmMVVgvO84kEpQcHv8pbYU6/CqHOJxiRKcYnN8VyJyegiWTeR0d
 9IZ2//F36gXN5eOIInrShiLlcB6iJexTtmQauaxNvipxhThwUd3Y5Is83Bn1tIkb3FXd4fp7wBa
 h2dN1OBsFG7RkxmsxpL1fxZ8Aub4hj5CHH4zaME7q8jW/v/kItW5vB58RYNS5N48U00dZAjcNqQ
 uD1LTGPowhm/JJW4c++y2ot0qiXyYwCPQMNT+V4e2dJMZPmtChsdaQKAH1PPzd/Bpiu3ZI7gAwG
 qwVCcCgLUwPyVMzAaI36xMRpyezITBntrlYIZUE5FYpYeCkNr4U=
X-Received: by 2002:a05:7301:fd81:b0:2be:80c4:2c8c with SMTP id
 5a478bee46e88-2eada6d6576mr1480875eec.8.1777042458742; Fri, 24 Apr 2026
 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
In-Reply-To: <sXJQOREScD4G6fYInirO2wbLtvZf6EK1yuTrP6U3GQBM5dIq7dhRnCm9uxSSiRRK0b4m7OEZRqEgjzHCTFoS0DruFvYUXh-UUXhkY0x786A=@proton.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Apr 2026 18:54:07 +0400
X-Gm-Features: AQROBzCX99rG3BrO5qZK5wSpYF9S5zClBApfbYPWa09Vv1eLCQHsCnwGWdGGhgM
Message-ID: <CAJ+F1CK=jxw1Nf8UYa6jx344HknSXyj5A4MaoUWr5xJSK-ohjg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Fri, Apr 24, 2026 at 4:37=E2=80=AFPM Feifan Qian <bea1e@proton.me> wrote=
:
>
> The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
> by the guest and passed directly as the shift amount in:
>
>     epctx->interval =3D 1 << ((ctx[0] >> 16) & 0xff);
>
> The shift amount can be 0-255.  Shifting a 32-bit `int` left by >=3D 32
> is undefined behaviour under C11 =C2=A76.5.7p4.  With UBSan
> (halt_on_error=3D1) this causes QEMU to abort; with aggressive compiler
> optimisations that assume UB is unreachable the result is
> unpredictable.
>
> Clamp the exponent to [0, 31] with MIN() before the shift, and use
> `1u` (unsigned) to avoid shifting a signed integer.  The xHCI
> specification defines a maximum meaningful Interval value of 15 for
> most endpoint types; clamping to 31 is the minimal safe fix that
> preserves the full unsigned 32-bit range for any compliant value.

I think we should clamp it to 15, to comply with the spec.
Otherwise, the patch looks fine.

>
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> hw/usb/hcd-xhci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 0000000000..0000000001 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1119,8 +1119,8 @@ static void xhci_init_epctx(XHCIEPContext *epctx,
>         xhci_ring_init(epctx->xhci, &epctx->ring, dequeue);
>         epctx->ring.ccs =3D ctx[2] & 1;
>     }
>
> -    epctx->interval =3D 1 << ((ctx[0] >> 16) & 0xff);
> +    epctx->interval =3D 1u << MIN((ctx[0] >> 16) & 0xffu, 31u);
> }
>
> static TRBCCode xhci_enable_ep(XHCIState *xhci, unsigned int slotid,
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

