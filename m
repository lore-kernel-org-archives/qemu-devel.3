Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE54C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 05:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s77WA-00007t-MA; Wed, 15 May 2024 01:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s77Vo-000059-KI
 for qemu-devel@nongnu.org; Wed, 15 May 2024 01:49:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s77Vk-0004mu-J8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 01:49:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44ed6e82fso5611833b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 22:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715752025; x=1716356825;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B2XcxEkrypcuMLBfY7Fue9LIpjQz4zyhacLOYATLt0=;
 b=yInmRKSIEie8xQgBTApwJwNsGWz2NoBqAKpb1g9rsVht+ndszrJdIsX1Yp2MovXgqT
 ArsD9p2jspsxpq7vDbA18DrZNYcRMYORJSsRjO0BxnYwlOK4UDS81j0PlBVpT1WanXxv
 k6O9XV4uVOQW170mY2xz61i+tdPZe0vVCBfwu69s7wW/SboT0voaR3oix3WbcTqcAZ2t
 pW5O6LowMJkXOLWOYi8T+oszm5Ac6widmLAoBQ5SWWmKml0Cz0KG4DDGACzJwFVYTGg5
 tZaaVOLfjoXw7WUXRUvuvgCx+J8c9kxHjBwK7pBJ6Fb77io5Ie8OWehGlqHCAXDbNzDH
 oIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715752025; x=1716356825;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6B2XcxEkrypcuMLBfY7Fue9LIpjQz4zyhacLOYATLt0=;
 b=eSdNvFIUYYb0q8ZLWYxVDtKOdYJ3SnkgW0KMzlHjoWSz3eUshc76/wo+Qn2x1ceGjl
 JPppRdAIri94XKTF9Zl1pRrzRGzGBm7jtaWGgEMH+4/rc/9IgGInNNbVJSPSnnikMG43
 KpLD+L2H3aNGhIcjYf43toY14eeBG/xjovDwbfcIw5zMG9/hC0L3ylITuWhR6FUQkxdb
 bkqyVvSjzIsbD4NBe1llZbKVWAK/u+8WzPqOIDO2A/Zyh0IZFTC7oBx4xk863GDXJs44
 kEpa+MrZNoNOc6THUS2PQoa/+FQhfUAQ/rfMNiv40Ily4GiJdUw02OKCGTsKccxTT16C
 4LBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNra9D9AzTneAT1zxWXkW45JMrHsGYgtB65De2pE2+aX0AVax8oNtxYOmUiQ4lKTCAjfC/cMphisp87hc58NT3ts3v8lM=
X-Gm-Message-State: AOJu0YzRrlDA4TZwLHJqI0BHH1NG1Ha8eNStTPDW4ANMVou5vreMPyQO
 AzMYaEV05nb0jKmzcXcIJLEgCiivqX4gMIVQIK1H9VJnzBlpzk0S49wMGU2U9l8=
X-Google-Smtp-Source: AGHT+IEKlYChBJFgQIJDFSL+7QJq+COXSuyKLTFoZraNHTf0PkT+oC97spigPLJdOFi8CCLrDErgcg==
X-Received: by 2002:a05:6a20:d817:b0:1b0:1025:2f5 with SMTP id
 adf61e73a8af0-1b010250487mr3421166637.0.1715752024415; 
 Tue, 14 May 2024 22:47:04 -0700 (PDT)
Received: from smtpclient.apple ([103.172.41.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a449f1esm10455452a12.11.2024.05.14.22.47.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2024 22:47:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v3 1/2] Revert "vhost-user: fix lost reconnect"
From: Li Feng <fengli@smartx.com>
In-Reply-To: <CAMDpr=f7=H0-8PAiodcQ-J_MOaEzXmXUbkA_b2uoY36a887_BA@mail.gmail.com>
Date: Wed, 15 May 2024 13:46:47 +0800
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <057D1C7C-067A-4660-943B-F3EFFFBEF30B@smartx.com>
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-2-fengli@smartx.com>
 <CAMDpr=f7=H0-8PAiodcQ-J_MOaEzXmXUbkA_b2uoY36a887_BA@mail.gmail.com>
To: Raphael Norwitz <raphael@enfabrica.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: 29
X-Spam_score: 2.9
X-Spam_bar: ++
X-Spam_report: (2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 21:58=EF=BC=8CRaphael Norwitz =
<raphael@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The code for these two patches looks fine. Just some questions on the
> failure case you're trying to fix.
>=20
>=20
> On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> This reverts commit f02a4b8e6431598612466f76aac64ab492849abf.
>>=20
>> Since the current patch cannot completely fix the lost reconnect
>> problem, there is a scenario that is not considered:
>> - When the virtio-blk driver is removed from the guest os,
>>  s->connected has no chance to be set to false, resulting in
>=20
> Why would the virtio-blk driver being removed (unloaded?) in the guest
> effect s->connected? Isn't this variable just tracking whether Qemu is
> connected to the backend process? What does it have to do with the
> guest driver state?

Unload the virtio-blk, it will trigger =E2=80=98vhost_user_blk_stop=E2=80=99=
, and in `vhost_dev_stop`
it will set the `hdev->vdev =3D NULL;`.

Next if kill the backend, the CLOSE event will be triggered, and the =
`vhost->vdev`
has been set to null before, then the `vhost_user_blk_disconnect` will =
not have a
chance to execute.So that he s->connected is still true.

static void vhost_user_async_close_bh(void *opaque)
{
    VhostAsyncCallback *data =3D opaque;
    struct vhost_dev *vhost =3D data->vhost;

    /*
     * If the vhost_dev has been cleared in the meantime there is
     * nothing left to do as some other path has completed the
     * cleanup.
     */
    if (vhost->vdev) {  <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D HERE vdev is null.
        data->cb(data->dev);
    } else if (data->event_cb) {
        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, data->event_cb,
                                 NULL, data->dev, NULL, true);
   }

    g_free(data);
}

Thanks,
Li

>=20
>>  subsequent reconnection not being executed.
>>=20
>> The next patch will completely fix this issue with a better approach.
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c      |  2 +-
>> hw/scsi/vhost-user-scsi.c      |  3 +--
>> hw/virtio/vhost-user-base.c    |  2 +-
>> hw/virtio/vhost-user.c         | 10 ++--------
>> include/hw/virtio/vhost-user.h |  3 +--
>> 5 files changed, 6 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 9e6bbc6950..41d1ac3a5a 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -384,7 +384,7 @@ static void vhost_user_blk_event(void *opaque, =
QEMUChrEvent event)
>>     case CHR_EVENT_CLOSED:
>>         /* defer close until later to avoid circular close */
>>         vhost_user_async_close(dev, &s->chardev, &s->dev,
>> -                               vhost_user_blk_disconnect, =
vhost_user_blk_event);
>> +                               vhost_user_blk_disconnect);
>>         break;
>>     case CHR_EVENT_BREAK:
>>     case CHR_EVENT_MUX_IN:
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index a63b1f4948..48a59e020e 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -214,8 +214,7 @@ static void vhost_user_scsi_event(void *opaque, =
QEMUChrEvent event)
>>     case CHR_EVENT_CLOSED:
>>         /* defer close until later to avoid circular close */
>>         vhost_user_async_close(dev, &vs->conf.chardev, &vsc->dev,
>> -                               vhost_user_scsi_disconnect,
>> -                               vhost_user_scsi_event);
>> +                               vhost_user_scsi_disconnect);
>>         break;
>>     case CHR_EVENT_BREAK:
>>     case CHR_EVENT_MUX_IN:
>> diff --git a/hw/virtio/vhost-user-base.c =
b/hw/virtio/vhost-user-base.c
>> index a83167191e..4b54255682 100644
>> --- a/hw/virtio/vhost-user-base.c
>> +++ b/hw/virtio/vhost-user-base.c
>> @@ -254,7 +254,7 @@ static void vub_event(void *opaque, QEMUChrEvent =
event)
>>     case CHR_EVENT_CLOSED:
>>         /* defer close until later to avoid circular close */
>>         vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
>> -                               vub_disconnect, vub_event);
>> +                               vub_disconnect);
>>         break;
>>     case CHR_EVENT_BREAK:
>>     case CHR_EVENT_MUX_IN:
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index cdf9af4a4b..c929097e87 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2776,7 +2776,6 @@ typedef struct {
>>     DeviceState *dev;
>>     CharBackend *cd;
>>     struct vhost_dev *vhost;
>> -    IOEventHandler *event_cb;
>> } VhostAsyncCallback;
>>=20
>> static void vhost_user_async_close_bh(void *opaque)
>> @@ -2791,10 +2790,7 @@ static void vhost_user_async_close_bh(void =
*opaque)
>>      */
>>     if (vhost->vdev) {
>>         data->cb(data->dev);
>> -    } else if (data->event_cb) {
>> -        qemu_chr_fe_set_handlers(data->cd, NULL, NULL, =
data->event_cb,
>> -                                 NULL, data->dev, NULL, true);
>> -   }
>> +    }
>>=20
>>     g_free(data);
>> }
>> @@ -2806,8 +2802,7 @@ static void vhost_user_async_close_bh(void =
*opaque)
>>  */
>> void vhost_user_async_close(DeviceState *d,
>>                             CharBackend *chardev, struct vhost_dev =
*vhost,
>> -                            vu_async_close_fn cb,
>> -                            IOEventHandler *event_cb)
>> +                            vu_async_close_fn cb)
>> {
>>     if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>>         /*
>> @@ -2823,7 +2818,6 @@ void vhost_user_async_close(DeviceState *d,
>>         data->dev =3D d;
>>         data->cd =3D chardev;
>>         data->vhost =3D vhost;
>> -        data->event_cb =3D event_cb;
>>=20
>>         /* Disable any further notifications on the chardev */
>>         qemu_chr_fe_set_handlers(chardev,
>> diff --git a/include/hw/virtio/vhost-user.h =
b/include/hw/virtio/vhost-user.h
>> index d7c09ffd34..324cd8663a 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -108,7 +108,6 @@ typedef void (*vu_async_close_fn)(DeviceState =
*cb);
>>=20
>> void vhost_user_async_close(DeviceState *d,
>>                             CharBackend *chardev, struct vhost_dev =
*vhost,
>> -                            vu_async_close_fn cb,
>> -                            IOEventHandler *event_cb);
>> +                            vu_async_close_fn cb);
>>=20
>> #endif
>> --
>> 2.45.0
>>=20


