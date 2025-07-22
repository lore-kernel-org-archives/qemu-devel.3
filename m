Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76875C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 21:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueKjg-0005Gq-R1; Tue, 22 Jul 2025 17:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ueKhP-0003jh-34
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 17:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ueKhM-0000hi-Ae
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 17:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753220335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckrIvX/9AZ5f2L1iT7gCp7yQMbY2juImpEfMPmefEA0=;
 b=A51KVzqE0zkH2q8EPOimjb2Ngtrt00HtuZsmQn2KluO95KupItUNrpg5qxiAgUEF85lMMQ
 rQXuh2hTDYiejT2uDKv2IPQDWtUfo1Xk2e/KL9C+dPOcU39fD+pREHmVkOr8FsN0pj3opx
 nKq0TU6K2gm6px6Jj7dK6XUOpHSwb/w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-bQk5TJ2uMuaPAIptYofTcw-1; Tue,
 22 Jul 2025 17:38:52 -0400
X-MC-Unique: bQk5TJ2uMuaPAIptYofTcw-1
X-Mimecast-MFC-AGG-ID: bQk5TJ2uMuaPAIptYofTcw_1753220330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB1411956048; Tue, 22 Jul 2025 21:38:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B300930001A4; Tue, 22 Jul 2025 21:38:46 +0000 (UTC)
Date: Tue, 22 Jul 2025 16:38:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 hibriansong@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH v3 01/12] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Message-ID: <6fr4lw2ui3fnlvwm2lvbanroda7vlaib7eul7khkdgkscrnm75@bynka4sjxzid>
References: <20250721210759.179709-1-stefanha@redhat.com>
 <20250721210759.179709-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721210759.179709-2-stefanha@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 21, 2025 at 05:07:48PM -0400, Stefan Hajnoczi wrote:
> When an AioHandler is enqueued on ctx->submit_list for removal, the
> fill_sq_ring() function will submit an io_uring POLL_REMOVE operation to
> cancel the in-flight POLL_ADD operation.
> 
> There is a race when another thread enqueues an AioHandler for deletion
> on ctx->submit_list when the POLL_ADD CQE has already appeared. In that
> case POLL_REMOVE is unnecessary. The code already handled this, but
> forgot that the AioHandler itself is still on ctx->submit_list when the
> POLL_ADD CQE is being processed. It's unsafe to delete the AioHandler at
> that point in time (use-after-free).
> 
> Solve this problem by keeping the AioHandler alive but setting a flag so
> that it will be deleted by fill_sq_ring() when it runs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


