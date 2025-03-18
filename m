Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVfY-0000dS-P6; Tue, 18 Mar 2025 08:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tuVfQ-0000Wz-T0
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tuVfM-0006QO-RX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742299407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrWIJ5qkY3lUJINWIy2sjyPfH4pk84gOxcicZQMvPoY=;
 b=jIf19IXYdNPDKOMEW7lJFgXDAvZkXwcFnJn/XB0KWGxjTdsEh4scUkGjY2ta7PZ4y9Jcgp
 mJqFpLlh/UMw0LMg525UibEbv2Bm0GrDFjN/Z/O/eYTHYY0uDhK5Ov2j/juXiPbikt/Aat
 5h6yv6sBr1VxVGewixtqr1SDoUkuaF0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-A2aHfGJPP6CglmrZNFtARw-1; Tue,
 18 Mar 2025 08:03:23 -0400
X-MC-Unique: A2aHfGJPP6CglmrZNFtARw-1
X-Mimecast-MFC-AGG-ID: A2aHfGJPP6CglmrZNFtARw_1742299402
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FD401955E9F; Tue, 18 Mar 2025 12:03:21 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.124])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6D21956095; Tue, 18 Mar 2025 12:03:14 +0000 (UTC)
Date: Tue, 18 Mar 2025 13:03:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] qemu-img: fix division by zero in bench_cb() for
 zero-sized images
Message-ID: <Z9lg88JF7FUYcxw1@redhat.com>
References: <20250318101933.255617-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318101933.255617-1-gerben@altlinux.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 18.03.2025 um 11:19 hat gerben@altlinux.org geschrieben:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> This error was discovered by fuzzing qemu-img.
> 
> This commit fixes a division by zero error in the bench_cb() function
> that occurs when using the bench command with a zero-sized image.
> 
> The issue arises because b->image_size can be zero, leading to a
> division by zero in the modulo operation (b->offset %= b->image_size).
> This patch adds a check for b->image_size == 0 and resets b->offset
> to 0 in such cases, preventing the error.
> 
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>

Thanks, applied to the block branch.

Kevin


