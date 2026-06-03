Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98569CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZhr-0000bN-8F; Tue, 02 Jun 2026 20:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZho-0000az-PP
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:43:36 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZhn-0003ip-6l
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:43:36 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so8860366a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447412; cv=none;
 d=google.com; s=arc-20240605;
 b=H50C5M3XTp1K6d72XZYxMchnjp63prcphoMnOLE4vQq+7naqrmLlMr5GTVTvyBDvkd
 NBGTeyi3zo59RbtfRfKkbvLCJjHEMbZsw29MBqTsqjfeV1nsfrvKaOIalZVTfit4gMje
 fVMB3ZM9pwGXytZrkMXB0kkW+mb+GtaU8C7ueM9Rzrc3WYHSgDPIbOLDCMeM0ig3c/t0
 RVeNORFlI5F2yZgqnRE6BIzaWWwv5osnsqKY1gtp5yd76MWsA+nncfD+FXguXJ4zjY5O
 /yExz5Q2rBjIqiTvZ063++vGQhA18IWHN4LpFYOzhA4Vb+7g2rLqo/DIRW0byDAG57lz
 PYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=34HVZbjV4xGIsTW3/VVhwRHkAaNJIlIs2vBfAIsqaHc=;
 fh=uqr/DpQacYcsRXO1RgcDHJmf4HNnoXaKHl6JDk/PLmQ=;
 b=PfFSWqFpZztwX5nr9nKEUiPTD4LkBDYGvUNXZhha6vP0Q1MoeiMrF2Vj9l+cZLrkDV
 yP+9oHxkF446Z7dM3nXzYWVZzuuDS9fNUDLBE+9f43H5M7gpGmCkWJGo2/YQwWCjED2x
 EUOnzMUq2GGfsV1KmVXVPFFuTQR0iIOgkJN9D7gdwWa+D+vRms0uSIcmUj753rhuCCRN
 LECwKuaITdfj3XxmGQtKqhVDnWeTcYVxu03yONyIQ2/5nRrwIAS1d6aR4CxJokCatvfI
 vA82jR2z4iUXMpOMR3W7I+J5Hmn06r2YBDVRrHPw4uNIUY7RSTv/tuI0JOGzQaQSMXS2
 8CvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780447412; x=1781052212; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34HVZbjV4xGIsTW3/VVhwRHkAaNJIlIs2vBfAIsqaHc=;
 b=UbySrFOnLA9UmcitJD0TNfIVKoK2Gstrkt6mBR9b1e0K6TFi+pIoMcQVKlgJuZJn4v
 W7yOuYmOo5TBe0bRdw6wAkM21/Xh4IXTRP+p4ocWlHplBUK79UuZ30ByGux5JlMAjbYL
 jT8Z3UB+VJZzr7N3ftSTDhNjd4/ozARSPenN+1BTq7v8FVbnoJGsPRaN+4o0WxD4Xr16
 U0veKxI3wfZEz/R8XDhNCz7yZBuKQJi26FejhQD9tyxL41fMf8BW1EwZLbc9BMGcW+g6
 oB0NEu7Wme/0zXWUfN93osZYqtTJmKGkgHOHsXTpzU7vp/gpV8MqjJX+IcuS3eEekJE3
 6AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780447412; x=1781052212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34HVZbjV4xGIsTW3/VVhwRHkAaNJIlIs2vBfAIsqaHc=;
 b=olYqAzJMOx2beoxEWy4+cSUhW5UuPBGuVcfOeOa3UGFw4ho9dmXbaJ/Dka9eOgqIXE
 CX0POlcFwrExzlTXQbkwC1C9unyKkAAz6B7LlGHizdFRWEp7/LohlnkUj5aUGdTLQuaf
 5kpPE9dm6QFYJ0h0jkdr8LaKn1gFzqu7pRvi99KJrMuH2djo/LSaVa5UybtbesAYqG/W
 sUWBNnnm61viie54pa5WFWpRaXfTTVRLCPxcqOZrgjATP4RN4kzXFya3T9CQ+PJD5gPl
 DydoVRAO7L9gwoUpCFkDIN3wWr1rDQUPJYy9ivYzgRTIEML3jSYuVvc+fg7oq02DkZLy
 MPDQ==
X-Gm-Message-State: AOJu0Yw78WrkrO4iFn12wIWKW0av/0+Vg6UXE+nCuhP3TCKEhpHYOhrh
 ipTRRgHkzIAiB/Dso7VSAD29ItDRQusxaD6COeLDVOIzpS9AVoLtaYLOfd3sKACgjzoPY/mKXOx
 6RYXU5h8GQK4/Z3fAmbZ5Q2c6G54xP9A=
X-Gm-Gg: Acq92OErDkPVy175QbbmXRyFPTsD8r/vhC1gxsdsizKGS8WkMmZTwdUfEQtHsxZjRt7
 F7EpnkM3Qd3+7Ri4pMHpP3U7CCBShk03bXg0UYlJxfmLzRASHjDmxrLK2ZThSE+Vy4UMqcDrOH3
 zaXaZg8SzcLr3ZNmxAx4Fcp14/9LgUVR2zLoPToOK1ETThEXR6UNOex2Q/agclccxrqvT3dj/Xf
 uZ6CEz6tOxVxKgp3yeEbu6RO7dhBYd1Z+NWdAjotg6tnEB/WGal47ptotfH6QtRy98RWhSIWBSx
 hSHYnR4ZxiO9QwrHG7iXgDDnOJ8KAdJWakLTTa/27VQm1F7f
X-Received: by 2002:a17:907:cf87:b0:beb:4674:6a1d with SMTP id
 a640c23a62f3a-bf0b15d8aabmr32478766b.11.1780447412071; Tue, 02 Jun 2026
 17:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260529053519.1224019-1-antonb@tenstorrent.com>
In-Reply-To: <20260529053519.1224019-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:43:04 +1000
X-Gm-Features: AVHnY4IFwdF7pq9nDcwdvilMnf7yDm4-l6X86zjwsANhtOoiaZsLI6O92UDppX0
Message-ID: <CAKmqyKPWj5qLUnchuzH4=gyqee9wmwn53FXnsH5dw-kuMvW1bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Print privilege level and ELP in
 riscv_cpu_dump_state
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Fri, May 29, 2026 at 3:37=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> The privilege level and ELP are implicit state (like virt), so print them
> out.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 952e34fdf5..b38ddc39ea 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -580,6 +580,22 @@ static void riscv_dump_csr(CPURISCVState *env, int c=
srno, FILE *f)
>      }
>  }
>
> +#if !defined(CONFIG_USER_ONLY)
> +static const char *riscv_priv_str(uint32_t priv)
> +{
> +    switch (priv) {
> +    case PRV_M:
> +        return "M";
> +    case PRV_S:
> +        return "S";
> +    case PRV_U:
> +        return "U";
> +    }
> +
> +    return "?";
> +}
> +#endif
> +
>  static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -588,9 +604,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE =
*f, int flags)
>      uint8_t *p;
>
>  #if !defined(CONFIG_USER_ONLY)
> +    qemu_fprintf(f, " %s %s\n", "priv   =3D  ", riscv_priv_str(env->priv=
));
> +
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s %d\n", "V      =3D  ", env->virt_enabled);
>      }
> +
> +    if (cpu->cfg.ext_zicfilp) {
> +        qemu_fprintf(f, " %s %d\n", "elp    =3D  ", env->elp);
> +    }
>  #endif
>      qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
>  #ifndef CONFIG_USER_ONLY
> --
> 2.34.1
>
>

