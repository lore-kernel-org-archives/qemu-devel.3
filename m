Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F97C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPCW-0000Io-U8; Tue, 20 May 2025 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPCS-0000I2-MB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPCR-0002MQ-4N
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747756093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AkuJockVPYKRQlGQhJ4Vx7XQ+h/iMB7KaxIr56ZY0js=;
 b=M17pMLEGkfsh9PHRQrWiKgJ8H94F/vPv1eb/ZDm7W+YIx7Tky5d5WsactOEzZa9JoQDegU
 65R00fjXC1vtz97Nr7QyEBkSkJCjKlrh6mOv8lwTXCs5X44fbCFyvAI5eAYTY3VOyUlI+C
 ie4N2o2SawnphzAc9RCenffC/iwkXzQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-E1F83hP7NJKlgsP_kKAg4Q-1; Tue,
 20 May 2025 11:48:08 -0400
X-MC-Unique: E1F83hP7NJKlgsP_kKAg4Q-1
X-Mimecast-MFC-AGG-ID: E1F83hP7NJKlgsP_kKAg4Q_1747756086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ABC719560AA; Tue, 20 May 2025 15:48:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6698819560AD; Tue, 20 May 2025 15:48:00 +0000 (UTC)
Date: Tue, 20 May 2025 10:47:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, 
 stefanha@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru, 
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 06/24] block: mark change_aio_ctx() callback and
 instances as GRAPH_RDLOCK(_PTR)
Message-ID: <ujbo2q7weoe7irynye5xbcah3nrst73imvty6rhgdzgtqtdmrn@rmvdqm3iabxo>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-7-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-7-f.ebner@proxmox.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Tue, May 20, 2025 at 12:29:54PM +0200, Fiona Ebner wrote:
> This is a small step in preparation to mark bdrv_drained_begin() as
> GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the

preparation

> drain out of bdrv_change_aio_context() and marking that function as
> GRAPH_RDLOCK.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


