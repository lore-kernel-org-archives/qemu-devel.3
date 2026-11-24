Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WPas7WNx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwlp-0002mQ-JG; Tue, 24 Nov 2026 15:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVwlg-0002l1-Oc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVwlS-00088S-Jh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795550717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJrSkMVR+LZTbTEM2yMo9vqrOUwDwHZW8MEiKnaOEsk=;
 b=WPas7WNxlQq2ee/lcxMzAJUoXIai3mMGrpS+cQDVcuOwdCWk3y9zboaAS1psRXgvaz6eyL
 XI69UrYcfG1Km74Dm6pXR0jFksB9bHGhG/Af/aFvim2C0myB4fSvio9fFP4K8GKwS4sDeb
 Wzqb/zRMCWqGTBcUSWIGoEr5EqpvF+0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-VzbZieKSMGSvYXikCW_DoA-1; Tue,
 24 Nov 2026 20:05:13 +0000
X-MC-Unique: VzbZieKSMGSvYXikCW_DoA-1
X-Mimecast-MFC-AGG-ID: VzbZieKSMGSvYXikCW_DoA_1795550711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA67C1944AA5; Tue, 24 Nov 2026 20:05:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2454C3000709; Tue, 24 Nov 2026 20:05:08 +0000 (UTC)
Date: Tue, 24 Nov 2026 15:05:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org,
 pierrick.bouvier@oss.qualcomm.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v2] fdmon-io_uring: avoid idle event loop being accounted
 as IO wait
Message-ID: <20261124200507.GA1918687@shajnocz.csb>
References: <20261124113700.470090-1-f.ebner@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124113700.470090-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 12:36:57PM +0100, Fiona Ebner wrote:
> From: Thomas Lamprecht <t.lamprecht@proxmox.com>
> 
> Since QEMU 10.2, iothreads use io_uring for file descriptor monitoring
> when available at build time. The blocking wait in io_uring_enter()
> gets accounted as IO wait by the kernel even when only poll or timeout
> SQEs are present. The result is nearly 100% IO pressure in PSI on idle
> VMs.
> 
> The Linux kernel also has a bug conflating reservations for task
> references and real in-flight requests [0], so the issue could occur
> even if no poll or timeout SQE was present.
> 
> The io_uring_set_iowait() function is available since liburing 2.10,
> so create a stub when it's not available and accept that IOWAIT
> accounting includes POLL_ADD and TIMEOUT ops on older hosts.
> 
> Track the number of in-flight requests that represent real block-layer
> IO (currently, anything submitted via aio_add_sqe() is) in a
> per-AioContext counter, and disable iowait accounting when the count
> is zero.
> 
> SQ-ring composition alone is not a usable signal here: poll SQEs get
> re-armed by process_cqe_aio_handler() on every fd-event cycle, so
> workloads with constant fd wakeups (observed with librbd) always leave
> a non-timeout SQE in the ring even when the guest is idle. Block
> drivers that do not go through aio_add_sqe() (e.g. librbd, libaio,
> thread-pool) never increment the counter and thus always get the flag
> passed, which matches the semantic intent: their iothreads block on
> completion notifications from other threads, not on IO they issued
> themselves.
> 
> The iowait_accounting_reqs counter added to the AioContext struct must
> be accessed with atomics, since a vCPU thread can reach
> fdmon_io_uring_wait() via aio_poll() (for example via
> virtio_scsi_dataplane_stop()).
> 
> [0]: https://lore.kernel.org/io-uring/b4d2aa36-8301-4e58-be3e-1451267b8c43@proxmox.com/T/
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ded29e64c6f3 ("aio-posix: integrate fdmon into glib event loop")
> Suggested-by: Fiona Ebner <f.ebner@proxmox.com>
> Link: https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@proxmox.com/
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> Co-authored-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Use io_uring_set_iowait() if available.
> * Do not split submit and wait in fdmon_io_uring_wait().
> * Cover other entry points that may call io_uring_enter().
> * Improve comment about private struct member.
> * Document assumption that request is not multishot for aio_add_sqe().
> 
>  include/qemu/aio.h    | 15 ++++++++++++++
>  meson.build           |  2 ++
>  util/fdmon-io_uring.c | 46 ++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 60 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan


