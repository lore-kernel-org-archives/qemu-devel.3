Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63EDC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 19:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdaAV-0006pS-SX; Thu, 30 Jan 2025 14:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaAL-0006lf-Du
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:25:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaAJ-0006Ot-MZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738265125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uflNv/2EsUE38wmvTHwKHNcHUGlfq5/sYkwO5CTvDQM=;
 b=bY/XabdEiqRe86WvkCOCoWX+nHdJWFHgcIinJZplbiZw4MIkRFmEBWvaur/+HJlOMFSlNY
 PhyEjGAetfFREgvSw1UGrHUuVlvIfsQ1lzHMPgW2Q8qPVUTmZiR813GwiSWSKFZf3uirug
 lhN/HOUN2xhv1Sbf7xipF4rCXcqnYB4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-7afrlna6NLSLf3bxxaMxyA-1; Thu,
 30 Jan 2025 14:25:22 -0500
X-MC-Unique: 7afrlna6NLSLf3bxxaMxyA-1
X-Mimecast-MFC-AGG-ID: 7afrlna6NLSLf3bxxaMxyA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 878931801F1A; Thu, 30 Jan 2025 19:25:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E93E1800358; Thu, 30 Jan 2025 19:25:18 +0000 (UTC)
Date: Thu, 30 Jan 2025 13:25:15 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com, 
 peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/9] block: Managing inactive nodes (QSD migration)
Message-ID: <ch5jsyr5rpq77eh4maqhgdxywgiwmq5bwxjxsol5jmfs5vdzed@vouf2yhijgda>
References: <20250122115046.51216-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122115046.51216-1-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Jan 22, 2025 at 12:50:37PM +0100, Kevin Wolf wrote:
> This series adds a mechanism that allows the user or management tool to
> manually activate and inactivate block nodes instead of fully relying on
> the automatic management in the migration code.
> 
> One case where this is needed is for migration with shared storage and
> devices backed by qemu-storage-daemon, which as an external process is
> not involved in the VM migration. Management tools can manually
> orchestrate the handover in this scenario. The new qemu-iotests case
> qsd-migrate demonstrates this.
> 
> There are other cases without qemu-storage-daemon where manual
> management is necessary. For example, after migration, the destination
> VM only activates images on 'cont', but after migrating a paused VM, the
> user may want to perform operations on a block node while the VM is
> still paused.
> 
> This series adds support for block exports on an inactive node (needed
> for shared storage migration with qemu-storage-daemon) only to NBD.
> Adding it to other export types will be done in a future series.
> 
> Kevin Wolf (9):
>   block: Allow inactivating already inactive nodes
>   block: Add option to create inactive nodes
>   block: Support inactive nodes in blk_insert_bs()
>   block/export: Don't ignore image activation error in blk_exp_add()
>   block/export: Add option to allow export of inactive nodes
>   nbd/server: Support inactive nodes
>   block: Add blockdev-set-active QMP command
>   iotests: Add filter_qtest()
>   iotests: Add qsd-migrate case

I started reviewing this, but see v2 now, so I'll resume my review there.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


