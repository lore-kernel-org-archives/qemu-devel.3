Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B757111224B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 00:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86Ol-0000qw-Rz; Wed, 01 Apr 2026 20:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Oi-0000kj-7P
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:59:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Of-0003gC-Ij
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:58:59 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66ba9dfe83bso470464a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 17:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775091536; cv=none;
 d=google.com; s=arc-20240605;
 b=RDzxrkOlIrxAMoCQje9KJ0G2I3RGKZvkYG2Si6K1fZbabnrI/4UOCEyqy0lcSSJT9j
 Hj+59WmkRHtYwMOnXR0PeNOMkBwoiU9nKFyTaKP4KJyWhS8U3Mx6kbXV9grWFB6Cm9sZ
 fm+HdLVv46dK3HBgwKmmvpwda3kpiXzX3aJOFc9Ajz54+Ccvrl295boHkHmQlCvMcswN
 /b6mbgYOCqUmXq6mIrec5U7VxylnlQMXiHU2ku2YB5Ure9RrkX33mnoMivIIdvifb0EU
 kRcK5ZKFJ2AGEtxgbWe5dc5VhEiJAoM5JY5nh8lTF7hgzfMuphids2DSfxCU7p4TjcA3
 A4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lDoDBNmBnIOdYYju17UifnlbiP5MhKUTGcHpFusvOyQ=;
 fh=AYl5sbYHcu6np+DU48iQmU5487MBLvGZaXtQ7QnoEn4=;
 b=AYoEw5sHrQ327k804EOsy6J4neGGBnMg0cEox29ob2OjvbK9g7W/XUfBBkohv051Wr
 G9dcjwAyeeFt02zbVODEBSccIZlFAZ9IDkxo6lGuIvnhlPI4VzLpy3rrWuwfRP8diZsx
 2XyHRGvjfijxm3MkAaM3ZkQxybbXuhEKxAlFi9DjMBo99F0fwfbCPhrRrJ1hzSJ3MeGa
 BY2lqUrTmw62E0B1+NcaaIoMMr07MXvXL94CQK4yC+Tz8SLemlXFgx25eIhRP1BLVur6
 b7gR3N64Mcv57G0NbB2Gshztf/3I/Q7MqGHslpLjfjm7GGlN2GovGs12ig9V8gKMhzjY
 nNqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775091536; x=1775696336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDoDBNmBnIOdYYju17UifnlbiP5MhKUTGcHpFusvOyQ=;
 b=FwrPumlcYFni9veTJ1CBUfOS3drT7D7uW5CX4eAN9u6QT4TA/70ntF9CnTJOdLANhO
 50TytV0iQUlwZf8NqUYPdQtDE0NJmd48yMQ9Jcfxbvl+k/Igdekpix5IVeevTCLWQUWy
 abCczvv6uJyFY9knVgaFPXqWG2Hz0xFsYP+4/XsO+UNHH28tI0EL9koNYKnbIUo1XFh2
 oYwM+ir6IkfuOUBOwuhn/RSZX4LujWTmbZCCAd5TQzH7GIcfVTXKtrvDmrp3TqtNqvwE
 O3Q/U/9aALLJigBLK19Mix/q62c+a3seRNe2hxVricOZYVZcoFOkIxPCWLM+vIcpPq5N
 2q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775091536; x=1775696336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lDoDBNmBnIOdYYju17UifnlbiP5MhKUTGcHpFusvOyQ=;
 b=OgdO53fUH6wqpq6v7xc9QDHFkmYH3kD6qWc8f5V5+7B+QM54Nck3FalhDNczj7TR9K
 vNuBw/dI0Khoz61NaGdFRcXYqzcZ7PvAD30vrxZj1ir5enGeIFzlkybWsQ1DiuM/IUV9
 zxOh/l3P7g9AHgAsID1UBi5mBfhTY/x78T5bDRk6+Uxaw8G4FZLxSnJWZiW5ArB9p/vY
 fCbJIySJ2BG8hmDD58bMfXI6DkD7H9J2Y9QYN9ukJKmGqSHKdWc6H8xtwhyIux/Tsn6e
 NOPGSeNNGWeJvVDTARdjIO2oSaapwjWS6hERUX0NkCKSzJ8BKyxN1jg2wbENCih/u5qQ
 Vfqw==
X-Gm-Message-State: AOJu0YzY97cJLV7dolgTYWxH2w3lbWh+7tbPj56G9JJw4E30hoepn/rA
 q78WwzE25Ww3zOU2wcFb0zBo8UqL9XqPhfXs8rxrmT+eg8TyIXb6qNQlRlGUYF5GTyspuruK8Qb
 HNpRPeU5gFZS3ktoUd80BVrZgVL3yslLUgVZO
X-Gm-Gg: ATEYQzxMLnoJVbTY9JzH2lClsJOf8cVqRl7B/XYEwQYOCuoVfKx/xRYHS69UZHLIUpD
 QONfYzwh5ZKztW9v6Ruy+AsDzZSubQ1mAho5MNHbRy6c3GJSZdcrVRoQNhdjp1mPQQpE3hfxgGZ
 /Czj2WcSUHYxDRe0KD79XuT3YEKBPSyb5dH2Il+RWiykGGwiqahDhTbLdwzWa6G+EkUceQRzkdS
 cUecgIUsbmGLIE8gL7Tho+TuNu7Bpp8UUyjhW2SHFWGunWO43WaKsdZDvRd4T0CBBKO8206BZqg
 PApvmunJK5ZLl91hNmBFHdZ8Tg8ZwV3FlVTfmg==
X-Received: by 2002:a17:907:1610:b0:b98:311:e048 with SMTP id
 a640c23a62f3a-b9c1378b3d6mr365037566b.7.1775091535797; Wed, 01 Apr 2026
 17:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053853.10473-1-sebasjosue84@gmail.com>
In-Reply-To: <20260401053853.10473-1-sebasjosue84@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:58:28 +1000
X-Gm-Features: AQROBzCp0HWMYx5SeF4wdqTVmxAt_HeIP_oycuxc8GYT1GJS6_-yJZHR-gh7UAQ
Message-ID: <CAKmqyKNp4zXhuEXoB3QWVOk0r+zO47XAP1_Kb32=Y1hs3nuB3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: fix stale ptshift and base on page walk
 restart
To: =?UTF-8?Q?Sebasti=C3=A1n_Alba_Vives?= <sebasjosue84@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Wed, Apr 1, 2026 at 11:57=E2=80=AFPM Sebasti=C3=A1n Alba Vives
<sebasjosue84@gmail.com> wrote:
>
> When the atomic compare-and-swap for updating A/D bits in the page
> table entry fails due to a concurrent PTE modification by another
> vCPU, get_physical_address() jumps to the 'restart' label to re-walk
> the page table from the root.
>
> However, neither 'ptshift' nor 'base' are re-initialized before the
> restart. After the walk completes, ptshift has been decremented to
> its final value and base has been overwritten with an inner PTE PPN.
> On goto restart, the for loop resets i=3D0 but ptshift and base remain
> stale, causing the restarted walk to compute incorrect PTE addresses.
>
> In an SMP guest with MTTCG and Svadu active, this can result in
> incorrect physical address mappings or guest crashes.
>
> Fix by saving the root base address and re-initializing both ptshift
> and base on each restart.
>
> Fixes: 0c3e702aca ("RISC-V CPU Helpers")
> Signed-off-by: Sebasti=C3=A1n Alba Vives <sebasjosue84@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861..22bab45 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1316,12 +1316,15 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,
>          adue =3D adue && (env->henvcfg & HENVCFG_ADUE);
>      }
>
> -    int ptshift =3D (levels - 1) * ptidxbits;
> +    int ptshift;
>      target_ulong pte;
>      hwaddr pte_addr;
> +    const hwaddr base_root =3D base;
>      int i;
>
>   restart:
> +    ptshift =3D (levels - 1) * ptidxbits;
> +    base =3D base_root;
>      for (i =3D 0; i < levels; i++, ptshift -=3D ptidxbits) {
>          target_ulong idx;
>          if (i =3D=3D 0) {
> --
> 2.43.0
>
>

