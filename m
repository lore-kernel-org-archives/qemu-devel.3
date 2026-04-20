Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989D7F588EC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEr0Z-0008BL-V9; Mon, 20 Apr 2026 11:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wEr0Y-0008Ao-Ae
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wEr0W-0006it-Dk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776700675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmGCgKHQXycY5UDNbKTcb3iZKBJiL/37JanVeePzLbc=;
 b=ivA4MJN751D+lMBCP1J7LfMHPYM+HWS/xVmUtPZPxBP6Q+xDRSZJo10MPTMzb0iRq5hOqL
 EFyHpchjpQ33QxX0P8GucIT0/p/6uBJIX99Mhp/b0Uop38QfbecDF3Hpuk7or+9AAVsOal
 6rI7NCnpKr2BtPABhIkdZmOIJu2vxDI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-sALPlQovOGec_D6f7UurBA-1; Mon, 20 Apr 2026 11:57:53 -0400
X-MC-Unique: sALPlQovOGec_D6f7UurBA-1
X-Mimecast-MFC-AGG-ID: sALPlQovOGec_D6f7UurBA_1776700673
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso40639395ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 08:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776700673; cv=none;
 d=google.com; s=arc-20240605;
 b=gePFGUFzbdvqgGFN3f4SnQKxvR5a99SA37zOErmPoK0BqTS+R0PavbJ0z6cQ1jwh3O
 IkFV8jY4OjKfi2gtOORQ0Msr+090CWepWOvtouTza1n4PQvaJVm2yJvafyXblBthKbzB
 I/qCRCgLawpFJeUBm056JUbFb2wsMiIwA8fAidN7CfrJ/mIN9aAyTpZhYft7crT+qhAz
 fDpC4v01PTHd7XRbjHf4y+BYRo4jkboNoYui5ow28iyymnnFlbvlqYVOCs60HTkrRtS3
 G9lcOPKiWUsgDYw3JB4JiucFWdcA2Z3HKPsQnTe/B8F6kM02ZaxfQ7oXTC/CznYHjx9d
 gkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WmGCgKHQXycY5UDNbKTcb3iZKBJiL/37JanVeePzLbc=;
 fh=n4vUO9h8l8a+OfSP4l5bPmM/Mwrbi/aHlWAd7/sKQlM=;
 b=bEsTGrVo1jfSCrKgNnQIikOmFsUet8TDdypnNWRrpKOp7iLwBgz4urQm4S3+YWMfPw
 XWIVR7NijFDQmNTUGmZz4NOG0vDytOl/g9Pl0hTOVcakO3rL53z73p2EAJ9z5czz26GF
 o1hYRNfB/NHn9F/Ijw6H8vhPszI/AAhPE+J168F+H5fW5yA1W+5BYhVfCjK0gC9gQiDJ
 T8OwWe/iJs8jqJuGD+pey1dkmKQgx5MPZM5/Ej3/cyE1XZ2hykFcUuTN8od4L9HKTlgo
 DFkqhgcy6el7rWz7HF8YFJGSrQxNiCGQ0vjjsWKEG1pJfEft8jAAOysKRkhK7jjw1oXK
 ZD6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776700673; x=1777305473; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmGCgKHQXycY5UDNbKTcb3iZKBJiL/37JanVeePzLbc=;
 b=rW+lZ6KDZAY2p4eoqTegJKPxOm93luFmjWMW30FMceroGl9ymQmCGGH6YDUVuVmzlV
 YLVJ0Vq56DUU2Zokq71rLZu/B97OKLiAwr3OxnC3mjw66pswwmB/gOa4iCoTzMsxgpac
 5LpOkv1nxpk6J7I2dCIKuz5H2UUMEjrd07RJMDza6VygBJ08dTTwQpCYFPX3PgqgKlxa
 JC65iSFeUcFDrT1ZI63gJC8GCNu7of8Bs0wZaC4gk3dRwarfgh358igt1g+8sVQSGca/
 7NIWStewYD9kIoe7GZDv7c4yvVwYUKpbuegsZXLcUAzPbLUIppBcbK51dd8p2TfXpVQm
 wMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776700673; x=1777305473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmGCgKHQXycY5UDNbKTcb3iZKBJiL/37JanVeePzLbc=;
 b=pOKsRDP4vNRQ92TeDfMaNV940N1+G3fLdxHwTX9emAiCkc9VMAA4FoQ1bdgd31KPli
 GfOlMQ9LX2ebMbRyw8J2NSXpmpT/QPr3VFl/hGGbsPOxtHenqy8T/zqJUMA2Gvtjqdb+
 T0Jxa6gv5idTdBme7ewK6lh6LakaPs8ynWZouHPHM3wrdVRJZAuOUG6a3n1s1fhwNo5D
 r3CQCYRj2vMJGHEVaxPTKH3t1xCeEtOMgQQX6lEOq/WlvIl/E3tORVZj//30OL9DoBOh
 Pv8gHGElDJagV59qcUTCAPrPg850NmoyPsoGEe4s1YlWGVf6bKMXJHPa443cZ6gbz686
 E/LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BhwKPRzD6GK5ntMxP/tQuaOdqAhUX3qIBgdanARJ5qbE3ieb/wpmM+p39toYPrfbsSgHAwSKDa8Hv@nongnu.org
X-Gm-Message-State: AOJu0YwYV7mnh1UUBER13u87e9RN7+aOkRYME0A+PhAKOiSHOJ9a8mVu
 IRvl4Svj+/1IuBwqcsdsKQREj7qdPdkCBRcZIjWD0rX6jEPvOyMijBWzZZok7vXdMOwRw1/OowF
 dyG11cZIbHinxicSjIQOsYXorqsLkchQVnOBJ1B6TwEfV+zHWIUiLbz7Z6xgh2Ael8L74aIKKbS
 qcK2pPnjsvnZYW/YUmJT+tBJ2KOIZpovM=
X-Gm-Gg: AeBDietOCcDCoyGz4nA5un/xTwLGcuga7MRmOlWygU+PAqLhgAfZ+/1CxlmY6hVNWG1
 iatmjXtxoyHEvMG2h2SrOvkVuztMEEa7qWouU4bxHXU0OMcnQT5/qbdI954pfNQf1kEGS7nVDS1
 a9eFpFn09cfzKNrDOzqEGefzzWV0q+IxkiMMTySEJv96v8P1yUSh45IaGfN3JPZ6IrTYc+3mz/M
 c9pTD6Jia6Dvwo=
X-Received: by 2002:a17:902:d505:b0:2b2:4fcc:2687 with SMTP id
 d9443c01a7336-2b5f9f50c25mr149481395ad.31.1776700672436; 
 Mon, 20 Apr 2026 08:57:52 -0700 (PDT)
X-Received: by 2002:a17:902:d505:b0:2b2:4fcc:2687 with SMTP id
 d9443c01a7336-2b5f9f50c25mr149481045ad.31.1776700671845; Mon, 20 Apr 2026
 08:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat>
In-Reply-To: <aeYvCK2qhZd1W9sA@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 20 Apr 2026 17:57:40 +0200
X-Gm-Features: AQROBzCzHah09tr-VP2eFC96aD55WqgWXNZVtnOLAOMfGA8CII_YP-JYHrZB0uQ
Message-ID: <CAGxU2F7=XQfc4PUEM=k5yc-tytRs-MkrRKFeRXAETVEY5eggZQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: "Jorge E. Moreira" <jemoreira@google.com>, hreitz@redhat.com,
 stefanha@redhat.com, gmaglione@redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>,
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

On Mon, 20 Apr 2026 at 16:49, Stefano Garzarella <sgarzare@redhat.com> wrot=
e:
>
> Thanks for starting the discussion here, let me add also Hanna, German,
> and Stefan in CC that can help us.
>
> On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
> >Migration of back-end state happens while the device is suspended (i.e
> >all vrings are stopped). To resume normal operation on the destination,
> >the vrings need to be started again with a kick (either a write on the
> >FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
>
> It's true that in the spec we have:
>    "Each ring is initialized in a stopped and disabled state. The
>    back-end must start a ring upon receiving a kick (that is, detecting
>    that file descriptor is readable) on the descriptor specified by
>    VHOST_USER_SET_VRING_KICK or receiving the in-band message
>    VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving
>    VHOST_USER_GET_VRING_BASE."
>
> But IMO this applies when a driver is not yet loaded.
> When we are migrating, the driver could be already loaded. So, in the
> new device running in the destination, IMO we should consider the ring
> already started or add some messages to tell to the device: "hey, the
> device was already started, this is a migration and it's completed".
>
> Sending a kick from the frontend, seems more an hack here.
>
> That said, for example, in subprojects/libvhost-user/libvhost-user.c
> IIUC the virtqueue is started when the SET_VRING_KICK is handled by
> vu_set_vring_kick_exec(), but not sure how compliant it is.
>
> >these notifications are typically sent by the driver, it has no reason
> >to send them in the destination if it already sent them in the source as
> >the driver is unaware that a migration took place. Therefore it should
> >be the responsibility of the vhost-user front-end to ensure these vrings
> >are started. This is particularly necessary for queues where data only
> >flows from device to driver, such as those used by the vsock and input
> >devices.
>
> Exactly, so IMO we should not use the kick, but maybe add something new
> or clarify what to do after the migration.
>
> For example in the "Migrating back-end state" we have:
>    "Migrating device state involves transferring the state from one
>    back-end, called the source, to another back-end, called the
>    destination. After migration, the destination transparently resumes
>    operation without requiring the driver to re-initialize the device at
>    the VIRTIO level."
>
> So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly to
> inform the new device about the state: "there isn't any state to
> transfer, but I notify you that the device was already initialized, so
> the vrings can be started".
>
> >
> >This behavior is already used by some qemu vhost-user front-ends (e.g
> >vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm).
>
> I looked at vhost-user-blk frontend, but I don't see it. I mean I see
> the code around the comment "/* Kick right away to begin processing
> requests already in vring */" but that one IIUC was introduced more to
> fix devices violating specs, so not sure it's a good example to follow:
>
> commit 110b9463d5c820120c8311db79f55a64c9d81ebe
> Author: Yongji Xie <elohimes@gmail.com>
> Date:   Wed Jun 6 21:24:48 2018 +0800
>
>      vhost-user-blk: start vhost when guest kicks
>
>      Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs ea=
rly")
>      kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violat=
es
>      the virtio spec. But virtio 1.0 transitional devices support this be=
haviour.
>      So we should start vhost when guest kicks in this case.
>
>      Signed-off-by: Yongji Xie <xieyongji@baidu.com>
>      Signed-off-by: Chai Wen <chaiwen@baidu.com>
>      Signed-off-by: Ni Xun <nixun@baidu.com>
>      Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> >Adding it to the vhost-user documentation makes it explicit that this
> >strategy is permitted and suggest it to vhost-user front-end authors.
> >Explicitly documenting it is necessary because vring kicks appear
> >designed to originate in the driver, so having some originate in the
> >front-end can be counterintuitive and cause developers to waste time
> >looking for other alternatives or face pushback during code review.
>
> As I pointed out in our discussion in
> https://github.com/rust-vmm/vhost-device/pull/936
> IMO we should use some in-band messages and not relaying on kicks that
> should be used only by the driver to notify the device about new
> available buffers.
>
> That said, I agree that we need to clarify in the specifications exactly
> what the backend and frontend should do after a migration to start
> vrings if there is no need to exchange a state.
>
>
> Any other opinion?
>
> Thanks,
> Stefano
>
> >
> >Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
> >---
> > docs/interop/vhost-user.rst | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >index 137c9f3669..ad5aba3430 100644
> >--- a/docs/interop/vhost-user.rst
> >+++ b/docs/interop/vhost-user.rst
> >@@ -656,7 +656,10 @@ destination, following the usual protocol for estab=
lishing a connection
> > to a vhost-user back-end: This includes, for example, setting up memory
> > mappings and kick and call FDs as necessary, negotiating protocol
> > features, or setting the initial vring base indices (to the same value
> >-as on the source side, so that operation can resume).
> >+as on the source side, so that operation can resume). The vhost-user fr=
ont-end
> >+may also write to the kick FDs of vrings containing unused buffers or s=
end
> >+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in the de=
stination
> >+since the driver likely already kicked them in the source and won't do =
it again.

After discussing this with Hanna, we came to the conclusion that your
idea of injecting the kick is the least invasive option for now and
complies with the spec (even though I still don=E2=80=99t think it=E2=80=99=
s a nice
thing to do).

So it=E2=80=99s fine to continue in this direction, but I might add these
words more in the "Migration" section than here, since we=E2=80=99re talkin=
g
about an optional state migration here. For example after "No further
update must be done before rings are restarted."
Or in the "Ring states" section, where we can clarify how to restart a
ring after a migration. Or in both :-)

WDYT?

Then instead of "may" I'd use "should". And I would refer to the fact
that migration is transparent to the driver, so the front-end should
kick all initialized vrings to comply with what we described in the
"Ring states" section.

Thanks,
Stefano


