Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C41F327BD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5xS-000440-Gf; Tue, 21 Apr 2026 03:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wF5xJ-00043d-AX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wF5xG-0007G3-IK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776758131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pze4sVW+77CULdSQxmo9DGZ0yfnEAJRwNVqseXPHGCY=;
 b=Q41Xyl6WV+ksa1rTIcvqBhvlDsFNGBejKpCKNu58SpVTwc0VgrYRHaJB3wTbUSHh4IjtoS
 9H7XANz25yKfrKuOSFhzslVoST9CrW9HLrdM4LPUAtX5wiwnfk4EX3NtAKmgcV92hzd63S
 04m1KeOykL+QLnBv8ALFc+LKOSwpqY4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-LpaQRhbNMWWHnI9nHDxNtQ-1; Tue, 21 Apr 2026 03:55:30 -0400
X-MC-Unique: LpaQRhbNMWWHnI9nHDxNtQ-1
X-Mimecast-MFC-AGG-ID: LpaQRhbNMWWHnI9nHDxNtQ_1776758129
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so9241127a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776758129; cv=none;
 d=google.com; s=arc-20240605;
 b=emGAevGly0fjaBYDhpgzE0dTZTGbHLop2Q2lhfkKE7dUN5aCT27lJ5fEgjgzAyU+9L
 mkCZ0Ow/UCIovSmy/EX7HX8KBkKkoMYo5LYFi8Gm14+zo31/p4ein/DClOO4Dk8JJl/9
 p2Yi90Kgk/s09n5zdor0nLsLy/fWm/MkQs1i8BEC3dKSKLW70xc7X9rx12xNtr+GeNdK
 KK5oUQVgHjNRpXK4QnFiam0e6zGtOIYyB8vaiMw2IdZ/NqxDjDOto/DbtXL9qPE4eM31
 4HR9vrTfD+OZu8MJb4r4HcPPschexkkBLZVLAB+tnmVjqPlZTBSku7Fi4+j8photuykc
 5bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pze4sVW+77CULdSQxmo9DGZ0yfnEAJRwNVqseXPHGCY=;
 fh=Xjt51VLi5u1w/oGGYLP5KXAPfcZj1HBbQ6fztbJKSz8=;
 b=J8LiFkOhD6t+1j+kmS8BP98hkj3Aiw6GOzOiHw+nXIVndGJe370q7f84Hx7No7Phty
 3HuNlNNf8F/mDS2uhhwunwf0Q6eJ5wjBFUJ60J+ph7ITx7u79RuM7YQPuMajrnqd280z
 eWsdv7b8GmLBIZt2xld8i66i8G/VZLaJ1HXmRr0NV4sCsHwYm0eK1fBRpY708HnhvO9w
 C6l12uIH4BejsTFW3heiPbEvQo9JwIDOegoGTrMHOOjYybSYlZycWHNNmqoKARFijBDR
 OsU4kzKxOZBCzh3WVRKGctUgElKJuHxzwj1l4hJY7NnM00rxkZOcAGPSWgdXOYFK7ClF
 AIdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776758129; x=1777362929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pze4sVW+77CULdSQxmo9DGZ0yfnEAJRwNVqseXPHGCY=;
 b=a3kcpcHeCezBbvthOigIms2dBKl1M8J5uEPPzAqqRPBitIPVXeKFrdJliR2fyuCZVC
 IauVpr3/ygv86tROpm2x46y8zlEAdfHafwpjYjOCv67gNgKBp/5z0RXH0rsjOg7v+/ry
 ixGCokNOJVsKswkaPORBddpiNLaCop0dyP0tCckm4S2uaBSjb/vh5a3njAzV9MVcukzD
 EOqH6bQR6QwLMcWTodgyQrh7fFH4PasO3MkJsJSp9m79NaIzhovCozDadVQWujzATkWm
 kKtOUnVfuQ2rKCtUvm/4YPafxOuSLVhMXW1cnDxh1JnLUehkkHU/iZycItLBV6L8uYbw
 991g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758129; x=1777362929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pze4sVW+77CULdSQxmo9DGZ0yfnEAJRwNVqseXPHGCY=;
 b=iM64tGa2bu+ttVTJV20TImJ0OOBwK+wLEC5tXZwy1Z1YJNiARMiWsNMJo1z2edXCeX
 6Pq8vK0xWyZvN0ruIMNRiQyu0sgoF38RB/D9mI8tR59c12sS4gVBQRrYXx331B3sX3hg
 m1duZesXTEZmgWEBAzFX1ZYpywJaYsRgsVaTyIKPujya3blPiIk+mqe3HFZxESQ7JXVj
 SzD8bXWZNZZRnbjf/XR9yFZ6gNeUd36YDxLBv0+G/j2+IxTMNjV2OPQO8aEbaLsxw+CB
 oLriKVh53hsEjEfyoUEtZY8mx/KB35XVcEj/w1520tCzChTgq5GgRLkEkemVicKuLXdl
 oB7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k9WQo9TjLPmxi38YS6xL/qXn0SV1dt4x+0wyGMVNcXbuFUp8kAUUjqKCSDugw+w3kEQBb+tmcNyr9@nongnu.org
X-Gm-Message-State: AOJu0Yz6sWRCq2HpODGFWv9f/QK1RbmGeW+UwtGagiEd4oTNx4cDits3
 1HeXwm88lCJJZlZf9ypTAbt1Bk6+aT/CxUv61/kF54dXwzbfAwv3ScCCdJBT9wU9Q3LC15BpsMb
 5WMmEqGTABVIJcpFr2USZvKI3UOrGAmqu+LI84I9pcqzFVE4AQEYyHZQn5W+1ZdUVVe7laES66z
 cvw2Al/qeVCtUZFyB4Li/LakKXdtT6NbA=
X-Gm-Gg: AeBDietmVgNfTL5Bx9pWN43fVrk/XpdWMSvTaV1BA4bS045uBG4gCZOV3L0th3skzLt
 ooMWSb0REIVQIHEFZUkwJkIy4tWO+QscN4aGIMCmp+Y0Rs5uQywqMhbCLASlEoMnBlcqk8CFCBU
 +3Zn0hqhTAQPjy0sBe86eqVdAjc4p4kO1aWZvbfdDqfqSJ4w3OJsZmkMI/TmtBDXZFhBQMGXFpa
 gHUhd40bhFhbhw=
X-Received: by 2002:a05:6a20:6a13:b0:398:d6a9:fc9 with SMTP id
 adf61e73a8af0-3a08d67bb60mr18771080637.5.1776758128808; 
 Tue, 21 Apr 2026 00:55:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a13:b0:398:d6a9:fc9 with SMTP id
 adf61e73a8af0-3a08d67bb60mr18771046637.5.1776758128222; Tue, 21 Apr 2026
 00:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
In-Reply-To: <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 09:55:16 +0200
X-Gm-Features: AQROBzBfAFy7nGQZvdgicFYsujMqcSW9fjP2mENgPBplgPdRvWwQEh0Zwlp073w
Message-ID: <CAGxU2F65wzpNJYgpjMbnc5iK8oNNsL3niF3pVmXhVU5PM34baA@mail.gmail.com>
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

On Tue, 21 Apr 2026 at 02:48, Jorge Moreira <jemoreira@google.com> wrote:
>
> > So it=E2=80=99s fine to continue in this direction, but I might add the=
se
> words more in the "Migration" section than here, since we=E2=80=99re talk=
ing
> about an optional state migration here. For example after "No further
> update must be done before rings are restarted."
> Or in the "Ring states" section, where we can clarify how to restart a
> ring after a migration. Or in both :-)
>
> I admit I don't know what that LOG_FD is for or what a "userfault-fd"
> is, so I don't know how they relate to vring state. The paragraph I
> modified discusses which part of the back-end state is in fact handled
> by the front-end, which somewhat matches the "vring-can/should-kick"
> idea. That being said, I don't have a strong preference for where this
> should go. Repeating it in "Ring states" makes sense to me.

I didn't express myself clearly, but my point is that discussing this
in the "Migrating back-end state" section is misleading. We should
address it first because it has nothing to do with state; it's also
needed for devices that don't require any state transfer.

>
>
> > QEMU's libvhost-user implementation already starts the ring when
> VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> waiting for the kick fd since a back-end that uses polling (peeking at
> the vring in memory) shouldn't need to monitor the kick fd. See below
> though about races between the kick fd and vhost-user protocol messages.

Just a note, we do the same in the rust-vmm vhost-user-backend crate as wel=
l.

> Starting rings when SET_VRING_KICK is received technically violates
> the vhost-user protocol as defined in the spec. QEMU may support
> back-ends behaving this way, but other VMMs may not. Changing the spec
> accordingly could potentially cause other implementations not
> depending on QEMU's libvhost-user to become non-compliant, I prefer to
> avoid this.

This is a good point and essentially what changed my mind.

However, this doesn't change anything for those frontends that also
send the kick (I don't know which ones do this, but QEMU doesn't, and
I don't think CH does either, since it uses the rust-vmm crates); they
continue to work just the same.

As for the backends, we=E2=80=99ve seen that both libvhost-user in QEMU and
vhost-user-backend in rust-vmm do exactly this (start vrings once
SET_VRING_KICK is received), so perhaps clarifying in this way isn't
too risky.

Do you know other backends we should check?

>
> > Note that monitoring the kick fd may be used to avoid races between
> > the kick fd and vhost-user protocol messages, so in practice back-end
> > implementors may still want to start the virtqueue when the kick fd
> > becomes readable
>
> Implementations having to do in practice what the spec says today is
> another reason not to change the it.
>
> While starting the vrings on SET_VRING_KICK could solve the state
> machine issue, it still won't notify the back-end that buffers are
> ready (the driver won't do this). Non-polling back-ends depend on this
> kick, especially for queues where data flows only from the driver to
> the back-end. Most implementations likely attempt to read from the
> queue only after receiving the kick.

Once the vrings are set, the VMM and the device have exactly the same
view of the vring state, so IMO the kick is just some extra step (I'm
fine to add it just because the spec wasn't clear). The device can
start in the same way without it.

>
> ------
> Thanks for the feedback! I'll wait for consensus before making further
> modifications.

Thanks!
Stefano

>
>
> On Mon, Apr 20, 2026 at 11:18=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 04:49:04PM +0200, Stefano Garzarella wrote:
> > > Thanks for starting the discussion here, let me add also Hanna, Germa=
n, and
> > > Stefan in CC that can help us.
> > >
> > > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > > > Migration of back-end state happens while the device is suspended (=
i.e
> > > > all vrings are stopped). To resume normal operation on the destinat=
ion,
> > > > the vrings need to be started again with a kick (either a write on =
the
> > > > FD or the VHOST_USER_VRING_KICK in-band message if negotiated). Whi=
le
> > >
> > > It's true that in the spec we have:
> > >   "Each ring is initialized in a stopped and disabled state. The   ba=
ck-end
> > > must start a ring upon receiving a kick (that is, detecting   that fi=
le
> > > descriptor is readable) on the descriptor specified by
> > > VHOST_USER_SET_VRING_KICK or receiving the in-band message
> > > VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
> > > VHOST_USER_GET_VRING_BASE."
> > >
> > > But IMO this applies when a driver is not yet loaded.
> > > When we are migrating, the driver could be already loaded. So, in the=
 new
> > > device running in the destination, IMO we should consider the ring al=
ready
> > > started or add some messages to tell to the device: "hey, the device =
was
> > > already started, this is a migration and it's completed".
> > >
> > > Sending a kick from the frontend, seems more an hack here.
> > >
> > > That said, for example, in subprojects/libvhost-user/libvhost-user.c =
IIUC
> > > the virtqueue is started when the SET_VRING_KICK is handled by
> > > vu_set_vring_kick_exec(), but not sure how compliant it is.
> > >
> > > > these notifications are typically sent by the driver, it has no rea=
son
> > > > to send them in the destination if it already sent them in the sour=
ce as
> > > > the driver is unaware that a migration took place. Therefore it sho=
uld
> > > > be the responsibility of the vhost-user front-end to ensure these v=
rings
> > > > are started. This is particularly necessary for queues where data o=
nly
> > > > flows from device to driver, such as those used by the vsock and in=
put
> > > > devices.
> > >
> > > Exactly, so IMO we should not use the kick, but maybe add something n=
ew or
> > > clarify what to do after the migration.
> > >
> > > For example in the "Migrating back-end state" we have:
> > >   "Migrating device state involves transferring the state from one
> > > back-end, called the source, to another back-end, called the   destin=
ation.
> > > After migration, the destination transparently resumes   operation wi=
thout
> > > requiring the driver to re-initialize the device at   the VIRTIO leve=
l."
> > >
> > > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly=
 to
> > > inform the new device about the state: "there isn't any state to tran=
sfer,
> > > but I notify you that the device was already initialized, so the vrin=
gs can
> > > be started".
> > >
> > > >
> > > > This behavior is already used by some qemu vhost-user front-ends (e=
.g
> > > > vhost-user-blk) and by front-ends implemented on other VMMs(e.g Cro=
sVm).
> > >
> > > I looked at vhost-user-blk frontend, but I don't see it. I mean I see=
 the
> > > code around the comment "/* Kick right away to begin processing reque=
sts
> > > already in vring */" but that one IIUC was introduced more to fix dev=
ices
> > > violating specs, so not sure it's a good example to follow:
> > >
> > > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > > Author: Yongji Xie <elohimes@gmail.com>
> > > Date:   Wed Jun 6 21:24:48 2018 +0800
> > >
> > >     vhost-user-blk: start vhost when guest kicks
> > >     Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs=
 early")
> > >     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This vio=
lates
> > >     the virtio spec. But virtio 1.0 transitional devices support this=
 behaviour.
> > >     So we should start vhost when guest kicks in this case.
> > >     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> > >     Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > >     Signed-off-by: Ni Xun <nixun@baidu.com>
> > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > > > Adding it to the vhost-user documentation makes it explicit that th=
is
> > > > strategy is permitted and suggest it to vhost-user front-end author=
s.
> > > > Explicitly documenting it is necessary because vring kicks appear
> > > > designed to originate in the driver, so having some originate in th=
e
> > > > front-end can be counterintuitive and cause developers to waste tim=
e
> > > > looking for other alternatives or face pushback during code review.
> > >
> > > As I pointed out in our discussion in
> > > https://github.com/rust-vmm/vhost-device/pull/936
> > > IMO we should use some in-band messages and not relaying on kicks tha=
t
> > > should be used only by the driver to notify the device about new avai=
lable
> > > buffers.
> > >
> > > That said, I agree that we need to clarify in the specifications exac=
tly
> > > what the backend and frontend should do after a migration to start vr=
ings if
> > > there is no need to exchange a state.
> > >
> > >
> > > Any other opinion?
> >
> > IMO no protocol changes are needed but the vhost-user spec should be
> > tweaked. Hanna worked on device state migration and can confirm/deny
> > what I'm about to describe.
> >
> > QEMU's libvhost-user implementation already starts the ring when
> > VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> > waiting for the kick fd since a back-end that uses polling (peeking at
> > the vring in memory) shouldn't need to monitor the kick fd. See below
> > though about races between the kick fd and vhost-user protocol messages=
.
> >
> > All of this boils down to the ring state machine. libvhost-user's
> > behavior is:
> > 1. Virtqueues are started by VHOST_USER_SET_VRING_KICK.
> > 2. Virtqueues are stopped by VHOST_USER_GET_VRING_BASE.
> > 3. Virtqueues are enabled/disabled by VHOST_USER_SET_VRING_ENABLE.
> >
> > The same sequence of vhost-user protocol messages that is used to
> > start/stop a device locally (e.g. pause and resume a VM) is the same
> > that can be used during migration. The ring state machine already exist=
s
> > and needs to be used when migrating device state.
> >
> > The following changes to the vhost-user spec would make this clearer:
> >
> > 1. Mention that virtqueues are started by VHOST_USER_SET_VRING_KICK.
> >    Note that monitoring the kick fd may be used to avoid races between
> >    the kick fd and vhost-user protocol messages, so in practice back-en=
d
> >    implementors may still want to start the virtqueue when the kick fd
> >    becomes readable.
> >
> > 2. Add a clarification to "Migrating back-end state" that the device
> >    must be suspended (see _suspended_device_state) when
> >    VHOST_USER_SET_DEVICE_STATE_FD is sent and device state is
> >    transferred. This is already implicit in "Device state transfer
> >    parameters", but it's not obvious when reading the "Migrating
> >    back-end state" section.
> >
> > Stefan
>


