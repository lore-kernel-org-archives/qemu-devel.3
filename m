Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1628FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwL2q-0006ri-Cd; Tue, 18 Aug 2026 10:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwL2p-0006rU-Im
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwL2n-0006ky-V6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787064240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFo9Y9eNwSpnDVpqfWXBdC22wXK7GMPT08eH5Db7MMY=;
 b=csPdzDsUmxdtE0rNp76MRzW0knNyStZArrPwR2nklHlOwxDV8ODsLCrl9iYyDXcSIDUYub
 6hXxkxIx7D03MAsR5lVxUhUlxpsB4wEpl+fccPeVkNK2Ql/rVFYj1twovBGxCHyiBFx9cj
 7zuDt47cq67hb9rsF0MG2qLNs1TGf1g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-oz757NMvNvKt4Bt157cp-g-1; Tue, 18 Aug 2026 10:43:58 -0400
X-MC-Unique: oz757NMvNvKt4Bt157cp-g-1
X-Mimecast-MFC-AGG-ID: oz757NMvNvKt4Bt157cp-g_1787064238
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e934385db1so209456d6.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787064238; x=1787669038; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TFo9Y9eNwSpnDVpqfWXBdC22wXK7GMPT08eH5Db7MMY=;
 b=t/ZVqQuTaQpGx1Ed00nZ7KMLsfzGKp3NzqNFo9hayGGT13SbavzouwTKsFtWrwRseo
 yFVwhxuv0IhYjF8GonJg+QBJTPOEcIT7KQheqIK7Y7OoN5mmykZD+K3hArkwPS6ZZnEc
 69FXOtWpbbUzDD6urDmfRLbCwK1cGuhUizXs1EWYF9WpSERQb0+l1a+3acvAk3gxiOWA
 w5KnFupFJdoRnGT0iqAR+NPvjuaBjXKRDoGVgkGMrETlUwD6k6aIsJpBPS/25wO8k7uL
 DIzuBkZMlxfF1i+l/w2A20oZW8ete/aGsJvvYLQujvNsPdiRK+OvG/tnnnSJ3/JBpnVe
 nreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064238; x=1787669038;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TFo9Y9eNwSpnDVpqfWXBdC22wXK7GMPT08eH5Db7MMY=;
 b=kJeYJeF6NAGWluXdkU5+vbVvEuA9N5pMw5SHCjIaGJkGNGrUQ0/7ZyJEvUKfq3PQRN
 2KSCHPPX1Rr2tVT+eyjm40BOvT1s5bghNrpXqv9/AUgsMD4XEyMGgCilpm3XK3DrbnNM
 H0jXpzp9AjsPu6b6rIC+vcHz8iSWJ+EgY2/BGxAZVfgkaruafaMvFKKOI2KR73wLGQ70
 0xuwUW+iwE6HVJdy0rgjQBUd+qdvOBEcOgrY+JNKGA+1CpZWflbYu+/CvjufZ5VUJOob
 6GbcZXX1itUuHy3VAavCW1PGhhcuf/WVeKJ/lBqpX4YGWU4JYxg3Q3jnxdThX/eUa2xY
 1kFw==
X-Gm-Message-State: AOJu0Yy1W4Bz2jsNBb4iYxduvgtnBhbmOdoDyGCXi2fVYG4KY9FtTP0U
 qhY2KWgDGp28fXc0gqPVX47ieJQkc9NB8ySBa+0iIeuGTAadxs+S2GlzEYzWAxwODsw/88N3Pwf
 K6fdVKi+iOIlLs6o2ESmrrEDBQ8a04SWeJuQ1hoBLXeemUI1z5INqBVja
X-Gm-Gg: AR+sD11uOkRboX3cEqn/Y07Fz3vU6K/AxidkELUp+eN5saPgeuUceeCS9VvOAuYMaUi
 pL8bd0wBLdzMKW+m1or01y6bN3srwCy7b7vILlL17/46fOUan0w1il/AbO1H76kfv7u+f4vd/RQ
 JgVwI/4d+f8+8+0K8rMsXEMQ5KCpe+u8q9UUbfvaWaux79fIVNt+hJLNG5Ff6Y2R5sqnwmZUBjO
 gSSG088zPyvQZ9ehghrg1axD5xwCinApsvssYkwKYP7r2YJ5UfOZx1exikkhaBaNYQWq5y6kb04
 1+t5od8sbkfxZeSHUg5q1g23qtSwGIDhX/PXFY8XlzRvJBe3esScqEfsdKZRZvqTYd2K
X-Received: by 2002:ad4:5746:0:b0:908:9c82:695e with SMTP id
 6a1803df08f44-90c4b0c4c18mr94723976d6.0.1787064238050; 
 Tue, 18 Aug 2026 07:43:58 -0700 (PDT)
X-Received: by 2002:ad4:5746:0:b0:908:9c82:695e with SMTP id
 6a1803df08f44-90c4b0c4c18mr94722986d6.0.1787064237418; 
 Tue, 18 Aug 2026 07:43:57 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5016c3a2sm16400346d6.37.2026.08.18.07.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:43:56 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:43:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Jack Wang <jinpu.wang@ionos.com>,
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
Message-ID: <aoRvobhlj6-YJsqT@x1.local>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com>
 <aoRXk0H1muF_gZJP@x1.local>
 <4a0b20e5-947c-45a4-8fcf-89c77e0a4cfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a0b20e5-947c-45a4-8fcf-89c77e0a4cfb@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Tue, Aug 18, 2026 at 09:57:12PM +0800, Yanfei Xu wrote:
> 
> On 2026/8/18 21:01, Peter Xu wrote:
> > On Tue, Aug 18, 2026 at 07:57:06PM +0800, Yanfei Xu wrote:
> > > Hi Peter,
> > Hi, Yanfei,
> > 
> > > No objection to removing the dead code — it clearly never worked
> > > 
> > > I do have one question about the direction, though. The removed logic
> > > was the only in-tree attempt at MR unregistration for the non-pin-all
> > > path. Without it, registered MRs grow monotonically over a migration,
> > > and with large, widely-spread dirty memory over chunks the accumulated
> > > MR metadata (user + kernel) can cost more than pin-all and even perform
> > > worse — which rather defeats the purpose of not pinning everything.
> > > 
> > > do we still intend to keep and improve the non-pin-all path going
> > > forward? If so, some form of dynamic MR unregistration will eventually
> > > be needed and it might be worth keeping this code，or at least leaving
> > > a TODO to mark the gap?
> > Thanks for taking a look.  This is a valid question to ask.
> > 
> > Though it was there for 13 years without being "enhanced", it means the
> > possibility we leverage it in the next couple of years is low.
> > 
> > You also discussed the other side of things: I am not a frequent RDMA user,
> > but my understanding is frequent MR reg operations already slow down
> > migration quite a bit.  It means dynamic management including unregisters
> > will be even worse.  AFAICT, it'll be a challenging task if we want to keep
> > the performance in bar and add a hard throttle to pinned memory.
> 
> One advantage of non-pin-all is that it neither sends the all-zero chunk
> nor registers the corresponding MRs. For guests with a low dirty-page
> workload and a large number of zero pages, this lets it migrate faster
> than pin-all and pin less guest memory during the migration.

I actually don't know why RDMA_CONTROL_COMPRESS is only used in !pin_all,
do you know?

I can only guess RDMA WRITEs were fast and need no round-robin chats, so
it's faster than RDMA_CONTROL_COMPRESS, but you seem to say it's not true.

Meanwhile, I would expect pin-all=off ultimately should meet the same perf
over pin-all=on.. so I don't really know how needs pin-all=on...  maybe
it's useful when one is looking for minimum total migration time when VMs
are required to be evicted from one host?

Feel free to share if you have more data points; I'm almost speaking from
reading the code, so it could be wrong.

Thanks,

-- 
Peter Xu


