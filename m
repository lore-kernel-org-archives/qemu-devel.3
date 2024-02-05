Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FC1C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWw01-00021k-CM; Mon, 05 Feb 2024 05:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rWw00-00021a-Aj
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:14:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rWvzy-0002by-8l
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:14:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93E3822277;
 Mon,  5 Feb 2024 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707128081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ikVav4LZuAZCNaLnG8XwGj0DD7btpuiN3OTD4hJXzo=;
 b=VetF+eUHerO4aqbD83JL5HEc190mVfu3NhH6T5LaiXcrO5YsgF/ZLGFDZWkgqWXGRwabaO
 S6Q5u3/cxO+IPlh0hGshSxD6GGL6QzLFEQDfZETTplpTEnYX03okdYyHGB+QyMKaTOEMLj
 1RCVIg4tC+RVmaFnLpVLVijoiCpCjdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707128081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ikVav4LZuAZCNaLnG8XwGj0DD7btpuiN3OTD4hJXzo=;
 b=f/NMUe+Wj2CByGWbWPOqgVkqyRUTbkKAXno+DFDQrhvxNhS5Iby2V7Ra0iP4hHHdc1egAh
 rGoJmNXBl7goVICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707128081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ikVav4LZuAZCNaLnG8XwGj0DD7btpuiN3OTD4hJXzo=;
 b=VetF+eUHerO4aqbD83JL5HEc190mVfu3NhH6T5LaiXcrO5YsgF/ZLGFDZWkgqWXGRwabaO
 S6Q5u3/cxO+IPlh0hGshSxD6GGL6QzLFEQDfZETTplpTEnYX03okdYyHGB+QyMKaTOEMLj
 1RCVIg4tC+RVmaFnLpVLVijoiCpCjdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707128081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ikVav4LZuAZCNaLnG8XwGj0DD7btpuiN3OTD4hJXzo=;
 b=f/NMUe+Wj2CByGWbWPOqgVkqyRUTbkKAXno+DFDQrhvxNhS5Iby2V7Ra0iP4hHHdc1egAh
 rGoJmNXBl7goVICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D571136F5;
 Mon,  5 Feb 2024 10:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LbxyDBG1wGX6KgAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 05 Feb 2024 10:14:41 +0000
Message-ID: <beb8fd5c-3fc4-9bf5-1f9b-3947a25f52d9@suse.de>
Date: Mon, 5 Feb 2024 11:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL 5/8] util: Add write-only "node-affinity" property for
 ThreadContext
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Michal Privoznik <mprivozn@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20221028095225.86118-1-david@redhat.com>
 <20221028095225.86118-6-david@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20221028095225.86118-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VetF+eUH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="f/NMUe+W"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,linaro.org,weilnetz.de,nongnu.org];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Queue-Id: 93E3822277
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.214,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

turning pages back in time,

noticed that in recent qemu-img binaries we include an ELF dependency on libnuma.so that seems unused.

I think it stems from this commit:

commit 10218ae6d006f76410804cc4dc690085b3d008b5
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Oct 14 15:47:17 2022 +0200

    util: Add write-only "node-affinity" property for ThreadContext


possibly this hunk?

diff --git a/util/meson.build b/util/meson.build
index e97cd2d779..c0a7bc54d4 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,5 +1,5 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
-util_ss.add(files('thread-context.c'))
+util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
 endif


I wonder if there is some conditional we could use to avoid the apparently useless dependency to libnuma in the qemu-img binary?

Ciao,

Claudio 


On 10/28/22 11:52, David Hildenbrand wrote:
> Let's make it easier to pin threads created via a ThreadContext to
> all host CPUs currently belonging to a given set of host NUMA nodes --
> which is the common case.
> 
> "node-affinity" is simply a shortcut for setting "cpu-affinity" manually
> to the list of host CPUs belonging to the set of host nodes. This property
> can only be written.
> 
> A simple QEMU example to set the CPU affinity to host node 1 on a system
> with two nodes, 24 CPUs each, whereby odd-numbered host CPUs belong to
> host node 1:
>     qemu-system-x86_64 -S \
>       -object thread-context,id=tc1,node-affinity=1
> 
> And we can query the cpu-affinity via HMP/QMP:
>     (qemu) qom-get tc1 cpu-affinity
>     [
>         1,
>         3,
>         5,
>         7,
>         9,
>         11,
>         13,
>         15,
>         17,
>         19,
>         21,
>         23,
>         25,
>         27,
>         29,
>         31,
>         33,
>         35,
>         37,
>         39,
>         41,
>         43,
>         45,
>         47
>     ]
> 
> We cannot query the node-affinity:
>     (qemu) qom-get tc1 node-affinity
>     Error: Insufficient permission to perform this operation
> 
> But note that due to dynamic library loading this example will not work
> before we actually make use of thread_context_create_thread() in QEMU
> code, because the type will otherwise not get registered. We'll wire
> this up next to make it work.
> 
> Note that if the host CPUs for a host node change due do CPU hot(un)plug
> CPU onlining/offlining (i.e., lscpu output changes) after the ThreadContext
> was started, the CPU affinity will not get updated.
> 
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20221014134720.168738-5-david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi/qom.json         |  9 ++++-
>  util/meson.build      |  2 +-
>  util/thread-context.c | 84 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8013ba4b82..20b5735d78 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -839,10 +839,17 @@
>  #                threads created in the thread context (default: QEMU main
>  #                thread CPU affinity)
>  #
> +# @node-affinity: the list of host node numbers that will be resolved to a
> +#                 list of host CPU numbers used as CPU affinity. This is a
> +#                 shortcut for specifying the list of host CPU numbers
> +#                 belonging to the host nodes manually by setting
> +#                 @cpu-affinity. (default: QEMU main thread affinity)
> +#
>  # Since: 7.2
>  ##
>  { 'struct': 'ThreadContextProperties',
> -  'data': { '*cpu-affinity': ['uint16'] } }
> +  'data': { '*cpu-affinity': ['uint16'],
> +            '*node-affinity': ['uint16'] } }
>  
>  
>  ##
> diff --git a/util/meson.build b/util/meson.build
> index e97cd2d779..c0a7bc54d4 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,5 +1,5 @@
>  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
> -util_ss.add(files('thread-context.c'))
> +util_ss.add(files('thread-context.c'), numa)
>  if not config_host_data.get('CONFIG_ATOMIC64')
>    util_ss.add(files('atomic64.c'))
>  endif
> diff --git a/util/thread-context.c b/util/thread-context.c
> index c921905396..4138245332 100644
> --- a/util/thread-context.c
> +++ b/util/thread-context.c
> @@ -21,6 +21,10 @@
>  #include "qemu/module.h"
>  #include "qemu/bitmap.h"
>  
> +#ifdef CONFIG_NUMA
> +#include <numa.h>
> +#endif
> +
>  enum {
>      TC_CMD_NONE = 0,
>      TC_CMD_STOP,
> @@ -88,6 +92,11 @@ static void thread_context_set_cpu_affinity(Object *obj, Visitor *v,
>      int nbits = 0, ret;
>      Error *err = NULL;
>  
> +    if (tc->init_cpu_bitmap) {
> +        error_setg(errp, "Mixing CPU and node affinity not supported");
> +        return;
> +    }
> +
>      visit_type_uint16List(v, name, &host_cpus, &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -159,6 +168,79 @@ static void thread_context_get_cpu_affinity(Object *obj, Visitor *v,
>      qapi_free_uint16List(host_cpus);
>  }
>  
> +static void thread_context_set_node_affinity(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +#ifdef CONFIG_NUMA
> +    const int nbits = numa_num_possible_cpus();
> +    ThreadContext *tc = THREAD_CONTEXT(obj);
> +    uint16List *l, *host_nodes = NULL;
> +    unsigned long *bitmap = NULL;
> +    struct bitmask *tmp_cpus;
> +    Error *err = NULL;
> +    int ret, i;
> +
> +    if (tc->init_cpu_bitmap) {
> +        error_setg(errp, "Mixing CPU and node affinity not supported");
> +        return;
> +    }
> +
> +    visit_type_uint16List(v, name, &host_nodes, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    if (!host_nodes) {
> +        error_setg(errp, "Node list is empty");
> +        goto out;
> +    }
> +
> +    bitmap = bitmap_new(nbits);
> +    tmp_cpus = numa_allocate_cpumask();
> +    for (l = host_nodes; l; l = l->next) {
> +        numa_bitmask_clearall(tmp_cpus);
> +        ret = numa_node_to_cpus(l->value, tmp_cpus);
> +        if (ret) {
> +            /* We ignore any errors, such as impossible nodes. */
> +            continue;
> +        }
> +        for (i = 0; i < nbits; i++) {
> +            if (numa_bitmask_isbitset(tmp_cpus, i)) {
> +                set_bit(i, bitmap);
> +            }
> +        }
> +    }
> +    numa_free_cpumask(tmp_cpus);
> +
> +    if (bitmap_empty(bitmap, nbits)) {
> +        error_setg(errp, "The nodes select no CPUs");
> +        goto out;
> +    }
> +
> +    if (tc->thread_id != -1) {
> +        /*
> +         * Note: we won't be adjusting the affinity of any thread that is still
> +         * around for now, but only the affinity of the context thread.
> +         */
> +        ret = qemu_thread_set_affinity(&tc->thread, bitmap, nbits);
> +        if (ret) {
> +            error_setg(errp, "Setting CPU affinity failed: %s", strerror(ret));
> +        }
> +    } else {
> +        tc->init_cpu_bitmap = bitmap;
> +        bitmap = NULL;
> +        tc->init_cpu_nbits = nbits;
> +    }
> +out:
> +    g_free(bitmap);
> +    qapi_free_uint16List(host_nodes);
> +#else
> +    error_setg(errp, "NUMA node affinity is not supported by this QEMU");
> +#endif
> +}
> +
>  static void thread_context_get_thread_id(Object *obj, Visitor *v,
>                                           const char *name, void *opaque,
>                                           Error **errp)
> @@ -208,6 +290,8 @@ static void thread_context_class_init(ObjectClass *oc, void *data)
>      object_class_property_add(oc, "cpu-affinity", "int",
>                                thread_context_get_cpu_affinity,
>                                thread_context_set_cpu_affinity, NULL, NULL);
> +    object_class_property_add(oc, "node-affinity", "int", NULL,
> +                              thread_context_set_node_affinity, NULL, NULL);
>  }
>  
>  static void thread_context_instance_init(Object *obj)


