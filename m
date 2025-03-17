Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06940C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDRb-0007mT-6k; Mon, 17 Mar 2025 12:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuDRU-0007jS-LV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:35:56 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuDRP-0008TC-9C
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:35:55 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd01781b56so61641826d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229350; x=1742834150; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cY+qA78oyPoMdz2uAuvT4sXxARrMoawnf9oc9gMj7cs=;
 b=b2McD1DercyisNG2xT/x5TUYj7CbhGZV4q5U4zcjIvtFY5L5Y26AEIRennP07CXUyD
 F2R0zMYchGT4B/TgnTkrU224lAIYHcnDPJdyft+iNT8tapPjg1Z3dvqwmw7yTsgHWhcH
 Qmy7uNYL09kENRkDCyxnWh4rw4YcTGqHKMBC/dcV1USB2/RyJknKJXSNAgQETSJJxyx4
 Hhc2q+Iz14qnNJ57fDmJIUdQK5PS8QyS/Lb6pNtrk3qxLKQjjU7iv/ue6XS0ibArrPH0
 ynM6N5Ii3S17mcMwmcUURLRHAnwezhakUaZTlSOMblqW05c+TPk8EASH4fD6tGHRPBLx
 fZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229350; x=1742834150;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cY+qA78oyPoMdz2uAuvT4sXxARrMoawnf9oc9gMj7cs=;
 b=FiLTU6yYVwR5N5ru27p9pKei0AalYJjpobR0t7xG/kJTZrDZ/h/VU+X4IHHIuUGeuX
 qP/vzxulp4AQMijWSal4nC77NH2hBNaFaeZx/ZOgfEkFBJoe5ZsMxVxVvGAeul4v3cNc
 fMzEEDpcrTw/wkGs4O53fmlmjvSzeMgQnBnnduMAq1Hg3imtPaRgjCqUNIlrVdgxWQrA
 K2a4BcLgDsuMNgj2T+nOBPR6W5GsRiYL0u/mvgH4uXHWAvHIk4IJOBoylC8nVWxecmo8
 WBeoFuDrkQSy5KFlmYcEcboLedaFvzwuFeY2aJ9U5jtXyyrzmUHlBVGP1eqFzL52WObJ
 C0Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW80sf5dS/Dts/ndaekbWoj9yyL8JHBOs0WCrhN9dcHtY3ONUgqW4Ivn6obeumc75ks+Ao1A6w1psmc@nongnu.org
X-Gm-Message-State: AOJu0YzuKThNhMwj5UC/Ee8uEyvERZPqgmVlbe1VVWSz1dfUf8gy1Tun
 xoXxBzVZv6UcqeMewf5H/FysTx5JSlIT06/ojVnE6dSNb566lUpr
X-Gm-Gg: ASbGnctvC6Cl+LNFsCr3kztQgxMX/Dm+sx6sp21ypAeAYpJQsqNq/KCXUqs5vAyPpom
 bAR7N/gmiGWVO+ipIo6lwpkCbvJNB0/gEJqI6WJWWMBMncMfR/TEGrPDMIk0OEKw+IjdgCkV7sv
 GSfrFdW2mYCXkeR1hP/aeiT11BPwdR6aCia4nhBdjXBgonXdyJIgJPN4TRL8+i86be3snCav68j
 eQShweB2Byqb3Nbqhhxef/TuGc3kRbFerRy/PIRFZuSCDbyZpSbfPxJwE86sjPLHL7tYq4GSFdC
 J+fFqqgv09y1Lqb/kZxlOq1r3BM9OpDWoAERT5hUwDeCsRnXGIlbAT5yLShtDIM=
X-Google-Smtp-Source: AGHT+IGXMaMK6jQgLZYB2sob7NAQ8Jj3eDNxrulg7jVZdn+U33dmpKB3EIUAT+4gx68/aG2vvaxOaw==
X-Received: by 2002:a05:6214:5084:b0:6e4:42c2:dd91 with SMTP id
 6a1803df08f44-6eaeaabadbcmr248872586d6.37.1742229349690; 
 Mon, 17 Mar 2025 09:35:49 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade330ff4sm56612066d6.78.2025.03.17.09.35.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:35:49 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-5-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 04/39] target/hexagon: Implement start/stop helpers
Date: Mon, 17 Mar 2025 11:35:48 -0500
Message-ID: <016801db975a$a42bdb30$ec839190$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQHyuq6zsvJ1SYA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-2, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 04/39] target/hexagon: Implement start/stop helpers
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |  3 ++
>  target/hexagon/cpu_bits.h   |  1 +
>  target/hexagon/cpu_helper.h |  3 ++
>  target/hexagon/cpu.c        | 14 +++++-
>  target/hexagon/cpu_helper.c | 94
> +++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  |  4 +-
>  6 files changed, 116 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> 894219fd20..1549c4f1f0 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -41,6 +41,7 @@ typedef struct CPUHexagonTLBContext
> CPUHexagonTLBContext;  #define REG_WRITES_MAX 32
>  #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>  #define VSTORES_MAX 2
> +#define VECTOR_UNIT_MAX 8

Not related to start/stop and not used in this patch.

>=20
>  #ifndef CONFIG_USER_ONLY
>  #define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
> @@ -178,6 +179,7 @@ struct ArchCPU {
>  #ifndef CONFIG_USER_ONLY
>      uint32_t num_tlbs;
>      uint32_t l2vic_base_addr;
> +    uint32_t hvx_contexts;

Not related to start/stop.

>  #endif
>  };
>=20
> @@ -194,6 +196,7 @@ G_NORETURN void
> hexagon_raise_exception_err(CPUHexagonState *env,  uint32_t
> hexagon_greg_read(CPUHexagonState *env, uint32_t reg);  uint32_t
> hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);  void
> hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t
> val);
> +void hexagon_cpu_soft_reset(CPUHexagonState *env);
>  #endif
>=20
>  #include "exec/cpu-all.h"
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h =
index
> b559a7ba88..610094a759 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -52,6 +52,7 @@ enum hex_event {
>=20
>  enum hex_cause {
>      HEX_CAUSE_NONE =3D -1,
> +    HEX_CAUSE_RESET =3D 0x000,
>      HEX_CAUSE_TRAP0 =3D 0x172,
>      HEX_CAUSE_FETCH_NO_UPAGE =3D  0x012,
>      HEX_CAUSE_INVALID_PACKET =3D  0x015,
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index 6f0c6697ad..95a0cc0788 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -17,6 +17,9 @@ void
> hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
> void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t
> old);  int get_exe_mode(CPUHexagonState *env);  void
> clear_wait_mode(CPUHexagonState *env);
> +void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause); =
void
> +hexagon_start_threads(CPUHexagonState *env, uint32_t mask); void
> +hexagon_stop_thread(CPUHexagonState *env);
>=20
>  static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t =
reg,
>                                         uint32_t val) diff --git =
a/target/hexagon/cpu.c
> b/target/hexagon/cpu.c index cb56b929cf..84a96a194b 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -32,6 +32,7 @@
>=20
>  #ifndef CONFIG_USER_ONLY
>  #include "sys_macros.h"
> +#include "qemu/main-loop.h"
>  #endif
>=20
>  static void hexagon_v66_cpu_init(Object *obj) { } @@ -61,6 +62,7 @@ =
static
> const Property hexagon_cpu_properties[] =3D {
>      DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs,
> MAX_TLB_ENTRIES),
>      DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, =
l2vic_base_addr,
>          0xffffffffULL),
> +    DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),

Not related to start/stop.

>  #endif
>      DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),


