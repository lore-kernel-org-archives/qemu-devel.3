Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D8ECD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURyx-0007bD-7z; Tue, 02 Jun 2026 12:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wURyq-0007aD-Pj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:28:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wURyo-0002p5-FO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:28:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so7479925e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780417716; x=1781022516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDPkFbZQTxPIs1ufIhGICnSIMcD2eKCe2VfC5grfm4k=;
 b=b6iGvYQICvHqZ+E5AYwWPKFtqAHDA8jlq/x4cghlQULXoSYA9GRXir6w1RX9Wu83zx
 PXiKlDFVmHK+IvIePAzUAMikbJs42j2sbB+YUBskrALkUVgeg+z3febXXHNphHyA4lcm
 UkRLh2EZzfBzvvTrtw9w+8c8hvIkIOMaCKpAhtiqI6GFwiALSmt5YT+q9RzvGUruOBzy
 E00QZVFQzEeuc5QleTPuQ4BZK3WGP1WqlmLxLFu715NZ+AIQma+nFEakQpMQ2fexA464
 Fvy3E9Ot0/OEQN1uJy/bi7u2g64sHOJTVunIKEysiP3s4bAVtE86UAdtoHlnf7T0u3Tn
 YtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780417716; x=1781022516;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDPkFbZQTxPIs1ufIhGICnSIMcD2eKCe2VfC5grfm4k=;
 b=jrWzMJbfwMWxfLmzEIbsq0k3yaIYOtOe21SXtllkMPvMyze7Y2+sbak41wB9XD/jTB
 beyzc8wfICS5Wm2rZSrQTdPLK806ovKkLzTBvRZBo5L5tDRVTt3TOOSQv0rLwPPTShdX
 0eLE2iYxnuK3y/ca/mOqzkez0Y1DfzNEt7T9pLmkYBo5MzytDSV+fJ3Ap9lNugyJqkGI
 /np5nCqEQ9pljXsJGQOlRFi2byBogAqOe3kVs7E5JHA86jqUvrUDit5pt7gs2jvk0OgH
 1DjHvwj0fpWDiJnCTCnNXRGkPpL/Ne/8IgSTwgn+AkoTM5ZlyD46/3h3L+v2EqPEjk33
 ftDQ==
X-Gm-Message-State: AOJu0YxrBeEdaCwY4dgA+TblzdadWMjb7KHdJhcbNgo67n3UJPX9+f7H
 W9NRtLX8ApJe+HpkaUrR7Qd5M4QeoKfjAbJLUlZrH6TqOf6jJ8ptcl5osTNxLGapqEw=
X-Gm-Gg: Acq92OGaeA6B5tLDLHLH+q6Qa2qBdDOfWtanoWexwR2xNdsQFHZj/i/47h2cUyzFFAQ
 M5NWolayyBjU3RmRoSRkCa8D/gzf7rZdAditbCB3eHL17x3qIg8Fd3whr8FCsweJlNCjgbbEW1t
 E4ft2jz7T3xpdV8d398ABD3JeSgNsyDDsDnUtJ6ORG8g0UNogcFtOpSVnMvS3Iva0iIZZRFdqoc
 gP0DeTTupu8WCYmqebpW8awSAVESRejeDoBSrUfFz3iOvP3Xfj0oS6xcFYCL+7/YgpTgxFkwGE7
 0sl218LwqFf+imLWg4WKz+H8LcQ1lt6rsTVDinkYEUYNioPkiPIsFU6Oi89/NR6pGqVS5CqSZiW
 iFHUpduq8NMfZ68Ggh3rhodgc25gLOsMPsZBIqDLRB4sHzR3rclArbqnSFHrwy+5F9bAGjRoVvN
 ozbCpyCp3mV0vAvQMG9MJmmUKlxrZGGMZONw==
X-Received: by 2002:a05:600c:1401:b0:490:9d1b:f06b with SMTP id
 5b1f17b1804b1-490b509d02emr5263035e9.26.1780417715622; 
 Tue, 02 Jun 2026 09:28:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e0de7bsm67249955e9.3.2026.06.02.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:28:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E10ED5F7F7;
 Tue, 02 Jun 2026 17:28:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Abdelrahman Elbehery <elbeheri95@gmail.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with
 direct array index
In-Reply-To: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
 (Abdelrahman Elbehery's message of "Mon, 18 May 2026 12:58:15 +0300")
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 02 Jun 2026 17:28:33 +0100
Message-ID: <87qzmovrda.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Abdelrahman Elbehery <elbeheri95@gmail.com> writes:

> Profiling showed g_hash_table_lookup as a hot spot when running TCG
> plugins that log all CPU registers (e.g. execlog with reg=3D*).
> Replace it with a direct array index to avoid lookup overhead.
>
> Signed-off-by: Abdelrahman Elbehery <elbeheri95@gmail.com>
> ---
> While profiling (via callgrind) a TCG plugin that logs all the CPU regist=
ers
> (very identical to execlog with reg=3D*) i noticed that arm_gdb_get_sysre=
g is a hot spot,
> mostly while calling g_hash_table_lookup. Probably this is due to some ha=
shtable collision
> that is handleded by glib internally.
>
> Currently each DynamicGDBFeatureInfo item holds keys for cp_regs, and the=
 keys are always
> used to retrieve the ARMCPRegInfo pointer.
>
> By replacing the keys array with a GPtrArray, we now just access reg info=
 directly from
> the given index.
>
> The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB memory) GCP
>
> Setup was to run qemu-system-aarch64 against a buildroot kernel and rootfs
> with and without the patch mostly using:
>     --plugin contrib/plugins/libstoptrigger.so,icount=3D2000000
>     --plugin contrib/plugins/libexeclog.so,reg=3D*
>     -M virt -cpu cortex-a710 -smp 1
>
> Benchmark showed ~15% performance gain when hashtable is not used.
> For benchmarking, i used hyperfine with 3 warmup rounds and 10 iterations=
 each.
> ---
>  target/arm/cpu.h     |  6 +++---
>  target/arm/gdbstub.c | 28 ++++++++++++++++------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f61=
82fdb8cee31c527 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -121,15 +121,15 @@
>   * DynamicGDBFeatureInfo:
>   * @desc: Contains the feature descriptions.
>   * @data: A union with data specific to the set of registers
> - *    @cpregs_keys: Array that contains the corresponding Key of
> - *                  a given cpreg with the same order of the cpreg
> + *    @cpregs_regs: Array that contains the corresponding Register info =
pointer
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
> index d6e29c4cf46745dc7851bc5f8339c8d7c6857b8c..e66af8207b436fe8f1dd27441=
a587b1eb52ff928 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -238,19 +238,23 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteAr=
ray *buf, int reg)
>      ARMCPU *cpu =3D ARM_CPU(cs);
>      CPUARMState *env =3D &cpu->env;
>      const ARMCPRegInfo *ri;
> -    uint32_t key;
>=20=20
> -    key =3D cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
> -    ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
> +    ri =3D g_ptr_array_index(cpu->dyn_sysreg_feature.data.cpregs.regs,
> reg);

I was only re-using key because we still use get_arm_cp_reginfo but I
have no objection to making the access faster for plugins given the
system registers don't change after CPU reset.


Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      if (ri) {
>          switch (cpreg_field_type(ri)) {
>          case MO_64:
>              if (ri->vhe_redir_to_el2 &&
>                  (arm_hcr_el2_eff(env) & HCR_E2H) &&
>                  arm_current_el(env) =3D=3D 2) {
> -                ri =3D get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to=
_el2);
> +                ri =3D g_ptr_array_index(
> +                    cpu->dyn_sysreg_feature.data.cpregs.regs,
> +                    ri->vhe_redir_to_el2
> +                );
>              } else if (ri->vhe_redir_to_el01) {
> -                ri =3D get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to=
_el01);
> +                ri =3D g_ptr_array_index(
> +                    cpu->dyn_sysreg_feature.data.cpregs.regs,
> +                    ri->vhe_redir_to_el01
> +                );
>              }
>              return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri)=
);
>          case MO_32:
> @@ -269,19 +273,18 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t=
 *buf, int reg)
>=20=20
>  static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,
>                                         DynamicGDBFeatureInfo *dyn_featur=
e,
> -                                       ARMCPRegInfo *ri, uint32_t ri_key,
> +                                       ARMCPRegInfo *ri,
>                                         int bitsize, int n)
>  {
>      gdb_feature_builder_append_reg(builder, ri->name, bitsize, n,
>                                     "int", "cp_regs");
>=20=20
> -    dyn_feature->data.cpregs.keys[n] =3D ri_key;
> +    g_ptr_array_index(dyn_feature->data.cpregs.regs, n) =3D ri;
>  }
>=20=20
>  static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
>                                              gpointer p)
>  {
> -    uint32_t ri_key =3D (uintptr_t)key;
>      ARMCPRegInfo *ri =3D value;
>      RegisterSysregFeatureParam *param =3D p;
>      ARMCPU *cpu =3D ARM_CPU(param->cs);
> @@ -292,7 +295,7 @@ static void arm_register_sysreg_for_feature(gpointer =
key, gpointer value,
>          if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>              if (ri->state =3D=3D ARM_CP_STATE_AA64) {
>                  arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
> -                                           ri, ri_key, 64, param->n++);
> +                                           ri, 64, param->n++);
>              }
>          } else {
>              if (ri->state =3D=3D ARM_CP_STATE_AA32) {
> @@ -302,10 +305,10 @@ static void arm_register_sysreg_for_feature(gpointe=
r key, gpointer value,
>                  }
>                  if (ri->type & ARM_CP_64BIT) {
>                      arm_gen_one_feature_sysreg(&param->builder, dyn_feat=
ure,
> -                                               ri, ri_key, 64, param->n+=
+);
> +                                               ri, 64, param->n++);
>                  } else {
>                      arm_gen_one_feature_sysreg(&param->builder, dyn_feat=
ure,
> -                                               ri, ri_key, 32, param->n+=
+);
> +                                               ri, 32, param->n++);
>                  }
>              }
>          }
> @@ -323,7 +326,8 @@ static GDBFeature *arm_gen_dynamic_sysreg_feature(CPU=
State *cs, int base_reg)
>                               "org.qemu.gdb.arm.sys.regs",
>                               "system-registers.xml",
>                               base_reg);
> -    cpu->dyn_sysreg_feature.data.cpregs.keys =3D g_new(uint32_t, num_reg=
s);
> +    cpu->dyn_sysreg_feature.data.cpregs.regs =3D g_ptr_array_new();
> +    g_ptr_array_set_size(cpu->dyn_sysreg_feature.data.cpregs.regs, num_r=
egs);
>      g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_feature, =
&param);
>      gdb_feature_builder_end(&param.builder);
>      return &cpu->dyn_sysreg_feature.desc;
>
> ---
> base-commit: ac6721b88df944ade0048822b2b74210f543d656
> change-id: 20260518-enhance_arm_gdb_get_sysreg_performance-4288474401d6
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

