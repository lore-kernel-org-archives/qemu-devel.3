Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A22AF5A8CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 00:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEzI7-0001pr-IL; Mon, 20 Apr 2026 20:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wEzI1-0001pd-DZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 20:48:33 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wEzHw-0004Mm-5T
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 20:48:32 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50e61648f10so965861cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 17:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732506; cv=none;
 d=google.com; s=arc-20240605;
 b=W2ZZX2tg+tIVLD2WnNrcEps0B/xOcLIsUujYHHwRCoDNO5J+mVWUtcMwHnnIgkicKa
 Uo3EWdmkPfC0womWagowr6EganZmO56oLSAExMMAUYWNQnQMZ8WvOa8hFYOXZrk1EjDc
 3pswWgwKpdzxatjhGuUh1sPUPDkTE/5yOGDPGAbG+8SxHjWv1yBy54lfU6SSYlavgfxG
 dYkHSarXVHv39VdnWiKWll1OAzkrB7/YfMlsDB2c2NLuaAcx4XLwXPPpLf1nAzafHhK+
 +8lfWwc1lIwuZ7rTL7CvnRsQaDjeHuVHIUu5b1fRqn4vmwBaJCO8MD7iX30lwbrGVgEq
 u3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BxQGPDd4zb72v/YUSL4sDbLy+DRcDgGqaCB550JFJ8Y=;
 fh=QQFBIrCQWPNAjZeDxwbTVz8vjK262aL8lzcsqS5DM7k=;
 b=MysSw2RL9zACrzcjUlpzb4EKbYDylNlKWAp0Yv9hSSWRPg24icIe6NFpWqNS+E0Ufo
 LlAsU+3pt/KycZAPRgIeDAFSlGmDlMKkhLBWlshMENDj+MbHmA8iW+/f5PutCPV/lcxi
 a4SX3aiYAwMA6CgcHHXD2AJb6SW9tJxZrtWuLaUm11cRXoqAxSA9r2t1PewaOL5WaFHB
 Q/KpFhqw91x6wVYesP34u9wk9qrGq/wfVBhqzZGPgn3toYL1rg0eIF+NZROpu8SnyKNb
 mHtbqrceHtyeXTeSifokUkSPq3svHTvt5UGqqv2kse8vyDi7ELmtpaSGa/5743PF18E6
 90fA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776732506; x=1777337306; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxQGPDd4zb72v/YUSL4sDbLy+DRcDgGqaCB550JFJ8Y=;
 b=SBlIfDCeY31W4O5RLnpPsbz80B0lEtdlNG/xmX82JHDMvDZPfTJOP4whuIlgyb7jqk
 dOEhpuo8sG6daWcBb/PTcuLQMNlhZYRNSX62rcgvstz+VXrOjuMJ+fypyiFfBr9fBzQQ
 B0Ay01j4W+tcWng7CpQHQ5ZB9flRjF8Iylg6i7HTNQ/X6nGQkRVQEGrpib1Cs/qhOwvZ
 u5MkLe9Upakd7Q9hKOSWmT9mimLlTBterzfhegE/ny9uVDr6jOYCcZtPaxPHMWmWd+ZO
 +fLQVUReXFNOSL9n7ZuTyiXsDMIB7IsiFF8a1nU5BQhz3y5NZ0/uweGnkKYmR6GQVGm9
 ErKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776732506; x=1777337306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BxQGPDd4zb72v/YUSL4sDbLy+DRcDgGqaCB550JFJ8Y=;
 b=OHKyFhuJv16EmKUKpNfbgu1DgMXn4L+K5KEO8I8ncK7KNkgYH8b8L6u8fe30RBaGY2
 oQxBqV+pas0eiIOTe3qyjOjwiROrOXITw5bR0D7WZQlp9oEqLQ63wIjQaTMdAwHdHLbK
 ZSVjLGj9sQF9tZ1O7LRGHfmjdDnjNfzjU4rtmEAdsJvNqQHK2nE+YMD3Tf9u3m+OSbct
 kvz5NtpyCUo3uLAEKTj6QqkTPrwxD9K5urFv8Bbe5WJvmJIH2zDLh6dLyS2KXBi6c8iY
 d/18CX0DhX6TamrzXlRP8hqZtH75rkNF2Nm2AQUetEzVIBPnIcNr2QBJ0n3XPv+F9xxB
 hwdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JEn13eqLbcvZGeJOf+AVbJVNhVHp1mZOU2pLKKrDrX7UZC7QLU5FMLB7zlljh9ZXnJDcxLZO+DSbt@nongnu.org
X-Gm-Message-State: AOJu0YzQqumNcOFnNoLrXXMceuTJu6GFBWpoC31wvHTIvVdcWqZ6NAzR
 1k5AJn4yUx8pYhSR7TDNlCeFsEZJYNO3eiWfx1/naXkOgQJUWse1GouXbvnVxJfbmiZXejJpZ2R
 KHbAac8KVgicWW2MLoGcyZgtSvvCeHfDnmURumNIk
X-Gm-Gg: AeBDiev7ti0JbqTSnx/3HBuP/XiWn8zWE2qi9LMmlRTyPMUTXv6pVfQH5XGINQpIjTl
 wBdb9ydt1X18XiiF03UKmBs3j3ll1LBalujAiU2Q5bF0y3oRD4PQUHT1LtcO9TEtSEwIs19F3qo
 Cy0LTdxboyXDmr9tH9rFIYKGV65cQAoBEZjN2G9fBsws8N3aPERJ+zsPXcoeJbUXfVMQpl0RR6m
 zzYQFGfAXlBys6yKXK8SDJ2YPMCKnGPT25zqKwO/S0h97T/9re2Y9NkCCwLZAhE3O2ddqhwijgf
 iUKfg55JbrLdTfcwG1sNKoSYCu+6VO1fpNN41Xt2PzN0z6VO1wlQ8xfqIg==
X-Received: by 2002:a05:622a:b:b0:509:15b6:f6a0 with SMTP id
 d75a77b69052e-50e42a58beemr39744331cf.6.1776732505226; Mon, 20 Apr 2026
 17:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
In-Reply-To: <20260420181818.GC405461@fedora>
From: Jorge Moreira <jemoreira@google.com>
Date: Mon, 20 Apr 2026 17:48:13 -0700
X-Gm-Features: AQROBzAkFLeVjtQeGjPubrU84dMX6RfbBqE8qCUMZFemWtCI-WAVhVG4CqBRuHM
Message-ID: <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=jemoreira@google.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

> So it=E2=80=99s fine to continue in this direction, but I might add these
words more in the "Migration" section than here, since we=E2=80=99re talkin=
g
about an optional state migration here. For example after "No further
update must be done before rings are restarted."
Or in the "Ring states" section, where we can clarify how to restart a
ring after a migration. Or in both :-)

I admit I don't know what that LOG_FD is for or what a "userfault-fd"
is, so I don't know how they relate to vring state. The paragraph I
modified discusses which part of the back-end state is in fact handled
by the front-end, which somewhat matches the "vring-can/should-kick"
idea. That being said, I don't have a strong preference for where this
should go. Repeating it in "Ring states" makes sense to me.


> QEMU's libvhost-user implementation already starts the ring when
VHOST_USER_SET_VRING_KICK is received. This makes more sense than
waiting for the kick fd since a back-end that uses polling (peeking at
the vring in memory) shouldn't need to monitor the kick fd. See below
though about races between the kick fd and vhost-user protocol messages.

Starting rings when SET_VRING_KICK is received technically violates
the vhost-user protocol as defined in the spec. QEMU may support
back-ends behaving this way, but other VMMs may not. Changing the spec
accordingly could potentially cause other implementations not
depending on QEMU's libvhost-user to become non-compliant, I prefer to
avoid this.

> Note that monitoring the kick fd may be used to avoid races between
> the kick fd and vhost-user protocol messages, so in practice back-end
> implementors may still want to start the virtqueue when the kick fd
> becomes readable

Implementations having to do in practice what the spec says today is
another reason not to change the it.

While starting the vrings on SET_VRING_KICK could solve the state
machine issue, it still won't notify the back-end that buffers are
ready (the driver won't do this). Non-polling back-ends depend on this
kick, especially for queues where data flows only from the driver to
the back-end. Most implementations likely attempt to read from the
queue only after receiving the kick.

------
Thanks for the feedback! I'll wait for consensus before making further
modifications.


On Mon, Apr 20, 2026 at 11:18=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Apr 20, 2026 at 04:49:04PM +0200, Stefano Garzarella wrote:
> > Thanks for starting the discussion here, let me add also Hanna, German,=
 and
> > Stefan in CC that can help us.
> >
> > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > > Migration of back-end state happens while the device is suspended (i.=
e
> > > all vrings are stopped). To resume normal operation on the destinatio=
n,
> > > the vrings need to be started again with a kick (either a write on th=
e
> > > FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
> >
> > It's true that in the spec we have:
> >   "Each ring is initialized in a stopped and disabled state. The   back=
-end
> > must start a ring upon receiving a kick (that is, detecting   that file
> > descriptor is readable) on the descriptor specified by
> > VHOST_USER_SET_VRING_KICK or receiving the in-band message
> > VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
> > VHOST_USER_GET_VRING_BASE."
> >
> > But IMO this applies when a driver is not yet loaded.
> > When we are migrating, the driver could be already loaded. So, in the n=
ew
> > device running in the destination, IMO we should consider the ring alre=
ady
> > started or add some messages to tell to the device: "hey, the device wa=
s
> > already started, this is a migration and it's completed".
> >
> > Sending a kick from the frontend, seems more an hack here.
> >
> > That said, for example, in subprojects/libvhost-user/libvhost-user.c II=
UC
> > the virtqueue is started when the SET_VRING_KICK is handled by
> > vu_set_vring_kick_exec(), but not sure how compliant it is.
> >
> > > these notifications are typically sent by the driver, it has no reaso=
n
> > > to send them in the destination if it already sent them in the source=
 as
> > > the driver is unaware that a migration took place. Therefore it shoul=
d
> > > be the responsibility of the vhost-user front-end to ensure these vri=
ngs
> > > are started. This is particularly necessary for queues where data onl=
y
> > > flows from device to driver, such as those used by the vsock and inpu=
t
> > > devices.
> >
> > Exactly, so IMO we should not use the kick, but maybe add something new=
 or
> > clarify what to do after the migration.
> >
> > For example in the "Migrating back-end state" we have:
> >   "Migrating device state involves transferring the state from one
> > back-end, called the source, to another back-end, called the   destinat=
ion.
> > After migration, the destination transparently resumes   operation with=
out
> > requiring the driver to re-initialize the device at   the VIRTIO level.=
"
> >
> > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly t=
o
> > inform the new device about the state: "there isn't any state to transf=
er,
> > but I notify you that the device was already initialized, so the vrings=
 can
> > be started".
> >
> > >
> > > This behavior is already used by some qemu vhost-user front-ends (e.g
> > > vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosV=
m).
> >
> > I looked at vhost-user-blk frontend, but I don't see it. I mean I see t=
he
> > code around the comment "/* Kick right away to begin processing request=
s
> > already in vring */" but that one IIUC was introduced more to fix devic=
es
> > violating specs, so not sure it's a good example to follow:
> >
> > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > Author: Yongji Xie <elohimes@gmail.com>
> > Date:   Wed Jun 6 21:24:48 2018 +0800
> >
> >     vhost-user-blk: start vhost when guest kicks
> >     Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs e=
arly")
> >     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This viola=
tes
> >     the virtio spec. But virtio 1.0 transitional devices support this b=
ehaviour.
> >     So we should start vhost when guest kicks in this case.
> >     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> >     Signed-off-by: Chai Wen <chaiwen@baidu.com>
> >     Signed-off-by: Ni Xun <nixun@baidu.com>
> >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >
> > > Adding it to the vhost-user documentation makes it explicit that this
> > > strategy is permitted and suggest it to vhost-user front-end authors.
> > > Explicitly documenting it is necessary because vring kicks appear
> > > designed to originate in the driver, so having some originate in the
> > > front-end can be counterintuitive and cause developers to waste time
> > > looking for other alternatives or face pushback during code review.
> >
> > As I pointed out in our discussion in
> > https://github.com/rust-vmm/vhost-device/pull/936
> > IMO we should use some in-band messages and not relaying on kicks that
> > should be used only by the driver to notify the device about new availa=
ble
> > buffers.
> >
> > That said, I agree that we need to clarify in the specifications exactl=
y
> > what the backend and frontend should do after a migration to start vrin=
gs if
> > there is no need to exchange a state.
> >
> >
> > Any other opinion?
>
> IMO no protocol changes are needed but the vhost-user spec should be
> tweaked. Hanna worked on device state migration and can confirm/deny
> what I'm about to describe.
>
> QEMU's libvhost-user implementation already starts the ring when
> VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> waiting for the kick fd since a back-end that uses polling (peeking at
> the vring in memory) shouldn't need to monitor the kick fd. See below
> though about races between the kick fd and vhost-user protocol messages.
>
> All of this boils down to the ring state machine. libvhost-user's
> behavior is:
> 1. Virtqueues are started by VHOST_USER_SET_VRING_KICK.
> 2. Virtqueues are stopped by VHOST_USER_GET_VRING_BASE.
> 3. Virtqueues are enabled/disabled by VHOST_USER_SET_VRING_ENABLE.
>
> The same sequence of vhost-user protocol messages that is used to
> start/stop a device locally (e.g. pause and resume a VM) is the same
> that can be used during migration. The ring state machine already exists
> and needs to be used when migrating device state.
>
> The following changes to the vhost-user spec would make this clearer:
>
> 1. Mention that virtqueues are started by VHOST_USER_SET_VRING_KICK.
>    Note that monitoring the kick fd may be used to avoid races between
>    the kick fd and vhost-user protocol messages, so in practice back-end
>    implementors may still want to start the virtqueue when the kick fd
>    becomes readable.
>
> 2. Add a clarification to "Migrating back-end state" that the device
>    must be suspended (see _suspended_device_state) when
>    VHOST_USER_SET_DEVICE_STATE_FD is sent and device state is
>    transferred. This is already implicit in "Device state transfer
>    parameters", but it's not obvious when reading the "Migrating
>    back-end state" section.
>
> Stefan

