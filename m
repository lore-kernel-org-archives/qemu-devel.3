Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01158C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslKA-0005A3-RS; Thu, 13 Mar 2025 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tslK5-00059W-On
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:22:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tslK3-00030B-8c
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:22:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso8163105e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741882932; x=1742487732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2oNL4C4uuFAQyDeD7/JbSVLyj+tCUKJYreKFnp05qk=;
 b=ibGCqF3xvTorqdU62Cw222wsYAJda6AyeNJ2kYfOq/L/m3qtcvqICUkTwrv9wuMhXI
 gOkCopsBq5otko7GDUA2S1YBNrKvoDM3Qu0/WQJ7z+I8IwnQMp5OpMbNNfJrm0Vm8L4M
 FeDn7uPBil4CQocdWmZ8+Be4MMIRXVTCVRXakVwmNrDWDuQ78hmbgYQCczZmbxAi3vMd
 Fydh/9JmPlYE933yZlzadLTuTYS048hTa1AyDvq8+pc3K/OspU4tsMcnayndyMm+/xa4
 q6FelFth6ngEZiZRaUAimve7OfYRwCdtXbLB+Kvp06SvCYNpRSozEsSqOGhVVZYEIgSY
 LbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882932; x=1742487732;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2oNL4C4uuFAQyDeD7/JbSVLyj+tCUKJYreKFnp05qk=;
 b=BIX9p0evJYrhtuzdKHYXsYXXyy+egHO0ZXMd5NKQlNPA13mAur6RY/x5pxAb77bqBq
 B87/xpDtaOy6fokG7FeJoXxTryDNA7H8w9HOPsISfFrpMAaXxVK8L7+1Ji0+ZVrabugh
 WOIqickm2nLn8IPp54HqngeDe80utHGyC7D14Xh8t6RxiHnvdzc3MP7cJqiEXlsBxQbA
 Vw5VZhMQ6fZX2ePoWpNybvbnPeoBUCHhtBIVOCtSmhtiabkPs/uQUyiHNLka86HZOASJ
 G+EigF1m5BkOwQECHpo0C+qSxRI4cZs6Aqmevr5NhXTCknyksUeGnZcoP4YtHz9gi2aY
 UXCA==
X-Gm-Message-State: AOJu0Ywa41UId3kD7W+x5g14pdP6P5+Fibu3snTfqNdGr3n5iqdBAvQP
 9Jb0fdb0xm3S+V03GUNUfyJYGcNMjyQQ8AmobuBakCr8B1W09IF+6vCecQC7DPeL9SE2ZMpnQKk
 8
X-Gm-Gg: ASbGnctWqnRofy0wm5NgSqgjQaCLl+iPsepf6ez7TLvvNE9vEnVPN5sfX4LZ+KVYAuR
 qzgyIf5TnwxcLQEG3lfJ6HjLzWjc0HKVlbAZNfg1v/0MhzeiZdXookRuHcaucWgeWmkP9V5z2+W
 VrSRY171985sYfsa7UFxkJOcKEFX3tDUd5q0x+6HIbidGg1x2JPaopJFUT8vvRs9uGguMEIYrlT
 gLKnC53wUlY9VlkrSIdV/nCNYJNay7lCCXXmwsP4/AKad5ubj111/c1apv+vqgL+6fr9wCLy1mr
 J/wWLsuKTC0iqICkoprGnMSxfI1iroh77racmOGqUQBi4es=
X-Google-Smtp-Source: AGHT+IGS0Zh3AQrAD9eN0z9NEX0BKNJuqDljfCbKMbAJZrgb3Tin2vMjTlda8++tZNrtZ952Q83Bfw==
X-Received: by 2002:a05:600c:1d01:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-43d1d88f21amr2702895e9.6.1741882931777; 
 Thu, 13 Mar 2025 09:22:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a8bsm2649416f8f.66.2025.03.13.09.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:22:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 499115F8C7;
 Thu, 13 Mar 2025 16:22:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 06/37] include/exec: Inline *_data_ra memory operations
In-Reply-To: <20250313034524.3069690-7-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 12 Mar 2025 20:44:46 -0700")
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-7-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 16:22:10 +0000
Message-ID: <87msdo52a5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> These expand inline to the *_mmuidx_ra api with
> a lookup of the target's cpu_mmu_index().
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This is where my re-based bisect broke. Fixed by moving cpu.h

modified   target/ppc/tcg-excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "cpu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -27,7 +28,6 @@
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "internal.h"
-#include "cpu.h"
 #include "trace.h"




> ---
>  include/exec/cpu_ldst.h     | 144 +++++++++++++++++++++++++++++-------
>  accel/tcg/ldst_common.c.inc | 108 ---------------------------
>  2 files changed, 118 insertions(+), 134 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index b33755169e..963c538176 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -84,17 +84,6 @@ int cpu_ldsw_le_data(CPUArchState *env, abi_ptr ptr);
>  uint32_t cpu_ldl_le_data(CPUArchState *env, abi_ptr ptr);
>  uint64_t cpu_ldq_le_data(CPUArchState *env, abi_ptr ptr);
>=20=20
> -uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t r=
a);
> -int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra=
);
> -uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra=
);
> -uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t r=
a);
> -int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra);
> -uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra=
);
> -uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t ra=
);
> -
>  void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>  void cpu_stw_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>  void cpu_stl_be_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> @@ -103,21 +92,6 @@ void cpu_stw_le_data(CPUArchState *env, abi_ptr ptr, =
uint32_t val);
>  void cpu_stl_le_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
>  void cpu_stq_le_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
>=20=20
> -void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
> -                     uint32_t val, uintptr_t ra);
> -void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint64_t val, uintptr_t ra);
> -void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint32_t val, uintptr_t ra);
> -void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr ptr,
> -                        uint64_t val, uintptr_t ra);
> -
>  static inline uint32_t
>  cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr=
_t ra)
>  {
> @@ -249,6 +223,124 @@ cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr add=
r, uint64_t val,
>      cpu_stq_mmu(env, addr, val, oi, ra);
>  }
>=20=20
> +/*--------------------------*/
> +
> +static inline uint32_t
> +cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint32_t
> +cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline int
> +cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
> +}
> +
> +static inline uint32_t
> +cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline uint64_t
> +cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stb_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintptr_t=
 ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr, uint32_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
> +static inline void
> +cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr, uint64_t val, uintpt=
r_t ra)
> +{
> +    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> +    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> +}
> +
>  #if TARGET_BIG_ENDIAN
>  # define cpu_lduw_data        cpu_lduw_be_data
>  # define cpu_ldsw_data        cpu_ldsw_be_data
> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
> index 99a56df3fb..2f203290db 100644
> --- a/accel/tcg/ldst_common.c.inc
> +++ b/accel/tcg/ldst_common.c.inc
> @@ -248,114 +248,6 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, In=
t128 val,
>   * Wrappers of the above
>   */
>=20=20
> -uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldub_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int8_t)cpu_ldub_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_lduw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t =
ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_lduw_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsw_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int16_t)cpu_lduw_be_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_ldl_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t r=
a)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldl_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint64_t cpu_ldq_be_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t r=
a)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldq_be_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint32_t cpu_lduw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t =
ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_lduw_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -int cpu_ldsw_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t ra)
> -{
> -    return (int16_t)cpu_lduw_le_data_ra(env, addr, ra);
> -}
> -
> -uint32_t cpu_ldl_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t r=
a)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldl_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -uint64_t cpu_ldq_le_data_ra(CPUArchState *env, abi_ptr addr, uintptr_t r=
a)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    return cpu_ldq_le_mmuidx_ra(env, addr, mmu_index, ra);
> -}
> -
> -void cpu_stb_data_ra(CPUArchState *env, abi_ptr addr,
> -                     uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stb_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stw_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stw_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stl_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stl_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stq_be_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint64_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stq_be_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stw_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stw_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stl_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint32_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stl_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -void cpu_stq_le_data_ra(CPUArchState *env, abi_ptr addr,
> -                        uint64_t val, uintptr_t ra)
> -{
> -    int mmu_index =3D cpu_mmu_index(env_cpu(env), false);
> -    cpu_stq_le_mmuidx_ra(env, addr, val, mmu_index, ra);
> -}
> -
> -/*--------------------------*/
> -
>  uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr addr)
>  {
>      return cpu_ldub_data_ra(env, addr, 0);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

