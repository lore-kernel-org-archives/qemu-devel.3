Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F0EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFeYc-000443-FF; Thu, 15 May 2025 15:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFeYb-00042w-RS
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFeYa-000151-9L
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747338470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YPMIwIPbsRZfuT+8k5x7VTbs7gK7HMTh0hplDAhONAs=;
 b=cTiaiey99RRLPk9nsu9g2Qa7C+SlALV8A4nvnVzmLRjM4Syf6kLy0phawoXzPf/f00jIVv
 78Hu7skoboKAW0h8PG2Gk5KTy/F0HUNwsQ4O71irJ71Ly1PDl6McSycs/iHJmdtHEdGehZ
 z+Cp2Q/Sri4D/gk/907UP3WCfWXdXeU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-o2EuGDJROcmzYab-da_m8Q-1; Thu,
 15 May 2025 15:47:49 -0400
X-MC-Unique: o2EuGDJROcmzYab-da_m8Q-1
X-Mimecast-MFC-AGG-ID: o2EuGDJROcmzYab-da_m8Q_1747338468
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C070119560BC; Thu, 15 May 2025 19:47:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.66])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A7D21800359; Thu, 15 May 2025 19:47:45 +0000 (UTC)
Date: Thu, 15 May 2025 14:47:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/2] qcow2: put discards in discard queue when
 discard-no-unref is enabled
Message-ID: <q2uh4thxyyuygd3y7ogig3727uxoxmq25egbc2szzj7payccz7@q5almgfwulrj>
References: <20250513132628.1055549-1-jean-louis@dupond.be>
 <20250513132628.1055549-3-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513132628.1055549-3-jean-louis@dupond.be>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 03:26:28PM +0200, Jean-Louis Dupond wrote:
> When discard-no-unref is enabled, discards are not queued like it
> should.
> This was broken since discard-no-unref was added.
> 
> Add some helper function qcow2_discard_cluster which handles some common

s/Add some/Add a/

(presumably the maintainer will fix the typo when queueing the patch,
no need to respin if the only change is a trivial commit message typo)

> checks and calls the queue_discards function if needed to add the
> discard request to the queue.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>  block/qcow2-cluster.c  | 16 ++++++----------
>  block/qcow2-refcount.c | 17 +++++++++++++++++
>  block/qcow2.h          |  4 ++++
>  3 files changed, 27 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


