Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F0606A334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eaz09ibj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP17B-0006Mb-4i; Thu, 05 Nov 2026 12:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xP178-0006ME-TW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:19:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xP176-000793-UJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793899138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8At3c7zUOJOwyUwV+OquRBgRvAGbecfWAFBkkueCNg=;
 b=eaz09ibjQMOdvyYfMaej15kjSPs6k53bWpZs30kX5b9EL2TnoUHO/bWohCoyjGmMrSnfue
 Rozot+GjTRa8wjqjgzoUPlwBzH9zmPqSYvdgpOELoiNUlk17wTp2WyPNsntQ90TJreUoiu
 On5owNvM9/N0mab8Hjt9ECCTw7Lven4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-XIVvXsbjPzmmvzK1JqFcYQ-1; Thu,
 05 Nov 2026 12:18:54 -0500
X-MC-Unique: XIVvXsbjPzmmvzK1JqFcYQ-1
X-Mimecast-MFC-AGG-ID: XIVvXsbjPzmmvzK1JqFcYQ_1793899133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 219C91954B32; Thu,  5 Nov 2026 17:18:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 192793001DA3; Thu,  5 Nov 2026 17:18:50 +0000 (UTC)
Date: Thu, 5 Nov 2026 18:18:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/5] block/vmdk: Fix various bugs in handling malicious
 image files
Message-ID: <auy6eFKcQOvGWpyi@redhat.com>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 03.11.2026 um 15:35 hat Peter Maydell geschrieben:
> This set of patches fixes four reported bugs in vmdk's handling of
> potentially malicious image files:
> 
>  #3843: if cluster_sectors is 0x200000 we can overflow an 'int' and try
>         to g_malloc() 0xffffffff80000000
>  #4017: if cluster_sectors is 0 we will divide by zero and SIGFPE
>  #4029: we can overflow a 32*64 multiply; we catch it a bit later on
>         so there are no ill-effects, but for robustness it's better to
>         check before the multiply
>  #4571: we can read off the end of a block of memory when trying to
>         parse descriptors; worst case is that we read some junk from
>         the heap into BlockDriverState::auto_backing_file and
>         ::backing_file. I don't think this is an exploitable info
>         leak into the guest.
>  #4571: if the input file specifies no extents, we hit an assert
>         in vmdk_co_get_info() rather than rejecting the file
>         (mentioned in passing in the same issue as previous bug)
> 
> I think these all classify as "hardening bugs" rather than security
> issues, since they're just "self-denial-of-service" at worst.
> 
> Tested using qemu-iotests on the vmdk format.

Thanks, applied to the block branch.

It would have been nice to add new qemu-iotests cases that can catch
these bugs, maybe you still want to do that on top?

And just looking briefly at each of the places that are patched, it's
immediately clear to me that some more fixes are needed.  :-)

Kevin


