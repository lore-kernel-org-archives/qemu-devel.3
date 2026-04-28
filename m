Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892B5FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcQa-0005wI-Rs; Tue, 28 Apr 2026 03:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wHcQU-0005uU-4B
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wHcQQ-0006B2-Ft
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777359605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dPFMo2fQw/0zfcUyYekok3h4o8hjaIAAKeca43Idp0=;
 b=fcmqEfIe/8ei1yv7SkJ+4fYuBmkapJ1SzUFYpel8vu4+OU/mVAldpRFWO9CfLzzk6AcO8G
 dAzFVUnPzXGIp1htKymDjWDkZOG/HHgC68S/lm2MamAqErPMVF1DJYBkHR83KMe5x+fBmf
 dd2qkT+wyJeb7QKCT4r4GB8I5X/HLf8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-teZOd6Q3POCV22GIb7kEVQ-1; Tue, 28 Apr 2026 03:00:03 -0400
X-MC-Unique: teZOd6Q3POCV22GIb7kEVQ-1
X-Mimecast-MFC-AGG-ID: teZOd6Q3POCV22GIb7kEVQ_1777359602
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4440c5944fbso1886179f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777359602; x=1777964402; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4dPFMo2fQw/0zfcUyYekok3h4o8hjaIAAKeca43Idp0=;
 b=bXU53jDAXveCj153k/8GJTaGJdrnynXEeq72k2bNQb1RJ5VMKna97vBqjJtZ49WxVi
 hhqkx4s3CHiHdPq6/PXoMc6qpMZm+0NKs8IbhQomEY49UivMXfNJzwlbEBbParfvz/DV
 ZKSnyRVKgUSFijthrEh4nUoi5Z+OMkfey6DCEDk7GRlWbp7xxfvlpmPd4s1UCixgtrU5
 X/sz5pBiK82XQby6/WFD8V3Z2l+Ph6sJXJW0UUCDA/9vxjBrZ3EdveNftoXpkLmCk4Nh
 YoQMg5LXj+y7A2ZpWGymePEEShw7TD9WAneL54pClmUEbv+/dSq3130D9CBixR3ia+7f
 5zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777359602; x=1777964402;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dPFMo2fQw/0zfcUyYekok3h4o8hjaIAAKeca43Idp0=;
 b=X52pZWZInvJE0gI3pc29lLTdT3CjDu3XeeyMJliezw33Hr570tnOwnS5UKXANaMNIw
 2Xz0cLYR+SLJ5aFgXuXHAwmfRtSbB/GMsGFJ6J8RxggbwgUmXJi3TiM/GiSFQ5KyFRhx
 g8V0k4+gkUfySvsQThRdCVyAM4NkeAhLMpoZ7tkRjX9NGukAF2BWnWQ401KWc1YNyQxn
 pxUNxNzTXxYAb36uxGZOpOxS9S5lC0LtPxEjC6j6skh8qVu8iFcJpDGrx6QKggVH9Y4J
 ti7ZK2Pz2gW66h8lRd4D8e19s2oOUqx9iKgshRIiPwJRrXU0T+cgt+9GmPeIw+/BIpoP
 BbXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ebJtYD2zPMigfPE+KSA/6q5dKC7w5jY75znbp2oYiKKf9SO3KY601entWNDT8698JrGSryTQX9tb2@nongnu.org
X-Gm-Message-State: AOJu0YwAaOhUpcAhYJMkf290GLr2P7X6nYsNJFm+9aos2cizchBi1AN/
 LyxdykkfPvln7/lpuOs5s/N2rZVIwqT44YJhmwChZEtaqFBcz7IE9aD0/NWPuwrmIdzrfLjkFPO
 EVLhb1Ce3/iDwYWRQW4lQUuJCO1e5IvIe5szjM/r1TUe729zO6vfzSpqD
X-Gm-Gg: AeBDieu5Az2sN0H+hr+N6F9CcnhmM32IoWBAz2URkKjVD0K/ospstM6q8IMY2V76tr7
 lbyKTHpTIfW92GpBugqgQEP89KOoLnMkxORGfPvJi0zW3x6JLYELx+4Bw7WF7tSTLwnvklxW1MU
 3KASMk71FHf2o9yIx2dYsZegx1JGJYprKDpoOxZ17RDc+lwJxuBVW7hpYYl9qw7BBolnuWvs1CF
 31vjLqVLIYyB6UMck52xZEYqtr9NVmmktYiGcBY+LAzog9ugY/UFlSB+7pQz4ubodrV7opWBq5Q
 S6amXfpLdHaQ92EFkTTLKgpoogNbBEy3e+zj/iwIGuawXBkCyygfJb/zZ14HcRI10cGGDD6bsvI
 8lSVqYWMqR85GL9WRKQHbnOqjV9mmn2RzpjJ3xkmOpYqWOY/SUVm6jWwt
X-Received: by 2002:a05:6000:2505:b0:43d:7508:c9c6 with SMTP id
 ffacd0b85a97d-4464a1684b1mr3206573f8f.28.1777359602239; 
 Tue, 28 Apr 2026 00:00:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2505:b0:43d:7508:c9c6 with SMTP id
 ffacd0b85a97d-4464a1684b1mr3206490f8f.28.1777359601615; 
 Tue, 28 Apr 2026 00:00:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463fa89140sm3896709f8f.27.2026.04.27.23.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:00:00 -0700 (PDT)
Date: Tue, 28 Apr 2026 02:59:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jorge Moreira <jemoreira@google.com>,
 Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260428025111-mutt-send-email-mst@kernel.org>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427224545.GH218226@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Apr 27, 2026 at 06:45:45PM -0400, Stefan Hajnoczi wrote:
> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> > On Wed, Apr 22, 2026 at 1:32 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrote:
> > > >
> > > > On Tue, Apr 21, 2026 at 2:12 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > >
> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > > > While starting the vrings on SET_VRING_KICK could solve the state
> > > > > > machine issue, it still won't notify the back-end that buffers are
> > > > > > ready (the driver won't do this). Non-polling back-ends depend on this
> > > > > > kick, especially for queues where data flows only from the driver to
> > > > > > the back-end. Most implementations likely attempt to read from the
> > > > > > queue only after receiving the kick.
> > > > >
> > > > > This is an interesting question to clarify in the spec.
> > >
> > > Yep, which is in part related to what I wrote in the other reply:
> > > "I think the main issue to clarify is what the device should do
> > > when the vrings are configured, but the driver has already been
> > > initialized (which is usually the case after migration)."
> > >
> > > > >
> > > > > Stefan
> > > >
> > > > This is the question that interests me most, to be honest. I'd rather
> > > > have the discussion about when to activate the vrings in a different
> > > > thread and keep this one focused on whether the front-end should send
> > > > the kick or if the back-end is expected to check if there are "new"
> > > > buffers in the vring after restore.
> > > >
> > >
> > > IMO we don't need anything from the VMM. When the device receives
> > > SET_VRING_KICK, it can check if the vring already contains buffers
> > > (and this is the part we might need to clarify) and wake-up the other
> > > threads (or always wake-ups them, as crosvm does IIUC, and let them
> > > perform this check).
> > > After sending the SET_VRING_KICK message to the device, the VMM has
> > > the exact same knowledge of the vring state as the device, therefore,
> > > it's still unclear to me why we need to inject that kick.
> > >
> > > Stefano
> > >
> > 
> > Is it possible to activate a vring after it has been deactivated with
> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> > reactivate it?
> 
> Hi Jorge and Stefano,
> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
> a VM is paused and then resumed.
> 
> You can stress test this by driving I/O using iperf (virtio-net) or fio
> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> QEMU's monitor.
> 
> Here is QEMU's code for starting (including re-starting) rings:
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?ref_type=heads#L1341
> 
> QEMU does not inject a kick. The back-end must check the rings itself.


I would worry that there could be buggy drivers that expect buffers not
consumed until the 1st kick.

A safer thing to do would be for source to record the fact there
was a kick after reset and for destination to then inject/check.


> I'm not sure that all vhost-user back-ends actually check the rings. I
> think back-ends should do it, but we should also update the spec with an
> front-end implementation note recommending injecting a kick after
> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
> with implementations that follow the current spec wording. And at the
> same time I think the spec should also be changed to say that
> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
> vring upon processing the message.
> 
> That seems like it would clean up the issues without introducing
> compatibility issues or making existing implementations non-compliant
> with the updated spec.
> 
> What do you think?
> 
> Stefan



