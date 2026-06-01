Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21CFCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU01x-0005gg-Hf; Mon, 01 Jun 2026 06:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wU01q-0005Dk-QB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:37:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wU01p-0007LJ-CC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 06:37:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so91196195e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780310270; x=1780915070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF66G1H6AyVbXdK0S++GSAelfTRixr29bruDMdcnnF0=;
 b=h7PJ6/46/bzI0q2qI/P0cUJQ/Tw62uxBJ5oB4Afc6twM9mcd52akKT3TbEg3WQr/nx
 kO6II2TvH8+9zBGPjH6MmckmYhkerU9NpqO6Gqbi05qCrR6MW0lr2QQJR3oKaevq7Bj6
 geOFn9eAgFVR6LEkqHXeZjTnfiNuxN0JQAIHT16dTVzSkJRsk/e0+/dZXhcj6r8R5QMh
 qwX3/iuZAliRjNiHKpG3/2SrYwa2utYxDKd2k1Sjxz15MgFsux1P4tw3JxABUPdZZnB6
 KGBnkNwSiYSFQibonGd6YsLBzojCmNUppgoLAnKb+KfL6D1eV0b2dQEVGNj+ZzWh+5+Q
 3uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780310270; x=1780915070;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GF66G1H6AyVbXdK0S++GSAelfTRixr29bruDMdcnnF0=;
 b=lkzsQKDWyqxMA4FZ6obmeaMHKGImI0go3KHO5R9c0yUMWri/952jMj6EqNYVd2BdhO
 6KfsNwz2Jf3MkqZLstZIXYjgKkKukiOPBMk2hNZOetCWYsywkEklXcQ96BWMITrNTiuq
 s8zQVf5qbhr+AWryI+2WF4YXV68i+p3fGe/i2lO/ZY8LOEmaUZn6nwXLu7v58GOMAshq
 774YlG0Rjy9jOZSpVnT5TkN1BG9mxRPcIYnPl4R11wSbvEoxLlma/b7ZS69NZVchrnyZ
 fmx7VzUEGDOfJII/uatmFKitolyUxMogCdl0aH5eGvCs0cpDKXc5+tJJUUM7J9T0oB6T
 +AeA==
X-Gm-Message-State: AOJu0YxAgWnYlCYawFHfQ0kY1CnPcAhMugoye3gJfSVySDdNJyvKP9HI
 bkPPkqLuOBaXNWSZfp/VB8ziT0oAoa4RjjiekYXrmciI3bDYvrB0EnlW
X-Gm-Gg: Acq92OGGAVh8GXRMKfWh9/qzNrtfDxS++qBibvOY+xfUPvAAtXSzM82mx9Fb1CHD1PS
 VR/oVX7ylgpP8N7EsyDnjSz7MASNLl7jFJ1GTPeiJzOVJfpNadf4aMhlwdlgefniimsZnuSpKUr
 lhMyZmKRJ+JtMlmQykhY2LIiaH12MHlPPMJYunUcqHyrz6JSmzmDwoeKMR+krnnu/cXb4sEX8yl
 Y5VJEdQXudzVIBeLNN1Mg85QxpTUhH3lbdwkJ3aGBQeVoVfixJtPv56ERjXaGusDT5r5TmkvIY+
 B22ZXXGLSppnaQDnTn/sb3BBysC8oIRZtuds8v9EVk93jL+7AzEPcD+BOote4TTp1lgsNQhsKP2
 LVujIGLXFwg9rf8L0XetC3lRXTCI3rAWah98NqqjcTarD2gEjZr1XSGngXvLEr2BrFktCQUQNNb
 296R82TxU58Gm6nmRr7sYMOMhZcJuS5RRTORn1IW2RWY0uYppjjQ==
X-Received: by 2002:a05:600c:4714:b0:490:a296:fdad with SMTP id
 5b1f17b1804b1-490a296fe25mr172208795e9.24.1780310269769; 
 Mon, 01 Jun 2026 03:37:49 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6eb4acsm236370175e9.9.2026.06.01.03.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 03:37:49 -0700 (PDT)
Date: Mon, 01 Jun 2026 10:37:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Vivien LEGER <vivien.leger@gmail.com>,
 qemu-ppc@nongnu.org
CC: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_fix_bus-frequency?=
 =?US-ASCII?Q?_property_hardcoded_to_zero_in_CPU_FDT_node?=
In-Reply-To: <2eb2afd4-6cf8-44bd-b038-4c2fa6b57ea1@tls.msk.ru>
References: <20260411154535.1451361-1-vivien.leger@gmail.com>
 <2B283171-55E2-4DC1-9F5F-BE2254E8DB7D@gmail.com>
 <2eb2afd4-6cf8-44bd-b038-4c2fa6b57ea1@tls.msk.ru>
Message-ID: <02CD3FF2-93FC-4382-9875-5EFF046D7DA2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 5=2E Mai 2026 14:58:40 UTC schrieb Michael Tokarev <mjt@tls=2Emsk=2Eru>=
:
>On 13=2E04=2E2026 14:30, Bernhard Beschow wrote:
>> + qemu-stable
>
>Hi!
>
>A bit late reply, but here it goes=2E
>
>What do you recommend for 10=2E0=2Ex series and this patch?
>This change (commit 774e6f5c15) contextually depends on a
>previous commit in the same area, v10=2E0=2E0-1542-gea585b1022
>"hw/ppc/e500: Move clock and TB frequency to machine class"=2E
>
>Should I pick both to 10=2E0=2Ex, or neither, or modify 774e6f5c15
>to apply without ea585b1022?  Do these patches have effect on
>migration stream?
>
>What do yo think?

IMO you made the correct choice for 10=2E0=2E Migration should not be affe=
cted since the dtb is created in RAM which gets restored by the migration s=
tream=2E The new dtb will be effective only after a reset, i=2Ee=2E a power=
 cycle=2E

Sorry for the late reply and thanks for backporting!

Best regards,
Bernhard

>
>Thanks,
>
>/mjt
>
>> Am 11=2E April 2026 15:45:35 UTC schrieb Vivien LEGER <vivien=2Eleger@g=
mail=2Ecom>:
>>> The bus-frequency property in the CPU FDT node was hardcoded to 0=2E
>>> This is incorrect - it should reflect the actual platform bus clock
>>> frequency, as firmware and RTOSes use it to derive peripheral clock
>>> rates=2E
>>>=20
>>> Notably, the RTEMS QorIQ BSP uses bus-frequency to program the MPIC
>>> global timer interval=2E With bus-frequency=3D0, the timer interval
>>> overflows to ~85 seconds, preventing any clock interrupts from firing=
=2E
>>>=20
>>> Fix by adding a bus_freq field to PPCE500MachineClass and using it in
>>> the FDT generator=2E Set bus_freq =3D PLATFORM_CLK_FREQ_HZ (400MHz) fo=
r
>>> existing machines, matching the existing clock_freq value=2E
>>>=20
>>> Signed-off-by: Vivien LEGER <vivien=2Eleger@gmail=2Ecom>
>>> ---
>>> hw/ppc/e500=2Ec      | 2 +-
>>> hw/ppc/e500=2Eh      | 1 +
>>> hw/ppc/e500plat=2Ec  | 1 +
>>> hw/ppc/mpc8544ds=2Ec | 1 +
>>> 4 files changed, 4 insertions(+), 1 deletion(-)

