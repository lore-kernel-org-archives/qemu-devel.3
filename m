Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB3D743C9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE7tw-0005Fr-Mo; Thu, 21 Nov 2024 09:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tE7tp-0005F7-Lh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:11:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tE7tn-0000PN-EA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:11:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C151721A22;
 Thu, 21 Nov 2024 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732198269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfpiEXUijtnY16vEkuA572Kv6GhUs1PtdznrY+O838c=;
 b=rmW84Zh2MepBBD46NJDyVCa9gtdmcCaIWoHsIQeWBStuOHSzDJmll2vEEHkEWm2kLOE1Wq
 EouY/NDjpt/jPaervq5TDutDraZqShjsFhX1K0d075jrbWpKdfPHN1QaAU9Cq4BLHx5GAq
 UDjPH3gmJR97gcZu8IwuIuTdL7PmlSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732198269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfpiEXUijtnY16vEkuA572Kv6GhUs1PtdznrY+O838c=;
 b=wVmZh7P0/6J2mt2sMqmK4ZUe4nMg7MHy1Hbk+TI8CDCIlRzZqF0YKag8FudILmzzPE6AI6
 HPFlOCINiII98KDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FgcY6P8d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cgY2K12t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732198267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfpiEXUijtnY16vEkuA572Kv6GhUs1PtdznrY+O838c=;
 b=FgcY6P8dBY95HqQuUUxRWt9+YZnKNyzCBUfFsz8hxxn9LF9cVavxT1wRiwRVwzB3CfR67c
 Chif4XXYduhf3wD1j3u+Bo3ipSLyToSHlOwxdc5UBSY0JKTTUr/RcZisFDSID6aDP2wtQX
 QHGplIbUQOPmkG2EUK2NyJuVZ/mJBRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732198267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfpiEXUijtnY16vEkuA572Kv6GhUs1PtdznrY+O838c=;
 b=cgY2K12t72Fmfa3oLkQFJAEaR/ic/dEXchPYvYLKesboqR3cSY72UbVhUbylwOxh15S7f+
 OSnoDu1oiB4CTtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B1B13927;
 Thu, 21 Nov 2024 14:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xDAwMno/P2dZNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Nov 2024 14:11:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v7 03/12] util/dsa: Implement DSA device start and stop
 logic.
In-Reply-To: <20241114220132.27399-4-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
 <20241114220132.27399-4-yichen.wang@bytedance.com>
Date: Thu, 21 Nov 2024 11:11:03 -0300
Message-ID: <875xogsmmg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C151721A22
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.de:dkim,suse.de:mid,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> * DSA device open and close.
> * DSA group contains multiple DSA devices.
> * DSA group configure/start/stop/clean.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  include/qemu/dsa.h | 103 +++++++++++++++++
>  util/dsa.c         | 280 +++++++++++++++++++++++++++++++++++++++++++++
>  util/meson.build   |   3 +
>  3 files changed, 386 insertions(+)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 util/dsa.c
>
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> new file mode 100644
> index 0000000000..71686af28f
> --- /dev/null
> +++ b/include/qemu/dsa.h
> @@ -0,0 +1,103 @@
> +/*
> + * Interface for using Intel Data Streaming Accelerator to offload certain
> + * background operations.
> + *
> + * Copyright (C) Bytedance Ltd.
> + *
> + * Authors:
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_DSA_H
> +#define QEMU_DSA_H
> +
> +#include "qapi/error.h"
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
> +typedef struct {
> +    void *work_queue;
> +} QemuDsaDevice;
> +
> +typedef QSIMPLEQ_HEAD(QemuDsaTaskQueue, QemuDsaBatchTask) QemuDsaTaskQueue;
> +
> +typedef struct {
> +    QemuDsaDevice *dsa_devices;
> +    int num_dsa_devices;
> +    /* The index of the next DSA device to be used. */
> +    uint32_t device_allocator_index;
> +    bool running;
> +    QemuMutex task_queue_lock;
> +    QemuCond task_queue_cond;
> +    QemuDsaTaskQueue task_queue;
> +} QemuDsaDeviceGroup;
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.
> + *
> + * @return int Zero if successful, otherwise non zero.
> + */
> +int qemu_dsa_init(const strList *dsa_parameter, Error **errp);
> +
> +/**
> + * @brief Start logic to enable using DSA.
> + */
> +void qemu_dsa_start(void);
> +
> +/**
> + * @brief Stop the device group and the completion thread.
> + */
> +void qemu_dsa_stop(void);
> +
> +/**
> + * @brief Clean up system resources created for DSA offloading.
> + */
> +void qemu_dsa_cleanup(void);
> +
> +/**
> + * @brief Check if DSA is running.
> + *
> + * @return True if DSA is running, otherwise false.
> + */
> +bool qemu_dsa_is_running(void);
> +
> +#else
> +
> +static inline bool qemu_dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +static inline int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
> +{
> +    if (dsa_parameter != NULL && strlen(dsa_parameter) != 0) {
> +        error_setg(errp, "DSA is not supported.");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline void qemu_dsa_start(void) {}
> +
> +static inline void qemu_dsa_stop(void) {}
> +
> +static inline void qemu_dsa_cleanup(void) {}
> +
> +#endif
> +
> +#endif
> diff --git a/util/dsa.c b/util/dsa.c
> new file mode 100644
> index 0000000000..79dab5d62c
> --- /dev/null
> +++ b/util/dsa.c
> @@ -0,0 +1,280 @@
> +/*
> + * Use Intel Data Streaming Accelerator to offload certain background
> + * operations.
> + *
> + * Copyright (C) Bytedance Ltd.
> + *
> + * Authors:
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/queue.h"
> +#include "qemu/memalign.h"
> +#include "qemu/lockable.h"
> +#include "qemu/cutils.h"
> +#include "qemu/dsa.h"
> +#include "qemu/bswap.h"
> +#include "qemu/error-report.h"
> +#include "qemu/rcu.h"
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")
> +
> +#include <linux/idxd.h>
> +#include "x86intrin.h"
> +
> +#define DSA_WQ_PORTAL_SIZE 4096
> +#define MAX_DSA_DEVICES 16
> +
> +uint32_t max_retry_count;
> +static QemuDsaDeviceGroup dsa_group;
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
> +    dsa_device = mmap(NULL, DSA_WQ_PORTAL_SIZE, PROT_WRITE,
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
> +dsa_device_init(QemuDsaDevice *instance,
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
> +dsa_device_cleanup(QemuDsaDevice *instance)
> +{
> +    if (instance->work_queue != MAP_FAILED) {
> +        munmap(instance->work_queue, DSA_WQ_PORTAL_SIZE);
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
> +dsa_device_group_init(QemuDsaDeviceGroup *group,
> +                      const strList *dsa_parameter,
> +                      Error **errp)
> +{
> +    if (dsa_parameter == NULL) {
> +        error_setg(errp, "dsa device path is not supplied.");
> +        return -1;
> +    }
> +
> +    int ret = 0;
> +    const char *dsa_path[MAX_DSA_DEVICES];
> +    int num_dsa_devices = 0;
> +
> +    while (dsa_parameter) {
> +        dsa_path[num_dsa_devices++] = dsa_parameter->value;
> +        if (num_dsa_devices == MAX_DSA_DEVICES) {
> +            break;
> +        }
> +        dsa_parameter = dsa_parameter->next;
> +    }
> +
> +    group->dsa_devices =
> +        g_new0(QemuDsaDevice, num_dsa_devices);
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
> +            error_setg(errp, "map_dsa_device failed MAP_FAILED.");

This will assert if it fails in more than one iteration, errp cannot be
set twice. You'll have to test 'ret' outside of the loop before
returning and set the error there.

> +            ret = -1;
> +        }
> +        dsa_device_init(&group->dsa_devices[i], dsa_wq);
> +    }
> +
> +    return ret;
> +}
> +
> +/**
> + * @brief Starts a DSA device group.
> + *
> + * @param group A pointer to the DSA device group.
> + */
> +static void
> +dsa_device_group_start(QemuDsaDeviceGroup *group)
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
> +dsa_device_group_stop(QemuDsaDeviceGroup *group)
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
> +dsa_device_group_cleanup(QemuDsaDeviceGroup *group)
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
> + * @return struct QemuDsaDevice* A pointer to the next available DSA device
> + *         in the group.
> + */
> +__attribute__((unused))
> +static QemuDsaDevice *
> +dsa_device_group_get_next_device(QemuDsaDeviceGroup *group)
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
> +bool qemu_dsa_is_running(void)
> +{
> +    return false;
> +}
> +
> +static void
> +dsa_globals_init(void)
> +{
> +    max_retry_count = UINT32_MAX;
> +}
> +
> +/**
> + * @brief Initializes DSA devices.
> + *
> + * @param dsa_parameter A list of DSA device path from migration parameter.
> + *
> + * @return int Zero if successful, otherwise non zero.
> + */
> +int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
> +{
> +    dsa_globals_init();
> +
> +    return dsa_device_group_init(&dsa_group, dsa_parameter, errp);
> +}
> +
> +/**
> + * @brief Start logic to enable using DSA.
> + *
> + */
> +void qemu_dsa_start(void)
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
> +void qemu_dsa_stop(void)
> +{
> +    QemuDsaDeviceGroup *group = &dsa_group;
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
> +void qemu_dsa_cleanup(void)
> +{
> +    qemu_dsa_stop();
> +    dsa_device_group_cleanup(&dsa_group);
> +}
> +
> diff --git a/util/meson.build b/util/meson.build
> index 5d8bef9891..5ec2158f9e 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -123,6 +123,9 @@ if cpu == 'aarch64'
>    util_ss.add(files('cpuinfo-aarch64.c'))
>  elif cpu in ['x86', 'x86_64']
>    util_ss.add(files('cpuinfo-i386.c'))
> +  if config_host_data.get('CONFIG_DSA_OPT')
> +    util_ss.add(files('dsa.c'))
> +  endif
>  elif cpu == 'loongarch64'
>    util_ss.add(files('cpuinfo-loongarch.c'))
>  elif cpu in ['ppc', 'ppc64']

