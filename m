Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99467D72379
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFS5-00079i-G8; Fri, 23 Jan 2026 06:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFRj-00077A-K1; Fri, 23 Jan 2026 06:35:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFRg-0005MO-Dr; Fri, 23 Jan 2026 06:35:23 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyG6q3qN6zHnGkY;
 Fri, 23 Jan 2026 19:34:27 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C09940086;
 Fri, 23 Jan 2026 19:35:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 11:35:04 +0000
Date: Fri, 23 Jan 2026 11:35:02 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <clg@redhat.com>,
 <alex@shazbot.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 16/37] hw/pci/pci: Introduce a callback to retrieve
 the MSI doorbell GPA directly
Message-ID: <20260123113502.000037fc@huawei.com>
In-Reply-To: <20260121175248.87649-17-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <20260121175248.87649-17-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Wed, 21 Jan 2026 17:52:21 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> For certain vIOMMU implementations, such as SMMUv3 in accelerated mode,
> the translation tables are programmed directly into the physical SMMUv3
> in a nested configuration. While QEMU knows where the guest tables live,
> safely walking them in software would require trapping and ordering all
> guest invalidations on every command queue. Without this, QEMU could race
> with guest updates and walk stale or freed page tables.
> 
> This constraint is fundamental to the design of HW-accelerated vSMMU when
> used with downstream vfio-pci endpoint devices, where QEMU must never walk
> guest translation tables and must rely on the physical SMMU for
> translation. Future accelerated vSMMU features, such as virtual CMDQ, will
> also prevent trapping invalidations, reinforcing this restriction.
> 
> For vfio-pci endpoints behind such a vSMMU, the only translation QEMU
> needs is for the MSI doorbell used when setting up KVM MSI route tables.
> Instead of attempting a software walk, introduce an optional vIOMMU
> callback that returns the MSI doorbell GPA directly.
> 
> kvm_arch_fixup_msi_route() uses this callback when available and ignores
> the guest provided IOVA in that case.
> 
> If the vIOMMU does not implement the callback, we fall back to the
> existing IOMMU based address space translation path.
> 
> This ensures correct MSI routing for accelerated SMMUv3 + VFIO passthrough
> while avoiding unsafe software walks of guest translation tables.
> 
> As a related change, replace RCU_READ_LOCK_GUARD() with explicit
> rcu_read_lock()/rcu_read_unlock(). The introduction of an early goto
> (set_doorbell) path means the RCU read side critical section can no longer
> be safely scoped using RCU_READ_LOCK_GUARD().
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

