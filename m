Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1372FC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfdJ-0002SO-MW; Thu, 13 Mar 2025 06:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tsfdD-0002Q7-5M
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tsfdB-0001wn-G2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MA9dE9T5xInzh/TpnlrKHFzJCyAk8i+o0W7aV7g8P74=;
 b=GaKtYevwK6VzB7xoUMULthx8edIb9FYHBqQek0PM2p2A2oDLUuGBylKOXbOEeo3YMjEl4g
 uyNevkq46rxRcf+dXfSAp+QBCUogWgSZetB3u5N/E7amGCkKdewAxydGHmebZa0vXHYb6s
 aVDSl+4Ftj7fIFLEeYoVNwOgwKR8SDM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-LMzHuBJCPGW1iDYKOxaOHw-1; Thu,
 13 Mar 2025 06:17:31 -0400
X-MC-Unique: LMzHuBJCPGW1iDYKOxaOHw-1
X-Mimecast-MFC-AGG-ID: LMzHuBJCPGW1iDYKOxaOHw_1741861050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75EF31801A12; Thu, 13 Mar 2025 10:17:29 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 409B218001E9; Thu, 13 Mar 2025 10:17:26 +0000 (UTC)
Date: Thu, 13 Mar 2025 11:17:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH] block: Fix bdrv_activate() not to fail without medium
Message-ID: <Z9KwszV4pQ-Kw0es@redhat.com>
References: <20250312143758.1660177-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312143758.1660177-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 12.03.2025 um 15:37 hat Markus Armbruster geschrieben:
> bdrv_activate() returns failure without setting an error when
> !bs->drv.  This is suspicious.  Turns out it used to succeed then,
> until commit 5416645fcf82 changed it to return -ENOMEDIUM.
> 
> Return zero instead.
> 
> Fixes: 5416645fcf82 (block: return error-code from bdrv_invalidate_cache)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

The commit message sounds more theoretical. Did you find this only by
code inspection? Do we know what the effect on real-world cases is, so
we could add a sentence about it to the commit message? Maybe we could
even have a qemu-iotests case to show the effect?

I absolutely agree that returning -ENOMEDIUM while not setting errp is
wrong. But without an example of what is affected, it's not obvious to
me which part of it needs to be fixed.

Kevin


