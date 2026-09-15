Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FDAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Q4b-00024G-0M; Tue, 15 Sep 2026 06:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6Q4Y-00023u-AE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6Q4U-0008IP-LO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789466843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpYjQtlKOa2RSRwrkcH0QknYGpTJVz6c5LjqmvPDU1M=;
 b=F3+4mY59y1qrLm7uQ+K+/ElkDVAhg8+lrg4suL15mw2SI2RA5MaeRIF1HlHEM8VHAt0ioG
 RZi/WCqpVh1JnxyRByMlS6sCqqQAfL1hdv7ynr5/iv54sEPzgS4BquLT260t6ajLiGfQur
 P3cu9V98m5FP4VC61G7Np02Mk75vySk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-q1a3JKeNPMa2sz_cu-lWeA-1; Tue, 15 Sep 2026 06:07:22 -0400
X-MC-Unique: q1a3JKeNPMa2sz_cu-lWeA-1
X-Mimecast-MFC-AGG-ID: q1a3JKeNPMa2sz_cu-lWeA_1789466841
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f3dbf7d2so2805342f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789466841; x=1790071641; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YpYjQtlKOa2RSRwrkcH0QknYGpTJVz6c5LjqmvPDU1M=;
 b=Wmwsi0msdTq6seOF6zVp1dmQNY+9EbSLXZaE6tT4V5Iz5/RulS9dtud5VUzXL6vax3
 8naRUwaIFDQOybup3AWRQ+GnehwCQj7AnVFcxAt7oBel+MjjIPFXRfoi2uRdljFMV1u7
 9wrcRZo0Eempo0DQr0vGWj53b63/2tT9okR8cvl7Ev8mrmcUeRY3H2/Fi5Ssek7YkWYJ
 J75yE0oMla0NEygsaxiTZrcesy1O+EqVfn26i2WWe04y32CIcPCIb/Y/8CBJbSYQZxS1
 vKrzmrCe2JOSX8vGBx7K4I04D/Khw+I5Wd5ZKk8xk3AauVRcSFfWjj33uzdkWQT73LLI
 aQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789466841; x=1790071641;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YpYjQtlKOa2RSRwrkcH0QknYGpTJVz6c5LjqmvPDU1M=;
 b=uUQxTWmf6O4lT0zXPqkMFbh71vD26ui1pugtiya6L0WwdxulcJLGiumOq3vcjmc4LU
 YJpPlXAmUhYTxwKSz3R+0MqrSND2KK5re7d8/J5+eSkHi4hDgb1rxOTCNKRvst6HJjHx
 bs/2+JKYrmvrXK9MAhY3tK3izl6M+Qy5AZA0czeWOOgfiY+a5JjSOVVDZ8mrrtbHYJ02
 A+2P4k+fqbwdk698MBvnTgBA60bmgAqB1kHvk9AWm8XDoAIkeyzOZ+QRRG9MYL49J1nj
 nw4f7xs1dflFmrqATSURBTQ1RIPOReoHn3S1+I7XfKH9YbZV58uATyjJmWzz8LUhgXwg
 tofg==
X-Gm-Message-State: AFuF++knVVQ3z/jQ+hd1KAxLyRRfLbLLBa6AVJx/f2xVuCrsFN62iF+V
 cEXoo1b+LFkSyS9La6jZUuRzSrUPzCQu/gvZxD2QJiahMs5idvhIaGXesLu/Yi4eAh5kqOt4A2S
 ubrXhzwpnHZkIp1rZqiQ/QgnmF1ZOuqn8h7Cf5m3RZtr0cHPQ4tPEsdWh
X-Gm-Gg: AYBFou35dr4EfUX7OrNcrwNU0nEu2mkLzJ4v+Hu4LZdvw7LVh5qODHAjv54wnFE4feU
 FFSbEdHe/eIOLzmIUye1ru9t4ZJkIGpCdd7WkGguGCNr/1d9NDB6NKFlSOcnGzuTBaj+rVwaFTo
 wushuMS81/o9jhocnZ2sUNs85Y1meumpZZDAEf7oJ/wQ6ZY4kBl8Q6KakaxR48GBSOc5+9hozWz
 Iwj1+tD682FevOTBVxEYFAPSocV92H4MUycv/YGUoh0gP0GYXBECpJ0yLePvga7TRu42+CPsrg6
 icYnixUP+2yYqC2RBBJtE+nMcd50k4g4apS3h8THERCZJzI8fJt/ucIqKLY2bABSfdUKrITT5Xd
 885Shz6ofxla0jPgD/q82VY5S66KBYDUdK0LjaVtKj/ePDA==
X-Received: by 2002:a5d:5e91:0:b0:487:947:db89 with SMTP id
 ffacd0b85a97d-4870a9e384bmr30838f8f.36.1789466841243; 
 Tue, 15 Sep 2026 03:07:21 -0700 (PDT)
X-Received: by 2002:a5d:5e91:0:b0:487:947:db89 with SMTP id
 ffacd0b85a97d-4870a9e384bmr30776f8f.36.1789466840657; 
 Tue, 15 Sep 2026 03:07:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm34537140f8f.19.2026.09.15.03.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:07:20 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:07:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqkXTbt49bPJW7R7@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
 <aqgQYmbLk6O1Af7I@sgarzare-redhat>
 <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 15, 2026 at 12:56:11PM +0300, Andrey Drobyshev wrote:
>On 9/14/26 6:36 PM, Stefano Garzarella wrote:
>> On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:

[...]

>>> @@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>> }
>>>
>>> +static int vhost_vsock_pre_save(void *opaque)
>>> +{
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>> +    int ret;
>>> +
>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    /*
>>> +     * Release the device ownership now for CPR migration.  The device is
>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>> +     * VHOST_SET_OWNER in post_load.
>>> +     */
>>> +    if (cpr_incoming_needed(NULL) && migration_is_running()) {
>>
>> Should we also check if vsock->owner_reset is already true?
>> Or it can never happen?
>
>Actually you're right, and we should also guard the RESET_OWNER op by
>!vsock->owner_reset.  If we fail somewhere after .pre_save() and the VM
>was stop before migration - we don't call set_status() just yet, so the
>device ownership isn't re-aquired, and a subsequent CPR attempt would
>fail here. I didn't think of such a case, thanks for noticing.

oh, right! Thanks for checking!

>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>> +        if (ret < 0) {
>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>>> +                         strerror(-ret));
>>> +            return ret;
>>> +        }
>>> +        vsock->owner_reset = true;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>> {
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>>> +    Error *local_err = NULL;
>>> +    int vhostfd, ret;
>>> +
>>>     /*
>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>      * guest cid is unchanged, and the cid-change reset would otherwise

[...]

>>> @@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>     }
>>>
>>>     /*
>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>> -     * device ownership is not handed over, so the target fails to set
>>> -     * up its device.  Fail the migration early and gracefully instead.
>>> +     * With the ownership handoff in place CPR migration is now supported.
>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>> +     * we only keep the migration blocker for the ID-less case.
>>>      */
>>> -    error_setg(&vsock->migration_blocker,
>>> -               "vhost-vsock: CPR migration is not supported");
>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>> -        return;
>>> +    if (!proxy->id) {
>>
>> Ditto about using `cpr_name` here.
>
>Agreed.
>> The rest LGTM!
>>
>> Thanks,
>> Stefano
>>
>>
>>> +        error_setg(&vsock->migration_blocker,
>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>> +            return;
>>> +        }
>>>     }
>
>There's an interesting consequence of adopting qdev_get_dev_path().
>IIUC vhost-vsock device inherits from virtio device and is always
>attached to a device which is virtio device.  Then in qdev_get_dev_path():
>
>    bc = BUS_GET_CLASS(dev->parent_bus);
>
>    if (bc->get_dev_path) {
>
>        return bc->get_dev_path(dev);
>
>    }
>
>And all virtio buses, namely: virtio-pci-bus, virtio-mmio-bus,
>virtio-ccw-bus - implement their own .get_dev_path().
>
>This essentially means that for vhost-vsock device qdev_get_dev_path()
>can never return NULL.  This in turn means that our migration blocker
>which is now guarded by proxy->id can be entirely dropped.  We can just
>always allow CPR migration and simply do `g_assert(cpr_name)` whenever
>we obtain that name, as it's expected to never be NULL.
>
>I'll try adopting that approach, unless you have any objections.

No objetions!

I haven't looked closely at `qdev_get_dev_path()`. Can you check if it
includes the device type (or the id) in the path, or should we add a
suffix?

Let me explain: I'd like to prevent other devices from conflicting in
the future, so if we use “vhost-vsock” as the suffix, we should be fine,
but I haven't checked carefully what it returns, so maybe it's already
there.

Thanks,
Stefano


