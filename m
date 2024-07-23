Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E272C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7Au-0006rh-HW; Tue, 23 Jul 2024 00:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7Ar-0006oy-U6; Tue, 23 Jul 2024 00:30:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sW7Ao-0003EN-Op; Tue, 23 Jul 2024 00:30:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d1fb6c108so1219270b3a.3; 
 Mon, 22 Jul 2024 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721709046; x=1722313846; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hixnnyt27NZOhXKWyY1NGsYhXS/o3nkcp7aEeomOxGo=;
 b=WD2jSJ5KwhNbQyEaaZ4kiQabkt9up2xYyKXMbXKDShWovZ7QcaI7SfKN60yAB1K9PP
 pthtpCtMI6AeUAap+qebdnmLuM6MCgrdulFxERYfHGxMMKAvEAsv2CsRSdSSHq8pG0Yj
 21LxfTMiPC1lQTdMupF1qhC/1FpXInkjX/vTCwp+ZCo5HfbDxbad0mUsr8UtZa8kYV+7
 dmwZH+T68SMZNylA8LUFV1ZZuJZIp13eylBWT3w9GQuX9sac0/qxki/DpjH9HwvpoKjE
 sVWwOw8N0JXllP2pqK0ZCuNJd0zDbDKFf0IFntPIbYHIYuqEguyCQZzuZlzeBcRobpcA
 8JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721709046; x=1722313846;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hixnnyt27NZOhXKWyY1NGsYhXS/o3nkcp7aEeomOxGo=;
 b=ok63rZjfPtwdkm6y2qBaxpgAsFIa8OkfC24W4neKLanhQXOwS+yFRcAm0x+8NKy1zR
 q88CBUAxcGI+X12aNAI0eybRXs5e6MiajxbWoa+23rUkgIRQkuZVbVyPCM30zFzNJIwb
 xaq7CkEoOwOKoSRrznan5aN1crZypfAV7x9zU+HMw4A2GGfrfFsAUL+AWirfZi9RUeY+
 RvDbCYcZE1W6z9eSfQ8wXGM6XJh2cC1EvFXghAy4TVQvPbvpD9QUsk/vQNNVk1wx8A9a
 ZHxH3F16DnHF5k0Fj2plQ4GtPx1l4SbsUjZjnhvZbT+9h3BNRRzb4WTV63VyqL/N4dQ8
 14XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhs/6BRqwoRNzNN9EhaaCMrlYJDHGuv0Q3f7NKaJzV18B7D+CfYShN0WcRQvsNoZwag3xS8YA2AYtTXOeFZS0VRM5Q
X-Gm-Message-State: AOJu0YyjzAa9lOY9kZRp/HnZqdjl0OyMS9yF/HDGvUiVsh/FIOuwF9VU
 j2BT4D9gdED92de54uY4R+9J/ara9wOaQmO1aU3ME6g6Vj872eU6
X-Google-Smtp-Source: AGHT+IFeYE7xIocUE6Hs91KRdvyVGI1wLyBMq7CVUk2Vp8NZX85rYNBwgekDDQWPQ+RSsk3YZWxvOA==
X-Received: by 2002:a05:6a00:3ccf:b0:70d:3587:c665 with SMTP id
 d2e1a72fcca58-70d3587c806mr3759089b3a.2.1721709045536; 
 Mon, 22 Jul 2024 21:30:45 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d27485721sm2691689b3a.8.2024.07.22.21.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 21:30:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jul 2024 14:30:38 +1000
Message-Id: <D2WMX1EEJ7PM.11W1PP8D9HCUN@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v5 2/5] target/ppc: Add Power11 DD2.0 processor
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
X-Mailer: aerc 0.18.0
References: <20240606121657.254308-1-adityag@linux.ibm.com>
 <20240606121657.254308-3-adityag@linux.ibm.com>
In-Reply-To: <20240606121657.254308-3-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Thu Jun 6, 2024 at 10:16 PM AEST, Aditya Gupta wrote:
> Add CPU target code to add support for new Power11 Processor.
>
> Power11 core is same as Power10, hence reuse functions defined for
> Power10.
>
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  target/ppc/compat.c     |  7 ++++++
>  target/ppc/cpu-models.c |  3 +++
>  target/ppc/cpu-models.h |  3 +++
>  target/ppc/cpu_init.c   | 54 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index ebef2cccecf3..12dd8ae290ca 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -100,6 +100,13 @@ static const CompatInfo compat_table[] =3D {
>          .pcr_level =3D PCR_COMPAT_3_10,
>          .max_vthreads =3D 8,
>      },
> +    { /* POWER11, ISA3.10 */
> +        .name =3D "power11",
> +        .pvr =3D CPU_POWERPC_LOGICAL_3_10_PLUS,

Might call that _P11 rather than _PLUS, but I can fold that in my tree.

> +        .pcr =3D PCR_COMPAT_3_10,
> +        .pcr_level =3D PCR_COMPAT_3_10,
> +        .max_vthreads =3D 8,
> +    },
>  };
> =20
>  static const CompatInfo *compat_by_pvr(uint32_t pvr)
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index f2301b43f78b..ece348178188 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -734,6 +734,8 @@
>                  "POWER9 v2.2")
>      POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POW=
ER10,
>                  "POWER10 v2.0")
> +    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POW=
ER11,
> +                "POWER11_v2.0")
>  #endif /* defined (TARGET_PPC64) */
> =20
>  /***********************************************************************=
****/
> @@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "power8nvl", "power8nvl_v1.0" },
>      { "power9", "power9_v2.2" },
>      { "power10", "power10_v2.0" },
> +    { "power11", "power11_v2.0" },
>  #endif
> =20
>      /* Generic PowerPCs */
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 0229ef3a9a5c..ef74e387b047 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -354,6 +354,8 @@ enum {
>      CPU_POWERPC_POWER10_BASE       =3D 0x00800000,
>      CPU_POWERPC_POWER10_DD1        =3D 0x00801100,
>      CPU_POWERPC_POWER10_DD20       =3D 0x00801200,
> +    CPU_POWERPC_POWER11_BASE       =3D 0x00820000,
> +    CPU_POWERPC_POWER11_DD20       =3D 0x00821200,
>      CPU_POWERPC_970_v22            =3D 0x00390202,
>      CPU_POWERPC_970FX_v10          =3D 0x00391100,
>      CPU_POWERPC_970FX_v20          =3D 0x003C0200,
> @@ -391,6 +393,7 @@ enum {
>      CPU_POWERPC_LOGICAL_2_07       =3D 0x0F000004,
>      CPU_POWERPC_LOGICAL_3_00       =3D 0x0F000005,
>      CPU_POWERPC_LOGICAL_3_10       =3D 0x0F000006,
> +    CPU_POWERPC_LOGICAL_3_10_PLUS  =3D 0x0F000007,
>  };
> =20
>  /* System version register (used on MPC 8xxx)                           =
     */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3d8a112935ae..9aa098935d05 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6669,6 +6669,60 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *dat=
a)
>      pcc->l1_icache_size =3D 0x8000;
>  }
> =20
> +static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bo=
ol best)
> +{
> +    uint32_t base =3D pvr & CPU_POWERPC_POWER_SERVER_MASK;
> +    uint32_t pcc_base =3D pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
> +
> +    if (!best && (base =3D=3D CPU_POWERPC_POWER11_BASE)) {
> +        return true;
> +    }
> +
> +    if (base !=3D pcc_base) {
> +        return false;
> +    }
> +
> +    if ((pvr & 0x0f00) =3D=3D (pcc->pvr & 0x0f00)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> +
> +    dc->fw_name =3D "PowerPC,POWER11";
> +    dc->desc =3D "POWER11";
> +    pcc->pvr_match =3D ppc_pvr_match_power11;
> +    pcc->pcr_mask =3D POWERPC_POWER10_PCC_PCR_MASK;
> +    pcc->pcr_supported =3D POWERPC_POWER10_PCC_PCR_SUPPORTED;
> +    pcc->init_proc =3D init_proc_POWER10;
> +    pcc->check_pow =3D check_pow_nocheck;
> +    pcc->check_attn =3D check_attn_hid0_power9;
> +    pcc->insns_flags =3D POWERPC_FAMILY_POWER9_INSNS_FLAGS; /* same as P=
9 */
> +    pcc->insns_flags2 =3D POWERPC_FAMILY_POWER10_INSNS_FLAGS2;
> +    pcc->msr_mask =3D POWERPC_POWER10_PCC_MSR_MASK;
> +    pcc->lpcr_mask =3D POWERPC_POWER10_PCC_LPCR_MASK;

BTW., I still think all these new macros should be named after the exact
CPU, e.g., all these should be called POWER11 and the differences or
sameness should be handled in cpu_init.h.

I might tweak that and the names a bit locally (e.g., why is one type of
define called POWERPC_FAMILY_x and another called POWERPC_x_PCC), but
that's not a big deal and mostly an exercise in bike shed painting. The
functionality of the patch looks okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
> +    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
> +    pcc->mmu_model =3D POWERPC_MMU_3_00;
> +#if !defined(CONFIG_USER_ONLY)
> +    /* segment page size remain the same */
> +    pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
> +    pcc->radix_page_info =3D &POWER10_radix_page_info;
> +    pcc->lrg_decr_bits =3D 56;
> +#endif
> +    pcc->excp_model =3D POWERPC_EXCP_POWER10;
> +    pcc->bus_model =3D PPC_FLAGS_INPUT_POWER9;
> +    pcc->bfd_mach =3D bfd_mach_ppc64;
> +    pcc->flags =3D POWERPC_POWER10_PCC_FLAGS;
> +    pcc->l1_dcache_size =3D 0x8000;
> +    pcc->l1_icache_size =3D 0x8000;
> +}
> +
>  #if !defined(CONFIG_USER_ONLY)
>  void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  {


