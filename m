Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD49C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trj75-0007qS-AQ; Mon, 10 Mar 2025 15:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trj72-0007jH-5C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 15:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trj70-0001qa-7a
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741636108;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wrBTZQemwdlmLToiZFjtRQMSl/NXUbFwmTnEUMBezYI=;
 b=hzPdjDPERCC3JVmXT+XxX39aP6Gc3Sn85bYaOXNAb+b2fWtcQi2qSam/kXV1Snlpxvsos8
 HI+atXJyG5hOUj0pacqjO05S7WN6aqWph7tk+VLY08+Zpq5RUL77mTM1XzBGr/o2qHU5Th
 Wb+lITqIYLWyvrjYFnuMfqiRKznkZlU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-LWM39iPTOp2kcaMBIov3Bg-1; Mon,
 10 Mar 2025 15:48:23 -0400
X-MC-Unique: LWM39iPTOp2kcaMBIov3Bg-1
X-Mimecast-MFC-AGG-ID: LWM39iPTOp2kcaMBIov3Bg_1741636102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 592AE18007E1; Mon, 10 Mar 2025 19:48:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB0B1800265; Mon, 10 Mar 2025 19:48:19 +0000 (UTC)
Date: Mon, 10 Mar 2025 19:48:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z89CALrwKnHdO4hx@redhat.com>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z885hS6QmGOZYj7N@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 10, 2025 at 03:12:05PM -0400, Peter Xu wrote:
> On Sun, Mar 09, 2025 at 09:15:00PM -0400, Manish Mishra wrote:
> > We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> > memory is accounted for in the OPTMEM limit. If there is any error while
> > sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> > queued in the socket error queue. This error queue is freed when userspace
> > reads it.
> > 
> > Usually, if there are continuous failures, we merge the metadata into a single
> > SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> > However, if there is any out-of-order processing or intermittent zerocopy
> > failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> > As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> > an ENOBUF error. Depending on the amount of data queued before the flush
> > (i.e., large live migration iterations), even large OPTMEM limits are prone to
> > failure.
> > 
> > To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> > we flush the error queue and retry once more.
> > 
> > Additionally, this patch removes the dirty_sync_missed_zero_copy migration
> > stat. This stat is not used anywhere and does not seem useful. Removing it
> > simplifies the patch.
> 
> IMHO it's still useful, it's just that if it's for debugging purpose, it's
> optional to expose it via QAPI.  Then if without exposing it to upper
> layer, it can simplify the change this patch wanted to introduce.  We can
> still keep it a tracepoint.


> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index dfb5189f0e..ee6b2d3cba 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -607,9 +607,6 @@ static int multifd_zero_copy_flush(QIOChannel *c)
> >          error_report_err(err);
> >          return -1;
> >      }
> > -    if (ret == 1) {
> > -        stat64_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
> > -    }
> 
> If we want to remove this, we need to remove the variable in QAPI too.
> 
> # @dirty-sync-missed-zero-copy: Number of times dirty RAM
> #     synchronization could not avoid copying dirty pages.  This is
> #     between 0 and @dirty-sync-count * @multifd-channels.  (since
> #     7.1)
> 
> Personally I'd remove it directly, but others may not always agree... in
> this case, the safe approach is to mark it deprecate and update this in
> docs/about/deprecated.rst.  Then you can leave it to us to finally remove
> this entry (or send another patch after two qemu releases).

Given this is in public API, the data needs to remain reported accurately
for the whole deprecation period. IOW, the patch to qiochannel needs to
preserve this data too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


