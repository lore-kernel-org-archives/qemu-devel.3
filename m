Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F77DF94CA2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFL5T-0002nl-Vc; Tue, 21 Apr 2026 20:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL5S-0002nM-Mn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:05:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL5R-00047V-2i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:05:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-676d8582a13so1330396a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 17:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816300; cv=none;
 d=google.com; s=arc-20240605;
 b=KMdr4xKnRDQ93KGANb4yjZwWJtBa86RU/k+BPklq4zsC6VcLo9KcA3lrkuKUo9xNmG
 sVgqJ/jNgvkP4p7QHT5hrTuNiL0ZEzX9p4hHvU08zVEl1/aS4JyTxG4UciyjQL7lshAO
 7Xe6lUmXsb66Z2A37adAHgucW/WUQTFuXJn0P26hO4r8F7TswCttwFIHRQxX+wCjTriy
 BgKQXSyG1Qxq1LJ5NtznZQWO6mcnZcp0/I+Gj8ikJvp/tqqbzLsLSy+fTZPW3JU+5MFS
 +6DjWnoRgs6dBDcY3KNPrRGxE9WwP5mlltOQZUbhaCxPkLr+rRBHgkcszoesrUTpoibA
 9ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hco5VyA1XfLEoQKJ1X+h5zZL1yg79y5fKn5DjcvX3Ks=;
 fh=Jqgq6Ia09t6Vodf6R7BTfp0X7UM9vMN1R3KFAlISu6k=;
 b=dYuKLHvjG2hNJ7WyNsaUXf25dtgqYnWDM131X1RmIwVRy3YDN2En12QAS9XVfsmpQU
 LxwoGiMzK0ehLNx2F83pOcfUZh8vOip/uBOuICpa1pr61hCSfSi2e/DHXJLZGObtA6bV
 nZ+i40L5y1i8c1+wAB0gNsTB4gQhM1dY5rxa2WZGi/+To29CbxSVjMXXfLJLqu1nfkWC
 UF7HGKKTtZ9ib6eyAQZGnoc1RGi7fHCVA7iTwtQ+n5Xk8pw1xYkj6pylJGF12L7znjzM
 XTRbA/xrIdFk3p8OVBQllNfXHQvNaFaIjVxmlHS9wtfQN4b+/Wukr1CHAmiHXzjwxvA2
 H0GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776816300; x=1777421100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hco5VyA1XfLEoQKJ1X+h5zZL1yg79y5fKn5DjcvX3Ks=;
 b=W28M92ga2dCADzbDTUG0LwGO8yoJtXXTzVmoUBAi1ENf+PVuUrpvSNm+cGLh/WS64e
 Kbob929sbfDftOc9uds1/HR7od1JnzYYm3/M/2kJy9yfWJLjvIn/LhVIyR7P8SVO+OLp
 t9X3p/QhjbVhOoOh/59MbbaqeJv5SM5h3Z0U68pvM31BnRoVpp5tYC4ZOEu+AaHUiVC0
 AGdb5Y8S9LEBVFehBQqdNvBarQXVDVqJUfD1CrJZh94c4sXgSLhHoKv08LnhpczPt+Lk
 Ex9hmLobWKVHxV5MlYR99dgQ7A6VoYvSvvGPzjhJGnmGXU86hhqeyX+U1p23gzSI7TIs
 cc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816300; x=1777421100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hco5VyA1XfLEoQKJ1X+h5zZL1yg79y5fKn5DjcvX3Ks=;
 b=mcRRCKqZM91ErRwG5xvwj3QHMcQzDtsHj3hBU8FgxmvQq9giV56s5QvtvO/h0Ajp5q
 DWLhupP3SHJdaRYbnuBoRPSDAWj1t+UzS5QtS8QysRgsYnooxCkNKCtjdeNuaYP0EZKC
 JVMLwpkHkSTv8nlc0QvPjfQPWvlEhvnldopJNti/B/FWYc9t08kunGo1Zi+l1U4v0Yhb
 MqOGnFVJtafbBSmLZIQlbndz2r6xcNSdkNKRe6ujmB/TPyDY+PYIsqUXBqvmMGAP2d9H
 Y9pdPMietgHs2sSrHJMm39jwZ0rHeLThFebD2ERLV3ilOIqBbzwJSmac4kCaQvukPqG7
 e5aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H9Xlq7DyNg4iDVTAF4vDkM0t4vaS1C7nLPRllZikPO8ZatF7ONFfnk40hc5xTzKFJbMwRAY8uPVuC@nongnu.org
X-Gm-Message-State: AOJu0YycjbKsVqw8Gi/U8kKA+qG8l2LW+uZKWuW1Xv3Lqs++D2cvt3H/
 hqYyXzAzFMnnqfhhBiwFyzfIMIgh6tGIx1yW++GTomOoidsnF32Hy7r7uuxnivouIVPrgYkXhoH
 O9KI76/65lfe99Y4m6LnVDfX/EQ9xJXqQXzEY
X-Gm-Gg: AeBDievTPXrQKvqabE+i5IGvVuByrXCGa7cmMC/1GopdQfL5pqVAMkIBYifnZZbQJZ0
 lAyXKA7DcoIbKfGiYm98K3ho7gIRTSCMMYddRJSItwG8TdIXr3YrjQ3o9UZQMc+y60xX3saljQw
 MNIODtY4CrMoFjt7UD/vbLwA10W1/g4JpRgFdjFAWsoptpAvdnSM81PI6MUqGe1g9LljCvwGtzA
 DS9IvwuEWhooFgcxA2QebPtd0A3Bv+5hhVZQC9arF/wTzAPrSy7/uBGSplIZ4Z/c8IILZKeg1PL
 HgDhp6jf+G5h5B7DXI+79o8j7C1juhhaRBoXNNeKLFDGRq14
X-Received: by 2002:a17:907:8707:b0:b9c:69df:4d8e with SMTP id
 a640c23a62f3a-ba41aa160d8mr675196866b.25.1776816299561; Tue, 21 Apr 2026
 17:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-3-joel@jms.id.au>
In-Reply-To: <20260421053140.752059-3-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 10:04:33 +1000
X-Gm-Features: AQROBzBaNA93jVv_UmWzTfVJMeOxE76v2LE3ElNgYNkBRNwbiMhH8QeZJhb7-Fk
Message-ID: <CAKmqyKMvPoDHD_A+zLfAAcNad4RpmBP0SuNX5RTFZV33kmnZpQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] hw/riscv/boot: Describe discontiguous memory in
 boot_info
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Apr 21, 2026 at 3:34=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Machines that have discontiguous memory may need to adjust where
> firmware and images are loaded at boot. Provide an interface for
> machines to describe a discontiguous low/high RAM scheme for this
> purpose.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/boot.h |  7 +++++++
>  hw/riscv/boot.c         | 11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f00b3ca12245..115e3222174f 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -28,6 +28,10 @@
>  #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
>
>  typedef struct RISCVBootInfo {
> +    /* First contiguous RAM region. If size is zero then assume entire R=
AM */
> +    hwaddr ram_low_start;
> +    hwaddr ram_low_size;
> +
>      ssize_t kernel_size;
>      hwaddr image_low_addr;
>      hwaddr image_high_addr;
> @@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
>  char *riscv_plic_hart_config_string(int hart_count);
>
>  void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *hart=
s);
> +void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
> +                                        RISCVHartArrayState *harts,
> +                                        hwaddr start, hwaddr size);
>  vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                     hwaddr firmware_end_addr);
>  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 9086793b7a7b..5c9547429a36 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -69,11 +69,22 @@ char *riscv_plic_hart_config_string(int hart_count)
>
>  void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *hart=
s)
>  {
> +    info->ram_low_start =3D 0;
> +    info->ram_low_size =3D 0;
>      info->kernel_size =3D 0;
>      info->initrd_size =3D 0;
>      info->is_32bit =3D riscv_is_32bit(harts);
>  }
>
> +void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
> +                                        RISCVHartArrayState *harts,
> +                                        hwaddr start, hwaddr size)
> +{
> +    riscv_boot_info_init(info, harts);
> +    info->ram_low_start =3D start;
> +    info->ram_low_size =3D size;
> +}
> +
>  vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                     hwaddr firmware_end_addr) {
>      if (info->is_32bit) {
> --
> 2.47.3
>
>

