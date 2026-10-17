Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F0CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3jT-0007z4-CW; Sat, 17 Oct 2026 08:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3jI-0007vH-I5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:40 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3jH-00049S-2j
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:40 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0cf2c0785so5819957b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240898; cv=none;
 d=google.com; s=arc-20260327;
 b=TWKMDUHXwJ3NIpZhH49RIEHXzyDkwtCZyX/rA6tDPZ4zLA987xrebPZ610BbE0vSpf
 R6fAZfVJPCmYgk1PPcIOqSDGFz3ykBcU1DatQKUg8DfSM8C58HFwTXq7Po3iNr2hX5y9
 jMvk0qQb0tnTtKtyMDGVGVpuzjYkSn75+m83BJjlaJX9DiyREwc09Gca8L7wzwoxfRe5
 lxkOq4bUfw9h33DkpwLHYL9aFEcDtkBTCtnbMT+3RdV/PVqu0X7gg9SerxjgLIcyb9l3
 Zg+erO0AUfoDjh5NwG3OJ6hLV4aIct3qzcNTaYKSNE432skAR4Rtyu+7ihxU2GD312r+
 +EMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NZdKfx+Etpoc3S2ApHYXl84B2+t+hA73P89U2cSWRX8=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=UPI0ptYAfNRpNYCdaB/Hm0gct9/bhHva+uKurGervytqTp/5KoKIw+ZCF28e48fPJ7
 9MXxJNjLnujpkoRZk2AUanemL+hLjN1mB7q5nZXMUbvrwTP5/dh+rfq/+6q4YEDjaBA1
 3+z2kk2kNANnxOwBHE93pQOn1ZCt4vnK5t9X5Qg6lln/gziCuHEb+ytHxkmsnI3T53Yo
 sABc5wC7s7Slc0jOnmbfng2OQr122IC1psGLzZ8w1tltNpcK8UadV8qd1X7z9GGFg9qK
 BJ3MRb2XI8XeGLbDO8qroWW+SpfcettNp55jG+UfSuF6c2VUcKX6U0DBje78DUiUSzOl
 cT9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240898; x=1792845698; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NZdKfx+Etpoc3S2ApHYXl84B2+t+hA73P89U2cSWRX8=;
 b=PAIgGmvAAHLj+Ed/woaC4Geo5ttk93S9wFBEEwbNx2Pr8Qhcx+xpRGTjEqCEbQAcRa
 kQEMsy2yIdo21zOD5wcxL+h3xuXVEz6Y6ei/0S1o5P6x1g6vXEnGInn8Uq7TN98g6ShW
 VIg8sNn713/NtOSdrE2llCSoB86n90a3xCh8dbNbzMrs2i8IZxvFWIZ2vtgMdQu0JfpG
 /BUrld42IL1xhUK2qa1kX4g3NCLhsmFqTBmAbOucH3jm1wOpMX2rVgoS8F1G212vxy+U
 yQkDDG2fVCA7eNn5wAwz0EFk+L7stq+jOTFhJm7vD6SIEJQ1kpz22LW3hAAZsVT/OPhk
 7idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240898; x=1792845698;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NZdKfx+Etpoc3S2ApHYXl84B2+t+hA73P89U2cSWRX8=;
 b=JO4K++7qhxX99Sm1JGoQN3tdxrpCGKHQ8P3NbhXLxgUP9EWSYvHTQRDL05dfPinzui
 6C8rWKfmpuOWeDkjwAX4hAigb1/quCJbciiuCQmZbXsWR9A3Rl0CcfKx7mu7/96e+SiR
 hZ2k4gVNb3h1GW1aJIuJrb9agXtod0va+h2Ykw/F2tLHK9ieWnjZT0DmwbBLMJhP64FX
 2RGEy0JsMpLx41wod7aNr1OqAHNcNLfngwygVcaGQOM3a6RsREPlMbz+7cu3EiO8EZ0e
 Fvg1Za/FAKJGjuWYvwAm2/EJZ/YFuNvHlT+TIeADrNBJvCMuTd/c7wYkfvY2h7qvGGtP
 bNiw==
X-Gm-Message-State: AFq9FYJpeuaa6SrNDCvD9lwaR1hAV2C0vDGaECXpdhALWAzRVkHFXLYK
 LCJYywy4aguM8rVcB3XR2zqqsxg46qeki6YArxCZ2uGVShE/6xN5iBpgKUvCezSwnC5WXPm/QPd
 nR394Jyc2CONcA133dzM7SaNXcz+ZNvM8/VOStab+gA==
X-Gm-Gg: AYBFou0+kJsFZQcCK9iAzb1EAOrcOHnT9uXOjAAV13uY9Gc8DHqQjGr/dXO/yskLOEu
 dnkkn7sn2Z1MEcaCIC3Mgja1JDMR1DWoXoP9WdomMlUu15OZT4zGpMOjIKgPGXUF2kUeJkUPwl1
 pm9PprglyN7taDlQ4/Hp6lKX673FRxZ3mAuUHPdjQVB8Zkt6XxL9M71CiOpYshS4K8+WnCck+g+
 VVXQdaCXMMV0iPm7Bu2LHEsGLkPun8Nu6uFK0P9JE0A+3S2R3xJqIFtTP3CKV7ejZna+UCKvdzl
 cnRM+EL88vvona9+kUuL7t2OdDVtA/STIfWHueDBXdd1VLn0RNktkEBv25Lx5v99UpQVsjXsRZ+
 OETMAQpAzVyhaDxUfqPJ8imEx8xEjJ3Sh+8Mje4s4v1CS2NQgzYE=
X-Received: by 2002:a05:690c:f09:b0:873:5ddf:d872 with SMTP id
 00721157ae682-8b0f21f0f15mr8429097b3.61.1792240897814; Sat, 17 Oct 2026
 05:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-8-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-8-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:41:25 +0100
X-Gm-Features: AclHuK-9JkQz8yv7JvdeeFSMwQ_f9aBH7f9X99Kn4HPrQbFEf9TMiyT-muZEFzc
Message-ID: <CAFEAcA8xkU4UdTt3W=TsiaoziRxiJDucxDnJ1OAe7LaPXhmGzQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] hw/net/bcm2838_genet: add GENET register
 structs, part 3/4
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add the TDMA (transmit DMA ring/length-status) register layout and
> field accessors, and the PHY BMCR/BMSR MII register field
> definitions.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/net/bcm2838_genet.c         | 88 ++++++++++++++++++++++++++++++++++
>  include/hw/net/bcm2838_genet.h | 88 ++++++++++++++++++++++++++++++++++
>  2 files changed, 176 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

