Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D224CC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woy0a-00038Q-Uv; Wed, 29 Jul 2026 02:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woy0Y-00037i-Rk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 02:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woy0X-0006c2-CK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 02:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785307392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Axd1EoHnmhzRa1SQPWvvHGAxnFWzpQ2UvAfELfnuDSo=;
 b=PV/cEbNb2n+7rCST/R+4rcgnHlTTvpY3d6ukC7rKlcthnWOE1j0R0vT3zTTsWGXwejUDEk
 XpV4UBA1raEEBtr4KSRnSeERdw3TMOFdicSw3r9NjQX365cPNRR2m2NR/NmSQEnI8de4Mh
 KK+wfRxI8R9VORw0Bj0fTipQQOxjV4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-P7NwQS-FMgC49QYFLAh3iA-1; Wed, 29 Jul 2026 02:43:10 -0400
X-MC-Unique: P7NwQS-FMgC49QYFLAh3iA-1
X-Mimecast-MFC-AGG-ID: P7NwQS-FMgC49QYFLAh3iA_1785307389
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso4030765e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785307389; x=1785912189; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Axd1EoHnmhzRa1SQPWvvHGAxnFWzpQ2UvAfELfnuDSo=;
 b=Ce6Hj+y3P5idYXyGJiES0stZWz9uDm6Y6ggxcxH+mIal1NhxSP0ib7adUhY5YIQZ/a
 Z6dl9LSuOHxO7vawTJnTv3ITIOx+Bzrck5niRUBhUipDc2kxbqYqnuGkLQrrrROtvShz
 n7f6XhEKVwtYVj8cnWItjyEFidGrx8FD/XSSYfYQV05jEaCyCkmxVc54FNaTdQQsyCA+
 FVNtrkDcKbQitUm/9fUu1vYPIJi8dFxM5pnzqPwZVnL5zSEz+a+b2XZMV9Ry3biZr3z5
 Pk0ldwKlu8M6CthjtB1wo7R4Z+B9gUPS7oWJMyoQXUh8PdHQzJ+uDTm1JhFzlPxLChJ0
 sv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785307389; x=1785912189;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Axd1EoHnmhzRa1SQPWvvHGAxnFWzpQ2UvAfELfnuDSo=;
 b=CNr0vJ/7vPVO3ZEKUYgQC82YYO+gahrG+Y88IdubTBfjcRxIKI+AkYET41CjEqZgju
 nQ9ijDkIbMTGMFGvxPlbd4Fs/5QAfXWpwyNfXfIhDX2ySqqpqYWmYmuX8MUjHlr759gJ
 BeSVlXsaUlZd7aQgkJnNiqBI5xq/keJ4v0vugPtewYGLnOmwbtv6hWo73sYaeOlC/PLD
 yZZihJ175aSjaHbxgZmupCDmkTu7MAFTn+ctBIYeB9o1dfQwZ3ynqY0rbwo/K5XDZQeM
 WfKhPOSCA5JN9yOhwiwd6D7qBT/HVEcM03j1+dsJPwP4xSSOyT7/03fjHCcB/LFwx8sV
 GA4w==
X-Gm-Message-State: AOJu0YwlUWpXnPKeKspYrV7T/1zo6t9baQBzZ/FrtYLprr9X3jbKu2hn
 U7aA273D4HLlBWLjc5HnOAxuh3LPE+mNdx8TwTa6BX8AjTU5MfeHaDaA0zdguXwegXYYr6Xv1M3
 kCm14K915jdtCOyZvh+CuLcJYltIH60qZrpiEYNZO0VpsV51Nm02AYFYB
X-Gm-Gg: AR+sD12RjUWDmtyP1vdV6zj/oZI8OIZtVRJ11qXSp8G2PIDgfq4eOveYdQtz0OJBKXK
 H1zYyzZ/CSa6eC1N1TsfOgB0gyNcyaZ+s1yUFIF/NqtzFGH8IeGvP7gopvsyDDCCYGl/OqVcLst
 dVEhKSkyJCwC5AuOJi59DZ+Lhep9ue3r6Nlp0CLLjnW/tDR7BjAuoCITP7uAwEvAFiubkrBcgjx
 ZElsKceLzez4qp3HLJ6JyGhjGNrYTqASwsXSVrowaORO+QPrR+qmuiqE3It2aVhVXnxbliF0IvC
 d4JL2w8z/9o1aEnzGzcBHOpwcpaUHiX+ooxJTJGsZPNycalyQyXZ7/3EKBcXcR4Hbg/rjwj7pfa
 JHg7Zh9n1kz2iCdOJ+WOEc90=
X-Received: by 2002:a05:600c:4f86:b0:496:c933:c276 with SMTP id
 5b1f17b1804b1-496c933c2afmr45867145e9.25.1785307388994; 
 Tue, 28 Jul 2026 23:43:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4f86:b0:496:c933:c276 with SMTP id
 5b1f17b1804b1-496c933c2afmr45866595e9.25.1785307388294; 
 Tue, 28 Jul 2026 23:43:08 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4632263sm141575415e9.15.2026.07.28.23.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:43:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 02:43:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260729024227-mutt-send-email-mst@kernel.org>
References: <cover.1785179875.git.mst@redhat.com>
 <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
 <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
 <20260728154328-mutt-send-email-mst@kernel.org>
 <75f2277a-8508-4e6e-adfe-92bed9fc1bf6@tls.msk.ru>
 <20260728192047-mutt-send-email-mst@kernel.org>
 <af6d5296-9860-4c5d-a72e-f2eacac3e2e9@tls.msk.ru>
 <c376bfdb-e917-4d6a-b89e-69e7185798ae@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c376bfdb-e917-4d6a-b89e-69e7185798ae@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 29, 2026 at 08:24:22AM +0300, Michael Tokarev wrote:
> On 7/29/26 08:12, Michael Tokarev wrote:
> > On 7/29/26 02:22, Michael S. Tsirkin wrote:
> > > On Tue, Jul 28, 2026 at 11:17:34PM +0300, Michael Tokarev wrote:
> > ..
> > > > So this whole change, for older versions, becomes just:
> > > > 
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -2572,6 +2572,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> > > >       if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
> > > >           abort();
> > > > 
> > > > +    queue_size = VIRTQUEUE_MAX_SIZE; /* fixed properly in 11.1. */
> 
> BTW, with this override in place, the second half of this fix isn't
> even needed - for older/stable versions, this line is enough to fix
> CVE-2026-50626.
> 
> > BTW, can't this logic be implemented without a compat property in
> > the first place?  This x-override-queue-size seems like a hack.
> > or a.. twisted way to compare a machine version.
> 
> Besides being a hack, it also redefines a #define within a compat property
> (using a "magic number" instead of a symbolic constant) in a non-obvious
> way.  Though it might be a good way here, since the property value is the
> actual historical number which should never be changed.
> 
> > Can't this very place become
> > 
> >     if (machine_version < 11.1) {
> >        queue_size = VIRTQUEUE_MAX_SIZE;
> >     }
> > 
> > instead of using this indirect property?
> 
> That would be great if this patch can be reduced to this (plus the
> fixup for VIRTIO_MMIO_QUEUE_NUM_MAX in virtio_mmio_read) without
> (ab)using properties like this.
> 
> BTW, isn't x-override-queue-size becoming a part of user interface?

I guess you dislike how qemu handles compatibility generally?


> Thanks,
> 
> /mjt


