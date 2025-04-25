Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9694C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LLM-0000B2-Hq; Fri, 25 Apr 2025 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8LLL-0000Ai-4D
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8LLJ-0006oX-9S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745596315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FTZ2JP4hQXUKgj1BfU93LzX8rtG6D8UDEI/AHD5EmOU=;
 b=jL4hcxXafSb95SDLkTVNgQ/fqRXFOUaKvHY2+un6BZBa2v+BOawr78yRh/G0vzVfU1L++l
 q8NQw/8i2mqen0OMKKxd04UKBX1DameQDXq4HDZkRPTUk1VOpnEKWP2eQYscWKf4eCJ8Or
 c2Fg58Z0wM8NeXyr5hZE/isGlTcYdco=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-HsznaBy8P_K_NJNLMhDoYg-1; Fri,
 25 Apr 2025 11:51:51 -0400
X-MC-Unique: HsznaBy8P_K_NJNLMhDoYg-1
X-Mimecast-MFC-AGG-ID: HsznaBy8P_K_NJNLMhDoYg_1745596310
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 565A11800570; Fri, 25 Apr 2025 15:51:49 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FB481956095; Fri, 25 Apr 2025 15:51:45 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:51:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, surajshirvankar@gmail.com,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/3] aio-posix: treat io_uring setup failure as fatal
Message-ID: <aAuvjznKfL1qg2J7@redhat.com>
References: <20250401142721.280287-1-stefanha@redhat.com>
 <20250401142721.280287-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401142721.280287-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 01.04.2025 um 16:27 hat Stefan Hajnoczi geschrieben:
> In the early days of io_uring it was possible for io_uring_setup(2) to
> fail due to exhausting RLIMIT_MEMLOCK. QEMU's solution was to fall back
> to epoll(7) or ppoll(2) when io_uring could not be used in an
> AioContext.
> 
> Nowadays io_uring memory is accounted differently so io_uring_setup(2)
> won't fail. Treat failure as a fatal error. Keep it simple: io_uring is
> available if and only if CONFIG_LINUX_IO_URING is defined.
> 
> Upcoming features that rely on io_uring won't need to handle the case
> where a subset of AioContexts lacks io_uring. This will simplify the
> aio_add_sqe() API introduced in the next commit.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

While making failure to set up io_uring for an AioContext a hard error
feels fine to me, I feel a bit uneasy about having fatal errors like
this in functions that aren't only called during startup. This function
is also called when adding an iothread object at runtime. The failure
mode that I would expect there is that object-add returns an error, not
that the whole QEMU process exits.

Kevin


