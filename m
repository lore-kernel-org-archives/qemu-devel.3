Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAF5C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 08:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5KxK-0002oC-QY; Thu, 17 Apr 2025 04:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u5Kwn-0002e4-Rw
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u5Kwj-0007fQ-Ra
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744879807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+arAyjKguR7Otm5vGIyKBbqn5sbrA0N5beoC9ueSGg=;
 b=gzznUlmrFezzPewiZ/HXWBp2YATDG4F+qxPxEH7MYMXyDHmXmtUYnXviSj2FIDykLktGPg
 1k77BKbFV+1IEpmzVBF8/lX9BacORIhdg6hc6EXNY3UzN04cxoLw4dC4k/punVXOkpOcET
 siwy/iLK8MvairMMAAMEXwv1cmxL4eU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-p867Bn53PHuJAyCxi40nPQ-1; Thu,
 17 Apr 2025 04:50:03 -0400
X-MC-Unique: p867Bn53PHuJAyCxi40nPQ-1
X-Mimecast-MFC-AGG-ID: p867Bn53PHuJAyCxi40nPQ_1744879802
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C97A7180087A; Thu, 17 Apr 2025 08:50:00 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5839B18002AD; Thu, 17 Apr 2025 08:49:57 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:49:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, eblake@redhat.com
Subject: Re: [PATCH v3 2/2] block/io: skip head/tail requests on EINVAL
Message-ID: <aADAs7oerG789LTI@redhat.com>
References: <20250414201214.241351-1-stefanha@redhat.com>
 <20250414201214.241351-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414201214.241351-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 14.04.2025 um 22:12 hat Stefan Hajnoczi geschrieben:
> When guests send misaligned discard requests, the block layer breaks
> them up into a misaligned head, an aligned main body, and a misaligned
> tail.
> 
> The file-posix block driver on Linux returns -EINVAL on misaligned
> discard requests. This causes bdrv_co_pdiscard() to fail and guests
> configured with werror=stop will pause.
> 
> Add a special case for misaligned head/tail requests. Simply continue
> when EINVAL is encountered so that the aligned main body of the request
> can be completed and the guest is not paused. This is the best we can do
> when guest discard limits do not match the host discard limits.
> 
> Fixes: https://issues.redhat.com/browse/RHEL-86032
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

It would be good to also update the comment a bit further up:

    /* Discard is advisory, but some devices track and coalesce
     * unaligned requests, so we must pass everything down rather than
     * round here.  Still, most devices will just silently ignore
     * unaligned requests (by returning -ENOTSUP), so we must fragment
     * the request accordingly.  */

I'm not sure where the -ENOTSUP came from (Eric, do you remember?), but
we should at least mention this -EINVAL case separately.

Kevin


