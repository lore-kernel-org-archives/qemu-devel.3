Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5D5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 21:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s06YU-0003rd-OX; Thu, 25 Apr 2024 17:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s06Xv-0003jk-0I
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:22:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s06Xs-0004ug-91
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:22:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99A835C747;
 Thu, 25 Apr 2024 21:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714080136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcxz9tLDN1Nzshwyj8GilZqD29GOz4r1OWRX+l322bM=;
 b=UyweLxnLhbkhk4ai9CZvxR96syypEfBumUgKhH89Aenc1/+lIdVOervUNh3l7B2IVEeEZ8
 NopvHxo7cyWYfMiOfq1ATielfWTtJsNYewD7g6fLiBAUOmSEOQf7yXRXsjD6tHPLAo6JFn
 AMLV/Wt1YjcuQWqhA3/44QNUMxM6mIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714080136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcxz9tLDN1Nzshwyj8GilZqD29GOz4r1OWRX+l322bM=;
 b=bfPXT/S5qqCReAjKDpUnyR3WOWYSpDwZC0tMj/dJu15tT66LHiYd7koNPkPIGEQ32WAGCC
 bP9BlAxZMZOzygBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714080136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcxz9tLDN1Nzshwyj8GilZqD29GOz4r1OWRX+l322bM=;
 b=UyweLxnLhbkhk4ai9CZvxR96syypEfBumUgKhH89Aenc1/+lIdVOervUNh3l7B2IVEeEZ8
 NopvHxo7cyWYfMiOfq1ATielfWTtJsNYewD7g6fLiBAUOmSEOQf7yXRXsjD6tHPLAo6JFn
 AMLV/Wt1YjcuQWqhA3/44QNUMxM6mIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714080136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcxz9tLDN1Nzshwyj8GilZqD29GOz4r1OWRX+l322bM=;
 b=bfPXT/S5qqCReAjKDpUnyR3WOWYSpDwZC0tMj/dJu15tT66LHiYd7koNPkPIGEQ32WAGCC
 bP9BlAxZMZOzygBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 205A31393C;
 Thu, 25 Apr 2024 21:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id guIuNofJKmZ8awAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 21:22:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, marcandre.lureau@redhat.com,
 peterx@redhat.com, armbru@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 03/14] util/dsa: Implement DSA device start and stop
 logic.
In-Reply-To: <20240425022117.4035031-4-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-4-hao.xiang@linux.dev>
Date: Thu, 25 Apr 2024 18:22:13 -0300
Message-ID: <871q6t87ei.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hao Xiang <hao.xiang@linux.dev> writes:

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

This should be done in meson.build. Here you're allowing an empty object
to be generated just so we can expose the struct batch_task to
multifd. In another patch I suggested we stop using it, then we can put
the whole dsa.c under CONFIG_DSA (we can drop the OPT as well) in
meson.build.

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
> +    struct dsa_device *dsa_devices;
> +    int num_dsa_devices;
> +    /* The index of the next DSA device to be used. */
> +    uint32_t device_allocator_index;
> +    bool running;
> +    QemuMutex task_queue_lock;
> +    QemuCond task_queue_cond;
> +    dsa_task_queue task_queue;
> +};
> +
> +uint64_t max_retry_count;
> +static struct dsa_device_group dsa_group;
> +
> +
> +/**
> + * @brief This function opens a DSA device's work queue and
> + *        maps the DSA device memory into the current process.
> + *
> + * @param dsa_wq_path A pointer to the DSA device work queue's file path.
> + * @return A pointer to the mapped memory, or MAP_FAILED on failure.
> + */
> +static void *
> +map_dsa_device(const char *dsa_wq_path)
> +{
> +    void *dsa_device;
> +    int fd;
> +
> +    fd = open(dsa_wq_path, O_RDWR);
> +    if (fd < 0) {
> +        error_report("Open %s failed with errno = %d.",
> +                dsa_wq_path, errno);
> +        return MAP_FAILED;
> +    }
> +    dsa_device = mmap(NULL, DSA_WQ_SIZE, PROT_WRITE,
> +                      MAP_SHARED | MAP_POPULATE, fd, 0);
> +    close(fd);
> +    if (dsa_device == MAP_FAILED) {
> +        error_report("mmap failed with errno = %d.", errno);
> +        return MAP_FAILED;
> +    }
> +    return dsa_device;
> +}
> +
> +/**
> + * @brief Initializes a DSA device structure.
> + *
> + * @param instance A pointer to the DSA device.
> + * @param work_queue A pointer to the DSA work queue.
> + */
> +static void
> +dsa_device_init(struct dsa_device *instance,
> +                void *dsa_work_queue)
> +{
> +    instance->work_queue = dsa_work_queue;
> +}
> +
> +/**
> + * @brief Cleans up a DSA device structure.
> + *
> + * @param instance A pointer to the DSA device to cleanup.
> + */
> +static void
> +dsa_device_cleanup(struct dsa_device *instance)
> +{
> +    if (instance->work_queue != MAP_FAILED) {
> +        munmap(instance->work_queue, DSA_WQ_SIZE);
> +    }
> +}
> +
> +/**
> + * @brief Initializes a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + * @param dsa_parameter A list of DSA device path from are separated by space
> + * character migration parameter. Multiple DSA device path.
> + *
> + * @return Zero if successful, non-zero otherwise.
> + */
> +static int
> +dsa_device_group_init(struct dsa_device_group *group,
> +                      const char *dsa_parameter)
> +{
> +    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
> +        return 0;
> +    }
> +
> +    int ret = 0;
> +    char *local_dsa_parameter = g_strdup(dsa_parameter);
> +    const char *dsa_path[MAX_DSA_DEVICES];
> +    int num_dsa_devices = 0;
> +    char delim[2] = " ";
> +
> +    char *current_dsa_path = strtok(local_dsa_parameter, delim);
> +
> +    while (current_dsa_path != NULL) {
> +        dsa_path[num_dsa_devices++] = current_dsa_path;
> +        if (num_dsa_devices == MAX_DSA_DEVICES) {
> +            break;
> +        }
> +        current_dsa_path = strtok(NULL, delim);
> +    }
> +
> +    group->dsa_devices =
> +        g_new0(struct dsa_device, num_dsa_devices);
> +    group->num_dsa_devices = num_dsa_devices;
> +    group->device_allocator_index = 0;
> +
> +    group->running = false;
> +    qemu_mutex_init(&group->task_queue_lock);
> +    qemu_cond_init(&group->task_queue_cond);
> +    QSIMPLEQ_INIT(&group->task_queue);
> +
> +    void *dsa_wq = MAP_FAILED;
> +    for (int i = 0; i < num_dsa_devices; i++) {
> +        dsa_wq = map_dsa_device(dsa_path[i]);
> +        if (dsa_wq == MAP_FAILED) {
> +            error_report("map_dsa_device failed MAP_FAILED.");
> +            ret = -1;
> +            goto exit;
> +        }
> +        dsa_device_init(&dsa_group.dsa_devices[i], dsa_wq);
> +    }
> +
> +exit:
> +    g_free(local_dsa_parameter);
> +    return ret;
> +}
> +
> +/**
> + * @brief Starts a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_device_group_start(struct dsa_device_group *group)
> +{
> +    group->running = true;
> +}
> +
> +/**
> + * @brief Stops a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +__attribute__((unused))
> +static void
> +dsa_device_group_stop(struct dsa_device_group *group)
> +{
> +    group->running = false;
> +}
> +
> +/**
> + * @brief Cleans up a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_device_group_cleanup(struct dsa_device_group *group)
> +{
> +    if (!group->dsa_devices) {
> +        return;
> +    }
> +    for (int i = 0; i < group->num_dsa_devices; i++) {
> +        dsa_device_cleanup(&group->dsa_devices[i]);
> +    }
> +    g_free(group->dsa_devices);
> +    group->dsa_devices = NULL;
> +
> +    qemu_mutex_destroy(&group->task_queue_lock);
> +    qemu_cond_destroy(&group->task_queue_cond);
> +}
> +
> +/**
> + * @brief Returns the next available DSA device in the group.
> + *
> + * @param group A pointer to the DSA device group.
> + *
> + * @return struct dsa_device* A pointer to the next available DSA device
> + *         in the group.
> + */
> +__attribute__((unused))
> +static struct dsa_device *
> +dsa_device_group_get_next_device(struct dsa_device_group *group)
> +{
> +    if (group->num_dsa_devices == 0) {
> +        return NULL;
> +    }
> +    uint32_t current = qatomic_fetch_inc(&group->device_allocator_index);
> +    current %= group->num_dsa_devices;
> +    return &group->dsa_devices[current];
> +}
> +
> +/**
> + * @brief Check if DSA is running.
> + *
> + * @return True if DSA is running, otherwise false.
> + */
> +bool dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +static void
> +dsa_globals_init(void)
> +{
> +    max_retry_count = UINT64_MAX;
> +}
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.
> + *
> + * @return int Zero if successful, otherwise non zero.
> + */
> +int dsa_init(const char *dsa_parameter)
> +{
> +    dsa_globals_init();
> +
> +    return dsa_device_group_init(&dsa_group, dsa_parameter);
> +}
> +
> +/**
> + * @brief Start logic to enable using DSA.
> + *
> + */
> +void dsa_start(void)
> +{
> +    if (dsa_group.num_dsa_devices == 0) {
> +        return;
> +    }
> +    if (dsa_group.running) {
> +        return;
> +    }
> +    dsa_device_group_start(&dsa_group);
> +}
> +
> +/**
> + * @brief Stop the device group and the completion thread.
> + *
> + */
> +void dsa_stop(void)
> +{
> +    struct dsa_device_group *group = &dsa_group;
> +
> +    if (!group->running) {
> +        return;
> +    }
> +}
> +
> +/**
> + * @brief Clean up system resources created for DSA offloading.
> + *
> + */
> +void dsa_cleanup(void)
> +{
> +    dsa_stop();
> +    dsa_device_group_cleanup(&dsa_group);
> +}
> +
> +#endif
> +
> diff --git a/util/meson.build b/util/meson.build
> index 2ad57b10ba..144c6812e5 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -88,6 +88,7 @@ if have_block or have_ga
>  endif
>  if have_block
>    util_ss.add(files('aio-wait.c'))
> +  util_ss.add(files('dsa.c'))
>    util_ss.add(files('buffer.c'))
>    util_ss.add(files('bufferiszero.c'))
>    util_ss.add(files('hbitmap.c'))

