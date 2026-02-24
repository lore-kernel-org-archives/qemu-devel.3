Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DBF3C982
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutVB-00070h-Og; Tue, 24 Feb 2026 09:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vutVA-000709-Re
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vutV8-0000Lp-QL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771943701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/s3DG4kRsNUk5cHSh4ez25A+ETDhRhwrwtAC4X8QkQ=;
 b=X3rXSXynm78CaC0rv7oTH6BMJ69mGVYl/gB2q6dUJ7Rs5oHY0lpwiVP25avcq7+W4sLPH1
 PJJ9CiPnjqOJ4miUaCNxNRweJNccpVwSv6b4Ela3CzfxEip33WkLRXaS0ZnURF3UqVrsSk
 NbHCPOAc91l7y637bK+jWhh1R0gM3rM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-dX3TwfkmMTCYTarAAAjc9w-1; Tue,
 24 Feb 2026 09:34:57 -0500
X-MC-Unique: dX3TwfkmMTCYTarAAAjc9w-1
X-Mimecast-MFC-AGG-ID: dX3TwfkmMTCYTarAAAjc9w_1771943697
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B57311800266; Tue, 24 Feb 2026 14:34:56 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF450195419A; Tue, 24 Feb 2026 14:34:54 +0000 (UTC)
Date: Tue, 24 Feb 2026 15:34:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
Message-ID: <aZ23DELMG6CycbQ8@redhat.com>
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116143946.1031006-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
> With '-drive', it is possible to specify the throttle configuration
> directly on the commandline. Add the possibility to do the same when
> using the modern way with '-blockdev' and a front-end device. Using a
> throttle filter block node is not always an option: in particular, the
> mirror block job operates on a root block node and it might be desired
> to throttle only the guest IO, but not to the block job.

Hm, is there still a reason why we require a root node for the source?

> There already is a 'block_set_io_throttle' QMP command, but it's nicer
> to be able to do it via the commandline too.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Hope I didn't miss a way to do this already.
> 
> Should changing via qom-set be supported? Currently, an attempt fails:
> > Error: Attempt to set property 'throttle-group' on device 'scsi0'
> > (type 'scsi-hd') after it was realized
> but there already is the 'block_set_io_throttle' QMP command.

It would be nice, but I don't think runtime writable properties are used
much in devices because I believe this would have to be done with plain
QOM properties, i.e. outside of qdev.

Though if it's actually easy, we could consider implementing it.

>  hw/block/block.c           | 15 +++++++++++++++
>  include/hw/block/block.h   |  4 +++-
>  tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)

Looks good to me, though maybe we could also use a qemu-iotests case
that actually tries to set the property instead of only updating the
output everywhere for having no throttle group.

Kevin


