Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9880DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 07:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0bVQ-0002Ox-N5; Fri, 04 Apr 2025 03:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1u0bVO-0002OB-2i
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1u0bVM-0003Z4-7Y
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743751817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK2BpwJPugw7oUMus62tydRQh3i/YWRvEIrybuuNB6Q=;
 b=CoFh9FZg/mmNRES5HuW0Od4Q8fOFo+zAvngDUrEoDtueLoE1oxZ7TMl8a2LPbjsL9OOAhi
 plN4Qokk6jlfa2mGHMGWZJ7NTNIZYpWcz4rGzHu545TGKAuHKFN+mDzf1j/qGltKoRKAi/
 MIlUvex+W/VYv1jBr3YnpkxvtQA/OBw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-IV8NwFqSNsaEhmWY4qyQJQ-1; Fri, 04 Apr 2025 03:30:15 -0400
X-MC-Unique: IV8NwFqSNsaEhmWY4qyQJQ-1
X-Mimecast-MFC-AGG-ID: IV8NwFqSNsaEhmWY4qyQJQ_1743751815
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso146184866b.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 00:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743751815; x=1744356615;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iK2BpwJPugw7oUMus62tydRQh3i/YWRvEIrybuuNB6Q=;
 b=JDH3wU+ZNGJid8ItXUm1uIdxmeA6+y/V7s/66/sTFA9bwm7JbNOCtFlR+cCQ8txCfz
 BYHhILWRSRB18FW9CHN44/8IYynT9CyXF0XxNDnoCaMDa2zNZ4vEU+b2rYu3hlFzWFO9
 x6RvdNW6AzijPUA6/4LcFGSDk8VYwQWguq4TiMe9zRNirAp4AnkToLPESpTWYL7sYY4g
 Gn3kii++nhd2FB4crej5lQuPoDKAN94xR7KvXOomKmKZZVIgJFG143zjh9zAgXL7Jjoy
 i0aFPlNhgKW61DRHC3/AybP+MabRa/elKWuHhabftWzFTV6gXp6lq/TxE8VaxbRA9MIx
 p8dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXolGw5+hMsXHwgVb6qz6WfXuxDKmxVPE70Xmusp/JYSVgNvej/0BtqZ0jLq8rmA9mCJzN7kg+g3upf@nongnu.org
X-Gm-Message-State: AOJu0YxwpoDqnA5up3XWwmw/K8Eyr70uQumG8+fzZ4lt/eUptHvkT/3N
 gdYqW8eFgvRQMdPhCitGvIarL1ODhjZx9NfswaLUJitUMvcZnzz1xRPGGM73HIF3D3fg0a3fh9t
 etXWG/InYEqCjgsz2goNE+R9IGisLaXWhglzQyZk3UvNMuKtYqW5X
X-Gm-Gg: ASbGncv0n2i/vbLx6BeezY/lSUoZ1teu/Jq5heDbcDXpgk/LfUwCOVsSh7zQiz342/l
 H/jFF2Onai/MjHONSywHpbEjF2UA0vGsI/vz0OHnOfhTj4WM7THJPctDjKtAhe9N3EHpFVCNOC4
 R/2Cx5zM/5vmOgXaroLULqW1pKFu5Qg5ib7VuIuI9nwzH8TShVq17bp30mXTuQjXaRoXj4f5pEh
 r4VRCL1QjbQzSMEAAy56dz9sqIj+Uf6hxYbkA5/dtpJbv9CYr8c0Jda5THf/LlHP8YzID9QVUQG
 ikNXcma+OJrm3Qplr8jb3ouDGCCggjHGNxImri3vHO2/7RX1udHt2kNZ7wU=
X-Received: by 2002:a17:907:94cf:b0:ac3:cff:80e1 with SMTP id
 a640c23a62f3a-ac7d19a160bmr198780266b.56.1743751814661; 
 Fri, 04 Apr 2025 00:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK7c9HZ1skdAB8VCURT+IDpaLHHzUn7zXPsfcy0+5c/L0s5fMCxKpqVx36ZOpPYjHfR+mUTA==
X-Received: by 2002:a17:907:94cf:b0:ac3:cff:80e1 with SMTP id
 a640c23a62f3a-ac7d19a160bmr198777266b.56.1743751814091; 
 Fri, 04 Apr 2025 00:30:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it.
 [87.11.6.59]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880a3ae1sm1939068a12.68.2025.04.04.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 00:30:13 -0700 (PDT)
Date: Fri, 4 Apr 2025 09:30:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 Raphael Norwitz <raphael@enfabrica.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
Message-ID: <kesiax2fftxxkzydpbmzsn2gmgbknctcekskupug6jyhr5f4ii@wdrojsvhdfee>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
 <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
 <scj244d5eifrvxe7qgz4aszeg7wbjxzhh6tdccuzxkj5k3jxvi@ujonxzfmd3tb>
 <4DC039FB-6711-4FAC-9FCF-FB59E6B1151E@smartx.com>
 <hoq242tlgchxwzm3ukckyunkqpppiq4zfzpqrauhjdy7wbdiaq@wr26zlpznr5s>
 <8E231839-A758-4F80-B517-EDF0A780C6A0@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8E231839-A758-4F80-B517-EDF0A780C6A0@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 27, 2025 at 02:53:24PM +0800, Haoqian He wrote:
>
>> 2025年3月25日 17:51，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>
>> On Tue, Mar 25, 2025 at 04:39:46PM +0800, Haoqian He wrote:
>>>> 2025年3月24日 22:31，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>>> On Thu, Mar 20, 2025 at 08:21:30PM +0800, Haoqian He wrote:
>>>>>> 2025年3月19日 23:20，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>>>>> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>>
>> [...]
>>
>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>>> index 6386910280..c99d56f519 100644
>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>>>>>> void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>>>>> void (*reset)(VirtIODevice *vdev);
>>>>>>> void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>>>>>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>>>>>
>>>>>> Why we need a new callback instead having `set_status` returning int ?
>>>>>
>>>>> Because there are other devices such as virtio-net, virtio-ballon, etc.,
>>>>> we only focus on vhost-user-blk/scsi when live migration.
>>>>
>>>> Why only them?
>>>>
>>>> What I mean, is why in devices where it's not important, don't we just return 0?
>>>> It seems more complicated to maintain and confusing for new devices to have 2 callbacks for the same thing.
>>>>
>>>> Stefano
>>>
>>> The series of these patches only want to fix that the inflight IO can't be
>>> completed due to the disconnection between and the vhost-user backend for
>>> vhost-user-blk / scsi devices during live migration. For other virito devices
>>> the issue does not exist, and `vm_state_notify` cannot distinguish specific
>>> devices, it's better not to return error.
>>
>> Why for example for vhost-user-fs it doesn't exist?
>>
>>>
>>> I try to list the virtio sub-devices as follows:
>>>
>>> hw/virtio/virtio-iommu.c:    vdc->set_status = virtio_iommu_set_status;
>>> hw/virtio/virtio-balloon.c:    vdc->set_status = virtio_balloon_set_status;
>>> hw/virtio/virtio-rng.c:    vdc->set_status = virtio_rng_set_status;
>>> hw/virtio/virtio-crypto.c:    vdc->set_status = virtio_crypto_set_status;
>>> hw/virtio/vhost-vsock.c:    vdc->set_status = vhost_vsock_set_status;
>>> hw/virtio/vhost-user-vsock.c:    vdc->set_status = vuv_set_status;
>>> hw/virtio/vhost-user-scmi.c:    vdc->set_status = vu_scmi_set_status;
>>> hw/virtio/vhost-user-fs.c:    vdc->set_status = vuf_set_status;
>>> hw/virtio/vhost-user-base.c:    vdc->set_status = vub_set_status;
>>> hw/virtio/vdpa-dev.c:    vdc->set_status = vhost_vdpa_device_set_status;
>>> tests/qtest/libqos/virtio-pci.c:    .set_status = qvirtio_pci_set_status,
>>> tests/qtest/libqos/virtio-pci-modern.c:    .set_status = set_status,
>>> tests/qtest/libqos/virtio-mmio.c:    .set_status = qvirtio_mmio_set_status,
>>> hw/scsi/vhost-user-scsi.c:    vdc->set_status = vhost_user_scsi_set_status;
>>> hw/scsi/vhost-scsi.c:    vdc->set_status = vhost_scsi_set_status;
>>> hw/net/virtio-net.c:    vdc->set_status = virtio_net_set_status;
>>> hw/char/virtio-serial-bus.c:    vdc->set_status = set_status;
>>> hw/block/vhost-user-blk.c:    vdc->set_status = vhost_user_blk_set_status;
>>> hw/block/virtio-blk.c:    vdc->set_status = virtio_blk_set_status;
>>>
>>> If the new function pointer type is not added, the number of functions affected
>>> will be very huge. Although it may seem a bit complicated to use two callbacks,
>>> it's much safer.
>>
>> I can understand that it requires more change, but I don't understand why it's safer, can you elaborate?
>>
>> Anyway let's see what Michael says, if it's okay for him to have 2 callbacks for the same thing but differing only by the return value, no objection for me.
>>
>> Thanks,
>> Stefano
>>
>
>Hi Stefano, I removed set_status_ext in patch v3, and only changed the return
>type of set_status to int. The new changes were applied to all vhost-user
>devices, and virtio returned 0 for other devices.
>
>Could you please review patch v3 is reasonable?


There are still questions like those a few lines above that I haven't 
received answers to, please don't send new versions if we haven't 
cleared up doubts about the current one first.

I still don't understand why we are only considering vhost-user-blk and 
vhost-user-scsi, can you elaborate?

Thanks,
Stefano


