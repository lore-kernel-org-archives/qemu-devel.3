Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAFACD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPC5o-00014C-Ls; Tue, 19 May 2026 00:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPC5n-00013t-KL
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:30:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPC5l-0003vt-Py
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:30:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so7192425a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165004; cv=none;
 d=google.com; s=arc-20240605;
 b=Kz4V3KpSgw50F9D8C5cJOFzGMVcviTDS1FTFH8TZwtFSjTYMcc8wTIlHT4G38jrTDL
 +DHFhU9KU/8FGOG8fEy3LxIva7MyCfihYLCk6IrnrWF6k62xWuPBC7LbeVh+VwEH5Je9
 zO2VvpULtan1QaZvaZ+Cam9Wo+EO1JPcA/PVo6StV4pCyoi1ENFGTYvl2ZKQAUgY/5/V
 7FiHbmMKBt5gjhOb6l0JkmcpEeIf5XkroVrDfrXNs4Lh4vTuYPoXDnho0NrvMHA+wmfU
 UZITaT5f3wdaZna8av+ogHv9rgt34qM1Okx21Z9LNk8aKdXuxcwbFfL8mhD3NLwuQKjt
 aYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I7u1P0DrZw2oKQ8QDwt8gZEmIBrt2954ihMOUmtppio=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=YYSmLKF4Y7u2OGnX+LepGKNJg/pgyEo39H5PfIHl8+aPzSBtxrOHxsOtFS7Ffpyr6C
 7tnpCfGGZl9ZZm43ykzufP35AdaZD8bzcFixZaD/nU2w7LUX/UEW+HYtSIadz1etj7lS
 Um4cGjJXuMZ0Pdo5pjq4EjdDQV6993DFhofmvDmjDQi4YdcRSYCKDeRB/4g+/69Iq07l
 vUqgsL/WHGhVLNmQuoXwGl8EiZpJeEfZNk/uNn7+DJKSZoETAe4rf+aDtiGL8Fm8Kp8i
 jWTfFv+IpKr9TwmvyDrJY+0S9KChdz98DM4m4TNHV1aNajafivK6XFVDr7Tfli7hkv0P
 2Z6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165004; x=1779769804; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7u1P0DrZw2oKQ8QDwt8gZEmIBrt2954ihMOUmtppio=;
 b=CJalWzeYKktjvkAepuoGWJEZLEjm7IT0yJ/wmFeEU4RcSscnRQmUW8XMMHJWUPnKvI
 J7Ewdqp/ayv4ZGWWxHb98Sgj2U28kZq4rIXUX029Q5kKGdZxBan0R8cDUF+cpJUQh9xV
 sv+qcSxOP0gH+BRaAohcfbbU9DdHc9kmGWXXxvzbpNJPHSt1XrhJFpyinX4BB0rXnmu6
 X+b7WacwtmCw1s8NjUZNWVX4UefiitfbGHo+2ZRve8grUALAfQ5XXXpjm01C0o57LYeo
 kGR9MQ9jlviqP8iN9UTGpCfwLHHDE/+WsxP6ZziColPevsyyAOOzeqA2ERv/wax6uvZm
 qblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165004; x=1779769804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I7u1P0DrZw2oKQ8QDwt8gZEmIBrt2954ihMOUmtppio=;
 b=XtEt3B5xVH/B17SiSRRLTgUvs9WOTHZXR9JdCYmUEyPSV4SYTxD1YwYMBY5q9nQHZK
 xbjN4T9AoH73rl+++HXs6AqMmKN/iq6wThC08zBExfp9HC8sGnPpm1sP/Yepoktwwt4b
 b/XIbsZicEqd8hS5FTIagDlF4joUMaae2RumGwWFVfS0hcfXC7Iqblfs2md0zJO3Zbh8
 prUM+EhMDzeHBnS64n8XgegCYlMpJ7YpTkV6stKq6qJC7yD5PDY6GIdl2022Rf+NQJrR
 pZqWTuzda50pcX/HmszvznMAGNZpbwPDNcRXJoS0tQfQOEadjcK1nydVTuqn8KE80TA6
 M0uA==
X-Gm-Message-State: AOJu0YwLtIWE/+KQjZ7XGc7Vj3tq92EUUeRvEpsHR0uFlNYjseGaesCm
 HZLFRWSNzdtJXRSn2xXvp4uiq24peXR98wXOH1TcGsB7FJwbERG2SEXdo46OYJNeYejOi9HCjm+
 8+++llF19eRtY86ULfShqMca8RqAM9XI=
X-Gm-Gg: Acq92OEcKDPjDWYiBIlltZD8vrx4ewBzjWPF8dFbftTAwVHhaKqA1InijZhmEeuXhcR
 /XHmv8usIxIsga73Py70WM9es+F6BLzJ53l/5OZ1gk0R4PH+VJd/pughjgCzP5+4iPH3brU78qp
 UCZti0xB4y1pee20EStECGl9AKDuI0CaZ/HhCbD9XW/N2vDvIxNhYFcU/hEL6j3m8Q3fNALYlPT
 p8vlfIy0bbH28G95B4MvK7iDCHwwhhrP4gYzDVxEhRHWMitJBtlPnlZ8/OPnVofgGKKxw6LBCEl
 0nryi8k6Wmj8JzoDl5Y64cseCEKzXP+WtNFhCw==
X-Received: by 2002:a17:907:a1a4:b0:bad:f032:fc78 with SMTP id
 a640c23a62f3a-bd51777c836mr701826366b.1.1779165004131; Mon, 18 May 2026
 21:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260514123342.2139464-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:29:37 +1000
X-Gm-Features: AVHnY4LArqF5dC4kuHu3P8vyMhC8K4y7kCjNCNU7ikdPObZY43lWGXJ50_rNdIs
Message-ID: <CAKmqyKNA=u9vGVc8-KKOf5a3MQwYPeiLkvvsSOXZB++-nx6OXQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: fix read of pmpaddr(0-63) CSRs
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, May 14, 2026 at 10:35=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The priv spec defines, for RV64, that the upper 10 bits of
> pmpaddr0-pmpaddr63 are WARL and are supposed to be cleared.
>
> After this patch, using the bug reproducer in [1], writing
> ffffffffffffffff in pmpaddr0 and reading it back now results in
> 003fffffffffffff.  Here's the 'diff -cp' dump before and after
> this change:
>
> *************** IN:
> *** 5272,5278 ****
>    pmpcfg10 0000000000000000
>    pmpcfg12 0000000000000000
>    pmpcfg14 0000000000000000
> !  pmpaddr0 ffffffffffffffff
>    pmpaddr1 0000000000000000
>    pmpaddr2 0000000000000000
>    pmpaddr3 0000000000000000
> --- 5545,5551 ----
>    pmpcfg10 0000000000000000
>    pmpcfg12 0000000000000000
>    pmpcfg14 0000000000000000
> !  pmpaddr0 003fffffffffffff
>    pmpaddr1 0000000000000000
>    pmpaddr2 0000000000000000
>    pmpaddr3 0000000000000000
>
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3362
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3362
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e1cd4a299c..476a620035 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5362,6 +5362,23 @@ static RISCVException read_pmpaddr(CPURISCVState *=
env, int csrno,
>                                     target_ulong *val)
>  {
>      *val =3D pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
> +
> +    /*
> +     * For RV64, bits 54-63 of the address registers
> +     * PMPAADDR(0-63) is a WARL zero field (priv spec,
> +     * section "Physical Memory Protection CSRs").
> +     *
> +     * We'll have to add an annoying TARGET_RISCV64 gate
> +     * here to avoid complaints about masking bits 0-53
> +     * of a potential 32 bit target_ulong '*var'.
> +     */
> +#ifdef TARGET_RISCV64
> +    if (env->misa_mxl =3D=3D MXL_RV64
> +        && csrno >=3D CSR_PMPADDR0 && csrno <=3D CSR_PMPADDR63) {
> +        target_ulong read_mask =3D MAKE_64BIT_MASK(0, 54);
> +        *val &=3D read_mask;
> +    }
> +#endif
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.43.0
>
>

