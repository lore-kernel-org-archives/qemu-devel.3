Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB4EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFSH-0002Uy-Ef; Wed, 12 Feb 2025 11:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiFSC-0002TT-50
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiFS9-0006z1-IW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739377146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FncJJP+n8BZMw+1jQRe74qU46zVeKTPiZiDq7BS3W7E=;
 b=KtcxdK60FElJlp0UIEfYWwErNjRRVixCcYhV5rhKeE2TWPeJMcKAyNsJI0yDk1zfEnh4oG
 N6ygaJgPFsaMhu0MgTYRnDMK6sp+PDLuCn6V8ToIVlbJzNykUgTdOddPs45jvvcXQeSXG/
 MsXB79OJ9arITaT3IxlehFdDMYlL2eE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-XV09ZLUkOZylgCWhjhJ72Q-1; Wed, 12 Feb 2025 11:19:04 -0500
X-MC-Unique: XV09ZLUkOZylgCWhjhJ72Q-1
X-Mimecast-MFC-AGG-ID: XV09ZLUkOZylgCWhjhJ72Q
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dc56ef418so2819153f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377143; x=1739981943;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FncJJP+n8BZMw+1jQRe74qU46zVeKTPiZiDq7BS3W7E=;
 b=f0p8ImlqHryG/RQaEkMk0QRUxUsShtcI8jlT6f+8ltzRJHSV0V3ogmx8P2hqSQKTh+
 xXfZOn2++yLQRvJifp/cp2ypBM85xX+D0i8w32+kv5NvqMdetDOblQ7PB/qYfwr5BAY7
 djlA3uMZWckgD209nXzw3c8Z/YD4XWvYnMx7+horhgCKAmSkQeqFansD+dX6Tx4lze02
 7ypbXBJLJFxG2+CEgjRByJJwYr3MSSQIpfYUdlftVL9n184jE2+43eGDO1uVh5fjVCoB
 tzAfy7BtFtnaV0zfUSZ7nMlSNNgyE2IC1WXBO1/v5vS3V3iybcgNWZKKeosqYdmcCxui
 Oo4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXig1MTcCQCGk+A2RY3WqLvdlXLWULCKPEAH8ej7mw1txvRYVsd5Xfo/gU4kB41BNyA21NRnS+wAUSg@nongnu.org
X-Gm-Message-State: AOJu0Yz3ekmH65RqKwBwo5ACsrjK5QSz9ooWS4es2SJf10QVtPxTg1J8
 9uhFIIVQf58m+PKybwwKZElYq3jTXobZwweTkyy9mnjvdxgnv28RgXGutkfn1eP4iG4Vyo3WyXI
 HVt4lBAGB9WwYCIWN64yEXOkkFw80NQOv3eErX0eiDL9uSAHCMxKY
X-Gm-Gg: ASbGncvtI0zO91Q2/Wr/AX49+tz6K+tV4rZJpnyTA3/MhGwJPDCcgrD0oHcKml1WGu3
 d8gbxQyE2jL/SPZ3c16wOG8kw4centp0I4SeOjlt43D8ueKNrksNEN9voJqu0u3nrYFvybWFJIn
 XdaVQRYi3YEOaHCbhEW6PZImlNEHhpuDTQgHynMjJ1I218bgzaifXPaml2/WBPsN8dqBeYFz1B1
 v+5hxxwmLU/YrQY74wifs9Ah5b7BMMRTTKotpx6AmYiC7/zoSdyLWXIAg7hyqmZX8+up9v55YOr
 3sZfEwJXpH1Szpg6Mp6p7WHspFb3Z1ertg8CxXk+WLs=
X-Received: by 2002:a05:6000:2cb:b0:38d:eb22:b12e with SMTP id
 ffacd0b85a97d-38deb22b262mr3013643f8f.13.1739377142812; 
 Wed, 12 Feb 2025 08:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9A1ZJuJ9o0lYjuLEH9s+SHi1m8bxbUr6zihinQGq4F2aN4Ndxr9FAJIV5oSmpvEgfKOZxPA==
X-Received: by 2002:a05:6000:2cb:b0:38d:eb22:b12e with SMTP id
 ffacd0b85a97d-38deb22b262mr3013615f8f.13.1739377142409; 
 Wed, 12 Feb 2025 08:19:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcaf3e4bcsm14854786f8f.41.2025.02.12.08.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:19:01 -0800 (PST)
Message-ID: <0fff5a27-7e52-4f00-af65-46f4cf025f4f@redhat.com>
Date: Wed, 12 Feb 2025 17:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/33] vfio/migration: Multifd device state transfer
 support - load thread
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <3e1708a19ab743441a4771a8868043887ea4543c.1738171076.git.maciej.szmigiero@oracle.com>
 <da120a2a-a906-48be-a20e-8cd570a5c0b6@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <da120a2a-a906-48be-a20e-8cd570a5c0b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/12/25 16:48, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Since it's important to finish loading device state transferred via the
>> main migration channel (via save_live_iterate SaveVMHandler) before
>> starting loading the data asynchronously transferred via multifd the thread
>> doing the actual loading of the multifd transferred data is only started
>> from switchover_start SaveVMHandler.
>>
>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>>
>> This sub-command is only sent after all save_live_iterate data have already
>> been posted so it is safe to commence loading of the multifd-transferred
>> device state upon receiving it - loading of save_live_iterate data happens
>> synchronously in the main migration thread (much like the processing of
>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>> processed all the proceeding data must have already been loaded.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c  | 229 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |   5 +
>>   2 files changed, 234 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 0c0caec1bd64..ab5b097f59c9 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -301,8 +301,16 @@ typedef struct VFIOStateBuffer {
>>   } VFIOStateBuffer;
>>   typedef struct VFIOMultifd {
>> +    QemuThread load_bufs_thread;
>> +    bool load_bufs_thread_running;
>> +    bool load_bufs_thread_want_exit;
>> +
>> +    bool load_bufs_iter_done;
>> +    QemuCond load_bufs_iter_done_cond;
>> +
>>       VFIOStateBuffers load_bufs;
>>       QemuCond load_bufs_buffer_ready_cond;
>> +    QemuCond load_bufs_thread_finished_cond;
>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>       uint32_t load_buf_idx;
>>       uint32_t load_buf_idx_last;
>> @@ -449,6 +457,171 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>       return true;
>>   }
>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>> +{
>> +    VFIOStateBuffer *lb;
>> +    guint bufs_len;
>> +
>> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
>> +    if (multifd->load_buf_idx >= bufs_len) {
>> +        assert(multifd->load_buf_idx == bufs_len);
>> +        return NULL;
>> +    }
>> +
>> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
>> +                               multifd->load_buf_idx);
>> +    if (!lb->is_present) {
>> +        return NULL;
>> +    }
>> +
>> +    return lb;
>> +}
>> +
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    return -EINVAL;
>> +}
>> +
>> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>> +                                         VFIOStateBuffer *lb,
>> +                                         Error **errp)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    g_autofree char *buf = NULL;
>> +    char *buf_cur;
>> +    size_t buf_len;
>> +
>> +    if (!lb->len) {
>> +        return true;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>> +                                                   multifd->load_buf_idx);
>> +
>> +    /* lb might become re-allocated when we drop the lock */
>> +    buf = g_steal_pointer(&lb->data);
>> +    buf_cur = buf;
>> +    buf_len = lb->len;
>> +    while (buf_len > 0) {
>> +        ssize_t wr_ret;
>> +        int errno_save;
>> +
>> +        /*
>> +         * Loading data to the device takes a while,
>> +         * drop the lock during this process.
>> +         */
>> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
>> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);
>> +        errno_save = errno;
>> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
>> +
>> +        if (wr_ret < 0) {
>> +            error_setg(errp,
>> +                       "writing state buffer %" PRIu32 " failed: %d",
>> +                       multifd->load_buf_idx, errno_save);
>> +            return false;
>> +        }
>> +
>> +        assert(wr_ret <= buf_len);
>> +        buf_len -= wr_ret;
>> +        buf_cur += wr_ret;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>> +                                                 multifd->load_buf_idx);
>> +
>> +    return true;
>> +}
>> +
>> +static bool vfio_load_bufs_thread_want_abort(VFIOMultifd *multifd,
>> +                                             bool *should_quit)
>> +{
>> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
>> +}
> 
> _abort or _exit or _quit ? I would opt for vfio_load_bufs_thread_want_exit()
> to match multifd->load_bufs_thread_want_exit.
> 
> 
>> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    bool ret = true;
>> +    int config_ret;
>> +
>> +    assert(multifd);
>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>> +
>> +    assert(multifd->load_bufs_thread_running);
>> +
>> +    while (!vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +        VFIOStateBuffer *lb;
>> +
>> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
>> +
>> +        lb = vfio_load_state_buffer_get(multifd);
>> +        if (!lb) {
>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>> +                                                        multifd->load_buf_idx);
>> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
>> +                           &multifd->load_bufs_mutex);
>> +            continue;
>> +        }
>> +
>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
>> +            break;
>> +        }
>> +
>> +        if (multifd->load_buf_idx == 0) {
>> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
>> +        }
>> +
>> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
>> +            ret = false;
>> +            goto ret_signal;
>> +        }
>> +
>> +        assert(multifd->load_buf_queued_pending_buffers > 0);
>> +        multifd->load_buf_queued_pending_buffers--;
>> +
>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>> +        }
>> +
>> +        multifd->load_buf_idx++;
>> +    }
>> +
>> +    if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +        error_setg(errp, "operation cancelled");
>> +        ret = false;
>> +        goto ret_signal;
>> +    }
>> +
>> +    if (vfio_load_config_after_iter(vbasedev)) {
>> +        while (!multifd->load_bufs_iter_done) {
>> +            qemu_cond_wait(&multifd->load_bufs_iter_done_cond,
>> +                           &multifd->load_bufs_mutex);
>> +
>> +            if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
>> +                error_setg(errp, "operation cancelled");
>> +                ret = false;
>> +                goto ret_signal;
>> +            }
>> +        }
>> +    }
> 
> Please put the above chunck at the end of the series with the patch
> adding ARM support. I think load_bufs_iter_done_cond should be moved
> out of this patch too.
> 
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
>> +    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
>> +    if (config_ret) {
>> +        error_setg(errp, "load config state failed: %d", config_ret);
>> +        ret = false;
>> +    }
>> +
>> +ret_signal:
>> +    multifd->load_bufs_thread_running = false;
>> +    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
>> +
>> +    return ret;
>> +}
>> +
>>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>>                                            Error **errp)
>>   {
>> @@ -517,11 +690,40 @@ static VFIOMultifd *vfio_multifd_new(void)
>>       multifd->load_buf_queued_pending_buffers = 0;
>>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>> +    multifd->load_bufs_iter_done = false;
>> +    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
>> +
>> +    multifd->load_bufs_thread_running = false;
>> +    multifd->load_bufs_thread_want_exit = false;
>> +    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
>> +
>>       return multifd;
>>   }
>> +static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
>> +{
>> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>> +    bql_unlock();
>> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>> +        while (multifd->load_bufs_thread_running) {
>> +            multifd->load_bufs_thread_want_exit = true;
>> +
>> +            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>> +            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
>> +            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
>> +                           &multifd->load_bufs_mutex);
>> +        }
>> +    }
>> +    bql_lock();
>> +}
>> +
>>   static void vfio_multifd_free(VFIOMultifd *multifd)
>>   {
>> +    vfio_load_cleanup_load_bufs_thread(multifd);
>> +
>> +    qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
>> +    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
>> +    vfio_state_buffers_destroy(&multifd->load_bufs);
>>       qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
>>       qemu_mutex_destroy(&multifd->load_bufs_mutex);
>> @@ -1042,6 +1244,32 @@ static bool vfio_switchover_ack_needed(void *opaque)
>>       return vfio_precopy_supported(vbasedev);
>>   }
>> +static int vfio_switchover_start(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +
>> +    if (!migration->multifd_transfer) {
>> +        /* Load thread is only used for multifd transfer */
>> +        return 0;
>> +    }
>> +
>> +    assert(multifd);
>> +
>> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>> +    bql_unlock();
>> +    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>> +        assert(!multifd->load_bufs_thread_running);
>> +        multifd->load_bufs_thread_running = true;
>> +    }
>> +    bql_lock();
>> +
>> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);

and please move these changes under a vfio_multifd_switchover_start()
routine.


Thanks,

C.



>> +    return 0;
>> +}
>> +
>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>       .save_prepare = vfio_save_prepare,
>>       .save_setup = vfio_save_setup,
>> @@ -1057,6 +1285,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>>       .load_state = vfio_load_state,
>>       .load_state_buffer = vfio_load_state_buffer,
>>       .switchover_ack_needed = vfio_switchover_ack_needed,
>> +    .switchover_start = vfio_switchover_start,
>>   };
>>   /* ---------------------------------------------------------------------- */
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 042a3dc54a33..418b378ebd29 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -154,6 +154,11 @@ vfio_load_device_config_state_end(const char *name) " (%s)"
>>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
>>   vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
>> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>>   vfio_migration_realize(const char *name) " (%s)"
>>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
>>
> 


