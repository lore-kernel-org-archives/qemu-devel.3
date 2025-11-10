Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F00CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUKN-0008DE-KH; Mon, 10 Nov 2025 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIUKA-000885-Ab
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIUK5-0003LR-0F
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762790452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4VVVYYB6NW2GlV8qFKj2NL/HHQ7juShJ1Aw4mMBHmM=;
 b=gH9bf2sayBM/k+jU2PA/3p0QJHQnX4nJjPWG1TBZoAWJvJZcHGKfBHQ3uxHHaPWKLb8OEl
 91t4dIm9V8IjVDjjFtgNZr0OPb5AfhHrPIzzEtgcNFnGocfE9mU1kpILJ+F9STDoDT4+hV
 l8JOYHF7pztfu7tQe3ef49pF5ejHfVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-l4L7DpBuMCWexI05vIZnlg-1; Mon,
 10 Nov 2025 11:00:50 -0500
X-MC-Unique: l4L7DpBuMCWexI05vIZnlg-1
X-Mimecast-MFC-AGG-ID: l4L7DpBuMCWexI05vIZnlg_1762790448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 553EF1954B14; Mon, 10 Nov 2025 16:00:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E843030044E1; Mon, 10 Nov 2025 16:00:45 +0000 (UTC)
Date: Mon, 10 Nov 2025 16:00:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 03/12] qio: Unwatch before notify in QIONetListener
Message-ID: <aRIMKry8h336cPup@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108230525.3169174-17-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 08, 2025 at 04:59:24PM -0600, Eric Blake wrote:
> When changing the callback registered with QIONetListener, the code
> was calling notify on the old opaque data prior to actually removing
> the old GSource objects still pointing to that data.  Similarly,
> during finalize, it called notify before tearing down the various
> GSource objects tied to the data.
> 
> In practice, a grep of the QEMU code base found that every existing
> client of QIONetListener passes in a NULL notifier (the opaque data,
> if non-NULL, outlives the NetListener and so does not need cleanup
> when the NetListener is torn down), so this patch has no impact.  And
> even if a caller had passed in a reference-counted object with a
> notifier of object_unref but kept its own reference on the data, then
> the early notify would merely reduce a refcount from (say) 2 to 1, but
> not free the object.  However, it is a latent bug waiting to bite any
> future caller that passes in data where the notifier actually frees
> the object, because the GSource could then trigger a use-after-free if
> it loses the race on a last-minute client connection resulting in the
> data being passed to one final use of the async callback.
> 
> Better is to delay the notify call until after all GSource that have
> been given a copy of the opaque data are torn down.
> 
> CC: qemu-stable@nongnu.org
> Fixes: 530473924d "io: introduce a network socket listener API", v2.12.0
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch, split out from 4/8 to leave that one as just pure
> refactoring, and call attention to this being a latent bug fix
> ---
>  io/net-listener.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


