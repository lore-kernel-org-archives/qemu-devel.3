Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AD1C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglEo-00063E-Df; Mon, 06 Jul 2026 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wglEn-00062i-7g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:28:01 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wglEl-00089j-L7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 11:28:01 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664d4478a64so4255281d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783351678; cv=none;
 d=google.com; s=arc-20260327;
 b=St67oqMLEQXgHJrdy8mwm+xQgkEhgwpASHbxPAD5e7FuABiH5I3QWHTx6bZ550t2BU
 ex+yMtFPvxbaIr8UIEg/9HQTgQdOzNo6qtaQafI19nUqHJ2C6okog4Gj4k56fL7DLT3/
 0OQupWaNjye6XpzQFJSzOypzapv1wi73gffGPtbj5YNa7IBVm7Yw7DQYf1c4MCWaOhg5
 CEkoZH500eSBjdsb0JxGImdtdkvgPlOyD2YznfKm3bMLzVdMvZFzB5ibzxhZwNUqOjaW
 uGZFeYvMQ18olygt4IFXonv/jBjLO8PM5Rdch4J46t0TVoRHIGhbDSzPLv/e0WIsVb0o
 /0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YKTcPxKxLRb5ojLf0eOsvN7SUhy86oPvFd+3G4Gph18=;
 fh=jBqT5j1JQiK7zMky8wko4jzsPHdS7dVIImZoHJZ/6n4=;
 b=BvtBhoXndmx+E/zz+VodMRZvHA/oqcXaZkbP8BBFKrnb3FGN/WHj5nC5euyukyi63h
 wPkWrSI9rem0mYf5N1nJA1pbmTwPiILJXrjifOurFopJ2k+UC+kgWeUx4E0lfigpSUSv
 ygaU/5sC/vq/mTRw4R5AFU9XIJCcw8cqE5dcnS960eY7Q2ueqIzw8HQbEh7D/9YqyVXg
 73XGN411umHhGLT9PUG+YCH8xcTE1fp3SlZnG0BW9ujHvSTZi2opi3VOVHaB+EzrfX9l
 gWUiBp+qAVUS2Z6BYCgmIeUu/2bOpcqeAWyXPcwiapdOqNtMsIxB3POBfVlLutBOK4sN
 VkOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783351678; x=1783956478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YKTcPxKxLRb5ojLf0eOsvN7SUhy86oPvFd+3G4Gph18=;
 b=bj2E5De/0gSGzI52Z9dGJDJMVE68w3u2MVSN6G0PALcA/rK942LezBxnqGUKJyataf
 3xXRyGGTNZ1sGFTvlQ0x0KdOwrWBpsbvEanPKJl1y46thmowyL29Z35A25+5ol/kDDnw
 5ZTWZ7iFU2St77gNrfS9wXcVAuTi4Y65QSZveH4cb7CEPLkhzsWg6i5k3v6iM63hQ6YE
 +XCiXZELH/5spzaKHdKvIjj5dtO2346+AXX85YPMNjlNQS1Xn/Wl1xULuSvhQw3rDM97
 QZlDxk3cHN6LWcx/2R9uIz0+BwBjPlbfVzfrOg3HvgvNo7tftP+wwA6/s3iRVNSoCN85
 lHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783351678; x=1783956478;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YKTcPxKxLRb5ojLf0eOsvN7SUhy86oPvFd+3G4Gph18=;
 b=PD3DozdtzmVDC7PBL6AWLdg3W0+v95G2igBCUsEouO+IH7qCtNVa/9D2D5iQcZMjdk
 dTunRgnHyEBvVCp0bcpv4qjTGQqGR1eQYCTzUtA29VpAkf++DsrChwDGATO2LoXVdofg
 CZCRa2RwgLWVMZ0UDlrSuMaV9tBbBrCBuqtEEw8dlgANeDB6+mHOyXUzOkFX8JdU/FEz
 iEE6slAUdsK9AIYJnMvDROLok5gknrmd0FvF02/pYwn7OAP7ARFNB8VZcCTVWRPbF86M
 EiWYnEnO94GxyfGBMPc/2QK5HKjoB7Ac8vK1WxYEIWnAj+MDf7hO2XaU3864vumIGi2v
 LTAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ7TvsnPd88bgc3fKzEh6yeid1Pu5Z2wdYkPjF/xz29wtti6Klee3a6xpkO5x0HAy2UJBGN7rcQUBS@nongnu.org
X-Gm-Message-State: AOJu0YwLtzfxTCiJS14LQz6ynbRnNUJosAyik37odPloLNjXhiDnCobD
 jJYmV/7dDT0JGIuJAehWHj6ngcmHL3QicVDFwRO9MY3tm6upJQA3KRHJUbWG14SZycFu+CQEQsc
 XjyiQYTzxOKDnWYAyxTDWThdGJ1RofB5IMbSh1n9YwQ==
X-Gm-Gg: AfdE7ck3vqw4EPzZfDQ2bCT1a1hL8HFI3flk89kcReYd51jzH0xE0WCX3iyOXut4o+I
 8A67kHlk4d8e4/RLlms3HHHGoBQ9VvFYFuGHH6qFrt+MVfxODoI8J+TyqVngDv1VgImbnrcnYX/
 dt6AHpL28un1AT12Yf41ffkoOYO7Y2tW4n2mGoaGYM3Qb91BfCy7pgxpcCXI0GU7JJ+qu+ZPua/
 wZc9/JWJ7+p9vQ8vhO3FzraW3SRWRlUbB4NbDnC/7rHp3hQbAAnZqBsCEruRxOmp1Yrwlrs+f5I
 GExCIfvvlRwWK2cAG6tlsgnOyUeK2DR4tvlt6SfIwC3xMvHwzPjyUlDK
X-Received: by 2002:a05:690e:4594:10b0:666:b80f:8b06 with SMTP id
 956f58d0204a3-6677fcd820bmr752507d50.68.1783351678212; Mon, 06 Jul 2026
 08:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260702160640.3875666-1-clg@redhat.com>
 <20260706082023.7ee830b8@shazbot.org>
 <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
In-Reply-To: <3f799ad7-08a5-44c7-b6bf-b143da038593@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 16:27:46 +0100
X-Gm-Features: AVVi8CcfqN8zfhXwBHOIZVd96rifEvBrVOKWyEvijgZ1RsgPBpxatr-OEJPZBqA
Message-ID: <CAFEAcA9wOZhn41Twz9zzCBD4MAET2+gbF71kUKnr7r6TXfhjuw@mail.gmail.com>
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 6 Jul 2026 at 16:12, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 7/6/26 16:20, Alex Williamson wrote:
> > On Thu,  2 Jul 2026 18:06:40 +0200
> > C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> >
> >> Any device on the board can have non-page-aligned memory regions. The
> >> VFIO listener should not warn about misalignment for regions that are
> >> not VFIO-related.
> >>
> >> Replace the vfio_known_safe_misalignment() whitelist with a
> >> vfio_get_vfio_device() ownership check: only warn when a VFIO device's
> >> own region is misaligned. For all other regions, emit a trace event
> >> and silently skip. Extract the misalignment test into a
> >> vfio_section_misaligned() helper for readability.
> >>
> >> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
> >> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
> >> memory regions through this path so this is sufficient for now.
> >
> > I thought the whole point was to warn when there are non-vfio devices
> > that we cannot insert into the DMA map.  851d6d1a0ff2 added tpm-crb-cmd
> > to an ignore list because it's not a DMA target.  The intention of that
> > ignore list was to continue to evaluate devices that are misaligned
> > and either add them to the ignore list or determine they could be a
> > valid DMA target and correct the alignment.
>
> If the goal was to use the VFIO listener to catch all misaligned regions,
> and potentially fix them, we should reconsider that approach :
>
>    https://lore.kernel.org/qemu-devel/20260701080843.2418461-1-clg@redhat=
.com/
>
> As Peter pointed out, regions that are not page-aligned regions are valid=
 :
>
>    https://lore.kernel.org/qemu-devel/CAFEAcA-QHJ=3DHaBc5WSLLap8NdDw+tty4=
EFfGt6cmmNOK6e_m7w@mail.gmail.com/
>
> and aligning them would require a machine compat for migration.

It seems very unlikely that anything not page-aligned is going
to be a sensible target for DMA ops from a device: the main
reason to have a non-page-aligned or non-page-sized region is that
it's the way we've chosen to implement a device, or it's some
"RAM but not general-purpose RAM" thing. If there's a path to
warn/error if it's actually used for a DMA op that would be worthwhile,
but as it stands I think all this warning will ever cause us to
do is add more entries to its whitelist every time it complains.

thanks
-- PMM

