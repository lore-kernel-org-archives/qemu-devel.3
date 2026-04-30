Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF5EFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMNi-0003C3-Bi; Thu, 30 Apr 2026 04:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wIMNd-0003Bo-OG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wIMNa-0002D8-9y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777536252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGLKw0YeAuHAbOQ0dN0jxdbSk4trZsfsFYVoo5cC3ZY=;
 b=a5VUanNSwVP3YNG0g6nL5w+44nyDmnumL4p84kq2+A4K45GYq+sdC260cLGBm+UD2ZY51X
 HlgS4lvnu0Z8Ovb/UDG4fVv2Z6M6E1/XJosBk3eyhQV+DcdQtzgcGfiEnDhQAp3cVTuxVZ
 nT+CbFoqAHloKmpngwTWy3SlUqLAbtg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-tnDXEqy2Pkurye8VyyKwkg-1; Thu, 30 Apr 2026 04:04:10 -0400
X-MC-Unique: tnDXEqy2Pkurye8VyyKwkg-1
X-Mimecast-MFC-AGG-ID: tnDXEqy2Pkurye8VyyKwkg_1777536249
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so418311a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777536249; cv=none;
 d=google.com; s=arc-20240605;
 b=TJVnEhvWS+khT7MfoSRswDOl7H2QNFesbmQE1CSYsgFqFhZYrG7ceQbQ9YTFROdqa5
 LXBJhBOzl3G8qWHBhIn7mgRSYnnVB+q1tLFQ+x6EumSVqKByypi25RDTLMn0m/EvqCiU
 evUsaBtNzpa/4e5aqH1qA51iVkiC92oBT3+LnMPI5eiM9Bd2zsbDUEplZJskk9hrxusj
 VbgAamKf/XaSOUqWeKRpCMKHmYeLUTOvbj6EttB96OfM/ehGNWpnbwi7pkJvkgrG/lWH
 DEtHzoXmKltLhv58N6xyU0Dti0blKWgzFUmYieUAbrAeQpZCwn3L18GqtnwwKDsupG3F
 PQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rGLKw0YeAuHAbOQ0dN0jxdbSk4trZsfsFYVoo5cC3ZY=;
 fh=dHZQOGH1yk/5mREwQZVkadq8q6ceUBLKIxKMy4NuQ6o=;
 b=RSyT9qEegtGoaFQTCkTllaqCG8kpnDgt4CFt0hVlZDt0GmtICXq3+BsYePrnLqMCN8
 J4AmzZIVnFros2SjzJKQgVXqUgpZS62K912hGoyQLiJHq5zvrovDtp8EvyHhgfXdlFXL
 MQVSkusOvESgRs3e6HXD+2JoiwH/4CyaH0DC1p47c4IOCkxj9LV8PRO52cnVy+//OqYW
 uWAMiUZQaaYBFyZ6fjrOFFIBnts9aYX/PeGcYNj9dbnKbpokgtOEOF/5BQW3RJ9jpGk0
 dg/bz6J8IJcg8bIXr3Hg/5GaPfwxC8GBxqGRRb5WonHxaTeLo9rAvOXHP5q3baoToZ8a
 H4vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777536249; x=1778141049; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGLKw0YeAuHAbOQ0dN0jxdbSk4trZsfsFYVoo5cC3ZY=;
 b=t9OpnmQIeROQKNu1q+bDVxzBGYFzQjny1VmPBB3rYDKxashytM+p5uphURQIODtYgn
 pZlWpBHj3o+aqwvQZchm0P7b/x4eBE2LgCOhQdQCzfzZGbMxXuH+7/FRhnSFLQDWpxdp
 VqC9KBB6HwvF8QDhR8CZT8Uhyt4mhnLPuO/EhTr+if2BtDjrwjtoW13onC20T2ipNLTh
 4HPmKE71V0rD7RYgIuUw617C0Glx/h5/vFvLibItvCs3rSHCTln70gTDwHSNlsc7oQdh
 1Qa4H7NoPFEZodG6wo4/KKTS4aLL3leCQqkF8VGJEubjrRyNKUVaRCtGGYNe2rg1BxrA
 4qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536249; x=1778141049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGLKw0YeAuHAbOQ0dN0jxdbSk4trZsfsFYVoo5cC3ZY=;
 b=O6d1DLCTiPwXlCXa9kRhuAJi//nwQ0S5osMqnHcN1rfeAsYp2h8onBENWGyFwScjWn
 fiK+jfDO8khg3C9rZaTeTRM+1C6RyCeCC84RzzA0eT2p2w5UerQVs56CGAQ51mqH+uE3
 sxnQygD9AN8ptOAafmkqTsrwlSMbbyCo/XzONo6wYdTgIa7JbLQnvclprdt9NtzPX0cp
 42Ihm2hS/c8giiBfzUpAZWx6+YSn36nG+OeyJPyTQEv/erlZ3gy6dOlMeEBW3KDc54Um
 KdrIDMTsqWxDZcSbpuzrEFQyf14iJmbL45y+1cyDnuSkNHRZGxter4lMLM1wHijoGqfe
 Pw7Q==
X-Gm-Message-State: AOJu0YxNjpfjZClbIJoAf7qA1rGwD5pJqN3uUav/mjHuzTnLRxTtzzMJ
 Fg0aXoWqrheItlqCPwZDqtUtWJndwIzeegfV/KUGZQyKx9H/QjVRrKy8GvpRfeoM22b0BA9ET1w
 J9z2UnxhsfoTUsqaeKLdLHkMq9GWXPMdKwOl/cJeHXM/6sGAVwJRYC7lyrJIyIXtAlpBx9berux
 uw0jcEdIlZae88Lhjz1dRzNpPwug6Rd1s=
X-Gm-Gg: AeBDietx1xM6ql6rB43Bv1yU5Nlw1BbsaQ9XuRR7XansmRDvXZl/rQ/MmKtdXlJcKzE
 LOqJfZym7WpklmKaKSH4pzsjGYOMo87xuUx44iKkUbQS7lMyrB5G25oaJfMBcyhKdM2osklJ01l
 3UD//IFq6R08WitG0NHTLwrHrGlh+NZLxUAReBMPTbyR5ANvUH68QihjuRhOiiXSEwflmeji//p
 SRLDOHboPdfuwqQaoTJPF69hOOWXH7obRDu/mOlqFkAhHAmcc+VVD/4BFfrahqCfCwgm5mAc+ai
 QzTbbKERveAZA/+ZKC/queNxnZgf6GbCDh8=
X-Received: by 2002:a05:6a20:9392:b0:3a2:d68d:9e6c with SMTP id
 adf61e73a8af0-3a3cf976d78mr2008547637.56.1777536249132; 
 Thu, 30 Apr 2026 01:04:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:9392:b0:3a2:d68d:9e6c with SMTP id
 adf61e73a8af0-3a3cf976d78mr2008529637.56.1777536248694; Thu, 30 Apr 2026
 01:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260430035626.3511676-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 12:03:57 +0400
X-Gm-Features: AVHnY4I4lRQAhaBuhPVZO1G17pf_IoGVLqjY-spjP6SyjWIIaW11C_Le9gehz_w
Message-ID: <CAMxuvayPtYgPobPaBMoZ7UaWNdWMdOwiVAeP9PkDv8HxE_ZaFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] target-info: extract target_info() definition in
 target-info-init.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 30, 2026 at 7:56=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> This allows us to prepare next commits, which will introduce qom
> registration for system mode.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  configs/targets/aarch64-softmmu.c |  6 ++----
>  configs/targets/arm-softmmu.c     |  6 ++----
>  include/qemu/target-info-init.h   | 20 ++++++++++++++++++++
>  target-info-stub.c                |  6 ++----
>  4 files changed, 26 insertions(+), 12 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>
> diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-=
softmmu.c
> index 82ccb575759..75d95b0e743 100644
> --- a/configs/targets/aarch64-softmmu.c
> +++ b/configs/targets/aarch64-softmmu.c
> @@ -8,6 +8,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/target-info-impl.h"
> +#include "qemu/target-info-init.h"
>  #include "hw/arm/machines-qom.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/cpu-param.h"
> @@ -23,7 +24,4 @@ static const TargetInfo target_info_aarch64_system =3D =
{
>      .page_bits_init =3D TARGET_PAGE_BITS_LEGACY,
>  };
>
> -const TargetInfo *target_info(void)
> -{
> -    return &target_info_aarch64_system;
> -}
> +target_info_init(target_info_aarch64_system)
> diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.=
c
> index 18940e51e55..73546fa5737 100644
> --- a/configs/targets/arm-softmmu.c
> +++ b/configs/targets/arm-softmmu.c
> @@ -8,6 +8,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/target-info-impl.h"
> +#include "qemu/target-info-init.h"
>  #include "hw/arm/machines-qom.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/cpu-param.h"
> @@ -23,7 +24,4 @@ static const TargetInfo target_info_arm_system =3D {
>      .page_bits_init =3D TARGET_PAGE_BITS_LEGACY,
>  };
>
> -const TargetInfo *target_info(void)
> -{
> -    return &target_info_arm_system;
> -}
> +target_info_init(target_info_arm_system)
> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-i=
nit.h
> new file mode 100644
> index 00000000000..9be06d8523a
> --- /dev/null
> +++ b/include/qemu/target-info-init.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU target info initialization
> + *
> + * Copyright (c) Qualcomm
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This file is included by each file defining a TargetInfo structure an=
d is
> + * responsible for registering it.
> + */
> +
> +#ifndef TARGET_INFO_DEF_H
> +

missing #define TARGET_INFO_DEF_H

> +#define target_info_init(ti_var)        \
> +const TargetInfo *target_info(void)     \
> +{                                       \
> +    return &ti_var;                     \
> +}
> +
> +#endif /* TARGET_INFO_DEF_H */
> diff --git a/target-info-stub.c b/target-info-stub.c
> index f5896a72621..af7cdc5e67a 100644
> --- a/target-info-stub.c
> +++ b/target-info-stub.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/target-info.h"
>  #include "qemu/target-info-impl.h"
> +#include "qemu/target-info-init.h"
>  #include "hw/core/boards.h"
>  #include "cpu.h"
>  #include "exec/page-vary.h"
> @@ -40,7 +41,4 @@ static const TargetInfo target_info_stub =3D {
>  #endif
>  };
>
> -const TargetInfo *target_info(void)
> -{
> -    return &target_info_stub;
> -}
> +target_info_init(target_info_stub)
> --
> 2.43.0
>


