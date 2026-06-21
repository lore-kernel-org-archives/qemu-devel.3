Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDC1CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 23:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbS2i-0001aM-KD; Sun, 21 Jun 2026 19:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS2h-0001a5-Dh
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:57:35 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS2f-0004UQ-TC
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:57:35 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6978f0870c9so1332674a12.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 16:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782086252; cv=none;
 d=google.com; s=arc-20240605;
 b=TOZ2HeoCS+HW0V58w+BfMH8xVH0RgoRywnFyn43EBJMxPotaOirs02vq3fE5UqqdAI
 XMO8uRxn6xHmUZ53hEo6t88uTHJ3U9+0h+zA0QOK4RqNXQanVjZbtgCvkgCFiq3zQziW
 Pau8Sfn8PVILkZzvt0uVmwuEQ9PfurQP1J6YnlVsRzm4ys4OMXuO1MtOAVjGzNk8q9F0
 VGWFu1sJB5CgVhRMVihQfa0BT1mOX4Gk9d6cXoTcbPjWDt5Y4opS/hFWZvoj9WwltYYO
 u413jCxJRWSlqFpwD2zU6v0xegEDDLIifgg/XpSA2FQ7AwnNyLPrGWojyBkOgvjcT9zF
 UB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LDMAoyM4aclkV3vCbjNWWErpW3ALnmEMfaOuJwiY/Qo=;
 fh=0PBKHgIskmm1L7ONMYOvSpwZKdMLVmwojJbXj83/ApQ=;
 b=HPdBD76b9paGcT+TlyL5kl2fgn6jGJi47EsjoC4Gj0G+uM7XznOiXDJ8tqWLgS7sV6
 MSyyKfk1qV0foSuHHCgEBoJNmHB4fnnK5bQIol0R+fkUgXW1Z5tG9NVFCbZk/IDG0KWa
 saQF59nDyzQsWTeCR0TfN7ZENNJmvkea6bNC4Z/Mhpopoc7aA6/64Sel22XQypUr06de
 OXNFa3cdccsjplM1GLpGbKAGr2W65JGKsyzU/wv6BwRluffSzBSe7yBAH6s2QSrASlI1
 z3I3nlb6swGsyJdEp6mo+tsnkuvToEO2yQnuanD02PzCvQgQZy76Qd4Qwic3Pm+V91t+
 nUkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782086252; x=1782691052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDMAoyM4aclkV3vCbjNWWErpW3ALnmEMfaOuJwiY/Qo=;
 b=iCQffeqNHEjJSLN21fmXtOEVoseCKtyAaHE6MQEKt4XRNZQQ1Rr8u53tBzMHrXIAeb
 GXFylN5G2SwkvsMoKqkJGOVNZKPvAe8p9I8LYggDDBgz7YY4zAxZGosCY4wG+Fy8eM0V
 RSWWo+e8kdOBzaUwy+J3WD2hUxYZanuqYWsvLaGOTBRtly965j2SNGdA90oWWZPFMeyr
 ilTSLszlWDCUOx/YNOuLQzF8HJMQ11UXVT9T2maw7uO0UwMelGNHpwsJ7XpnqpckkhLS
 89iXm1xu0dqrlm2onw1HcMkUXaOMwqgQa2xo8N1KFu+uIgnT3bUuuqc4/uk6BY8Ok4xL
 zaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782086252; x=1782691052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDMAoyM4aclkV3vCbjNWWErpW3ALnmEMfaOuJwiY/Qo=;
 b=QmaMKn+Ybm2/9edhnl5xhOGuiwBLOZ4vUdZWG28BlsVB54jBQjjwyjitPSsZYYIMqY
 bZ4dHygNtWDX9oLytEikG/O/2j9arRbIYJD9GJ8sAmYmLubW9eyu48FYQjmTRgGVVfYB
 ex54/qqqlWqW4upE622u4mGL8ZnkInuZj68qHulZD1qrtIxCzeMWIWh53BP3/qSWHf5r
 NX2Xs86HY/R/o2u0bHKwh8PewRGcKO38CplN1TYgmBBBQyurw12+COvR1MasoMhD7rTS
 XBRbmVnzbzrAgDzxMlsJhCfej8wWMsRuWfnE5GN8NKdRwzRZ5kyqLhX+VI3xubMCIiz4
 JSgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ84vmfPUnm4iGG1XcX9x9onvu32JeYV+EVPB8QAy1sLXlM2alw2p6wR10noZrtdfsjvvEAaedcI92KY@nongnu.org
X-Gm-Message-State: AOJu0Yz8LS9gIiXTqQ2IEcEUbpD3hs3Eyrz46FAX6aYFCQBmYhdoT+OV
 aqNQBzp4SImrD8mip5zw2N4ei9IgIQc8cKFECHYZZV7TR8a6h/a87yKSqWO2JuHTucMZUEOLX1G
 ubXY1Zi53mlkqpdoHjb9VnwQ8jXYl+C0=
X-Gm-Gg: AfdE7clScPMsLlqToYzph5n16wEud22p+WA7VVE5vBt2vsr8piu4n9pToVNjFGqx1/2
 78ZBlKPzHw/H2yKQpJ+9Y4BJHvyXBc65Zo2ufi4RleAvgeL+EJa4UPR68bTFMz3cPQfiVaWAiEo
 1NB4cEfR9ks0HCYCTSz0ChzBT1Sx14+/mZI+bj9f4swZ6vsG8BxP1kpbh5qrCufm98GvbQHThOJ
 HtpSljXU68RrPJmP4Oz2VbAC9L2r1+3fuKn/nmStgdckGLvAiC8CsgnVSR43T1pxpS4PWQi8BtF
 u971gMOKr3tJJpJbrs0QrrnDsVmLHWUN+Sh+DA==
X-Received: by 2002:a05:6402:a51b:10b0:697:7fe4:c3db with SMTP id
 4fb4d7f45d1cf-6977fe4c47emr1657897a12.3.1782086251764; Sun, 21 Jun 2026
 16:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-2-joel@jms.id.au>
In-Reply-To: <20260617054034.1020724-2-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 09:57:05 +1000
X-Gm-Features: AVVi8CeFRjDUtF1P3XaXPENhSrSjNzL7ZqQP7cSQd8IfA334o05s3ipaoFlhYOI
Message-ID: <CAKmqyKM0pWWTzubMZqKB8k3hdZpPki2wszsmp6OJrfWE8mL7Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: Avoid NULL deref in IMSIC CSR write
To: Joel Stanley <joel@jms.id.au>
Cc: alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Jun 17, 2026 at 3:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> rmw_xireg_aia() and rmw_xtopei() were changed to store the IMSIC
> callback's value in a local before passing it back to the caller.
> For write only CSR accesses that pointer is NULL, causing a crash when
> guest programs write to xireg or xtopei, such as when the guest sets up
> the IMSIC.
>
> This only happens when setting aia=3Daplic-imsic so none of the existing
> boot tests caught it.
>
> Fix it by guarding the pointer dereference as done for other CSRs.
>
> Fixes: 63469ad75dcc ("target/riscv: Fix arguments to board IMSIC emulatio=
n callbacks")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ec931a8c3ddf..4502f2ab4788 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2732,7 +2732,9 @@ static RISCVException rmw_xireg_aia(CPURISCVState *=
env, int csrno,
>                                      AIA_MAKE_IREG(isel, priv, virt, vgei=
n,
>                                                    riscv_cpu_mxl_bits(env=
)),
>                                      &wide_val, new_val, wr_mask);
> -            *val =3D wide_val;
> +            if (val) {
> +                *val =3D wide_val;
> +            }
>          }
>      } else {
>          isel_reserved =3D true;
> @@ -3008,7 +3010,9 @@ static RISCVException rmw_xtopei(CPURISCVState *env=
, int csrno,
>                      AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein=
,
>                                    riscv_cpu_mxl_bits(env)),
>                      &wide_val, new_val, wr_mask);
> -    *val =3D wide_val;
> +    if (val) {
> +        *val =3D wide_val;
> +    }
>
>  done:
>      if (ret) {
> --
> 2.47.3
>
>

