Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ABAC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwPO-0006OB-JB; Fri, 28 Feb 2025 04:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnwPN-0006O1-Au
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnwPK-0007Ii-PI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740733905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vwG9ampV1bHf3n9HzdjYItvbGjhysvwCFD+kMBeN2zw=;
 b=QHl2QvsQZxvLqq+zpg+kHwkH1GHfAneRJvx2Jirf7ppr3PQrVJyUk0R9hgGl3gSPK6ZlBQ
 AusmGNPsR98PGT9TjEjkafYIL3IGC9STHlTTzXSI1NpJ63hVYh+8Vzk3a5LgQUijsf6Eo0
 Yomwjz8IhLmtm8zIe+ZTzCr8T7U0KuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-tXOgQdX4OSuiPvt97I6iaw-1; Fri, 28 Feb 2025 04:11:42 -0500
X-MC-Unique: tXOgQdX4OSuiPvt97I6iaw-1
X-Mimecast-MFC-AGG-ID: tXOgQdX4OSuiPvt97I6iaw_1740733902
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so9881805e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 01:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733901; x=1741338701;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwG9ampV1bHf3n9HzdjYItvbGjhysvwCFD+kMBeN2zw=;
 b=XaOJkEzj45DWoxPhNaeEvhK0Hq+oBpEGv5q7H5O99/lfoX3OnImbIvp3BIc4V1+e2L
 +obiu4I7G9x84uzMECYN9uZjd9BIRK2YqgZaB+YhQ19C3WYTZnCEVE5OpODWmGOARLM/
 8uwIZi1Sb+X8y1Wx5I4Py6+t4u0s/T0D6g3VoDBsTEcgzeMMsOJxlwzRsQ8fVu6jMM3j
 F/fKMZYBvabVSts7tq7+WclLBxLq+mW+Lu6quSTVt1tu/KihuxRc/yVF7CEdLlMrKCJE
 BD6xZ4S4u2q9+xtW3z8yf2RNEExe0Yg8/k24CjzUmIyofzdRsWlyy9ItGW5539cAJex/
 PSVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNf3zmRbnnlfbc1yacVR3Jv0jd1BACOhPY2UAGqL8/ZnJmJP3JTSadFb62YiRH3n7CeWpOiOeWBgU5@nongnu.org
X-Gm-Message-State: AOJu0Yy1AVU53WsKGXUxHLsHpTgGUACiYWya0SU4/3Slsjxa2JekauaG
 mH7kIHOpyJSHXJzkdKsjd8DvPLpok7ajWqOWY1c4hZNurYhDTrRDPUDi8S9kjr4Xspi54qqGM7k
 yDmxWBPY1Dljvr7wUcozUppdGI9SKCPqBMbdSqfFvjUjw51Jv0/EZ
X-Gm-Gg: ASbGnctPsFi95lj23nj1JS31/N21yoyuy68NAEd1JWoipFISaBwTGKmI2ttfnBkzyvt
 ju96kxpSO5TgnUupPJK8A96s3/I7KuTz8JaX801JdpdbB/L9yWdr7YevpS9tOoO0mR7fYBznWML
 8AY2DzhqkTvJ35iXKf7sFzKFmy+QaX8JAUnpK71OSWptjEcn4FqWuGWlRmufavRQ6xCMkCTxGG0
 ZsKHiIi9xHMDO+PmDyQATr5rQ1UTBFCoWLuFqOipE1/WhUov23D5ahYCYHDhfUUb2W2X8cdk8ti
 R+nUtArbUAsviinHPU52I3E2H953ea1z3iDQkYQAQACDmbYfPDZFMCaXrbY=
X-Received: by 2002:a05:600c:1c25:b0:439:5a37:8157 with SMTP id
 5b1f17b1804b1-43ba6774a03mr20992675e9.30.1740733901494; 
 Fri, 28 Feb 2025 01:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ957yPMUkGbQV0/wr8l8dZQUnO6B9pdlcg0WFGiYirmoFgNOEduITImC0L2pJjT4rA/uelw==
X-Received: by 2002:a05:600c:1c25:b0:439:5a37:8157 with SMTP id
 5b1f17b1804b1-43ba6774a03mr20992315e9.30.1740733901058; 
 Fri, 28 Feb 2025 01:11:41 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4847fe5sm4604374f8f.73.2025.02.28.01.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 01:11:40 -0800 (PST)
Message-ID: <9659a377-0132-4449-8592-1c8ef8b2d8d0@redhat.com>
Date: Fri, 28 Feb 2025 10:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/36] vfio/migration: Multifd device state transfer
 support - load thread
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <9be8882ea2189c1a827bdf09835d6c65488d2ca6.1739994627.git.maciej.szmigiero@oracle.com>
 <573fab5e-4c0f-416c-bbd0-4786ad25e18f@redhat.com>
 <438ee2cb-d29a-4975-806e-2e2f2dff1a44@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <438ee2cb-d29a-4975-806e-2e2f2dff1a44@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/26/25 22:05, Maciej S. Szmigiero wrote:
> On 26.02.2025 14:49, Cédric Le Goater wrote:
>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Since it's important to finish loading device state transferred via the
>>> main migration channel (via save_live_iterate SaveVMHandler) before
>>> starting loading the data asynchronously transferred via multifd the thread
>>> doing the actual loading of the multifd transferred data is only started
>>> from switchover_start SaveVMHandler.
>>>
>>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>>> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>>>
>>> This sub-command is only sent after all save_live_iterate data have already
>>> been posted so it is safe to commence loading of the multifd-transferred
>>> device state upon receiving it - loading of save_live_iterate data happens
>>> synchronously in the main migration thread (much like the processing of
>>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>>> processed all the proceeding data must have already been loaded.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration-multifd.c | 225 ++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/migration-multifd.h |   2 +
>>>   hw/vfio/migration.c         |  12 ++
>>>   hw/vfio/trace-events        |   5 +
>>>   4 files changed, 244 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index 5d5ee1393674..b3a88c062769 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -42,8 +42,13 @@ typedef struct VFIOStateBuffer {
>>>   } VFIOStateBuffer;
>>>   typedef struct VFIOMultifd {
>>> +    QemuThread load_bufs_thread;
>>> +    bool load_bufs_thread_running;
>>> +    bool load_bufs_thread_want_exit;
>>> +
>>>       VFIOStateBuffers load_bufs;
>>>       QemuCond load_bufs_buffer_ready_cond;
>>> +    QemuCond load_bufs_thread_finished_cond;
>>>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>>>       uint32_t load_buf_idx;
>>>       uint32_t load_buf_idx_last;
>>> @@ -179,6 +184,175 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>>       return true;
>>>   }
>>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>>> +{
>>> +    return -EINVAL;
>>> +}
>>
>>
>> please move to next patch.
> 
> As I wrote on the previous version of the patch set at
> https://lore.kernel.org/qemu-devel/4f335de0-ba9f-4537-b230-2cf8af1c160b@maciej.szmigiero.name/:
>> The dummy call has to be there, otherwise the code at the
>> previous commit time wouldn't compile since that
>> vfio_load_bufs_thread_load_config() call is a part of
>> vfio_load_bufs_thread().
>>
>> This is an artifact of splitting the whole load operation in
>> multiple commits.
> 
> I think adding empty dummy implementations is the typical way
> to do this - much like you asked today to leave
> vfio_multifd_transfer_setup() returning true unconditionally
> before being filled with true implementation in later patch.
> 
> See also my response at the end of this e-mail message, below
> the call to vfio_load_bufs_thread_load_config().
> 
>>> +static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
>>> +{
>>> +    VFIOStateBuffer *lb;
>>> +    guint bufs_len;
>>
>> guint:  I guess it's ok to use here. It is not common practice in VFIO.
>>
>>> +
>>> +    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
>>> +    if (multifd->load_buf_idx >= bufs_len) {
>>> +        assert(multifd->load_buf_idx == bufs_len);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&multifd->load_bufs,
>>> +                               multifd->load_buf_idx);
>>
>> Could be one line. minor.
>>
>>> +    if (!lb->is_present) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return lb;
>>> +}
>>> +
>>> +static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>>> +                                         VFIOStateBuffer *lb,
>>> +                                         Error **errp)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    g_autofree char *buf = NULL;
>>> +    char *buf_cur;
>>> +    size_t buf_len;
>>> +
>>> +    if (!lb->len) {
>>> +        return true;
>>> +    }
>>> +
>>> +    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>>> +                                                   multifd->load_buf_idx);
>>
>> I thin we can move this trace event to vfio_load_bufs_thread()
> 
> It would get messy since we don't load empty buffers,
> so we we don't print this trace point (and its _end sibling)
> for empty buffers.
> 
> If we print this in vfio_load_bufs_thread() then it would
> need to duplicate that !lb->len check.
> 
>>> +    /* lb might become re-allocated when we drop the lock */
>>> +    buf = g_steal_pointer(&lb->data);
>>> +    buf_cur = buf;
>>> +    buf_len = lb->len;
>>> +    while (buf_len > 0) {
>>> +        ssize_t wr_ret;
>>> +        int errno_save;
>>> +
>>> +        /*
>>> +         * Loading data to the device takes a while,
>>> +         * drop the lock during this process.
>>> +         */
>>> +        qemu_mutex_unlock(&multifd->load_bufs_mutex);
>>> +        wr_ret = write(migration->data_fd, buf_cur, buf_len);> +        errno_save = errno;
>>> +        qemu_mutex_lock(&multifd->load_bufs_mutex);
>>> +
>>> +        if (wr_ret < 0) {
>>> +            error_setg(errp,
>>> +                       "writing state buffer %" PRIu32 " failed: %d",
>>> +                       multifd->load_buf_idx, errno_save);
>>> +            return false;
>>> +        }
>>> +
>>> +        assert(wr_ret <= buf_len);
>>> +        buf_len -= wr_ret;
>>> +        buf_cur += wr_ret;
>>> +    }
>>> +
>>> +    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>>> +                                                 multifd->load_buf_idx);
>>
>> and drop this trace event.
> 
> That's important data since it provides for how long it took to load that
> buffer (_end - _start).
> 
> It's not the same information as _start(next buffer) - _start(current buffer)
> since the next buffer might not have arrived yet so its loading won't
> start immediately after the end of loading of the previous one.
> 
>> In which case, we can modify the parameters of vfio_load_state_buffer_write()
>> to use directly a 'VFIOMultifd *multifd'and an fd instead of "migration->data_fd".
>>
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
>>> +                                            bool *should_quit)
>>> +{
>>> +    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
>>> +}
>>> +
>>> +/*
>>> + * This thread is spawned by vfio_multifd_switchover_start() which gets
>>> + * called upon encountering the switchover point marker in main migration
>>> + * stream.
>>> + *
>>> + * It exits after either:
>>> + * * completing loading the remaining device state and device config, OR:
>>> + * * encountering some error while doing the above, OR:
>>> + * * being forcefully aborted by the migration core by it setting should_quit
>>> + *   or by vfio_load_cleanup_load_bufs_thread() setting
>>> + *   multifd->load_bufs_thread_want_exit.
>>> + */
>>> +static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOMultifd *multifd = migration->multifd;
>>> +    bool ret = true;
>>> +    int config_ret;
>>
>> No needed IMO. see below.
>>
>>> +
>>> +    assert(multifd);
>>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>>> +
>>> +    assert(multifd->load_bufs_thread_running);
>>
>> We could add a trace event for the start and the end of the thread.
> 
> Added vfio_load_bufs_thread_{start,end} trace events now.
> 
>>> +    while (true) {
>>> +        VFIOStateBuffer *lb;
>>> +
>>> +        /*
>>> +         * Always check cancellation first after the buffer_ready wait below in
>>> +         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
>>> +         */
>>> +        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
>>> +            error_setg(errp, "operation cancelled");
>>> +            ret = false;
>>> +            goto ret_signal;
>>
>> goto thread_exit ?
> 
> I'm not sure that I fully understand this comment.
> Do you mean to rename ret_signal label to thread_exit?


Yes. I find label 'thread_exit' more meaning full. This is minor since
there is only one 'exit' label.

> 
>>> +        }
>>> +
>>> +        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
>>> +
>>> +        lb = vfio_load_state_buffer_get(multifd);
>>> +        if (!lb) {
>>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>>> +                                                        multifd->load_buf_idx);
>>> +            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
>>> +                           &multifd->load_bufs_mutex);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
>>> +            break;
>>> +        }
>>> +
>>> +        if (multifd->load_buf_idx == 0) {
>>> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
>>> +        }
>>> +
>>> +        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
>>> +            ret = false;
>>> +            goto ret_signal;
>>> +        }
>>> +
>>> +        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>>> +        }
>>> +
>>> +        multifd->load_buf_idx++;
>>> +    }
>>
>> if ret is assigned to true here, the "ret = false" can dropped
> 
> I inverted the "ret" logic here now - initialized ret to false
> at definition, removed "ret = false" at every failure/early exit block
> and added "ret = true" just before the "ret_signal" label.
> 
>>> +    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
>>> +    if (config_ret) {
>>> +        error_setg(errp, "load config state failed: %d", config_ret);
>>> +        ret = false;
>>> +    }
>>
>> please move to next patch. This is adding nothing to this patch
>> since it's returning -EINVAL.
>>
> 
> That's the whole point - if someone were to accidentally enable this
> (for example by forgetting to apply the next patch when backporting
> the series) it would fail safely with EINVAL instead of having a
> half-broken implementation.

OK. Let's keep it that way.


Thanks,

C.


> 
> Another option would be to simply integrate the next patch into this
> one as these are two parts of the same single operation and I think
> splitting them in two in the end brings little value.
> 
>> Thanks,
>>
>> C.
> 
> Thanks,
> Maciej
> 


