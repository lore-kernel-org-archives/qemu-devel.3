Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1504FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 02:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7RCQ-00081C-1v; Wed, 15 May 2024 22:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RCN-00080k-1O
 for qemu-devel@nongnu.org; Wed, 15 May 2024 22:50:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s7RCJ-0002Wa-2y
 for qemu-devel@nongnu.org; Wed, 15 May 2024 22:50:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so6976962b3a.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 19:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715827699; x=1716432499;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7wlmbfm/ruX/3KG1YrgWC4QUZraogS8lJlOUUfmmLOE=;
 b=djdSC986mfC7cmdN7WRPMYH/WcM07KbsUhhm+VFH6t+93TMUaPI5DByNxZg9+8dX0e
 Xs/3d/+tHpa6weYQtuk1ATSl1m/wRrZVf5Qc+X803mCfFTgh4tfTMw0s6uc/pvfBsmLi
 W2SzAKPazlXR13c33PT4wfW+hZgxpFVC0t8s27IJooBfiFrPaZXWQjollleJv7TV+GLw
 PfwQ6A/LM4N4nrLYW4DnbBx/8/upj4Zb5RptkfXU6NWFIm80sBlk3dSfgAGo+SVV2zcO
 ah2wRkHC6BsnhsCxpIGLUZr8TnC6mRJChxmVcpudoa+V9Q2b2z2gBpMaT1GczrMRsQKB
 UxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715827699; x=1716432499;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wlmbfm/ruX/3KG1YrgWC4QUZraogS8lJlOUUfmmLOE=;
 b=CONsP+J+R+h7niKNOSg2bfhth9F8voIlsj5DAdXTZ3J2X0Re+g8EiJWU93NS70AFhz
 7WzzVmmQ1ymzCWE6//K3LBGn7YMcIILVWNg6e5LqjaHyHX4+dVQZ9oROMsmqi3oUcv4W
 ETw/pD/ZW0Onj/yzhAO10Eh1ILTsCwKMLMfJNejmnL/YkfX9pbsAQGlFmkxtOc1HgPKl
 Ty0VejG7mNb60Kyl8nTQiRSEP3FKS42AslGCCC5QGL4A4dPhTLMR2uvOasEw2ew/57LJ
 RUuQ0/5VgOxtI0cdtty39JbagUl+ZuzqYNOfjKulSb/cYovB6lPDt7a6bT48pP1/TUya
 oqKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX8pXc1eQlzMeGyIjZ7XE6qK+SY2wLft37fHUX4E0cUAkP4Hlnmi9mWAaDVZQpHasGZe+R6HGpVBP7R7y+xTl68r0JXCA=
X-Gm-Message-State: AOJu0YyyHuiUe1Nre6Izu6wy7VAPHp42XJFaJahkfK4HayRcbC2gkBp5
 kPAWK9ALbLZZmWUBqBAm3H6+libWe5S2qmjyVJtucDaFPO4BoUguKGubHu2kRx4=
X-Google-Smtp-Source: AGHT+IHjgHvdLrV7tQ3dSzxPth/wYMi/SYWC9gi8yl66vvEZyZBScdHkF60sDoOExye7XxESKjXELQ==
X-Received: by 2002:a05:6a00:2195:b0:6ea:b48a:f971 with SMTP id
 d2e1a72fcca58-6f4e029a2e3mr28086901b3a.2.1715827698664; 
 Wed, 15 May 2024 19:48:18 -0700 (PDT)
Received: from smtpclient.apple ([103.172.41.204])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f669b7d58dsm4055858b3a.105.2024.05.15.19.48.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 May 2024 19:48:18 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
Message-Id: <2A51C37E-972B-4231-8D08-7A4560ED5E49@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D91E6ED1-FD7E-49D4-8061-594537900F5D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v3 2/2] vhost-user: fix lost reconnect again
Date: Thu, 16 May 2024 10:48:01 +0800
In-Reply-To: <CAMDpr=cSEPH2CHFn76=2Z3PrZ644-wdq_7S++pCFdesbzC6ikA@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
To: Raphael Norwitz <raphael@enfabrica.net>
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-3-fengli@smartx.com>
 <CAMDpr=crBG2ViSRSmrmtGQ7gn90XB_QHLdt74EbgG-k2hxiPhg@mail.gmail.com>
 <0BF8DF49-CB9A-4D0A-A994-099A7925DF09@smartx.com>
 <CAMDpr=cSEPH2CHFn76=2Z3PrZ644-wdq_7S++pCFdesbzC6ikA@mail.gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 29
X-Spam_score: 2.9
X-Spam_bar: ++
X-Spam_report: (2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_D91E6ED1-FD7E-49D4-8061-594537900F5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2024=E5=B9=B45=E6=9C=8815=E6=97=A5 23:47=EF=BC=8CRaphael Norwitz =
<raphael@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The case your describing makes sense but now I have some concerns on
> the vhost_dev_cleanup bit.
>=20
> On Wed, May 15, 2024 at 1:47=E2=80=AFAM Li Feng <fengli@smartx.com =
<mailto:fengli@smartx.com>> wrote:
>>=20
>>=20
>>=20
>>> 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 21:58=EF=BC=8CRaphael Norwitz =
<raphael@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Code looks good. Just a question on the error case you're trying to =
fix.
>>>=20
>>> On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> =
wrote:
>>>>=20
>>>> When the vhost-user is reconnecting to the backend, and if the =
vhost-user fails
>>>> at the get_features in vhost_dev_init(), then the reconnect will =
fail
>>>> and it will not be retriggered forever.
>>>>=20
>>>> The reason is:
>>>> When the vhost-user fail at get_features, the vhost_dev_cleanup =
will be called
>>>> immediately.
>>>>=20
>>>> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct =
vhost_dev))'.
>>>>=20
>>>> The reconnect path is:
>>>> vhost_user_blk_event
>>>>  vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>>>>    qemu_chr_fe_set_handlers <----- clear the notifier callback
>>>>      schedule vhost_user_async_close_bh
>>>>=20
>>>> The vhost->vdev is null, so the vhost_user_blk_disconnect will not =
be
>>>> called, then the event fd callback will not be reinstalled.
>>>>=20
>>>> With this patch, the vhost_user_blk_disconnect will call the
>>>> vhost_dev_cleanup() again, it's safe.
>>>>=20
>>>> In addition, the CLOSE event may occur in a scenario where =
connected is false.
>>>> At this time, the event handler will be cleared. We need to ensure =
that the
>>>> event handler can remain installed.
>>>=20
>>> Following on from the prior patch, why would "connected" be false =
when
>>> a CLOSE event happens?
>>=20
>> In OPEN event handling, vhost_user_blk_connect calls vhost_dev_init =
and encounters
>> an error such that s->connected remains false.
>> Next, after the CLOSE event arrives, it is found that s->connected is =
false, so nothing
>> is done, but the event handler will be cleaned up in =
`vhost_user_async_close`
>> before the CLOSE event is executed.
>>=20
>=20
> Got it - I see why the event handler is never re-installed in the code
> as it was before if we fail at get_features. That said, how do you
> explain your comment:

OK, I will update the commit message because this code has changed some =
months ago.

>=20
>>>> With this patch, the vhost_user_blk_disconnect will call the
>>>> vhost_dev_cleanup() again, it's safe.
>=20
> I see vhost_dev_cleanup() accessing hdev without even a NULL check. In
> the case we're talking about here I don't think it's a problem because
> if vhost_dev_init() fails, connected will be false and hit the goto
> but I am concerned that there could be double-frees or use-after-frees
> in other cases.

OK, you are right, with this patch, the vhost_dev_cleanup will not be
called multiple times now.

I think there is no need to worry about calling vhost_dev_cleanup =
multiple times,
because historically vhost_dev_cleanup has been allowed to be called =
multiple
times, and looking at the code, it can be found that calling =
vhost_dev_cleanup
multiple times is indeed safe.

Look this patch:

commit e0547b59dc0ead4c605d3f02d1c8829630a1311b
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Wed Jul 27 01:15:02 2016 +0400

    vhost: make vhost_dev_cleanup() idempotent

    It is called on multiple code path, so make it safe to call several
    times (note: I don't remember a reproducer here, but a function =
called
    'cleanup' should probably be idempotent in my book)

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks,
Li

>=20
>> Thanks,
>> Li
>>=20
>>>=20
>>>>=20
>>>> All vhost-user devices have this issue, including =
vhost-user-blk/scsi.
>>>>=20
>>>> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED =
handling")
>>>>=20
>>>> Signed-off-by: Li Feng <fengli@smartx.com>
>>>> ---
>>>> hw/block/vhost-user-blk.c   |  3 ++-
>>>> hw/scsi/vhost-user-scsi.c   |  3 ++-
>>>> hw/virtio/vhost-user-base.c |  3 ++-
>>>> hw/virtio/vhost-user.c      | 10 +---------
>>>> 4 files changed, 7 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>>> index 41d1ac3a5a..c6842ced48 100644
>>>> --- a/hw/block/vhost-user-blk.c
>>>> +++ b/hw/block/vhost-user-blk.c
>>>> @@ -353,7 +353,7 @@ static void =
vhost_user_blk_disconnect(DeviceState *dev)
>>>>    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>>>=20
>>>>    if (!s->connected) {
>>>> -        return;
>>>> +        goto done;
>>>>    }
>>>>    s->connected =3D false;
>>>>=20
>>>> @@ -361,6 +361,7 @@ static void =
vhost_user_blk_disconnect(DeviceState *dev)
>>>>=20
>>>>    vhost_dev_cleanup(&s->dev);
>>>>=20
>>>> +done:
>>>>    /* Re-instate the event handler for new connections */
>>>>    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, =
vhost_user_blk_event,
>>>>                             NULL, dev, NULL, true);
>>>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>>>> index 48a59e020e..b49a11d23b 100644
>>>> --- a/hw/scsi/vhost-user-scsi.c
>>>> +++ b/hw/scsi/vhost-user-scsi.c
>>>> @@ -181,7 +181,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState *dev)
>>>>    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>>>=20
>>>>    if (!s->connected) {
>>>> -        return;
>>>> +        goto done;
>>>>    }
>>>>    s->connected =3D false;
>>>>=20
>>>> @@ -189,6 +189,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState *dev)
>>>>=20
>>>>    vhost_dev_cleanup(&vsc->dev);
>>>>=20
>>>> +done:
>>>>    /* Re-instate the event handler for new connections */
>>>>    qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
>>>>                             vhost_user_scsi_event, NULL, dev, NULL, =
true);
>>>> diff --git a/hw/virtio/vhost-user-base.c =
b/hw/virtio/vhost-user-base.c
>>>> index 4b54255682..11e72b1e3b 100644
>>>> --- a/hw/virtio/vhost-user-base.c
>>>> +++ b/hw/virtio/vhost-user-base.c
>>>> @@ -225,13 +225,14 @@ static void vub_disconnect(DeviceState *dev)
>>>>    VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>>>>=20
>>>>    if (!vub->connected) {
>>>> -        return;
>>>> +        goto done;
>>>>    }
>>>>    vub->connected =3D false;
>>>>=20
>>>>    vub_stop(vdev);
>>>>    vhost_dev_cleanup(&vub->vhost_dev);
>>>>=20
>>>> +done:
>>>>    /* Re-instate the event handler for new connections */
>>>>    qemu_chr_fe_set_handlers(&vub->chardev,
>>>>                             NULL, NULL, vub_event,
>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>> index c929097e87..c407ea8939 100644
>>>> --- a/hw/virtio/vhost-user.c
>>>> +++ b/hw/virtio/vhost-user.c
>>>> @@ -2781,16 +2781,8 @@ typedef struct {
>>>> static void vhost_user_async_close_bh(void *opaque)
>>>> {
>>>>    VhostAsyncCallback *data =3D opaque;
>>>> -    struct vhost_dev *vhost =3D data->vhost;
>>>>=20
>>>> -    /*
>>>> -     * If the vhost_dev has been cleared in the meantime there is
>>>> -     * nothing left to do as some other path has completed the
>>>> -     * cleanup.
>>>> -     */
>>>> -    if (vhost->vdev) {
>>>> -        data->cb(data->dev);
>>>> -    }
>>>> +    data->cb(data->dev);
>>>>=20
>>>>    g_free(data);
>>>> }
>>>> --
>>>> 2.45.0


--Apple-Mail=_D91E6ED1-FD7E-49D4-8061-594537900F5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><br><blockquote =
type=3D"cite"><div>2024=E5=B9=B45=E6=9C=8815=E6=97=A5 23:47=EF=BC=8CRaphae=
l Norwitz &lt;raphael@enfabrica.net&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><=
br class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">The case your describing makes sense but =
now I have some concerns on</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">the =
vhost_dev_cleanup bit.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">On Wed, =
May 15, 2024 at 1:47=E2=80=AFAM Li Feng &lt;</span><a =
href=3D"mailto:fengli@smartx.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;">fengli@smartx.com</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; wrote:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"><br><br><br><blockquote type=3D"cite">2024=E5=B9=B45=E6=9C=8814=E6=97=
=A5 21:58=EF=BC=8CRaphael Norwitz &lt;raphael@enfabrica.net&gt; =
=E5=86=99=E9=81=93=EF=BC=9A<br><br>Code looks good. Just a question on =
the error case you're trying to fix.<br><br>On Tue, May 14, 2024 at =
2:12=E2=80=AFAM Li Feng &lt;fengli@smartx.com&gt; wrote:<br><blockquote =
type=3D"cite"><br>When the vhost-user is reconnecting to the backend, =
and if the vhost-user fails<br>at the get_features in vhost_dev_init(), =
then the reconnect will fail<br>and it will not be retriggered =
forever.<br><br>The reason is:<br>When the vhost-user fail at =
get_features, the vhost_dev_cleanup will be =
called<br>immediately.<br><br>vhost_dev_cleanup calls 'memset(hdev, 0, =
sizeof(struct vhost_dev))'.<br><br>The reconnect path =
is:<br>vhost_user_blk_event<br>&nbsp;vhost_user_async_close(.. =
vhost_user_blk_disconnect =
..)<br>&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers &lt;----- clear the =
notifier callback<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;schedule =
vhost_user_async_close_bh<br><br>The vhost-&gt;vdev is null, so the =
vhost_user_blk_disconnect will not be<br>called, then the event fd =
callback will not be reinstalled.<br><br>With this patch, the =
vhost_user_blk_disconnect will call the<br>vhost_dev_cleanup() again, =
it's safe.<br><br>In addition, the CLOSE event may occur in a scenario =
where connected is false.<br>At this time, the event handler will be =
cleared. We need to ensure that the<br>event handler can remain =
installed.<br></blockquote><br>Following on from the prior patch, why =
would "connected" be false when<br>a CLOSE event =
happens?<br></blockquote><br>In OPEN event handling, =
vhost_user_blk_connect calls vhost_dev_init and encounters<br>an error =
such that s-&gt;connected remains false.<br>Next, after the CLOSE event =
arrives, it is found that s-&gt;connected is false, so nothing<br>is =
done, but the event handler will be cleaned up in =
`vhost_user_async_close`<br>before the CLOSE event is =
executed.<br><br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Got it =
- I see why the event handler is never re-installed in the =
code</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">as it was before if we =
fail at get_features. That said, how do you</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">explain your comment:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><div><br></div>OK, I will update the commit =
message because this code has changed some months =
ago.</div><div><br><blockquote type=3D"cite"><div><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite"><blockquote type=3D"cite">With this patch, the =
vhost_user_blk_disconnect will call the<br>vhost_dev_cleanup() again, =
it's safe.<br></blockquote></blockquote></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I see vhost_dev_cleanup() accessing hdev =
without even a NULL check. In</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">the =
case we're talking about here I don't think it's a problem =
because</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">if vhost_dev_init() =
fails, connected will be false and hit the goto</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">but I am concerned that there could be =
double-frees or use-after-frees</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">in =
other cases.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote><br><div>OK, you are right, with this patch, =
the vhost_dev_cleanup will not be</div><div>called multiple times =
now.</div><div><br></div><div>I think there is no need to worry about =
calling vhost_dev_cleanup multiple times,</div><div>because historically =
vhost_dev_cleanup has been allowed to be called =
multiple</div><div>times, and looking at the code, it can be found that =
calling vhost_dev_cleanup</div><div>multiple times is indeed =
safe.</div><div><br></div><div>Look this =
patch:</div><div><br></div><div>commit =
e0547b59dc0ead4c605d3f02d1c8829630a1311b</div><div>Author: Marc-Andr=C3=A9=
 Lureau &lt;marcandre.lureau@redhat.com&gt;</div><div>Date: &nbsp; Wed =
Jul 27 01:15:02 2016 +0400</div><div><br></div><div>&nbsp; &nbsp; vhost: =
make vhost_dev_cleanup() idempotent</div><div><br></div><div>&nbsp; =
&nbsp; It is called on multiple code path, so make it safe to call =
several</div><div>&nbsp; &nbsp; times (note: I don't remember a =
reproducer here, but a function called</div><div>&nbsp; &nbsp; 'cleanup' =
should probably be idempotent in my =
book)</div><div><br></div><div>&nbsp; &nbsp; Signed-off-by: Marc-Andr=C3=A9=
 Lureau &lt;marcandre.lureau@redhat.com&gt;</div><div>&nbsp; &nbsp; =
Reviewed-by: Michael S. Tsirkin &lt;mst@redhat.com&gt;</div><div>&nbsp; =
&nbsp; Signed-off-by: Michael S. Tsirkin =
&lt;mst@redhat.com&gt;</div><div><br></div><div>Thanks,</div><div>Li</div>=
<div><br></div><blockquote type=3D"cite"><div><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;">Thanks,<br>Li<br><br><blockquote type=3D"cite"><br><blockquote =
type=3D"cite"><br>All vhost-user devices have this issue, including =
vhost-user-blk/scsi.<br><br>Fixes: 71e076a07d ("hw/virtio: generalise =
CHR_EVENT_CLOSED handling")<br><br>Signed-off-by: Li Feng =
&lt;fengli@smartx.com&gt;<br>---<br>hw/block/vhost-user-blk.c =
&nbsp;&nbsp;| &nbsp;3 ++-<br>hw/scsi/vhost-user-scsi.c &nbsp;&nbsp;| =
&nbsp;3 ++-<br>hw/virtio/vhost-user-base.c | &nbsp;3 =
++-<br>hw/virtio/vhost-user.c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 10 =
+---------<br>4 files changed, 7 insertions(+), 12 =
deletions(-)<br><br>diff --git a/hw/block/vhost-user-blk.c =
b/hw/block/vhost-user-blk.c<br>index 41d1ac3a5a..c6842ced48 =
100644<br>--- a/hw/block/vhost-user-blk.c<br>+++ =
b/hw/block/vhost-user-blk.c<br>@@ -353,7 +353,7 @@ static void =
vhost_user_blk_disconnect(DeviceState =
*dev)<br>&nbsp;&nbsp;&nbsp;VHostUserBlk *s =3D =
VHOST_USER_BLK(vdev);<br><br>&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) =
{<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
done;<br>&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;s-&gt;connected =3D =
false;<br><br>@@ -361,6 +361,7 @@ static void =
vhost_user_blk_disconnect(DeviceState =
*dev)<br><br>&nbsp;&nbsp;&nbsp;vhost_dev_cleanup(&amp;s-&gt;dev);<br><br>+=
done:<br>&nbsp;&nbsp;&nbsp;/* Re-instate the event handler for new =
connections =
*/<br>&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;s-&gt;chardev, =
NULL, NULL, =
vhost_user_blk_event,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NULL, dev, NULL, =
true);<br>diff --git a/hw/scsi/vhost-user-scsi.c =
b/hw/scsi/vhost-user-scsi.c<br>index 48a59e020e..b49a11d23b =
100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -181,7 +181,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState =
*dev)<br>&nbsp;&nbsp;&nbsp;VirtIOSCSICommon *vs =3D =
VIRTIO_SCSI_COMMON(dev);<br><br>&nbsp;&nbsp;&nbsp;if (!s-&gt;connected) =
{<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
done;<br>&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;s-&gt;connected =3D =
false;<br><br>@@ -189,6 +189,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState =
*dev)<br><br>&nbsp;&nbsp;&nbsp;vhost_dev_cleanup(&amp;vsc-&gt;dev);<br><br=
>+done:<br>&nbsp;&nbsp;&nbsp;/* Re-instate the event handler for new =
connections =
*/<br>&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vs-&gt;conf.chardev,=
 NULL, =
NULL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_user_scsi_event, NULL, dev, NULL, =
true);<br>diff --git a/hw/virtio/vhost-user-base.c =
b/hw/virtio/vhost-user-base.c<br>index 4b54255682..11e72b1e3b =
100644<br>--- a/hw/virtio/vhost-user-base.c<br>+++ =
b/hw/virtio/vhost-user-base.c<br>@@ -225,13 +225,14 @@ static void =
vub_disconnect(DeviceState *dev)<br>&nbsp;&nbsp;&nbsp;VHostUserBase *vub =
=3D VHOST_USER_BASE(vdev);<br><br>&nbsp;&nbsp;&nbsp;if =
(!vub-&gt;connected) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto =
done;<br>&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;vub-&gt;connected =3D =
false;<br><br>&nbsp;&nbsp;&nbsp;vub_stop(vdev);<br>&nbsp;&nbsp;&nbsp;vhost=
_dev_cleanup(&amp;vub-&gt;vhost_dev);<br><br>+done:<br>&nbsp;&nbsp;&nbsp;/=
* Re-instate the event handler for new connections =
*/<br>&nbsp;&nbsp;&nbsp;qemu_chr_fe_set_handlers(&amp;vub-&gt;chardev,<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;NULL, NULL, vub_event,<br>diff --git =
a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>index =
c929097e87..c407ea8939 100644<br>--- a/hw/virtio/vhost-user.c<br>+++ =
b/hw/virtio/vhost-user.c<br>@@ -2781,16 +2781,8 @@ typedef struct =
{<br>static void vhost_user_async_close_bh(void =
*opaque)<br>{<br>&nbsp;&nbsp;&nbsp;VhostAsyncCallback *data =3D =
opaque;<br>- &nbsp;&nbsp;&nbsp;struct vhost_dev *vhost =3D =
data-&gt;vhost;<br><br>- &nbsp;&nbsp;&nbsp;/*<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;* If the vhost_dev has been cleared in the =
meantime there is<br>- &nbsp;&nbsp;&nbsp;&nbsp;* nothing left to do as =
some other path has completed the<br>- &nbsp;&nbsp;&nbsp;&nbsp;* =
cleanup.<br>- &nbsp;&nbsp;&nbsp;&nbsp;*/<br>- &nbsp;&nbsp;&nbsp;if =
(vhost-&gt;vdev) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<br>- =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;data-&gt;cb(data-&gt;dev);<br><br>&nbsp;&nbsp;&nbsp;g_fr=
ee(data);<br>}<br>--<br>2.45.0</blockquote></blockquote></blockquote></div=
></blockquote></div><br></body></html>=

--Apple-Mail=_D91E6ED1-FD7E-49D4-8061-594537900F5D--

