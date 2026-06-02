Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEBECD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUQuT-00049x-RD; Tue, 02 Jun 2026 11:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elbeheri95@gmail.com>)
 id 1wUQtv-0003zr-CW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:19:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elbeheri95@gmail.com>)
 id 1wUQtq-0002kr-Ld
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:19:30 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf083so4257992a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 08:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780413564; cv=none;
 d=google.com; s=arc-20240605;
 b=gB2Tbv2TqgtqafSFDvVDJENGEBd0MmK+3PB1vqxzGXwu0fRQQMXeJc81ID4EFUWR7k
 7sPiTbXHCrQfA/ma1aTKB6rX3G+Q4KFfyzuANAxu02KMs7K4Ass68IHTMfq9Zdxj4AOR
 D1JmtCP0Jk0Bdwpwq121RLvze9ks1AGidmXw2ehVdhPwG4E91Bm04XPWzXsHbm/Cd4dl
 tjzQGi/8J23M+SDsqtWR6133jHEB00CMrX5/Ox4KoXspUBM7gZP3mAslLarkx5/7Uffy
 q5HTnioJvcGn0LSb13CH7U4qWdIqjDc1Vq0hU9pp5R2G5qcFsq3BAbCEIXhOtwX2u0F1
 jeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yufCkPiCNTuH2zYreZ7eB68NsfeiXbKHNGfTTy+Jv/k=;
 fh=kcNJKrmYDcBWFsQjc/jfNTVf50XvfSHEyaGn6RGzQuw=;
 b=bR8Zm7GELavKUTJj8IVLcC1Qs/elVPYFHm5Yv9CH00rM06xWGMIvO2pyoTpFyAA6/X
 1vvrYYj37LsxjQa5PMgo/ENKwJ5IeMvfXiopB2TfmFd4h/gWxvluneO9/XSlrl3/2hBY
 VQqOTWnT2g7z0qCQV+TZkJr9/z2MSyGmoTAYjVqARUVoEV9tirfvX/1xI85Nfj78ZCxU
 Jh8JFoiVXNBbRIKMBf0LdEg5ULkLavzaYxasMb3/lWCUp+IyLQL84EAWVvSnaAi1Qr7u
 s7TKPHT4IJFmSyi3aOJpa+TEEDEEsu46eR1vi3OySoMZDtXmrMRiJXgRfj3jRKLh3TTH
 1hzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780413564; x=1781018364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yufCkPiCNTuH2zYreZ7eB68NsfeiXbKHNGfTTy+Jv/k=;
 b=DG2+9/KSqvbLL6m+69wa2gxW2h4Kox8sTsSbqHOg0dumdHQEfZ11fDOgJ8AEt0/INp
 6/yjWpy8g4BB9MKlDt59jMhFwvUIffR7zYx3Oouub4Perq4C+hpBBi4dolhDaIaHMyiF
 8DsyqZOP4sO6Dx/eXayWiT5YQYPekvGspivJDkXXTInHpHJJbgYLsDbMv6mnrRcmA+cA
 FbIZQ49AE655KoXTOcIiJa3PsKGNRwfULntnuY0jUJ9ezzvalnQO4lrF928Tchfm84hg
 pC5bCOVjbbo/um29yCSqsAc73BG3y6kQDk3FZT6nQEHz6sSHMYqOtjiK7JH9cUjQ0iEL
 4OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780413564; x=1781018364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yufCkPiCNTuH2zYreZ7eB68NsfeiXbKHNGfTTy+Jv/k=;
 b=YBDZPPgYD44zZTsqrhEusLREUy+y/ddt8+lZW6ZDMcKd5YnPb+A71FTHOzqj/vTvO5
 5FsHOZsg1O143yPj/2D54w6J7EsgJt3XDRg3wJxfAIttDlVTDunf5xYg8fIk5evkY3cy
 TUZggzNAAKHZElSAvoRzwdXziegDiZc6g9q1OryTThQSfUj3aKkpqBrN4H5Qwy4neIpI
 cdjzGCwCYnsVzXx8r5bxvwoEj51Y3ap0WjqG3QM6/Ab97N6vL8QO/YA+iNJ3y/iRTSYV
 Txk/5Q7oyUzm4fO6QWdki0wuCe4ibl9Va2palT9vi5KsArIa585fqOwO2wogb3H78yNx
 PU4A==
X-Gm-Message-State: AOJu0YytyQLm53cxlJ6WH8G6+d46ASpGaVvz7/VdP5iRAcy0w2A9QcWC
 AmgoPzhxF1ZwAR1/dsGOJ8JZZWDQt0c/E0hGaLyZ7iIC5jTNWluIxc0S7famrNGOBZr+ALhLEnM
 08zfpn7CCc1ZGkcdQ5u9EQ+BLBQMW/5bIGA==
X-Gm-Gg: Acq92OHxSTH0ap3TXw7LY3GX/S6A9fBH0sg8AoWzxHH+vZHJ92WpZv3dceLjOmCx19p
 HQ0zu10R19wL+tENscXbcma2cEEHPna5L1ix2CuLfwUfguQWZBfe+neU2OotnWweVLV4580mhhZ
 uZGssJV8vK+5gIFYvp79uX5DAW0kDlWc+60712A2XFHlLdQnQI/VdG/+swwKHFVvToRoY/feUCj
 Qr2ONXGqLW4cEfBj8qScmtFuC5w95FQJFjJxkQfDGE0vp0Whh8A59+bb+ZnrHK5FRjN/Ez6lQ/K
 wBsVRVbjgIwFmX6dOp8ndJY3nu1QqJJa/gxeUnTS6iNbGUNiYgY=
X-Received: by 2002:a17:907:c006:b0:bea:5ce6:4267 with SMTP id
 a640c23a62f3a-beab71afd63mr950424866b.35.1780413563253; Tue, 02 Jun 2026
 08:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
In-Reply-To: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
From: abdelrahman elbehery <elbeheri95@gmail.com>
Date: Tue, 2 Jun 2026 18:19:11 +0300
X-Gm-Features: AVHnY4JtI9UBrwDFxUF3gFzrTRmQH-SX1GgAjzi3AlEzWJQ_k80SyAymLKQBjF4
Message-ID: <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with direct
 array index
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fdb58e065346d5be"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=elbeheri95@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000fdb58e065346d5be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Mon, 18 May 2026, 12:58=E2=80=AFpm Abdelrahman Elbehery, <elbeheri95@gma=
il.com>
wrote:

> Profiling showed g_hash_table_lookup as a hot spot when running TCG
> plugins that log all CPU registers (e.g. execlog with reg=3D*).
> Replace it with a direct array index to avoid lookup overhead.
>
> Signed-off-by: Abdelrahman Elbehery <elbeheri95@gmail.com>
> ---
> While profiling (via callgrind) a TCG plugin that logs all the CPU
> registers
> (very identical to execlog with reg=3D*) i noticed that arm_gdb_get_sysre=
g
> is a hot spot,
> mostly while calling g_hash_table_lookup. Probably this is due to some
> hashtable collision
> that is handleded by glib internally.
>
> Currently each DynamicGDBFeatureInfo item holds keys for cp_regs, and the
> keys are always
> used to retrieve the ARMCPRegInfo pointer.
>
> By replacing the keys array with a GPtrArray, we now just access reg info
> directly from
> the given index.
>
> The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB memory) GCP
>
> Setup was to run qemu-system-aarch64 against a buildroot kernel and rootf=
s
> with and without the patch mostly using:
>     --plugin contrib/plugins/libstoptrigger.so,icount=3D2000000
>     --plugin contrib/plugins/libexeclog.so,reg=3D*
>     -M virt -cpu cortex-a710 -smp 1
>
> Benchmark showed ~15% performance gain when hashtable is not used.
> For benchmarking, i used hyperfine with 3 warmup rounds and 10 iterations
> each.
> ---
>  target/arm/cpu.h     |  6 +++---
>  target/arm/gdbstub.c | 28 ++++++++++++++++------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index
> 15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f6182fdb8=
cee31c527
> 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -121,15 +121,15 @@
>   * DynamicGDBFeatureInfo:
>   * @desc: Contains the feature descriptions.
>   * @data: A union with data specific to the set of registers
> - *    @cpregs_keys: Array that contains the corresponding Key of
> - *                  a given cpreg with the same order of the cpreg
> + *    @cpregs_regs: Array that contains the corresponding Register info
> pointer
> + *                  of a given cpreg with the same order of the cpreg
>   *                  in the XML description.
>   */
>  typedef struct DynamicGDBFeatureInfo {
>      GDBFeature desc;
>      union {
>          struct {
> -            uint32_t *keys;
> +            GPtrArray *regs;
>          } cpregs;
>      } data;
>  } DynamicGDBFeatureInfo;
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index
> d6e29c4cf46745dc7851bc5f8339c8d7c6857b8c..e66af8207b436fe8f1dd27441a587b1=
eb52ff928
> 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -238,19 +238,23 @@ static int arm_gdb_get_sysreg(CPUState *cs,
> GByteArray *buf, int reg)
>      ARMCPU *cpu =3D ARM_CPU(cs);
>      CPUARMState *env =3D &cpu->env;
>      const ARMCPRegInfo *ri;
> -    uint32_t key;
>
> -    key =3D cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
> -    ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
> +    ri =3D g_ptr_array_index(cpu->dyn_sysreg_feature.data.cpregs.regs, r=
eg);
>      if (ri) {
>          switch (cpreg_field_type(ri)) {
>          case MO_64:
>              if (ri->vhe_redir_to_el2 &&
>                  (arm_hcr_el2_eff(env) & HCR_E2H) &&
>                  arm_current_el(env) =3D=3D 2) {
> -                ri =3D get_arm_cp_reginfo(cpu->cp_regs,
> ri->vhe_redir_to_el2);
> +                ri =3D g_ptr_array_index(
> +                    cpu->dyn_sysreg_feature.data.cpregs.regs,
> +                    ri->vhe_redir_to_el2
> +                );
>              } else if (ri->vhe_redir_to_el01) {
> -                ri =3D get_arm_cp_reginfo(cpu->cp_regs,
> ri->vhe_redir_to_el01);
> +                ri =3D g_ptr_array_index(
> +                    cpu->dyn_sysreg_feature.data.cpregs.regs,
> +                    ri->vhe_redir_to_el01
> +                );
>              }
>              return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri)=
);
>          case MO_32:
> @@ -269,19 +273,18 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t
> *buf, int reg)
>
>  static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,
>                                         DynamicGDBFeatureInfo *dyn_featur=
e,
> -                                       ARMCPRegInfo *ri, uint32_t ri_key=
,
> +                                       ARMCPRegInfo *ri,
>                                         int bitsize, int n)
>  {
>      gdb_feature_builder_append_reg(builder, ri->name, bitsize, n,
>                                     "int", "cp_regs");
>
> -    dyn_feature->data.cpregs.keys[n] =3D ri_key;
> +    g_ptr_array_index(dyn_feature->data.cpregs.regs, n) =3D ri;
>  }
>
>  static void arm_register_sysreg_for_feature(gpointer key, gpointer value=
,
>                                              gpointer p)
>  {
> -    uint32_t ri_key =3D (uintptr_t)key;
>      ARMCPRegInfo *ri =3D value;
>      RegisterSysregFeatureParam *param =3D p;
>      ARMCPU *cpu =3D ARM_CPU(param->cs);
> @@ -292,7 +295,7 @@ static void arm_register_sysreg_for_feature(gpointer
> key, gpointer value,
>          if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>              if (ri->state =3D=3D ARM_CP_STATE_AA64) {
>                  arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
> -                                           ri, ri_key, 64, param->n++);
> +                                           ri, 64, param->n++);
>              }
>          } else {
>              if (ri->state =3D=3D ARM_CP_STATE_AA32) {
> @@ -302,10 +305,10 @@ static void arm_register_sysreg_for_feature(gpointe=
r
> key, gpointer value,
>                  }
>                  if (ri->type & ARM_CP_64BIT) {
>                      arm_gen_one_feature_sysreg(&param->builder,
> dyn_feature,
> -                                               ri, ri_key, 64,
> param->n++);
> +                                               ri, 64, param->n++);
>                  } else {
>                      arm_gen_one_feature_sysreg(&param->builder,
> dyn_feature,
> -                                               ri, ri_key, 32,
> param->n++);
> +                                               ri, 32, param->n++);
>                  }
>              }
>          }
> @@ -323,7 +326,8 @@ static GDBFeature
> *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
>                               "org.qemu.gdb.arm.sys.regs",
>                               "system-registers.xml",
>                               base_reg);
> -    cpu->dyn_sysreg_feature.data.cpregs.keys =3D g_new(uint32_t, num_reg=
s);
> +    cpu->dyn_sysreg_feature.data.cpregs.regs =3D g_ptr_array_new();
> +    g_ptr_array_set_size(cpu->dyn_sysreg_feature.data.cpregs.regs,
> num_regs);
>      g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_feature,
> &param);
>      gdb_feature_builder_end(&param.builder);
>      return &cpu->dyn_sysreg_feature.desc;
>
> ---
> base-commit: ac6721b88df944ade0048822b2b74210f543d656
> change-id: 20260518-enhance_arm_gdb_get_sysreg_performance-4288474401d6
>
> Best regards,
> --
> Abdelrahman Elbehery <elbeheri95@gmail.com>
>
>

--000000000000fdb58e065346d5be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 18 May 2026, 12:58=E2=
=80=AFpm Abdelrahman Elbehery, &lt;<a href=3D"mailto:elbeheri95@gmail.com">=
elbeheri95@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Profiling showed g_hash_table_lookup as a hot spot when running TCG<br>
plugins that log all CPU registers (e.g. execlog with reg=3D*).<br>
Replace it with a direct array index to avoid lookup overhead.<br>
<br>
Signed-off-by: Abdelrahman Elbehery &lt;<a href=3D"mailto:elbeheri95@gmail.=
com" target=3D"_blank" rel=3D"noreferrer">elbeheri95@gmail.com</a>&gt;<br>
---<br>
While profiling (via callgrind) a TCG plugin that logs all the CPU register=
s<br>
(very identical to execlog with reg=3D*) i noticed that arm_gdb_get_sysreg =
is a hot spot,<br>
mostly while calling g_hash_table_lookup. Probably this is due to some hash=
table collision<br>
that is handleded by glib internally.<br>
<br>
Currently each DynamicGDBFeatureInfo item holds keys for cp_regs, and the k=
eys are always<br>
used to retrieve the ARMCPRegInfo pointer.<br>
<br>
By replacing the keys array with a GPtrArray, we now just access reg info d=
irectly from<br>
the given index.<br>
<br>
The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB memory) GCP<br=
>
<br>
Setup was to run qemu-system-aarch64 against a buildroot kernel and rootfs<=
br>
with and without the patch mostly using:<br>
=C2=A0 =C2=A0 --plugin contrib/plugins/libstoptrigger.so,icount=3D2000000<b=
r>
=C2=A0 =C2=A0 --plugin contrib/plugins/libexeclog.so,reg=3D*<br>
=C2=A0 =C2=A0 -M virt -cpu cortex-a710 -smp 1<br>
<br>
Benchmark showed ~15% performance gain when hashtable is not used.<br>
For benchmarking, i used hyperfine with 3 warmup rounds and 10 iterations e=
ach.<br>
---<br>
=C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0target/arm/gdbstub.c | 28 ++++++++++++++++------------<br>
=C2=A02 files changed, 19 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/target/arm/cpu.h b/target/arm/cpu.h<br>
index 15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f6182=
fdb8cee31c527 100644<br>
--- a/target/arm/cpu.h<br>
+++ b/target/arm/cpu.h<br>
@@ -121,15 +121,15 @@<br>
=C2=A0 * DynamicGDBFeatureInfo:<br>
=C2=A0 * @desc: Contains the feature descriptions.<br>
=C2=A0 * @data: A union with data specific to the set of registers<br>
- *=C2=A0 =C2=A0 @cpregs_keys: Array that contains the corresponding Key of=
<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a given c=
preg with the same order of the cpreg<br>
+ *=C2=A0 =C2=A0 @cpregs_regs: Array that contains the corresponding Regist=
er info pointer<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of a give=
n cpreg with the same order of the cpreg<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in t=
he XML description.<br>
=C2=A0 */<br>
=C2=A0typedef struct DynamicGDBFeatureInfo {<br>
=C2=A0 =C2=A0 =C2=A0GDBFeature desc;<br>
=C2=A0 =C2=A0 =C2=A0union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *keys;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPtrArray *regs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} cpregs;<br>
=C2=A0 =C2=A0 =C2=A0} data;<br>
=C2=A0} DynamicGDBFeatureInfo;<br>
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c<br>
index d6e29c4cf46745dc7851bc5f8339c8d7c6857b8c..e66af8207b436fe8f1dd27441a5=
87b1eb52ff928 100644<br>
--- a/target/arm/gdbstub.c<br>
+++ b/target/arm/gdbstub.c<br>
@@ -238,19 +238,23 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArra=
y *buf, int reg)<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);<br>
=C2=A0 =C2=A0 =C2=A0CPUARMState *env =3D &amp;cpu-&gt;env;<br>
=C2=A0 =C2=A0 =C2=A0const ARMCPRegInfo *ri;<br>
-=C2=A0 =C2=A0 uint32_t key;<br>
<br>
-=C2=A0 =C2=A0 key =3D cpu-&gt;dyn_sysreg_feature.data.cpregs.keys[reg];<br=
>
-=C2=A0 =C2=A0 ri =3D get_arm_cp_reginfo(cpu-&gt;cp_regs, key);<br>
+=C2=A0 =C2=A0 ri =3D g_ptr_array_index(cpu-&gt;dyn_sysreg_feature.data.cpr=
egs.regs, reg);<br>
=C2=A0 =C2=A0 =C2=A0if (ri) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cpreg_field_type(ri)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MO_64:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ri-&gt;vhe_redir_to_el2=
 &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(arm_hcr_el2_=
eff(env) &amp; HCR_E2H) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_current_e=
l(env) =3D=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri =3D get_arm_cp_=
reginfo(cpu-&gt;cp_regs, ri-&gt;vhe_redir_to_el2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri =3D g_ptr_array=
_index(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-=
&gt;dyn_sysreg_feature.data.cpregs.regs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri-&=
gt;vhe_redir_to_el2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (ri-&gt;vhe_redir=
_to_el01) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri =3D get_arm_cp_=
reginfo(cpu-&gt;cp_regs, ri-&gt;vhe_redir_to_el01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri =3D g_ptr_array=
_index(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-=
&gt;dyn_sysreg_feature.data.cpregs.regs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ri-&=
gt;vhe_redir_to_el01<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return gdb_get_reg64(buf, (=
uint64_t)read_raw_cp_reg(env, ri));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MO_32:<br>
@@ -269,19 +273,18 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t *=
buf, int reg)<br>
<br>
=C2=A0static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DynamicG=
DBFeatureInfo *dyn_feature,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPRegI=
nfo *ri, uint32_t ri_key,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPRegI=
nfo *ri,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int bits=
ize, int n)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0gdb_feature_builder_append_reg(builder, ri-&gt;name, bi=
tsize, n,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, &quot=
;cp_regs&quot;);<br>
<br>
-=C2=A0 =C2=A0 dyn_feature-&gt;data.cpregs.keys[n] =3D ri_key;<br>
+=C2=A0 =C2=A0 g_ptr_array_index(dyn_feature-&gt;data.cpregs.regs, n) =3D r=
i;<br>
=C2=A0}<br>
<br>
=C2=A0static void arm_register_sysreg_for_feature(gpointer key, gpointer va=
lue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0gpointer p)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint32_t ri_key =3D (uintptr_t)key;<br>
=C2=A0 =C2=A0 =C2=A0ARMCPRegInfo *ri =3D value;<br>
=C2=A0 =C2=A0 =C2=A0RegisterSysregFeatureParam *param =3D p;<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(param-&gt;cs);<br>
@@ -292,7 +295,7 @@ static void arm_register_sysreg_for_feature(gpointer ke=
y, gpointer value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (arm_feature(env, ARM_FEATURE_AARCH64)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ri-&gt;state =3D=3D ARM=
_CP_STATE_AA64) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gen_one_f=
eature_sysreg(&amp;param-&gt;builder, dyn_feature,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ri, ri_key, 64, param-&gt;n++);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ri, 64, param-&gt;n++);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ri-&gt;state =3D=3D ARM=
_CP_STATE_AA32) {<br>
@@ -302,10 +305,10 @@ static void arm_register_sysreg_for_feature(gpointer =
key, gpointer value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ri-&gt;ty=
pe &amp; ARM_CP_64BIT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0arm_gen_one_feature_sysreg(&amp;param-&gt;builder, dyn_feature,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ri, ri_key, 64, param-&gt;n++);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ri, 64, param-&gt;n++);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0arm_gen_one_feature_sysreg(&amp;param-&gt;builder, dyn_feature,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ri, ri_key, 32, param-&gt;n++);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ri, 32, param-&gt;n++);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -323,7 +326,8 @@ static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUSt=
ate *cs, int base_reg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;org.qemu.gdb.arm.sys.regs&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;system-registers.xml&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base_reg);<br>
-=C2=A0 =C2=A0 cpu-&gt;dyn_sysreg_feature.data.cpregs.keys =3D g_new(uint32=
_t, num_regs);<br>
+=C2=A0 =C2=A0 cpu-&gt;dyn_sysreg_feature.data.cpregs.regs =3D g_ptr_array_=
new();<br>
+=C2=A0 =C2=A0 g_ptr_array_set_size(cpu-&gt;dyn_sysreg_feature.data.cpregs.=
regs, num_regs);<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_foreach(cpu-&gt;cp_regs, arm_register_sysr=
eg_for_feature, &amp;param);<br>
=C2=A0 =C2=A0 =C2=A0gdb_feature_builder_end(&amp;param.builder);<br>
=C2=A0 =C2=A0 =C2=A0return &amp;cpu-&gt;dyn_sysreg_feature.desc;<br>
<br>
---<br>
base-commit: ac6721b88df944ade0048822b2b74210f543d656<br>
change-id: 20260518-enhance_arm_gdb_get_sysreg_performance-4288474401d6<br>
<br>
Best regards,<br>
-- <br>
Abdelrahman Elbehery &lt;<a href=3D"mailto:elbeheri95@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">elbeheri95@gmail.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000fdb58e065346d5be--

