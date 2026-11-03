Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA296606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHV0wnn1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3tJ-00028I-9B; Mon, 02 Nov 2026 21:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3tF-00027T-S7; Mon, 02 Nov 2026 21:04:45 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3tD-0006m9-UZ; Mon, 02 Nov 2026 21:04:45 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DD44600CB;
 Tue,  3 Nov 2026 02:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB231F000C1;
 Tue,  3 Nov 2026 02:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793671482;
 bh=zmWYsuP2etQmZ+YivbUZ/g+Odjw33nGEmzC3/cKlyYg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cHV0wnn1lqryX6ST2svjw39tmPEXy+3VI7+t2nL8nzRBBeOU5PlMCNKKXbjDiJjU4
 bVjVtcYl62+wzqFoHejtfA2NP9UT3RNeVk0N5OS3S3ljhNGgUbgJJn0YKozMnHHx+v
 MS3RKMc6r5Hq9IXRQck2UIwboEooc883JlbOEl/4uCu7+OJHcQNOrPKpOCdMv7AEx9
 yK+3t8DXix9Ui3ltM6nTVMQvn/1JWWWtELw4yaw7ao/dLzMfg2sMvpAAk+JqGDWwp0
 1hbyJYdbU+1apsp20UR1KdimVfbR1aTbf40AseFSnXMHHFilnYyrzxfnBmaWsaUOiD
 6frc7pB3y9D7A==
Date: Tue, 3 Nov 2026 02:04:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 21/37] hw/arm/virt: Create L2/L3 cache MPAM MSCs
Message-ID: <20261103020433.486c1b06@jic23-hlaptop>
In-Reply-To: <tencent_C427298A199263A6959A34FE890C44CEDB07@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_C427298A199263A6959A34FE890C44CEDB07@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:41 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Derive the L2/L3 cache MSCs from the smp cache topology: the
> sharing step comes from machine_get_cache_topo_level() so L3 MSCs
> group per socket and L2 MSCs per cluster, and each MSC's cache id
> (cpu | level << 16 | type << 24) matches the PPTT cache node the
> MPAM table will point at.
> 
> Based on an RFC series by Jonathan Cameron, adapted to the current
> cache topology API.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Trivial stuff only.

I wonder a bit how fragile the topology counting approach will be if
we get more sophisticated controls on the cache topology but for now
this seems fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/arm/virt.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 77942e7..a57ba56 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2144,6 +2144,60 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>  #define MPAM_VIRT_NUM_PARTID     256
>  #define MPAM_VIRT_NUM_INTPARTID  32
>  
> +static void create_mpam_msc_cache(VirtMachineState *vms, int level,
> +                                  hwaddr *base)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    const CPUArchIdList *cpu_list = ms->possible_cpus;
> +    DeviceState *dev;
> +    int step, i;
> +    CpuTopologyLevel topo;
> +
> +    /*
> +     * Work out how many CPUs share a cache at this level, so each MSC
> +     * covers exactly one cache, and the cache_id (derived from the
> +     * first CPU of the group) matches the PPTT cache node the MPAM
> +     * table points at.
> +     */
> +    topo = (level == 3) ?
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) :
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +
> +    if (topo == CPU_TOPOLOGY_LEVEL_SOCKET && ms->smp.sockets > 0) {
> +        step = cpu_list->len / ms->smp.sockets;
> +    } else if (topo == CPU_TOPOLOGY_LEVEL_CLUSTER && ms->smp.clusters > 0) {
> +        /*
> +         * ms->smp.clusters is per socket; possible_cpus is ordered
> +         * socket-major, so dividing by the total cluster count keeps
> +         * each group inside one cluster.
> +         */
> +        step = cpu_list->len / (ms->smp.sockets * ms->smp.clusters);
> +    } else {
> +        step = ms->smp.threads;
> +    }
> +    if (step < 1) {
> +        step = 1;
> +    }
> +
> +    for (i = 0; i < cpu_list->len; i += step) {

      for (int i = 0; ..
Perhaps bring dev into this scope as well.


> +        dev = qdev_new(TYPE_MPAM_MSC_CACHE);
> +        object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-partid",
> +                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-int-partid",
> +                                 MPAM_VIRT_NUM_INTPARTID,
> +                                 &error_fatal);

Look to rewrap these. This one fits below 80 chars and IIRC qemu is
a bit relaxed on just over 80 anyway.

> +        object_property_set_uint(OBJECT(dev), "cache-level", level,
> +                                 &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACHE,
> +                                 &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "cpu", i, &error_fatal);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
> +        *base += MPAM_SIZE;
> +    }
> +}



