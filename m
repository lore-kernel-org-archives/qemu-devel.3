Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC0F8FA9C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEIM-00042U-Bi; Tue, 21 Apr 2026 12:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFEIK-00042L-JJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFEIH-0003cb-Uk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776790187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EnHLkCJ78eZuiF6iUatZ+JyH/VzBHukoWXBkbkKCss=;
 b=Qp2khf8yqYHHvJNuo8ve2hfTvsgUusxKmWtJIJ9bXLowbtB1IPoSUOf9EaKV0tuV8wrBTN
 5kmdjScBBDrXu3s0jBdbZEYBEDVOUcJmodYhL83QqtjsZ4QBkPij4dO2pZDG19TE1p79kc
 5+nDBVHR/tAQh5RSoxuNmYRUiL8q0yw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yw0l6D80NY6sjFsTK88uOA-1; Tue, 21 Apr 2026 12:49:46 -0400
X-MC-Unique: yw0l6D80NY6sjFsTK88uOA-1
X-Mimecast-MFC-AGG-ID: yw0l6D80NY6sjFsTK88uOA_1776790185
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bce224720d8so2526391a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776790185; cv=none;
 d=google.com; s=arc-20240605;
 b=jBCJnLApAqngfx/hLqys17eKODo5uYsVR3G/ckgfJcD72aAW5v2LY4qmkEXz30j2dZ
 dO3iXN/XNGjzSvDVXJrPAo72GQPmUOqIaxglpM83/WbVmDXhsvtQxT+RkGpX2Jbs3MuK
 hOu9cgWJsFzqeAw1/L7kZEZK9G34XaYe40hYFc773exOfoppxxGi7TqNddxDrbh4n2Fr
 vpgp1GK96CFU4HLCzeALFlVDey6UrW13cbN/k01HlhbN4/rh4FGb82mHth1ksEqXAmDF
 xrqzAiOxVZdKHmhOnC198gWZcN1BwPLVgE0tCaY//nybX/+PKWSpbzJRQtNUCS/pjSDG
 +SOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3EnHLkCJ78eZuiF6iUatZ+JyH/VzBHukoWXBkbkKCss=;
 fh=GDjkLWRGkGK37l02jRRhBDCHdPTp5S0SLvg2QR6NxNA=;
 b=kwncAIGUC/JQ5Yjb2k8UzXny4091ToCOwpf1WRqsdguM/HituSvKvbsC/IKK3p0WCX
 3QtTx8wzDE8PpcPj9dlQO4X4YDk7Sh0XZr+cnqkQt/qfEMgtgTZyarTQknTOWhLfJ8zi
 UFqaIzldl47tvcJSa40YKCnWHFKDNW1GP305LKvDzCDyFBEWcf7grwkgVpAqneYjh5QU
 dgECTJtZIcGZZqHogpgBZFkAgqfEzbXToz7ACzWm6MTlmQZ7anhlsQ/PqP5YFrd9F4b6
 n+BPBI7z5is5QW91cnHucXrLZ5RCgwm3A7rXenebxKElQFxyJMi2DPhVCoBrhTlW4HkU
 YKqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776790185; x=1777394985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EnHLkCJ78eZuiF6iUatZ+JyH/VzBHukoWXBkbkKCss=;
 b=RYj9Vx0X/p0tkFS1knrHze2pUA+gpD5XCfhHr/miC/RaKsN7EtMQFHbmq7ieWnbaog
 I7nGtP/3JGdDRaqa3UD6YHlQiFL1XTGDq4YNNpkoS8OdITdZw4g4rrLEkr6pts2WDvSw
 olhaK3EPqjyFx1xBpz08Fc/WbmMU1sE6aLh0QNPhSHdgdibd2HFNncJmxgLBdVy+eCC9
 k8ublc52QYaElZUyMBk6Leasgc8L7v6fSUjTjqbLM7CcXSMqbpyYTXVx+IknAvJvBsxF
 d/9TOjkOxCPzx5kpARhyGlPhL/302lP9hTw1e69fdDvwAkr+3ZSKw0i2G5zwmrvQVN49
 hTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776790185; x=1777394985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3EnHLkCJ78eZuiF6iUatZ+JyH/VzBHukoWXBkbkKCss=;
 b=BDi3nKBkRrlbCH8Xm0nhFowyQrAZg8/CfLkrV2/lU6q3N/4cKKSerIUInXDB74wCK0
 CGIUzC6Kzj+p4PYxvWSL4p8mPYCBl98mdpmYMzoJlPmO+5kHBXRfdbxFn4mamRVdxkPD
 7Nto6Cy5kqwGWe+6af+5sarGrfZASM5NoxdzwpDxkvU6m2mkvglIITKDpfZW/eKK+8ff
 LxE/97ihspouKVeXMsnlYoOpR1acgu3xz8G/X6AfTujIq5uZPBveKAfCs6IKNbBSGmio
 WGWur6eWUyYvdI48ecQv52YsqhdlzW4MRfwbHXD89HWSxUZHzhKUEDxMg0KqhUwjByIV
 osdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+QhG3HbTB6xbTbO6tF2DRiUZ/y/Ok2B0pmlYki+44T0bxEN1d5KL//tcOavdbvnYBqx3JXlOsDiGG@nongnu.org
X-Gm-Message-State: AOJu0Yyby5PtsTmHnptL5tupEcA+vj/TV6Y/2022y2GNLu3SOLaXZN18
 ay9imQJHZ8ifh/mq9sRP6NH4AoBCgtrorMyFRRjn1bGp37lY/FuODHb6/IViiT9qkmANaneK32/
 iW2Wg7BxsW+Z2XQ1twBrtEOEkctsXYqhk42crx1KnJpmxhl2rkxAa5P14EoYe1+pxOCjpYLKLoa
 SBtNDsu+wLtaZe+Nuan6ZSXP6ckMTzVfE=
X-Gm-Gg: AeBDievlq+veY2KEVXNpju5LqoAcrf+/tLBa+U2C9FH5wltSHPltd3YBDtMy+l0V0Hy
 evNwsk7aIDR3lTQIRoDBiNemn3gDmpYhTEYoKMefLA3NyYUlRxCQ5YFc/uR3JYqAeW3DIbE3Hl3
 q/rMPITZ6n8kaY+4QdboZDAQM7bl/I+xkkSdLWvN2u9ppHxlKyu1yLYIeT7ZY+x8ExiCc+YS1KR
 NEZdYoq4NdJ+Bw=
X-Received: by 2002:a05:6a00:a24e:b0:82f:238f:b5a8 with SMTP id
 d2e1a72fcca58-82f8c84ea7amr17854399b3a.9.1776790184957; 
 Tue, 21 Apr 2026 09:49:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:a24e:b0:82f:238f:b5a8 with SMTP id
 d2e1a72fcca58-82f8c84ea7amr17854354b3a.9.1776790184087; Tue, 21 Apr 2026
 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <CAGxU2F65wzpNJYgpjMbnc5iK8oNNsL3niF3pVmXhVU5PM34baA@mail.gmail.com>
 <CAJi--PNdP+OxT6XAE7fjp01o5nX-bZPjBMmuaONrg1Gn_65qQA@mail.gmail.com>
In-Reply-To: <CAJi--PNdP+OxT6XAE7fjp01o5nX-bZPjBMmuaONrg1Gn_65qQA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 18:49:32 +0200
X-Gm-Features: AQROBzD98XoDXyCN8EkzbMx-hoClz5RGZ2sbSqCs3bYXdcJ6kuWIplnNPVT1o74
Message-ID: <CAGxU2F5y5omgvSUV+JQCAsUQVSQVkdzXhsS5QYysETerDjVkdA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 21 Apr 2026 at 18:06, Jorge Moreira <jemoreira@google.com> wrote:
>
> > Do you know other backends we should check?
>
> CrosVm's: https://github.com/google/crosvm/tree/main/devices/src/virtio/v=
host_user_backend

Which do exactly the same
https://github.com/google/crosvm/blob/b49e336de56d6353ae06245de0c7fabec3db2=
d5e/devices/src/virtio/vhost_user_backend/handler.rs#L596

No?


>
>
> On Tue, Apr 21, 2026 at 12:55=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >
> > On Tue, 21 Apr 2026 at 02:48, Jorge Moreira <jemoreira@google.com> wrot=
e:
> > >
> > > > So it=E2=80=99s fine to continue in this direction, but I might add=
 these
> > > words more in the "Migration" section than here, since we=E2=80=99re =
talking
> > > about an optional state migration here. For example after "No further
> > > update must be done before rings are restarted."
> > > Or in the "Ring states" section, where we can clarify how to restart =
a
> > > ring after a migration. Or in both :-)
> > >
> > > I admit I don't know what that LOG_FD is for or what a "userfault-fd"
> > > is, so I don't know how they relate to vring state. The paragraph I
> > > modified discusses which part of the back-end state is in fact handle=
d
> > > by the front-end, which somewhat matches the "vring-can/should-kick"
> > > idea. That being said, I don't have a strong preference for where thi=
s
> > > should go. Repeating it in "Ring states" makes sense to me.
> >
> > I didn't express myself clearly, but my point is that discussing this
> > in the "Migrating back-end state" section is misleading. We should
> > address it first because it has nothing to do with state; it's also
> > needed for devices that don't require any state transfer.
> >
> > >
> > >
> > > > QEMU's libvhost-user implementation already starts the ring when
> > > VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> > > waiting for the kick fd since a back-end that uses polling (peeking a=
t
> > > the vring in memory) shouldn't need to monitor the kick fd. See below
> > > though about races between the kick fd and vhost-user protocol messag=
es.
> >
> > Just a note, we do the same in the rust-vmm vhost-user-backend crate as=
 well.
> >
> > > Starting rings when SET_VRING_KICK is received technically violates
> > > the vhost-user protocol as defined in the spec. QEMU may support
> > > back-ends behaving this way, but other VMMs may not. Changing the spe=
c
> > > accordingly could potentially cause other implementations not
> > > depending on QEMU's libvhost-user to become non-compliant, I prefer t=
o
> > > avoid this.
> >
> > This is a good point and essentially what changed my mind.
> >
> > However, this doesn't change anything for those frontends that also
> > send the kick (I don't know which ones do this, but QEMU doesn't, and
> > I don't think CH does either, since it uses the rust-vmm crates); they
> > continue to work just the same.
> >
> > As for the backends, we=E2=80=99ve seen that both libvhost-user in QEMU=
 and
> > vhost-user-backend in rust-vmm do exactly this (start vrings once
> > SET_VRING_KICK is received), so perhaps clarifying in this way isn't
> > too risky.
> >
> > Do you know other backends we should check?
> >
> > >
> > > > Note that monitoring the kick fd may be used to avoid races between
> > > > the kick fd and vhost-user protocol messages, so in practice back-e=
nd
> > > > implementors may still want to start the virtqueue when the kick fd
> > > > becomes readable
> > >
> > > Implementations having to do in practice what the spec says today is
> > > another reason not to change the it.
> > >
> > > While starting the vrings on SET_VRING_KICK could solve the state
> > > machine issue, it still won't notify the back-end that buffers are
> > > ready (the driver won't do this). Non-polling back-ends depend on thi=
s
> > > kick, especially for queues where data flows only from the driver to
> > > the back-end. Most implementations likely attempt to read from the
> > > queue only after receiving the kick.
> >
> > Once the vrings are set, the VMM and the device have exactly the same
> > view of the vring state, so IMO the kick is just some extra step (I'm
> > fine to add it just because the spec wasn't clear). The device can
> > start in the same way without it.
> >
> > >
> > > ------
> > > Thanks for the feedback! I'll wait for consensus before making furthe=
r
> > > modifications.
> >
> > Thanks!
> > Stefano
> >
> > >
> > >
> > > On Mon, Apr 20, 2026 at 11:18=E2=80=AFAM Stefan Hajnoczi <stefanha@re=
dhat.com> wrote:
> > > >
> > > > On Mon, Apr 20, 2026 at 04:49:04PM +0200, Stefano Garzarella wrote:
> > > > > Thanks for starting the discussion here, let me add also Hanna, G=
erman, and
> > > > > Stefan in CC that can help us.
> > > > >
> > > > > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > > > > > Migration of back-end state happens while the device is suspend=
ed (i.e
> > > > > > all vrings are stopped). To resume normal operation on the dest=
ination,
> > > > > > the vrings need to be started again with a kick (either a write=
 on the
> > > > > > FD or the VHOST_USER_VRING_KICK in-band message if negotiated).=
 While
> > > > >
> > > > > It's true that in the spec we have:
> > > > >   "Each ring is initialized in a stopped and disabled state. The =
  back-end
> > > > > must start a ring upon receiving a kick (that is, detecting   tha=
t file
> > > > > descriptor is readable) on the descriptor specified by
> > > > > VHOST_USER_SET_VRING_KICK or receiving the in-band message
> > > > > VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receivi=
ng
> > > > > VHOST_USER_GET_VRING_BASE."
> > > > >
> > > > > But IMO this applies when a driver is not yet loaded.
> > > > > When we are migrating, the driver could be already loaded. So, in=
 the new
> > > > > device running in the destination, IMO we should consider the rin=
g already
> > > > > started or add some messages to tell to the device: "hey, the dev=
ice was
> > > > > already started, this is a migration and it's completed".
> > > > >
> > > > > Sending a kick from the frontend, seems more an hack here.
> > > > >
> > > > > That said, for example, in subprojects/libvhost-user/libvhost-use=
r.c IIUC
> > > > > the virtqueue is started when the SET_VRING_KICK is handled by
> > > > > vu_set_vring_kick_exec(), but not sure how compliant it is.
> > > > >
> > > > > > these notifications are typically sent by the driver, it has no=
 reason
> > > > > > to send them in the destination if it already sent them in the =
source as
> > > > > > the driver is unaware that a migration took place. Therefore it=
 should
> > > > > > be the responsibility of the vhost-user front-end to ensure the=
se vrings
> > > > > > are started. This is particularly necessary for queues where da=
ta only
> > > > > > flows from device to driver, such as those used by the vsock an=
d input
> > > > > > devices.
> > > > >
> > > > > Exactly, so IMO we should not use the kick, but maybe add somethi=
ng new or
> > > > > clarify what to do after the migration.
> > > > >
> > > > > For example in the "Migrating back-end state" we have:
> > > > >   "Migrating device state involves transferring the state from on=
e
> > > > > back-end, called the source, to another back-end, called the   de=
stination.
> > > > > After migration, the destination transparently resumes   operatio=
n without
> > > > > requiring the driver to re-initialize the device at   the VIRTIO =
level."
> > > > >
> > > > > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exa=
ctly to
> > > > > inform the new device about the state: "there isn't any state to =
transfer,
> > > > > but I notify you that the device was already initialized, so the =
vrings can
> > > > > be started".
> > > > >
> > > > > >
> > > > > > This behavior is already used by some qemu vhost-user front-end=
s (e.g
> > > > > > vhost-user-blk) and by front-ends implemented on other VMMs(e.g=
 CrosVm).
> > > > >
> > > > > I looked at vhost-user-blk frontend, but I don't see it. I mean I=
 see the
> > > > > code around the comment "/* Kick right away to begin processing r=
equests
> > > > > already in vring */" but that one IIUC was introduced more to fix=
 devices
> > > > > violating specs, so not sure it's a good example to follow:
> > > > >
> > > > > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > > > > Author: Yongji Xie <elohimes@gmail.com>
> > > > > Date:   Wed Jun 6 21:24:48 2018 +0800
> > > > >
> > > > >     vhost-user-blk: start vhost when guest kicks
> > > > >     Some old guests (before commit 7a11370e5: "virtio_blk: enable=
 VQs early")
> > > > >     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This=
 violates
> > > > >     the virtio spec. But virtio 1.0 transitional devices support =
this behaviour.
> > > > >     So we should start vhost when guest kicks in this case.
> > > > >     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> > > > >     Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > > > >     Signed-off-by: Ni Xun <nixun@baidu.com>
> > > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > >
> > > > >
> > > > > > Adding it to the vhost-user documentation makes it explicit tha=
t this
> > > > > > strategy is permitted and suggest it to vhost-user front-end au=
thors.
> > > > > > Explicitly documenting it is necessary because vring kicks appe=
ar
> > > > > > designed to originate in the driver, so having some originate i=
n the
> > > > > > front-end can be counterintuitive and cause developers to waste=
 time
> > > > > > looking for other alternatives or face pushback during code rev=
iew.
> > > > >
> > > > > As I pointed out in our discussion in
> > > > > https://github.com/rust-vmm/vhost-device/pull/936
> > > > > IMO we should use some in-band messages and not relaying on kicks=
 that
> > > > > should be used only by the driver to notify the device about new =
available
> > > > > buffers.
> > > > >
> > > > > That said, I agree that we need to clarify in the specifications =
exactly
> > > > > what the backend and frontend should do after a migration to star=
t vrings if
> > > > > there is no need to exchange a state.
> > > > >
> > > > >
> > > > > Any other opinion?
> > > >
> > > > IMO no protocol changes are needed but the vhost-user spec should b=
e
> > > > tweaked. Hanna worked on device state migration and can confirm/den=
y
> > > > what I'm about to describe.
> > > >
> > > > QEMU's libvhost-user implementation already starts the ring when
> > > > VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> > > > waiting for the kick fd since a back-end that uses polling (peeking=
 at
> > > > the vring in memory) shouldn't need to monitor the kick fd. See bel=
ow
> > > > though about races between the kick fd and vhost-user protocol mess=
ages.
> > > >
> > > > All of this boils down to the ring state machine. libvhost-user's
> > > > behavior is:
> > > > 1. Virtqueues are started by VHOST_USER_SET_VRING_KICK.
> > > > 2. Virtqueues are stopped by VHOST_USER_GET_VRING_BASE.
> > > > 3. Virtqueues are enabled/disabled by VHOST_USER_SET_VRING_ENABLE.
> > > >
> > > > The same sequence of vhost-user protocol messages that is used to
> > > > start/stop a device locally (e.g. pause and resume a VM) is the sam=
e
> > > > that can be used during migration. The ring state machine already e=
xists
> > > > and needs to be used when migrating device state.
> > > >
> > > > The following changes to the vhost-user spec would make this cleare=
r:
> > > >
> > > > 1. Mention that virtqueues are started by VHOST_USER_SET_VRING_KICK=
.
> > > >    Note that monitoring the kick fd may be used to avoid races betw=
een
> > > >    the kick fd and vhost-user protocol messages, so in practice bac=
k-end
> > > >    implementors may still want to start the virtqueue when the kick=
 fd
> > > >    becomes readable.
> > > >
> > > > 2. Add a clarification to "Migrating back-end state" that the devic=
e
> > > >    must be suspended (see _suspended_device_state) when
> > > >    VHOST_USER_SET_DEVICE_STATE_FD is sent and device state is
> > > >    transferred. This is already implicit in "Device state transfer
> > > >    parameters", but it's not obvious when reading the "Migrating
> > > >    back-end state" section.
> > > >
> > > > Stefan
> > >
> >
>


