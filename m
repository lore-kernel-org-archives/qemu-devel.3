Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77804C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwl2-00082t-51; Thu, 25 Jul 2024 07:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWwl0-000824-6c
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWwkx-0007Jr-E3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721907333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4aqT93+5qt3mwXcMIl/LzXlhfg6b83h4ER6KhHL2Xc=;
 b=hQnTRIGSyg2g0bMvXzsFTduVmQnpzJtvXQxTltlzLV70rY8h9WAK76X8iUx8NQ2+OUlI8W
 GtU+fC8rWsMsp3otKljWoAnIbAm9wUDNDZwIpUxG0jR0f1oPibfyikWfaSXX5thangbqza
 OKIbtMgsoCXM1Tn/LZt45UYR3M/F4IU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-DIMZb9fPPo-wpWcWL6Sqrw-1; Thu,
 25 Jul 2024 07:35:27 -0400
X-MC-Unique: DIMZb9fPPo-wpWcWL6Sqrw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B14541956095; Thu, 25 Jul 2024 11:35:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BB953000194; Thu, 25 Jul 2024 11:35:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC24F21F4B8B; Thu, 25 Jul 2024 13:35:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  Eric Blake
 <eblake@redhat.com>,  qemu-devel@nongnu.org,  dengpc12@chinatelecom.cn,
 zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free
 memory trimming
In-Reply-To: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn> (Guoyi
 Tu's message of "Fri, 28 Jun 2024 18:22:48 +0800")
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
Date: Thu, 25 Jul 2024 13:35:21 +0200
Message-ID: <87h6cdogau.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Guoyi Tu <tugy@chinatelecom.cn> writes:

> In the test environment, we conducted IO stress tests on all storage disks
> within a virtual machine that had five storage devices mounted.During 
> testing,
> we found that the qemu process allocated a large amount of memory (~800MB)
> to handle these IO operations.
>
> When the test ended, although qemu called free() to release the allocated
> memory, the memory was not actually returned to the operating system, as
> observed via the top command.
>
> Upon researching the glibc memory management mechanism, we found that when
> small chunks of memory are allocated in user space and then released with
> free(),  the glibc memory management mechanism does not necessarily return
> this memory to the operating system. Instead, it retains the memory until
> certain conditions are met for release.

Yes.

> For virtual machines that only have business operations during specific
> periods,  they remain idle most of the time. However, the qemu process
> still occupies a large amount of memory resources, leading to significant
> memory resource waste.

Mitigation: the memory free()'s but not returned to the OS can be paged
out.

> To address this issue, this patch introduces an API to actively reclaim
> idle memory within the qemu process. This API effectively calls 
> malloc_trim()
> to notify glibc to trim free memory. With this api, the management tool
> can monitor the virtual machine's state and call this API during idle times
> to free up the memory occupied by the virtual machine, thereby allowing more
> virtual machines to be provisioned.

How does this affect the test case you described above?

There's an existing use of malloc_trim() in util/rcu.c's
call_rcu_thread().  It's from commit 5a22ab71623:

    rcu: reduce more than 7MB heap memory by malloc_trim()
    
    Since there are some issues in memory alloc/free machenism
    in glibc for little chunk memory, if Qemu frequently
    alloc/free little chunk memory, the glibc doesn't alloc
    little chunk memory from free list of glibc and still
    allocate from OS, which make the heap size bigger and bigger.
    
    This patch introduce malloc_trim(), which will free heap
    memory when there is no rcu call during rcu thread loop.
    malloc_trim() can be enabled/disabled by --enable-malloc-trim/
    --disable-malloc-trim in the Qemu configure command. The
    default malloc_trim() is enabled for libc.
    
    Below are test results from smaps file.
    (1)without patch
    55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
    Size:              21796 kB
    Rss:               14260 kB
    Pss:               14260 kB
    
    (2)with patch
    55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
    Size:              21668 kB
    Rss:                6940 kB
    Pss:                6940 kB
    
    Signed-off-by: Yang Zhong <yang.zhong@intel.com>
    Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

How would the malloc_trim() you propose interact with this one?

> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
> ---
>   hmp-commands.hx       | 13 +++++++++++++
>   include/monitor/hmp.h |  1 +
>   monitor/hmp-cmds.c    | 14 ++++++++++++++
>   monitor/qmp-cmds.c    | 18 ++++++++++++++++++
>   qapi/misc.json        | 13 +++++++++++++
>   5 files changed, 59 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc..0fde22fc71 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1858,4 +1858,17 @@ SRST
>   ``xen-event-list``
>     List event channels in the guest
>   ERST
> +
> +    {
> +        .name       = "trim-memory",
> +        .args_type  = "reserved:l?",
> +        .params     = "[reserved]",
> +        .help       = "trim momory",
> +        .cmd        = hmp_trim_memory,
> +    },
> +
> +SRST
> +``trim-memory`` *reserved*
> +  try to release free memory and keep reserved bytes of free memory 
> untrimmed
> +ERST
>   #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 954f3c83ad..547cde0056 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -181,5 +181,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
>   void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>   void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
>   void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
> +void hmp_trim_memory(Monitor *mon, const QDict *qdict);
>
>   #endif
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index ea79148ee8..f842e43315 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -460,3 +460,17 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>      monitor_printf(mon, "dtb dumped to %s", filename);
>  }
>  #endif
> +
> +void hmp_trim_memory(Monitor *mon, const QDict *qdict)
> +{
> +    int64_t reserved;
> +    bool has_reserved = qdict_haskey(qdict, "reserved");
> +    Error *err = NULL;
> +
> +    if (has_reserved) {
> +        reserved = qdict_get_int(qdict, "reserved");
> +    }
> +
> +    qmp_trim_memory(has_reserved, reserved, &err);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index f84a0dc523..878a7a646a 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -31,6 +31,7 @@
>  #include "qapi/type-helpers.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/intc/intc.h"
> +#include <malloc.h>
>
>  NameInfo *qmp_query_name(Error **errp)
>  {
> @@ -161,6 +162,23 @@ void qmp_add_client(const char *protocol, const 
> char *fdname,
>      }
>  }
>
> +void qmp_trim_memory(bool has_reserved, int64_t reserved, Error **errp)
> +{
> +#if defined(CONFIG_MALLOC_TRIM)
> +    if (!has_reserved) {
> +        reserved = 1024 * 1024;
> +    }
> +    if (reserved < 0) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                   "reserved", "a >0 reserved");
> +        return;
> +    }
> +    malloc_trim(reserved);
> +#else
> +    error_setg(errp, "malloc_trim feature not configured");

Have you tried making the entire command conditional instead?  Like...

> +#endif
> +}
> +
>   char *qmp_human_monitor_command(const char *command_line, bool 
> has_cpu_index,
>                                   int64_t cpu_index, Error **errp)
>   {
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ec30e5c570..00e6f2f650 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -605,3 +605,16 @@
>   { 'event': 'VFU_CLIENT_HANGUP',
>     'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
>               'dev-id': 'str', 'dev-qom-path': 'str' } }
> +
> +##
> +# @trim-memory:
> +#
> +# try to release free memory
> +#
> +# @reserved: specifies the amount of free space to leave untrimmed.
> +#            default to 1MB if not specified.
> +#
> +# Since: 9.0
> +##
> +{'command': 'trim-memory',
> + 'data': {'*reserved': 'int'} }

... so:

   { 'command': 'trim-memory',
     'data': {'*reserved': 'int'},
     'if': 'CONFIG_MALLOC_TRIM' }

Could we do without the argument?


