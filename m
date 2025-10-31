Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73920CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfHl-0004ma-Kc; Thu, 30 Oct 2025 22:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfHi-0004el-KI
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:54:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfHc-0003Z7-G2
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:54:37 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so390548266b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879267; x=1762484067; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALUxoWVg5lQWwxTfxTsxyHcmQ8KKQ2nKa8zJDTCjQrA=;
 b=JnDcB3Ip8HmruvowhXdSFmH+IYSsYepYqvq8oTY2GqquAZaQ8+Xyk8EeKgHpy28MTZ
 IeZnv3hsv4WdSiXRBws/jKJXLx3tkcSrQ+GfQVBEh3AtRvCvwsypaxvoGSsmmmdF6QfI
 jHw9ngWDetl1P1/uD04vixAzhFaUca07SjsCSIC5vRf6/LrnU7cbELFexcda5cEVbg1k
 w9d+PYYiaVo+pFx8rpzUCtOoy+O8caSxa/bsNxmFeMU7KhPUG93o62lYIGIwLg3D5+TD
 MlUr0v3Ia6EfK8xuFrPYImiWtcVdM0w6TReTymyPlY6eYmaeNrPd6mMiuwxytuob4CAX
 6EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879267; x=1762484067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALUxoWVg5lQWwxTfxTsxyHcmQ8KKQ2nKa8zJDTCjQrA=;
 b=kNTvJPIS8v9lJjqeT7Qo2OKtPSk7mbgSR75ov1ri8MhZ9bFZ3AdCJWnu/KcnOfHsKn
 MSriO2dhb7f8+QOWNLqNrc/ak8KTZDxlitINf+A4/kNW2zNqznN4NwqZSJdsK6bLniO+
 CpVAhNqjZsVHvdDMOLPXYpcctY+ytyo+X67ky0tKdXRmCpH6xqVhEu7YTnS6cA0jX+zE
 40myWON4VGXSzL2Xd4eyO7UH7rV8DWuHKfSmKrc0/YOHcitTQruw+NIAbL+3hj64Plpr
 EDg7paLqxrUl/2BDtl79suPB2LuNn/BqkjQn4J+6CUrswrEcw1q0YMWOcx0Rc9PzX19q
 JPSA==
X-Gm-Message-State: AOJu0YyG6mLpyMeNA9QIYoRjHRAvztG0c7A/b/zKPpXX3ymSfVhYnz0x
 C8FUBuavXL45bzY9DLp1Qu7q5mxR84PcafQcpz1cro+NjEDenhvnQUO+73lzLKTEJNh5Iv8f+lU
 vfQmrWskTJjoSS2jtqtrS1xENuLLDVLE=
X-Gm-Gg: ASbGncsqilzqKAXBtYJAEBUc2W7Q5BiVNoaKUW+UeYsvJzW5tVCt+DFvdara2tHC6fF
 yLcNgYLQpreMcRsDx9RJ4bPh71T64KMiIVnSOGE3eZhvSFTC/c/aYRWEzUqAwtanLOUZPbEZ3FP
 TENjCevw/Rjc1DHJRyX1A6U4wmhEcpA/A94Rnvh02heLVln0nc8RENfXKmtPyx8aKJKoifqVijk
 xm5AHOP5gGe9H/QOs8gmo0h74Y12cMdkhGY3Q4gx6BMB/+nUfMR9lQsdeSX4xJdETbj1yLhEsQT
 bCUVb74qkNZVEMc=
X-Google-Smtp-Source: AGHT+IG6mqpiRCc05jURzevyRNZm0Nn9YzXCmj0QSVZTo7H0oml6GgzcP2qhsyXTE03wrdpvkEhf3EkphxuUq/UNdv4=
X-Received: by 2002:a17:907:728c:b0:b6d:2f3f:3f98 with SMTP id
 a640c23a62f3a-b70704bc291mr168184966b.41.1761879266632; Thu, 30 Oct 2025
 19:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-28-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-28-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:53:59 +1000
X-Gm-Features: AWmQ_bmKTKMfDFfQ3y33jeKDh-qcPGkQdm75Wztb2_DAx4ZtVY07YBXRkSO3N6Y
Message-ID: <CAKmqyKPKNhW5ux0OMXaURQCyYeCjf76dQAozS_1WTvFG-fddXQ@mail.gmail.com>
Subject: Re: [PATCH v4 27/33] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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

On Tue, Oct 28, 2025 at 4:24=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Widen to 64 bits in size to hold all relevant values.  Note: src and dst
> arguments change from signed to unsigned but no functional change is
> incurred.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 5 +++--
>  target/riscv/cpu_helper.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c2be30795a..ee4444f22d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -662,8 +662,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, i=
nt index, uint64_t bit);
>  void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>                          bool virt_en);
>
> -void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> -    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
> +void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
> +                         enum CTRType type, privilege_mode_t prev_priv,
> +                         bool prev_virt);
>  void riscv_ctr_clear(CPURISCVState *env);
>
>  void riscv_translate_init(void);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index b102f15ac6..20ff05a4b2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -926,8 +926,9 @@ static bool riscv_ctr_check_xte(CPURISCVState *env,
>   *    entry =3D isel - CTR_ENTRIES_FIRST;
>   *    idx =3D (sctrstatus.WRPTR - entry - 1) & (depth - 1);
>   */
> -void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_lon=
g dst,
> -    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
> +void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
> +                         enum CTRType type, privilege_mode_t src_priv,
> +                         bool src_virt)
>  {
>      bool tgt_virt =3D env->virt_enabled;
>      uint64_t src_mask =3D riscv_ctr_priv_to_mask(src_priv, src_virt);
> --
> 2.51.0
>
>

