Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF399C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1kW4-0000Ef-2W; Mon, 07 Apr 2025 07:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u1kW2-0000ES-Of
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:19:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1u1kVz-0000cX-Pg
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:19:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso4217687b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744024780; x=1744629580;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKXegi+ZhbtVvyPuf1B/BZ/ofjeGPi0rJK3872qSKok=;
 b=YcSQiBxRGmlCnoYDdpNV8TzPjK9zewbvUWRRxstnvImmzvWn4m8iMw03W/zy9EdSxe
 Vrd9T+XLArK1Ww4yLuI5i/g+oyEjRCEclCIMXAdc3NIYgOnpBES2yJ495JwE7x/vQW8U
 267jq9Cg3G+SSF+Kgot47c9GANjKMWGglh+4YQmnK1yl+HzLUZMvOTisQ/4jntg72dkp
 VG7jq/QVtNwEVSTVRE+s1RwMuOQ4zypS7UmIADY9/WLl0XqftSjTtx3Bzd5LLkIvtsa9
 UFPv14jFes3i1IPB9N8CzxCeVLoNYO/gIF2tFPYf33YSdyGokIdBr6Egirrx/ptmmqIL
 Xr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744024780; x=1744629580;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKXegi+ZhbtVvyPuf1B/BZ/ofjeGPi0rJK3872qSKok=;
 b=dfzd7FEAX+c9ua2VmeY7Rbzzz/sBJBn3JSScmGpZusxWZWlIroaZlzm5eOfzal/3CS
 Q7O9KGXPegeOPjbC5Don+AEdzsETnIciUSPJGVZ7YUcVwMGMhTxdmxNfrrjZ7spvMizl
 c+5rbYOZjIfqVc6bRN4/zQ0h53u730xmcM1aCj7aeP3k1TWT0d6AUqRdIsMOqDXeqWwb
 TzUpnaH0xzXI1TEcDcX53nSQ/pykGYEgEPmeL6M6/JPdbRAozk3OH6rhHDFxbedcvB/A
 +cBNrQFqCjVNTyFYCG26CsUZ1DySw0IrOlTECS3MQP5FveXBSKFrexcjXdGa8nTsG6iZ
 uk8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJrSVnnjduHAXxx9A5kYiH3Rt5VComMbJ+aWrunn2jBUg/IWQ36QU3MBJBTecbuJinG4FvlcX3iL6L@nongnu.org
X-Gm-Message-State: AOJu0YwJFnCMYQU9SfHv5qGgCFKbKoK7Js3FRZJ+rjSXDVMl698ux++/
 SMTPUYmwvpvqg03KWEW68CQo8mnVm5L22ucmJGbKIw3uHlxWnmLJuJvlBoy0sIc=
X-Gm-Gg: ASbGnct0yX4yax70BMIsmvJoKO/Ik/2rwF8gNm110D1eoYAkR97pYNX1qqkjnVKapEt
 BqIX8vGrU2SjJ0Jd4ckNYzzIStBv+80aT0ncbNurwZtaBEjNegjH9l3A7RUjazWxUn8GIVX0gGj
 Kz13ktp7cMHlHtpqdv1phGV7/omVE+WHyE9l10bDGxQ7YROEyoFQiq3Tuf3lkSla4lAA4ZTiYnp
 DCJ2KyEIl6uehEhO0jsDLcPf4fiU4RTl+5cZpGYwWV2IJw5FHD8c71KVYCjQryqOv+uHoJtARAR
 SGn2osQpD5k2pn6wJ5PWgSlC3aZ9MJnHFRnuJJ3CNwA1+YR8GMG7+Zzy+E2jR/SO9Hblr5932mB
 9458t8WMmPk02E1hRKoCmZCCJNi9vhUj1AzsEt0msFsS25lCV
X-Google-Smtp-Source: AGHT+IFZTPMEumNMlqrJG9r6WQX8F0kykW9K8OccRgEW2fe0QW5S1YRxLytfmDS/w7ghcJv7b8ZaLw==
X-Received: by 2002:a05:6a00:1790:b0:736:5c8e:bab8 with SMTP id
 d2e1a72fcca58-739e48d5a0fmr18827676b3a.3.1744024779828; 
 Mon, 07 Apr 2025 04:19:39 -0700 (PDT)
Received: from smtpclient.apple (n058152022152.netvigator.com. [58.152.22.152])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d2f63sm8270062b3a.1.2025.04.07.04.19.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Apr 2025 04:19:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <kesiax2fftxxkzydpbmzsn2gmgbknctcekskupug6jyhr5f4ii@wdrojsvhdfee>
Date: Mon, 7 Apr 2025 19:19:22 +0800
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
Message-Id: <7D403755-9B2A-4B98-A9E0-98F084A8670F@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
 <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
 <scj244d5eifrvxe7qgz4aszeg7wbjxzhh6tdccuzxkj5k3jxvi@ujonxzfmd3tb>
 <4DC039FB-6711-4FAC-9FCF-FB59E6B1151E@smartx.com>
 <hoq242tlgchxwzm3ukckyunkqpppiq4zfzpqrauhjdy7wbdiaq@wr26zlpznr5s>
 <8E231839-A758-4F80-B517-EDF0A780C6A0@smartx.com>
 <kesiax2fftxxkzydpbmzsn2gmgbknctcekskupug6jyhr5f4ii@wdrojsvhdfee>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=haoqian.he@smartx.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


> 2025=E5=B9=B44=E6=9C=884=E6=97=A5 15:30=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Mar 27, 2025 at 02:53:24PM +0800, Haoqian He wrote:
>>=20
>>> 2025=E5=B9=B43=E6=9C=8825=E6=97=A5 17:51=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Tue, Mar 25, 2025 at 04:39:46PM +0800, Haoqian He wrote:
>>>>> 2025=E5=B9=B43=E6=9C=8824=E6=97=A5 22:31=EF=BC=8CStefano =
Garzarella <sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>> On Thu, Mar 20, 2025 at 08:21:30PM +0800, Haoqian He wrote:
>>>>>>> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 23:20=EF=BC=8CStefano =
Garzarella <sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>>> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>>>=20
>>> [...]
>>>=20
>>>>>>>> diff --git a/include/hw/virtio/virtio.h =
b/include/hw/virtio/virtio.h
>>>>>>>> index 6386910280..c99d56f519 100644
>>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>>>>>>> void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>>>>>> void (*reset)(VirtIODevice *vdev);
>>>>>>>> void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>>>>>>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>>>>>>=20
>>>>>>> Why we need a new callback instead having `set_status` returning =
int ?
>>>>>>=20
>>>>>> Because there are other devices such as virtio-net, =
virtio-ballon, etc.,
>>>>>> we only focus on vhost-user-blk/scsi when live migration.
>>>>>=20
>>>>> Why only them?
>>>>>=20
>>>>> What I mean, is why in devices where it's not important, don't we =
just return 0?
>>>>> It seems more complicated to maintain and confusing for new =
devices to have 2 callbacks for the same thing.
>>>>>=20
>>>>> Stefano
>>>>=20
>>>> The series of these patches only want to fix that the inflight IO =
can't be
>>>> completed due to the disconnection between and the vhost-user =
backend for
>>>> vhost-user-blk / scsi devices during live migration. For other =
virito devices
>>>> the issue does not exist, and `vm_state_notify` cannot distinguish =
specific
>>>> devices, it's better not to return error.
>>>=20
>>> Why for example for vhost-user-fs it doesn't exist?
>>>=20
>>>>=20
>>>> I try to list the virtio sub-devices as follows:
>>>>=20
>>>> hw/virtio/virtio-iommu.c:    vdc->set_status =3D =
virtio_iommu_set_status;
>>>> hw/virtio/virtio-balloon.c:    vdc->set_status =3D =
virtio_balloon_set_status;
>>>> hw/virtio/virtio-rng.c:    vdc->set_status =3D =
virtio_rng_set_status;
>>>> hw/virtio/virtio-crypto.c:    vdc->set_status =3D =
virtio_crypto_set_status;
>>>> hw/virtio/vhost-vsock.c:    vdc->set_status =3D =
vhost_vsock_set_status;
>>>> hw/virtio/vhost-user-vsock.c:    vdc->set_status =3D =
vuv_set_status;
>>>> hw/virtio/vhost-user-scmi.c:    vdc->set_status =3D =
vu_scmi_set_status;
>>>> hw/virtio/vhost-user-fs.c:    vdc->set_status =3D vuf_set_status;
>>>> hw/virtio/vhost-user-base.c:    vdc->set_status =3D vub_set_status;
>>>> hw/virtio/vdpa-dev.c:    vdc->set_status =3D =
vhost_vdpa_device_set_status;
>>>> tests/qtest/libqos/virtio-pci.c:    .set_status =3D =
qvirtio_pci_set_status,
>>>> tests/qtest/libqos/virtio-pci-modern.c:    .set_status =3D =
set_status,
>>>> tests/qtest/libqos/virtio-mmio.c:    .set_status =3D =
qvirtio_mmio_set_status,
>>>> hw/scsi/vhost-user-scsi.c:    vdc->set_status =3D =
vhost_user_scsi_set_status;
>>>> hw/scsi/vhost-scsi.c:    vdc->set_status =3D vhost_scsi_set_status;
>>>> hw/net/virtio-net.c:    vdc->set_status =3D virtio_net_set_status;
>>>> hw/char/virtio-serial-bus.c:    vdc->set_status =3D set_status;
>>>> hw/block/vhost-user-blk.c:    vdc->set_status =3D =
vhost_user_blk_set_status;
>>>> hw/block/virtio-blk.c:    vdc->set_status =3D =
virtio_blk_set_status;
>>>>=20
>>>> If the new function pointer type is not added, the number of =
functions affected
>>>> will be very huge. Although it may seem a bit complicated to use =
two callbacks,
>>>> it's much safer.
>>>=20
>>> I can understand that it requires more change, but I don't =
understand why it's safer, can you elaborate?
>>>=20
>>> Anyway let's see what Michael says, if it's okay for him to have 2 =
callbacks for the same thing but differing only by the return value, no =
objection for me.
>>>=20
>>> Thanks,
>>> Stefano
>>>=20
>>=20
>> Hi Stefano, I removed set_status_ext in patch v3, and only changed =
the return
>> type of set_status to int. The new changes were applied to all =
vhost-user
>> devices, and virtio returned 0 for other devices.
>>=20
>> Could you please review patch v3 is reasonable?
>=20
>=20
> There are still questions like those a few lines above that I haven't =
received answers to, please don't send new versions if we haven't =
cleared up doubts about the current one first.
>=20
> I still don't understand why we are only considering vhost-user-blk =
and vhost-user-scsi, can you elaborate?
>=20
> Thanks,
> Stefano
>=20

Sorry for the late reply. Both patch v1 and v2 are not comprehensive =
enough.
We should not only consider the block I/O interfaces =
vhost-user-blk/scsi.

Thanks,
Haoqian


