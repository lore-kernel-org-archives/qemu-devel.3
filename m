Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F91D6D237
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWG6N-0000yv-94; Thu, 18 Dec 2025 10:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWG6K-0000ye-TU
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWG6J-0003pk-BN
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766072373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/OeVd6fdUWqnCYvBeyMfaKW5ukTSQw1GKS8WSZIE74=;
 b=S9efwa7h/9Mb4pqiNZHgDiHN/BkCfeTwF9+2Pdq4untoFiZU2oQzhXk8eJEOQQSfpUEeVx
 CDmu5LDsDFDB782uxrZYYbIRHAUKvtPZAzTAWkRffkIk/QwqkxgMrUxQT6LK+lT3QlxGij
 uIRIHhmAHJlblyc6bL68qM/kbkmU2pA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-xfo9-Fq2OEW584ObI4bBkg-1; Thu, 18 Dec 2025 10:39:32 -0500
X-MC-Unique: xfo9-Fq2OEW584ObI4bBkg-1
X-Mimecast-MFC-AGG-ID: xfo9-Fq2OEW584ObI4bBkg_1766072372
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a344b86f7so25013296d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766072372; x=1766677172; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I/OeVd6fdUWqnCYvBeyMfaKW5ukTSQw1GKS8WSZIE74=;
 b=ZaXrq2EMoXwhaaQxj1B4zmDM/6gly+MRsXsp7s3HYf4yZva0BqJ10gp8oGr+xKYYV5
 HcrQAp9BxcvMRQoaXPG1IJeSx3WQ6AHEttz1gV2tH2UQZARye8STVFBcvc21tLyYVvln
 k+t0uM0H/59C0FW46mX5kBndD+/B/3WnCfvr8Aa6SDFBZGqBb8QrOKhO6l4AtV9FOAMN
 PFD2S+HKheU/5FZhsv9gpjuKi0NktwH5cNhmxjdmf7jlTUeXf73Asbd6sFrPWfVI/tgw
 PbJyN4F5Rf2ZEinzQ/Bgj9WMYryWaOy7KPsdP6LZxzkBxKAhtPtNwMIMOq64Z3riQuv5
 52qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072372; x=1766677172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/OeVd6fdUWqnCYvBeyMfaKW5ukTSQw1GKS8WSZIE74=;
 b=UOCxa9i7dgSXEPhE9g6be5FXiunUJGaHroYpbf1TnSZbxeKPmuY0jDse3XfA3E2fjG
 1Zgds+6ZjbADT4xyKXGixeVnRzHx1HyLXIJ9nqqvEPSafI1J5tK26my0ytT+QjmJvzdX
 wnDeVNSGlS2Qlj7LfVhb1WDaTawtzsKV1LK3ufcuzQbQ//j6QRVXY8c66X9sFdVdzqzb
 m5ASRLxeyDduRXIU6WpffTzoETTMbmkcA0V7K1s12zy4vqglIZoEsXtoHA+gfrxtyEQ7
 IQvE9FqIOdXo2oCbeTglWEZc6jlgopAxeJnaa5UaafefDjY+EurBnrBP52SKQ7/tWu+E
 158w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8X8xt0HyGNIExKL9QBY3D9MY7YA5QGX7WKExiSLIOTTs7dvFBiS28/Nw+hVDW+ZbMOJg0ckeCWZ+X@nongnu.org
X-Gm-Message-State: AOJu0YwjRxFE3MKyR1ltaIuy/bksqyARD9Z1m9xQaSciCRmcJLEi2xJr
 aUJZHZGCcBKTJ5t0PChdx0KFR555ecsvzSHvjLMOPVE2KjuU4bs3cJJd6E+8RnZZKNB4MdE0zEP
 tl5Xj/QM+P5pkezJFubPQVEcYJpd8da7UVq+O8EuXBjBFvdpHbRWuSBYH
X-Gm-Gg: AY/fxX4q5ZSuNQnNrJX0tUUzL0p+9yyKKmGa3IGFhuMN6OSK0AsF8tPxwX1FXGcrLTn
 gKDjXDZpCsEKk6jtruW5NbAnYoAkMogo/9Cb9l+9+6Sgi/chXGzWQDY432Zff8hoR0mHisOwEED
 VKq6YiyhPmEsQa+QSPU8GsOQsc62OYeacsz5LUk5tIb3ceDEfArPASNxZHAxYgWJsIzr42AeKEF
 e7fueFVhACmTtdEGps7FaiyZT10yweA3CXS70PtcJs/SwvJ0L332BbqFwbkhtTKqLFZKOGsFVL7
 iMWkp+cvgJEyG68pIrqq17e3xROfhrXHRrETJsuj8JanZ4q2p4Y/4FZJ85pWsicADh46Y18UE0O
 BOu4=
X-Received: by 2002:a0c:ed42:0:b0:888:8096:a09c with SMTP id
 6a1803df08f44-8888096a4f6mr249288636d6.62.1766072371784; 
 Thu, 18 Dec 2025 07:39:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeZ8xNWHEcYAb3tLO+EqqaYazPHnNKaclHDNFuMXIqpkG39i81sXL+3EeHGUr5giPxrHUMtQ==
X-Received: by 2002:a0c:ed42:0:b0:888:8096:a09c with SMTP id
 6a1803df08f44-8888096a4f6mr249288086d6.62.1766072371150; 
 Thu, 18 Dec 2025 07:39:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88c6089aecesm21501466d6.32.2025.12.18.07.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:39:30 -0800 (PST)
Date: Thu, 18 Dec 2025 10:39:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 mst@redhat.com, sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, david@kernel.org, philmd@linaro.org
Subject: Re: [PATCH v4 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aUQgMf4kMvdWdc5M@x1.local>
References: <20251218114220.83354-1-xuchuangxclwt@bytedance.com>
 <878qf00z10.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qf00z10.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 18, 2025 at 09:12:27AM -0300, Fabiano Rosas wrote:
> "Chuang Xu" <xuchuangxclwt@bytedance.com> writes:
> 
> > In our long-term experience in Bytedance, we've found that under
> > the same load, live migration of larger VMs with more devices is
> > often more difficult to converge (requiring a larger downtime limit).
> >
> > Through some testing and calculations, we conclude that bitmap sync time
> > affects the calculation of live migration bandwidth.
> >
> > When the addresses processed are not aligned, a large number of
> > clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
> > 2048 clear_dirty ioctls from two different memory_listener),
> > which increases the time required for bitmap_sync and makes it
> > more difficult for dirty pages to converge.
> >
> > For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
> > 16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
> > (tested with 10GBps dirty rate, the sync time increases as the dirty
> > page rate increases), Here are each part of the sync time:
> >
> > - sync from kvm to ram_list: 2.5ms
> > - vhost_log_sync:3ms
> > - sync aligned memory from ram_list to RAMBlock: 5ms
> > - sync misaligned memory from ram_list to RAMBlock: 61ms
> >
> > Attempt to merge those fragmented clear_dirty ioctls, then syncing
> > misaligned memory from ram_list to RAMBlock takes only about 1ms,
> > and the total sync time is only *12ms*.
> >
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Side note: I plan to fold a var, hence a fixup to be squashed:

diff --git a/migration/ram.c b/migration/ram.c
index 27ffa13763..c403fd73a6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -992,10 +992,8 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             memory_region_clear_dirty_bitmap(rb->mr, start, length);
         }
     } else {
-        ram_addr_t offset = rb->offset;
-
         num_dirty = physical_memory_test_and_clear_dirty(
-                        start + offset,
+                        start + rb->offset,
                         length,
                         DIRTY_MEMORY_MIGRATION,
                         dest);

Queued, thanks!

-- 
Peter Xu


