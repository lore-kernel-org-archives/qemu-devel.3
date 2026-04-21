Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A6F8FA9A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDdF-0007hb-3h; Tue, 21 Apr 2026 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFDcZ-0007Xs-OH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:06:46 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wFDcW-0006nL-CG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:06:42 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-50d836552daso2284691cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776787599; cv=none;
 d=google.com; s=arc-20240605;
 b=HeuJXXe7T9AXplCTcN9HR71DZj2btsqhhXRwmr0njyuaEGssQyDt4E9aoXBGdKQy0N
 U6ihc558brbkSGiow1QtCeoTYlWT/hqik1Iv7oLYFgq3EcWFv8btB8LRDsbPLuBQpkeD
 iHIRtFYU7hzzaidfRv7c4KxqXW4t7AOSEFAje+x6jxP/rs5+E9r3mcplL3oq+OERq9Dn
 5Yu41coCVqrObBappKDiSwg4a6t25PrFqI4SqQOEsaFS0pJtWSXeTVtF3xbK+12HXVgA
 VkGUyyA9aGQun5ga6vQFhsUiFlnlhp7LS5fwIvNw1+998ylcX6A8fqYVXIpCx9EzONpW
 IPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bVGS/3RarJvJ30Ymm2NL8qEpb9kv7rqqhGlxv+oVcPo=;
 fh=9p3Q9JPmYlX41moP6vt7sPSIGse5ar2/3ixaEYdW2l4=;
 b=CYOQHbptZYaqeRZG1tFhBVSpLTUc9kcRdupUSC+MjRKAbC6Z2vZb0TbArsqWgs/5ty
 /JYorIIRKQ6fBZLpTGlas2/F2l37lFC205n7RUdMiT5C5fG3Y6U7hbGFDONtgEu8bfGc
 Aixfzssu8KBtPTKryp/1lP2k+qfnhhP3u92VfSwIVldeVyXMtOzV0jzu3w6kKHDRRyM2
 NkPAu4rfOOHF2jz+SU1qR3qYs67Z2y6F+e3nlvcjf5mjvF8iWuznM3+aEZwEo524nqYB
 C7+9qbYhPlCUPWdq4KTNTbTU4EQz+4V9xVdWsbRdNHEN0WAOMJWDtbgjHrUHuoZd6yWG
 Lg8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776787599; x=1777392399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVGS/3RarJvJ30Ymm2NL8qEpb9kv7rqqhGlxv+oVcPo=;
 b=jdX9e4tgTv5Kl05CgtfNRKesAlyzqdjtAVPZO5E7Qcg7cqCrz3lK4uRKfGerBryq8P
 rzhQtiPv1P8uRJ3VWzWJmH4wTrGaA1AwKOsXy6hn7XFyLptgF/TkLm6Lt+6dkYc2bd7w
 rqeaRWBa28z7l8c8NuXDImDZ5MzIq2Zu2wTCB4Z0k6uTnm6vYO0Z1ICWghOpH3Wf3nA5
 D7SI0bwBtyo9xLkbOxDxtg2PqUk4mhBV1RolFzQGqI56yINX4cf/HedYPr8atnA7hUcx
 elRkQgR6vMDmM8GCsXtU5nEzwjryvpxWdqK/Vm15bUeR8TcuR6dBEhtLnPbnlJ8YVzj1
 E98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787599; x=1777392399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVGS/3RarJvJ30Ymm2NL8qEpb9kv7rqqhGlxv+oVcPo=;
 b=rY5PVfgGvohjpOhfZZm+7sbTbVyZfNuZYdPpz4ibj61ugiX6gknHG23xcRoihA1Itv
 TKY/qLnYcUMWZrUvgOgwCn5kcuNvp/tRvAveCk5C/l9zuzPPQBxB8US7qh1M035WvBRe
 /hjQg26bZfe2sc/e/8Njey0bRKoJwXMyNswSORqqPX8yecO3M2vqi5hjpUAeim3x9+Iu
 73ZigW3H1KznaSXbxkGjQJFijZ63XOGjyb/3PNxHculQMbQKaZmtwiQfQ2+0L95oHaxq
 nLshxnK4LAMmKdwOW0Sgv4WskZoWlJvtDCWsay36PGVaMb3DTtmz/y4tFHS51CD70eP7
 xumg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Hq1auw2mVbZPEjpCgxzDeLSAXPHL+ENRvgAmvQBy6fDkbh+LlRavJlohmr64m7RGxD+i1+kYx1WbC@nongnu.org
X-Gm-Message-State: AOJu0YxsO6xtTvqIxM+NKxjt8giG8wA7huGSSV19pO9ZAd1u4r1WhdQv
 Y/VYpWjaIcXIk2IuesQnFQvaIcZ44pJ76QkBFrnGjeJjPsbLu0+cko0kdLgKdrAm+Fu3/IV7HHf
 TjrGVQIBT5XtKK5c/Mh9vCkfrOsrBn0rwRjHitmsd
X-Gm-Gg: AeBDiet/1pjAF99IpQ6j9+DIQYBmS3HWjnMKq8RbCKPNprioMgi7d9FKJAfw4kk0RI5
 lMGQqb5iKKnpV2zkH7R9aVokpvxNjbAmxFApxjJyiAtHalJEN2PsRSSujtobYs78T0gyOJpp44q
 rkojZevBKdFNUWv1RKeBeG79WnJ5YbvVik7hfCyOj1KcOJfNXdG/K44kFPV2uxPjyCbtSOCW627
 MVbc3B2DEIXzHxSKq0L1q5eC85cPPzOfcFZvgbr0IhsjxQX4sAfes39QcbS6JsTWioYzKU9aX2O
 xNnmxtPrxU0E7xUGg7rew1m0rqI=
X-Received: by 2002:ac8:5946:0:b0:50e:5e19:587a with SMTP id
 d75a77b69052e-50e5e195b15mr22624711cf.3.1776787598268; Tue, 21 Apr 2026
 09:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <CAGxU2F65wzpNJYgpjMbnc5iK8oNNsL3niF3pVmXhVU5PM34baA@mail.gmail.com>
In-Reply-To: <CAGxU2F65wzpNJYgpjMbnc5iK8oNNsL3niF3pVmXhVU5PM34baA@mail.gmail.com>
From: Jorge Moreira <jemoreira@google.com>
Date: Tue, 21 Apr 2026 09:06:26 -0700
X-Gm-Features: AQROBzAKBoKbDAcwNR-o08eIyHQOvIldhoxJgpR70W5Xhgs9xiaeKBhg2-n1q4g
Message-ID: <CAJi--PNdP+OxT6XAE7fjp01o5nX-bZPjBMmuaONrg1Gn_65qQA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=jemoreira@google.com; helo=mail-qt1-x82d.google.com
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

> Do you know other backends we should check?

CrosVm's: https://github.com/google/crosvm/tree/main/devices/src/virtio/vho=
st_user_backend


On Tue, Apr 21, 2026 at 12:55=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Tue, 21 Apr 2026 at 02:48, Jorge Moreira <jemoreira@google.com> wrote:
> >
> > > So it=E2=80=99s fine to continue in this direction, but I might add t=
hese
> > words more in the "Migration" section than here, since we=E2=80=99re ta=
lking
> > about an optional state migration here. For example after "No further
> > update must be done before rings are restarted."
> > Or in the "Ring states" section, where we can clarify how to restart a
> > ring after a migration. Or in both :-)
> >
> > I admit I don't know what that LOG_FD is for or what a "userfault-fd"
> > is, so I don't know how they relate to vring state. The paragraph I
> > modified discusses which part of the back-end state is in fact handled
> > by the front-end, which somewhat matches the "vring-can/should-kick"
> > idea. That being said, I don't have a strong preference for where this
> > should go. Repeating it in "Ring states" makes sense to me.
>
> I didn't express myself clearly, but my point is that discussing this
> in the "Migrating back-end state" section is misleading. We should
> address it first because it has nothing to do with state; it's also
> needed for devices that don't require any state transfer.
>
> >
> >
> > > QEMU's libvhost-user implementation already starts the ring when
> > VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> > waiting for the kick fd since a back-end that uses polling (peeking at
> > the vring in memory) shouldn't need to monitor the kick fd. See below
> > though about races between the kick fd and vhost-user protocol messages=
.
>
> Just a note, we do the same in the rust-vmm vhost-user-backend crate as w=
ell.
>
> > Starting rings when SET_VRING_KICK is received technically violates
> > the vhost-user protocol as defined in the spec. QEMU may support
> > back-ends behaving this way, but other VMMs may not. Changing the spec
> > accordingly could potentially cause other implementations not
> > depending on QEMU's libvhost-user to become non-compliant, I prefer to
> > avoid this.
>
> This is a good point and essentially what changed my mind.
>
> However, this doesn't change anything for those frontends that also
> send the kick (I don't know which ones do this, but QEMU doesn't, and
> I don't think CH does either, since it uses the rust-vmm crates); they
> continue to work just the same.
>
> As for the backends, we=E2=80=99ve seen that both libvhost-user in QEMU a=
nd
> vhost-user-backend in rust-vmm do exactly this (start vrings once
> SET_VRING_KICK is received), so perhaps clarifying in this way isn't
> too risky.
>
> Do you know other backends we should check?
>
> >
> > > Note that monitoring the kick fd may be used to avoid races between
> > > the kick fd and vhost-user protocol messages, so in practice back-end
> > > implementors may still want to start the virtqueue when the kick fd
> > > becomes readable
> >
> > Implementations having to do in practice what the spec says today is
> > another reason not to change the it.
> >
> > While starting the vrings on SET_VRING_KICK could solve the state
> > machine issue, it still won't notify the back-end that buffers are
> > ready (the driver won't do this). Non-polling back-ends depend on this
> > kick, especially for queues where data flows only from the driver to
> > the back-end. Most implementations likely attempt to read from the
> > queue only after receiving the kick.
>
> Once the vrings are set, the VMM and the device have exactly the same
> view of the vring state, so IMO the kick is just some extra step (I'm
> fine to add it just because the spec wasn't clear). The device can
> start in the same way without it.
>
> >
> > ------
> > Thanks for the feedback! I'll wait for consensus before making further
> > modifications.
>
> Thanks!
> Stefano
>
> >
> >
> > On Mon, Apr 20, 2026 at 11:18=E2=80=AFAM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > On Mon, Apr 20, 2026 at 04:49:04PM +0200, Stefano Garzarella wrote:
> > > > Thanks for starting the discussion here, let me add also Hanna, Ger=
man, and
> > > > Stefan in CC that can help us.
> > > >
> > > > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > > > > Migration of back-end state happens while the device is suspended=
 (i.e
> > > > > all vrings are stopped). To resume normal operation on the destin=
ation,
> > > > > the vrings need to be started again with a kick (either a write o=
n the
> > > > > FD or the VHOST_USER_VRING_KICK in-band message if negotiated). W=
hile
> > > >
> > > > It's true that in the spec we have:
> > > >   "Each ring is initialized in a stopped and disabled state. The   =
back-end
> > > > must start a ring upon receiving a kick (that is, detecting   that =
file
> > > > descriptor is readable) on the descriptor specified by
> > > > VHOST_USER_SET_VRING_KICK or receiving the in-band message
> > > > VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
> > > > VHOST_USER_GET_VRING_BASE."
> > > >
> > > > But IMO this applies when a driver is not yet loaded.
> > > > When we are migrating, the driver could be already loaded. So, in t=
he new
> > > > device running in the destination, IMO we should consider the ring =
already
> > > > started or add some messages to tell to the device: "hey, the devic=
e was
> > > > already started, this is a migration and it's completed".
> > > >
> > > > Sending a kick from the frontend, seems more an hack here.
> > > >
> > > > That said, for example, in subprojects/libvhost-user/libvhost-user.=
c IIUC
> > > > the virtqueue is started when the SET_VRING_KICK is handled by
> > > > vu_set_vring_kick_exec(), but not sure how compliant it is.
> > > >
> > > > > these notifications are typically sent by the driver, it has no r=
eason
> > > > > to send them in the destination if it already sent them in the so=
urce as
> > > > > the driver is unaware that a migration took place. Therefore it s=
hould
> > > > > be the responsibility of the vhost-user front-end to ensure these=
 vrings
> > > > > are started. This is particularly necessary for queues where data=
 only
> > > > > flows from device to driver, such as those used by the vsock and =
input
> > > > > devices.
> > > >
> > > > Exactly, so IMO we should not use the kick, but maybe add something=
 new or
> > > > clarify what to do after the migration.
> > > >
> > > > For example in the "Migrating back-end state" we have:
> > > >   "Migrating device state involves transferring the state from one
> > > > back-end, called the source, to another back-end, called the   dest=
ination.
> > > > After migration, the destination transparently resumes   operation =
without
> > > > requiring the driver to re-initialize the device at   the VIRTIO le=
vel."
> > > >
> > > > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exact=
ly to
> > > > inform the new device about the state: "there isn't any state to tr=
ansfer,
> > > > but I notify you that the device was already initialized, so the vr=
ings can
> > > > be started".
> > > >
> > > > >
> > > > > This behavior is already used by some qemu vhost-user front-ends =
(e.g
> > > > > vhost-user-blk) and by front-ends implemented on other VMMs(e.g C=
rosVm).
> > > >
> > > > I looked at vhost-user-blk frontend, but I don't see it. I mean I s=
ee the
> > > > code around the comment "/* Kick right away to begin processing req=
uests
> > > > already in vring */" but that one IIUC was introduced more to fix d=
evices
> > > > violating specs, so not sure it's a good example to follow:
> > > >
> > > > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > > > Author: Yongji Xie <elohimes@gmail.com>
> > > > Date:   Wed Jun 6 21:24:48 2018 +0800
> > > >
> > > >     vhost-user-blk: start vhost when guest kicks
> > > >     Some old guests (before commit 7a11370e5: "virtio_blk: enable V=
Qs early")
> > > >     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This v=
iolates
> > > >     the virtio spec. But virtio 1.0 transitional devices support th=
is behaviour.
> > > >     So we should start vhost when guest kicks in this case.
> > > >     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> > > >     Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > > >     Signed-off-by: Ni Xun <nixun@baidu.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >
> > > >
> > > > > Adding it to the vhost-user documentation makes it explicit that =
this
> > > > > strategy is permitted and suggest it to vhost-user front-end auth=
ors.
> > > > > Explicitly documenting it is necessary because vring kicks appear
> > > > > designed to originate in the driver, so having some originate in =
the
> > > > > front-end can be counterintuitive and cause developers to waste t=
ime
> > > > > looking for other alternatives or face pushback during code revie=
w.
> > > >
> > > > As I pointed out in our discussion in
> > > > https://github.com/rust-vmm/vhost-device/pull/936
> > > > IMO we should use some in-band messages and not relaying on kicks t=
hat
> > > > should be used only by the driver to notify the device about new av=
ailable
> > > > buffers.
> > > >
> > > > That said, I agree that we need to clarify in the specifications ex=
actly
> > > > what the backend and frontend should do after a migration to start =
vrings if
> > > > there is no need to exchange a state.
> > > >
> > > >
> > > > Any other opinion?
> > >
> > > IMO no protocol changes are needed but the vhost-user spec should be
> > > tweaked. Hanna worked on device state migration and can confirm/deny
> > > what I'm about to describe.
> > >
> > > QEMU's libvhost-user implementation already starts the ring when
> > > VHOST_USER_SET_VRING_KICK is received. This makes more sense than
> > > waiting for the kick fd since a back-end that uses polling (peeking a=
t
> > > the vring in memory) shouldn't need to monitor the kick fd. See below
> > > though about races between the kick fd and vhost-user protocol messag=
es.
> > >
> > > All of this boils down to the ring state machine. libvhost-user's
> > > behavior is:
> > > 1. Virtqueues are started by VHOST_USER_SET_VRING_KICK.
> > > 2. Virtqueues are stopped by VHOST_USER_GET_VRING_BASE.
> > > 3. Virtqueues are enabled/disabled by VHOST_USER_SET_VRING_ENABLE.
> > >
> > > The same sequence of vhost-user protocol messages that is used to
> > > start/stop a device locally (e.g. pause and resume a VM) is the same
> > > that can be used during migration. The ring state machine already exi=
sts
> > > and needs to be used when migrating device state.
> > >
> > > The following changes to the vhost-user spec would make this clearer:
> > >
> > > 1. Mention that virtqueues are started by VHOST_USER_SET_VRING_KICK.
> > >    Note that monitoring the kick fd may be used to avoid races betwee=
n
> > >    the kick fd and vhost-user protocol messages, so in practice back-=
end
> > >    implementors may still want to start the virtqueue when the kick f=
d
> > >    becomes readable.
> > >
> > > 2. Add a clarification to "Migrating back-end state" that the device
> > >    must be suspended (see _suspended_device_state) when
> > >    VHOST_USER_SET_DEVICE_STATE_FD is sent and device state is
> > >    transferred. This is already implicit in "Device state transfer
> > >    parameters", but it's not obvious when reading the "Migrating
> > >    back-end state" section.
> > >
> > > Stefan
> >
>

