Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3778CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlu7-0003x7-0T; Sun, 17 May 2026 20:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOltu-0003w9-Pa
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:32:09 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlts-0003T9-HG
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:32:06 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so432504566b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064323; cv=none;
 d=google.com; s=arc-20240605;
 b=PSHN8zJiJKEP1HauA6KsibJPpqmNilBVIlY54krVoPjQ00VVfHOOzGDgkPmueyLuSq
 fjjzhfrqRc/Vs2koIqcTo6IdJ+lZ/5SjjmI5qzWt4Wq8uY7+FAijxs94ef98ZWNdRdJM
 okDaeZ5bravSdeAaGp5ImoyxdgXgVZgqicJVHrflaU9akHprBFQm+iGw++O4i9NZ2ral
 w/lArhVxnDK1updzvmwSYYI7R1CQTi7CgPDCvOgZD1TFpdEPr0QN/McUnAWi1afCY6E+
 CDYrkC8kyDQEXHnHFUSujlUQoEX8FWbvhzMfkrhmA1k/xubYxnJUlVG5W/qrgda//O35
 9w6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E6NamInBZqMt4Aa+QPwSrNuWAWoaeHpQ+LCtfYrUoFY=;
 fh=DfT8VKx8s3s56Yy3qVpMzac2Y9B5AgQ7VulbdecPEfw=;
 b=TEsbwTIUHNaA+dCFBypWSVu0lux67kGdJIfesKf0p7hoSeAfZkMbVTGKM28gehQgPm
 115BBtlSj2B5uKzoxmVeZ9acXTDi6FHlxCaUkwpKKQViCWF72Mzle4+IRaZfOCtz/Fum
 WC3s/i7g4/O3MAQ5tj/Tkd52PjpnalK7l52DH4Qw724G2KGhwALOk6ipJ67F3di9yJPa
 3z0qosqIuZLFUk1+aHNqtQLvxUbshvUWTiRilM6zdrntSqMiBLjkaIZO5x8dGInnrstt
 kqL/df4ow3DllVa0m9arKmMjZyQupJDXK8n8cvVQHI6TYeulQQWe3pFGlcDWrBEzMtaf
 HXnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064323; x=1779669123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6NamInBZqMt4Aa+QPwSrNuWAWoaeHpQ+LCtfYrUoFY=;
 b=l2UOPfRm5zjbJlwJyO50lEFk+G86o5X0A3xKI6Br7AFenSvJGL0mvI6yyQoUQE1uFO
 59PPo5jaCgzog8THJnzd1OzEQucfnCSox+FKtk4/YtwuTR9d8yZyCO+c3Jl2dXRPnkcJ
 EtDizkYFKyFfOHA7t2dtezsbUV5nVzY3wa/xHfekJXjS0VIMaUTFr5ftClxUL+I0QWKi
 Bu+i1gfbA9j5y/wtf5uxygtNUXIY7vZY1L5jGbMBBsbSptqqABRbYNDbYGEaMf947Us9
 S7XpSPY5yYnwenbIUGKBL4StvdGq877iUphz3xujgcxvK5PHQ3/kbi57k/ls7IrSFr2T
 x7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064323; x=1779669123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6NamInBZqMt4Aa+QPwSrNuWAWoaeHpQ+LCtfYrUoFY=;
 b=ozgApQKPPL7Zw29lSFxk8BDSksMyoywr1SX6wNSums2l3Ih1tAopQjIlnxZIcAOojE
 xJqs3tZEUP1S5Nzwmn1mbAI5Hv4sTqVgm50G3pM3zSFca5ZiP4KD9J834DS1z7Ew4W6X
 RW8TaEqsxjWX4PXZT1MDdMNXul+NGAKU7zCWtp2I+nRu9B5fMHE1xSeEjOCMsBbO0GLB
 5amR78rWj+nbELbjxy2UBGDQGOJeGDht87viwxMn1ZYBfOD9+R6QX4IZRwc7W3VrFJ6N
 p3jaU8kUPO0ZvbR34hnGDVbEIfDeEP1mGhNWm9JF4aQ0Bxa+HU1OG2u2wCraD3How5Wf
 kTLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tJKrmLBnuL6Z1P01sDGOi+UmcT4LaLNbZQrS6fTA/pBI2rTf+thdxQwwaq12DuafyRXO031C7voEy@nongnu.org
X-Gm-Message-State: AOJu0Ywsibiv6OJIEcpjP56IvceXVdQu1hswfnIhhlB7sEJ95NMEonXu
 7mnCLog8wp98/LSqDVljmMFvEYYfaGeCk2LtaXj4/IhojQibRFTu83TGgrILi6RV+//FLr4hvtB
 iIghQfi05C47aMcIjcN3vHsWOGbwQwkg=
X-Gm-Gg: Acq92OGBUduFvfp8yEGvRDXiaeZB3d1gDccgPNiM8Z/gRB5tNokXvW3eKdskw0xfSJl
 6xganHcFq8s44d0MXdrzkkuiw1PrmYJJfuPuYEbk2Otkip29976+wfVZsclMkaWF2hA+QMREPw6
 86/YLepDYMYK015AH7mezZBnSwxahSZkrMUxtrGISS2sSlt8zQW8rd/1kQlzCAT8f50800DhstB
 B/ie1yyGnZXz08vGdHMbkny5YpDXmi/45AdGMgo0CZQ1V4Z71lXHi+uMK9wQpYFCHP0DaBwnsVS
 5oiodPXd4Cei+wwbhPSFao49+hW/fNcTufE7DqI5aWIx4O2W
X-Received: by 2002:a17:907:846:b0:bd5:2bfd:b35d with SMTP id
 a640c23a62f3a-bd52bfdb3d0mr499327366b.27.1779064322733; Sun, 17 May 2026
 17:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
 <20260511102627.3120140-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511102627.3120140-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:31:36 +1000
X-Gm-Features: AVHnY4INdPxKXMcY5PKiYlVY_AIoczVOnuvT08kR_JFQOaBcWEraNsT3GxuKbDs
Message-ID: <CAKmqyKPHjT-+_W=THUQ6AbsmcsdZcyTzse4=rUCqP6x5wP8Frw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Mon, May 11, 2026 at 8:27=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> According to the RISC-V Privileged Manual: "The Sv32 page-based
> virtual-memory scheme described in sv32 supports 34-bit physical
> addresses for RV32, so the PMP scheme must support addresses wider than
> XLEN for RV32."
>
> However, the current QEMU implementation uses `target_ulong` (which
> resolves to `uint32_t` on RV32) for PMP address variables.  When
> shifting these addresses left (e.g., `this_addr << 2`), an integer
> overflow occurs, truncating the high bits of the 34-bit physical
> address.
>
> Fix this issue by changing the types of PMP address variables
> (`this_addr` and `prev_addr`) to `hwaddr`.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa=
-manual/pr-2472/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes in v2:
> - Changed the types of `this_addr` and `prev_addr` to `hwaddr` instead
>   of using inline casting, by Daniel's suggestion.
>
>  target/riscv/pmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5391caa59c7d..a71091a316e0 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hw=
addr *ea)
>  void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>  {
>      uint8_t this_cfg =3D env->pmp_state.pmp[pmp_index].cfg_reg;
> -    target_ulong this_addr =3D env->pmp_state.pmp[pmp_index].addr_reg;
> -    target_ulong prev_addr =3D 0u;
> +    hwaddr this_addr =3D env->pmp_state.pmp[pmp_index].addr_reg;
> +    hwaddr prev_addr =3D 0u;
>      hwaddr sa =3D 0u;
>      hwaddr ea =3D 0u;
>      int g =3D pmp_get_granularity_g(env);
> --
> 2.51.2
>
>

