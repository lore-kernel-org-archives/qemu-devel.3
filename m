Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0D5C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0bw-0005oR-01; Thu, 22 May 2025 03:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uI0bt-0005nv-T6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uI0bs-0000Ig-0t
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747899897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQZUGXm0llvR9IhqVa4yIUGJXsTkGHMhmABycPtiUek=;
 b=JGySFtdrv4I7HEKSEtXNJTpCav8e1juRW3hj79M4ygSRV4NHBVAOtLc7nGTQGEO3fUgVYY
 D7sO0C/e4sLlr6hFqI85NMPwGhUBe8E4QRF195xDkCQP6gmMK2rNi9aV0H/GG7id76PGQ4
 hCpjm94lO/UM6ooun0DUnZdaWk4fyKo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-O6zmmOYRMf2fT14gWELb9A-1; Thu, 22 May 2025 03:44:55 -0400
X-MC-Unique: O6zmmOYRMf2fT14gWELb9A-1
X-Mimecast-MFC-AGG-ID: O6zmmOYRMf2fT14gWELb9A_1747899895
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e7b9273c33cso6930741276.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747899895; x=1748504695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQZUGXm0llvR9IhqVa4yIUGJXsTkGHMhmABycPtiUek=;
 b=TUcXCUa1Ns+a+/KyVau1MPSTYfyG0TX2W8sQLVcODrR4g3M3NS03MTYnEMgtsxR+l0
 G/oPy+qNfmpPZulVvnVXXevk7wVpGDPxd6rpQvhzXrXVxo6OEG9nwMkgy/uUXZKXCTF/
 F8oZr1NDthS6zf+SfWSdTnLkXAGCnhyKu4/RAx/3AMl2hgA4f2KOgjabw90G16DqraGP
 Zm2nrI2MQcG2rysSVdNUVOd3IRHnnd4dpFqJyooE7q1dZTb1gIil/Yr8ZpSddZltmOJw
 NzITagp1UsXxeflJBP93naCdOETE5H0g3StOpP9BR9J3qmmgDuWPG01IhSWROGyGcFrV
 2bsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhbexuEQGWtcDHsbN3F+WXCjlvxaG+NBPJjl/kBNVZBzZGB6npfsjAd6Atsliv5hDHq2plgqjctRKt@nongnu.org
X-Gm-Message-State: AOJu0Yx4H2eK1zoDuWBr7lTotJRyEwk17mqXOrEwZ1Hgy9Fm7e6mpYcm
 Gkr7JEjtr+DB9gu/2EFbGLCENYJeQNw5EE5+P3rDEZd7pwHmRShF9//hn/4CtUxToQydbP86fDC
 nsPBcsla8N5Sl4dpsQobugJI42klSjKK3rcV6GEArVlX+LYGFr9/hx2AR+Fl7wd7U+76JlPqpJI
 Zc9l6LqlPMwIN9DXE2mGl8trzxXiVHsn8=
X-Gm-Gg: ASbGnctLbSAtVa+aSwC4gFloid7+9X++w7yE0veqj6waM0edpO4/GxU3NtncAsR8W/h
 n3kr2Jgd4roYPnQM0u11plhOQKGxHjnae11l1S1Qnj8fT4BgTgHkVRzE+D/YZSEQce6A=
X-Received: by 2002:a05:6902:2b13:b0:e7d:763c:a12f with SMTP id
 3f1490d57ef6-e7d763ca65bmr155987276.13.1747899895362; 
 Thu, 22 May 2025 00:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2/73WYKqgpLV6Fu4gYxHOb0YSjinNCPtYUaLQjb1myImPQBJjkEtS/Sm7aWb42d6PA7rbMNgAS8Z3hto7VNU=
X-Received: by 2002:a05:6902:2b13:b0:e7d:763c:a12f with SMTP id
 3f1490d57ef6-e7d763ca65bmr155962276.13.1747899894990; Thu, 22 May 2025
 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
 <CAAuJbeJ4+cop8m_9sy6VJtafADhxxmkwaFMZvfo_mmpmFU0Vxw@mail.gmail.com>
 <js757hz2wuwhjafk7z2gmfqxdb6d5hhjx3ul7bwqst5qdqa5b7@f2lhjb6itxo2>
 <CAAuJbeL-yyigS8jE2xvvq84cUKmggrCPgc+ko3=Ks+JvokxF8Q@mail.gmail.com>
In-Reply-To: <CAAuJbeL-yyigS8jE2xvvq84cUKmggrCPgc+ko3=Ks+JvokxF8Q@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 22 May 2025 09:44:43 +0200
X-Gm-Features: AX0GCFvML6S3oSVpo1cUcYbknP_l_3ZV_uv_lW78dJFWMmXmysrgL2osO93-1zE
Message-ID: <CAGxU2F7WX=VRvASzSp+66z_C-5e5yALSeZqToT+LhNoqLPrGJA@mail.gmail.com>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
To: Huaitong Han <oenhan@gmail.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Huaitong Han,

On Thu, 22 May 2025 at 05:39, Huaitong Han <oenhan@gmail.com> wrote:
>
> Hi Stefano,
>
> I=E2=80=99ve implemented the version based on your suggestion. The core l=
ogic
> now looks like this:
> if (k->query_guest_notifiers &&
>     !k->query_guest_notifiers(qbus->parent) &&
>     virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
>     ...
> }

Which is the way it was before, right?

>
> And in virtio_pci_query_guest_notifiers():
> if (msix_enabled(&proxy->pci_dev)) {
>     return false;
> } else {
>     return !pci_irq_disabled(&proxy->pci_dev);
> }
>
> Although this works and preserves the original interface, I personally
> find the logic less intuitive to read.

I think I've already explained the reason for my request, but I'll try
to explain myself better.

Since we are fixing a problem, I think the patch should be as least
intrusive as possible to avoid new problems and to simplify the
backport.

So IMHO changes such as a readability improvement are not something to
be included in a patch that fixes a problem, but in a separate patch.

> if you're fine with this version, I=E2=80=99ll go ahead and send v3 based=
 on it.

Yep, and if you want you can send another patch, or put both in a
series, to improve the readability. But again, I'm not sure if I
followed you about that, so if you will include the second patch,
please explain why it improves the readability.

Thanks,
Stefano


