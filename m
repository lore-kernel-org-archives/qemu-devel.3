Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C8BCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRr3A-0006PS-37; Tue, 26 May 2026 08:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr37-0006OU-Nn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:38:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRr35-0003OU-75
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:38:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so49756785e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799097; cv=none;
 d=google.com; s=arc-20240605;
 b=gDzejqjwLSx1LSw2JNZnzcdvRUqDs2rBDXg/KnY+M2XHMYYc3zIafC/Vaqhr539ET+
 7WXig5bmgFbyiTOzvwaVHyzfeZh9YoBQg53noVp4fvO42Hb3RCZ9l2/ikkHo0rLB424l
 GG06kcE6uqCYEWaBvC1/2uVfA5JO1n9OKvcs2F0mfKJPqZ9/YD8qeSomwhkRhuq292Fz
 Xp8HcQttmOiWbKLRZHXFVmmjOcvdr1mLu6g+gazbP667CSNSvT9CFwJ2zRshsAdy6b6h
 uanIi8B5GveEoYNoLVG9Dc4U33xQ+XXZLqwDXvktto3gLGF4wyNmoPgfODjSh4JQpVM3
 D1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ou9ZWNvQIywegbPag2KpLXrluSK1REkFdLEt58vvRSk=;
 fh=npPUHKndKGRtKGG0AmfLjCRBPrh6aaPyHa+8WDDvcV4=;
 b=ItbfrrXnhEiKjwWeoCelKX5fTt75dKigeE3rVqO3Nlq55o22TEa6UzzHPu3wJ3rfnR
 LO9AKWtTNw5S49zZJZdzShLdzrh3ACifMfVmaqJgYiTu92XFzq0+HjGPIOgaXKkcLZ5x
 X7cHtlxcldE/ojfKHB/LHjbQ3wAFtYblan5rjif8yNPcSypRUzxt0bf6IV9FFyx4i4/D
 sUJ5KYk0DkmA0knB43Av/Zx8Vn+9R17zU1hlVdYTH4d0SNOo3A57qTxVhJ8UkyuK43jd
 XQ4nxb49k5u7Lcr5zKSWhsbSQPP0PGufdzNvmhcSjSU6ESKFIwpolKua9ApwFHPmY6ck
 NGrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779799097; x=1780403897; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ou9ZWNvQIywegbPag2KpLXrluSK1REkFdLEt58vvRSk=;
 b=n1IVY+QPb/wZpemvLR5OXQ+nGmcvJ5e/WwIafU4WgQty/pLe5l1l17HPgomOYDUarM
 duCbJ3xZ123buXyuEnujeOlfANGlHxRHmg8l33FqMtP7tC9dTgXABZHhjfsQzrhRawdq
 QaIooh/jEpyzNdg/wIGo5yITNZKMbfclCysb0OxQYEPKc9FLL4/igEuIdxj7JLliE9RU
 24eb5YvGs8miaNlBoOUq81Ybe+NqRnnncOOFeg3RYNQuGXe1cALoStR6d1wg7x1CI3Za
 p9DxZy/d7NBrGt3BdmZooCVzrIoKsbAspIDO7HNxmUBIwQVsCsqayOFDjrG1wCndlf26
 SMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779799097; x=1780403897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ou9ZWNvQIywegbPag2KpLXrluSK1REkFdLEt58vvRSk=;
 b=J7N8/FIskFKPmFLDA+Qx0R13Up8hXzh/WOMD/NP31yTcl+wJAotrn3ztZU2pZ7u/aL
 e4kae1jSDavgrJDt+GToOOMNKTanwU00t5g1SdiOpf4kfypJFfptpnvkcmlT5MtNu6Dy
 FCwQ5SB9RKNulFnv3wbmXXVu7No1//k5YBcbcc9BRVVldL2UDhdswNDCzmH2oGA9QHPk
 4+RDA/5DmgPyIbv3uVuvnhCJLAMLKVO14M9nkzE0fWZJ51LwNpQ4bstjmVkET/AYzFtf
 9DX3HJpvzhuzYW6X9mrb3CqLEfcrjLVfSJjtfRad3TzL9iQ4ujohAxqMlKplt8oeRntY
 vXXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NorvE6UmupEj5yE6f4mfPBxfdK5d+O/Imn11wwmydLTKarLVYP6NK83TrJ97OsvxrK5yQFWXEUrkQ@nongnu.org
X-Gm-Message-State: AOJu0Yz+jmkbvJAMDlSa+Lj7uo4dilvkC1O+9rhXRGopxdiqm6c1dJAc
 PbO6R3jc+EDcl/HE9CSZh0LLIZu0rVeCgsSUERpN3OTHpnr5v18ftT1J65HkKvGmZ6XGFOU/QdG
 zixUQKWMHszo7XO0ep/mmAmdiZVJq2zCanvBMdjVo6g==
X-Gm-Gg: Acq92OHmsA+0hH5ti/Qoc2Oidc/WEBAocssXXxmR/U7SzANvc58C+GDxBMhOi8gEIp9
 2783RGsl7a88eEekDNarOe20mdLv2i+gkDDGXjCp95RjauM1fa/qYOgzhDIwKQZbA3q/43mdKVV
 1c5ptjIOOqP7e2RV6WgdZKQAsfRgj6fQIvetAh9Y9+bKheiBQV8D+f4hagRJjXL3Hfme7v9zBpu
 HniP79Wrm/pIVodKKYevAeVr3/KnlCgXT0UF0E7q0fOWq4Rvh8yL5BvJ5LVYYh9TOOHdh3xI8Hf
 UTucqxvAa78GUXArLBlmeVfxPf7ZGoaKLpoq0zahjHX0rM20W4/yqPp5yHZYy8LTlDOGPtk=
X-Received: by 2002:a05:600c:444b:b0:490:b07:5fd1 with SMTP id
 5b1f17b1804b1-490424aa00fmr283891305e9.11.1779799097478; Tue, 26 May 2026
 05:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
 <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
 <20260526082814-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260526082814-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 26 May 2026 15:37:50 +0300
X-Gm-Features: AVHnY4KsQEKkfZpzts7DQGVj2kot9ZNRIkSlPPHUPz4bWKlbKjaerstDf4wTCUk
Message-ID: <CAAjaMXYzNUG2KNWkOdH8Y5HV18MwxTVR2jVNPaP_m72VZb2P+w@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Tue, May 26, 2026 at 3:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 26, 2026 at 01:27:40PM +0200, BALATON Zoltan wrote:
> > Maybe clarifying this in the policy could be
> > done although there will always be people who ignore documents.
>
> One advantage of the linux style tags is that at least they differ
> from whatever ai's put in by default. So whoever does it can get
> banned pretty quickly.
>

What would be the mechanism for that though? Getting the list
administrators involved to ban email addresses from the list?

If banning is to be a deterrent, the process and rules should be
codified in the docs so that it exists as a warning and there is
little room for abuse and ambiguity in both sides.

>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

