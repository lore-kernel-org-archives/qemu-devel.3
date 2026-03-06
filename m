Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FCAF0182E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTiX-0003JW-GE; Fri, 06 Mar 2026 06:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyTiV-0003J2-Iy; Fri, 06 Mar 2026 06:51:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyTiR-00036S-MV; Fri, 06 Mar 2026 06:51:39 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS4VN5dznzJ468s;
 Fri,  6 Mar 2026 19:50:52 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id B786140584;
 Fri,  6 Mar 2026 19:51:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 11:51:30 +0000
Date: Fri, 6 Mar 2026 11:51:28 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 04/65] hw/intc/arm_gicv5: Implement skeleton code for
 IRS register frames
Message-ID: <20260306115128.0000463d@huawei.com>
In-Reply-To: <20260223170212.441276-5-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-5-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On Mon, 23 Feb 2026 17:01:11 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The GICv5 IRS has one mandatory register frame (the config frame) for
> each of up to four supported physical interrupt domains.  Implement
> the skeleton of the code needed to create these as sysbus MMIO
> regions.
> 
> The config frame has a mix of 32-bit and 64-bit registers, and it is
> valid to access the 64-bit registers with 32-bit accesses.  In a
> similar way to the various GICv3 devices, we turn the MemoryRegionOps
> read_with_attrs and write_with_attrs calls into calls on functions
> specifically to read 32 or 64 bit values.  (We can't trivially
> implement one in terms of the other because various registers have
> side effects on write which must only trigger when the "correct" half
> of the 64-bit register is written to.)
> 
> Unlike the GICv3, we choose to expose a sysbus MMIO region for each
> interrupt domain even if the config of the GICv5 means that it
> doesn't implement that domain.  This avoids having the config frame
> for a domain ending up at a different MMIO region index depending on
> the config of the GICv5.  (This matters more for GICv5 because it
> supports Realm, and so there are more possible valid configurations.)
> 
> gicv5_common_init_irqs_and_mmio() does not yet create any IRQs, but
> we name it this way to parallel the equivalent GICv3 function and to
> avoid having to rename it when we add the IRQ line creation in a
> subsequent commit.
> 
> The arm_gicv5_types.h header is a little undermotivated at this
> point, but the aim is to have somewhere to put definitions that we
> want in both the GIC proper and the CPU interface.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Really trivial stuff inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> +DEFINE_READ_WRITE_WRAPPERS(ns, GICV5_ID_NS)
> +DEFINE_READ_WRITE_WRAPPERS(realm, GICV5_ID_REALM)
> +DEFINE_READ_WRITE_WRAPPERS(secure, GICV5_ID_S)
> +DEFINE_READ_WRITE_WRAPPERS(el3, GICV5_ID_EL3)
> +
> +static const MemoryRegionOps config_frame_ops[NUM_GICV5_DOMAINS] = {
> +    [GICV5_ID_S] = {

Maybe it's worth a macro for filing in the MemoryRegionOps as well
if we don't expect them to diverge beyond the config_xx_read/write.

> +        .read_with_attrs = config_secure_read,
> +        .write_with_attrs = config_secure_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid.min_access_size = 4,
> +        .valid.max_access_size = 8,
> +        .impl.min_access_size = 4,
> +        .impl.max_access_size = 8,
> +    },
> +    [GICV5_ID_NS] = {
> +        .read_with_attrs = config_ns_read,
> +        .write_with_attrs = config_ns_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid.min_access_size = 4,
> +        .valid.max_access_size = 8,
> +        .impl.min_access_size = 4,
> +        .impl.max_access_size = 8,
> +    },
> +    [GICV5_ID_EL3] = {
> +        .read_with_attrs = config_el3_read,
> +        .write_with_attrs = config_el3_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid.min_access_size = 4,
> +        .valid.max_access_size = 8,
> +        .impl.min_access_size = 4,
> +        .impl.max_access_size = 8,
> +    },
> +    [GICV5_ID_REALM] = {
> +        .read_with_attrs = config_realm_read,
> +        .write_with_attrs = config_realm_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid.min_access_size = 4,
> +        .valid.max_access_size = 8,
> +        .impl.min_access_size = 4,
> +        .impl.max_access_size = 8,
> +    },
> +};

> diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
> new file mode 100644
> index 0000000000..143dcdec28
> --- /dev/null
> +++ b/include/hw/intc/arm_gicv5_types.h

> +/*
> + * The GICv5 has four physical Interrupt Domains. This numbering
> + * must match the encoding used in IRS_IDR0.INT_DOM.

Wrap seems a bit short but meh, maybe it's more readable like this.

> + */
> +typedef enum GICv5Domain {
> +    GICV5_ID_S = 0,
> +    GICV5_ID_NS = 1,
> +    GICV5_ID_EL3 = 2,
> +    GICV5_ID_REALM = 3,
> +} GICv5Domain;
> +
> +#define NUM_GICV5_DOMAINS 4
> +
> +#endif


