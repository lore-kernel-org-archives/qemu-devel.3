Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1348AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 04:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXYlL-0002U9-Dx; Sat, 27 Jul 2024 00:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1sXYlI-0002Sb-SR
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 00:10:28 -0400
Received: from smtpnm6-07.21cn.com ([182.42.151.156] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1sXYlD-0003AD-5T
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 00:10:28 -0400
HMM_SOURCE_IP: 192.168.138.117:0.313935585
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-112.44.135.226 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 4627B9C19C1;
 Sat, 27 Jul 2024 12:10:02 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([112.44.135.226])
 by gateway-ssl-dep-67bdc54df-qz2qs with ESMTP id
 799eca1d70934cd8bd75930e03d03c62 for armbru@redhat.com; 
 Sat, 27 Jul 2024 12:10:10 CST
X-Transaction-ID: 799eca1d70934cd8bd75930e03d03c62
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 112.44.135.226
X-MEDUSA-Status: 0
Message-ID: <1f960137-f5b5-429c-9eca-13ed6cc1786f@chinatelecom.cn>
Date: Sat, 27 Jul 2024 12:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn, zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
To: Markus Armbruster <armbru@redhat.com>
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
 <87h6cdogau.fsf@pond.sub.org>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <87h6cdogau.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.151.156; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

On 2024/7/25 19:35, Markus Armbruster wrote:
> Guoyi Tu <tugy@chinatelecom.cn> writes:
> 
>> In the test environment, we conducted IO stress tests on all storage disks
>> within a virtual machine that had five storage devices mounted.During
>> testing,
>> we found that the qemu process allocated a large amount of memory (~800MB)
>> to handle these IO operations.
>>
>> When the test ended, although qemu called free() to release the allocated
>> memory, the memory was not actually returned to the operating system, as
>> observed via the top command.
>>
>> Upon researching the glibc memory management mechanism, we found that when
>> small chunks of memory are allocated in user space and then released with
>> free(),  the glibc memory management mechanism does not necessarily return
>> this memory to the operating system. Instead, it retains the memory until
>> certain conditions are met for release.
> 
> Yes.
> 
>> For virtual machines that only have business operations during specific
>> periods,  they remain idle most of the time. However, the qemu process
>> still occupies a large amount of memory resources, leading to significant
>> memory resource waste.
> 
> Mitigation: the memory free()'s but not returned to the OS can be paged
> out.
Yes, swap can alleviate the issue of insufficient system memory, but it 
can also affect performance. Additionally, some systems may disable the 
swap function for various reasons, making it unavailable for use

>> To address this issue, this patch introduces an API to actively reclaim
>> idle memory within the qemu process. This API effectively calls
>> malloc_trim()
>> to notify glibc to trim free memory. With this api, the management tool
>> can monitor the virtual machine's state and call this API during idle times
>> to free up the memory occupied by the virtual machine, thereby allowing more
>> virtual machines to be provisioned.
> 
> How does this affect the test case you described above?
Based on the test results, QEMU generally allocates a lot of memory
when handling backend I/O, and this memory can be released when the
virtual machine’s storage I/O is idle.

Based on this observation, management tools can monitor the storage I/O
load of virtual machines. If the storage I/O load of a virtual machine
remains low for a certain period, the tool can use this interface to
return most of the allocatable memory to the operating system.

According to our statistics, this approach can save at least 150MB of
system memory per virtual machine on average.

> There's an existing use of malloc_trim() in util/rcu.c's
> call_rcu_thread().  It's from commit 5a22ab71623:
> 
>      rcu: reduce more than 7MB heap memory by malloc_trim()
>      
>      Since there are some issues in memory alloc/free machenism
>      in glibc for little chunk memory, if Qemu frequently
>      alloc/free little chunk memory, the glibc doesn't alloc
>      little chunk memory from free list of glibc and still
>      allocate from OS, which make the heap size bigger and bigger.
>      
>      This patch introduce malloc_trim(), which will free heap
>      memory when there is no rcu call during rcu thread loop.
>      malloc_trim() can be enabled/disabled by --enable-malloc-trim/
>      --disable-malloc-trim in the Qemu configure command. The
>      default malloc_trim() is enabled for libc.
>      
>      Below are test results from smaps file.
>      (1)without patch
>      55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
>      Size:              21796 kB
>      Rss:               14260 kB
>      Pss:               14260 kB
>      
>      (2)with patch
>      55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
>      Size:              21668 kB
>      Rss:                6940 kB
>      Pss:                6940 kB
>      
>      Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>      Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> How would the malloc_trim() you propose interact with this one?
During the lifecycle of the virtual machine, this part of the logic
may not be triggered, so we plan to add a new interface.
>> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
>> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
>> ---
>>    hmp-commands.hx       | 13 +++++++++++++
>>    include/monitor/hmp.h |  1 +
>>    monitor/hmp-cmds.c    | 14 ++++++++++++++
>>    monitor/qmp-cmds.c    | 18 ++++++++++++++++++
>>    qapi/misc.json        | 13 +++++++++++++
>>    5 files changed, 59 insertions(+)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 06746f0afc..0fde22fc71 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1858,4 +1858,17 @@ SRST
>>    ``xen-event-list``
>>      List event channels in the guest
>>    ERST
>> +
>> +    {
>> +        .name       = "trim-memory",
>> +        .args_type  = "reserved:l?",
>> +        .params     = "[reserved]",
>> +        .help       = "trim momory",
>> +        .cmd        = hmp_trim_memory,
>> +    },
>> +
>> +SRST
>> +``trim-memory`` *reserved*
>> +  try to release free memory and keep reserved bytes of free memory
>> untrimmed
>> +ERST
>>    #endif
>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>> index 954f3c83ad..547cde0056 100644
>> --- a/include/monitor/hmp.h
>> +++ b/include/monitor/hmp.h
>> @@ -181,5 +181,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
>>    void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>>    void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
>>    void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
>> +void hmp_trim_memory(Monitor *mon, const QDict *qdict);
>>
>>    #endif
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index ea79148ee8..f842e43315 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -460,3 +460,17 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>>       monitor_printf(mon, "dtb dumped to %s", filename);
>>   }
>>   #endif
>> +
>> +void hmp_trim_memory(Monitor *mon, const QDict *qdict)
>> +{
>> +    int64_t reserved;
>> +    bool has_reserved = qdict_haskey(qdict, "reserved");
>> +    Error *err = NULL;
>> +
>> +    if (has_reserved) {
>> +        reserved = qdict_get_int(qdict, "reserved");
>> +    }
>> +
>> +    qmp_trim_memory(has_reserved, reserved, &err);
>> +    hmp_handle_error(mon, err);
>> +}
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index f84a0dc523..878a7a646a 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -31,6 +31,7 @@
>>   #include "qapi/type-helpers.h"
>>   #include "hw/mem/memory-device.h"
>>   #include "hw/intc/intc.h"
>> +#include <malloc.h>
>>
>>   NameInfo *qmp_query_name(Error **errp)
>>   {
>> @@ -161,6 +162,23 @@ void qmp_add_client(const char *protocol, const
>> char *fdname,
>>       }
>>   }
>>
>> +void qmp_trim_memory(bool has_reserved, int64_t reserved, Error **errp)
>> +{
>> +#if defined(CONFIG_MALLOC_TRIM)
>> +    if (!has_reserved) {
>> +        reserved = 1024 * 1024;
>> +    }
>> +    if (reserved < 0) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> +                   "reserved", "a >0 reserved");
>> +        return;
>> +    }
>> +    malloc_trim(reserved);
>> +#else
>> +    error_setg(errp, "malloc_trim feature not configured");
> 
> Have you tried making the entire command conditional instead?  Like...
> 
>> +#endif
>> +}
>> +
>>    char *qmp_human_monitor_command(const char *command_line, bool
>> has_cpu_index,
>>                                    int64_t cpu_index, Error **errp)
>>    {
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index ec30e5c570..00e6f2f650 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -605,3 +605,16 @@
>>    { 'event': 'VFU_CLIENT_HANGUP',
>>      'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
>>                'dev-id': 'str', 'dev-qom-path': 'str' } }
>> +
>> +##
>> +# @trim-memory:
>> +#
>> +# try to release free memory
>> +#
>> +# @reserved: specifies the amount of free space to leave untrimmed.
>> +#            default to 1MB if not specified.
>> +#
>> +# Since: 9.0
>> +##
>> +{'command': 'trim-memory',
>> + 'data': {'*reserved': 'int'} }
> 
> ... so:
> 
>     { 'command': 'trim-memory',
>       'data': {'*reserved': 'int'},
>       'if': 'CONFIG_MALLOC_TRIM' }
> 
> Could we do without the argument?
> 
> 
--
Guoyi

