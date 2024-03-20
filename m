Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD8AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyJz-0003Vd-Gv; Wed, 20 Mar 2024 11:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmyJx-0003RY-HJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmyJv-0008TU-LR
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710950258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZhnImmYDFqakXJLp39yv26+A3HIttvTpFtNWPSTMeM=;
 b=JxTfRtxZ6RZW4BiB8idGnTycvgZRW8jA2RWOj6nV3DxIqgCvBuH7qpfb5XeFJJoX87W5dA
 WQAehXkV3j8pkjksM09EFiwUBJUOdFiECmrCj44ZzBHWJXRoa/Ny0Mv6z60eoh9TNqD5tY
 XbKW/ZAaYYtiycePOhhgxkCqxQUcja4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-k8zLO3YYNc2pRBGOV8obVg-1; Wed, 20 Mar 2024 11:57:37 -0400
X-MC-Unique: k8zLO3YYNc2pRBGOV8obVg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-60cd62fa1f9so102977847b3.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710950256; x=1711555056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZhnImmYDFqakXJLp39yv26+A3HIttvTpFtNWPSTMeM=;
 b=KSiYLj3wxHI6PWwHX7ebfz1hcw4LO5N1nrAWQcMO4Xrtm27km5kpfXDxERo8GDds5e
 IgDKj2Ac4wcVhgSVa8X6O9a+/jx+3l0R2zVADkWsLpTmz1tRO0iyLnuDcqXQUS0GTomf
 d+rlEgL6iN7fT0XVcQXGcO2yVXOmUy5i3SAgLUPk85nuMNxvbg7/QcL8weU/7R63zlv0
 oD+VjtseZ+OuluxQt9e8V6SyAA4jQGPSU/dD2Y+OrTj1D2YJGPXFFa/0mSmMCgwFKXzw
 mAJa2WOwxM5H1dkMdcyvI0rF4BS6zQFmY360FWINBNyBLEwA/RfwgXfYvTJV4L8NoIz0
 CP4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlbO8RpzHmTI8Qpei5q47l+DIPYlixbgSBWzKHreMkmEQgxk8jDso4fL91YGiXQxqZbOwQWppmM57Cb2iS1TA1csO+h7A=
X-Gm-Message-State: AOJu0Yx6duucddpadqa5MRxo4q5Rlb7IZNkgU+jmxhhdzuqJEhikOj4D
 WRypzSLzCRlSqF3oYSk0lj51cQxDHHLuGC3vHgCSn4Ia6Eyv+fj5yAZObwPCIOlzleVrIhWNt1N
 TtYD+5E7uIzj/KaP5PN/VJziM7OdwGgxk8JPCE9v7JDqH9EMVvk/hQs4uzmCEsKidTaF2xMNX13
 hyKQNsuYv9CMzjBg2cenHR5rybz6U=
X-Received: by 2002:a0d:f2c3:0:b0:609:69e2:8599 with SMTP id
 b186-20020a0df2c3000000b0060969e28599mr17875213ywf.44.1710950256691; 
 Wed, 20 Mar 2024 08:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKKZ7RUZc+o78FhCZBwYQOcNF+qx/GhUMQlMMcn7KHluQWkU0aI0oqSm3nuvCD7SBtcVXBruOYGaqJUiFWiDM=
X-Received: by 2002:a0d:f2c3:0:b0:609:69e2:8599 with SMTP id
 b186-20020a0df2c3000000b0060969e28599mr17875206ywf.44.1710950256399; Wed, 20
 Mar 2024 08:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun> <1786176.VLH7GnMWUR@valdaarhun>
 <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
 <9252283.CDJkKcVGEf@valdaarhun>
In-Reply-To: <9252283.CDJkKcVGEf@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Mar 2024 16:57:00 +0100
Message-ID: <CAJaqyWdUpLjgWK-mcBb0_34aXRu6g9D==W8-o4+FhchQaWQvTQ@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Mar 16, 2024 at 9:27=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> Thank you for your reply.
>
> On Friday, March 15, 2024 4:57:39 PM IST Eugenio Perez Martin wrote:
> > [...]
> > > Some sections in the above docs were difficult to grasp. For the time
> > > being, I have focused on those parts that I thought were relevant
> > > to the project.
> >
> > Please feel free to ask any questions, maybe we can improve the doc :).
>
> I understood the introductory sections of the documentation such as the
> "About QEMU" section and the first half of the "system emulation". Sectio=
ns
> and subsections that went into greater detail were a little overwhelming
> such as the "QEMU virtio-net standby" subsection [1] or the "migration
> features" [2] subsection. But the red hat blogs and deep-dive articles he=
lped
> cover a lot of ground conceptually.
>
> I feel once I start getting my hands dirty, I'll be able to absorb these =
concepts
> much better.
>
> I did have two questions that I would like to ask.
>
> Q1.
> Regarding the "Deep dive into Virtio-networking and vhost-net" article [3=
],
> the "Introduction" subsection of the "Vhost protocol" section mentions th=
at
> sending the available buffer notification involves a vCPU interrupt (4th =
bullet
> point).

Now I realize we used a very misleading term there :). Without
ioeventfd, when the guest writes to the PCI notification area the
guest vCPU is totally paused there, and the control is handed to
host's KVM first and QEMU after it. The same physical CPU of the
machine needs to switch context because of that.

Is an interruption of the execution and a context switch. Maybe
"paused" is a better term.

> But in figure 2, the arrow for the "available buffer notification" indica=
tes
> a PCI interrupt. Initially I thought they were two different interrupts b=
ut I am
> a little confused about this now.
>

They are different, but at that part of the blog is just the direction
of who interrupts / notifies who :).

> Q2.
> In the "Virtio-net failover operation" section of the "Virtio-net failove=
r: An
> introduction" article [4], there are five bullet points under the first f=
igure.
> The second point states that the guest kernel needs the ability to switch
> between the VFIO device and the vfio-net device. I was wondering if
> "vfio-net" is a typo and if it should be "virtio-net" instead.
>

Good catch :). CCing Laurent, the author of the blog, in case he can
modify the text.

> > [...]
> > There is a post before the first in the series:
> > https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-head=
jack-
> > and-phone
>
> Got it. I didn't know this was the first in the series. I have now covere=
d this as
> well, so I can move on to "Virtqueues and virtio ring: How the data trave=
ls" [3] :)
>
> > > 1. Virtqueues and virtio ring: How the data travels [8]
> > > 2. Packed virtqueue: How to reduce overhead with virtio [9]
> > > 3. Virtio live migration technical deep dive [10]
> > > 4. Hands on vDPA: what do you do when you ain't got the hardware v2 (=
Part
> > > 1) [11]
> > I think it's a good plan!
> >
> > If you feel like you're reading a lot of theory and want to get your
> > hands dirty already, you can also start messing with the code with the
> > blogs you already read. Or, maybe, after reading the Packed virtqueue
> > one, your call.
> >
> > In a very brute-forced description, you can start trying to copy all
> > the *packed* stuff of kernel's drivers/virtio/virtio_ring.c into
> > vhost_shadow_virtqueue.c.
>
> I would love to start with some hands-on tasks. I'll take a look at
> the kernel's "drivers/virtio/virtio_ring.c". I think I should also start
> going through the "vhost_shadow_virtqueue.c" [4] source code.
>
> > There is a lot more in the task, and I can get into more detail
> > if you want either here or in a meeting.
>
> Thank you. Either means of communication works for me although
> the latter will require some coordination.
>
> > If you prefer to continue with the theory it is ok too.
>
> A good balance of theory and practice would be nice at this stage.
> It'll keep my brains from getting too muddled up.
>
> Thanks,
> Sahil
>
> [1] https://www.qemu.org/docs/master/system/virtio-net-failover.html
> [2] https://www.qemu.org/docs/master/devel/migration/features.html
> [3] https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-=
net
> [4] https://www.redhat.com/en/blog/virtio-net-failover-introduction
> [5] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-tr=
avels
>
>


