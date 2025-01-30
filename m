Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692D6C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdb44-0007L0-LK; Thu, 30 Jan 2025 15:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdb3w-0007Jy-NQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdb3u-0002xW-GY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738268573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QV+WCJHeQl7vvve6y1ANB46ttPT4t5bKMZ1UMxgIDA=;
 b=HfbZ9V0vyrN3dJnj9hCBFM0UWP+cJeBqAkwXvnVYrMOJUQHBFIOFR7fWLxCbgQaP8ISM60
 tmXafvC9A3z8fSAKqrMO6TdhXnf999ZOa7UUYn3qs69NIlVTplsmchrV2zgf7cDG5YJLSG
 ESF7yWyibxaD4vMliWgi2knmJ2vdC20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-oKfeRWmjMhGeJILyOCi0hQ-1; Thu,
 30 Jan 2025 15:22:48 -0500
X-MC-Unique: oKfeRWmjMhGeJILyOCi0hQ-1
X-Mimecast-MFC-AGG-ID: oKfeRWmjMhGeJILyOCi0hQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3172A1801F1A; Thu, 30 Jan 2025 20:22:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC0F21800951; Thu, 30 Jan 2025 20:22:43 +0000 (UTC)
Date: Thu, 30 Jan 2025 14:22:41 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/15] block: Add blockdev-set-active QMP command
Message-ID: <6e2bzk3xyn6mzhy7xamm7vnymlobmptaombltlqmjvz5qcn5ua@6bf5qvhmozcg>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-9-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, Jan 30, 2025 at 06:12:39PM +0100, Kevin Wolf wrote:
> The system emulator tries to automatically activate and inactivate block
> nodes at the right point during migration. However, there are still
> cases where it's necessary that the user can do this manually.
> 
> Images are only activated on the destination VM of a migration when the
> VM is actually resumed. If the VM was paused, this doesn't happen
> automatically. The user may want to perform some operation on a block
> device (e.g. taking a snapshot or starting a block job) without also
> resuming the VM yet. This is an example where a manual command is
> necessary.
> 
> Another example is VM migration when the image files are opened by an
> external qemu-storage-daemon instance on each side. In this case, the
> process that needs to hand over the images isn't even part of the
> migration and can't know when the migration completes. Management tools
> need a way to explicitly inactivate images on the source and activate
> them on the destination.
> 
> This adds a new blockdev-set-active QMP command that lets the user
> change the status of individual nodes (this is necessary in
> qemu-storage-daemon because it could be serving multiple VMs and only
> one of them migrates at a time). For convenience, operating on all
> devices (like QEMU does automatically during migration) is offered as an
> option, too, and can be used in the context of single VM.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json               | 32 ++++++++++++++++++++++++++++++
>  include/block/block-global-state.h |  3 +++
>  block.c                            | 21 ++++++++++++++++++++
>  blockdev.c                         | 32 ++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6029e54889..2ffb2efbc7 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4945,6 +4945,38 @@
>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' },
>    'allow-preconfig': true }
>  
> +##
> +# @blockdev-set-active:
> +#
> +# Activate or inactive a block device. Use this to manage the handover of block

s/inactive/inactivate/

> +# devices on migration with qemu-storage-daemon.
> +#
> +# Activating a node automatically activates all of its child nodes first.
> +# Inactivating a node automatically inactivates any of its child nodes that are
> +# not in use by a still active node.
> +#

With that minor fix, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


