Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13540CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDPhm-0003tv-6T; Mon, 27 Oct 2025 12:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDPhc-0003ql-Jn
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vDPhY-0002oA-IC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761581039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=trTStwKnlra4QQRolocHgPFrK0UqaJUDD9Vk49wb6nI=;
 b=LKHowrRrwE8anEiODSaoagn6hjJavKuTd6pfPkkbIfRzt+JtrlFoNC/t5+n99zU7fhxHMF
 h+T2RQ3lEdxa47HkdO7JmIWNZpm8c+uqy3ETv27LXvCUJdmbsiJ5zSk1IzaqGp7XIFMawM
 hWI9mcZfhXB8vzGWkdmNr7hOKH2UfM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-hU9CitkeMVaH2lqgF95DqQ-1; Mon,
 27 Oct 2025 12:03:27 -0400
X-MC-Unique: hU9CitkeMVaH2lqgF95DqQ-1
X-Mimecast-MFC-AGG-ID: hU9CitkeMVaH2lqgF95DqQ_1761580994
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346AD19540E7; Mon, 27 Oct 2025 16:03:14 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.37])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8235F180057E; Mon, 27 Oct 2025 16:03:11 +0000 (UTC)
Date: Mon, 27 Oct 2025 17:03:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 stefanha@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v2 0/5] block: refresh filter parents when child was
 resized
Message-ID: <aP-XvEvH25SsbSmD@redhat.com>
References: <20250917115509.401015-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 17.09.2025 um 13:54 hat Fiona Ebner geschrieben:
> Changes in v2:
> * Check for BDRV_CHILD_FILTERED rather than bs->drv->is_filter which
>   is more generic and for example, also covers the case when the
>   child of a 'raw' node is resized.
> * Expand commit message for main patch, i.e. 3/5.
> * Add test for resizing the filtered 'file' node of a 'raw' node.
> 
> Resizing a node below a filter would result in the filter still
> reporting the old size. Implement a 'resize' callback for the
> child_of_bds class, that refreshes filter parents recursively.

Thanks, applied to the block branch.

Kevin


