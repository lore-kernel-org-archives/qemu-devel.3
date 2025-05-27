Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5417DC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJy1h-00017B-Dt; Tue, 27 May 2025 13:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJy1f-00014R-23
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJy1d-0000vf-1w
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748366619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Fr4KP/w+ew6NVMzGi9V//f2p+cYP+KfRyvIRcgzr9U=;
 b=EANryRCCgZCif+tnOs6mvn4beioLf6u6HJyxiCMo2ECOIUM8oAOOoO/bqoz6IWSlJ7P5p4
 RE//zn6mW9MUwqk8N7jf8j1BCQxsVbIpAfmbyxkqwS2k3taICWrAwMgud/jiyqSO0qaCb/
 PAeYBW7mjH+WOEOyKhSJ86YyFy5Oms0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-SH_nK-L8NeC0VhaTVC7i7A-1; Tue,
 27 May 2025 13:23:38 -0400
X-MC-Unique: SH_nK-L8NeC0VhaTVC7i7A-1
X-Mimecast-MFC-AGG-ID: SH_nK-L8NeC0VhaTVC7i7A_1748366616
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF00A180045C; Tue, 27 May 2025 17:23:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.20])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 037F919560A3; Tue, 27 May 2025 17:23:25 +0000 (UTC)
Date: Tue, 27 May 2025 19:23:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v3 14/24] block: move drain outside of quorum_add_child()
Message-ID: <aDX1C8HPLOMyPgOR@redhat.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-15-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132140.1641377-15-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
> This is part of resolving the deadlock mentioned in commit "block:
> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
> 
> The quorum_add_child() callback runs under the graph lock, so it is
> not allowed to drain. It is only called as the .bdrv_add_child()
> callback, which is only called in the bdrv_add_child() function, which
> also runs under the graph lock.
> 
> The bdrv_add_child() function is called by qmp_x_blockdev_change(),
> where a drained section is introduced.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Here we should have the documentation about the draining requirement on
both BlockDriver.bdrv_add_child() and the bdrv_add_child() wrapper. With
the added comments:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


