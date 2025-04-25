Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC33C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ldg-0000yj-Ex; Fri, 25 Apr 2025 12:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Ldc-0000yA-Tl
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8Ldb-0001LP-9J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745597450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GlypJDmFKjgZtP7glBxB0/9xkycTJRdlDY16LdfZWc=;
 b=PIzNa7c3jWaMnI1JnEOGvSj9aHYbAsVTzIPUapomH46T+OFzpIcJz+32tPHHfjAcMAo66A
 t5O2Ol9vQVPvYekKq+mPWlGhLdbN0EazlIdTPTLLekR3Fx96P146tIYhyNO7NhQI1vwUic
 ByqLW9Kg33aTBmJkzaN65X109OMnksU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-VApKMLAwNAO2i0k-HI72Iw-1; Fri,
 25 Apr 2025 12:10:48 -0400
X-MC-Unique: VApKMLAwNAO2i0k-HI72Iw-1
X-Mimecast-MFC-AGG-ID: VApKMLAwNAO2i0k-HI72Iw_1745597446
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246D51800873; Fri, 25 Apr 2025 16:10:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 077D3180047F; Fri, 25 Apr 2025 16:10:43 +0000 (UTC)
Date: Fri, 25 Apr 2025 18:10:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH 4/4] qemu-img: improve queue depth validation in img_bench
Message-ID: <aAu0AWrlL3zS50pC@redhat.com>
References: <20250327162423.25154-1-gerben@altlinux.org>
 <20250327162423.25154-5-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327162423.25154-5-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

Am 27.03.2025 um 17:24 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> Currently, running `qemu-img bench -d 0` in img_bench is allowed,
> which is a pointless operation and causes qemu-img to hang.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

This one seems obvious, so I'm already taking it.

Thanks, applied to the block branch.

Kevin


