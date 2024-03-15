Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D0C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5jc-00084J-2m; Fri, 15 Mar 2024 07:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rl5jZ-00083b-9c
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rl5jX-0001SQ-1P
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710502097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2h2pYTgh5PyMC74qLvTPILXe53aZuAmn8woLk5C2Lo=;
 b=Vg8cedScIcX/ojoQIK8gvq0m6enIWv9oACRqbpujUBrLeT4Gnt0y+s4oJ70CniBFuk5EpH
 B9tWfxcfQnGFzz9AJSWjg5NV7jvvtUgpyZFStKwB7DCSNEOCe3fmrb+XntJTvITECx2MCX
 pCfEuxwFNO8Ib2BL3+aG4GdtnUYbUq8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-v3ax8I-pOfeTQglPtizWQg-1; Fri, 15 Mar 2024 07:28:16 -0400
X-MC-Unique: v3ax8I-pOfeTQglPtizWQg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a0151f194so33790967b3.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710502096; x=1711106896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2h2pYTgh5PyMC74qLvTPILXe53aZuAmn8woLk5C2Lo=;
 b=OdQYvjwHwtkrE5jw2Ho5b0sPWIACLVSDisKsICiVdwSuKNd1G9PLJCAbC8KZvqfKti
 SiNq7RVnIFn3SmrxY1fAB3oGz1QADcfCrtah1lz/2P9YAVKHzYQ12QnxfzvIv7i+QCZ9
 /ofUcWWHvnx9xE+kBzQiV6RUQzVWzXt4XFASSwJybINUSctJiV+6CKZMAXP6ufN5bx2c
 IncUhQ7l4WnX9ZCy6ryjEjBScLwuOrkeJlo+9zvGO7MWOYGSgiMPjy49u/B4eSyYzNZF
 Ypv/KGsIcT3qhizozP7aBcsGDNv+ycpVCe/1xxw13FZl1bV+Hk3O5HOH+nOyKIoiuxqO
 prKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1yApnP+WUS9vr/HOY2YSXJSKIY+zRus4S1v3QrEsM0ex7nTxwugrgnUrwHZyMzvElFJCSpmOFo5GVfjCm4lswfWm7MK8=
X-Gm-Message-State: AOJu0Yws3HUjo+lwmW0YvTFlAMnyzkVIPCo/HUVES2jmGwU6Km/ghReI
 mnFkG2+b0IaGfWJJLKDQ2+fsFu6JHJfsJg6TocWnPMeQuO9R/192tlCvMcQZD89QrfWk4j1+jCJ
 GK5z3VEYTWa83gQEpaFge7G2hHSJPhwgV3z5n0mNkqzNTwjaSKvTXQY6svzmzN7mFN5UBpjGoyl
 BGN8rVMgVyDWqNN1k0FnnoiD2erz0=
X-Received: by 2002:a0d:c282:0:b0:60c:7540:37d7 with SMTP id
 e124-20020a0dc282000000b0060c754037d7mr3997487ywd.7.1710502095784; 
 Fri, 15 Mar 2024 04:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFRHWtNHxg3+AXifEO1h0YjSLFgr6U9WeJHW9UbmfMPjIFuIEc2Zhnwezr6zCmK3kkVSkO/lRnhtZZnxoyGos=
X-Received: by 2002:a0d:c282:0:b0:60c:7540:37d7 with SMTP id
 e124-20020a0dc282000000b0060c754037d7mr3997467ywd.7.1710502095416; Fri, 15
 Mar 2024 04:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun> <6022175.lOV4Wx5bFT@valdaarhun>
 <CAJaqyWcuU_kQpCN+U3ejWgfm+zBv3Mofe0zyi-RB+rbqgDHEgg@mail.gmail.com>
 <1786176.VLH7GnMWUR@valdaarhun>
In-Reply-To: <1786176.VLH7GnMWUR@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 15 Mar 2024 12:27:39 +0100
Message-ID: <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

On Fri, Mar 15, 2024 at 8:15=E2=80=AFAM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> Thank you for your email.
>
> On Thursday, March 14, 2024 8:39:45 PM IST Eugenio Perez Martin wrote:
> > Hi Sahil,
> >
> > It's being hard to find a good self-contained small task related to
> > the project to be honest. As it would be out of SVQ, would it be ok
> > for you if we start straight to the task of adding the packed vq
> > format to SVQ?
> >
> > Thanks!
>
> Sure, this works too! I would love to get started with the project.
>
> I have a small update as well. I have read through a few docs and
> articles to familiarize myself with the relevant terminology and
> technicalities.
>
> 1. "About", "system emulation" and "user mode emulation" sections of
>     the user documentation [1]
> 2. The migration subsystem [2]
>
> Some sections in the above docs were difficult to grasp. For the time
> being, I have focused on those parts that I thought were relevant
> to the project.
>

Please feel free to ask any questions, maybe we can improve the doc :).

> I have also read through the following articles:
>
> 1. Introduction to virtio-networking and vhost-net [3]
> 2. Deep dive into Virtio-networking and vhost-net [4]
> 3. Virtualized Hardware Devices [5]
> 4. VFIO - "Virtual Function I/O" (Just the introduction) [6]
> 5. Virtio-net failover: An introduction [7]
>
> I hope I haven't gone off on a tangent. I was planning to finish reading
> up on the following articles as well:
>

There is a post before the first in the series:
https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-headjack=
-and-phone

> 1. Virtqueues and virtio ring: How the data travels [8]
> 2. Packed virtqueue: How to reduce overhead with virtio [9]
> 3. Virtio live migration technical deep dive [10]
> 4. Hands on vDPA: what do you do when you ain't got the hardware v2 (Part=
 1) [11]
>

I think it's a good plan!

If you feel like you're reading a lot of theory and want to get your
hands dirty already, you can also start messing with the code with the
blogs you already read. Or, maybe, after reading the Packed virtqueue
one, your call.

In a very brute-forced description, you can start trying to copy all
the *packed* stuff of kernel's drivers/virtio/virtio_ring.c into
vhost_shadow_virtqueue.c. There is a lot more in the task, and I can
get into more detail if you want either here or in a meeting.

If you prefer to continue with the theory it is ok too.

> I believe the hands-on vPDA article will have me set up a development
> environment for the project as well.
>

Yes, that's right.

> Please let me know if I should amend my roadmap. I am
> excited to get started :)
>

I think it is a great plan!

Thanks!

> Thanks,
> Sahil
>
> [1] https://www.qemu.org/docs/master/index.html
> [2] https://www.qemu.org/docs/master/devel/migration/index.html
> [3] https://www.redhat.com/en/blog/introduction-virtio-networking-and-vho=
st-net
> [4] https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-=
net
> [5] https://access.redhat.com/documentation/en-us/red_hat_enterprise_linu=
x/7/html/virtualization_getting_started_guide/sec-virtualization_getting_st=
arted-products-virtualized-hardware-devices
> [6] https://www.kernel.org/doc/html/latest/driver-api/vfio.html
> [7] https://www.redhat.com/en/blog/virtio-net-failover-introduction
> [8] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-tr=
avels
> [9] https://developers.redhat.com/articles/2024/02/21/virtio-live-migrati=
on-technical-deep-dive
> [10] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-=
virtio
> [11] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-ai=
nt-got-hardware-part-1
>
>


