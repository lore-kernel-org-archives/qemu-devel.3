Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A1CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZr5-00026J-FK; Tue, 16 Sep 2025 13:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyZqp-0001nQ-HC
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:52:25 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyZqn-0008NS-3k
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=AxEONyLJUtMV6IUJSjcYKhCgJlW/7HPy8XfBmsePm0g=; b=gNLT0xIu+2qAyKmS
 z/iBp2sunDEkFYVAbNY7Bg/IGtxsNL/EeYXgLOmHbrZ6zbQVt9FYGwgZHXVBKOLa4NAiepuWKJQBF
 wP3VA2WkVEfRdmB7ZMcoUG8MAT4PoGNXB3cfvmBr4w6KPuvvOxlwmioC6F0V6zFce1Sc3P6ve/2Q2
 K+xgwJK7d+IN3gHQG3ksl0MA1zHo0VWZDOySRrAy9y7hdFcsx6hv2jr9KVTd+zNQBcya42fooG7Ib
 mJg06xV2IFTdLopEIHzbAETukD0w8Vr3Gd1vjhYO+MQ9sb1x3Pv9ZPrpOd2trmJGcuub6QooJQoXf
 fRpMcCnI1S616rEfUw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uyZqj-00BQf3-2v;
 Tue, 16 Sep 2025 17:52:17 +0000
Date: Tue, 16 Sep 2025 17:52:17 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
Message-ID: <aMmj0T6Bv2g7InkK@gallifrey>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:51:50 up 142 days,  2:05,  1 user,  load average: 0.05, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Magnus Kulke (magnuskulke@linux.microsoft.com) wrote:
> From: Praveen K Paladugu <prapal@microsoft.com>
> 
> Allow to query mshv capabilities via query-mshv QMP and info mshv HMP commands.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  hmp-commands-info.hx       | 13 +++++++++++++
>  hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
>  hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
>  include/monitor/hmp.h      |  1 +
>  include/system/hw_accel.h  |  1 +
>  qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
>  6 files changed, 73 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 6142f60e7b..eaaa880c1b 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -307,6 +307,19 @@ SRST
>      Show KVM information.
>  ERST
>  
> +    {
> +        .name       = "mshv",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show MSHV information",
> +        .cmd        = hmp_info_mshv,
> +    },
> +
> +SRST
> +  ``info mshv``
> +    Show MSHV information.
> +ERST
> +
>      {
>          .name       = "numa",
>          .args_type  = "",
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 3a612e2232..682ed9f49b 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -163,6 +163,21 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
>      qapi_free_KvmInfo(info);
>  }
>  
> +void hmp_info_mshv(Monitor *mon, const QDict *qdict)
> +{
> +    MshvInfo *info;
> +
> +    info = qmp_query_mshv(NULL);
> +    monitor_printf(mon, "mshv support: ");
> +    if (info->present) {
> +        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
> +    } else {
> +        monitor_printf(mon, "not compiled\n");
> +    }
> +
> +    qapi_free_MshvInfo(info);
> +}
> +

Looks the same as info kvm, so just for HMP

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

>  void hmp_info_uuid(Monitor *mon, const QDict *qdict)
>  {
>      UuidInfo *info;
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 6aca1a626e..e24bf0d97b 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -28,6 +28,20 @@
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "hw/s390x/storage-keys.h"
> +#include <sys/stat.h>
> +
> +/*
> + * QMP query for MSHV
> + */
> +MshvInfo *qmp_query_mshv(Error **errp)
> +{
> +    MshvInfo *info = g_malloc0(sizeof(*info));
> +
> +    info->enabled = mshv_enabled();
> +    info->present = accel_find("mshv");
> +
> +    return info;
> +}
>  
>  /*
>   * fast means: we NEVER interrupt vCPU threads to retrieve
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index ae116d9804..31bd812e5f 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -24,6 +24,7 @@ strList *hmp_split_at_comma(const char *str);
>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>  void hmp_info_version(Monitor *mon, const QDict *qdict);
>  void hmp_info_kvm(Monitor *mon, const QDict *qdict);
> +void hmp_info_mshv(Monitor *mon, const QDict *qdict);
>  void hmp_info_status(Monitor *mon, const QDict *qdict);
>  void hmp_info_uuid(Monitor *mon, const QDict *qdict);
>  void hmp_info_chardev(Monitor *mon, const QDict *qdict);
> diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
> index fa9228d5d2..55497edc29 100644
> --- a/include/system/hw_accel.h
> +++ b/include/system/hw_accel.h
> @@ -14,6 +14,7 @@
>  #include "hw/core/cpu.h"
>  #include "system/kvm.h"
>  #include "system/hvf.h"
> +#include "system/mshv.h"
>  #include "system/whpx.h"
>  #include "system/nvmm.h"
>  
> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> index fb28c8d920..c2bfbc507f 100644
> --- a/qapi/accelerator.json
> +++ b/qapi/accelerator.json
> @@ -54,3 +54,32 @@
>  { 'command': 'x-accel-stats',
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
> +
> +##
> +# @MshvInfo:
> +#
> +# Information about support for MSHV acceleration
> +#
> +# @enabled: true if MSHV acceleration is active
> +#
> +# @present: true if MSHV acceleration is built into this executable
> +#
> +# Since: 10.0.92
> +##
> +{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +
> +##
> +# @query-mshv:
> +#
> +# Return information about MSHV acceleration
> +#
> +# Returns: @MshvInfo
> +#
> +# Since: 10.0.92
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-mshv" }
> +#     <- { "return": { "enabled": true, "present": true } }
> +##
> +{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

