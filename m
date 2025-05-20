Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4946AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHTf5-0002eK-Ta; Tue, 20 May 2025 16:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHTf2-0002e3-B0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHTf0-0005bX-3N
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747773237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFRzvJ3FwmahiR8fyQbnE2qTYZr0LxhndZf/YviN9OY=;
 b=RQeSpYLlSNrbibmNQe961vqZvUD7mT2i44QQlKsJKXT+QygP+6EnEWInIZBvj2glBAlToZ
 7UckUByDUzlqSVee8wNBOTzQ0JQzA0fb8Tp6ZXdb61dOAV4Fhowi0xcpjVmO1ADQEnhrI/
 FjgndHfGyMQs0wEV1TiVQ18Zhi7w2QM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-3tYAJ3cPPyeRs020NZW2MQ-1; Tue, 20 May 2025 16:33:56 -0400
X-MC-Unique: 3tYAJ3cPPyeRs020NZW2MQ-1
X-Mimecast-MFC-AGG-ID: 3tYAJ3cPPyeRs020NZW2MQ_1747773235
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5e2a31f75so1937375485a.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 13:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747773235; x=1748378035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFRzvJ3FwmahiR8fyQbnE2qTYZr0LxhndZf/YviN9OY=;
 b=Bxr0zfUF5pQSU4sBLlw+wvdEHxwggQnepkbYSPEDlCBeQhcpEw6LjuO4V80CdXTbZi
 cRH4kCKLu+oK3YndtH5aNMcSgR8bPP1W7bcgsOX5DCa9I3jMPMqKXPeVxTHtGJrilrPg
 05gkSfD/9TFnxNy7dftW+8neXn8uQ1+InODNwOrf+Sbn63Rtf0iIzwNYLShK0B4VFBM6
 r+1cX7UUeJbf6CBe7diEU26feGCz0IOFCAOHwC9TevyWwMUnqadYO1GseLVXrgaD66rW
 FdjeSseD1caprUVxQuDD1DHYThfrSpC2gcaXbWSuu70mAxeJk3OeBpEoqUxaajRgiSxB
 c67w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkPlHMcfwW2uIfC4x0Wx3swxzioIyp2ShWdiNNnijWVwupHBE8LZ2ZHUpjFtZ51jkCbB9heqBr6e+G@nongnu.org
X-Gm-Message-State: AOJu0YyJ/A2nEgDJpwEUvZEqJk/5GTycdHUM6NUKrRqXONl1GyJGoIPr
 xbfx7QZRRjhmF3Izkuj8HUjtujy6QCx8A9R+79qQjD9TuHXyJzml9mXHnQPqAKfePa96Z7YeoTx
 icltW48hCmnVHnHhVed6gCALL2+CSxKzEYcQr9RRvskpXlqwXh0jNj/MY
X-Gm-Gg: ASbGncvZsT3nU0P7fsWuWk9Qiz4k+pK0BBeEBCu5LefAIAI31LmNHjaPXEQ40QxZLgF
 bvBhraspmOst4A5k9CrbtdFYK2mbQoNi5WwSJhBw+cwmjWTq1Wb6dYwUW68ftu6FjIJjC0abOE6
 7V81/Sukg7JeJTkGGpMZbCkOQmFCZDzQ9hVOCmm6L176xJ1tRzBEXrETRRgWBWW2fFT9KuroWLe
 aIRtHm1CNedsHM/uBaMrHKvojaVzAlcRf4wjY/JJZDVYGeAAqZ4EMOicbWpKZtQhNj6MKfXX9pk
 cJw=
X-Received: by 2002:a05:620a:17a3:b0:7ca:f37a:2b4e with SMTP id
 af79cd13be357-7cd47f1de86mr2593857385a.23.1747773235362; 
 Tue, 20 May 2025 13:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERyMggfnIwNHok95soC8Iu+GgimG7NAJRKMYIwXaX9j1GVlurfcL+FKHyUHl3dhWEYfB2rhg==
X-Received: by 2002:a05:620a:17a3:b0:7ca:f37a:2b4e with SMTP id
 af79cd13be357-7cd47f1de86mr2593853485a.23.1747773234815; 
 Tue, 20 May 2025 13:33:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468d8e68sm778501885a.112.2025.05.20.13.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 13:33:54 -0700 (PDT)
Date: Tue, 20 May 2025 16:33:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] migration/ram: avoid to do log clear in the last round
Message-ID: <aCznLilrKAn5jkWg@x1.local>
References: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
 <87zff75ch6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zff75ch6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Tue, May 20, 2025 at 04:05:57PM -0300, Fabiano Rosas wrote:
> Yanfei Xu <yanfei.xu@bytedance.com> writes:
> 
> > There won't be any ram sync after the stage of save_complete, therefore
> > it's unnecessary to do manually protect for dirty pages being sent. Skip
> > to do this in last round can reduce noticeable downtime.
> >
> > Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> > ---
> > As I don't have proper machine to test this patch in qemu and verify if it has
> > risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
> > it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
> > for suggestions.
> >
> >  migration/ram.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e12913b43e..2b169cdd18 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
> >       * the page in the chunk we clear the remote dirty bitmap for all.
> >       * Clearing it earlier won't be a problem, but too late will.
> >       */
> > -    migration_clear_memory_region_dirty_bitmap(rb, page);
> > +    if (!rs->last_stage) {
> > +        migration_clear_memory_region_dirty_bitmap(rb, page);
> > +    }
> >  
> >      ret = test_and_clear_bit(page, rb->bmap);
> >      if (ret) {
> 
> Well, it looks ok to me and passes all my tests.
> 
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks both!

I plan to test a bit on this patch later to see how much perf we can get in
QEMU.  Since it makes perfect sense on its own, queued it for now, and the
plan is with below comments squashed in.  Let me know if there's comments.

Postcopy unfortunately still cannot benefit much from this change, but I'll
prepare some patches soon so that this should ideally also work for the
whole lifecycle of postcopy.  After that done, I am expecting some further
page fault latency reduction with this change.

diff --git a/migration/ram.c b/migration/ram.c
index db70699f95..fd8d83b63c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -831,14 +831,20 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     bool ret;
 
     /*
-     * Clear dirty bitmap if needed.  This _must_ be called before we
-     * send any of the page in the chunk because we need to make sure
-     * we can capture further page content changes when we sync dirty
-     * log the next time.  So as long as we are going to send any of
-     * the page in the chunk we clear the remote dirty bitmap for all.
-     * Clearing it earlier won't be a problem, but too late will.
+     * During the last stage (after source VM stopped), resetting the write
+     * protections isn't needed as we know there will be either (1) no
+     * further writes if migration will complete, or (2) migration fails
+     * at last then tracking isn't needed either.
      */
     if (!rs->last_stage) {
+        /*
+         * Clear dirty bitmap if needed.  This _must_ be called before we
+         * send any of the page in the chunk because we need to make sure
+         * we can capture further page content changes when we sync dirty
+         * log the next time.  So as long as we are going to send any of
+         * the page in the chunk we clear the remote dirty bitmap for all.
+         * Clearing it earlier won't be a problem, but too late will.
+         */
         migration_clear_memory_region_dirty_bitmap(rb, page);
     }

-- 
Peter Xu


