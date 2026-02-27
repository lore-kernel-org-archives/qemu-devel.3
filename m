Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689C8FEFB6C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw0Ew-0003YH-UL; Fri, 27 Feb 2026 10:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vw0Ef-0003XI-1M; Fri, 27 Feb 2026 10:58:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vw0Ec-0003fu-MU; Fri, 27 Feb 2026 10:58:36 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMtJr0KZQzJ46CH;
 Fri, 27 Feb 2026 23:58:04 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id BDDBA40584;
 Fri, 27 Feb 2026 23:58:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 15:58:29 +0000
Date: Fri, 27 Feb 2026 15:58:28 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and
 VINTF VCMDQ register reads
Message-ID: <20260227155828.00007b6b@huawei.com>
In-Reply-To: <20260226105056.897-16-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-16-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

On Thu, 26 Feb 2026 10:50:39 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Tegra241 CMDQV exposes per-VCMDQ register windows through two MMIO views:
> 
>   -Global VCMDQ registers at 0x10000/0x20000
>   -VINTF VCMDQ (VI_VCMDQ) registers at 0x30000/0x40000
> 
> The VI_VCMDQ register ranges are an alias of the global VCMDQ registers
> and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
> IOMMU_HW_QUEUE_ALLOC.
> 
> Add read side emulation for both global VCMDQ and VI_VCMDQ register
> ranges. MMIO accesses are decoded to extract the VCMDQ instance index
> and normalized to a VCMDQ0_* register offset, allowing a single helper
> to service all VCMDQ instances.
> 
> VI_VCMDQ accesses are translated to their equivalent global VCMDQ
> offsets and reuse the same decoding path. All VCMDQ reads are currently
> served from cached register state.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Hi Shameer,

As noted below there are a lot of repeats of 0x80 and the register window offsets in here.
Maybe some defines would make things clearer?

>  static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
>  {
>      int i;
> @@ -42,6 +82,7 @@ static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
>  static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
> +    int index;
>  
>      if (offset >= TEGRA241_CMDQV_IO_LEN) {
>          qemu_log_mask(LOG_UNIMP,
> @@ -67,6 +108,42 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
>          return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
>      case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
>          return tegra241_cmdqv_read_vintf(cmdqv, offset);
> +    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
> +        /*
> +         * VI_VCMDQ registers (VINTF logical view) have the same per-VCMDQ
> +         * layout as the global VCMDQ registers, but are based at 0x30000
> +         * instead of 0x10000.
> +         *
> +         * Subtract 0x20000 to translate a VI_VCMDQ offset into the equivalent
> +         * global VCMDQ offset, then fall through to reuse the common VCMDQ
> +         * decoding logic below.
> +         */
> +        offset -= 0x20000;
There are a lot of repeated numeric values of offsets and sizes in here.
I'm a bit in two minds about whether they are clearer as numbers or you should add
a few more defines.

Jonathan





