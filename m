Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7365ACCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIOks-0005Hs-MR; Mon, 10 Nov 2025 05:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vIOc6-0002ON-Fm
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vIOc3-0005Tf-9Z
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 04:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762768501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WC9lkc/lJYNdUy3gctgOGCjhmREld1xXVFbpfu+tRjM=;
 b=DQhRwSI0PeaZeT3gEk6mOTWwLFSvwkfUYiRs+0Z3C4mxDEXCYP6Vd4ui6g2xERXj0Qg67r
 G4LPLDGSQqECup+3GMu4D7DMK3Nfa2DxFYdQsmmrZM/ylM6DblhWVll/ADNDZ0J6zRuRg0
 w1PoBOSjKj6uVdqM5HvDwJIx4c6psdU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-_VtNDOZkPnmek9x38ORrsg-1; Mon,
 10 Nov 2025 04:53:40 -0500
X-MC-Unique: _VtNDOZkPnmek9x38ORrsg-1
X-Mimecast-MFC-AGG-ID: _VtNDOZkPnmek9x38ORrsg_1762768419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65294180035F; Mon, 10 Nov 2025 09:53:38 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC59F30001B9; Mon, 10 Nov 2025 09:53:35 +0000 (UTC)
Date: Mon, 10 Nov 2025 10:53:32 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christopher Pereira <kripper@imatronix.cl>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, users@lists.libvirt.org
Subject: Re: Compact backing chain (sparsify + compress)
Message-ID: <aRG2HK8nNMo_ySPt@angien.pipo.sk>
References: <aea951a3-6e83-4ec1-b287-4d7dba14b674@imatronix.cl>
 <87wm3y2zet.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wm3y2zet.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 10, 2025 at 07:07:54 +0100, Markus Armbruster via Users wrote:
> Adding cc:s.
> 
> Christopher Pereira <kripper@imatronix.cl> writes:
> 
> > Hi,
> >
> > I would like to revisit this old thread from 2016 with a special use case that I believe should be a standard `virsh` command:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03571.html
> >
> > **Summary:**
> >
> > Given this QEMU backing chain:
> > `base <- snap1 <- snap2 <- snap3 (active)`
> >
> > We want to merge `base <- snap1 <- snap2` into a new snapshot `collapsed-base` that is:
> > 1. Sparsified (`virt-sparsify`)
> > 2. Compressed
> >
> > The resulting backing chain would be:
> > `collapsed-base <- snap3 (active)`

So collapsing 'snap1' and 'snap2' into 'base' is currently possible
directly via libvirt's 'virsh blockcommit'. Select 'snap2' as 'top'
argument.

Unfornunately 'virt-sparsify' can be used only on inactive VMs as it
modifies the disk. You could sparisify the VM directly from within the
guest OS if you enable discard propagation.

Regarding qcow2 compression, libvirt currently doesn't support adding
'compress' filters to the backing chain which could theoretically make
the base to be compressed. Compression has performance impact also on
reads and thus users will not normally want to use it, especially if the
majority of the image (for reads) is still in the backing image.

> > **Motivation:**
> >
> > - We perform daily backup snapshots and never modify existing files (too dangerous). We only rebase.

For backups we now have specific APIs to perform block-level
incremental backups via qemu's support to track block changes.

See

https://www.libvirt.org/kbase/live_full_disk_backup.html
https://www.libvirt.org/formatbackup.html

> > - We collapse older chains into a new `collapsed-base` snapshot to limit chain size and avoid performance degradation.
> >
> > We have been doing this successfully for over 10 years using:
> >
> > - `qemu-img convert`
> > - `virt-sparsify`
> > - `virsh save`
> > - `qemu-img rebase`
> > - `virsh resume`
> >
> > **Problems:**
> >
> > - There is a small downtime due to `virsh save`/`resume`.
> > - In recent QEMU versions, `virsh` adds a `backingStore` tag to the XML even when using the `--no-metadata` option. This causes inconsistencies after `qemu-img rebase`.

That's a libvirt change that added backing store tracking. When you
collapse the backing chain via libvirt it modifies the <backingStore>
elements approrpiately.

> >
> > We didn’t use QMP because it didn’t support sparsify + compression in the past.
> >
> > **Questions:**
> >
> > - Is there now a better way to achieve this?

Consider using the backup APIs; see above.

> > - Could this feature be implemented or supported directly in `virsh`?
> >
> > In my opinion, this would be the ideal backup solution: we could travel in time, sync immutable snapshots to a remote backup server, and maintain performance.

So current state:
- for backups libvirt now supports the backup APIs to use qemu's changed
  block tracking
- backing chani merging is already implemented
- sparsification for a live VM needs to be driven via the VM itself
  (virt-sparsify can't be used while the VM is running or saved)
- compression support (while technically feasible) is unlikely to be ever
  implemented in libvirt


