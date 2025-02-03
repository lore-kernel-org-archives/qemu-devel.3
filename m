Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B50AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1sh-0001SH-Df; Mon, 03 Feb 2025 14:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf1se-0001RZ-GY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf1sa-0007e8-J2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738609985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQXprCEQzf67nVP14Qq6AkDewKIycIJxUEOl3KvBuJM=;
 b=a0tyJbSmpmUb3RZiIQ+B3+Tb/fcMPUBqR93syXwuuS8P6jGqsQTk+DU7yLXHNuTtHcwCri
 BL9XmF+DMrJgwOZz/iUp5C6K5SNdk0I1AsDOoWmiRpow/lg/RVzIEMLiY6Md1NmAmQKCPL
 0Sqo2FC0kbJBopX7LTDRNKKNji1Ug+8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-QD73GDq4MOKkyMtn56pDpQ-1; Mon,
 03 Feb 2025 14:13:01 -0500
X-MC-Unique: QD73GDq4MOKkyMtn56pDpQ-1
X-Mimecast-MFC-AGG-ID: QD73GDq4MOKkyMtn56pDpQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFB011801F18; Mon,  3 Feb 2025 19:12:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.73])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BD6630001BE; Mon,  3 Feb 2025 19:12:55 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:12:52 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 11/15] block/export: Add option to allow export of
 inactive nodes
Message-ID: <7jxsvzgn7wjdjgfifjglv5fyyfp6v52wzjpzdbt6t4rwdplev2@afc6egu6bbzk>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250131095051.49708-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131095051.49708-2-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 31, 2025 at 10:50:47AM +0100, Kevin Wolf wrote:
> Add an option in BlockExportOptions to allow creating an export on an
> inactive node without activating the node. This mode needs to be
> explicitly supported by the export type (so that it doesn't perform any
> operations that are forbidden for inactive nodes), so this patch alone
> doesn't allow this option to be successfully used yet.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json             | 10 +++++++++-
>  include/block/block-global-state.h |  3 +++
>  include/block/export.h             |  3 +++
>  block.c                            |  4 ++++
>  block/export/export.c              | 31 ++++++++++++++++++++----------
>  5 files changed, 40 insertions(+), 11 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


