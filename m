Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGijf-0007DE-0y; Tue, 13 Oct 2026 16:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGijd-0007CV-Hv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGijc-000373-0U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791921865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6fRvMSISGYN0cvq3i5JYF1oBKCZb5mvRYaRSDHtYH0=;
 b=DvbDVSSwVfowRbHr9kDCCQQTLCuADUxdE4ge+0pykTykhqOB/gIjRkV1zwIZoOgNGwnu1c
 pqvx3aNAX4dHf3HgIwE7nDANkVKZj2P9c52/ga0IciB6TrB8ZJGu/x1C4qMUnj38fRiBzu
 gj0/ljpLztXtZT67fDaGW0KEuLZ0tWY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-1BDjJrh_Mj-BmOa0Zi_AIQ-1; Tue,
 13 Oct 2026 20:04:22 +0000
X-MC-Unique: 1BDjJrh_Mj-BmOa0Zi_AIQ-1
X-Mimecast-MFC-AGG-ID: 1BDjJrh_Mj-BmOa0Zi_AIQ_1791921861
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46B9C1953957; Tue, 13 Oct 2026 20:04:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF69180029C; Tue, 13 Oct 2026 20:04:17 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:04:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 7/8] scsi: clean up persistent reservation state after
 migration
Message-ID: <as6Msz5F7DFMVf2p@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
 <20261013181752.1299456-8-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013181752.1299456-8-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 13, 2026 at 02:17:51PM -0400, Stefan Hajnoczi wrote:
> Live migration of persistent reservations is designed to work without
> coordination between the source and destination. The destination uses
> the PREEMPT command to atomically take over the reservation or
> unregister keys belonging to the source. This approach avoids race
> conditions where other nodes in the cluster might acquire the
> reservation and it minimizes communication during the downtime window.
> 
> While this works at the SCSI level, this approach is incomplete when
> using multipathd. Multipathd tracks registered keys and automatically
> registers them again when paths come up. It is unaware that the
> destination has preempted the reservation and therefore it will still
> attempt to register the key on the source host.
> 
> Use the new PR_HELPER_CLEANUP command to communicate with multipathd on
> the source after migration completes successfully. The effect is similar
> to REGISTER AND IGNORE EXISTING KEY, except it also discards
> multipathd's state so that the source will no longer attempt to register
> the key.
> 
> PR_HELPER_CLEANUP is a QEMU-internal command that is rejected by
> scsi_req_new(), so note that this command is not exposed to guests
> although direct blk_aio_ioctl(SG_IO) calls can make use of it.
> 
> Buglink: https://redhat.atlassian.net/browse/RHEL-274966
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/scsi/scsi.h |  1 +
>  hw/scsi/scsi-disk.c    | 21 ++++++++++++++++++++-
>  hw/scsi/scsi-generic.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


