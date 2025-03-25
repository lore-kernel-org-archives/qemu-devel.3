Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF85C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 09:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx0wg-0007TE-NU; Tue, 25 Mar 2025 05:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tx0we-0007Sw-S4
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tx0wc-0000bY-TN
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742896297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7ozHmHoS8tMJC4bQwG4+e/WZsb+SLWq1Hjl9bB/f1w=;
 b=Cz7FtyveMKpP1ItP2P7zMdxmCX+FBAFJWZWPMLFRz+uQeuR+7M6UF71H3ySWf0RjP5R9Ra
 Qcao6OSUMFSBQsJQAwVTPvG3p/+O2v2EGGdjJec+qpn3NJKZ8v6dWP6HeCeshHnZxWIwCQ
 J18CJDkCOfDkvNjn0TPtNDcaHqwUMAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-vxhEthRJNsyPZvhu7Y8A4w-1; Tue, 25 Mar 2025 05:51:35 -0400
X-MC-Unique: vxhEthRJNsyPZvhu7Y8A4w-1
X-Mimecast-MFC-AGG-ID: vxhEthRJNsyPZvhu7Y8A4w_1742896294
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso2318706f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 02:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742896294; x=1743501094;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7ozHmHoS8tMJC4bQwG4+e/WZsb+SLWq1Hjl9bB/f1w=;
 b=QdfXbr/emyOD21XKY1mlBll0DuKr5/30cKXh6l4PQvBMppwJPq8AIddyDfoGz/1Xa2
 uqF/yM52C4ypPqH8bFBcKOmceUwdX59FwdoE+acCyIRARJH4og2Uu6M0TydcB42IiNcM
 bVj9NeJ/9YJarsJryvb3k2exZXNoNiY8JVc+CcweLZBFk6NJTeD7jlp5yoPPhNMXw5V3
 Bl6eJckuAvk62jerHMOgXB5jNaB5MsdZYwJeEAbQ7nd4TjoLz74gBagtUQBlYdoyEIYh
 NUSC4h2b3ggzd7WVzbmO0GnBeEv22tny4OZ+g9NhwaUUn/wb7mOGi2jfZjEVDc29oJrP
 5u6g==
X-Gm-Message-State: AOJu0Yy89Nx8VaJvrFw2iUPEIJPyuQTt+ai83mLb/gYdkOpJq/+khC93
 EH+i56hDLPOHakYWH0+9RFMtCYVGEiRxrOE71IfhKc8t3BnTihtGjcykr4YAmx/F1yIxCF/orSx
 VTzXeu0I3UCk5B5FpkqCACxQVgXyUE8xYTVJ/6nvCnIE0kVqu2Vx1
X-Gm-Gg: ASbGncvodZBZYewOrk0SqG7wJ49YocvZPOBIcSGW/3SP2hXJ5HB3i9PHw5r/U2fGuUb
 CZfhiYeJv8+v3mCowT/oPx8F+V56CtleJauy6fyZU3IHOqd1XUrrtFDZG87Nt0qjvBMzMv2yWoA
 eJ99nQUIzWW33e+md7dtIvN4Pq3jdxKAdnTMGee3KtcmCkPainDOK8fDKpcsC2XPA+bmkO41uMg
 dUKv+EXcgMoCWPIhHdLDCrV8/O+SgViaKN/kxeA7fb7vdlzGpQJDTZrDys6ghBWccUG3bN2WPNa
 TSYIcCbW+V+8t0VIUJccxNrXBAO/BaIAHWB4+8mBktshCsdfovwF5WJ6WjsbclM1
X-Received: by 2002:a5d:64c6:0:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3997f93bf86mr12731485f8f.45.1742896293578; 
 Tue, 25 Mar 2025 02:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2invCa0hfU7KEZk0+RNwOue3jFyi3iNXTXvE3CLStyXapOGUxGmZGgiqjEhUElqtToJGuqA==
X-Received: by 2002:a5d:64c6:0:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3997f93bf86mr12731451f8f.45.1742896293017; 
 Tue, 25 Mar 2025 02:51:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it.
 [87.12.25.55]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abafed528sm9797533f8f.27.2025.03.25.02.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 02:51:32 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:51:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
Message-ID: <hoq242tlgchxwzm3ukckyunkqpppiq4zfzpqrauhjdy7wbdiaq@wr26zlpznr5s>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
 <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
 <scj244d5eifrvxe7qgz4aszeg7wbjxzhh6tdccuzxkj5k3jxvi@ujonxzfmd3tb>
 <4DC039FB-6711-4FAC-9FCF-FB59E6B1151E@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4DC039FB-6711-4FAC-9FCF-FB59E6B1151E@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 25, 2025 at 04:39:46PM +0800, Haoqian He wrote:
>> 2025年3月24日 22:31，Stefano Garzarella <sgarzare@redhat.com> 写道：
>> On Thu, Mar 20, 2025 at 08:21:30PM +0800, Haoqian He wrote:
>>>> 2025年3月19日 23:20，Stefano Garzarella <sgarzare@redhat.com> 
>>>> 写道：
>>>> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:

[...]

>>>>> diff --git a/include/hw/virtio/virtio.h 
>>>>> b/include/hw/virtio/virtio.h
>>>>> index 6386910280..c99d56f519 100644
>>>>> --- a/include/hw/virtio/virtio.h
>>>>> +++ b/include/hw/virtio/virtio.h
>>>>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>>>> void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>>> void (*reset)(VirtIODevice *vdev);
>>>>> void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>>>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>>>
>>>> Why we need a new callback instead having `set_status` returning int ?
>>>
>>> Because there are other devices such as virtio-net, virtio-ballon, etc.,
>>> we only focus on vhost-user-blk/scsi when live migration.
>>
>> Why only them?
>>
>> What I mean, is why in devices where it's not important, don't we just return 0?
>> It seems more complicated to maintain and confusing for new devices to have 2 callbacks for the same thing.
>>
>> Stefano
>
>The series of these patches only want to fix that the inflight IO can't be
>completed due to the disconnection between and the vhost-user backend for
>vhost-user-blk / scsi devices during live migration. For other virito devices
>the issue does not exist, and `vm_state_notify` cannot distinguish specific
>devices, it's better not to return error.

Why for example for vhost-user-fs it doesn't exist?

>
>I try to list the virtio sub-devices as follows:
>
>hw/virtio/virtio-iommu.c:    vdc->set_status = virtio_iommu_set_status;
>hw/virtio/virtio-balloon.c:    vdc->set_status = virtio_balloon_set_status;
>hw/virtio/virtio-rng.c:    vdc->set_status = virtio_rng_set_status;
>hw/virtio/virtio-crypto.c:    vdc->set_status = virtio_crypto_set_status;
>hw/virtio/vhost-vsock.c:    vdc->set_status = vhost_vsock_set_status;
>hw/virtio/vhost-user-vsock.c:    vdc->set_status = vuv_set_status;
>hw/virtio/vhost-user-scmi.c:    vdc->set_status = vu_scmi_set_status;
>hw/virtio/vhost-user-fs.c:    vdc->set_status = vuf_set_status;
>hw/virtio/vhost-user-base.c:    vdc->set_status = vub_set_status;
>hw/virtio/vdpa-dev.c:    vdc->set_status = vhost_vdpa_device_set_status;
>tests/qtest/libqos/virtio-pci.c:    .set_status = qvirtio_pci_set_status,
>tests/qtest/libqos/virtio-pci-modern.c:    .set_status = set_status,
>tests/qtest/libqos/virtio-mmio.c:    .set_status = qvirtio_mmio_set_status,
>hw/scsi/vhost-user-scsi.c:    vdc->set_status = vhost_user_scsi_set_status;
>hw/scsi/vhost-scsi.c:    vdc->set_status = vhost_scsi_set_status;
>hw/net/virtio-net.c:    vdc->set_status = virtio_net_set_status;
>hw/char/virtio-serial-bus.c:    vdc->set_status = set_status;
>hw/block/vhost-user-blk.c:    vdc->set_status = vhost_user_blk_set_status;
>hw/block/virtio-blk.c:    vdc->set_status = virtio_blk_set_status;
>
>If the new function pointer type is not added, the number of functions affected
>will be very huge. Although it may seem a bit complicated to use two callbacks,
>it's much safer.

I can understand that it requires more change, but I don't understand 
why it's safer, can you elaborate?

Anyway let's see what Michael says, if it's okay for him to have 2 
callbacks for the same thing but differing only by the return value, no 
objection for me.

Thanks,
Stefano


