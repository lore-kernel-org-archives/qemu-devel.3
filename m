Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB684C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 06:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txh7a-0005oR-H7; Thu, 27 Mar 2025 02:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txh7Y-0005nr-HQ
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:53:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txh7V-00052q-R2
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:53:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22398e09e39so14268225ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743058420; x=1743663220;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Perkpg+QLyIIBp8z2j495n9UzfO+OOijJkCXO07XLs=;
 b=EE3sxf9Vyx5G4XDZU54AinfdG95J5VQLYwGenBQois2yNWPvHPYJ0sJHgNUQdzAIlX
 KZOurxpNRdH7g44c22cgY7hDCKwWIQkhEjtzk3G/reKbjfYlfr0vT/YCCD73CW0r763d
 BXwjoQXxZEhdFOE/rn0bTWMnbHEW0dUi0EjFU129R5NaAU0GuhMP6SF/IbHfPGu6RimN
 etyqr7OlkSKKYnOuSsIF6rVhKE6c9xVhog98wFlr+NVNOrRewcPfVrfKQPAnag3SED00
 09CaCdjMsddPeiFZW0/xG5XYwixpRNg27ahfJmuDzZD/rgUBejqot3fsKP1OujaMo6KS
 btkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743058420; x=1743663220;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Perkpg+QLyIIBp8z2j495n9UzfO+OOijJkCXO07XLs=;
 b=nn7mhfw+q+rqPXn15LoAT3MS0uXnri8lR/8y5MakXdEVTWm4XDkimCnNFyV9KCSpik
 x6ogv+juVGgIhJwiikY+WaMvijld0eGb9mz1+tDW9miVQC+R6auZg8cW6tAz/Y1KuLRB
 wHM7EMNc1wdpGUdE6bNoO3Yn9zgnFWGMyjCEnJK7pQRKq9fbrg+jMl0/tBle5CzxcW2S
 96gAargET/UIk/AAR7czn652WLgweoyCAWoO57yBJyP/fGPcD/V/b+Wxf0zwj6fKIjx1
 FApBZ5Q2TM9wUazO/L2EYLxs+mS0DzC3jw+/uIlddqCkHWIfE8GACNMJ3ZgfX7L++cP7
 8FlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Gfrrq6z+33ND8hzM7tL9OOoAJMDXpUu4jfZ5pISQsWPw55i0WpjxCfOb8iAwxEYTY9liuWgZ0Z+H@nongnu.org
X-Gm-Message-State: AOJu0YxjYfxN0gTy2yGfXBJ0xxH6bCMwhUMEf0a468vXoMkq/jHDpNoq
 SC7SiD5/EJM8KTj/bSG2YFD+tZNNueP3UFr71agv3YnIBO1fOyl1BK4wYmVbrwc=
X-Gm-Gg: ASbGncuS5ctnGD5x0/uu+X68dhhtdDJccV/OVBQESGerFgK+LdrXsmtF4vMXFOfcJ25
 508iMNkgoi6MROSkzT+E3RLmMQ7PLeSe4ua1Se4D5kwGaeu3TSTWLNs+0lQAlvJ24RVtEVukUnQ
 bNfyj33+ajlMpGPV/M5B5hNLqfNZhXY3L+KKb3Hxzc4elUScMyRd0aie7ieo5sbCO30h6aVmk2C
 SOjO0urByff2gOWWoVDgYpgjLMlDbAh+wM14QMt8BThdYccY+RTntqZgx3JNHM5TKwQfE7ikpcc
 QYAF3InRClIPkKasT9wY0vnvV6FqcAcg2pSDHWKJm2WRqKxkqw==
X-Google-Smtp-Source: AGHT+IHH2UI18xdU1T0DpN7Y3C/Wy7/0tKCnGXlT/9fcqzdrugqWuY/Lfg6WHfdtJ+uqyfMfyNAESw==
X-Received: by 2002:a17:902:ccd2:b0:211:e812:3948 with SMTP id
 d9443c01a7336-2280455d75fmr40839275ad.0.1743058419575; 
 Wed, 26 Mar 2025 23:53:39 -0700 (PDT)
Received: from smtpclient.apple ([23.163.8.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm122089405ad.59.2025.03.26.23.53.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Mar 2025 23:53:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <hoq242tlgchxwzm3ukckyunkqpppiq4zfzpqrauhjdy7wbdiaq@wr26zlpznr5s>
Date: Thu, 27 Mar 2025 14:53:24 +0800
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E231839-A758-4F80-B517-EDF0A780C6A0@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
 <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
 <scj244d5eifrvxe7qgz4aszeg7wbjxzhh6tdccuzxkj5k3jxvi@ujonxzfmd3tb>
 <4DC039FB-6711-4FAC-9FCF-FB59E6B1151E@smartx.com>
 <hoq242tlgchxwzm3ukckyunkqpppiq4zfzpqrauhjdy7wbdiaq@wr26zlpznr5s>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> 2025=E5=B9=B43=E6=9C=8825=E6=97=A5 17:51=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Mar 25, 2025 at 04:39:46PM +0800, Haoqian He wrote:
>>> 2025=E5=B9=B43=E6=9C=8824=E6=97=A5 22:31=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>> On Thu, Mar 20, 2025 at 08:21:30PM +0800, Haoqian He wrote:
>>>>> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 23:20=EF=BC=8CStefano =
Garzarella <sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>=20
> [...]
>=20
>>>>>> diff --git a/include/hw/virtio/virtio.h =
b/include/hw/virtio/virtio.h
>>>>>> index 6386910280..c99d56f519 100644
>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>>>>> void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>>>> void (*reset)(VirtIODevice *vdev);
>>>>>> void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>>>>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>>>>=20
>>>>> Why we need a new callback instead having `set_status` returning =
int ?
>>>>=20
>>>> Because there are other devices such as virtio-net, virtio-ballon, =
etc.,
>>>> we only focus on vhost-user-blk/scsi when live migration.
>>>=20
>>> Why only them?
>>>=20
>>> What I mean, is why in devices where it's not important, don't we =
just return 0?
>>> It seems more complicated to maintain and confusing for new devices =
to have 2 callbacks for the same thing.
>>>=20
>>> Stefano
>>=20
>> The series of these patches only want to fix that the inflight IO =
can't be
>> completed due to the disconnection between and the vhost-user backend =
for
>> vhost-user-blk / scsi devices during live migration. For other virito =
devices
>> the issue does not exist, and `vm_state_notify` cannot distinguish =
specific
>> devices, it's better not to return error.
>=20
> Why for example for vhost-user-fs it doesn't exist?
>=20
>>=20
>> I try to list the virtio sub-devices as follows:
>>=20
>> hw/virtio/virtio-iommu.c:    vdc->set_status =3D =
virtio_iommu_set_status;
>> hw/virtio/virtio-balloon.c:    vdc->set_status =3D =
virtio_balloon_set_status;
>> hw/virtio/virtio-rng.c:    vdc->set_status =3D virtio_rng_set_status;
>> hw/virtio/virtio-crypto.c:    vdc->set_status =3D =
virtio_crypto_set_status;
>> hw/virtio/vhost-vsock.c:    vdc->set_status =3D =
vhost_vsock_set_status;
>> hw/virtio/vhost-user-vsock.c:    vdc->set_status =3D vuv_set_status;
>> hw/virtio/vhost-user-scmi.c:    vdc->set_status =3D =
vu_scmi_set_status;
>> hw/virtio/vhost-user-fs.c:    vdc->set_status =3D vuf_set_status;
>> hw/virtio/vhost-user-base.c:    vdc->set_status =3D vub_set_status;
>> hw/virtio/vdpa-dev.c:    vdc->set_status =3D =
vhost_vdpa_device_set_status;
>> tests/qtest/libqos/virtio-pci.c:    .set_status =3D =
qvirtio_pci_set_status,
>> tests/qtest/libqos/virtio-pci-modern.c:    .set_status =3D =
set_status,
>> tests/qtest/libqos/virtio-mmio.c:    .set_status =3D =
qvirtio_mmio_set_status,
>> hw/scsi/vhost-user-scsi.c:    vdc->set_status =3D =
vhost_user_scsi_set_status;
>> hw/scsi/vhost-scsi.c:    vdc->set_status =3D vhost_scsi_set_status;
>> hw/net/virtio-net.c:    vdc->set_status =3D virtio_net_set_status;
>> hw/char/virtio-serial-bus.c:    vdc->set_status =3D set_status;
>> hw/block/vhost-user-blk.c:    vdc->set_status =3D =
vhost_user_blk_set_status;
>> hw/block/virtio-blk.c:    vdc->set_status =3D virtio_blk_set_status;
>>=20
>> If the new function pointer type is not added, the number of =
functions affected
>> will be very huge. Although it may seem a bit complicated to use two =
callbacks,
>> it's much safer.
>=20
> I can understand that it requires more change, but I don't understand =
why it's safer, can you elaborate?
>=20
> Anyway let's see what Michael says, if it's okay for him to have 2 =
callbacks for the same thing but differing only by the return value, no =
objection for me.
>=20
> Thanks,
> Stefano
>=20

Hi Stefano, I removed set_status_ext in patch v3, and only changed the =
return
type of set_status to int. The new changes were applied to all =
vhost-user
devices, and virtio returned 0 for other devices.

Could you please review patch v3 is reasonable?

Thanks,
Haoqian


