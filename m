Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4EC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Sjm-0006dy-6r; Tue, 15 Sep 2026 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6SjF-0006Up-80
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6Siw-0002iE-38
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789477039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUUeWv0d9UxvFkMkF4Q4KdOVnHwWeCzEKKTGT61D4Vk=;
 b=CwCOYIX1x+TbrwCcOgcJVUNf5naAeUUUjs6SKkFEu7Kj/wygLbQ3thFogEoP4MvW/PXRZ2
 m2ZNumoqUqM10rQuBQCYqyYL+O6JCAqXjwqdc2oyWNycKjqJADGhIGA12j4xqVVEzq5wqL
 7GU7hf4fwc3LDOqWa45u1ESlszH6PHQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-jjp23BB2PF2p1fjznkDsBg-1; Tue, 15 Sep 2026 08:56:14 -0400
X-MC-Unique: jjp23BB2PF2p1fjznkDsBg-1
X-Mimecast-MFC-AGG-ID: jjp23BB2PF2p1fjznkDsBg_1789476973
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a1e3cfc8d3so4673965a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789476973; x=1790081773; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUUeWv0d9UxvFkMkF4Q4KdOVnHwWeCzEKKTGT61D4Vk=;
 b=Xebdbj7/fLsLsFkPnZN7nqAxbO7i1zZGH82bmrv/M+Iy5IpnFh7mgIkXX9ks7pvmiO
 tQeIPH3thgUprVFMgcYhhnkieyeBXLG5wjNapNkbSZynrHyt7LA01xGZQTyXZp04/aU5
 z2nggsnuxnbswE1tiq0YrqC75Hcbv9O1gNO4nA/E+hSRnnkzhVw+BKaYqDQqo6O7xZMe
 Q4hD9etcM8Xs8ECS9PQwrFO3yfsss6n2+DUqY6HYbJkJBrpQtp8+PwdlQH9+BctOX83O
 HLGrdkh8AM+5Kts4abkCNctZHEbQQzhfXCgEdmux6kziSeiILNqVKZYSPoT0/o7aF/LR
 UQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476973; x=1790081773;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AUUeWv0d9UxvFkMkF4Q4KdOVnHwWeCzEKKTGT61D4Vk=;
 b=C/TN9BBCqoYgBk1IepqUhgWyr5nJzqTZo85mqBhCX4UY7xrxm4p81TI9CBQkRol5eX
 N7UC2BhiO4KyDmDZ3SMoOD/G3M266i0sMG1973jDPn30anspgTJMKAKnAnMrJqWflNfP
 aU7GSVJNzQpI2rrUZnaSVaIL5dApCxmFNmQqP0zLcNxcc3tkTWsKILm8LtbNbYLa+dFA
 F7CrVXqLuJY2HgiF7FaaydtmFgv+h1zeIaOjOoc1eZiCvLA39c/iTxa+D0Vu1QXO8Ks9
 fGnDHd7UCQo0SwmTm3mUN9u9qps2urq98lvsmKgkYyiue9+y2RQt8BGfHyTkRUKKe5VL
 XH8Q==
X-Gm-Message-State: AFuF++mxcn5+DZ3iemqw1dVlZu8/rULtBPFy3b13HihuEKPE2j7J7Hce
 1LSaFNzaXWSSnZd5Kig2SEaQ7ILXsIQtHbCHdgRCFLX09+BVgMNCTW9J2myHrrO8kyCg9TpGJgS
 lbAKVyi6Y033bUILHcAtNgdz/LsSV8FlQycoduOA00DPOOf10Fcn8XqmC
X-Gm-Gg: AYBFou1TwmFvFp3cdRONpzR781Yuu1DxMygZf9316jHqZC/z99dhncy4CUjXqcOFwgW
 23j5LkRpA7mMsq2wE0jFNSKdjvzy798EhZUyx2sdJhwZeluG2uepLa8nIrvQh4zD0bU2PGy2CHS
 kpc3TFFIDI+8hWcKVJZnOmLtxnJ5ppgYEKw6pdS4ic1PV9160lAFpXBzSf/G82dGQYTk+7t3piJ
 iEnLDDqx6xGRk8MdjyD7MeFE3m7eisoxMxtzEULhziitpJ1kd8X8YhqglMpN+g13vrBL7TWqAxA
 FsSk0G01Cxgyhxvm1nnpi8v1k713h5uAybp+F3C8Mq3jlffceZkUsGJC+44IYr+pIHw/Fu7xvMF
 3a+XlGUfT5a3eprIFt2NW2zHwvvQ4C0bkhhD9SETxkZdOtA==
X-Received: by 2002:a05:6402:4449:b0:6a9:864c:9d94 with SMTP id
 4fb4d7f45d1cf-6a9f63cda0bmr4660100a12.28.1789476973347; 
 Tue, 15 Sep 2026 05:56:13 -0700 (PDT)
X-Received: by 2002:a05:6402:4449:b0:6a9:864c:9d94 with SMTP id
 4fb4d7f45d1cf-6a9f63cda0bmr4660081a12.28.1789476972718; 
 Tue, 15 Sep 2026 05:56:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b59276a9sm6020243a12.19.2026.09.15.05.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:56:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:56:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqk_2QBTUzWeJ8eT@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
 <aqgQYmbLk6O1Af7I@sgarzare-redhat>
 <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
 <aqkXTbt49bPJW7R7@sgarzare-redhat>
 <a3d27ffc-679d-4b1a-aa5a-f3d9a7be155c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3d27ffc-679d-4b1a-aa5a-f3d9a7be155c@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 15, 2026 at 03:36:10PM +0300, Andrey Drobyshev wrote:
>On 9/15/26 1:07 PM, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 12:56:11PM +0300, Andrey Drobyshev wrote:
>>> On 9/14/26 6:36 PM, Stefano Garzarella wrote:
>>>> On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:
>>
>> [...]
>>
>>>>> @@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>>> }
>>>>>
>>>>> +static int vhost_vsock_pre_save(void *opaque)
>>>>> +{
>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>>>> +    if (ret) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Release the device ownership now for CPR migration.  The device is
>>>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>>>> +     * VHOST_SET_OWNER in post_load.
>>>>> +     */
>>>>> +    if (cpr_incoming_needed(NULL) && migration_is_running()) {
>>>>
>>>> Should we also check if vsock->owner_reset is already true?
>>>> Or it can never happen?
>>>
>>> Actually you're right, and we should also guard the RESET_OWNER op by
>>> !vsock->owner_reset.  If we fail somewhere after .pre_save() and the VM
>>> was stop before migration - we don't call set_status() just yet, so the
>>> device ownership isn't re-aquired, and a subsequent CPR attempt would
>>> fail here. I didn't think of such a case, thanks for noticing.
>>
>> oh, right! Thanks for checking!
>>
>>>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>>>> +        if (ret < 0) {
>>>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>>>>> +                         strerror(-ret));
>>>>> +            return ret;
>>>>> +        }
>>>>> +        vsock->owner_reset = true;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>>>> {
>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>>>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>>>>> +    Error *local_err = NULL;
>>>>> +    int vhostfd, ret;
>>>>> +
>>>>>     /*
>>>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>
>> [...]
>>
>>>>> @@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>>     }
>>>>>
>>>>>     /*
>>>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>>>> -     * device ownership is not handed over, so the target fails to set
>>>>> -     * up its device.  Fail the migration early and gracefully instead.
>>>>> +     * With the ownership handoff in place CPR migration is now supported.
>>>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>>>> +     * we only keep the migration blocker for the ID-less case.
>>>>>      */
>>>>> -    error_setg(&vsock->migration_blocker,
>>>>> -               "vhost-vsock: CPR migration is not supported");
>>>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>> -        return;
>>>>> +    if (!proxy->id) {
>>>>
>>>> Ditto about using `cpr_name` here.
>>>
>>> Agreed.
>>>> The rest LGTM!
>>>>
>>>> Thanks,
>>>> Stefano
>>>>
>>>>
>>>>> +        error_setg(&vsock->migration_blocker,
>>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>> +            return;
>>>>> +        }
>>>>>     }
>>>
>>> There's an interesting consequence of adopting qdev_get_dev_path().
>>> IIUC vhost-vsock device inherits from virtio device and is always
>>> attached to a device which is virtio device.  Then in qdev_get_dev_path():
>>>
>>>    bc = BUS_GET_CLASS(dev->parent_bus);
>>>
>>>    if (bc->get_dev_path) {
>>>
>>>        return bc->get_dev_path(dev);
>>>
>>>    }
>>>
>>> And all virtio buses, namely: virtio-pci-bus, virtio-mmio-bus,
>>> virtio-ccw-bus - implement their own .get_dev_path().
>>>
>>> This essentially means that for vhost-vsock device qdev_get_dev_path()
>>> can never return NULL.  This in turn means that our migration blocker
>>> which is now guarded by proxy->id can be entirely dropped.  We can just
>>> always allow CPR migration and simply do `g_assert(cpr_name)` whenever
>>> we obtain that name, as it's expected to never be NULL.
>>>
>>> I'll try adopting that approach, unless you have any objections.
>>
>> No objetions!
>>
>> I haven't looked closely at `qdev_get_dev_path()`. Can you check if it
>> includes the device type (or the id) in the path, or should we add a
>> suffix?
>
>AFAIU it includes neither of those, and it's purely the transport bus
>address.  For different kinds of virtio buses that'd be smth like:
>
>  * PCI: "0000:00:02.0"
>  * virtio-mmio: "virtio-mmio@000000000a003e00"
>  * ccw: "/fe.0.0001"
>
>And then we have precedents of other subsystems appending suffix to this
>address for the purpose of CPR indexing, e.g. physmem construct RAM
>block IDs for CPR as "<devpath>/<region name>".  So we might do the same.

Oh, nice, if we have something to follow, I agree we should!

>> Let me explain: I'd like to prevent other devices from conflicting in
>> the future, so if we use “vhost-vsock” as the suffix, we should be fine,
>> but I haven't checked carefully what it returns, so maybe it's already
>> there.
>
>Now, IIUC when we add 2 or more distinct devices which a siblings on a
>virtio bus (of any kind) - they do get distinct addresses on the bus ->
>qdev_get_dev_path() will return distinct values.  So we should be good here.

I see, and source and destination must have the same bus addresses, 
right?

>
>I'm going to adopt this approach, as well as drop the migration blocker,
>and do a respin.

Great, I agree on next steps :-)
Stefano


