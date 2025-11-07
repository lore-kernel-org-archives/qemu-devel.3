Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D0CCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 12:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHLex-0003uQ-Fh; Fri, 07 Nov 2025 07:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vHLew-0003tn-7X
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 07:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vHLeu-0006KW-OV
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 07:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762518820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjnCX8VSnBiGfn5GghaAzGG7Z5wpMi9Qk3YEbGg9eLA=;
 b=MdYoPHITaig81xbt6AUXFsubeyOjLGi/BD3iYcVVn8dVF3VpHqCYvfALogMBNVURUiLIHT
 wnha5EG8vN/vYkpK/Btrh6IWUUH9gGSCXzWgmocbza3cIffS+k/60vbZqW9O4NCXMsTJxo
 fImXeCqadq04qUSpwABsy7WAHtRPIqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-ZsNQnPJwNiGxXcD0K56IFA-1; Fri,
 07 Nov 2025 07:33:37 -0500
X-MC-Unique: ZsNQnPJwNiGxXcD0K56IFA-1
X-Mimecast-MFC-AGG-ID: ZsNQnPJwNiGxXcD0K56IFA_1762518816
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6E4B180048E; Fri,  7 Nov 2025 12:33:35 +0000 (UTC)
Received: from redhat.com (stefkas-mbp.str.redhat.com [10.33.192.245])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD2643001E83; Fri,  7 Nov 2025 12:33:33 +0000 (UTC)
Date: Fri, 7 Nov 2025 13:33:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
Message-ID: <aQ3nG4RcLTFaNv6V@redhat.com>
References: <20251107091834.383781-1-berto@igalia.com>
 <aQ3mnR1RJiaPau6A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3mnR1RJiaPau6A@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 07.11.2025 um 13:31 hat Kevin Wolf geschrieben:
> Am 07.11.2025 um 10:18 hat Alberto Garcia geschrieben:
> > During a rebase operation data is copied from the backing chain into
> > the target image using a loop, and each iteration looks for a
> > contiguous region of allocated data of at most IO_BUF_SIZE (2 MB).
> > 
> > Once that region is found, and in order to avoid partial writes, its
> > boundaries are extended so they are aligned to the (sub)clusters of
> > the target image (see commit 12df580b).
> > 
> > This operation can however result in a region that exceeds the maximum
> > allowed IO_BUF_SIZE, crashing qemu-img.
> > 
> > This can be easily reproduced when the source image has a smaller
> > cluster size than the target image:
> > 
> > base <- int <- active
> > 
> > $ qemu-img create -f qcow2 base.qcow2 4M
> > $ qemu-img create -f qcow2 -F qcow2 -b base.qcow2 -o cluster_size=1M int.qcow2
> > $ qemu-img create -f qcow2 -F qcow2 -b int.qcow2  -o cluster_size=2M active.qcow2
> > $ qemu-io -c "write -P 0xff 1M 2M" int.qcow2
> > $ qemu-img rebase -F qcow2 -b base.qcow2 active.qcow2
> > qemu-img: qemu-img.c:4102: img_rebase: Assertion `written + pnum <= IO_BUF_SIZE' failed.
> > Aborted
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3174
> > Fixes: 12df580b3b7f ("qemu-img: rebase: avoid unnecessary COW operations")
> > Signed-off-by: Alberto Garcia <berto@igalia.com>

Oops, I forgot to mention the other point I had:

Cc: qemu-stable <qemu-stable@nongnu.org>

Added it to the Cc: list of this reply and also to the commit message.

Kevin


