Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDA1C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thI3b-0001YW-Ik; Sun, 09 Feb 2025 19:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI3Z-0001XX-B5; Sun, 09 Feb 2025 19:53:49 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thI3X-0002jz-Lo; Sun, 09 Feb 2025 19:53:49 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4b2c0a7ef74so2597408137.2; 
 Sun, 09 Feb 2025 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739148826; x=1739753626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXONoNNTGaXXKSl1DL1uZSnQOd1CCrunq2zGZIh0jwY=;
 b=i/z+u7LiIDY3NoHH5SZQJt1hkiGaRkVPRYnDLM9OGqcF3bNTahCww7GjEEVvGK2B8+
 eyV0V5sWiqHFDulpuLd+j9lr0RqkefCycgLULBh+oGSmkpFG6sGcLE2eWayPTGiV6B0b
 Mg7OWtgE/TI++wvLK/Zlaw+5BDzhjOvJI8moNpQhSmF8bDrSmyac/sOUlFOrvSogOB1p
 FWO17hATuousZmt0A02a61jUQeQXrxjaqumVPND92M2yiDIfhHaM+j3gwlwRZ+h7pMbK
 aVwdA4k6/lZrQy02RRiv27/C0CG3axWWSKs76i/zgggr+K3VKWMeG6d0DffQ6zD6j6ww
 +XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739148826; x=1739753626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXONoNNTGaXXKSl1DL1uZSnQOd1CCrunq2zGZIh0jwY=;
 b=Jxq0lf9t6v6kzGBskbINQ47Ng/tkjI789+mgJ2f1Xc0j6GxkkkGvkaIFfYsJhOZc0V
 aEAS0sl13gmcndsJRYKDkaQc5fXH7YDFle7dPLnewzjOLXeMMf6wvWEn4+icqKrKqlPp
 SGlWyRmqoK/n+gh5hZVq1zXHeme5OzWkunqNloxEtZDADtd3Vc//uIqQUMcRDmFehxU1
 pNLaDCvgeUFRmoZjOchsVbSB/Exbh8ycyl/M+ClrwnCtFxaF8qQkuGzuUeBhXa++WD34
 +imm39dGPV4JMk3uKaiswKgCi1NkKY3hToLRZpcCd/SQBDIARUDYE3Uo1TqRr5xJofy2
 xOGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv4aJIOT/3nu2jiAm41s3wB40Rc+E20aBrbAWoduDTg6vL7X3QLO6ShhiPEIWcdwQ3saO+8gkXuvtd@nongnu.org
X-Gm-Message-State: AOJu0Yxqk2/ue1s+UkoqIcvuxTmpJgh1i/MJYo2rX+d4R+RblCOGd1os
 TzyxWqGe45ME6feBjDV2yuYnn6tlZKanBIImhn6fZBgSe4SmEwFaBUmp7y9SYqFvCyP+pQfiGOA
 Rt3sUDrtuOgnVjsKNpHIsWpZsBQM=
X-Gm-Gg: ASbGncv68AiCLV9ijnq+1FmyksCqbn+wzD7utOFr18/n29QClb9jjJJkThmyn9kGg2j
 1EThSg50z8t35aLwiaw8gN/A3D1N7vcACvH0tjIBrI7OalxK8PQeHyQgsW6aE4dowqO4udB0R8r
 8KmnHx9dmpJJmsveuWl/o79j0EPw==
X-Google-Smtp-Source: AGHT+IEkx8dVap0E45mWVk6Y82qBF9DsyRoZXtlnG+QIyPBEydGgAawPgipnPIx0iQ388teo2+2TS3HoCDLkZmtKu58=
X-Received: by 2002:a05:6102:4414:b0:4af:e61d:e22f with SMTP id
 ada2fe7eead31-4ba85f90424mr9324038137.24.1739148826202; Sun, 09 Feb 2025
 16:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20250203061852.2931556-1-midnight@trainwit.ch>
In-Reply-To: <20250203061852.2931556-1-midnight@trainwit.ch>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:53:20 +1000
X-Gm-Features: AWEUYZn_mdXtgtkW9WBZOWTTNbvHXgXbMn8N4OJ7hHDKZ7oh9HaLFjwTPQcZ2eg
Message-ID: <CAKmqyKMGqMBaMUGL9DZW1zHJhF1LdCec_R4HgB7O1W71O7KHCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: log guest errors when reserved bits
 are set in PTEs
To: julia <midnight@trainwit.ch>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Mon, Feb 3, 2025 at 4:20=E2=80=AFPM julia <midnight@trainwit.ch> wrote:
>
> For instance, QEMUs newer than b6ecc63c569bb88c0fcadf79fb92bf4b88aefea8
> would silently treat this akin to an unmapped page (as required by the
> RISC-V spec, admittedly). However, not all hardware platforms do (e.g.
> CVA6) which leads to an apparent QEMU bug.
>
> Instead, log a guest error so that in future, incorrectly set up page
> tables can be debugged without bisecting QEMU.
>
> Signed-off-by: julia <midnight@trainwit.ch>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..3dd8e06044 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1226,14 +1226,27 @@ restart:
>              ppn =3D pte >> PTE_PPN_SHIFT;
>          } else {
>              if (pte & PTE_RESERVED) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in=
 PTE: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_=
FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                  return TRANSLATE_FAIL;
>              }
>
>              if (!pbmte && (pte & PTE_PBMT)) {
> +                /* Reserved without Svpbmt. */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE=
, "
> +                              "and Svpbmt extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_=
FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                  return TRANSLATE_FAIL;
>              }
>
>              if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +                /* Reserved without Svnapot extension */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
> +                              "and Svnapot extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_=
FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                  return TRANSLATE_FAIL;
>              }
>
> @@ -1244,14 +1257,19 @@ restart:
>              /* Invalid PTE */
>              return TRANSLATE_FAIL;
>          }
> +
>          if (pte & (PTE_R | PTE_W | PTE_X)) {
>              goto leaf;
>          }
>
> -        /* Inner PTE, continue walking */
>          if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
> +            /* D, A, and U bits are reserved in non-leaf/inner PTEs */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in n=
on-leaf PTE: "
> +                          "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_=
lx "\n",
> +                          __func__, pte_addr, pte);
>              return TRANSLATE_FAIL;
>          }
> +        /* Inner PTE, continue walking */
>          base =3D ppn << PGSHIFT;
>      }
>
> @@ -1261,10 +1279,17 @@ restart:
>   leaf:
>      if (ppn & ((1ULL << ptshift) - 1)) {
>          /* Misaligned PPN */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligne=
d: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "=
\n",
> +                      __func__, pte_addr, pte);
>          return TRANSLATE_FAIL;
>      }
>      if (!pbmte && (pte & PTE_PBMT)) {
>          /* Reserved without Svpbmt. */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
> +                      "and Svpbmt extension is disabled: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "=
\n",
> +                      __func__, pte_addr, pte);
>          return TRANSLATE_FAIL;
>      }
>
> --
> 2.47.0
>
>

