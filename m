Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6A7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 12:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTks-0003Oc-MV; Mon, 12 Aug 2024 08:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTkq-0003Kh-T4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTki-0001rq-E0
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723464139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+65iu01NPIv7uWIeGGoac4SWkRO5zqtd9iaInoLAGw=;
 b=e37clh4jh9vVkAXUgbI4vvkBa14ivqF+tvBkxls2JSzKk6/3Gys/bI+xE6bIxyjyJobWYD
 B4hhJraiCmSLyciQ2GnTT4YvBXfxg2BNbuCMihUyMPCCPiS1MX8krs+6KBoJH5voManmmB
 6im32hVU942pPmPzkwB9LF9z2NWjlYE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-pbf17qSMO4KIDatyhO88OQ-1; Mon, 12 Aug 2024 08:02:17 -0400
X-MC-Unique: pbf17qSMO4KIDatyhO88OQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4281ca9f4dbso35277035e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 05:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723464136; x=1724068936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+65iu01NPIv7uWIeGGoac4SWkRO5zqtd9iaInoLAGw=;
 b=kfiHcf1c9Sm06Z1F9OqfYzDs1DTvAE/ArJ2Lgzq8QHkhp3CzrRDI8+NxIz+9a7zJsY
 6MphoNFmt/Hh8c/XSvTG7N7vxedTj9DZPlohBk+AhC/VGN/IFP3bvB7dUs1qKJEXwF+H
 mqfY/fo56mgqJ9vdGRy2ALi1cPB8Sh1vHsfSelkORNr3NFqFWX7h4NYI+IoUejcyVrWZ
 bZVJ+r0TmU6/9dsj0OjcsVF3fHRv8dnUrCj9wMnMJt+yxCLsDrhkDN7oaD5oJmnhseBB
 SX8P+TZ0tWv3kd0nSBpHpY4EszVnRGAC40QUV+Pq9o20NR7nPXsAnpPmCLjYKp0A/1RL
 Fl5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp/XEOhtgWECnHSumh+ITfwTtKFd8AB+4Ni4iT0TJRIb8ltKNyByLDaXRSHuY0XHD8wHMX6cUcvLnz@nongnu.org
X-Gm-Message-State: AOJu0Yx5JEZ1MHU/BaxsXiwMkUgfaBcFsnXT8MOlHvkcUMoTxZGn3fhO
 WmvDhq4Rbsq10Z7uebHgJEsuy6lUAzQNizjn1Vcav9LzhPq5zwpYglYeVgSVvaRudPSZxhmNtOl
 3xKe2sQyfOQ+CK4IKgNsEYKBmD361SoD/5CT+eb/8q1LZwY9DxtrU
X-Received: by 2002:a05:600c:354b:b0:426:6eb9:db07 with SMTP id
 5b1f17b1804b1-429d4806c91mr1293475e9.13.1723464136503; 
 Mon, 12 Aug 2024 05:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPKds0KQDqWQo7B86uduTnRYkpzEfbrS1jfTZcY8d0bGzXJK/SZcSeNZ7Myq5znt6/xAnuTA==
X-Received: by 2002:a05:600c:354b:b0:426:6eb9:db07 with SMTP id
 5b1f17b1804b1-429d4806c91mr1293155e9.13.1723464135879; 
 Mon, 12 Aug 2024 05:02:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750e57fsm99660975e9.12.2024.08.12.05.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 05:02:15 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:02:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Peter Maydell <peter.maydell@linaro.org>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 09/10] target/arm: add an experimental mpidr arm cpu
 property object
Message-ID: <20240812140214.408158b9@imammedo.users.ipa.redhat.com>
In-Reply-To: <a60316927a84748517209a741bf904a802827b8e.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <a60316927a84748517209a741bf904a802827b8e.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu,  8 Aug 2024 14:26:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Accurately injecting an ARM Processor error ACPI/APEI GHES
> error record requires the value of the ARM Multiprocessor
> Affinity Register (mpidr).
> 
> While ARM implements it, this is currently not visible.
> 
> Add a field at CPU storing it, and place it at arm_cpu_properties
> as experimental, thus allowing it to be queried via QMP using
> qom-get function.

looks fine to me, but it's upto ARM folk to ack this

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  target/arm/cpu.c    |  1 +
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 10 ++++++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c239181..30fcf0a10f46 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2619,6 +2619,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>  
>  static Property arm_cpu_properties[] = {
>      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a12859fc5335..d2e86f0877cc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1033,6 +1033,7 @@ struct ArchCPU {
>          uint64_t reset_pmcr_el0;
>      } isar;
>      uint64_t midr;
> +    uint64_t mpidr;
>      uint32_t revidr;
>      uint32_t reset_fpsid;
>      uint64_t ctr;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8fb4b474e83f..16e75b7c5ed9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4692,7 +4692,7 @@ static uint64_t mpidr_read_val(CPUARMState *env)
>      return mpidr;
>  }
>  
> -static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +static uint64_t mpidr_read(CPUARMState *env)
>  {
>      unsigned int cur_el = arm_current_el(env);
>  
> @@ -4702,6 +4702,11 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      return mpidr_read_val(env);
>  }
>  
> +static uint64_t mpidr_read_ri(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return mpidr_read(env);
> +}
> +
>  static const ARMCPRegInfo lpae_cp_reginfo[] = {
>      /* NOP AMAIR0/1 */
>      { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
> @@ -9723,7 +9728,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "MPIDR_EL1", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 5,
>                .fgt = FGT_MPIDR_EL1,
> -              .access = PL1_R, .readfn = mpidr_read, .type = ARM_CP_NO_RAW },
> +              .access = PL1_R, .readfn = mpidr_read_ri, .type = ARM_CP_NO_RAW },
>          };
>  #ifdef CONFIG_USER_ONLY
>          static const ARMCPRegUserSpaceInfo mpidr_user_cp_reginfo[] = {
> @@ -9733,6 +9738,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>          modify_arm_cp_regs(mpidr_cp_reginfo, mpidr_user_cp_reginfo);
>  #endif
>          define_arm_cp_regs(cpu, mpidr_cp_reginfo);
> +        cpu->mpidr = mpidr_read(env);
>      }
>  
>      if (arm_feature(env, ARM_FEATURE_AUXCR)) {


