Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7509C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjcnm-0007Yo-UK; Mon, 11 Mar 2024 06:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1rjcnj-0007YT-Pi
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:22:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1rjcng-0000Rn-QK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710152552; x=1741688552;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JjN91EHR9CxEvRvZ+oBPMzA30BEBgNyoheCGlVqJbf4=;
 b=gJ+2Uvs1KpTuqUlne1MbJZRUDduEYPz8JLn/5sax4U4NWNlD5qbJrRBx
 Dute0qM2FzV1hfTS5q+dHhw5D6WLZer8Z3A4Vbenw1MB6warNdwKnUu+J
 bq3ibywmT31SnaCGS7VL7fbxm6I5IXPuXTi8p0F4AMv985JTGrLXYTE86
 5illXt6faHjGiwv1rjC0UaOThJC31feWELKzivUekN9eUorQQZ7bikox4
 Bf5JDJhn2pQN/pktCITA1rXi18qH1VDTjl5WECJtK39vKZZ6Sq4ClmM0p
 Jdr+UVniCn7w8oZPNDU0kHR7Hmvi1jBixRBdotUp4b4wCFM+C7BcPj+KT g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="16208092"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="16208092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 03:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="11560017"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.239.60])
 ([10.124.239.60])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 03:22:22 -0700
Message-ID: <e730da3c-42be-45d0-aa11-279ee47bb933@linux.intel.com>
Date: Mon, 11 Mar 2024 18:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/21] hw/core/machine: Support modules in -smp
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-3-zhao1.liu@linux.intel.com>
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240227103231.1556302-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


On 2/27/2024 6:32 PM, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>
> Add "modules" parameter parsing support in -smp.
>
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v8:
>   * Add module description in qemu_smp_opts.
>
> Changes since v7:
>   * New commit to introduce module level in -smp.
> ---
>   hw/core/machine-smp.c | 39 +++++++++++++++++++++++++++++----------
>   hw/core/machine.c     |  1 +
>   qapi/machine.json     |  3 +++
>   system/vl.c           |  3 +++
>   4 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index a0a30da59aa4..8a8296b0d05b 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -51,6 +51,10 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
>           g_string_append_printf(s, " * clusters (%u)", ms->smp.clusters);
>       }
>   
> +    if (mc->smp_props.modules_supported) {
> +        g_string_append_printf(s, " * modules (%u)", ms->smp.clusters);
> +    }

smp.clusters -> smp.modules?


> +
>       g_string_append_printf(s, " * cores (%u)", ms->smp.cores);
>       g_string_append_printf(s, " * threads (%u)", ms->smp.threads);
>   
> @@ -88,6 +92,7 @@ void machine_parse_smp_config(MachineState *ms,
>       unsigned sockets = config->has_sockets ? config->sockets : 0;
>       unsigned dies    = config->has_dies ? config->dies : 0;
>       unsigned clusters = config->has_clusters ? config->clusters : 0;
> +    unsigned modules = config->has_modules ? config->modules : 0;
>       unsigned cores   = config->has_cores ? config->cores : 0;
>       unsigned threads = config->has_threads ? config->threads : 0;
>       unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
> @@ -102,6 +107,7 @@ void machine_parse_smp_config(MachineState *ms,
>           (config->has_sockets && config->sockets == 0) ||
>           (config->has_dies && config->dies == 0) ||
>           (config->has_clusters && config->clusters == 0) ||
> +        (config->has_modules && config->modules == 0) ||
>           (config->has_cores && config->cores == 0) ||
>           (config->has_threads && config->threads == 0) ||
>           (config->has_maxcpus && config->maxcpus == 0)) {
> @@ -117,12 +123,12 @@ void machine_parse_smp_config(MachineState *ms,
>           error_setg(errp, "dies not supported by this machine's CPU topology");
>           return;
>       }
> +    dies = dies > 0 ? dies : 1;
> +
>       if (!mc->smp_props.clusters_supported && clusters > 1) {
>           error_setg(errp, "clusters not supported by this machine's CPU topology");
>           return;
>       }
> -
> -    dies = dies > 0 ? dies : 1;
>       clusters = clusters > 0 ? clusters : 1;
>   
>       if (!mc->smp_props.books_supported && books > 1) {
> @@ -138,6 +144,13 @@ void machine_parse_smp_config(MachineState *ms,
>       }
>       drawers = drawers > 0 ? drawers : 1;
>   
> +    if (!mc->smp_props.modules_supported && modules > 1) {
> +        error_setg(errp, "modules not supported by this "
> +                   "machine's CPU topology");
> +        return;
> +    }
> +    modules = modules > 0 ? modules : 1;
> +
>       /* compute missing values based on the provided ones */
>       if (cpus == 0 && maxcpus == 0) {
>           sockets = sockets > 0 ? sockets : 1;
> @@ -152,11 +165,13 @@ void machine_parse_smp_config(MachineState *ms,
>                   cores = cores > 0 ? cores : 1;
>                   threads = threads > 0 ? threads : 1;
>                   sockets = maxcpus /
> -                          (drawers * books * dies * clusters * cores * threads);
> +                          (drawers * books * dies * clusters *
> +                           modules * cores * threads);
>               } else if (cores == 0) {
>                   threads = threads > 0 ? threads : 1;
>                   cores = maxcpus /
> -                        (drawers * books * sockets * dies * clusters * threads);
> +                        (drawers * books * sockets * dies *
> +                         clusters * modules * threads);
>               }
>           } else {
>               /* prefer cores over sockets since 6.2 */
> @@ -164,23 +179,26 @@ void machine_parse_smp_config(MachineState *ms,
>                   sockets = sockets > 0 ? sockets : 1;
>                   threads = threads > 0 ? threads : 1;
>                   cores = maxcpus /
> -                        (drawers * books * sockets * dies * clusters * threads);
> +                        (drawers * books * sockets * dies *
> +                         clusters * modules * threads);
>               } else if (sockets == 0) {
>                   threads = threads > 0 ? threads : 1;
>                   sockets = maxcpus /
> -                          (drawers * books * dies * clusters * cores * threads);
> +                          (drawers * books * dies * clusters *
> +                           modules * cores * threads);
>               }
>           }
>   
>           /* try to calculate omitted threads at last */
>           if (threads == 0) {
>               threads = maxcpus /
> -                      (drawers * books * sockets * dies * clusters * cores);
> +                      (drawers * books * sockets * dies *
> +                       clusters * modules * cores);
>           }
>       }
>   
>       maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
> -                                      clusters * cores * threads;
> +                                      clusters * modules * cores * threads;
>       cpus = cpus > 0 ? cpus : maxcpus;
>   
>       ms->smp.cpus = cpus;
> @@ -189,6 +207,7 @@ void machine_parse_smp_config(MachineState *ms,
>       ms->smp.sockets = sockets;
>       ms->smp.dies = dies;
>       ms->smp.clusters = clusters;
> +    ms->smp.modules = modules;
>       ms->smp.cores = cores;
>       ms->smp.threads = threads;
>       ms->smp.max_cpus = maxcpus;
> @@ -196,8 +215,8 @@ void machine_parse_smp_config(MachineState *ms,
>       mc->smp_props.has_clusters = config->has_clusters;
>   
>       /* sanity-check of the computed topology */
> -    if (drawers * books * sockets * dies * clusters * cores * threads !=
> -        maxcpus) {
> +    if (drawers * books * sockets * dies * clusters * modules * cores *
> +        threads != maxcpus) {
>           g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
>           error_setg(errp, "Invalid CPU topology: "
>                      "product of the hierarchy must match maxcpus: "
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 36fe3a4806f2..030b7e250ac5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -872,6 +872,7 @@ static void machine_get_smp(Object *obj, Visitor *v, const char *name,
>           .has_sockets = true, .sockets = ms->smp.sockets,
>           .has_dies = true, .dies = ms->smp.dies,
>           .has_clusters = true, .clusters = ms->smp.clusters,
> +        .has_modules = true, .modules = ms->smp.modules,
>           .has_cores = true, .cores = ms->smp.cores,
>           .has_threads = true, .threads = ms->smp.threads,
>           .has_maxcpus = true, .maxcpus = ms->smp.max_cpus,
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 93b46772869e..5233a8947556 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1640,6 +1640,8 @@
>   #
>   # @clusters: number of clusters per parent container (since 7.0)
>   #
> +# @modules: number of modules per parent container (since 9.0)
> +#
>   # @cores: number of cores per parent container
>   #
>   # @threads: number of threads per core
> @@ -1653,6 +1655,7 @@
>        '*sockets': 'int',
>        '*dies': 'int',
>        '*clusters': 'int',
> +     '*modules': 'int',
>        '*cores': 'int',
>        '*threads': 'int',
>        '*maxcpus': 'int' } }
> diff --git a/system/vl.c b/system/vl.c
> index b8469d9965da..15ff95b89b57 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -741,6 +741,9 @@ static QemuOptsList qemu_smp_opts = {
>           }, {
>               .name = "clusters",
>               .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "modules",
> +            .type = QEMU_OPT_NUMBER,
>           }, {
>               .name = "cores",
>               .type = QEMU_OPT_NUMBER,

