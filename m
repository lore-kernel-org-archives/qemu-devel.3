Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C3CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Di5-0003KV-UH; Fri, 10 Oct 2025 10:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7Di3-0003Js-PG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7Dhr-0007gz-PC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760104966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KoRvbDJRDCXtO0HZ2rP71U/Vw9NGLsXlYwPWfEpgwys=;
 b=i5DISq7COGEwbuzrs3q8y8KCknLn7HO1uVyzFvVZyNh7bNWmWJM3v054PLy8/d4SoMmHt1
 8tKB+9S7TtV5VvKYlx5+OL4t/sfDC3fChiyZyNAOacZeMGCBadRuo8rWhLSsWYf2WeDlLU
 flZ5TVHx6sdmzVxMRN2LnbO8ioz7Q6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-ZfMtyzw8N86UDtSSPNAsRA-1; Fri,
 10 Oct 2025 10:02:41 -0400
X-MC-Unique: ZfMtyzw8N86UDtSSPNAsRA-1
X-Mimecast-MFC-AGG-ID: ZfMtyzw8N86UDtSSPNAsRA_1760104957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E5EF180047F; Fri, 10 Oct 2025 14:02:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFB8C3000381; Fri, 10 Oct 2025 14:02:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 324DC21E6A27; Fri, 10 Oct 2025 16:02:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Wei Liu <liuwe@microsoft.com>,  Cornelia
 Huck <cohuck@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Roman Bolshakov
 <rbolshakov@ddn.com>,  Phil Dennis-Jordan <phil@philjordan.eu>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Magnus Kulke <magnuskulke@microsoft.com>,  Wei Liu
 <wei.liu@kernel.org>,  Eric Blake <eblake@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
In-Reply-To: <20250916164847.77883-25-magnuskulke@linux.microsoft.com> (Magnus
 Kulke's message of "Tue, 16 Sep 2025 18:48:44 +0200")
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
Date: Fri, 10 Oct 2025 16:02:32 +0200
Message-ID: <871pnahn2f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Magnus Kulke <magnuskulke@linux.microsoft.com> writes:

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

Mirrors the entry for "kvm".

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

Mirrors hmp_info_kvm().

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

Mirrors qmp_query_kvm().

Note that accel_find() works for any accelerator.  It returns the
AccelClass.  As far as I can tell, AccelClass member @allowed points to
the variable _enabled() returns.  So, this function could be made
generic.  More on that below.

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

Why?

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

Mirrors query-kvm.  Okay apart from the Since: issues Daniel pointed
out.

Should we have a generic query-accelerator instead of one query-FOO for
every accelerator FOO?


