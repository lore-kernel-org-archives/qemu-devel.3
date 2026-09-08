Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A53C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y6a-0000Fx-AY; Tue, 08 Sep 2026 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3y6Z-0000Fe-0C
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:51:27 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3y6X-00085E-DL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:51:26 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-855a66e5b5dso38002007b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 08:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882684; cv=none;
 d=google.com; s=arc-20260327;
 b=i8rZHoXjtdJBaQZQxpVbhwpRLhlVY7GP4Flbc4Q5n4XDVSDobC11TJFPfSYVnRvpyv
 ySZmOXLNaGbbd26XdPTaWybfKAJe0oBtddittGpTwa5BiWSeg1BCurvZwEZoiFtzPSQY
 Mh8Btpi2o+h9VCgWjZf37SZz/LG9UhsOp1SLRLS86hz/fjoc2fLcQYRLVVTIFaNKEPGC
 O5cU7c3yaNIMW/bKfTEG12GfM/s5zxsa7a9ZhNYWbHMUAKHoILN4rFicDqtR9i7/LFDm
 THNRGMicp//zBOcO83zmcb1uEdNDIQuQ4CvNqDCYjZ6CSNYdEmKG93hjFW8f5ZCNjfcF
 naPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iMSUhya9L1kjCNqSNxSRyD9vraXGuJKfOwQ38jodovE=;
 fh=V4/Fk53ndankTtc1WBGT96/wJD2tS50dQDvAWjyR/MM=;
 b=WpyCjgW1pFpwm9E9bWDyG986qwGgOICfB8jyIAExc3XegqfaGQDRErgXlizjKvz3IJ
 dgiGXN+AwB9sU/en6AO0ydZ8P/wrpLLQYeW7ODl1rBe3Yf7Zv+G1ZWdwRf1xqf3l58wy
 l8bF+8CmrZdBhakhBJi8i1NxJYb+wfPMbFMNkiuJkTNy+FST0pcxG1bUBuhKUYPk4vpF
 IStxuF/DqJKvDW1n1xpuQM3B9Iu0RFinOasV4KzSbRhXMTdKJlws6Bmkr4P4vtJkT6Iz
 wY8JWLIMyvhBkyh7KWvPUrPSrf8UL5sIOAazyCFrNvHviSmA5m1TrDmp6aWpzra6KaWN
 NcnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788882684; x=1789487484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iMSUhya9L1kjCNqSNxSRyD9vraXGuJKfOwQ38jodovE=;
 b=JUE0rfYtyzC95QBZ3xz1rSWrVVxeTCcS9ija/ClsxX1IkPZ0oiquh4hIyDNrcdW9Jl
 LUMa+ns0yha8xu9EFb2Vr05oJ/r5aiyggMpy/nsxMah70aQSTsYxGPrUyLuLI6WfBl60
 fcnMkej34to6AFVCszh4CiBgj723WGXsPI7swp/spgmFD2Jw/qKmaAD3GQzb5V9me8mP
 Wor/QomdmLq5ldK226KwUEuDLkKRq5MR94vP2NV5rlJvAaBAHhOZKdjvLrtv71lMYeHC
 SLRQeb/mfUswgobacqqWcBSUHYnTu+uglembaOXD7Y2eReWR+4e8BqirsvLKxcG29/4N
 Fc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882684; x=1789487484;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMSUhya9L1kjCNqSNxSRyD9vraXGuJKfOwQ38jodovE=;
 b=KrykK/wwGiE1lKxNdF+YrxfE8x7VbV+oCk/mDQ4Hpj2R7HIH14xnMVW12ODXFs2eCm
 m0PUyKT5i8LPinB9Qa+D7CNZvDG7D0qGf0Gt5FMRg+OoSFT7nAI8DAQFheVD1cmNZlb3
 IDgQKBSzlS11Lhkf3aHRrZhaqFLgc51n+1a2UwRNGpdD4dXS68OAZEW5U/1gwGUUYWJ3
 FRgCaTKP91oiPUuDezy/i2/S5l5JawMSoBSajzUF1BrdJ6UP8h2Uk+BAmHD/jhDC640b
 I+2vgYOaah/tQMmSuHdB41BcDRhLlhQpnnPjHzhYeKjK4gX7qtQhl3DY6/GUxPxycWqr
 TYUQ==
X-Gm-Message-State: AFuF++k6yAS/bouqfrdnbxnEuiqb2k9l2ZGxv5WgkTgVi6HZGOTXQelD
 pKYTnJ1zI5deo7ZKLxdF/bfMDr9tfHQU8xZOcpyF4LCUWEilBlUn0QRWz2f2C1SolG0iO+Iibi5
 jmKTV+kk59G/MiXT03lXov3f2jJtw8HvaEKF2MPpCIw==
X-Gm-Gg: AYBFou3WcASii3sN9s664wV1qFq8PufaXkv4/Xe7JYLAYVUj6bfUg2p+PpOIRst7CWG
 nX6EQL6uEQn0Y0fzFse05aiR3TyOm1ayql7eyRu5sdg2xcs0Fo53cT1AZL7DbTOT+63+bp2gMne
 rW+XmP7ZqIUUa1G08etKaK2ziNhHPQPFy8bAH/VB6OTV+cxx8yxo2CmVUY6FBWlLvWxKETJeAnq
 x29Md/YCwPEUUMTWiczc9jKAPwgt6xt3F48QSpLotGD6tYegTYDad3jb9TNxnXCnb0w6o0WdRj7
 js3VHGROBB/W8TxjgmkD/AT00PACmNkwCYG/dxOiDxxAjErdZS119ov1xgojNQ8sjPqTUDQAX8l
 vnOWkpB2dgnUbgjXM9aVZ68QCS3SzE8yCFRV/WUmA
X-Received: by 2002:a05:690c:4a01:b0:86f:8707:1682 with SMTP id
 00721157ae682-87125448905mr128150607b3.5.1788882683810; Tue, 08 Sep 2026
 08:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260902165956.582901-1-alex.bennee@linaro.org>
In-Reply-To: <20260902165956.582901-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 16:51:11 +0100
X-Gm-Features: AcwNN1WHXR9H2SYPfeucCTOX1WEAQqGcPhoh8q_G0dXyXkstzs6RFMkj29nSq5o
Message-ID: <CAFEAcA_hbEUYO+0vSDZDGtyp8uo+The9q_Bkry2WwJY40EVvTQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart: Accept character input upon RDR
 read
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "open list:STM32L4x5 SoC Family" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 2 Sept 2026 at 18:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Looking through existing serial devices this seems to be a common
> pattern so it makes sense to me this is the right fix and matches the
> API description.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
> Reported-by: Jan Brittenson (@bson)
> Suggested-by: Jan Brittenson (@bson)
> AI-used-for: fetch issue, apply proposed patch, verify build and qtests

I think the fix is fine, but given this tag I'm not sure what
you want me to do with this.

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

-- PMM

