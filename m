Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D287F54AD2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54Pb-0005rj-76; Tue, 24 Mar 2026 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w54PZ-0005rJ-Nr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w54PX-0000w4-Jz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774368916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86h82t5FqIstlDTMQ3Nz5Xw5uCNfGCDHg02hWrnjqUc=;
 b=E/jaQQQdbiIaU3TeyNgV4DqZK97+OQdKhEtH5aYnGHOGFg3jy+fRmkTCJhHZk6O9+jViTX
 ybwQViG2ECnTEuviocFdHiz5HCJJ3gT/o5L5VKLv7SrZs1oRQo1VDR6/RrFvcAOYEMOL0A
 mT7Imux/khdBioaHUtgxb5ciVu/KMnw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-3-u57F_CMA2wVeCvpdBCLA-1; Tue,
 24 Mar 2026 12:15:15 -0400
X-MC-Unique: 3-u57F_CMA2wVeCvpdBCLA-1
X-Mimecast-MFC-AGG-ID: 3-u57F_CMA2wVeCvpdBCLA_1774368914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F0E1944F2F; Tue, 24 Mar 2026 16:15:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.246])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94973180058C; Tue, 24 Mar 2026 16:15:11 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:15:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-11.0 v2 0/3] linux-aio/io-uring: Resubmit tails of
 short requests
Message-ID: <acK4bx0Pvi4l9G4x@redhat.com>
References: <20260324084338.37453-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324084338.37453-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24.03.2026 um 09:43 hat Hanna Czenczek geschrieben:
> Hi,
> 
> v1 is here:
> 
> https://lists.nongnu.org/archive/html/qemu-block/2026-03/msg00307.html
> 
> Short reads and writes can happen.  One way to reproduce them is via
> FUSE export, if you force it to limit the request length in the
> read/write path (patch in the commit messages of patches 2 and 3), but
> specifically short writes apparently can also happen with NFS.
> 
> For the file-posix block driver, aio=threads already takes care of them.
> aio=native does not, at all, and aio=io_uring only handles short reads,
> but not writes.  This series has both aio=native and aio=io_uring handle
> both short reads and writes.  zone-append is not touched, as I don’t
> believe resubmitting the tail (if a short append can even happen) is
> safe.
> 
> v2:
> - Patch 1 (kept R-b):
>   - Put all 32-bit fields together
>   - Removed unnecessary parentheses
> - Patch 2 (kept R-b):
>   - make qemu_iovec_destroy() call contingent on qiov.iov being non-NULL
>   - include total_done in offset in laio_do_submit()
> - Patch 3 (kept R-b):
>   - make qemu_iovec_destroy() call contingent on qiov.iov being non-NULL
>   - include total_done in offset in luring_prep_sqe()

Thanks, applied to the block branch.

Kevin


