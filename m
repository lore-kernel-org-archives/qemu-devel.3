Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C952C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ke2-0004LT-GV; Tue, 29 Apr 2025 09:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9kdw-0004Jf-VV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9kds-0001Rh-V6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745931892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nrCjU7uUSDJ+lWC4154feQNw/X8mcWdAxgYV/tyL5M=;
 b=J45CWTFUzm4jtI5YkrCqQmN9S3ALXQgkfOBIi/B+lntESZMZdQ8z03WIAS/3JkNai+M8dT
 Ij/VM8ryi3xocegP6+em9ibkr1l12hlFQwqpgwNC3nQxAq4/xrSo/0K3fo9eZeAFGLQj0v
 kylT86hvQhPy3xuTxbL3afbdLaFizbY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-xka3sRa-OEeIxBdqlhtHog-1; Tue, 29 Apr 2025 09:04:50 -0400
X-MC-Unique: xka3sRa-OEeIxBdqlhtHog-1
X-Mimecast-MFC-AGG-ID: xka3sRa-OEeIxBdqlhtHog_1745931889
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5c9abdbd3so554969285a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931889; x=1746536689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nrCjU7uUSDJ+lWC4154feQNw/X8mcWdAxgYV/tyL5M=;
 b=uDnBvc9GasKaxNDRO0Sj0Hgp/tpfGOMiYq4de7+vmHxeL9kA+ZAlQCU6lk5NG064ms
 W+3AWjtmUuGm4obC9Cyk0Rgmj1G5Wlsw8c+m4DZgQaSNyKJszEasi1FY8KyuHD1O2f3R
 9Su/8aS9/eec3TvMAZ40XBKX4M63FmPvf74o8sEpkMnNN0DnVq4zQ3Ia2tgQWxB+ED15
 wM6FgrOl8HP3rrEndBx/Hc9XhFZt6PxRKLbiPQqYvaND9yRhFHTuG9H4O+X7Eghmo8Ya
 rXRZcHN5ZR7sU2R2U3XkrR458jykWHDqvce1FD+BaeReJszkpD15EJ8TP/JsICa5v1NM
 rG3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwPRfiXfwwEuo2ZE7eTDRR+QlBO75MqtDA8Md2GFQEPPKwv6ap63gcmB3Ss0iEgxj4O02mCdnSYQxs@nongnu.org
X-Gm-Message-State: AOJu0Ywp4BjRZ3Q6BKnuyBdezfUOxxAq0WtcB4rmGiD2+pY7/Q1zAzKz
 mg3KhWWGfR0qS0PQejlZzWcfNdk78hxIND0CZV4p1V8xHmsXv9hVS0D/dO1DIKzquM+Wx7p9ykJ
 485SNYQIlymsMOCHwQS2K0chn6Umf0HoC7pgeRRfTsfbx9u3Blswl
X-Gm-Gg: ASbGnctSGRW6txKs6PTj9b9H4W/SDImnhwuPk/OP0iN11RwUG/Aj33sm8MUWUUXnJuI
 Ihhya4YsEOVsACMrDoVluz3Qw8oaPboEtU/5mG3tQSVQVmGnvwotdy2LkmMhcvWDG/glJRsU4pD
 Ax8UTWDQyugbJu919hKSjGBDtqp9Qvt6Reaxu87anl9GzslNinmDZXkoZ9aAlPs6B5mosILhRgm
 XxMwYWOcwOrDL1M/a91mnS9ZJqG9WG/Ck6lrqw4sib8F9TcnST3UbgF2ep8Q5ckT5di1kIhqNF+
 /3A=
X-Received: by 2002:a05:620a:28c9:b0:7c5:642f:b22f with SMTP id
 af79cd13be357-7cabdd80fddmr519427685a.18.1745931889625; 
 Tue, 29 Apr 2025 06:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzV2CJhrN/ZxCuM2+dAkTyHp02W0b3KMZY0RHCEItJb4XruCPpr8kn8CBAh8bc4KIBHeAkAw==
X-Received: by 2002:a05:620a:28c9:b0:7c5:642f:b22f with SMTP id
 af79cd13be357-7cabdd80fddmr519423185a.18.1745931889231; 
 Tue, 29 Apr 2025 06:04:49 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958eb534csm734188285a.117.2025.04.29.06.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:04:48 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:04:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
Message-ID: <aBDObgL7hDQMy63F@x1.local>
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Tue, Apr 29, 2025 at 06:21:13PM +0530, Prasad Pandit wrote:
> Hi,
> 
> > On Thu, Apr 17, 2025 at 01:05:37PM -0300, Fabiano Rosas wrote:
> > > It's not that page faults happen during multifd. The page was already
> > > sent during precopy, but multifd-recv didn't write to it, it just marked
> > > the receivedmap. When postcopy starts, the page gets accessed and
> > > faults. Since postcopy is on, the migration wants to request the page
> > > from the source, but it's present in the receivedmap, so it doesn't
> > > ask. No page ever comes and the code hangs waiting for the page fault to
> > > be serviced (or potentially faults continuously? I'm not sure on the
> > > details).
> >
> > I think your previous analysis is correct on the zero pages.  I am not 100%
> > sure if that's the issue but very likely.  I tend to also agree with you
> > that we could skip zero page optimization in multifd code when postcopy is
> > enabled (maybe plus some comment right above..).
> 
>    migration/multifd: solve zero page causing multiple page faults
>      -> https://gitlab.com/qemu-project/qemu/-/commit/5ef7e26bdb7eda10d6d5e1b77121be9945e5e550
> 
> * Is this the optimization that is causing the migration hang issue?

I think that's what Fabiano mentioned, but ultimately we need to verify it
on a reproducer to know.

> 
> ===
> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
> index dbc1184921..00f69ff965 100644
> --- a/migration/multifd-zero-page.c
> +++ b/migration/multifd-zero-page.c
> @@ -85,7 +85,8 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>  {
>      for (int i = 0; i < p->zero_num; i++) {
>          void *page = p->host + p->zero[i];
> -        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
> +        if (!migrate_postcopy() &&
> +            ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
>              memset(page, 0, multifd_ram_page_size());
>          } else {
>              ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
> ===
> 
> * Would the above patch help to resolve it?

Looks ok, but please add some comments explain why postcopy needs to do it,
and especially do it during precopy phase.

I'd use migrate_postcopy_ram() instead. I wished migrate_dirty_bitmaps()
has a better name, maybe migrate_postcopy_block()..  I have totally no idea
who is using the feature, especially when postcopy-ram is off.

> 
> * Another way could be when the page fault occurs during postcopy
> phase, if we know (from receivedmap) that the faulted page is a
> zero-page, maybe we could write it locally on the destination to
> service the page-fault?

I don't think we can know that - receivedmap set doesn't mean it's a zero
page, but only says it's been received before.  It can also happen e.g. >1
threads faulted on the same page then the 2nd thread faulted on it may see
receivedmap set because the 1st thread got faulted already got the fault
resolved.

-- 
Peter Xu


