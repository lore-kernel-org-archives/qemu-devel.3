Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD8CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOC1-0001Pt-3D; Mon, 11 May 2026 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMOBs-0001NJ-OJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMOBr-0002mf-7U
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778496526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0U1MHFNaYv7Sttil56eRYisy3ne36tiAS+epZsQqy4=;
 b=Fq7cTMMrJjV8WsMoaPWl8Hq394axEJgWz43KMGY2nLV/4pKX8oN5pQVHxdGs/N+rp+U6Jw
 qmCI49iVT1f05Dso2eMsRMLjsshCnc3iXSRTgg74M35M98APtpyUAQpiKJRS+Tkql2YCDr
 WZsSWD98DiTznss/bG+pgQ+4n2i3aWg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-6et89fqGNtSYcDgsC1p0xQ-1; Mon, 11 May 2026 06:48:45 -0400
X-MC-Unique: 6et89fqGNtSYcDgsC1p0xQ-1
X-Mimecast-MFC-AGG-ID: 6et89fqGNtSYcDgsC1p0xQ_1778496524
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44ffa15dc8cso2715405f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778496524; x=1779101324; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+0U1MHFNaYv7Sttil56eRYisy3ne36tiAS+epZsQqy4=;
 b=r+dpqLOwRJxNVuc2bMywDSFYF445nHWQVEwA6O5ig03OQuzpp8/jTdtdxYK35OZgF7
 0B3PeUoFUbxRTyYVN3vVUxBWuSQImsPul+RsUIrcsVaLUDhOYLkqweVx7rPCeWC3ZITT
 USk2w4NFdW2XENMXGwkVnd/RMMSiaXt71ceMir/lm6liVt2CH1bmwd0rKNcveCd/yAEh
 L3Hj1oE9Xx2umLp5ISJ6FR1JnAQYFFPLzDSaEcpFcnZd7p+0XFDqmLqOu+iQoLvidZ3w
 BqN/3bB7ab2a/GpBCkVFn8POHLp10vjWhAyMT8BRclE7HW+fHqdT5aHymyrY9qu23IDn
 dHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778496524; x=1779101324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+0U1MHFNaYv7Sttil56eRYisy3ne36tiAS+epZsQqy4=;
 b=LXc1bGMBfKrRA8q6ikLrKZHvjtab+pJnv6dvRUMu7quHzSQYaqKeQwz6RsBTfHbEOE
 yshTsDVYeDTpxbJrXIsq2ijU7Xc17nVGFlx2sf07FXwhJZ49f0/3TWrBIhjvIVX+RqJg
 EfvMy3VMAQOIboIL2vP2Vqxlokk5vvEomSfYY3M/P2hLr2t0giBUYFdxf6vtW4F7n3u6
 kKGKJag1kA4d57Rux5lIOIqCWNNHfJt4rFaHdKoKBG7lZi1Fm4BZFP2n0LP2LmA+11Lq
 r/o3g+pRDwp1XrlJ1qFIzAUPEmaZ/J/pjLuiL5Vo1L/Crf4Nxd/IoWfIqGIB5hRnL76n
 ypww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8S9SwYoEzF5FciBAbd6xAJNH0kZvhWBnxZTO1+6HcQxQ7ZpuWciO6mwhzwcBH/9+wl/uuxyNPub8Ys@nongnu.org
X-Gm-Message-State: AOJu0Yy6ZlhJonr/hBoMTTIhglCgki3owkNp3TWkdq7ahXgQ1jvQsKfR
 8assF301usfbVS1TvLitsFdq24JQ+chDEwJt+WqhTINrFFNZ8xiBC+ut7haNziwgkOpt0BqIfgN
 ovMJXMJrh34DcVbt3eG3XzxSRBSSACraI0DXFT5GnNXrmDjaxk9iYe9aI
X-Gm-Gg: Acq92OFLiIozNmjaXEa1OU1UwwwDS+dGx11IE+cfPaOypI3ykwoYhSFl4ybdGeOakwU
 I44lKpdCGkajQp+S+H6Pzs28LbCUClCpWFC/peoLfgliX7uQa4UTxYfVks3uWJ1N479P2eLZrgj
 cmqOFljPU4PYCvUhci5lNZgpuFaz/w1EoQ0VYMKI4zmeO14v2mt3PHF/A0Y3VKHMYX/A8CtBgzj
 2BRueoMOl/pli1G09P/YPtkpCmNiqxmUrOQTF5vT6feYH+v4Q5zHn3nhpK4AN1k/u2XUXySEYaU
 FCEqW7oT+7ncVkKQNOmm3PZLGRrVP8WCGuZsNRdVY8cNeA/BdgYSjLF4Ec0Zzl+jYIqMyN7f0zH
 RG4AfmRR03QO4tpxgMoG8yI3xpQe7U4KRhQpIWF8t
X-Received: by 2002:a05:6000:310a:b0:451:1143:7df5 with SMTP id
 ffacd0b85a97d-4515d2e72ffmr37102141f8f.41.1778496523643; 
 Mon, 11 May 2026 03:48:43 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:451:1143:7df5 with SMTP id
 ffacd0b85a97d-4515d2e72ffmr37102068f8f.41.1778496523051; 
 Mon, 11 May 2026 03:48:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm25457448f8f.13.2026.05.11.03.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 03:48:42 -0700 (PDT)
Date: Mon, 11 May 2026 06:48:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn,
 qemu-devel@nongnu.org, lixianglai@loongson.cn,
 chenhuacai@loongson.cn, Avihai Horon <avihaih@nvidia.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
Message-ID: <20260511064834-mutt-send-email-mst@kernel.org>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
 <c87311a3-b214-4705-8ed3-7386aea1056e@redhat.com>
 <20260510161352-mutt-send-email-mst@kernel.org>
 <f1f3f8c9-4142-46ad-87b6-2681b9ec5bc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1f3f8c9-4142-46ad-87b6-2681b9ec5bc6@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Mon, May 11, 2026 at 11:26:56AM +0200, Cédric Le Goater wrote:
> On 5/10/26 22:19, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 10:08:49PM +0200, Cédric Le Goater wrote:
> > > On 5/7/26 11:23, Song Gao wrote:
> > > > diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
> > > > index 22f6eb8ca7..7baf1968a3 100644
> > > > --- a/include/standard-headers/linux/virtio_ring.h
> > > > +++ b/include/standard-headers/linux/virtio_ring.h
> > > > @@ -31,7 +31,6 @@
> > > >     * SUCH DAMAGE.
> > > >     *
> > > >     * Copyright Rusty Russell IBM Corporation 2007. */
> > > > -#include <stdint.h>
> > > >    #include "standard-headers/linux/types.h"
> > > >    #include "standard-headers/linux/virtio_types.h"
> > > > @@ -200,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> > > >    	vr->num = num;
> > > >    	vr->desc = p;
> > > >    	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > > > -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > > > +	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
> > > >    		+ align-1) & ~(align - 1));
> > > >    }
> > > 
> > > The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of
> > > libc types") changed this virtio header and this breaks the
> > > build on Windows :
> > > 
> > >    https://gitlab.com/legoater/qemu/-/jobs/14297040230
> > > 
> > > A fix could be to reintroduce 'uintptr_t' (available through
> > > osdep.h) by modifying the linux headers update script. Ideas ?
> > > 
> > > Thanks,
> > > 
> > > C.
> > 
> > Yea sorry ( Just add
> > #define VIRTIO_RING_NO_LEGACY
> > somewhere.
> > 
> > 
> 
> Something like :
> 
>   --- a/scripts/update-linux-headers.sh
>   +++ b/scripts/update-linux-headers.sh
>   @@ -104,6 +104,7 @@ cp_portable() {
>            -e 's/struct ethhdr/struct eth_header/' \
>            -e '/\#define _LINUX_ETHTOOL_H/a \\n\#include "net/eth.h"' \
>   +        -e '/\#define _LINUX_VIRTIO_RING_H/a \\n\#define VIRTIO_RING_NO_LEGACY' \
>            "$f" > "$to/$header";
>    }
> 
> 
> Thanks,
> 
> C.


right.


