Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177E606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D1pJ0QYI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7rI-0003Rp-Vb; Wed, 28 Oct 2026 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM7rI-0003Ra-3r
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xM7rF-00081h-CH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793210080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3SdHF9tPL2CGSziLCTtf1zhb8Dnq0Ef7aZQfrFKObo=;
 b=D1pJ0QYIJOpVz6c4SEUnEp83HhypIR4YsuB4/S50eoOjiDihkutGQ8fKlKlRuQKGGSiZ5q
 +dKk8sLDfvDze08xdfaPpvVklzJD7SZIpMlfsNAw2VYO9pnReA8IIQRAj98VUGNfGBH1V+
 RhFvmmWjFYt7rVSfhz6ym5KYsyRllQQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-AyBVzPmJPPy1bNh-hQCrcA-1; Wed,
 28 Oct 2026 13:54:37 -0400
X-MC-Unique: AyBVzPmJPPy1bNh-hQCrcA-1
X-Mimecast-MFC-AGG-ID: AyBVzPmJPPy1bNh-hQCrcA_1793210076
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77071180267B; Wed, 28 Oct 2026 17:54:36 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C3E51956087; Wed, 28 Oct 2026 17:54:34 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:54:31 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, afaria@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] file-posix: Add 'accept-read-only-device' option
Message-ID: <auI1mzkqNehP_-FM@redhat.com>
References: <20261028171057.139326-1-kwolf@redhat.com>
 <20261028171057.139326-2-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028171057.139326-2-kwolf@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 06:10:56PM +0100, Kevin Wolf wrote:
> The host_device block driver refuses to open a block device read-write
> if the BLKROGET ioctl tells it that it's actually read-only. For such
> devices it's possible to open a read-write file descriptor, but any
> writes to the device would fail.
> 
> There are valid use cases for which this check gets in the way, as
> explained in the bug report:
> 
>     However, this behavior prevents a legitimate enterprise use case:
>     running VMs against storage replication target LUNs in a disaster
>     recovery configuration. Enterprise storage arrays (Dell Powermax,
>     Pure Storage) set the SCSI Write Protect bit on replication target
>     LUNs, causing the Linux kernel to mark them read-only via BLKROGET.
>     The VMs on the passive DR site need to start with these LUNs
>     attached - writes are expected to fail (the application middleware
>     knows it's on the passive side), and after a DR role swap the LUN
>     becomes writable and writes should succeed immediately without any
>     VM restart.
> 
> In order to allow such use cases in which a currently read-only device
> is deliberately opened read-write, add a new option to the host_device
> driver that allows the user to skip the check.
> 
> Buglink: https://redhat.atlassian.net/browse/RHEL-186136
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 19 ++++++++++++++++++-
>  block/file-posix.c   | 23 ++++++++++++++++++++---
>  2 files changed, 38 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


