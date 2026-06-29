Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CDCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0DR-0001W4-4O; Sun, 28 Jun 2026 20:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0DH-0001V9-7b
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:51:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0DE-0004tb-7n
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:51:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so4855334a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694255; cv=none;
 d=google.com; s=arc-20260327;
 b=kL7LKwgsMEEnb0PCl1tCkupg1OUi35VhzCvFUIMitdW2aFSCQwVeyBp7BQBgdrfw59
 r/B4IvdCVt1fH1Gd9YhdUzs/FHyTfPtJYva/y9WKGoQy6qQ4AihngfGlCjFg2WxQhSYR
 rd+kRTxsBrilj4SUOg73Y58JvhEZoTEfD2JoTjOyI+7Top/HiPUwyq+DCPMtfXvbJHqm
 aaGwnhoiQOBGpf1Y3gh1nbRpNOuOGtnmC0P8IwQ0WTYiMPnG8N+ZbiUyxZ2eY33L6e6t
 G1GSnU4sjJ14+iu7E5Bzws5sbjZo4KDh0kf2NHMET+XtcX8j9DPPlcnI8I81ByYUzYIt
 hHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LwzgFFmYXx5EzS6oTaFWg3iGy/aaClN4MZPlgQhAOQg=;
 fh=UX1Iv2eIVQQe4ZaNCLcfHtXkAXQlDMHBxRjbWNE720Q=;
 b=KK6tdcz690kzbspM62d0k0H+D+OdKvObBz3pB0uDJKKDKHJIiX1uJ721VH/sXZJNAP
 +GZYBY4oHr4sB8SMibOJPKcgY6pb7cBy2qr0/P+xJfZMzXUsoMayRpqzoEQqPqJz1P03
 v6qCM1ix7gkqqoNRPjBQ6KpFN20PJwc7+v23lfFCEb/V72XcpUHbA+F+UF9H4wK53Xqz
 0N7bG/ZBOII7n9JxtQ2R08WpzK9rVdKeSJQ8tw5JXW7uf810YZOfKhX4T3c+E5KdzlaX
 1kBPmpqH1gtq5He6P39RKDluPe6LfmvW1GKNNEh725AQamnC26QrD94oLSzb1FHZadZ9
 NWPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694255; x=1783299055; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwzgFFmYXx5EzS6oTaFWg3iGy/aaClN4MZPlgQhAOQg=;
 b=EO23m/0KgRZmG4QM6VEQTumFyQKM2fOIXk9EqpTfRKTTsJxDaJz/I+8TZ+70zszbLb
 m592PpoftK5xf5gXQGVRVu+ARw404EogPCv61prDu7IPNZiF2o6GYwolc0dWZjv00ZT6
 dguRbdWdX8kwymxCswuKBYlcyEKnONWLBRw/PZGP9NrrHMuGq/RzQLkBqCT9g/WwDdhx
 8YAzTQ8f2heFtaSvkBanilN0dBOm/f0ZGK0RKu0yLPq9WybmX5Aw0LtbSUIFljvZd0WG
 fvdjaMM1ED3tjucojOjp8mYhtiD/yNsGReIoRtNVUdIPdJMeeERXvGyGCWncr3sDxiA/
 vxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694255; x=1783299055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LwzgFFmYXx5EzS6oTaFWg3iGy/aaClN4MZPlgQhAOQg=;
 b=ZpmL1Ph8iFEmRI0rWUiovEk5yBNliNF+mAGTydaE6+hgo+dDxMYPIn67x/eDHfeue6
 GKGLeI5OaA0pW2VntD/O5Euj9bpg+U8sITKpF0l4YUY0Te/1iWu9Rza2KknAEma/iefH
 x1dxyFDZzfQkL0e86ANglYQG9jbxhntzfF7Zd1adxZnfG3g6GnEfnDO2TIV1ZGHCF2C/
 T85W5szC3TJ+m+rnYDMLO7KOGTcYuShiUqIA/CuFWFs0Lh+BC85AWqF6SGlHzJesoE2k
 H16RrJLmYzFZANpHlSGDBNp0J9hBXKS3mrp1ZOkiYfVeROniR2/ITbXHabjJVFG9ck8w
 yVLg==
X-Gm-Message-State: AOJu0YwQFLHy8IRdZeYx/iAWNA/Q3AnpwSczwueEJxvKq6oeLRBfuY/k
 /LIsWlmjNBdtafu8EHoVi9vhTUS0wJkjnv/+W/18nCKMzINbZe+oMw11oLQcEETR6xr46V9lgqh
 ehaeTF0A4/9m7t5Y3vwsnFnsYnaweZcc=
X-Gm-Gg: AfdE7ck2fejS/69rM1wLNvmIxtxfN2d4QuBpIJjzN6M0PJkqUq5zgHzKJqDvnf8I0w/
 jyKci2AzcGJs0YMlS6aMToHeIS3MhYomAA7NU1GkYzNS9p3SPTP9ifrekrmoZhjHWEK4eLlFkQG
 l63BODidlYlKpgtret2Wr2m1MfLTctaTeyHX1GhQvoYpY4nK7qMzCmgbAKEzS9xzljzGbL+EOXi
 1wqnKHmcB+9EolAletvcdMMdjEyfbwsDhBdoOnmU0nYhY9Hvi7vNmlyH345tEh7DGXn3SKUVeJy
 bYp3FXKljC1QeyN60SZMnZGy2sc=
X-Received: by 2002:a05:6402:5113:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-69810a45891mr5278450a12.4.1782694255358; Sun, 28 Jun 2026
 17:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-marchid-v2-1-3821c351028b@gmail.com>
In-Reply-To: <20260625-marchid-v2-1-3821c351028b@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:50:28 +1000
X-Gm-Features: AVVi8Cfsp3EivFshtIbSQ8BCLnflCzLg2cCoR1E59koj_BUM6CGu6o4LxVHDf0A
Message-ID: <CAKmqyKPu+F9xaNiXuTC4R0VnCNXZ=z9kPNCQnyYs-d=pksWUbA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Report QEMU CPU archid as 42
To: Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jun 26, 2026 at 3:13=E2=80=AFPM Charlie Jenkins
<thecharlesjenkins@gmail.com> wrote:
>
> When a non-vendor CPU is used, report the archid as 42 which has been
> allocated for QEMU in the riscv isa manual [1]. This can help software
> check if it is running in QEMU.
>
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> This series was original proposed by Palmer Dabbelt [1] with a follow up
> by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.
>
> When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
> marchid will now be reported as 42.
>
> > qemu-system-riscv64 ... -cpu rv64
>
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_z=
ifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_=
zbc_zbs_sstc_svadu_svvptc
> mmu             : sv57
> mvendorid       : 0x0
> marchid         : 0x2a
> mimpid          : 0x0
> hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_z=
ifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_=
zbc_zbs_sstc_svadu_svvptc
>
> When booting with a vendor CPU like veyron-v1, the proper marchid will
> still appear.
>
> > qemu-system-riscv64 ... -cpu veyron-v1
>
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei=
_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_=
sstc_svinval_svnapot_svpbmt
> mmu             : sv48
> mvendorid       : 0x61f
> marchid         : 0x8000000000010000
> mimpid          : 0x111
> hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei=
_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_=
sstc_svinval_svnapot_svpbmt
>
> [1] https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.co=
m/
> ---
> Changes in v2:
> - Added comment linking the spec allocating 42 to marchid
> - Cleaned up the id setting
> - Link to v1: https://lore.kernel.org/qemu-devel/20260624-marchid-v1-1-a0=
af7997071f@gmail.com
> ---
>  target/riscv/cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fa497e5e8a..94946d335f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -47,6 +47,13 @@
>  static const char riscv_single_letter_exts[] =3D "IEMAFDQCBPVH";
>  const uint32_t misa_bits[] =3D {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>                                RVC, RVS, RVU, RVH, RVG, RVB, 0};
> +#define RISCV_CPU_MVENDORID 0
> +#define RISCV_CPU_MIMPID 0
> +/*
> + * marchid allocated for qemu:
> + * https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
> + */
> +#define RISCV_CPU_MARCHID 42
>
>  /*
>   * From vector_helper.c
> @@ -1183,6 +1190,10 @@ static void riscv_cpu_init(Object *obj)
>          mcc->def->profile->enabled =3D true;
>      }
>
> +    cpu->cfg.mvendorid =3D RISCV_CPU_MVENDORID;
> +    cpu->cfg.marchid =3D RISCV_CPU_MARCHID;
> +    cpu->cfg.mimpid =3D RISCV_CPU_MIMPID;
> +
>      env->misa_ext_mask =3D env->misa_ext =3D mcc->def->misa_ext;
>      riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
>
>
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260624-marchid-80d176b873d8
>
> Best regards,
> --
> - Charlie
>
>

