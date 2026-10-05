Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83928CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkIZ-0000Uy-8K; Mon, 05 Oct 2026 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIV-0000UD-J5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:12 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIM-00063s-O8
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:04 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so17050257b3.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212881; cv=none;
 d=google.com; s=arc-20260327;
 b=E5pY8AZ2sgmAcsr+ClhoVz3iooaPBXoNCNOsgJeXbUUmTD/T1/3zqVxMDIotbDPDW3
 Hi0lLBzLW1yLCzW8jnrJ0g9XBg/04rduW1FMEzqhZG1w3Lcs76ooBvVe1oavbteXj0wJ
 c+PWu/2ICi0g54OaKlo6XYKsh2GVtVMU8dG62ruGCOcNjblmPbkGCeReFBe4wNjP3MIQ
 pSAB7EBFJmQzyYDQS3QJRvncj67t4uke2sqnY9EVAsg8wqU1MWE9iSUOZmsSGQgXAQrI
 riRwhZgKgleyN4cZgrwol0Foc9YtJohEpzTjCaojfIUyWHYGBysCJHpMs3tTbpMx3TLo
 054Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kPIA/Y6YnQ8BkTvSAb35KC+BDCx2WLPuot48lTO+AWE=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=GYD3X/Q02QqgYXyuE0EkR4Le9Gbcvso5MCpDbT7kjdK/XmNa6XjYr4u4X9KRLuY811
 HacaUwA8c7SaH1j6Wor1ox4bL7Mg+sohDZlQSWdDyLSChq2fl/Xcr1dRPpQaq9u1aAOJ
 fl0i31TMaGxs/59rS97FWvxPxaiA2L/miR/CdAK9O9fPxs5ZWod8wX7nFw51ufM7a+uF
 QN1EOY2QTaK+rEfi6Axq18gjBvDud8FjxAmJXucOi1sKUanfqJ1C5G4KRFMgm0qssNW3
 Fm8khmsnHkxDNGzCdnYnnLBWm77632/S4SGX+U+h4fKeWVl4boDiiSvfAaRN2vwZHlBS
 H4Nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212881; x=1791817681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kPIA/Y6YnQ8BkTvSAb35KC+BDCx2WLPuot48lTO+AWE=;
 b=Fb+U4q+lAoRo2rafPucz15Jrv5aLZmSo+qlRbk5xome8QAh9ffsq0XKNeGvLIHrttN
 Hn7EZtfEtkWNDi66BVbcuLcttnXIT176C04Bz6WQ2LwDUtvZMtGdPaqMxzzBED5k3hAK
 iF1CaZ77AH0cNrQ36DKGW8RuONxLxjoBAFKE0kiKXTospImaCLUy7b8sAf2g3mqcvB5f
 BKd2+99WvwDwNh7nAE2PGq/vJq3sWb17GpyvkQdlT+R9wGzEiQ+JR+ZBlBmPk1LCsHkM
 KebO2Ils1awgWXec66jzh1wce1GadPYGClFYkEeA2IhINrMa/h08i0t4kfQYu/06nka0
 wX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212881; x=1791817681;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kPIA/Y6YnQ8BkTvSAb35KC+BDCx2WLPuot48lTO+AWE=;
 b=IucGviMLS6ZK5OW0YdgB9kkhReBswshMfx57TiQJgWlkMDrYGQk3K2bGGkyHy+gvvg
 0ZsbkVJMHK9qUyMwurz0ErM3ocD7tGXbZuahv7fCodSphzCRe/Cr6asfkOY5LV75Kp91
 LXgVWB460wast/uOvaTcgwBgpGEPyEXTe8r95ove9Fu0qACKRsVI3Nb2IZ6PkQKVuQqu
 antXRNvfDTWMoGEmoCEHmfxwLlrDyhgvtd6V1KXcQOHdUtiFz6RIgzk55ujKan8TMjxW
 06PLjPF4fs5V7HNquUFqgmZ7wzxpMVUu6WzyeUZ0GoV10I9vMqskRCOvaMHCUSPfkI9R
 iUFA==
X-Gm-Message-State: AFq9FYJMumnKSBvGa0EHAfiZ2lLnuIck2hyLaXHOcGMEiWvJV6deK07+
 BOQGs9F3n/IgpVvgUF5ESjzvCpBNuTtXZQW70NEAN+ZgD31Q4XZ8UXbeDH3mmNF2fKTWaO4IDo6
 mKAnRpv25yOMC5CgFzo1YxkFpIEkoqQE=
X-Gm-Gg: AYBFou3XE2NoGaBs6E7czwxorHTMRDXw4PX5Ny8qEIaeRDTLhzXjYJGDftGQaexBXWq
 5N3NVM6qGHXMcRq3ZOQDwqTk2LTieqQtwWfpnPxsWxfPvZiNw2Gi+xzN/5dRv3qsIeqsUzWHH5g
 sMgado1WwJ3QQDKhAde6t31/D75BPFh0Droc1MQNjPXL8EL4ju908CFg3Uaz/KgJ1mah6X46mxA
 z3H1sPizZlRh9OFjD694UFJgwCOq6TfNGJdNuUlphtdf1Plj6N3H+JnA+A211ydT5bAaBPzKOYM
 dBRWEh3527/tu8bBnhLyzSKfqDyKnvXt69gd2bm4ePNTafQlVi64HvTi7G/b8WiM+YG9apkghgC
 vb0GnH0Q1+WHwXrXipsBHjvCwhg==
X-Received: by 2002:a05:690c:e3eb:b0:8a9:977a:4149 with SMTP id
 00721157ae682-8ae95af34bcmr29299547b3.72.1791212881434; Mon, 05 Oct 2026
 08:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-13-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-13-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:07:49 +0800
X-Gm-Features: AclHuK-X1jJ9gj8trYB-27aVTIcLsV4TeEVO-uw44W-_q6RXFeLphOyDV4uG6jA
Message-ID: <CAEUhbmWY7ryV6C2=+tkrpDr8GPSavucZAVMGfYZmhUz3AB_26w@mail.gmail.com>
Subject: Re: [PATCH v3 12/31] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1136.google.com
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

On Mon, Oct 5, 2026 at 6:23=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx25.h | 5 ++---
>  hw/arm/fsl-imx25.c         | 7 +------
>  hw/arm/imx25_pdk.c         | 2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

