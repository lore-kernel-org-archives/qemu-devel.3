Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F6F55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFStg-0000NB-6C; Wed, 22 Apr 2026 04:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFSte-0000Mi-P1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wFStc-0007Vj-HF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scRzCA6AXGz+F2SYsc7/NHmDTy4AU0WfTRI0/pUfH9Y=;
 b=f5+TswoOXLvktoRF+w3xTeqW1Y05pD/DJHVUaeE6n3EP/MnWdMw2HNVGEaUlMVrlpmJv4u
 P8phGOknLWuyWNJXTzo+kLr69m/BXdya3yRP1L3kk4VQawv194UMJlhq4DTchfT4v+t4Ak
 Xvcx4/qxl577zkCzfuHf3xi0LZnaBos=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-REF85XvHPk2y9LJeBnB-Yw-1; Wed, 22 Apr 2026 04:25:18 -0400
X-MC-Unique: REF85XvHPk2y9LJeBnB-Yw-1
X-Mimecast-MFC-AGG-ID: REF85XvHPk2y9LJeBnB-Yw_1776846317
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35e5791871fso2939008a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776846317; cv=none;
 d=google.com; s=arc-20240605;
 b=Bb96H+mQ8z7QvuiQqeiVnWOYojg1Q2pqKT+uOPadoujAMogvTc33b85XZWvmO8pDNM
 lafQGUzYJZlKNgGXCuuHycdlz2qrQsok0+8ODY3TlSbyJxtIwC/RkMqLw203b9M+KiGG
 w6RMfGQaMx5p4frbdWhzKiD/rNF6o8Q9Crn3Yt/O06PFrp1WbMJfPVol9lPNq9mkw9/w
 klh/hGThS5cm09wHOAVC5EjL5X1Ok31jOoxFRDorMMa1Rb0wV5q5DI2RMPE6ZrwIxOOP
 4RRUGtQuDYepfF8VkDAz3XYms6fvewqUSwcfFEgxF6/VaMZFdcrUuFmF7Js0ai+/CEZB
 ovpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=scRzCA6AXGz+F2SYsc7/NHmDTy4AU0WfTRI0/pUfH9Y=;
 fh=VaNkszKAlO2uwOZZo982xNSB1VdmmUxH2JBM3BUvgWY=;
 b=hXGiITdXTibpA4XAsNrGw7H1YlDsi0w02hyJsUMuH6b7Xd0U7UPJtrOQPNFsUA+UBh
 LpAMk4mZa79mBtaqP8ZZjMopMz1xZB+NA7iyc2oncHMDftOF5L+G7l4bzw0Cgr6b80e4
 WSXUN7ugwhYzqHeiLh43Wz11Fo16Op1qzPr6qq/+hdwH6ayMQlsIWn/UKnflh9U8923W
 QVrjnIeunTdSP/pOE7F/OwQi5ATGd78is/GdlrrykxIamjka50xRu3g1kyZMTzbAZlg+
 T3wii3Ya7qVwc2w3nGMeH+QmUa2FEGBhEncROersLIT5ix/h4li62r7RpjpTmSe92SiB
 aqzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846317; x=1777451117; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scRzCA6AXGz+F2SYsc7/NHmDTy4AU0WfTRI0/pUfH9Y=;
 b=jEVZKAwt1JyhcqI4IO8y46VyLHledwVx3L2u+dhOIijJazlSQQe9CF26zeYp8QYP1K
 sJd4iBf5xbjfZbvgpIZXEKQ6zLClKItn3U7gbVvipY2KvAmZxNEhXzXw9ShMa9f6Roej
 Vv7fnUekzRoMt6O6EaOjCpkEJYyjdXMMp3z+gjM999GF23zauk23o7oVb60fX5CPFUyb
 lrpqW/8x8NjXTZ/OIW0AyAnyQk6WSWh++EMOYKG1bz6bkV71iWru0UjkG0zfzOnTd16e
 XXLSFb1pNQIc19EH2QwfygOgI5HJByAyJdFj1r7pRgjAaBfE1ujzWF24nWb+lB17v2BU
 j5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846317; x=1777451117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=scRzCA6AXGz+F2SYsc7/NHmDTy4AU0WfTRI0/pUfH9Y=;
 b=BoV1MpnWvjNj6OdIL656euKubbcc/h1SdjaoMCdpeZLOPezOgCdJ6A6P4H5UvMTTcA
 DhKRXXvC/Qu9ef3yk11Fok9R3l1aQf88L1p+2Vn1g3XANI+GEiTRYL0WdjVSATSHs2FF
 /V6ZfOciZ9cxBCFUIg88tOomLBgx2hXAmkM9k/4uq6zW1Lx9KfPcqFRC8Qi3SPTWnIVk
 tqAzf3stGpUqmYsv+m7ZAIwNin2GJ00+Jp2zrlYM2S1tkmrhvwiaVeo2PhjcibqUzQPu
 aV1b6ZM/ok2hDzJ/hbd1QybZUMB6tTBH+fW4OTIykkTaD43Dtc4KWv/OYWvGN3UxOl27
 6X3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6Lz4I6iJuF69rMjlr/51f1QCdyxYZLoylJwYO4lR260z4qvsntswtclp7yl8+Q0GtRCc3Nq6RYyig@nongnu.org
X-Gm-Message-State: AOJu0Yy183S1PmyeTr5cmCGJe84hUfmI2WWNNucKCaqjulUSDqYLzkKu
 6v8ACFiTauRsHq4ycF8qOvwkKJ54zJveqI+crVCyDcr/Yb6xquBm9sLXJ1FbUPa865rx/xc0GLs
 SRG1Fz91gTxqRwc+zo3JuzhZ/UmnczDi7eU/tXM+DLTlJuo9yrqbylIMSKFx+s4nnRHQlCDop14
 ZHAUY5aMLJMMX0IshGLXr1RVXmgOvp7h8=
X-Gm-Gg: AeBDiev5Gvp/Cn+7b9Jr0drXKzZnduOKZ8gnIcPRPcrx3j+5oCjPxsRv6dTVP99QNg0
 xW8KwAE20tHA4R+sQiCRhWfh2VWbMi9PlFPWJZEU4WXRN1y01+GewjSBpED/EjUkDfdeDC+G/Xl
 WWzXUADnCvAt4ISkI0P2YihCX8GDUh60Zgt4LkjVeX6sHb7BdhcLsFcilSAIDrusUH+TmAee4w3
 IEtnspWGQVlMko=
X-Received: by 2002:a17:90a:d09:b0:361:45df:f5 with SMTP id
 98e67ed59e1d1-36145df04afmr14416080a91.16.1776846317206; 
 Wed, 22 Apr 2026 01:25:17 -0700 (PDT)
X-Received: by 2002:a17:90a:d09:b0:361:45df:f5 with SMTP id
 98e67ed59e1d1-36145df04afmr14416051a91.16.1776846316604; Wed, 22 Apr 2026
 01:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat>
 <CAGxU2F7=XQfc4PUEM=k5yc-tytRs-MkrRKFeRXAETVEY5eggZQ@mail.gmail.com>
 <20260421205156.GB466778@fedora>
In-Reply-To: <20260421205156.GB466778@fedora>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 22 Apr 2026 10:25:05 +0200
X-Gm-Features: AQROBzBWMD1_3Bhp6iPPdELTv9RThEZkXRblVew9IvLnWkAfhMdv1AL3eCVFTkU
Message-ID: <CAGxU2F6vceXOqmLc4HC_u3uzZxWsUExPd9QBm7CAdvXEu5iuDg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Jorge E. Moreira" <jemoreira@google.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 21 Apr 2026 at 22:52, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Apr 20, 2026 at 05:57:40PM +0200, Stefano Garzarella wrote:
> > On Mon, 20 Apr 2026 at 16:49, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
> > >
> > > Thanks for starting the discussion here, let me add also Hanna, Germa=
n,
> > > and Stefan in CC that can help us.
> > >
> > > On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> > > >Migration of back-end state happens while the device is suspended (i=
.e
> > > >all vrings are stopped). To resume normal operation on the destinati=
on,
> > > >the vrings need to be started again with a kick (either a write on t=
he
> > > >FD or the VHOST_USER_VRING_KICK in-band message if negotiated). Whil=
e
> > >
> > > It's true that in the spec we have:
> > >    "Each ring is initialized in a stopped and disabled state. The
> > >    back-end must start a ring upon receiving a kick (that is, detecti=
ng
> > >    that file descriptor is readable) on the descriptor specified by
> > >    VHOST_USER_SET_VRING_KICK or receiving the in-band message
> > >    VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receivin=
g
> > >    VHOST_USER_GET_VRING_BASE."
> > >
> > > But IMO this applies when a driver is not yet loaded.
> > > When we are migrating, the driver could be already loaded. So, in the
> > > new device running in the destination, IMO we should consider the rin=
g
> > > already started or add some messages to tell to the device: "hey, the
> > > device was already started, this is a migration and it's completed".
> > >
> > > Sending a kick from the frontend, seems more an hack here.
> > >
> > > That said, for example, in subprojects/libvhost-user/libvhost-user.c
> > > IIUC the virtqueue is started when the SET_VRING_KICK is handled by
> > > vu_set_vring_kick_exec(), but not sure how compliant it is.
> > >
> > > >these notifications are typically sent by the driver, it has no reas=
on
> > > >to send them in the destination if it already sent them in the sourc=
e as
> > > >the driver is unaware that a migration took place. Therefore it shou=
ld
> > > >be the responsibility of the vhost-user front-end to ensure these vr=
ings
> > > >are started. This is particularly necessary for queues where data on=
ly
> > > >flows from device to driver, such as those used by the vsock and inp=
ut
> > > >devices.
> > >
> > > Exactly, so IMO we should not use the kick, but maybe add something n=
ew
> > > or clarify what to do after the migration.
> > >
> > > For example in the "Migrating back-end state" we have:
> > >    "Migrating device state involves transferring the state from one
> > >    back-end, called the source, to another back-end, called the
> > >    destination. After migration, the destination transparently resume=
s
> > >    operation without requiring the driver to re-initialize the device=
 at
> > >    the VIRTIO level."
> > >
> > > So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly=
 to
> > > inform the new device about the state: "there isn't any state to
> > > transfer, but I notify you that the device was already initialized, s=
o
> > > the vrings can be started".
> > >
> > > >
> > > >This behavior is already used by some qemu vhost-user front-ends (e.=
g
> > > >vhost-user-blk) and by front-ends implemented on other VMMs(e.g Cros=
Vm).
> > >
> > > I looked at vhost-user-blk frontend, but I don't see it. I mean I see
> > > the code around the comment "/* Kick right away to begin processing
> > > requests already in vring */" but that one IIUC was introduced more t=
o
> > > fix devices violating specs, so not sure it's a good example to follo=
w:
> > >
> > > commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> > > Author: Yongji Xie <elohimes@gmail.com>
> > > Date:   Wed Jun 6 21:24:48 2018 +0800
> > >
> > >      vhost-user-blk: start vhost when guest kicks
> > >
> > >      Some old guests (before commit 7a11370e5: "virtio_blk: enable VQ=
s early")
> > >      kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This vi=
olates
> > >      the virtio spec. But virtio 1.0 transitional devices support thi=
s behaviour.
> > >      So we should start vhost when guest kicks in this case.
> > >
> > >      Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> > >      Signed-off-by: Chai Wen <chaiwen@baidu.com>
> > >      Signed-off-by: Ni Xun <nixun@baidu.com>
> > >      Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > > >Adding it to the vhost-user documentation makes it explicit that thi=
s
> > > >strategy is permitted and suggest it to vhost-user front-end authors=
.
> > > >Explicitly documenting it is necessary because vring kicks appear
> > > >designed to originate in the driver, so having some originate in the
> > > >front-end can be counterintuitive and cause developers to waste time
> > > >looking for other alternatives or face pushback during code review.
> > >
> > > As I pointed out in our discussion in
> > > https://github.com/rust-vmm/vhost-device/pull/936
> > > IMO we should use some in-band messages and not relaying on kicks tha=
t
> > > should be used only by the driver to notify the device about new
> > > available buffers.
> > >
> > > That said, I agree that we need to clarify in the specifications exac=
tly
> > > what the backend and frontend should do after a migration to start
> > > vrings if there is no need to exchange a state.
> > >
> > >
> > > Any other opinion?
> > >
> > > Thanks,
> > > Stefano
> > >
> > > >
> > > >Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
> > > >---
> > > > docs/interop/vhost-user.rst | 5 ++++-
> > > > 1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > >diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.r=
st
> > > >index 137c9f3669..ad5aba3430 100644
> > > >--- a/docs/interop/vhost-user.rst
> > > >+++ b/docs/interop/vhost-user.rst
> > > >@@ -656,7 +656,10 @@ destination, following the usual protocol for e=
stablishing a connection
> > > > to a vhost-user back-end: This includes, for example, setting up me=
mory
> > > > mappings and kick and call FDs as necessary, negotiating protocol
> > > > features, or setting the initial vring base indices (to the same va=
lue
> > > >-as on the source side, so that operation can resume).
> > > >+as on the source side, so that operation can resume). The vhost-use=
r front-end
> > > >+may also write to the kick FDs of vrings containing unused buffers =
or send
> > > >+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in th=
e destination
> > > >+since the driver likely already kicked them in the source and won't=
 do it again.
> >
> > After discussing this with Hanna, we came to the conclusion that your
> > idea of injecting the kick is the least invasive option for now and
> > complies with the spec (even though I still don=E2=80=99t think it=E2=
=80=99s a nice
> > thing to do).
> >
> > So it=E2=80=99s fine to continue in this direction, but I might add the=
se
> > words more in the "Migration" section than here, since we=E2=80=99re ta=
lking
> > about an optional state migration here. For example after "No further
> > update must be done before rings are restarted."
> > Or in the "Ring states" section, where we can clarify how to restart a
> > ring after a migration. Or in both :-)
> >
> > WDYT?
> >
> > Then instead of "may" I'd use "should". And I would refer to the fact
> > that migration is transparent to the driver, so the front-end should
> > kick all initialized vrings to comply with what we described in the
> > "Ring states" section.
>
> I don't agree. Here is my thinking about how to solve this:
>
> Device state migration uses the ring state machine to suspend the device
> on the source host and start rings on the destination host after loading
> state.
>
> Starting rings is not specific to migration, it is covered by the ring
> state machine that's also used when pausing and resuming a VM locally,
> for example. We need to fix the ring state machine section in the spec
> rather than making changes to the migration or device state fd sections.
>
> Given that there are vhost-user back-ends like DPDK that do not rely on
> the kick fd (they do not use it when running in poll mode), injecting a
> kick cannot be necessary. Adding anything to the spec that requires the
> kick fd is at best a no-op and at worst could break those back-ends.
>
> The spec must be updated to say that rings are started by
> VHOST_USER_SET_KICK, which is what implementations already do today.

If we update the spec with this, I agree with you. I also think it's
the right thing to do. Even though I would have preferred a specific
message to get things started, which would require a new feature,
etc., I agree that=E2=80=99s too much.

My reasoning was based on the fact that we always needed to inject a
kick to start the rings, which is essentially what we currently state
in the specification. Not sure why all the implementation fortunately
didn't follow that, maybe because they got inspired by libvhost-user.

BTW, I think the main issue to clarify is what the device should do
when the vrings are configured, but the driver has already been
initialized (which is usually the case after migration).

If the driver hasn't been initialized, everything is clear.

>
> If you want to add a note that front-ends may send a kick after
> VHOST_USER_SET_KICK completes to ensure that rings are started according
> to the old spec wording, then that is fine, but it should be clear that
> kicks are not the primary mechanism for starting rings since it would be
> dangerous to rely on that (it breaks poll-mode back-ends).

Agree, after clarifying VHOST_USER_SET_KICK.

Thanks,
Stefano


