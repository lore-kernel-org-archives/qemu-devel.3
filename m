Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FE4FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGJzF-0001TZ-9s; Fri, 24 Apr 2026 13:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wGJzC-0001Si-UI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wGJzB-0003Dt-Aj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777050394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOKgE8jFCSmFpf4dCp7U1NP42j4qCfmEM5uH1z39tq4=;
 b=d9UyNR8t991RKfKiP3OBbu1uCIyHgRL6TjgqNUZWFW68tVntDcde0qj1rZEwACkXsXrXgq
 UX0omroSnKKdxTSuxoEArgihzrgk4ag9H/W1ke/g27zMUKcobGzJal7YxS4DbAueZLq2n0
 t/OB1IXYRLK/wswA7tLoHRo6X1VfGfk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373--9Sz5lIqMuiz4KJsicRvjA-1; Fri,
 24 Apr 2026 13:06:29 -0400
X-MC-Unique: -9Sz5lIqMuiz4KJsicRvjA-1
X-Mimecast-MFC-AGG-ID: -9Sz5lIqMuiz4KJsicRvjA_1777050388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE03619560BB; Fri, 24 Apr 2026 17:06:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.216])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EF4C180047F; Fri, 24 Apr 2026 17:06:24 +0000 (UTC)
Date: Fri, 24 Apr 2026 19:06:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, stefanha@redhat.com, berrange@redhat.com,
 mr-083 <matthieu@min.io>, armbru@redhat.com
Subject: Re: [PATCH] block: add blockdev-attach QMP command
Message-ID: <aeujDmRSu39026wD@redhat.com>
References: <20260415173905.71224-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415173905.71224-1-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 15.04.2026 um 19:39 hat mr-083 geschrieben:
> Add a blockdev-attach QMP command that attaches a block driver state
> tree to a device's block backend.  Unlike blockdev-insert-medium, this
> works for non-removable devices such as NVMe namespaces.
> 
> After drive_del removes a device's backing store, the BlockBackend
> remains attached to the guest device but has no BlockDriverState.
> blockdev-attach reconnects a block node (previously created with
> blockdev-add) to the device's BlockBackend via blk_insert_bs().
> 
> This separates the two concerns as recommended: blockdev-add creates
> the block node, blockdev-attach associates it with the device.
> 
> Example usage with NVMe namespace hot-swap:
>   drive_del drv0
>   blockdev-add node-name=node0 driver=qcow2 file.driver=file \
>                file.filename=disk.qcow2
>   blockdev-attach id=ns0 node-name=node0

Is the intended functionality the same as the following?

   blockdev-add node-name=node0 driver=qcow2 file.driver=file \
                file.filename=disk.qcow2
   qom-set path=ns0 property=drive value=node0
   drive-del drv0 / blockdev-del node-name=old-node

This seems cleaner because there is no window where the namespace
isn't backed by any block node.

If this does what you want, it's unclear to me if we want a separate QMP
command to do the same in a maybe more discoverable way. Markus, do we
have precedence for this?

> An HMP wrapper is included for convenience.

An HMP convenience command mapping to qom-set should still be possible
either way.

Kevin


