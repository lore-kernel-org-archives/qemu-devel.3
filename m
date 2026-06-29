Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0389BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0Ga-000232-Lk; Sun, 28 Jun 2026 20:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0GY-00022l-Vi
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:54:27 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0GX-0005e6-70
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:54:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso3177701a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694464; cv=none;
 d=google.com; s=arc-20260327;
 b=H7D9jV46XHGvxzZnUT5k2hMtPfgENtJ1P8fM8jAg1Iuv8oK9BR0TcGFtJO0STgNvgI
 zL81VcC1W7TM/HKwCal/GT6jZJm1PS0HT78IkG8BzB4MlbQow7ggkcsOLAPy5ysKF0Fm
 3C6ucUeKaZkfKW2Hy5mjgjN5++Zw6KOtrX7EWaEih1wMvz9Xw0LFVzDGAldUjWdyUamu
 VKsTSZxbeM3+q8y7FZq8EEW9fk2HYjt1xBnDOZQv3ytBJVqtg28Dx1nIayDgEx3/waOI
 /qwYt6T+6L2gUi89Htw2St0z8ghW6JwZzP3ZkIGUbQ+ZBCwjhMOOt3To+2S2P65aURw5
 1GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5d2lZ4pWSohSk57YjRQFDaDExvgrPNsodilWDmJTziQ=;
 fh=UX1Iv2eIVQQe4ZaNCLcfHtXkAXQlDMHBxRjbWNE720Q=;
 b=mdn/nTjxJx0ptEXxQsB8nIN9JvpFmxgxc1oi6YQ1HHgUZeAIwT4yFwkyid2yHQH1Lz
 y/JAUWbFYcsNorGUauPd+fLRMMXTWFZ2DgQfc0h5HyZsWJ3g49uvhykQA3dylUTCQEKB
 JdJhSAYoxh1s2lD9jdBbI4o8F/8TY71cyEP0Zlzo3vmQoJfIJRNJLnuOabKHVjlqrgsL
 XmvTlMRr30uRyhHCyEZkoa8eZdgilBKwcN5aWbjASvxKfk9raRqZagaO9OpDGM4XT92g
 LnMAfftqZzm9dzM8Vwx66Ia5h45RmNsDjpyUyCyviVXT/5KRAQDRlP6XFwXuKGz70yiY
 sJxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694464; x=1783299264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d2lZ4pWSohSk57YjRQFDaDExvgrPNsodilWDmJTziQ=;
 b=pLyPO/m7LPPqH5aC3IaB3UZoGTxZzEYD/e5O+88w2Q3gWmWtwInxe7pH2md5fJ5Xsc
 dRkYQ8cBYZKmVeSjBvQ+uf9JEis1j1P8XeRgRBAwkuE8eb9yJCP7IkGXzqd1fzrzqedE
 jhVzjsu0O1md5khqy8RXiM4PcyspAjqJWMLsMqNKJUKLkv4YFAlAfAceuqcEg/BvdZmb
 Z3RxBO6myjBSce+MMOhphKhg39c0J6LMFztv63MD8izFWepOctTTA+9k6FfHr8ao93aC
 +/AoIZwrM+RzTu9aeS8nvc87mY8ab2VUaE74NSXBQBV8ll1SDEZpKkPLR5eTEkyPhzfx
 aM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694464; x=1783299264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5d2lZ4pWSohSk57YjRQFDaDExvgrPNsodilWDmJTziQ=;
 b=VnEmuS8aqqPeNpoJvWFelyu/RK2uM4l1vFrJQQwMjL2AHNlnUMoClm9p0Dd2ZprGl8
 dqmiOc9BiuQcuCTzIl7wxPkjQAHjqN5spIClrSPOJURj23qsj/O9mnNoY0ZUnwvLG5PT
 rudtJVkyfhQG8lXZNLdm6HYVqa7mnSOZZOK+ZMUsSGBrSVnxVoSevIV65+YBKQkg0nMI
 PfiapfGeEj490MdKKg+GmS0VZpuHAt1KEV45A+B3AkwAOtjQCGvsAJyMfNfn77Jhn/E2
 Mp6faIjfmgYtjNiaSbSUHYH6T+uJFMCpnq61lFPXMVBClejZiKpriHux20XhJ7rXRP1h
 YI5g==
X-Gm-Message-State: AOJu0Yzokd0ewjMNfa0rg70eeF54uQG+IiTYCFgFFSBsyQ25d6BL1QvG
 hinIu0U4aWzM/W74brbTKKH3PvlqxbYmknv/vNPBkSg8qasA2jCjsG4WHxp5ULqLn/UO/sYgvPx
 DsVrWILZKTIEHzdW8CrDZfsg/6NGBFKk=
X-Gm-Gg: AfdE7clwWH1UcFDjlhmNUWyqv6uEukOJhwrTgh96VVc7IKkxl5GFlJUR2HeEW83oZE/
 JPzaLQd8Xq3a5FTm78IPLI/+QlY1jfGX00HtsqNpNvGDUQ7Ww7xF0upvP81Bd9H242wnmuYGNgv
 1hSEzPdHrMRB/4cxkV6XGLqWMAaqsgTzOUfMqV99CYGCUbZp6ttxU6pAvTY88bzNAXPZp8P91CS
 lhBYtb5ha+Z0b5iW9hV+zthVTBv9TaeqnnPNetK+ELBubbG8zf/+5STnboc/WcODeXRLJjZmZio
 zEHmfaBRQHxHKydAHSd/adKxY34=
X-Received: by 2002:aa7:d604:0:b0:698:3b7c:7e41 with SMTP id
 4fb4d7f45d1cf-6983b7c804dmr2942777a12.33.1782694463588; Sun, 28 Jun 2026
 17:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-marchid-v2-1-3821c351028b@gmail.com>
In-Reply-To: <20260625-marchid-v2-1-3821c351028b@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:53:57 +1000
X-Gm-Features: AVVi8Cd9PrZGsLrwdrZZbrz8nzKCtNCvtsbS2dJnvnr9QMX-v0jLxd52gqvOYp0
Message-ID: <CAKmqyKP817ZuYSkctYBaUkbv7+wDEzj2j9qi+5TENE7hSViODQ@mail.gmail.com>
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
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

