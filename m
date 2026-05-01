Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB2FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIf3l-0005Zx-C0; Fri, 01 May 2026 00:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf3j-0005ZK-1x
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:00:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeyv-000483-Ea
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:00:55 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so236866366b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607498; cv=none;
 d=google.com; s=arc-20240605;
 b=hdxCCPk0aosQ+qcp6Xp4D8UwgrWmys54yFPGkay+P/hOg7b/RhDXvcVdH7hM06b0VE
 S8b4hnSTZqtGv2Gv46zGfQx0i9xdmyX6aaxRRy+RdA2DyTiWILtFFOFt0Ngm2W1ICQ+j
 k1yMHV2cH5tJ4ttVdWE6G3Ody1x9KcjC4AuXSOmz/rWfJkoU6r0Vz5l9i5savobk/5U1
 nwjljZibHCOhz4pPyfPHRUbo3GKayfH3jRSofp5YOvkooMYyPtdlH6Flsx09FMuHrcv7
 B23zPSFmTz3Xazro5g81jzwJxklA6yuHFo//ebzVjNL+6xlpmAPY95xR9SYdFdEf2cFf
 +h7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OQaJ8Ej92KgTjhWnxvDtgroL28VLjFje2NfjUBo5zas=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=fF6hF1qkRwVKb8NSll6Zk45t9dz3IrxDQ5+GIYVtZxpvd1qR3U3qmjguXsmgdWbC+m
 IwVr5e68oW63UIoXnPSgbSri5iaUg3IAgIc3KPc0ksET09RoevxaaWEi70nlU+/AR54L
 qwa0RGZvja/5TTx64T+Ss+i6Xv2Vewk+Z9CPchqzgNG7Q1EPLkW4foWaMCJvYZBOs7hS
 sDB+rEYWHWDdatRc0vw1WwbDX57VsHxPIO3UuKhWDmvj0XrIRuoj3w4bdDBtVLzaaSYL
 lRyWscuMf4+1FcDzp8kyjG31juLGnIob+K2VG5E4QGLWeBgdM8pbWwMDtymYek0MSkCw
 jImg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777607498; x=1778212298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQaJ8Ej92KgTjhWnxvDtgroL28VLjFje2NfjUBo5zas=;
 b=Z84r5qV5sU20knJpQcm1uV2FjA9Wn60DQTuaOgTZG25/bOmZTVNVM1akT+mXFgX+vd
 QQUmbz3IqNp/4ooBPtcE2IUpefrHQMeKVaRe7v8djWsDzBZt817vhTyKZ89VZVIzADPF
 Ians4aMM7ucsXtN5oqBmPXKf3XmeXRi+1jb+s0trOrdUYkTJHnbUONeiNpWd3EA5HCNe
 Qynja7AfRSy3Ynpkim/ViXVCRt5PTTzD5XcEA+Z3QvobDKraKDBNA+MimdkOthiNa/O1
 C/NWdkvCJ5RspfSeboe1Z+nt7dBwwHg8AB0R75tKPDyk2RyZGnwSEPXFOeK0xufnbRLe
 LZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777607498; x=1778212298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OQaJ8Ej92KgTjhWnxvDtgroL28VLjFje2NfjUBo5zas=;
 b=ougR2o3Q8cuZK2A9AcySZdTgpokdkAe85gMv1JUkLqihUyuDjQ3GhvFTdlQGFEu7yd
 SxliwxrqeYs9HW+tjx6faTwR8X3qMhqwOJgx4eAvFfmZ+nACAkW251NLeoxcwSqI5Q5W
 H2T6lBR2rYt5U+DRtSRwMDVThW6Jt1d0/HaSaYarzu5pYoeII2lRpiREqhcz2gDTAg7S
 PfyoLrOZ/eV2UlORSC4Wi+kUJNgUmNTY+aykp4dxg3lGwME3OqQbmKiomJ3KaoA4/d2j
 vKLOfAOH3TBVagzW4IWQX0+DRRpGhyLw0KPSBIOV6AtjDdy2B3ZCRxCq7n2cUj8sjAyn
 ssqw==
X-Gm-Message-State: AOJu0Yxxvcheb0IgmOFq4LhQ0aYTiFb6pfGrZ4JgDUn0fYl0a2fMWYjM
 AibPnlqC72hEw7lH94GFKOGdPC8CKiev7trwfwAJhDZ5kPbOwBg97bHEHZVDbDHrhQTGOShEdv/
 Z8xjBOUYJIIizyvo10fumhdXwEf8XzXY=
X-Gm-Gg: AeBDietam6nRJ2dO/ccayfWQZHBuH3Xi4SrheX7SPmunhN4Y7sGE2ml4cS5LFbFvnkb
 LDzG3CwXXOcubFiT5fp06AS5s+U3mLicgqsar6SdJbG05D0jm5AL/ujQ298ri3tkvbhgl6HKr67
 5aR+KymuAHkIC9EzEZ3+irPqPDoWNTi6cfXo+lyOUuWF4e7YZ+C3HMdUCzERwwVZg+PHr00grVM
 0Bw9zA4cZImKp8LB90Bv08nHfe3Qdw5I7CGxaWMu73hnL+VV3NxQAwjnXDDVHrup13asWe8Vfoe
 PRR1osx84O9w5ho6gWBfmpUheLbaPDslDQJ08F3Pg7KKDetvWiJ4YgUDZSk=
X-Received: by 2002:a17:907:724d:b0:bab:14bc:165c with SMTP id
 a640c23a62f3a-bbb6b593044mr325502766b.29.1777607498074; Thu, 30 Apr 2026
 20:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-3-frank.chang@sifive.com>
In-Reply-To: <20260424102800.24022-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:51:11 +1000
X-Gm-Features: AVHnY4Ky2LVHxzhsraokBKrAjjyVDsPc0RoYjQtY8d-z-PHCnHy8_09-cSDvHXA
Message-ID: <CAKmqyKOpoKO9N2GZeisyRA1ZajXZAt+-MomxLr+LkMJioM+ytQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
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

On Fri, Apr 24, 2026 at 8:29=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> When the Zicclsm extension is not enabled, raise misaligned load/store
> exceptions for misaligned accesses from scalar load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index 2c82ae41a77..2662fc5c2a2 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |=3D MO_ALIGN;
> +    }
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          out =3D gen_load_i128(ctx, a, memop);
> @@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, M=
emOp memop)
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |=3D MO_ALIGN;
> +    }
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          return gen_store_i128(ctx, a, memop);
> --
> 2.43.0
>
>

