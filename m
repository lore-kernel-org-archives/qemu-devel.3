Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11914CEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7H4-00027O-KC; Tue, 08 Oct 2024 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy7H3-000272-3D; Tue, 08 Oct 2024 06:17:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sy7Gz-0005ZG-MI; Tue, 08 Oct 2024 06:16:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNBkv1GZFz6K5rX;
 Tue,  8 Oct 2024 18:16:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C4996140391;
 Tue,  8 Oct 2024 18:16:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 12:16:52 +0200
Date: Tue, 8 Oct 2024 11:16:51 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Ma?=
 =?ISO-8859-1?Q?thieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sergio Lopez <slp@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "Anthony
 PERARD" <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>,
 "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 05/12] hw/core/machine: Introduce custom CPU topology
 with max limitations
Message-ID: <20241008111651.000025ab@Huawei.com>
In-Reply-To: <20240919061128.769139-6-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20240919061128.769139-6-zhao1.liu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 19 Sep 2024 14:11:21 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Custom topology allows user to create CPU topology totally via -device
> from CLI.
> 
> Once custom topology is enabled, machine will stop the default CPU
> creation and expect user's CPU topology tree built from CLI.
> 
> With custom topology, any CPU topology, whether symmetric or hybrid
> (aka, heterogeneous), can be created naturally.
> 
> However, custom topology also needs to be restricted because
> possible_cpus[] requires some preliminary topology information for
> initialization, which is the max limitation (the new max parameters in
> -smp). Custom topology will be subject to this max limitation.
> 
> Max limitations are necessary because creating custom topology before
> initializing possible_cpus[] would compromise future hotplug scalability.
> 
> Max limitations are placed in -smp, even though custom topology can be
> defined as hybrid. From an implementation perspective, any hybrid
> topology can be considered a subset of a complete SMP structure.
> Therefore, semantically, using max limitations to constrain hybrid
> topology is consistent.
> 
> Introduce custom CPU topology related properties in MachineClass. At the
> same time, add and parse max parameters from -smp, and store the max
> limitations in CPUSlot.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

A few code style comments inline.

J
> diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
> index 1cc3b32ed675..2d16a2729501 100644
> --- a/hw/cpu/cpu-slot.c
> +++ b/hw/cpu/cpu-slot.c

> +
> +bool machine_parse_custom_topo_config(MachineState *ms,
> +                                      const SMPConfiguration *config,
> +                                      Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    CPUSlot *slot = ms->topo;
> +    bool is_valid;
> +    int maxcpus;
> +
> +    if (!slot) {
> +        return true;
> +    }
> +
> +    is_valid = config->has_maxsockets && config->maxsockets;
> +    if (mc->smp_props.custom_topo_supported) {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_SOCKET].max_limit =
> +            is_valid ? config->maxsockets : ms->smp.sockets;
> +    } else if (is_valid) {
> +        error_setg(errp, "maxsockets > 0 not supported "
> +                   "by this machine's CPU topology");
> +        return false;
> +    } else {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_SOCKET].max_limit =
> +            ms->smp.sockets;
> +    }
Having the error condition in the middle is rather confusing to
read to my eyes. Playing with equivalents I wonder what works best..


    if (!is_valid) {
        slot->stat.entries[CPU_TOPOLOGY_LEVEL_SOCKET].max_limit =
            ms->smp.sockets;
    } else if (mc->smp_props.custom_topo_supported) {
        slot->stat.entries[CPU_TOPOLOGY_LEVEL_SOCKET].max_limit =
            config->max_sockets;
    } else {
        error_setg...
        return false;
    }

or take the bad case out first.  Maybe this is a little obscure
though (assuming I even got it right) as it relies on the fact
that is_valid must be false for the legacy path.

    if (!mc->smp_props.custom_topo_supported && is_valid) {
        error_setg();
        return false;
    }

    slot->stat.entries[CPU_TOPOLOGY_LEVEL_SOCKET].max_limit =
          is_valid ? config->maxsockets : ms->smp.sockets;

Similar for other cases.

> +
> +    is_valid = config->has_maxdies && config->maxdies;
> +    if (mc->smp_props.custom_topo_supported &&
> +        mc->smp_props.dies_supported) {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_DIE].max_limit =
> +            is_valid ? config->maxdies : ms->smp.dies;
> +    } else if (is_valid) {
> +        error_setg(errp, "maxdies > 0 not supported "
> +                   "by this machine's CPU topology");
> +        return false;
> +    } else {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_DIE].max_limit =
> +            ms->smp.dies;
> +    }
> +
> +    is_valid = config->has_maxmodules && config->maxmodules;
> +    if (mc->smp_props.custom_topo_supported &&
> +        mc->smp_props.modules_supported) {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_MODULE].max_limit =
> +            is_valid ? config->maxmodules : ms->smp.modules;
> +    } else if (is_valid) {
> +        error_setg(errp, "maxmodules > 0 not supported "
> +                   "by this machine's CPU topology");
> +        return false;
> +    } else {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_MODULE].max_limit =
> +            ms->smp.modules;
> +    }
> +
> +    is_valid = config->has_maxcores && config->maxcores;
> +    if (mc->smp_props.custom_topo_supported) {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_CORE].max_limit =
> +            is_valid ? config->maxcores : ms->smp.cores;
> +    } else if (is_valid) {
> +        error_setg(errp, "maxcores > 0 not supported "
> +                   "by this machine's CPU topology");
> +        return false;
> +    } else {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_CORE].max_limit =
> +            ms->smp.cores;
> +    }
> +
> +    is_valid = config->has_maxthreads && config->maxthreads;
> +    if (mc->smp_props.custom_topo_supported) {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_THREAD].max_limit =
> +            is_valid ? config->maxthreads : ms->smp.threads;
> +    } else if (is_valid) {
> +        error_setg(errp, "maxthreads > 0 not supported "
> +                   "by this machine's CPU topology");
> +        return false;
> +    } else {
> +        slot->stat.entries[CPU_TOPOLOGY_LEVEL_THREAD].max_limit =
> +            ms->smp.threads;
> +    }
> +
> +    maxcpus = 1;
> +    /* Initizlize max_limit to 1, as members of CpuTopology. */
> +    for (int i = 0; i < CPU_TOPOLOGY_LEVEL__MAX; i++) {
> +        maxcpus *= slot->stat.entries[i].max_limit;
> +    }
> +
> +    if (!config->has_maxcpus) {
> +        ms->smp.max_cpus = maxcpus;
Maybe early return here to get rid of need for the else?

> +    } else {
> +        if (maxcpus != ms->smp.max_cpus) {

Unless this is going to get more complex later,  else if probably appropriate here
(if you don't drop the else above.

> +            error_setg(errp, "maxcpus (%d) should be equal to "
> +                       "the product of the remaining max parameters (%d)",
> +                       ms->smp.max_cpus, maxcpus);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}


