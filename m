Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1449C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPe5-0007hu-GB; Tue, 18 Aug 2026 15:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wwPe0-0007fs-LJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wwPdy-0001bi-Ri
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787081920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XODjaz3/MuPJ/ctkepLi/wVb3n2XPQPMWXlF10Nxg9Q=;
 b=fBwQM0l2WPHRLbLpe9D3bLCRQkxWolAjxbZIBMYRS20TKeo1Bh5MJGhd2Su3N3Nohqkn9L
 TCIJDmtXVmMx0LnEyKiYhgKGv5AdBFYJBPL7wUpz8h/1vsbTvcQtHhZWW9fRnK5SVcChwv
 2HUeO47n3UcI2Q2rdsfWMmZIdH8CWY0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tux9759qNX-KHaQK7LiPkQ-1; Tue, 18 Aug 2026 15:38:39 -0400
X-MC-Unique: tux9759qNX-KHaQK7LiPkQ-1
X-Mimecast-MFC-AGG-ID: tux9759qNX-KHaQK7LiPkQ_1787081918
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so2399365ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787081918; cv=none;
 d=google.com; s=arc-20260327;
 b=ATa4lswYesbUwUzsNFWDg2bNpd5AJc/tL+YgRgrsmJ9d0On7FTLUAbl9Apa9rMmtGa
 bxuPuF3LVnyMP/OFSVrCX0yWIZQTfDdjSrO+24HewsxqwYjyb9D7lDjNSv3thJDShTao
 wp4Os8Iamjj+Er9+6jF1N4XWylLoNWENjgcFM1XxuSQLryeOJrAlaFUEfyaaXoODspJO
 jgszF7XDfpUlZRUyoxLwVo+RgTePU4VxiusvizfE1d8uzd+r2OaWc3oDANBgKwzwnISL
 5LZw+IRMVb8eU+LJWmJ2sG93uRIEhk9afmJZAuSvy4/pb5jswq0G95uV1qNyfuEmGx8H
 +Cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XODjaz3/MuPJ/ctkepLi/wVb3n2XPQPMWXlF10Nxg9Q=;
 fh=M6zhbhISD7mw1NOyhgcYsRWx/NoTLa4JRxl9cNnyUeg=;
 b=G4LoKELIyAMMbxyZMWtN/UqTdWwlT2H2GT0eUo0Kegj6kXuyh7c/qqwG7MdYPygU5c
 iM4T74Ke9yVHK/5iizRiFk3qYj4cDYsPhmMn5XjtajlJOobP3nylq4C11DIwds9y636S
 gvN+hFO/nW5CXebbNp1N1U+JM/YMdazNhUXM8Oz7gMRfETvwQ8T7Tt5OlSfF5RJhwDly
 CiqLEuIvBff95M5uJtNuSZ0leWMzf2s5rt4Hs9POthbAxN7L8K/vAdYZoHhgM7hDSECb
 GTnP/JiMVwKauS73wPjEheqSfp3ueeaOlPzsWzQSEgQutmYr+Fq44gdRVET9alurKc+0
 QjiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787081918; x=1787686718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XODjaz3/MuPJ/ctkepLi/wVb3n2XPQPMWXlF10Nxg9Q=;
 b=Wx4tTDOqtN5he0sepLqJ+vghp2dke+lrA8B+Cums0KTTkduUShSmWiRYLdd+bfgVV+
 Gnw8npi/pIQzBKkOBE3Wunw4x50F0GzQR1A7JH4DZt8HPo/Y158p5utrAnlYK5X0j7AV
 ukwOwI26tfhwKot2rg3ZUrUbsoxAKIW3EpRMQtgsNSsDqhfBsD02IjkrteMHQ4eLyOzt
 mYC8oQywU02iKlHp48PdNx4MY7rKdd2gOMXP5sNNvBtBliiC3UJEEB9x3YdZ+feBx8cJ
 6fS6v9d1vreNDa7SbdURLluJhrcep/2M4MREav//D76CvuQUqusnHG0aUYyl7MrasCd1
 tvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081918; x=1787686718;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XODjaz3/MuPJ/ctkepLi/wVb3n2XPQPMWXlF10Nxg9Q=;
 b=r6AgmPrEaftiKihv5LikENKk1xkGgkSNqNbg5ymIQ2OdWCHQ7KFco/btsMF5fakTUN
 q8YF4c6S8ZNMc44B/78HUNQe7h+3wm33Cd4r8Xi+G5IuTtOkqvxFetAWgn1TE2yGHYVx
 5kc1qkkOgtYG217okyyNXNZvt8TWu66O5QL+3B1Xt0b9vg1+ZrM1AbvNy66+xjlqau8L
 KIEVgu1ntTLGbwph45NIkjBMMIXmlXoZEbHgQAz4TM4XTuyH4jJ6q4Smwz2IaEbNfzob
 l1p5ItsVhZmJnAg4j2x0sc2A2zvhqJL9oJW2UwJ3M6hXfptTmMMsyAUcE2YTTx2mJUg1
 rx2A==
X-Gm-Message-State: AOJu0YzPg22t6h4E/oOc5ueSWOSkc1B/SrojNCEVaFGR5/MZLP9I0Ptc
 aIdVHU7IAmq3Yd9YWiupHBNhO1fwwk+sqQACGG5z6mOPzE6QlIrYShVOihY+BCgdFBxNUxc/fzU
 b6IaRes977E1naq+6cHQ19iSaSXLxiJYVOweVY5wCcA+oJl+j3eCUKMTjEyZHf5IX2t1Sn9Nl1K
 3oF94RK9LuxkXhjwjMiz+vYm4jyGKiklg=
X-Gm-Gg: AR+sD11iWpBtErrIbcaJ4i+/0phtzPAdyD1yZcsRg3t7rhSTn87pcMpPq055zKSbLcK
 XoEQg+ToYDeqG1tDHkeMnJq/2yrWrw2tW54XdRcljDO8HfMqtxDE+WU1HC7NiOTdL8cRwpVKdRi
 4L30zqEQY72UXLk4ate1WEaYXmg2UzuTdl9B+HbyrEna1RSDeEc8WSIyobl64m6ZFMi9MUUu5Sv
 vB7ZvkqOinjjJjgiDG/dB/0XkhDBAUoa1H5x7Hx0os5roRkqrTnCR+FeAyaOHE2AHog8tqLqKTd
 Ig==
X-Received: by 2002:a17:90b:1f8a:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3957b8b516cmr105131a91.14.1787081918248; 
 Tue, 18 Aug 2026 12:38:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8a:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-3957b8b516cmr105068a91.14.1787081917758; Tue, 18 Aug 2026
 12:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260818193300.2871415-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260818193300.2871415-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 23:38:25 +0400
X-Gm-Features: AcwNN1VrwYgDRx7ChSfp1anH2AU1OU8msIgrWAasYq66Uf34UgIThrihidW38K0
Message-ID: <CAMxuvayhJGjOb7jQDey2V1ixuAYfQNNEFevCjn8x0VKe6KZc9A@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Add HMP info tlb command
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 18, 2026 at 11:33=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/monitor.c   | 23 +++++++++++++++++++++++

please name it something like hmp-cmds.c, so we can easily compile it out l=
ater

otherwise, lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  hmp-commands-info.hx       |  3 ++-
>  target/hexagon/meson.build |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 target/hexagon/monitor.c
>
> diff --git a/target/hexagon/monitor.c b/target/hexagon/monitor.c
> new file mode 100644
> index 00000000000..150045769cc
> --- /dev/null
> +++ b/target/hexagon/monitor.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hex_mmu.h"
> +#include "monitor/hmp.h"
> +#include "monitor/monitor.h"
> +
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> +{
> +    CPUArchState *env =3D mon_get_cpu_env(mon);
> +
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    dump_mmu(mon, env);
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c21..0d31fb8a84c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -193,7 +193,8 @@ ERST
>          .help       =3D "show virtual to physical memory mappings",
>          .cmd        =3D hmp_info_tlb,
>          .arch_bitmask =3D QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPA=
RC \
> -                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M=
68K,
> +                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M=
68K \
> +                        | QEMU_ARCH_HEXAGON,
>      },
>
>  SRST
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 4c921eee73b..a84a35106f5 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -261,6 +261,7 @@ hexagon_softmmu_ss.add(files(
>      'hex_interrupts.c',
>      'hexswi.c',
>      'machine.c',
> +    'monitor.c',
>  ))
>
>  #
> --
> 2.34.1
>
>


