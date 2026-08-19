Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573EC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi6R-0004NF-H3; Wed, 19 Aug 2026 11:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwi6Q-0004Mz-1x
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwi6O-0004z5-59
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787152875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y67dJL0IjWzcIcrOB+919ZUBBrhKLAIGZ1eLYD4bUHg=;
 b=cCmXDDVQn/HhjKHnm+UN32J8kVkoNhgK9jEM1gbuZQ7KJV7XSWYENxzximmgUaZcQPTVBw
 Pmvv4S3CHHlwW+ZbJ9jm9Mob4IVt1AjcSwcpEIjIk6D7XP//YVqo4L8QhwyYPRAdGC5F15
 7aYPu3KbWwQVNj5APNuqKKNPCU8Lk/k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-FJJqbu01ONOtlxx_yQhY4w-1; Wed, 19 Aug 2026 11:21:08 -0400
X-MC-Unique: FJJqbu01ONOtlxx_yQhY4w-1
X-Mimecast-MFC-AGG-ID: FJJqbu01ONOtlxx_yQhY4w_1787152867
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so14539831cf.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787152867; x=1787757667; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y67dJL0IjWzcIcrOB+919ZUBBrhKLAIGZ1eLYD4bUHg=;
 b=e+c42e9ch4nuD2Hn+bJOrttYrGxyKMcD37oxphrkY94HrET8Sjae6gdQt/9EsKD0Cn
 WPYHc3/r5ZN9QRLIWhktZoYCwcbCMZbuymIaYcTn1unH66VAfViN4xBaDpv4HquBI4nF
 +YPVctIGhHoPyPCUeI4ajUTz3DSqbPwiodu+uHjMV7THGBH8C6pnBnzR3Q/tvxiXKGWu
 uPcdUhsBnkj0KubEsBQOlr8YXxWhkR82RYBDIULK5fWRQOsAW5w3hJcHythS1cDuD3Gb
 f6C11iAt8d4csAOUwzASkxKXxYM+nsAP+C45u5EA8jVhSZ/U+tMTSW3KUL1GMKa1TcvB
 QYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152867; x=1787757667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y67dJL0IjWzcIcrOB+919ZUBBrhKLAIGZ1eLYD4bUHg=;
 b=jf7dKkDpZMXwCctTCYqbEoK9DBEsyKOdSpBdbCmcfQFHJBoHz1EA53zzG/E6R0ilEz
 KM9NLuotG+x/+RfRV/L6l45q6oiTFWd87xuhS4i7RqxAsV9vU+RyPFljsJuZPMANdZPY
 gHS56ieauG2KrpGHQ6Jjr/leT6tGbYvYY3Py99T2FPiMvGd0uaXXa/V8XJGEzNK+TKkP
 dWpzlK6g4zTN2tnlX5XeKNmFUQifDBCfYRAwhOrFiJIUuJIyVuEUdSmzUSoyBGu1vZSN
 TMBLoCvG1IIMn2iYgK3XcGYcq83iZUgV0vaThv7rR0GYqIhiEhp9iOYqApKNmbHv8+45
 fYDA==
X-Gm-Message-State: AOJu0Yz5OWjyhLK3+z56SnTn9UHZa/9WRz3RiwQpsxOr90BWQyLAMomd
 7IpT0JBGvg8LMz+JbY3rjI1M/patBuPPlN2iSqpZ67DzzFSXnKiNVHk38p4APAEJtlFOUAytz2G
 OKzThXEu7dxGxSUeIUO7OTZ0bvhjG+bR1OiYn6nHOkeUGCvUjQxbfb4MY
X-Gm-Gg: AR+sD12Kztucg7BJbxg0mIRpvEfSyInzEfA36gvbF/5Gqg+uyMsWBfw4SSG5AqiJqDx
 mG5xe8teDmdbV8r7Zs4xtxAAlTv+wbkHBxW7Tu8csvP6wsDa8ydTygGyJbYuhIGH/8Gq8FHbSBZ
 crLxLkpsBy53vHTtL8oGPi1ZwBzGFTpKrkHf6zagZNT9OsxWZhNoWkqZlKO7FOdOtp8DusJeXR7
 Rhhcw46lYkYXwldiR/cR6ME3mugPtASSVLNbCXgc8aOB2Nr9FmsHyUIcm4ITT44qea6Od1/u/VK
 EFsTKIDr1iH6/Zk+UBBVXgXfRIDL2jR78QZ49oZOA0Pl7BGmhVJWRfrSqdrDH/AOysST
X-Received: by 2002:a05:622a:1b8d:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-52dd5f3920cmr50594701cf.43.1787152867080; 
 Wed, 19 Aug 2026 08:21:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8d:b0:51c:1c2c:a8bf with SMTP id
 d75a77b69052e-52dd5f3920cmr50582551cf.43.1787152860399; 
 Wed, 19 Aug 2026 08:21:00 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2911a5sm16365556d6.30.2026.08.19.08.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:20:58 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:20:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 08/10] migration/rdma: Sanity check
 RDMA_CONTROL_REGISTER_REQUEST chunks
Message-ID: <aoXJ1k8N_bzfXs5u@x1.local>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-9-peterx@redhat.com>
 <CAMGffEkzdOna79f561r6bMF3wgZw4h5LwHXhC3KBx_FqLNz+wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEkzdOna79f561r6bMF3wgZw4h5LwHXhC3KBx_FqLNz+wQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 19, 2026 at 03:00:51PM +0200, Jinpu Wang wrote:
> On Mon, Aug 17, 2026 at 10:24 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > The value received on wire for head.chunks when registering new RDMA
> > regions is not correctly checked.  Logically the value can still make
> > ram_chunk_start() (of ram_chunk_end()) to overflow, having a result pointer
> > very small, smaller than RDMALocalBlock.local_host_addr.
> >
> > Add the sanity check.
> >
> > Reported-by: Tristan (@TristanInSec)
> > Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4011
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/rdma.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 5ce8b06818..bbbc40ea3b 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3401,6 +3401,13 @@ int rdma_registration_handle(QEMUFile *f)
> >                  chunk = ram_chunk_index(block->local_host_addr,
> >                                          (uint8_t *) host_addr);
> >                  chunk_start = ram_chunk_start(block, chunk);
> > +                if (chunk + reg->chunks > block->nb_chunks) {
> > +                    error_report("%s: head.chunks contains illegal value"
> > +                                 " (chunk=%"PRIu64", chunks=%"PRIu64", "
> > +                                 "nb_chunks=%d)", __func__, chunk,
> > +                                 reg->chunks, block->nb_chunks);
> > +                    goto err;
> > +                }
> safer to do this instead, as reg->chunks is from wire:
> uint64_t chunk_sum;
> if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
>     chunk_sum > block->nb_chunks) {
>     error_report(...);
>     goto err;
> }

I thought I covered that, I even mentioned the overflow in the commit log,
but I didn't really do anything..

When looking at this again, I found reg->chunks is defined in a weird way,
instead of "number of chunks", it's off-by-one...

qemu_rdma_write_one():
    chunks = length / chunk_size;
    if (chunks && ((length % chunk_size) == 0)) {
        chunks--;
    }

So I think I should check it with "chunk_sum >= block->nb_chunks" to be
accurate.  Diff attached to be squashed when repost, please help double
check:

diff --git a/migration/rdma.c b/migration/rdma.c
index 6384306ead..e976739fad 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3393,7 +3393,7 @@ int rdma_registration_handle(QEMUFile *f)
             }

             for (int count = 0; count < head.repeat; count++) {
-                uint64_t chunk;
+                uint64_t chunk, chunk_sum;
                 uint8_t *chunk_start, *chunk_end;

                 reg = &registers[count];
@@ -3424,7 +3424,8 @@ int rdma_registration_handle(QEMUFile *f)
                 chunk = ram_chunk_index(block->local_host_addr,
                                         (uint8_t *) host_addr);
                 chunk_start = ram_chunk_start(block, chunk);
-                if (chunk + reg->chunks > block->nb_chunks) {
+                if (uadd64_overflow(chunk, reg->chunks, &chunk_sum) ||
+                    chunk_sum >= block->nb_chunks) {
                     error_report("%s: head.chunks contains illegal value"
                                  " (chunk=%"PRIu64", chunks=%"PRIu64", "
                                  "nb_chunks=%d)", __func__, chunk,

Thanks for the careful review,

-- 
Peter Xu


