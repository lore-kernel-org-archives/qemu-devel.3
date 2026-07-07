Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2906FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2NG-0000HV-86; Tue, 07 Jul 2026 05:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wh2NE-0000H8-On
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:45:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wh2ND-0001pn-6V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:45:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso967507a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783417549; cv=none;
 d=google.com; s=arc-20260327;
 b=WwDMmEP99tuIpW1YTMl9QzjowpvygAeg1ARd589ugCbQ4PDn7Hsm0xiSGz/m0H2iEo
 /NIlyQn6IZn1ktdwlJfQJZuSwUcA04VfHWecyJM9tqPjqGq0V7C1WoabcohDVJUVO+27
 2SoWo7jV4DBdZUCXBmX69xDxPeGehHkVa2BI1oWb4vunGtGXfEgX1RxSlYAfvgfThcgP
 mIhXqPGmdFt22FcH6lJRXWq12x3USOPUmyBJh4AxXY7b6k+V/PqI7TApMxbd2FMQrokt
 33x47C3FdfgmkKaiy3YpbM8ZSllHqYtKhhph7e04k3WOHkSWWhjzD1hEeUlLjHDhDKg4
 SVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rYntU0dy4niKq7cyGjdJYtPd9ZiahQMZwLW2R3JNlgY=;
 fh=Lg6DYHnKMmHCVFaM97zdbaaapNtyHCw5bqWUTFlcFYc=;
 b=mcaR+rQWWZyOpyQRuZDM63uP+VIleBDmFplbFUOPLN92S4qikYD6NAnvy0KSNuniYJ
 ewAImkhi/8im95JYMAocLoxvIS7nM8lkR2n0ug7rdF/T7S0qUB7N00qFbIBFBubXHR42
 /qGOxbW0gL5CAVDA+dgSjjOzxUy38MZKLMJ/gXRhyC2caTDqDndp4hqwwtRxN6gw5NcD
 wQWHGjUK233nUUxCTVkOiAo+LEnomIguIj75TGgVVApVJRaP6tHhXIWZTe4DOFR+WCGy
 5mdLfgp2usYzyw43KDOAxg9MsN7Y7ZcmdtgMG6mBVAUMhNshX7z4A1DQdFah0GnLYrqq
 Q51g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783417549; x=1784022349; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYntU0dy4niKq7cyGjdJYtPd9ZiahQMZwLW2R3JNlgY=;
 b=IZqXjRmiOIipuknNgfI0nOWxXAUyi4F35/GwlP310x8b/5FBHqRBKYBephrhIY2cSU
 EKV23h+pcAbXG+zc+msuZZLEIVjdd9ZmvugKcpCr27SZsman1M4XDOuT4fDkGzwOAile
 +asQjYOT/ElxM1KL4UP+Ah4LJLCv4a2L3OTrResr/LdLS49/SDMnCVnMfavgqmr0Ss1b
 fEUU5/vMuS6j/I+jo5g1UoGOEqFmshZaYzL2WUIgjhX9SKyx/UutLVFOZ6LtZmTWPmVF
 kljbt96bGSf/H224ADKzwuFTOo8OfPKFZIVq7AYOMMBC9zYCp4OH+w8ex2yRXKsZU8hc
 VriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417549; x=1784022349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rYntU0dy4niKq7cyGjdJYtPd9ZiahQMZwLW2R3JNlgY=;
 b=W3Juf3unT6X/eS1vWnLuMISogBQuylo9IvcWMhiAlIEpndTaLiNICGtpeK+1M9XYA1
 lkpo4jvEBmIs1jbsqTeGC2zEcaL8QK4JiiR9B8obND9rHToJVMulC+KM6g3oJep7MmRE
 cHc8h9x9gGfvxzwCUZRWw9obeYJ4onkdzpZFa4cEAI+VO8/cBimsbujYj+tn7LmoE5zK
 7hKNMs8L+so+eEQdjGBEqad3GEDOMuH8jSisvHse5aq7bK778vvXKmFZ92OLErkGWp+R
 LuqzLyeqWp/RxHANSNbx+luwQQTroSlN3Gqo3v5JFOcMCvZOVv53bEpbcie9TrOFu9R/
 4WeQ==
X-Gm-Message-State: AOJu0YwAoBvMCZhpBx/zIurIUBUqoZTi5UuXvw1nzH98+rB+CXEAElve
 7DaXaoDZpbQB+pq7Hv40pgOBAVSK2+yuHh+7nAkwHGVSapUmpN23tqVzRdWo/64Mdcremk+MnuF
 wWq0yumO2ba/0/R/9/v4yr9gRXvPFfrs=
X-Gm-Gg: AfdE7ckMEBss2JDmEczL7tlzoeV246EBBusnmLBD+grzvN/RJmoU3L46+DYY/pp5Raw
 WdooqqL0V8FLiod6UHtrnLVCW39FgyQTfZoePXKQ/2B0zJs0vsX+RaKklGuTT9biSDgWYi8HNZU
 93egSnpaUOdJLhKY5YZJsBJ0Xo/5HlNY6mppC3Foh/21eKeIJyH7aUo6RnOn8hJlS65ouP4DKgc
 bfHVoQkdE5AWXqlnKDUpWvI408k10pNxTTmT2V2Z5Mc9UBLc5B4XKKpdm2hxrUzq3ixTmgm
X-Received: by 2002:a05:6402:234c:b0:698:485d:14d7 with SMTP id
 4fb4d7f45d1cf-69a910ac7f7mr1057354a12.8.1783417548928; Tue, 07 Jul 2026
 02:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260629015346.17653-1-jasowang@redhat.com>
In-Reply-To: <20260629015346.17653-1-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 7 Jul 2026 17:45:11 +0800
X-Gm-Features: AVVi8CekSBI3K88mkQTyCB2jklQujbhvf-ZKZP2vGhYziF9STNQqrnUoF9FTwps
Message-ID: <CAK3tnvLDS7cyef+N1m3JUyedXCS9dr1Ao96u57ML354=Q3R+Kw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update Jason Wang's email address
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52f.google.com
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

On Mon, Jun 29, 2026 at 9:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Update maintainer email from jasowang@redhat.com to
> jasowangio@gmail.com and add corresponding .mailmap entries.
>
> Signed-off-by: Jason Wang <jasowangio@gmail.com>

Good luck, Jason~
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 34c092714a..8ade2eed66 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -31,7 +31,8 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c=
8c-71466251a162>
>  Aaron Larson <alarson@ddci.com> alarson@ddci.com
>  Andreas F=C3=A4rber <andreas.faerber@web.de> Andreas F=C3=A4rber <andrea=
s.faerber>
>  fanwenjie <fanwj@mail.ustc.edu.cn> fanwj@mail.ustc.edu.cn <fanwj@mail.us=
tc.edu.cn>
> -Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
> +Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang>
> +Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang@redhat.com>
>  Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.=
com>
>  Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs=
.org>
>  Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72357df7c4..6160d86825 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2275,7 +2275,7 @@ F: hw/char/
>  F: include/hw/char/
>
>  Network devices
> -M: Jason Wang <jasowang@redhat.com>
> +M: Jason Wang <jasowangio@gmail.com>
>  S: Odd Fixes
>  F: hw/net/
>  F: include/hw/net/
> @@ -3448,7 +3448,7 @@ F: include/qemu/qemu-print.h
>  F: util/qemu-print.c
>
>  Network device backends
> -M: Jason Wang <jasowang@redhat.com>
> +M: Jason Wang <jasowangio@gmail.com>
>  S: Maintained
>  F: net/
>  F: include/net/
> @@ -4045,7 +4045,7 @@ F: target/i386/igvm.c
>
>  VT-d Emulation
>  M: Michael S. Tsirkin <mst@redhat.com>
> -R: Jason Wang <jasowang@redhat.com>
> +R: Jason Wang <jasowangio@gmail.com>
>  R: Yi Liu <yi.l.liu@intel.com>
>  R: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@bull.com>
>  S: Supported
> @@ -4480,7 +4480,7 @@ F: subprojects/libvfio-user.wrap
>  F: tests/functional/x86_64/test_vfio_user_client.py
>
>  EBPF
> -M: Jason Wang <jasowang@redhat.com>
> +M: Jason Wang <jasowangio@gmail.com>
>  R: Yuri Benditovich <ybendito@redhat.com>
>  S: Maintained
>  F: docs/devel/ebpf_rss.rst
> --
> 2.54.0
>
>

