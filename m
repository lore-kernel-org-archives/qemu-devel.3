Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642BFCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLxU-0005H8-8F; Thu, 18 Sep 2025 17:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steviea@google.com>)
 id 1uzLxL-0005EJ-Qw
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:14:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <steviea@google.com>)
 id 1uzLxF-0002pG-Q1
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 17:14:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-267c90c426dso26625ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758230031; x=1758834831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf1ZDzwXdB2A2eNZdnLqHYk2R3XFN3FkaKolUJPzAs0=;
 b=1OYzxjPlRTTEEM8PzpUczZmaB6Ug8fANa8FqbeB1rveuuSIfjVJ6xTygnN1srv7Ifv
 U296aGMNBLh4wG4zzwMvTihAb/qTl0Rha10UJJ8ha/GG79c1ZsYO1hh67mJsbxGpq65y
 IGFqP+gxJ/Jh3/mZVHv1TS3te/ZWXxxr/4DfxjqR5UFEj2yABULhjjJngsWwxMbDbq96
 cVcKe4ex0jWqHZde88bbnQ8ijBdWw/xEkbPd2I/pfWADFd6dNh3M77lYU417S88FoR5r
 3F/kLWV+pwUQQe/I8tQfFvV1clbFHoJcdD3vaOebcBMuoeFwGU40kjo6jbfmetL1zUj5
 8aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758230031; x=1758834831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yf1ZDzwXdB2A2eNZdnLqHYk2R3XFN3FkaKolUJPzAs0=;
 b=bM0Cqvh4l3sym4KyxoJAzYBNdryiyKpYgx9Gi2G9palvQGApZzojaZiFNYPn6rtnia
 mPClLjX66YplFhOEJ8L/52d2nNq09sqgrKVlZZnSZLqpJh+4EHctm1NFYoVDMXw0jQZT
 Ai3KdeR0v70igob7JeJvoi9jirSD9Xp2nvJzRVMp/uIKKtbT6mZyAqkRojBGHKBSZuE0
 Fh7uzkPME9gh/KjbQFeW8qm/6zUiFE7cgAvtEkmvaVxbULQXq95cFPkB0ElnFpih+qhC
 WlL9W6Yy9ephao8jOtKrSFckTsgM9IuCbqiAWnVFxxtcZOpbqHo0mESMKs9ECbUZXDO6
 uC/g==
X-Gm-Message-State: AOJu0Yw5DhjT98TnwaSbhj3dLkYpBIvCJH8kS5z5MxxJXpB8Ocx+HY+D
 7IATCalOK7xfyothGuasxc+qMJZZUSDM4d1H9ma+8Vp/7XT50FIHwSv/Lde6q13/hbZTUeyDJRb
 PGILiZ8S1WSNx0C0fKmKiNZgHpGQ+k8EXDUff93aHZIHDVCT0oeY56WGsTdg=
X-Gm-Gg: ASbGnctoiTxUfZ1zHCsL80RvO7S4lz2wKZkLhqeN5Kd8Ayk9Kkr3KSZ7B/19qZH959G
 PqOLv37B/ASfjZRcJaCXUrQloSGPzySBW56vEQdyakkJLrI5pT3YJnJHJrNH8o+SYPzHmYg138j
 MK+lcGcT4Jb3rHDoLu+mSevTwLpEPeIgchJYgCuRuq+5m0ilj3pOKckNg+/YdYbHp3bo3Suhvnl
 D8W7SbAjV/l9jwrBsUW49+OXC5LasfKSf72qgj7/jMMP9TVDruYuH94KsgWNog=
X-Google-Smtp-Source: AGHT+IFxkAxIZFOFZyCYp1BGPX2MH1P+BGG55pfSxU7nEYMQ3+1wrRRhojD6f9TaTYOP8YzHGR7cJpORDjOiCS20Q8Q=
X-Received: by 2002:a17:902:f644:b0:264:f533:75cc with SMTP id
 d9443c01a7336-26800c32bb6mr13871495ad.0.1758230030811; Thu, 18 Sep 2025
 14:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250916165859.1718787-1-steviea@google.com>
In-Reply-To: <20250916165859.1718787-1-steviea@google.com>
From: Stevie Alvarez <steviea@google.com>
Date: Thu, 18 Sep 2025 14:13:38 -0700
X-Gm-Features: AS18NWAvm6AscMQApKRueU-y2Hc7OVRhQxarV4ygbMNYtpA79gU0ZALw-8yP4aA
Message-ID: <CALeaR2oKukFOm2GamyOd04uGeWR11MxvHcvQ9=xq7=V67js97A@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pca954x: enable vmstate
To: qemu-devel@nongnu.org
Cc: venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=steviea@google.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 9:59=E2=80=AFAM Stevie Alvarez <steviea@google.com>=
 wrote:
+ CC Corey Minyard for I2C maintainers.
>
> From: Patrick Venture <venture@google.com>
>
> Add missing vmstate support.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  hw/i2c/i2c_mux_pca954x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index a8ef640cd2..78828acafb 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -22,6 +22,7 @@
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
> +#include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/queue.h"
> @@ -211,6 +212,18 @@ static void pca954x_init(Object *obj)
>      }
>  }
>
> +static const VMStateDescription pca954x_vmstate =3D {
> +    .name =3D TYPE_PCA954X,
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(parent, Pca954xState),
> +        VMSTATE_UINT8(control, Pca954xState),
> +        VMSTATE_BOOL_ARRAY(enabled, Pca954xState, PCA9548_CHANNEL_COUNT)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const Property pca954x_props[] =3D {
>      DEFINE_PROP_STRING("name", Pca954xState, name),
>  };
> @@ -228,6 +241,7 @@ static void pca954x_class_init(ObjectClass *klass, co=
nst void *data)
>
>      dc->desc =3D "Pca954x i2c-mux";
>      dc->realize =3D pca954x_realize;
> +    dc->vmsd =3D &pca954x_vmstate;
>
>      k->write_data =3D pca954x_write_data;
>      k->receive_byte =3D pca954x_read_byte;
> --
> 2.51.0.384.g4c02a37b29-goog
>

