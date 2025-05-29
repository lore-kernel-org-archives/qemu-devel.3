Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B81C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKhrR-0008IK-E7; Thu, 29 May 2025 14:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uKhrQ-0008HT-7w; Thu, 29 May 2025 14:20:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uKhrO-0001gN-P1; Thu, 29 May 2025 14:20:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so144479f8f.1; 
 Thu, 29 May 2025 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748542809; x=1749147609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjCM9hucdKgIDvTF3Sg2k+zep7sU+NzDvtIm5J6IHDw=;
 b=Aqcz9ZchOxxC6wPsyqGl1IVRSaiDJhwQfYAexPGFDTNlvk0LAF1Vai2ARVUluRGcjF
 yRVi748jDE9EiW0yPM4k+I1KNFxHpJhqDphWCVrHuG4nUSblRyDIxYEeNpXxnaYNj9z1
 AKvwObYLyE7jhSMiahtd6Cl3Qi3sixLDbXbHmV8wp0pO+Uy09OE1TGS2Ox6hriEgwHB9
 sZEUQWx0gFB4EM+6ScjRdXvm2acRitAUz2gfkb6s400p6UyFV0UIAzJ3dYwm3cBQ79hh
 lhkPyHHlopFmlfrLWmBepsiSnB+HNwNC0BXl9vjT1GwI4jPMWLj2WLUg1q+9KGzpUBZe
 tXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748542809; x=1749147609;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjCM9hucdKgIDvTF3Sg2k+zep7sU+NzDvtIm5J6IHDw=;
 b=hpDwiz65vWr3KPRTB9ZsM7QbYvJtIdm1BK7fVirRdBRvQQEif7lkN6RMoqk5zOJAcD
 4hRUV+Hr7XOUqUBLshsEPu/+Xo78/Zj8nYWE6zfNgHpvwVK1sSbBAaHoy0Ap08SAFuvS
 Fqh5te9+L+NzYJiJvG41T7pyYp6Y/SV7SbZPLbnm+EtmPfcfSRYQClzljcM1S1LC6l/u
 NtovPLXzUqyqknUH3DoMucNNovj8WMWh/QBq6E6306JF2V9g0tr/q720/tJ2E4wRzta0
 xH8/F3P+oHvzglL4/2Yo2JlqlLPWELOI6FnaHEFDc/xxSz6gS7cBgOLLwvHbANi6/ahu
 yMcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfIsRhe0Fv7MNpf4oxOLZcs8bT0XFBHVk9BF2ws1G6Whv82ibYiykfEAnzCi42WNy0fD3r9UP5S1+R@nongnu.org,
 AJvYcCVokpZQh10WCsPg/mX+nKxtRuXp9YsRk/Z5PknfEV0Z4XsyVJvrFuqYhu5jUdyoymsM/UwezRAx1do=@nongnu.org
X-Gm-Message-State: AOJu0Yzn8yOnxVAfVXr//tK7ZUJg7qPlL+R3mDRgbj2GQ76I2KlOXYrl
 doS8r4gEz0xD+7B2RaL3bdnhXV+aY6XmCaJaHqGLaV5O6qYuHEWml0Ty
X-Gm-Gg: ASbGncskmnJgw/QsY3DxcG6j4EFwaWnhaG+en8JE62MEu+qCDiVxbxmfVvPZXRWIOHU
 fUBIyu0P3qXi9z2w4sWScz5MZJ4TXiM7DVZa/FvdX1rVdr/4oJ1ukD5iTkh1f1sc6N14ab3ABnF
 Pt2DG5NfYO+o+wNijFk2fk/DXFnJPXW1Zuz6CkMA3qi+zkYY7ieOF43YvFrEsIP/hvdburIj4zN
 EA1qi2Z/pmEYgzQsQNL/KWO9DQcyz8RAi1/ILRTbOzillpG3hl+4US8XS9Nncgb+hmftSGvZkdz
 BPeeu/YPOyoj44IOlheSZsVu9mveL32o+vkF8vzs/6Fa6ByMQ01rFWmPzAHhc3eJADtbbrPRxWK
 CnKs9rP6xDw==
X-Google-Smtp-Source: AGHT+IHLik3qgYjr+mOD4Xk4IdA40JuH6mRGdvTrRlZ+QNC7mboUP0NlaPS63jLrpuWUkACHFEuSnA==
X-Received: by 2002:a05:6000:2583:b0:3a4:df8c:dd3 with SMTP id
 ffacd0b85a97d-3a4eedb8b24mr4398152f8f.21.1748542808635; 
 Thu, 29 May 2025 11:20:08 -0700 (PDT)
Received: from [127.0.0.1] (ip-185-104-138-110.ptr.icomera.net.
 [185.104.138.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f83sm2630542f8f.49.2025.05.29.11.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:20:08 -0700 (PDT)
Date: Thu, 29 May 2025 18:20:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] hw/net/fsl_etsec: Set default MAC address
In-Reply-To: <8bd7ca691bd502b5fd761615d9af805e783fba36.1748012109.git.balaton@eik.bme.hu>
References: <cover.1748012109.git.balaton@eik.bme.hu>
 <8bd7ca691bd502b5fd761615d9af805e783fba36.1748012109.git.balaton@eik.bme.hu>
Message-ID: <5B1A79E5-1389-49F7-AB4B-C1468D398F1C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 23=2E Mai 2025 15:02:12 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>Use default MAC address if none is specified by property as done by
>most other network interface models=2E
>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>---
> hw/net/fsl_etsec/etsec=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/hw/net/fsl_etsec/etsec=2Ec b/hw/net/fsl_etsec/etsec=2Ec
>index d14cb2a101=2E=2E846f6cbc5d 100644
>--- a/hw/net/fsl_etsec/etsec=2Ec
>+++ b/hw/net/fsl_etsec/etsec=2Ec
>@@ -389,6 +389,7 @@ static void etsec_realize(DeviceState *dev, Error **e=
rrp)
> {
>     eTSEC        *etsec =3D ETSEC_COMMON(dev);
>=20
>+    qemu_macaddr_default_if_unset(&etsec->conf=2Emacaddr);
>     etsec->nic =3D qemu_new_nic(&net_etsec_info, &etsec->conf,
>                               object_get_typename(OBJECT(dev)), dev->id,
>                               &dev->mem_reentrancy_guard, etsec);

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


