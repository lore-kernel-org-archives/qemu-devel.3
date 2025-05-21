Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96279C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlIH-0007xX-PV; Wed, 21 May 2025 11:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHlIF-0007xM-Ck
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHlI7-0003XN-D8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747841012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ET53qD0Rw/eEsVRB03imsJfLnHW0LRdAFYHfhMYnBbE=;
 b=S3T1wkix34+WCFKzD7YkeZ04CrMxIdxcFnbp5+XC21wmWrtrT53O21O0MkIUH7UYFWyCrZ
 NqiTtWtolvMUW3pXsZHpbp4iSvSSPGNwtuKushRAFoilTsfGVwy0hO+5COxGwnjx12ILFn
 t7W2Kluy3+zGI4YvNllQyjRzalMJtZ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-5wT6UWieMsysYV_tdb2VDg-1; Wed,
 21 May 2025 11:23:31 -0400
X-MC-Unique: 5wT6UWieMsysYV_tdb2VDg-1
X-Mimecast-MFC-AGG-ID: 5wT6UWieMsysYV_tdb2VDg_1747841009
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25648180087E; Wed, 21 May 2025 15:23:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1261F30001AA; Wed, 21 May 2025 15:23:20 +0000 (UTC)
Date: Wed, 21 May 2025 17:23:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 06/24] block: mark change_aio_ctx() callback and
 instances as GRAPH_RDLOCK(_PTR)
Message-ID: <aC3v5m3l8uz9HcQ4@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-7-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-7-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> This is a small step in preparation to mark bdrv_drained_begin() as
> GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the
> drain out of bdrv_change_aio_context() and marking that function as
> GRAPH_RDLOCK.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

I noticed that all existing callers of .change_aio_ctx() apart from the
one annotated only in the previous patch are in fact even GRAPH_WRLOCK.

Maybe it's not important any more nowadays given that the assigned
AioContext of a block node is more of a default, but traditionally I
think it would have made sense to treat changing the AioContext as
changing the graph, i.e. bs->aio_context could have been GRAPH_WRLOCK.

Just posting this in case someone has more thoughts on it. I don't
necessarily disagree with using GRAPH_RDLOCK.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


