Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ADFD2D10F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffTo-0004Xc-Sv; Tue, 13 Jan 2026 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vffTJ-0004QD-FB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vffTH-0006ZA-Lx
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768314851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0z6OpOegSWo+lRcDyawfWXccycFCage2yh+erT0Rh4=;
 b=jJeh7R+ZJxESjcSxuch8l7qX1Gmc8qO9JJX8VWYRpCjc4CSvhds0BaEM+zKbZK+iY7nZuG
 tutVyMCvYdboZ2PBbkcrRdU39JYQh4+RjTyq+Elk+LHIsvNW8SzUCqDblM+i/n6WvLwNmj
 RzYIaS5XyimC20oIF3VD9OX2m/FWQMY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-HJJfKSQuNdi6K_oAp4qk_g-1; Tue,
 13 Jan 2026 09:34:07 -0500
X-MC-Unique: HJJfKSQuNdi6K_oAp4qk_g-1
X-Mimecast-MFC-AGG-ID: HJJfKSQuNdi6K_oAp4qk_g_1768314846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1FBB1955D8E; Tue, 13 Jan 2026 14:34:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA2031800240; Tue, 13 Jan 2026 14:34:04 +0000 (UTC)
Date: Tue, 13 Jan 2026 14:34:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Use "gsed" for expressions that
 require GNU sed
Message-ID: <aWZX2c2q7BUgIFz3@redhat.com>
References: <20260113141415.97281-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113141415.97281-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 03:14:15PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> A bunch of tests are currently failing e.g. on FreeBSD like this:
> 
>  082   fail       [13:38:58] [13:38:59]   0.5s                 output
>   mismatch (see .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad)
>  --- .../src/tests/qemu-iotests/082.out
>  +++ .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad
>  @@ -17,7 +17,7 @@
>   cluster_size: 4096
>   Format specific information:
>       compat: 1.1
>  -    compression type: COMPRESSION_TYPE
>  +    compression type: zlib
>       lazy refcounts: true
>       refcount bits: 16
>       corrupt: false
> 
> This happens because the sed statements require GNU sed. Let's use
> gsed in these spots to get it fixed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/286       | 2 +-
>  tests/qemu-iotests/common.rc | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


