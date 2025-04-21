Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6763C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 14:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6sas-0006Cf-7V; Mon, 21 Apr 2025 10:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sar-0006CT-3H
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 10:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sap-0000e5-80
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 10:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745247473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkPpGuz/koz83DK5bYjYztqVZuhpnVx5S1ZmO+JZhxw=;
 b=P0deyrR6oZc2Ozbc86Cyl4CiXtHcNGtS238etilJEkhHEVAHTaO8Cskum93YATUVDVPMrf
 h/CpFuUIKMIofke2ideIDGLtOQzMlRzCezC/m39EPN4FR94/GTuwlCkzVE4Uuc4YfRu/GP
 8RXjxF6rBZUTX/4LvC+nymT2byWtRDE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-DBOiaLVNM72Oy7MIUD8M0w-1; Mon,
 21 Apr 2025 10:57:50 -0400
X-MC-Unique: DBOiaLVNM72Oy7MIUD8M0w-1
X-Mimecast-MFC-AGG-ID: DBOiaLVNM72Oy7MIUD8M0w_1745247469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26E451955DC6; Mon, 21 Apr 2025 14:57:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 272F919560A3; Mon, 21 Apr 2025 14:57:44 +0000 (UTC)
Date: Mon, 21 Apr 2025 09:57:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block/file-posix: allow BLKZEROOUT with -t writeback
Message-ID: <waelzl7a6py3fd47mr2w57hh5a6ucfesiuucpe2g3ht57dys2i@y2pqeq6m2dmd>
References: <20250417211053.98700-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417211053.98700-1-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
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

On Thu, Apr 17, 2025 at 05:10:53PM -0400, Stefan Hajnoczi wrote:
> The Linux BLKZEROOUT ioctl is only invoked when BDRV_O_NOCACHE is set
> because old kernels did not invalidate the page cache. In that case
> mixing BLKZEROOUT with buffered I/O could lead to corruption.
> 
> However, Linux 4.9 commit 22dd6d356628 ("block: invalidate the page
> cache when issuing BLKZEROOUT") made BLKZEROOUT coherent with the page
> cache.
> 
> I have checked that Linux 4.9+ kernels are shipped at least as far back
> as Debian 10 (buster), openSUSE Leap 15.2, and RHEL/CentOS 8.
> 
> Use BLKZEROOUT with buffered I/O, mostly so `qemu-img ... -t
> writeback` can offload write zeroes.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 11 -----------
>  1 file changed, 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


