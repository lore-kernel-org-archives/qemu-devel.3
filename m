Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F73FC3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txUKH-0007dC-7k; Wed, 26 Mar 2025 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1txUKE-0007cO-UR
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1txUKD-0001td-6r
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743009234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFT37f7tJdTXoY1+wLWkLUPoeHVcQUvc+QwQ85ybPcs=;
 b=AAi0pQDH/tJomn7puYtTeK5u0c0VMOjG78TIy8gQ4+nvGvzdkGS9r/8Aq03wjrM2pGLk9V
 pJD5xw5iebQvjXphrlYR03Clh7LRJ8+H3wdlWgcurLAsI5rXIRGorf+jhIHxY3M+SH+DF3
 dvTcYGldZFZwQ+PHnX5WgCQX684C5ow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-c_j8rRMtP0WFbX7d_VPgXA-1; Wed,
 26 Mar 2025 13:13:50 -0400
X-MC-Unique: c_j8rRMtP0WFbX7d_VPgXA-1
X-Mimecast-MFC-AGG-ID: c_j8rRMtP0WFbX7d_VPgXA_1743009229
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8DC19560AF; Wed, 26 Mar 2025 17:13:49 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97DA61955D81; Wed, 26 Mar 2025 17:13:46 +0000 (UTC)
Date: Wed, 26 Mar 2025 18:13:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <Z-Q1yDqmS3gniW4X@redhat.com>
References: <174293621917.22751.11381319865102029969-0@git.sr.ht>
 <174293621917.22751.11381319865102029969-1@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174293621917.22751.11381319865102029969-1@git.sr.ht>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 25.03.2025 um 21:49 hat ~h0lyalg0rithm geschrieben:
> From: Suraj Shirvankar <surajshirvankar@gmail.com>
> 
> Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> ---
>  util/fdmon-io_uring.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

As Stefan already mentioned, the commit message should say why we want
to set this flag and why it is correct to do so.

Is there a reason why you change the io_uring_queue_init() call in
util/fdmon-io_uring.c, but not the one in block/io_uring.c?

If so, please document it in the commit message, too.

Kevin


