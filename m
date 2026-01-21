Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC92C44502
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viUi9-00047b-7O; Wed, 21 Jan 2026 04:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viUi1-00043Q-Rx; Wed, 21 Jan 2026 04:41:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viUhy-0001yN-Gn; Wed, 21 Jan 2026 04:41:05 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwzh43BvzzJ46cn;
 Wed, 21 Jan 2026 17:40:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5448F40563;
 Wed, 21 Jan 2026 17:40:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 09:40:45 +0000
Date: Wed, 21 Jan 2026 09:40:44 +0000
To: Cornelia Huck <cohuck@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH RFC 1/3] arm: handle demuxed ID registers
Message-ID: <20260121094044.000019a8@huawei.com>
In-Reply-To: <20260119172732.140613-2-cohuck@redhat.com>
References: <20260119172732.140613-1-cohuck@redhat.com>
 <20260119172732.140613-2-cohuck@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 19 Jan 2026 18:27:30 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> For some registers, we do not have a single ID register, but actually
> an array of values (e.g. CCSIDR_EL1, where the actual value is
> determined by whatever CSSELR_EL1 points to.) If we want to avoid
> using a different way to handle registers like that for every
> instance, we should provide some kind of infrastructure. Therefore,
> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
> we already use for regular ID registers.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-sysregs.h |  5 +++++
>  target/arm/cpu.h         | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index 7877a3b06a8e..31f82c6a0afc 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -35,6 +35,11 @@ typedef enum ARMSysRegs {
>  
>  #undef DEF
>  
> +/* ID registers that vary based upon another register */
> +typedef enum ARMIDRegisterDemuxIdx {
> +    NUM_ID_DEMUX_IDX,
> +} ARMIDRegisterDemuxIdx;
> +
>  extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>  
>  int get_sysreg_idx(ARMSysRegs sysreg);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 08b7d3fb936a..f7bd19f26fbd 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -905,6 +905,25 @@ typedef struct {
>          i_->idregs[REG ## _EL1_IDX];                                    \
>      })
>  
> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX] = VALUE;         \
> +    })
> +
> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX];                 \
> +    })
> +
> +#define COPY_IDREG_DEMUX(ISAR, REG, FROM_INDEX, TO_INDEX)               \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][TO_INDEX] =             \
> +            i_->idregs_demux[REG ## _EL1_DEMUX_IDX][FROM_INDEX];        \
> +    })
> +
>  /**
>   * ARMCPU:
>   * @env: #CPUARMState
> @@ -1083,6 +1102,7 @@ struct ArchCPU {
>          uint32_t dbgdevid1;
>          uint64_t reset_pmcr_el0;
>          uint64_t idregs[NUM_ID_IDX];
> +        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][16];
Hi,

Trivial, but I'd like a comment on why 16. I assume because that's
the biggest you've seen so far (8 levels, 2 types for CCSIDR)
Just good to have a bread crumb here for future readers.

Otherwise seems reasonable to me.
>      } isar;
>      uint64_t midr;
>      uint32_t revidr;


