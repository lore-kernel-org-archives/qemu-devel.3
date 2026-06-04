Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B76CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyN1-0001EI-Th; Wed, 03 Jun 2026 23:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUyMz-0001Dl-ET
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:03:45 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUyMw-0007jo-ES
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:03:45 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7dfe7712572so2661027b3.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780542219; cv=none;
 d=google.com; s=arc-20240605;
 b=VzC4927A+R9dM1KQLwpb79pvmB7A88eE6c1lbjgUAyB2huJ/dgLX3cBuatJoFD4ewL
 oPPrYHKu9p1e8yIrUkf05RsNOn/uKQ8s5HLHlO3bTf4Z4ddbBE/H+Ple+2djIPcDcHPZ
 VCB3qm/7c8YU2FkyXaajXQtCnnmnGmM3oOzv/B0oeTu0NmaNQHfAVzOujLTwGpqjlmtA
 Wd87Gw+4UCPZUuAhR3PRDjapPYUqKVuq49trmoZzqdJafWyFrYYDhmBXFgl76znKxIqJ
 HLcNzoR5CWhxbxiVwaPjKsxXJ32vNOezm62bE8arv6vk31dzvtcea5Dt37Skwv51qaqZ
 8RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EJ/7cbNnLAl3O3LPfWL/LtTNZVrE9ReRYjyLbX5TjZQ=;
 fh=B19CKkiShh0L7Nq8sDBUZ1TISt9vFNScqbLKsTQes10=;
 b=CXX8XiC4u4xLxZ0qga8QclRnifooYEXpP019fZedzzh+4RSD19Y9nUcmOtEH/HL4Ws
 bBOg3q3sX2um0/lvcVFaZknyR+sGwQGTo1JUsXTlKC080t0YVe9s54rib+ilfUub+UTc
 87/Xw++VaH2aGQ6a9HxMRjmNwxvDIKF2rumQJu3GBAsPqkObbAsWF7LwzRbifmJ+vtTp
 ElnioO8VbYd29d2d5nTOD2q22+mzHAb/aVdvhLCTjBP/bk6aMkU5rWb1dLaBd1pPAjO7
 O8ozaOJIkkqlxM+HCzQfjW3f8snhEY5c2wnS+yS48MPvRQ9DX41IbgfG55fDKB9csFq6
 MMZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1780542219; x=1781147019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ/7cbNnLAl3O3LPfWL/LtTNZVrE9ReRYjyLbX5TjZQ=;
 b=eMc64BfzehTUA138pQTqtSX/Er9L8oa0kbmgOIWO4PPyOZALKEwyyO8TAzGRy/2Jtv
 IY1Flr1y7VDMHP/paNEHqart7xZVatMfReFdFvRGY6R6fmprvXkvDMZ9xQ1SR/C6oeyM
 7TOlf4TL//peJmINY6/cLdXlwS8N4SR2Soo5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780542219; x=1781147019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EJ/7cbNnLAl3O3LPfWL/LtTNZVrE9ReRYjyLbX5TjZQ=;
 b=q9dryKqRKFZCa3hDojfGJctr0v/pd4BKO1eYxU4PZYicyOPZOI6Ir5UvdsDbeFU41x
 QxqDhnp9qPnE2QvFC/V387q55T5FOxe+AaaHDOxXrzc7UKCiNQ/ixGfZX4BzX26+PCz5
 V2Nkgg6JFTLiI5FqjCKgRQa0ZaiOwUex/3Ys6GA2ghTzJCBtdeaDJEuFMNvInuOeuUdq
 Uy2z0WgYpP2qmdx42NIQLf4tS+3g2wPRc36bIjlljxkGgCsQbyufZ3EtkoCzAREBlnk3
 NaZHcm/6tZgpY6QG6ts4SfyNCGkeK1n6yad3pFx4R+5MfbKQvWRQC1lqxs04CC4s9zzK
 iIGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fsD2gdc81ONFCWLsBcXJuxo4YPieSVqN6Y5svy0Zzu7fqHoMg3xMZqQrNlsNhJL80Uppb3s4stvnE@nongnu.org
X-Gm-Message-State: AOJu0YzWiC8NgrfH3E+xOeb9+XhF2gYbWSYz5Y+D415vlRo5l70SIGaF
 qQTNxKoDH1q3GKd6uC6P7y5S/0wH4Cv9BIMBGYmvfxSk4lWfW5c4eoligEpIr7SmgAKfJxboVeC
 E0Y7SMgnBl7dYUx2CWmY9XgbViLyJx+o=
X-Gm-Gg: Acq92OEMSYmSg2kv6ur65MLzAz33sVfdEsZtA+CqhQMnVrcVV39QbyAFniRyS1tvwkU
 6/UqB5h3Y6K3eOieaq0ftX4CnZnEq8vvi1PaHMG0nj8QllfmtXRvccR3uAVOIAg6U+cjTx5wE72
 dPMeKeK0fyc0q7yfYjO4C5g5BYDSvZKEx+2MAxPlydw1hLSRLlSyqirltdMZgPfq7B/zQGP6FpP
 DQtsnbFahCKFZF3V54xFF1+A2arrs1w9kD4B2phJR2B7T/g4Z3kLmP4i8UQLkoXv64jLD9lTtql
 +3ImxMgovA2Z+ArRfljmY2RLMGaMLuL99Vg59IL8CBMV9bdjyfNdaGgHU7tA3aF3G0a00AOfHRx
 Pg3yjnJQdN5NY4pKY9EvjJbEdOqrG9sqvL/RTUeKbOveeTw==
X-Received: by 2002:a05:690c:c22c:b0:7dc:a5a8:8b9 with SMTP id
 00721157ae682-7ea46d27046mr60132337b3.10.1780542219351; Wed, 03 Jun 2026
 20:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-6-joel@jms.id.au>
 <876dbf23-c7ec-46f4-9232-816a3d0bf16c@mailo.com>
In-Reply-To: <876dbf23-c7ec-46f4-9232-816a3d0bf16c@mailo.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 4 Jun 2026 12:33:27 +0930
X-Gm-Features: AVHnY4Kt8-7101iy7BvqOSpSETeScdndUz42ZR-kpCQwSfcycZ40Fa2SBoy016M
Message-ID: <CACPK8XeJX2s3-mvpsrCeOLsMyZXYN7fxiMCiitKTtN84Ntxvvw@mail.gmail.com>
Subject: Re: [PATCH v8 05/12] hw/riscv/aia: Configure stride for the M-mode
 IMSIC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 3 Jun 2026 at 17:41, Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>=
 wrote:
> > --- a/hw/riscv/aia.h
> > +++ b/hw/riscv/aia.h
> > @@ -14,6 +14,7 @@
> >   uint32_t imsic_num_bits(uint32_t count);
> >
> >   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> > +                             hwaddr m_imsic_stride,
>
> hw/riscv/virt-acpi-build.c:74:    uint64_t imsic_socket_addr, imsic_addr;
> hw/riscv/virt.c:532:    uint32_t imsic_max_hart_per_socket, imsic_addr,
> imsic_size;
> target/riscv/kvm/kvm-cpu.c:1829:    uint64_t socket, base_hart,
> hart_count, socket_imsic_base, imsic_addr;
>
> Why choose hwaddr for a stride (region size)?

Brain fart.

> Using uint64_t:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>

uint32_t would be more than sufficient too, do you agree?

