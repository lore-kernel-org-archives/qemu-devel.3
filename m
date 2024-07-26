Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5ECC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLC1-0007RO-U5; Fri, 26 Jul 2024 09:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLC0-0007Qs-DE
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sXLBy-0001Gf-FG
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvcgbraQaupJ+tJToBmXh9CZ2F9z5w/pSxoUUHKpiNs=;
 b=NsqlrJX5+DfY+qIcnU3oPACOQtA+LsX/03xbHlB4uGNHpuVdwPumi6ruhhQGoUSGGJSajv
 Au1/zLExIr8vZpS618KVgOZ734GTkj+aisluDdRwj4ywuNfkoANGyr/0k1s5hTJozJdtc/
 Bd+ENcC4x/Bqiom0nBF3W8R0sHY/ufs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-JnrtpYooMaabFQyEAGn6aw-1; Fri, 26 Jul 2024 09:41:01 -0400
X-MC-Unique: JnrtpYooMaabFQyEAGn6aw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-650fccfd1dfso49360947b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001261; x=1722606061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvcgbraQaupJ+tJToBmXh9CZ2F9z5w/pSxoUUHKpiNs=;
 b=Zjn9AZ+ZshBDdNdj0QO1I+P9ni+41z0k5hEhZUoWtS+69nGbxpmCyo2UY04qT253nI
 ZuFhTXL+ijUUK/vA9y0lT6NcHcz1CFqyhG/+AfTubP2AF8pHS6uhvozW/BOdIYfqcg84
 V+f6KVMTJxczMXYHcgIcQf2eeaQqDuCDkEE2t2HyQmbRnawgX3VaGNHjCjX3ADdkITO9
 Ljf2+TQjdvek+b53pg4/nblh4z8qezh0gXPhfQvpmZJWRlVq4b+MJAMYwNSwKxAcrQFK
 XP+MEmyxrqdfANYl8WRBQiKOaAgR2ARuCAIdvLB8BNPezgWPTp2/1TFjgdh2IlSEOfkV
 VP+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0W8XgG1P8e0nF4lD8nuUYEncVvwi9Yms6KrkGWUA1N2uTWrNf5KI+9112s0q6Uox16uN/xqpOknt9CNe7FnkQPyicXyw=
X-Gm-Message-State: AOJu0Yz6OLCy8NHO5hSegitUMkL3io5O5pb4xyd0qhIzC0w3WErjTnFM
 fUGffZmw+kjIRPhVqreoVyx+7dD8r0zJloH0jOxqpbej8B1++JQl5JRcQHbU0Cpqjosb8a6G8V9
 EJnFGXCKqlnfhm+ch+E68VZjThqOYJoYOdb89EYOfyIrVDIHNBIGBQgx4r1maUbf9NaYfYI9+eo
 6M80WhHJ9WNHEwAjDlLDYjH6kWCrE=
X-Received: by 2002:a0d:ef42:0:b0:646:5f0b:e54 with SMTP id
 00721157ae682-675b8811f24mr56657607b3.8.1722001260827; 
 Fri, 26 Jul 2024 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCAedybNBS8uzo9pRPf1t4KngoX+P4Y0IQ1K6D4bhxC6kD4vQcHLxhCO4IRSJMX2H9e/IG4WfdQ31vbBQdw5w=
X-Received: by 2002:a0d:ef42:0:b0:646:5f0b:e54 with SMTP id
 00721157ae682-675b8811f24mr56657417b3.8.1722001260494; Fri, 26 Jul 2024
 06:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240726095822.104017-1-sahilcdq@proton.me>
In-Reply-To: <20240726095822.104017-1-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jul 2024 15:40:24 +0200
Message-ID: <CAJaqyWdZeohNn3BpD=Od9F9JekayYnXR-RBOn6OX_Oq4uYq5MQ@mail.gmail.com>
Subject: Re: [RFC v2 0/3] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
>
> Hi,
>
> I have made some progress in this project and thought I would
> send these changes first before continuing. I split patch v1 [1]
> into two commits (#1 and #2) to make it easy to review. There are
> very few changes in the first commit. The second commit has not
> changes.
>
> There are a few things that I am not entirely sure of in commit #3.
>
> Q1.
> In virtio_ring.h [2], new aliases with memory alignment enforcement
> such as "vring_desc_t" have been created. I am not sure if this
> is required for the packed vq descriptor ring (vring_packed_desc)
> as well. I don't see a type alias that enforces memory alignment
> for "vring_packed_desc" in the linux kernel. I haven't used any
> alias either.
>

The alignment is required to be 16 for the descriptor ring and 4 for
the device and driver ares by the standard [1]. In QEMU, this is
solved by calling mmap, which always returns page-aligned addresses.

> Q2.
> I see that parts of the "vhost-vdpa" implementation is based on
> the assumption that SVQ uses the split vq format. For example,
> "vhost_vdpa_svq_map_rings" [3], calls "vhost_svq_device_area_size"
> which is specific to split vqs. The "vhost_vring_addr" [4] struct
> is also specific to split vqs.
>
> My idea is to have a generic "vhost_vring_addr" structure that
> wraps around split and packed vq specific structures, rather
> than using them directly in if-else conditions wherever the
> vhost-vdpa functions require their usage. However, this will
> involve checking their impact in several other places where this
> struct is currently being used (eg.: "vhost-user", "vhost-backend",
> "libvhost-user").
>

Ok I've just found this is under-documented actually :).

As you mention, vhost-user is already using this same struct for
packed vqs [2], just translating the driver area from the avail vring
and the device area from the used vring. So the best option is to
stick with that, unless I'm missing something.

> Is this approach alright or is there a better alternative? I would
> like to get your thoughts on this before working on this portion of
> the project.
>
> Thanks,
> Sahil
>

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
[2] https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18ab=
e43/lib/vhost/vhost_user.c#L841C1-L841C25


