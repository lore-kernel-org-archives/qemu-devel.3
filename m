Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62EDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBc1-0007yD-R8; Fri, 10 Jul 2026 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiBc0-0007xJ-2a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:49:52 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiBbw-00017b-E7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:49:50 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66771ded50aso1587593d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783691387; cv=none;
 d=google.com; s=arc-20260327;
 b=NCOY0AaZylSMNfVYW227ViPOIjwFuzSRZ0nYV/3PquFy5d8tjEXaDyiv/N3GpDp84P
 OXkMIBgHWFIBvwgUQbsxlOLfEgNeFr3MsUiI2EGr9k2Edx2My6TqtXT9yWODtI+jq1rR
 CagRz/rShz6VwAEn7NF9V7Q8YLo600uBCsAXSij0K+DBcVN3k7GCfBmUbV14981cBQ6B
 g9cEvNfXlEUeucjEQ2FS546DXmtEoopd8GDtmnqgtU+DPdQqfHc3Vt2QTHWKVstjMGCJ
 a4xTSBAyQTzkQ/N6zVxPyZKzMXCYWes5JraxOfzy/XDO4ysmN3aDOz1uvDbstQBMH5Iq
 BC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9FHEy95HDKrD+em7DRowOIijJMJSg06LQji/uBbaXOc=;
 fh=wR2fQUyvsEP5H6Cw5GuiOKUlf08ZVMKpkdLkzO0Xni0=;
 b=Q4FPnl2B5SoI2ISdmgd/0UzAYZAh1SJsJj2nZF3PwJgeepxb02JL5Adr+pNalKq0Gx
 rkVsbhSay3/ON+sTd2DerGe0sb+UfMAGql3ZKvybqMJfyc+Pvn5AJkYTZUBrFfvAnaMg
 EelOO58Vfhlawsx3ezkT3hNCR5u0G+Jb9Hyjj6+5egFkvsAdVm4kA7D8sm6pZrJdx9od
 TqQVbylFe7xnWr6+L25KMBpA3iLb6f4eBHi4d9mMGn/B8qer+FhGP3hraEx5dOmJuOMz
 VuTKcgn1CC2jImyPOs05+MvCJNS/jgs/rGmaX9QBrFvHZ1DHD1ootC6eU9qd1XjWwq+M
 v8Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783691387; x=1784296187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9FHEy95HDKrD+em7DRowOIijJMJSg06LQji/uBbaXOc=;
 b=h6S0njRfdiIELRs0z712Bbf3P6g9QZsX4zH/Bciko/h0SBHz1coZ7tFotH8zBkAbiG
 8gaV/z3n/Pu9KP7VVYsq557AUS0ViE8b+IgXQVn/GEKGu4vEyjyXfYaDSEIQPcHRjNBk
 hLn4KcLsS0kd78nKozva4GjsNtpz7Y5cNyTYAommsr/1AJcA4omzm1z/1QlgtoKQY21w
 CEfoL/aJW8vFSRTGF/Ab/gpVwQw8TqG/7XWFz5MOWRKQgHnNMPjen4pXJQh5IXn3jRFo
 6xamWNtcpVI/kkfETzWHpbrReNEvIq7Z66gAgug75QaJG+XRYDRG88vtgv0VIC7v5E9x
 jrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691387; x=1784296187;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9FHEy95HDKrD+em7DRowOIijJMJSg06LQji/uBbaXOc=;
 b=sKtOVCnd0TkEEgP39byiCtaXIybbTEzJsKxfcT5Fg1HHvwEKNSCZT8JkExhNT2Dn+x
 360K1uTQxHjlADeMrH2jMSFSWJzXPy3MXF6Q6Qlp2zFshSM4MgGbbFYha/BWvlIrU1Ny
 1FC3UohzuIsxbigVYKziqZt2CJfCyfXfnzAYWDayv9djdlbpo2cAw0gbPmtVGWO/7+Tf
 E2MC+tnpgs3wvU1y1zfCVmepjn8tgPREQMCEDXfKlpRAJqbbUGNk6F2hfqx2py24wsLb
 ZylltGIk5sce8tTF0KLnSRzvJtb0T88W8TWjU+8v2QrCFjXkYyezitmAqBQr+pvzZP+l
 C0VA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNBdupWIorez2VOTRqcWRiRi6Kk24OskDeSiqMisEiB62leyJfqd4Oev52QC4+sTcy87BSYnS+w8xf@nongnu.org
X-Gm-Message-State: AOJu0YzWR4MFASS0rTmUWeFIcBz9It+e3/4XhaiTZugoD5vjiS9o19uY
 VzmDT5yWJ2vA823yrPbRqDLKnvUTT3za0cppRpXsoUOf11Omti0TzYrZBQwHp4UG1GC7DaVjKXW
 4SAtbuAg5HwAgKav4kMRou6ebEpY9razTXWejFggHRw==
X-Gm-Gg: AfdE7ckQ+6Le6jJ+kw13qpFI77TlBkBJ72Tzo7YNLLNbrVINlFQY3XXBxFaprt3R7Er
 dc1XNTtu0hlG5BAUHqMEbQ8uFIpdCb6Wp8D2Tgj9lDWPYuxURj/CR7Pfg8UasMmNH9pbU4Sqm8e
 TReXnFmopqIHOKnk7KCbl0duszPP40o0iV1gzztpBfgaCua+tv1Q8eKL1gMjljPUYyjLiNFUwRL
 64J6Y/sbyGdqjgXBm/gEBhOEcipaSg0A6v8e67FC88BgoO4O3iIX+T5fNRhkizPYrizvp7hFTon
 oGbSQOciuI0XD0TcEsgVdVpJB7bK3vKjVmmc1pcgHnRIKD/2KKD6OA3n
X-Received: by 2002:a05:690e:43c2:b0:667:8a13:c3f with SMTP id
 956f58d0204a3-6679f0c80c2mr6226539d50.42.1783691386827; Fri, 10 Jul 2026
 06:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-9-peter.maydell@linaro.org>
 <4162f17d-c91a-4e59-82e4-d4c1f590396c@oss.qualcomm.com>
In-Reply-To: <4162f17d-c91a-4e59-82e4-d4c1f590396c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 14:49:33 +0100
X-Gm-Features: AUfX_mw1QgM1LwR9N1Ooz8dtwW8YBTKUeBniwFqXXPqueOTEUJcG5uQg6VhsQJo
Message-ID: <CAFEAcA8_wGzV60Z+8r8U3w5is7F=Vqn=He9xj7JNfqmi+qLNzQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] include/hw/arm/omap_dma.h: Move to include/hw/dma
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 10 Jul 2026 at 14:37, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 10/7/26 12:59, Peter Maydell wrote:
> > omap_dma.h is the header file for hw/dma/omap_dma.c; it fits better
> > to put it in include/hw/dma/ to match where we have the .c file.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/arm/omap1.c                    | 2 +-
> >   hw/dma/omap_dma.c                 | 2 +-
> >   hw/dma/soc_dma.c                  | 2 +-
> >   include/hw/{arm =3D> dma}/soc_dma.h | 0
> >   4 files changed, 3 insertions(+), 3 deletions(-)
> >   rename include/hw/{arm =3D> dma}/soc_dma.h (100%)
>
> Per the cover letter, "The omap_dma device is the only user of
> the soc_dma code", then maybe take the rename opportunity to
> name as omap_dma.h?

It's the only user but it is still a separate C file, so
I think we should keep soc_dma.h to match the soc_dma.c filename.

-- PMM

