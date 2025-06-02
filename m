Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA8C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 00:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLtQS-0004iv-Gl; Sun, 01 Jun 2025 20:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLtQO-0004ia-P8; Sun, 01 Jun 2025 20:53:14 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLtQN-0006Xq-49; Sun, 01 Jun 2025 20:53:12 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-87e7c306fc4so74503241.3; 
 Sun, 01 Jun 2025 17:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748825588; x=1749430388; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYxoPMFfjUfg2+1WRtysPEm2brYz5pL6l/raJmrXCkM=;
 b=Ox+w+HpZCbBLmuVjSoofnXck14PW7XPl2cL77qgtTGqy13vMh62lbStr8uwLtoMeKe
 BdVNmORqFvkapMBHpgiecXioCnFWURCF16ReRBsEvbyYLJK6s0hIHgWEr1QsOyi5ewkk
 0nXhlRUkp6JR5/vd3SGFmGoRtxPasDCkDCZrHXllfI3NqG7JafMPG8THLb+abDN6niig
 IKQ5xy5rAunDFDLCb6MwKpvhne5vm3OHhE4n9EO23Jucw3qrx2Y86EnhGDUzKQ5YSzN7
 XRafas/lFRUZBO8h6o1XiNNaOp4iwBJ/icatEYa9rQmzjctHF5xfsH6rX+Lo1TBa3qqn
 ronQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748825588; x=1749430388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYxoPMFfjUfg2+1WRtysPEm2brYz5pL6l/raJmrXCkM=;
 b=Unr72T6shR46BUXbOlM1tnkXt9LuWyQoIQ0a9XRLEpCpOBlnU0S4y3ZSKsUmjOEkDk
 ZJwc3isnajkB8EchTy3bzSKNhkV6SZ42Fh91tz0jRPCF4cmexOPhtSIomAnhwUON02Mk
 m2BG/vBv2THzKhIGuJak2OUHlDs9ZPGwDABOtLuo0FwZW6XTPR+SNLUwkRl832UxnG+T
 qWMb7hdTDdj5mS0ySV/7VG0hXPJ3sbrjpXk23MOK5vTuzVIBEgJ3H5XWFqWQjRQfpYUF
 lrFrxaamMlLohTAAPqmvIjCpkIXGM7BRuTbf1Qntl0YujU09Q2yj9cdLcgdX0khh+EZW
 Qydw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXIgTt+KidKIAhpVNiI9gPpnhYmR+rw5n4nNhiGRcjC2uoqIw1XtM39GuXjV6BmP6TBKwJKYNXuMho@nongnu.org
X-Gm-Message-State: AOJu0YzkvzlekC/wJRXr2kGg7oMBKNr+zG5qe92I6nGcHnBGuxvvGJBk
 67FpJwtB+/I+H8368uiF7sLqgr/UH34GSj5+lhjnzsIwhS4ClLRJlZW4eiXn9VWFblS2UV17Xgk
 YmCsos2BumwVKMNzE8YEO+QZvPdj8Pcc=
X-Gm-Gg: ASbGncsKhyyYIAW2Md3Pe69WuyAUbsnewtCOtyrAXwlNWx1X7MoHP4E5p+uRfAN5Klk
 vj4qfkbOzOH2JWTAG7fuW1bgjFkI3AwLEgOTtLIzh9JwqQ/8tOZaH47y4RnxS0663DPcQ9adumB
 dizzQQpLu1b7rt3/9ZCNTAc/ZlzxnqYMjkwPMzQ7Fh7qNaGgD2PdUG2fwZ+RrsyWM2UF8s+zStG
 w==
X-Google-Smtp-Source: AGHT+IF+nVW2r3Dx2rWkkF/xyp8uvPUPSHHt93s56Fd3owD/h8qJtx8rfkvFv4Qsyc8ui9fGySz9fEXoUE/SQATON2o=
X-Received: by 2002:a05:6102:32ce:b0:4e6:a33d:9925 with SMTP id
 ada2fe7eead31-4e6ecd2e650mr6887147137.5.1748825587911; Sun, 01 Jun 2025
 17:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 10:52:41 +1000
X-Gm-Features: AX0GCFtJa_ok2ESI6S6nPlIXNCZZY1-fCqrgFpaEY__tJ8t_XZ0P_CSdV1w2Tb0
Message-ID: <CAKmqyKOepjGz2DsB-K7o4Zbu7VtSKbOcr9BwUajaudPERKjHFg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: remove capital 'Z' CPU properties
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Fri, May 30, 2025 at 11:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> These properties were deprecated in QEMU 8.2, commit 8043effd9b.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 17 -----------------
>  target/riscv/cpu.h         |  1 -
>  target/riscv/tcg/tcg-cpu.c | 31 +------------------------------
>  3 files changed, 1 insertion(+), 48 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fe21e0fb44..7c6e0844d0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1387,23 +1387,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_featu=
res[] =3D {
>      { },
>  };
>
> -/* Deprecated entries marked for future removal */
> -const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] =3D {
> -    MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
> -    MULTI_EXT_CFG_BOOL("Zicsr", ext_zicsr, true),
> -    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> -    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> -    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> -    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> -    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> -    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> -
> -    { },
> -};
> -
>  static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
>                               Error **errp)
>  {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2a6793e022..17bf4e7579 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -951,7 +951,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_extensi=
ons[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
> -extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
>
>  typedef struct isa_ext_data {
>      const char *name;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 66929f2e8d..8ebffe55bc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1416,25 +1416,6 @@ static void riscv_cpu_add_profiles(Object *cpu_obj=
)
>      }
>  }
>
> -static bool cpu_ext_is_deprecated(const char *ext_name)
> -{
> -    return isupper(ext_name[0]);
> -}
> -
> -/*
> - * String will be allocated in the heap. Caller is responsible
> - * for freeing it.
> - */
> -static char *cpu_ext_to_lower(const char *ext_name)
> -{
> -    char *ret =3D g_malloc0(strlen(ext_name) + 1);
> -
> -    strcpy(ret, ext_name);
> -    ret[0] =3D tolower(ret[0]);
> -
> -    return ret;
> -}
> -
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
>  {
> @@ -1447,13 +1428,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Vis=
itor *v, const char *name,
>          return;
>      }
>
> -    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
> -        g_autofree char *lower =3D cpu_ext_to_lower(multi_ext_cfg->name)=
;
> -
> -        warn_report("CPU property '%s' is deprecated. Please use '%s' in=
stead",
> -                    multi_ext_cfg->name, lower);
> -    }
> -
>      cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
>
>      prev_val =3D isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
> @@ -1489,14 +1463,13 @@ static void cpu_add_multi_ext_prop(Object *cpu_ob=
j,
>                                     const RISCVCPUMultiExtConfig *multi_c=
fg)
>  {
>      bool generic_cpu =3D riscv_cpu_is_generic(cpu_obj);
> -    bool deprecated_ext =3D cpu_ext_is_deprecated(multi_cfg->name);
>
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
>                          NULL, (void *)multi_cfg);
>
> -    if (!generic_cpu || deprecated_ext) {
> +    if (!generic_cpu) {
>          return;
>      }
>
> @@ -1539,8 +1512,6 @@ static void riscv_cpu_add_user_properties(Object *o=
bj)
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
>
> -    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
> -
>      riscv_cpu_add_profiles(obj);
>  }
>
> --
> 2.49.0
>
>

