Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B9CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMT0p-0002ww-Ty; Mon, 11 May 2026 11:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMT0m-0002tB-As
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:57:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMT0k-0004tD-1u
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:57:39 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so3108937d50.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778515057; cv=none;
 d=google.com; s=arc-20240605;
 b=gR/Qgx+clFlQwU0sMK34sgKe6AHcQQv1Y0sjMZ3sKCz+O37C0vuOl6TKM2OzTfY/oL
 F1sN4TtR7NesQcqPMb2TqwxsVVfKZZjlkKJIZ5im++uwb+Ps3OTFoArPAvR/pb2KuoBk
 8mpfQC3GYvXSBKmgGTUmu4ov3mcQmYQeGsDMPLeI4SkoI2L12XaJ5KHs7szPiKEZt/SO
 lSAym27xqgnwhUSaKFc2WMy+fSNzErojOcy9o8lt/pXh1hVu8J8+yS44GVQbjOJN5c6E
 Njp+g1/hflB2RwV5a3frmpG+qrFhqc9yEi+1h334qL1Cj6i8cIjhLt9/sVZfBA1HrIZS
 De/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eqrAMGl9NMp9kikl1hyfJKPegp87kKq6C5dPX64G6Gc=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=RpxRzHl44/d6B0bKmFg4EbOCPz0G7cZkokhtde8RFvZvN/mX7v3qXZ+qKMj7giMws+
 RZcebkqANjIT5H7QWQjg/Gddt175FZHtHn7SgCkdLGDkFoBtccb+B3bgsFxD28USGCO8
 b9DMXPrWlzuaaFR8yEfleQi+YtEpNPFHmppDIfqIByz5jwQwS381xxq6MlYt6oAv29k2
 vCVwwYh1kIBEzztwk7DWKIAl2McG4uYiD4UGfxLAibuaNKyNKj29CjdlMgoczMZQVlJy
 OGG2iKEk4j1k7BRujamd/W6vW01WO8jA1/FEwdIFgqrIYXg0MQHrN6s9iLGkb/7R1vcK
 zRIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778515057; x=1779119857; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqrAMGl9NMp9kikl1hyfJKPegp87kKq6C5dPX64G6Gc=;
 b=j+EWvf5keQ28FZWi1ZRE/h5STsRplPhC8W4/kogy9ujIwOrjYfoXbl8m45jrFQIdVG
 ifsFvDxRpARrugE1h/RNMMOLQPFeS3dkFYJKxHYZoZNqHVMkOpE6MtACY5MZZV4UsNJg
 GRBS3tJkJvqS0HMx1xD/mO53qi+Nvb2sxU7YK7xgyarJ9b020H5sMhns7pcz0j9KqCWB
 Qo0anKLGOy8zRlZev1Vcb++VwsSQmbc6tXr0ouroQdXT2qmqCAA1M1XsywQ1niZvwZMy
 cw5iEUyzdAEs8SSWczomGHGRbUgaRt/w2/QVwVK4J40TiLs9J3CgmFKkaTIWyT/E+oz9
 MBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778515057; x=1779119857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eqrAMGl9NMp9kikl1hyfJKPegp87kKq6C5dPX64G6Gc=;
 b=CElW8otuK7/csJQnd6Bvirq9pbSNY2QhMv6w0jcP1NSZEuR0oouVP2qrQNjSH547N0
 JpTjKoSxEvkGFws6fTORBNZwqVi9ml/CHaNuwQ868a97iATYfD6opura/h4rguDpJHqa
 nf+OnHfSf+3pKS41roVbK15x/tCDHDwz2PvFu2/O6lbGct+b4wDZznxJRmmxGSEvCjl4
 HISjbC/6JA0VLuzY0FFi5C4vnHA912w6S4pibGw9kIgfnbnkBrVvQm49n1Znxeu/elb/
 jgXR39HrLa/Vzpd0jtXGidcnEpIwQtfLF7xWX2kdsY9D2nn1Cau8L8FXKkbEIEkhv4vU
 ymbQ==
X-Gm-Message-State: AOJu0YzKu5mGCmIWzgsm1hU/6NGcFhZeH9+GEW3dk7j06WlvDZb7SdAp
 +vwWcPZ1XLDTjJHLk2njAbydc4vBdcRq4izhzlqmXECbClboDkRWknAfjz0QU/tRnttCYPbPRcs
 4Dpme2g/lN30xaP5F43H2KkKoleZQVFTaMwu4OlHNYA==
X-Gm-Gg: Acq92OGEcCqE64I8gXoZCTqwoxMyVOrDI9t4mBYcF55wH8XvsgRIAy+4qtvjZ0JiFRP
 NcGGMl6kOKEMqXI/ZXre99+DdnDThXQvfwOiWWhmjGsWsuN4mMCRmjCcxsl8jqnBCB1us1ImZv0
 ez8r+qcEHe8pQvUwoBhBtdS8AbNcs1wn737RB3ztkvtPc7DKHcG3dJayR3CCax4AlHcGXYuwdRW
 2D2oUgyZkZhobqvzB/AEGeq+4ZhlD8UJv7bXmF8yQaBrX2SJaS/3Wpa72pw80mmLxnn8/heq+c5
 eUetUyfZJsKjG6i0ROiqh2NEQGUgue9vAfg7gboyb99dovgmBLwuw3832l1DmvyxS5Tbk30lFmG
 p8w==
X-Received: by 2002:a05:690e:408e:b0:654:1261:8bab with SMTP id
 956f58d0204a3-65da84bc6bfmr9806391d50.20.1778515056621; Mon, 11 May 2026
 08:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260511155617.99522-1-alex.bennee@linaro.org>
In-Reply-To: <20260511155617.99522-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:57:24 +0100
X-Gm-Features: AVHnY4Ir6pRMMvM7IjFNg-OMAyXRxI2g5URLEq9xg4POtdrg5DRVqpudWnISI5I
Message-ID: <CAFEAcA9_An2a2G1=xz1rF4tckmfzvc8047n7Kzw41GVFfZBaDg@mail.gmail.com>
Subject: Re: [RFC PATCH] gitlab: update issue template for binary test cases
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 11 May 2026 at 16:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Binary test cases are sketchy because they can be vectors for phising

"phishing"

> and other malware. Lets strongly hint that source bases tests are
> preferred and binaries should have their provenance declared.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .gitlab/issue_templates/bug.md | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug=
.md
> index 53a79f58284..cdb7ac1fe72 100644
> --- a/.gitlab/issue_templates/bug.md
> +++ b/.gitlab/issue_templates/bug.md
> @@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
>  <!--
>  Attach logs, stack traces, screenshots, etc. Compress the files if neces=
sary.
>  If using libvirt, libvirt logs and XML domain information may be relevan=
t.
> +
> +If attaching binary test cases you should describe where they where obta=
ined

"were"

> +from preferably linking to the original source. We greatly prefer test c=
ases in

"from, "

> +the form of source code that can be audited before compiling by the engi=
neer.
>  -->

thanks
-- PMM

