Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552BF588DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpwK-00089c-UG; Mon, 20 Apr 2026 10:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wEpwI-00083E-Ru
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wEpwG-0004Re-Od
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776696567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3Gk9l+Pk6Ig52UanUSXecOqK80gAfkFr/AOS4SGp6s=;
 b=PVG962xu99bA9CyTzTudPzaQ+pbR+gXSk75zjaxL/NBjn/v25pOpn42jq+aPenLqktarTk
 6FAiXA7GviQJCmWLEDPX28pFNsBbxRnmelPZU8XIRiJ2OaaN2/zPV5C9r86TCX8lhAWnKg
 LicNnvLLy0ZmpgBt5h4z2NFyIWW+qUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ng9hq071MpGDaYzigIrWgA-1; Mon, 20 Apr 2026 10:49:24 -0400
X-MC-Unique: ng9hq071MpGDaYzigIrWgA-1
X-Mimecast-MFC-AGG-ID: ng9hq071MpGDaYzigIrWgA_1776696563
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488e3fd89e5so39848705e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776696563; x=1777301363; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b3Gk9l+Pk6Ig52UanUSXecOqK80gAfkFr/AOS4SGp6s=;
 b=Iqgoju76Mc3i5dzpKwRP0lo1HnXp6j5t0yRQ52Mr6WyMESKlWWdbuPlWPtHQoFaEwN
 5kKqkeWxBVgS3WzdJU/MZbdeBdLXoZCjIWO15/EU6xuBpi6RtI19WQMGrvXkt0GHDMwn
 25+Zeul1sD8k7oq+tT7TMPD9Frme6oioxkSBVbHIIhTIfF1RSnPYuC8q3zXLt8v9qBqt
 eVL2FGXF74OJvzuDYDGUonWDY1gkkDcjknxK0hBnfCkWZd4W7xj478WWU5kA4r67tQVB
 s8XmVNv/eeyAxKvxIjJFqEX9fozDrjtApVO5zOLpM6DlfvhSWXLsOCAwtzWPHWjhRDFd
 JaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776696563; x=1777301363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3Gk9l+Pk6Ig52UanUSXecOqK80gAfkFr/AOS4SGp6s=;
 b=VpKC2R8icPILmQTlhnVKrTT/7sb/oTlUv0di0hUDbWaTUKjuckA9x4ZIZp/Bmp4Juz
 CYbDtMYKpntiMilNrDNdKY8BmFHYwcI5xi4Mel7RVUUSL0jPCBBQopomcAoBeWbAYiYj
 Hwp2W7y5h5Um5dXBaoYkdFLee15XryWnXUbm4TRvYkpyzJ+IaYWOaTuqoO/yAujq1Smr
 IbUsgyupOZusXbver5lxdouByk60D/N5yANUDq2WnwbWaLfPPLFkKdB1Q1+Th9B2zc8N
 L7dfSrWn09YGUzW1K314zEGS09GQYX48Z9qPEwP8BEKPKfvu9pzDuA3Y1J6j9rdDKwcS
 909w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zDxQiZ3UFH/+c7hhpMwqcE9GbnvDD+GsY2+S0XBCitjmDzolLZ7qMq+9bi6q1hdwtnvMrCubKKHGK@nongnu.org
X-Gm-Message-State: AOJu0YyOYqrg5fAeWkOsmHL0vMAh61QKJTBnzKS7M61+qmhA2gpOumiH
 ITqf+xFPRDGV2BKUklEUANIblzUfpFJLHIxmxktTPr/v5cmykIlBCjbBjDIr0BYe2/OJCuYAiZ5
 7Zlr71NHr9HU7eWNgP0ql86cqlUMue0AFP/RIgRhAx9vrNYXqL+VXMk/B
X-Gm-Gg: AeBDietQRhU5O3zTkwUPhuGexNkcFHXwj2Ay0aj0pCI3b3TM+zFIn20FJ6wUhsbLdWy
 ERELvCLO4yKJgngATtIk/C007h6WrmBDMLX+7InemESaeMaNjE1bhdayIZauCl6Jld9GWpVkO7j
 YR7FzDsH2e24ZUeIYeOh2hV7napwaiM8Zmz4VJ197xxMGQ3Pj5FYtsN6Ul5CnrBLX2yRhnnHtU1
 fFjXsDdrjoKa7TFgzWdDMTd9hpJXmSgp7ht3BrwCU898TF0iEeUWgRZuSLksKhINJYYJAuW9SX1
 dfC7Vb4oNoN9IB3v9xNbfSwpy1r1wdIvXArPafUs9G9Mu84DVxBpRam4lA685ZVguYlHjC8t+7v
 99VcbVHpV7CWpSbLrVgoG7P7QHm2r8QIPP8mXNbGh69MpCHL18I6CgiL5MuHqGahEYfU5r2NLqo
 7V1G9H9g==
X-Received: by 2002:a05:600d:9:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-488fb8bdfa8mr144640895e9.15.1776696563100; 
 Mon, 20 Apr 2026 07:49:23 -0700 (PDT)
X-Received: by 2002:a05:600d:9:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-488fb8bdfa8mr144640575e9.15.1776696562543; 
 Mon, 20 Apr 2026 07:49:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it.
 [87.16.204.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm150362025e9.14.2026.04.20.07.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 07:49:21 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:49:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jorge E. Moreira" <jemoreira@google.com>, hreitz@redhat.com, 
 stefanha@redhat.com, gmaglione@redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <aeYvCK2qhZd1W9sA@sgarzare-redhat>
References: <20260411021205.3592118-1-jemoreira@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260411021205.3592118-1-jemoreira@google.com>
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

Thanks for starting the discussion here, let me add also Hanna, German, 
and Stefan in CC that can help us.

On Fri, Apr 10, 2026 at 07:12:05PM -0700, Jorge E. Moreira wrote:
>Migration of back-end state happens while the device is suspended (i.e
>all vrings are stopped). To resume normal operation on the destination,
>the vrings need to be started again with a kick (either a write on the
>FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While

It's true that in the spec we have:
   "Each ring is initialized in a stopped and disabled state. The 
   back-end must start a ring upon receiving a kick (that is, detecting 
   that file descriptor is readable) on the descriptor specified by 
   VHOST_USER_SET_VRING_KICK or receiving the in-band message 
   VHOST_USER_VRING_KICK if negotiated, and stop a ring upon receiving 
   VHOST_USER_GET_VRING_BASE."

But IMO this applies when a driver is not yet loaded.
When we are migrating, the driver could be already loaded. So, in the 
new device running in the destination, IMO we should consider the ring 
already started or add some messages to tell to the device: "hey, the 
device was already started, this is a migration and it's completed".

Sending a kick from the frontend, seems more an hack here.

That said, for example, in subprojects/libvhost-user/libvhost-user.c 
IIUC the virtqueue is started when the SET_VRING_KICK is handled by 
vu_set_vring_kick_exec(), but not sure how compliant it is.

>these notifications are typically sent by the driver, it has no reason
>to send them in the destination if it already sent them in the source as
>the driver is unaware that a migration took place. Therefore it should
>be the responsibility of the vhost-user front-end to ensure these vrings
>are started. This is particularly necessary for queues where data only
>flows from device to driver, such as those used by the vsock and input
>devices.

Exactly, so IMO we should not use the kick, but maybe add something new 
or clarify what to do after the migration.

For example in the "Migrating back-end state" we have:
   "Migrating device state involves transferring the state from one 
   back-end, called the source, to another back-end, called the 
   destination. After migration, the destination transparently resumes 
   operation without requiring the driver to re-initialize the device at 
   the VIRTIO level."

So, IMO we can use the VHOST_USER_SET_DEVICE_STATE_FD channel exactly to 
inform the new device about the state: "there isn't any state to 
transfer, but I notify you that the device was already initialized, so 
the vrings can be started".

>
>This behavior is already used by some qemu vhost-user front-ends (e.g
>vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm).

I looked at vhost-user-blk frontend, but I don't see it. I mean I see 
the code around the comment "/* Kick right away to begin processing 
requests already in vring */" but that one IIUC was introduced more to 
fix devices violating specs, so not sure it's a good example to follow:

commit 110b9463d5c820120c8311db79f55a64c9d81ebe
Author: Yongji Xie <elohimes@gmail.com>
Date:   Wed Jun 6 21:24:48 2018 +0800

     vhost-user-blk: start vhost when guest kicks
     
     Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
     kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violates
     the virtio spec. But virtio 1.0 transitional devices support this behaviour.
     So we should start vhost when guest kicks in this case.
     
     Signed-off-by: Yongji Xie <xieyongji@baidu.com>
     Signed-off-by: Chai Wen <chaiwen@baidu.com>
     Signed-off-by: Ni Xun <nixun@baidu.com>
     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


>Adding it to the vhost-user documentation makes it explicit that this
>strategy is permitted and suggest it to vhost-user front-end authors.
>Explicitly documenting it is necessary because vring kicks appear
>designed to originate in the driver, so having some originate in the
>front-end can be counterintuitive and cause developers to waste time
>looking for other alternatives or face pushback during code review.

As I pointed out in our discussion in 
https://github.com/rust-vmm/vhost-device/pull/936
IMO we should use some in-band messages and not relaying on kicks that 
should be used only by the driver to notify the device about new 
available buffers.

That said, I agree that we need to clarify in the specifications exactly 
what the backend and frontend should do after a migration to start 
vrings if there is no need to exchange a state.


Any other opinion?

Thanks,
Stefano

>
>Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
>---
> docs/interop/vhost-user.rst | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 137c9f3669..ad5aba3430 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -656,7 +656,10 @@ destination, following the usual protocol for establishing a connection
> to a vhost-user back-end: This includes, for example, setting up memory
> mappings and kick and call FDs as necessary, negotiating protocol
> features, or setting the initial vring base indices (to the same value
>-as on the source side, so that operation can resume).
>+as on the source side, so that operation can resume). The vhost-user front-end
>+may also write to the kick FDs of vrings containing unused buffers or send
>+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in the destination
>+since the driver likely already kicked them in the source and won't do it again.
>
> Both on the source and on the destination side, after the respective
> front-end has seen all data transferred (when the transfer FD has been
>-- 
>2.53.0.1213.gd9a14994de-goog
>


