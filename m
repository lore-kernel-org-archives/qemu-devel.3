Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDAAC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 14:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s009R-0004kY-DH; Thu, 25 Apr 2024 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s009L-0004kI-S9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s009G-0000uT-QV
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714055549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ukUEtoouNJ2/ZeEd8OZbkzGx2YXeEr/QNw6eooSGC9Q=;
 b=e/fxkNTW+J/RrnOvWhropySipP5GKxMgmbtucHCpcHg4clxEKSLYhjZLMDmAeQ/NCxLTTk
 Emzm+4U5QVJ9Q3v/T/bmGmu6ECUzTOTze9f/DICS2f6ttDrGStAvf7lL2ySTEOjEp6GzU1
 qaHVamNgif5RmKNzX+Rg48TcyRkzY1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-ub8f-zyJND2s0JreCanQuQ-1; Thu, 25 Apr 2024 10:32:28 -0400
X-MC-Unique: ub8f-zyJND2s0JreCanQuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D8C8EE934;
 Thu, 25 Apr 2024 14:32:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8371121313;
 Thu, 25 Apr 2024 14:32:25 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:32:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 03/14] util/dsa: Implement DSA device start and stop
 logic.
Message-ID: <Zippd7gTrUaRWnq_@redhat.com>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-4-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-4-hao.xiang@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 02:21:06AM +0000, Hao Xiang wrote:
> * DSA device open and close.
> * DSA group contains multiple DSA devices.
> * DSA group configure/start/stop/clean.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> ---
>  include/qemu/dsa.h |  72 +++++++++++
>  util/dsa.c         | 316 +++++++++++++++++++++++++++++++++++++++++++++
>  util/meson.build   |   1 +
>  3 files changed, 389 insertions(+)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 util/dsa.c
> 
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> new file mode 100644
> index 0000000000..f15c05ee85
> --- /dev/null
> +++ b/include/qemu/dsa.h
> @@ -0,0 +1,72 @@
> +#ifndef QEMU_DSA_H
> +#define QEMU_DSA_H
> +
> +#include "qemu/error-report.h"
> +#include "qemu/thread.h"
> +#include "qemu/queue.h"
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")
> +
> +#include <linux/idxd.h>
> +#include "x86intrin.h"
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.
> + *
> + * @return int Zero if successful, otherwise non zero.
> + */
> +int dsa_init(const char *dsa_parameter);

BTW, all these methods should also use 'qemu_dsa_' as a name
prefix, not merely 'dsa_'. The latter is too generic, and
likely to clash with naming of APIs implemnenting 'dsa'
crypto, as well as withthe kernel's dsa devoce header.

Likewise best practice for the structs in the dsa.c file
to also use 'QemuDsa' as a nameprefix, not merely 'Dsa'.

> +
> +/**
> + * @brief Start logic to enable using DSA.
> + */
> +void dsa_start(void);
> +
> +/**
> + * @brief Stop the device group and the completion thread.
> + */
> +void dsa_stop(void);
> +
> +/**
> + * @brief Clean up system resources created for DSA offloading.
> + */
> +void dsa_cleanup(void);
> +
> +/**
> + * @brief Check if DSA is running.
> + *
> + * @return True if DSA is running, otherwise false.
> + */
> +bool dsa_is_running(void);
> +
> +#else
> +
> +static inline bool dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +static inline int dsa_init(const char *dsa_parameter)
> +{
> +    if (dsa_parameter != NULL && strlen(dsa_parameter) != 0) {
> +        error_report("DSA not supported.");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline void dsa_start(void) {}
> +
> +static inline void dsa_stop(void) {}
> +
> +static inline void dsa_cleanup(void) {}
> +
> +#endif
> +
> +#endif
> diff --git a/util/dsa.c b/util/dsa.c
> new file mode 100644
> index 0000000000..05bbf8e31a
> --- /dev/null
> +++ b/util/dsa.c
> @@ -0,0 +1,316 @@
> +/*
> + * Use Intel Data Streaming Accelerator to offload certain background
> + * operations.
> + *
> + * Copyright (c) 2023 Hao Xiang <hao.xiang@bytedance.com>
> + *                    Bryan Zhang <bryan.zhang@bytedance.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/memalign.h"
> +#include "qemu/lockable.h"
> +#include "qemu/cutils.h"
> +#include "qemu/dsa.h"
> +#include "qemu/bswap.h"
> +#include "qemu/error-report.h"
> +#include "qemu/rcu.h"
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")
> +
> +#include <linux/idxd.h>
> +#include "x86intrin.h"
> +
> +#define DSA_WQ_SIZE 4096
> +#define MAX_DSA_DEVICES 16
> +
> +typedef QSIMPLEQ_HEAD(dsa_task_queue, dsa_batch_task) dsa_task_queue;
> +
> +struct dsa_device {
> +    void *work_queue;
> +};
> +
> +struct dsa_device_group {

IMHO preferable to use initial-upper case for struct
names, to distinguish from method names. ie

 QemuDsaDeviceGroup

also I'd suggest they should all be typedef'd too,
so its not repeating 'struct <blah>' everywhere.

> +    struct dsa_device *dsa_devices;
> +    int num_dsa_devices;
> +    /* The index of the next DSA device to be used. */
> +    uint32_t device_allocator_index;
> +    bool running;
> +    QemuMutex task_queue_lock;
> +    QemuCond task_queue_cond;
> +    dsa_task_queue task_queue;
> +};

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


