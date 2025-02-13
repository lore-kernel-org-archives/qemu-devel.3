Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B73FC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXMH-0007Fv-IL; Thu, 13 Feb 2025 06:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiXMF-0007FM-D3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiXMB-0001zT-O6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739445969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xhy8q4kc/c0WUONMdwjUk0ZpxTbe02QgZdW7hW6aAmw=;
 b=YAcHOgyaUwmJRTRNt37GkMYGG5+YRMp7xOghk9wR4aYOqhvVYBQueFfqXxgb0H3aYTn2Xw
 CY99OgoXMJDkWNNUJrfEcFOikd2fEO8/l74nCdxxuMmOO7Z7VUnaVXs+a4bE9dGv3DTQtU
 I93zzbjwh88kNppyADtpKFvbk+VJL3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-uOlP8-u_NHqlkejzRZmUuA-1; Thu, 13 Feb 2025 06:26:07 -0500
X-MC-Unique: uOlP8-u_NHqlkejzRZmUuA-1
X-Mimecast-MFC-AGG-ID: uOlP8-u_NHqlkejzRZmUuA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dd533dad0so547885f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 03:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739445967; x=1740050767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhy8q4kc/c0WUONMdwjUk0ZpxTbe02QgZdW7hW6aAmw=;
 b=ngE60kYbh91hpXu2/IYEP4mQrM3+hUm/KRV3KgxAd57Q0dqR4ACMNHR9q8sdv1UqGC
 ywe1Vb5POX1UH5IpVBaDA9ZXVme1bYJiZO9dCSlHX8ITzsmlvl9tVXuBheFFmYLrpIZA
 uxnGznCUCezufq+9WaO1Dul30kMWGJcKAda/ZXTnrN81JJkqZnZyIDxuVTJcZPSRzx5F
 WILgByeyk3js3M8VIcE1cRmMkl+EDcTgLuNy18s1PrVlwDMGERcBYrwPxKn7zKW+arQE
 cOmKJNdhAM1MLe16YZNJsIIhotwnvhkZtQG7L4j/q1/K1Vx4GIdxOP/p0vXvesobtHZM
 3HdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhAOgf7vdMS/0W64JNE1wPDGQsyK+XO4l+BHlBMq1MYyNpWcjwgyT9RFZZPNhsLcymPmh2c+M4N7A9@nongnu.org
X-Gm-Message-State: AOJu0YyFKpPc/pYT4fvoV87rbriP/2ZHDk6DNnhHJsqpfUX17g8j6htB
 jZT24Bvmfe/k/L0f7B8nO24LF0+ftW2bXmdd1yo07Hj8CXB6tpvpbJ7LwgV0G3CJXK3Xav/6ueo
 /p2OfPKyS3ve8zpJOVVRx8lVEIAz+TSAwTFoDH7FIwkTDoMd+d1ylzVJfe18986E2CLExePIUoB
 O1gnwzeKBcXjZ1eb1s8aVhphJAZaw=
X-Gm-Gg: ASbGnctE4o0ruJFXrNv2Nq2OIx67EvuC8Nc8ML6mgjYeUOqQ1AwqFGYlGBDGKuRfrmJ
 AlQ0w6DmOoIMoIzL+WAkQKTQ2nEZHb3qBCjQbDnBClqGWT3ynfwpaV6vHbpIQ4CI=
X-Received: by 2002:a05:6000:2ab:b0:38d:d39a:d13c with SMTP id
 ffacd0b85a97d-38dea256ee7mr6600890f8f.2.1739445966721; 
 Thu, 13 Feb 2025 03:26:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjOABVMMJQBbuPDEbTE1atpPLosKxPvaHqvJvlxSdC9zQrx8z37JNI8nwRW/TaUP+YSz4ZRgL1aJAk6yhZdl8=
X-Received: by 2002:a05:6000:2ab:b0:38d:d39a:d13c with SMTP id
 ffacd0b85a97d-38dea256ee7mr6600850f8f.2.1739445966313; Thu, 13 Feb 2025
 03:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
 <20250210030051.2562726-2-zhao1.liu@intel.com>
In-Reply-To: <20250210030051.2562726-2-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Feb 2025 12:25:55 +0100
X-Gm-Features: AWEUYZnbblVJEqx9xEzitGZ2-FQk6-BUDOz6tMzGvwZI1lgi26sUhJORBpm5muU
Message-ID: <CABgObfb6PhiKO9=iWne9AoXQ+Ek7FddoW8D0VcWvw3Qa3TW-9w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 10, 2025 at 3:41=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d2cb08715a21..546de63123e6 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -26,8 +26,6 @@
>  #include CONFIG_DEVICES
>  #include "target/i386/cpu.h"
>
> -struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};

This must be kept for the case where HPET is not enabled at all in the
build; removing the FW_CFG_HPET file changes the guest API and I'd
prefer to merge the Rust HPET implementation without having to figure
out the safety of that change.

No need to do anything, I'll just make it

#if !defined(CONFIG_HPET) && !defined(CONFIG_X_HPET_RUST)
const struct hpet_fw_config hpet_fw_cfg =3D {.count =3D UINT8_MAX};
#endif

Paolo


