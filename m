Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552EBC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 19:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdaYt-0008G8-Ji; Thu, 30 Jan 2025 14:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaYm-0008FR-PU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:50:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaYk-0003IB-Pt
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738266641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nYAluqaD00gSuYCxM4QLUFM67xEtgc59x0RZv5IxEYU=;
 b=LE7qddSUysFfDMdUu2HorhsrvlkM2DLENmrX1NoYl6RVDDTRGd3mcNN0Qij43ECv0J+B+F
 9GyQEev8FjmUFjSdtiFoH7hDjwj3HLRrZ20qJfXCl1fPZR52cYOeYHR3HpOWCy4+nziFtc
 /gz6k0eC4mtAlUJjI9k9dpqjM4/0MCc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-h7SfKcogOea-TnmMS4sa7A-1; Thu,
 30 Jan 2025 14:50:37 -0500
X-MC-Unique: h7SfKcogOea-TnmMS4sa7A-1
X-Mimecast-MFC-AGG-ID: h7SfKcogOea-TnmMS4sa7A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388221800373; Thu, 30 Jan 2025 19:50:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56AD319560AA; Thu, 30 Jan 2025 19:50:33 +0000 (UTC)
Date: Thu, 30 Jan 2025 13:50:30 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/15] migration/block-active: Remove global active flag
Message-ID: <w4os6ygobpsglo4h4a6gmg35sv4wzqvww4jzviqsjwwmjdywvh@nzdyfj3ybiar>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-4-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Thu, Jan 30, 2025 at 06:12:34PM +0100, Kevin Wolf wrote:
> Block devices have an individual active state, a single global flag
> can't cover this correctly. This becomes more important as we allow
> users to manually manage which nodes are active or inactive.
> 
> Now that it's allowed to call bdrv_inactivate_all() even when some
> nodes are already inactive, we can remove the flag and just

Is this commit out of order with 5/15 that removes the assertion
failure for inactivating an already-inactive device?

But in the long run, the sentiment is correct, even if the wording is
inaccurate for a window of a couple of patches, so I'm not sure it is
worth a slight rewording to s/it's allows/it will soon be allowed/.

> unconditionally call bdrv_inactivate_all() and, more importantly,
> bdrv_activate_all() before we make use of the nodes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/migration.h    |  3 ---
>  migration/block-active.c | 46 ----------------------------------------
>  migration/migration.c    |  8 -------
>  3 files changed, 57 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


