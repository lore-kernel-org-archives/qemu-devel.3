Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C135BCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 09:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um7Lx-0007DF-2R; Wed, 13 Aug 2025 05:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1um7Lo-0007B9-Tu
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 05:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1um7Li-0005vx-UL
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 05:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755075644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xzut1+MCg+ehy7Oid7ZMIhCxvguCVXvLcHTMsdLjTds=;
 b=AkMWsD0F+eota7AcDXTmRW7XW4mo52ZS8Mj5m/YYdJb2NTDgdXTqbtqUxoKrBkbSbms/tK
 UT/FYTubvtksz4Sg3PBV+I/9ckagA9XzJ3oqDJFTZt8XnDENMjJkITGAZ/g/Copqz4bXFN
 v6r3YNaUs4/VUr8zy2nE9+eTYsE9tfM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-_BRWYxSPPBKoQ0dVk7u9TA-1; Wed,
 13 Aug 2025 05:00:42 -0400
X-MC-Unique: _BRWYxSPPBKoQ0dVk7u9TA-1
X-Mimecast-MFC-AGG-ID: _BRWYxSPPBKoQ0dVk7u9TA_1755075641
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59B7D195609E; Wed, 13 Aug 2025 09:00:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07FD91800446; Wed, 13 Aug 2025 09:00:37 +0000 (UTC)
Date: Wed, 13 Aug 2025 11:00:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 2/3] rbd: Fix .bdrv_get_specific_info implementation
Message-ID: <aJxUM-ciwAUzgHYQ@redhat.com>
References: <20250812195901.305895-1-kwolf@redhat.com>
 <20250812195901.305895-3-kwolf@redhat.com>
 <30ecd389-fc8f-49e7-affa-99787f11d322@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ecd389-fc8f-49e7-affa-99787f11d322@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.08.2025 um 08:12 hat Michael Tokarev geschrieben:
> On 12.08.2025 22:59, Kevin Wolf wrote:
> > qemu_rbd_get_specific_info() has at least two problems:
> > 
> > The first is that it issues a blocking rbd_read() call in order to probe
> > the encryption format for the image while querying the node. This means
> > that if the connection to the server goes down, not only I/O is stuck
> > (which is unavoidable), but query-names-block-nodes will actually make
> > the whole QEMU instance unresponsive. .bdrv_get_specific_info
> > implementations shouldn't perform blocking operations, but only return
> > what is already known.
> > 
> > The second is that the information returned isn't even correct. If the
> > image is already opened with encryption enabled at the RBD level, we'll
> > probe for "double encryption", i.e. if the encrypted data contains
> > another encryption header. If it doesn't (which is the normal case), we
> > won't return the encryption format. If it does, we return misleading
> > information because it looks like we're talking about the outer level
> > (the encryption format of the image itself) while the information is
> > about an encryption header in the guest data.
> > 
> > Fix this by storing the encryption format in BDRVRBDState when the image
> > is opened (and we do blocking operations anyway) and returning only the
> > stored information in qemu_rbd_get_specific_info().
> > 
> > The information we'll store is either the actual encryption format that
> > we enabled on the RBD level, or if the image is unencrypted, the result
> > of the same probing as we previously did when querying the node. Probing
> > image formats based on content that can be modified by the guest has
> > long been known as problematic, but as long as we only output it to the
> > user instead of making decisions based on it, it should be okay. It is
> > undoubtedly useful in the context of 'qemu-img info' when you're trying
> > to figure out which encryption options you have to use to open the
> > image successfully.
> > 
> > Fixes: 42e4ac9ef5a6 ("block/rbd: Add support for rbd image encryption")
> > Buglink: https://issues.redhat.com/browse/RHEL-105440
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Message-ID: <20250811134010.81787-1-kwolf@redhat.com>
> > Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> This looks like a qemu-stable material (10.0).  Please let me know
> if it is not.

I was on the verge of adding Cc: qemu-stable for it, but then decided
against it because it does subtly change behaviour in the common case
where the connection doesn't go down. On second thoughts, the common use
case is 'qemu-img info' where the image isn't opened encrypted (because
we're only trying to find out which encryption format it has), and that
output stays the same. So taking it into stable might still be
reasonable enough.

Kevin


