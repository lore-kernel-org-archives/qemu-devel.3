Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF59C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKOw-00018T-5g; Fri, 26 Jul 2024 08:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKOu-00017U-B6; Fri, 26 Jul 2024 08:50:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKOs-0001vO-7Z; Fri, 26 Jul 2024 08:50:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVnbk1YYmz6K5mp;
 Fri, 26 Jul 2024 20:48:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 82E13140B63;
 Fri, 26 Jul 2024 20:50:18 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:50:18 +0100
Date: Fri, 26 Jul 2024 13:50:17 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 5/7] target/arm: preserve mpidr value
Message-ID: <20240726135017.00003cdb@Huawei.com>
In-Reply-To: <acdc77f8b53ed570aa7a59fdc83fb8ab5f79ca19.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <acdc77f8b53ed570aa7a59fdc83fb8ab5f79ca19.1721630625.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Jul 2024 08:45:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There is a logic at helper to properly fill the mpidr information.
> This is needed for ARM Processor error injection, so store the
> value inside a cpu opaque value, to allow it to be used.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Seems reasonable to me, but not really my area of expertise.
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
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
> index ce319572354a..2432b5b09607 100644
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


