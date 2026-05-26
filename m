Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B90BCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhOI-0004XT-8V; Mon, 25 May 2026 22:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhOF-0004Wt-Q4
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:19:31 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhOD-0005Kp-V5
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:19:31 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd6460b0d11so1767624966b.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779761968; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/fNo8KTiEhH+pNk7uy07m/FI1NwLMUW0xmRlD/9KVLqTxWYOh8GyLSJd+tBQU+YGJ
 A7I2IrYOsmv8gez0ppdSeromg7b8AWqzT6SVG6+kWxQY6RiSTsKRRNS2EirwmMI+dF1X
 6Gnet70BsYT0nRwFnoqda3CdKyJOR8wIVzlBBSqZzWFoE/M2Gc/0hOzQhPe45iu/D1tv
 TWQkGlAZ0IenT0NZ5Jl0CHHPWKPpBBoe0XkfH5fzm+nG6LqHT0MAP1+hKIjB904VISxi
 zsK+Xm4f4qNe60kJn6KXzfG2CT1RqNp1EH4mixvwRvB5s8ofeeKqH2Fe65yw5hizZtyX
 7/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A/WiF3FXcSt0EjHZF3cjKD+hGZAXlfDRVfC0X/lAYVA=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=QsCbW6B+DDsSyHd8o+wGIw/0PuuvcShYiKrY6J9KuCIzdjH8m7i5MrMXaTDmV7c5hP
 7579lrJ5AmKAh4hZNVByf537H1doqfuGiblWHXdk43YbrFO9HFQt1Gi2lnyQw2pfOEbt
 9p5TFoSytTlcwyCm1ycFXDYZ7lSSdqeAXrXnlDqBhhot55l17vcyuCmWqDk7zPCVD1Nj
 1ZzLMrU09r9VuGJpUHrqvbn3pbBifQOPsyfFqwG9D7jRSvqq8s/8S5A0/OVT5tKKRPu4
 a6h4Bp8ZFDwRUTMbnqDAxZ5HjJAGL6PsgpYOuT83YkSrgLlF2wZeoLE31RKn2jLLyPyD
 AlBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779761968; x=1780366768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/WiF3FXcSt0EjHZF3cjKD+hGZAXlfDRVfC0X/lAYVA=;
 b=p33dH5pPgW2yl8gl9zZ6vHouT9QmjiaVW/q2INQ4tWESZubZaojHl8KIjsQsRo7Ro6
 IlpiJfinP8V133H4PON69PrGDcYchPW0Xqs0Tpkbbw8gxUDr/r2dtUsNxL3XJiaGR/Bw
 m4FtnMnWyzDrx3kMZ0vHOFhLR38MrnaGKx4tM1RcN2m4HcGJksSCz24aOl1bXhuuU77B
 1rop/q56p8ASQuFrg+UXfrjZoBc5wqSbskq/KQYhHJFkO5MzC0O7rXrANNcYN1i6vWdl
 1icBMEjStiV3ieuh74MS714J76jr/8Lgw6g/ZfwovAuk2sOg4L7PehmGb6mG1IV8Bypi
 zORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779761968; x=1780366768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A/WiF3FXcSt0EjHZF3cjKD+hGZAXlfDRVfC0X/lAYVA=;
 b=iNzrqjNkecQs1+eJsa0cLO2cRBJxME1uvW2DquppqU9zYgXj5qVyX8AtMUIJAGW+66
 udMCRWMf3W+esOr9WAX7Q7jpvRSsLun5vD/821SAII2NAQZrICek/lZzkdqBv1cpMhn1
 RnQC+xoqol3bb2cAV8MKwysQ5b7/8bLKBHnsP7YFQd8jSTCIBR/2aeNxccFb80F7oZUr
 3DiQUexoPBvbYziRW3MrFMKK/eLtpWcWi9BMo2H3K09mgy1oCTfN8tpEB9DcXgnpii+X
 szODdplpso2XkLUhIwn+arO2Czkk+/yfVXulqfMgzuIWHBD6+cMLq5vnEj8O70hAl//1
 hALg==
X-Gm-Message-State: AOJu0YzXlRB50ntQhnZ+wsxW2hqCvKXoPVrF0h3l7M6BvzuqXtEQw61m
 D1T3L0OFV0EUi2saOcDAfxQbITqJ6gvo2wvTJRf7HVZOYXO21l65mWEuA5HoH4iakP1vo1Qd3X/
 18F6GnlW5z2WbEhwwlRBdQw0lgTW4bsQ=
X-Gm-Gg: Acq92OEI0nHu7ccq06tfbkamAcnWnoMUpXKP+BulSWNFC4x4WTTE9WgHZ7p5JQKI9Nt
 22saC4J/gUgYXbClngOBx7vU6nOz0BslLjDZtf8dd34wriZjIf9zSY+RQD0+TIFaS6Q270Q22BJ
 RhLhab3aulAanZWs1/ohfXl5JprYnTeT763t059z5vCb5Jwu7K15MmuvPg+uWCZI+ONEUW67D4V
 H6wrIckhaBgjBra0sVkGWI8cpNvI56Lq8GOe9u26h++QiqsY7gQNX/t7aGu0Dch/iHwiIJqi8eY
 j2AZiXWWTocCyaO0LP49R30O9vZOxDYtjhmh2w==
X-Received: by 2002:a17:907:cf8c:b0:bd8:bd2b:abbb with SMTP id
 a640c23a62f3a-bdd22938bc8mr894632266b.10.1779761968229; Mon, 25 May 2026
 19:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:19:01 +1000
X-Gm-Features: AVHnY4KQT6VDxTADh_RU1P4DHYk49Xt-OqnXzAHiCJMI00yKAz5zrEaIyWT9l1I
Message-ID: <CAKmqyKM7cLb=gdhEyPk7TMMpQiNX_ZKOJvTkV+330duS+3fZXQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/tcg: disable svpbmt if satp_mode < sv39
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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

On Tue, May 19, 2026 at 9:49=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Priv spec chapter "Svpbmt Extension for Page-Based Memory Types, Version
> 1.0" mentions that "The Svpbmt extension depends on the Sv39
> extension.".
>
> We're not doing any satp checks when enabling svpbmt.  This causes
> problems with the riscv32 'max' CPU that happens to be enabling svpbmt
> even though it doesn't support the required satp mode.  In fact all rv32
> CPUs are allowing menvcfg.PBMTE writes, which doesn't make sense for
> them in any circunstance since svpbmt is not possible for rv32 at this
> moment [1].
>
> This also impacts rv64 CPUs that are running in satp 'bare' mode and are
> reporting svpbmt in the riscv,isa.
>
> All these problems can be solved by disabling svpbmt if satp_mode is not
> at least sv39.  The problem reported in [1] goes away because we'll
> never enable MENVCFG_PBMTE write mask in write_menvcfgh().  We're also
> become consistent with how svpbmt is enabled for rv64.
>
> In case the user enables svpbmt in the command line using an invalid setu=
p,
> not just disable svpbmt but also throw a warning:
>
> $ ./build/qemu-system-riscv64 -M virt,dumpdtb=3Dfdt.dtb \
>     -cpu max,sv39=3Doff,sv48=3Doff,sv57=3Doff,sv64=3Doff,svpbmt=3Don
> qemu-system-riscv64: warning: svpbmt requires at least satp sv39, current=
 satp mode: none
>
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3473
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3473
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a358d91ca5..5b3e36d9ab 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -887,6 +887,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
> +        cpu->cfg.ext_svpbmt =3D false;
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
> +            warn_report("svpbmt requires at least satp sv39, "
> +                        "current satp mode: %s",
> +                        satp_mode_str(cpu->cfg.max_satp_mode,
> +                                     riscv_cpu_is_32bit(cpu)));
> +        }
> +    }
> +#endif
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.43.0
>
>

