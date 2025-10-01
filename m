Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wNv-0007td-Ln; Wed, 01 Oct 2025 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wNm-0007rC-FI; Wed, 01 Oct 2025 08:56:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wNZ-0008D8-17; Wed, 01 Oct 2025 08:56:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccFG239f1z6M4Wf;
 Wed,  1 Oct 2025 20:52:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id C7FD314014C;
 Wed,  1 Oct 2025 20:56:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 13:56:05 +0100
Date: Wed, 1 Oct 2025 13:56:04 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Message-ID: <20251001135604.00006776@huawei.com>
In-Reply-To: <20250929133643.38961-15-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:30 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
> features are compatible with the host SMMUv3.
> 
> Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
> Only the following fields can be used:
> 
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
>   - IDR1: SIDSIZE, SSIDSIZE
>   - IDR3: BBML, RIL
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
> 
> For now, the check is to make sure the features are in sync to enable
> basic accelerated SMMUv3 support.
> 
> One other related change is, move the smmuv3_init_regs() to smmu_realize()
> so that we do have that early enough for the check mentioned above.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Hi Shameer,

Back to this series...

Various things in the checks in here.

Jonathan

> ---
>  hw/arm/smmuv3-accel.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c       |  4 +-
>  2 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9ad8595ce2..defeddbd8c 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -39,6 +39,96 @@
>  #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
>                         STE1_S1CIR | STE1_S1DSS)
>  
> +static bool
> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
> +                                 struct iommu_hw_info_arm_smmuv3 *info,
> +                                 Error **errp)
> +{
> +    uint32_t val;
> +
> +    /*
> +     * QEMU SMMUv3 supports both linear and 2-level stream tables.
> +     */

Single line comment would be more consistent with below and looks to be under 80 chars.

> +    val = FIELD_EX32(info->idr[0], IDR0, STLEVEL);
> +    if (val != FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);

This seems a rather odd side effect to have.  Perhaps a comment on why
in error path it make sense to change s->idr[0]?

> +        error_setg(errp, "Host SUMMUv3 differs in Stream Table format");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports only little-endian translation table walks */
> +    val = FIELD_EX32(info->idr[0], IDR0, TTENDIAN);
> +    if (!val && val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {

This is a weird check.  || maybe?

Otherwise if !val is true, then val is not likely to be greater than anything.

> +        error_setg(errp, "Host SUMMUv3 doesn't support Little-endian "
> +                   "translation table");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports only AArch64 translation table format */
> +    val = FIELD_EX32(info->idr[0], IDR0, TTF);
> +    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
> +        error_setg(errp, "Host SUMMUv3 deosn't support Arch64 Translation "

Spell check the messages. doesn't.

> +                   "table format");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports SIDSIZE 16 */
> +    val = FIELD_EX32(info->idr[1], IDR1, SIDSIZE);
> +    if (val < FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {

Why not
    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
	FIELD_EX32(s->idr[1], IDR1, SIDSIZE))
I.e. why does the local variable make sense in cases where the value is
only used once.  To me if anything this is slightly easier to read.   You could
even align the variables so it's obvious it's comparing one field.

    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
	FIELD_EX32(s->idr[1],    IDR1, SIDSIZE))
  
> +        error_setg(errp, "Host SUMMUv3 SIDSIZE not compatible");
> +        return false;
> +    }
> +
> +    /* QEMU SMMUv3 supports Range Invalidation by default */
> +    val = FIELD_EX32(info->idr[3], IDR3, RIL);
> +    if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
> +        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");

doesn't.

> +        return false;
> +    }
> +
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
That doesn't smell like it's checking 64K
> +        return false;
> +    }
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN16K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
> +        return false;
> +    }
> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN64K);
> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
Nor is this one seem likely to be checking 16K. 
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool
> +smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> +                           Error **errp)
> +{
> +    struct iommu_hw_info_arm_smmuv3 info;
> +    uint32_t data_type;
> +    uint64_t caps;
> +
> +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> +                                         &info, sizeof(info), &caps, errp)) {
> +        return false;
> +    }
> +
> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
> +        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
> +                     data_type);

Alignment looks off.

> +        return false;
> +    }
> +
> +    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> +        return false;
> +    }
> +    return true;
> +}
> +



