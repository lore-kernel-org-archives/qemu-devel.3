Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D1E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 22:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMaUs-0007zz-2k; Sat, 14 Dec 2024 17:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMaUp-0007zI-Hm; Sat, 14 Dec 2024 17:20:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tMaUn-0004J2-Pm; Sat, 14 Dec 2024 17:20:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so8321295e9.0; 
 Sat, 14 Dec 2024 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734214818; x=1734819618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDEfSax5hxGaioMXd7JgPLlZqTNdZaInDrva/y83ko4=;
 b=O1BT4CpD+qrMy51rasP2r8gSxhxbeAk7edIuODHEFleiMyhHNHZYxvzxYnw7QVBavj
 zB1YMMc0DnF5YCZtCNX3Ld5XiQnrQ/mO6fSHQdg/ZS4ymQsuL9pnEnXmbnv7j1hs5C+w
 PbS540jPGFQ+tHS84cpiR7QulhfJc3YaSR/XwE/6tReSrDQFuKKQMeXRmJMiMGUtg7SL
 nGJCnpuXAsuE5s4bNWA7KlRqVIMK0iVTSlmq871V+lfK6co8r2Vx3F3nK2T3VCJdNSNr
 B9C2i1Bv0dhVBfwMcMobzsBDjZbJtKWjAikSMFgm/3tVydNNN3HxqWQDtGBSYq3CF3YI
 m0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734214818; x=1734819618;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDEfSax5hxGaioMXd7JgPLlZqTNdZaInDrva/y83ko4=;
 b=rczx34au7oZCLLpKTqJZ5vIRzn7nFNmNSYRPKdRau/QZN4GVNe+pxbde7J+lrgM9JE
 F5dYoKxRmLGx2mmgbFlIMDUgkzFE/9kvqCF+XoF7Pmav+dBtTJA8+nXjAqPdV4Ae4jpO
 FROky6/dCYTD9cM+96xPTsMe88x769V7D29dUehA7pzgGZcU52wzNRcPQNdKRla+5VgF
 gSxhGNA9oIcnTmdVPbvDCk9KzDvuGGSNOlrrFtsyoKmkl8afadHGUdG33pa5Z9zRGgI0
 S9/+rQgFnp01SxnRkwVI/EUI/OgLw9dKru79oBWIxXrwW5h9N9YL2E25IZuJLIvxJlml
 UzaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn7k95obCSnWgbwTeX6QhdMJf7hPkg1/N0EAJhz8+S13IxBc1qumNTxF40NtGn4BAE2eWXCQ+lAA==@nongnu.org
X-Gm-Message-State: AOJu0YxWrz7uIQJQAy6wki36O+FoNknR52RA0jVcOUD5AbNQBIPpkLKa
 vPeYMrI/o2SwCFlnl1Bnmq1Uz2mbYnwrig+z5K22nju4w7UEr8GSsr5HHg==
X-Gm-Gg: ASbGncvmM/nJmlHNsFkOuY1dFVAgP6apHiGjEFOG/wixiHKaU+d5q9A4yk9DR8NKNfO
 RXkS5gAo3kJzKSe38zXn6UUr0XojwbqIRbJ8zk+TXw0duite8/dsosH0C7YUe256mU986MH+lUB
 mbRP1corjBMS+HkAPYNgfhorPQjlbsarTnAKHPSPkvJeIzcfNoB2Mcr+6AKWVtlKy5Vo2TJ7cOm
 0Nh3wf9/QKfAMliJJxKQicLXs0KAofn9Ux0q2TXZo3bW7HYgvj+paOE66K+EtwrH6S9S03BkgSL
 A19TNxC0lb/3SyJlQrATyYZpn5SZ3CE=
X-Google-Smtp-Source: AGHT+IEGqgZDhEZn9FG7/tNiAJ56+IzHWN+N/CIRzjtays8adWCcvKZClvuors0IhHaJvzsKgR8hCA==
X-Received: by 2002:a5d:64cb:0:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-38880adb134mr4603270f8f.34.1734214818118; 
 Sat, 14 Dec 2024 14:20:18 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-013-249-192.77.13.pool.telefonica.de.
 [77.13.249.192]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012249sm3636291f8f.10.2024.12.14.14.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 14:20:17 -0800 (PST)
Date: Sat, 14 Dec 2024 22:20:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 35/71] hw/isa: Constify all Property
In-Reply-To: <20241213190750.2513964-40-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-40-richard.henderson@linaro.org>
Message-ID: <EAEA10D2-4E04-44EB-B5D3-FE6A6396AAE4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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



Am 13=2E Dezember 2024 19:07:09 UTC schrieb Richard Henderson <richard=2Eh=
enderson@linaro=2Eorg>:
>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>---
> hw/isa/lpc_ich9=2Ec | 2 +-
> hw/isa/pc87312=2Ec  | 2 +-
> hw/isa/piix=2Ec     | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/isa/lpc_ich9=2Ec b/hw/isa/lpc_ich9=2Ec
>index dabd1217dd=2E=2E378244aa8f 100644
>--- a/hw/isa/lpc_ich9=2Ec
>+++ b/hw/isa/lpc_ich9=2Ec
>@@ -826,7 +826,7 @@ static const VMStateDescription vmstate_ich9_lpc =3D =
{
>     }
> };
>=20
>-static Property ich9_lpc_properties[] =3D {
>+static const Property ich9_lpc_properties[] =3D {
>     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap=2Espkr_hi, fals=
e),
>     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm=2Esmm_compat, false)=
,
>     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm=2Esmm_enabled, fals=
e),
>diff --git a/hw/isa/pc87312=2Ec b/hw/isa/pc87312=2Ec
>index f67155498d=2E=2E7bb2af817d 100644
>--- a/hw/isa/pc87312=2Ec
>+++ b/hw/isa/pc87312=2Ec
>@@ -327,7 +327,7 @@ static const VMStateDescription vmstate_pc87312 =3D {
>     }
> };
>=20
>-static Property pc87312_properties[] =3D {
>+static const Property pc87312_properties[] =3D {
>     DEFINE_PROP_UINT16("iobase", PC87312State, iobase, 0x398),
>     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
>     DEFINE_PROP_END_OF_LIST()
>diff --git a/hw/isa/piix=2Ec b/hw/isa/piix=2Ec
>index b4a402f61b=2E=2E8ec9c63b8a 100644
>--- a/hw/isa/piix=2Ec
>+++ b/hw/isa/piix=2Ec
>@@ -408,7 +408,7 @@ static void pci_piix_init(Object *obj)
>     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
> }
>=20
>-static Property pci_piix_props[] =3D {
>+static const Property pci_piix_props[] =3D {
>     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
>     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
>     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

