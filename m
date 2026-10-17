Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19294CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3jt-0008ID-SM; Sat, 17 Oct 2026 08:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3ja-00083A-7u
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:42:01 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3jY-0004A9-Q5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:57 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ac9d666d4eso5549877b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240914; cv=none;
 d=google.com; s=arc-20260327;
 b=evx1SeHhINfzZZSU6UHZ1JVUpqfnJVbxBpRLbeP9VVX7za4l/Ok+5IqWjkvSL9FWbb
 QvDnXrAFoHbgAPzPKoDBKQuNTD+f5OBYofGeImn4My2mLTvbdUH+0G2ZhhMvuQZv8nA9
 nXYz5YXp/4s6LERkZQlSpIU+yvwmv7Set/8YxE6ENxrOqg2opyivz8w+WvibxH7QNfA9
 QQLYMephVpED1qKitncMEMyn0UbB9S7W5daLWWEqBF/8Tmf/KUygRxfYFTZmoQ0yxv7o
 JMnZ6b06eeekwz0iIA2ar9ddzva7oCqjdRCyvzX6eFtATFS0vHHNSWQVN4jOap0+68vX
 nRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rk6Op3t4nh2EfatWEvRXCZRkE4RXXW5hM3EwnFMG1ko=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=rRf4GV03lDTpgpSL7Pr6DXrqoW+cfjzVL3L2rVHVSZS3kHTpfXORsi0zivYrC++0nc
 6T3ptlmQFm1ZCfNi9NyNMGqwrSsA5k2H4lp/k8paiz9zXIZDWkMVWNs4i9JPs3lMAHfQ
 K8s3MsJR69+fB6hPwH+1cL9bLuVlAnbrPEmjXA4IQZ8yWpS3njaOjQnfbMcjDytY47V1
 hPZmic+LSDfUcbluubu69+CeLfogLq+AAXZ57FK7cyD6ubfPyno3E6a5BrLkGwZ47hvJ
 /lP93f14dSvyDr3x3RlO6wu9qk2zzRZDDW+9DOmPAV8N8FIikX5ENFlArEXEIH9Rb2jR
 Kbow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240913; x=1792845713; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rk6Op3t4nh2EfatWEvRXCZRkE4RXXW5hM3EwnFMG1ko=;
 b=j10UgAm9EkQH3MLg/jrVn2iybcNulHDcmk8UoIOIIedXvby5w+W7LW0t2QxOFOGjUs
 YBWU1yt81JyNY8Mjmjun7cfzO1+MWDIT0ZcxeEiEuClYIWaMTSOdkQRwP50Bw0t9juwq
 Jj562PgEzXBJBMfAo8dnrWiamStd86cRf92QQgXow5KpDlUKgglCH/4vF13+vH6Tk5zb
 ktROkdpwYOKWOjdmh1DugKa4Cx2i7rfHuES/A6r8AzN9kDe1t9LRnWlpTPzt3uZQA3+V
 bBU8vOLgri/cM3AJJpsH+FSBN03jUlEKVMgmLDVhkCN845SdeZMm/xXH9p4F9R3DrRgi
 1fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240913; x=1792845713;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rk6Op3t4nh2EfatWEvRXCZRkE4RXXW5hM3EwnFMG1ko=;
 b=W2FD7INGOZ5qmrGRfOafRDAfv4rg3FjRw2HaUam1heOt+0YtQsiLGyK3fGUzMz6xlv
 wmZN0gRbccNjpoRTuHh4U50jLeJVpgooh2o+qup3mgmb7PV4p+vK/hADPJuGSOjNCR2J
 Z3C+mawWbEP/50GN7hbqyNsLcCUr8tpmC7pSEN8b6A/saPxAL9gTh3ukyxtAw908dh45
 NGTFLfd5uIQgc/z8Z135tMfLA80WiL8rqxJrKCpPZTrKlTRnBbFXATJwyfNfvRluR7jj
 NgYu62oF8PJHeCt7GTZgjBQvzW/VH7AbKI2H0GbwK45EfjPpHqYwy4Qa8/BymHb51BRE
 Wiug==
X-Gm-Message-State: AFq9FYJfhWfd9ha+l9e+iGVdcvJyCnD3f0ZlSe3nNpcjT/F+qJJKZA8S
 iHZzUsHllVpQf9d1EFztB11SiQ6RPYkgK1ktGplHDwTKrtf6u8E9R/IBOFzTUkEyb7J2BV6Fvw1
 WipjqfmkA0MdQrA26YYfwvh+9llPYefP8G0kEO1N4juWWcys+3QwVb5w=
X-Gm-Gg: AYBFou0TR8j5DAK09wlBBLBaI+WJ+Eb4XLWs0r117G1j1QU7qXVKujrR0yY8Nl/vJut
 w6BqVDWyGRkkCZZlHxiE3YQFGgsZbOfdbknFi7Y5ljsHX5pCzKOmFRcgW07VDfyGZfxMHqdlyHF
 eIQaXsl5htDvNqh32jtpS0NfyoYEjTMUAlUR1+SQ9m/M0+kC6x7rF5mkwsKRGcheudld7PYdpOI
 VssaWaBF/PVpVLMdZSQfjbCr9nB6O7tyYwKVxTbzI2caCdd+PekLe3MfJdNhBWcFpl5N28RZaUI
 4pOrtyIEKLSpQp+wcp1kWQLbT5mdLmFA/W/Ig/xvwKeha+XEZCMrTZQY8m/GcfecKMZafP77JzQ
 holwJ80ik8EAy487DEi5jeqEp17hyAumfmgr6mWE=
X-Received: by 2002:a05:690c:dd5:b0:8b0:f0f6:1476 with SMTP id
 00721157ae682-8b0f2072830mr9728477b3.15.1792240913503; Sat, 17 Oct 2026
 05:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-9-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-9-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:41:40 +0100
X-Gm-Features: AclHuK_AYqEiAssa2K-pWXq0FkMn01tjdPBVJj_SG34TGP3Ue9h2bEIf7lSpfcw
Message-ID: <CAFEAcA8pBUTVxb-CEAxmAUHBG9e4kEEwkBdJ_0Hg+ViFY27nWg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] hw/net/bcm2838_genet: add GENET register
 structs, part 4/4
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add the PHY "shadow" register structs (BCM54213PE PHY-specific
> clock control, RGMII mode, LED, and expansion-block registers
> accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
> MDIO emulation added in a later patch.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

