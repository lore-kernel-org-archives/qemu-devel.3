Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC19C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 02:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9FZS-0004W4-SX; Mon, 20 May 2024 22:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9FZR-0004TV-J1
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9FZF-0002N1-Lr
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716259772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPhztye5LSuacoa3I2KzsGwZyx6wnIeiY8cgr6k7pr8=;
 b=g+lIYxyymEzbe6UkbQEBBSQqUeBJ1yQLAn0FfMYC8l3L7XJsES+ap61TGJ3FGFqvoVHz1k
 zXfd1/ZflXQDHf60vb3A1ZWPMsgOe1uuXdOE7csIFv0EFvQpSh9BMOt1HnFXK4qJMgkJFJ
 oiePJc0HA1ZAHRx8rSItWokTNNi6TyQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-zK-bpj-ZOgO4VwNCn1uugQ-1; Mon, 20 May 2024 22:49:31 -0400
X-MC-Unique: zK-bpj-ZOgO4VwNCn1uugQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b96f302d84so7519137a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 19:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716259770; x=1716864570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPhztye5LSuacoa3I2KzsGwZyx6wnIeiY8cgr6k7pr8=;
 b=wwjirBZA4wS0D4rDGu/QTdcOMjvvV1ptlVTSIlM1hYbw+iU4KfGZGIMkCS5hXhLflN
 W+qAfy4Yf2aZmNwr7O1cUcqeB/56tg+sNEqGWzJ/E1iC8dnAmIQZ5wUY14V8Pkrc//xM
 uJZ3KZXpiCCsL5tnPrqHftBBShaXBp1DEPKX+AK3jZiveyKrWCeT+nnqUsPUU2ha1fit
 PLC5ste0OpG6AjMKUWZmcLU7GqvjQOIpnv/VFwsR+6huX0W8yxFlWpO/zwegJFBs//XQ
 iHx1nXJz6+Sm73hvLz9ltvmvYjK6BZKWrIEjfcsCDXCqsl4QBSKHQoN0uY/oY9Fvg5k9
 ATWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1I9kRsLTRQPg6R+iPfF2ClFFlZUq647DEEqbbd0/6+wWIbTWxQwfPbFmIhPRkV1cfM+aYDSORT2aSCV09nE8qg2VgKeg=
X-Gm-Message-State: AOJu0YzURQTy9S588vOkC/UXl09fhwTI5csMhII/YNYpuM6EtrZElMX/
 uL/XeN3jvVh5X1f9Hu7fxlJOIkk1JTnDJ3btuoKfMOIwX05HGVoXJn/W7sz0Yg2urYEQDZYo4ha
 lkCZYfKv3+phjSvN9LCAoGdf5yrsCR2bOM1BG8+dR5uqHn5cSUAkNOMmqX8IgFuVHGZqtPv0RwO
 6vVpOGCzspZMxIWyiHVyogZZYTUYI=
X-Received: by 2002:a17:90b:124b:b0:2b2:aac3:fc2f with SMTP id
 98e67ed59e1d1-2b6cc76d796mr32075376a91.18.1716259770296; 
 Mon, 20 May 2024 19:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3yQE91ozfcBXtzmKk8qFnLlAQ/JD6fA1cfodQSEDoggmsjNBT2o5hFju0TPZN9ooxAimSxrU2B/N5b9lxMNs=
X-Received: by 2002:a17:90b:124b:b0:2b2:aac3:fc2f with SMTP id
 98e67ed59e1d1-2b6cc76d796mr32075359a91.18.1716259770008; Mon, 20 May 2024
 19:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240517075336.104091-1-f.ebner@proxmox.com>
 <87h6esjf7i.fsf@suse.de>
In-Reply-To: <87h6esjf7i.fsf@suse.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:49:18 +0800
Message-ID: <CACGkMEu4w0JjzNVBp6b-mJsnpOcHbCR4XJPsYpC84JamDA9ywA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
To: Fabiano Rosas <farosas@suse.de>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com, 
 eduardo@habkost.net, yuri.benditovich@daynix.com, andrew@daynix.com, 
 peterx@redhat.com, t.lamprecht@proxmox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, May 21, 2024 at 6:23=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Fiona Ebner <f.ebner@proxmox.com> writes:
>
> > Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
> > version 8.1 can fail with:
> >
> >> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179=
bfffe7
> >> kvm: Failed to load virtio-net:virtio
> >> kvm: error while loading state for instance 0x0 of device '0000:00:12.=
0/virtio-net'
> >> kvm: load of migration failed: Operation not permitted
> >
> > The series
> >
> > 53da8b5a99 virtio-net: Add support for USO features
> > 9da1684954 virtio-net: Add USO flags to vhost support.
> > f03e0cf63b tap: Add check for USO features
> > 2ab0ec3121 tap: Add USO support to tap device.
> >
> > only landed in QEMU 8.2, so the compatibility flags should be part of
> > machine version 8.1.
> >
> > Moving the flags unfortunately breaks forward migration with machine
> > version 8.1 from a binary without this patch to a binary with this
> > patch.
> >
> > Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> I'll get to it eventually, but is this another one where just having
> -device virtio-net in the command line when testing cross-version
> migration would already have caught the issue?

Yes if you are using Qemu >=3D 8.2. Qemu has a default machine type for
each version.

Thanks

>


