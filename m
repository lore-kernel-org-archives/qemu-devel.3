Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCE3CA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDjS6-0000i2-Ng; Mon, 05 Oct 2026 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xDjS5-0000hs-IN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xDjS3-000126-Tm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791209638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWHVn3CF56EapEaGP/tP/5tzanN8k1NlbKcRTsKhfgI=;
 b=adhSB8YGLkw53PTAy1JDoaNxkmQ0sWK3ctF3p1/vzwUTYI7E3Zhof4WEozXsUSBg11kORc
 GFXk8xsO1ytIt5u9SslnOxbY1PnKC/eEFnt8EIYcr6oTIUnun57fY8H4HUl6wg/7MCZtR7
 77i62yjKx+eA1sU5MvSgUdYqaUy+uzA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-XjweyBnvPaqCvkJTOWJgiw-1; Mon,
 05 Oct 2026 10:13:55 -0400
X-MC-Unique: XjweyBnvPaqCvkJTOWJgiw-1
X-Mimecast-MFC-AGG-ID: XjweyBnvPaqCvkJTOWJgiw_1791209634
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE4D180A9EA; Mon,  5 Oct 2026 14:13:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A88811956095; Mon,  5 Oct 2026 14:13:51 +0000 (UTC)
Date: Mon, 5 Oct 2026 16:13:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, nsoffer@redhat.com,
 Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] file-posix: add statx(STATX_DIOALIGN) support
Message-ID: <asOwnf7uOtH1L-pa@redhat.com>
References: <20260922154351.226540-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922154351.226540-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 22.09.2026 um 17:43 hat Stefan Hajnoczi geschrieben:
> Linux v6.1 commit 825cf206ed51 ("statx: add direct I/O alignment
> information") added an interface to fetch O_DIRECT alignment values for
> block devices and file systems.
> 
> Prefer STATX_DIOALIGN to older interfaces and probing, but keep them as
> fallbacks in case STATX_DIOALIGN cannot provide the information.
> 
> STATX_DIOALIGN support as of Linux 6.1:
> - btrfs: no
> - ext4: yes
> - XFS: yes
> - block devices: yes
> - dm-crypt: yes
> 
> This change fixes #1290 ("IO alignment probing delivers incorrect
> results on Linux when used with e.g. dm-crypt") on Linux host kernel
> version 6.1 or later by avoiding the problematic probing code in
> raw_probe_alignment(). It would be nice to fix the probing code but I
> have not been able to reproduce it. Stable/LTS distros ship Linux 6.1+,
> so the number of users without STATX_DIOALIGN is becoming small.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1290
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
> - Rebase and update commit description
> v2:
> - Make sure that XFS_IOC_DIOINFO takes priority over logical blocksize [Eric Biggers]

Thanks, applied to the block branch.

Kevin


