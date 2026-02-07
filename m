Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3793EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voigD-0003Zo-KY; Sat, 07 Feb 2026 08:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifs-0003Jk-2O
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voifn-0003FE-QE
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqS7DgxgdvRKwVkTbJh9nq7FBPfNH5tz/OogZo8RZ6c=;
 b=HX5xuaQegZoOdSP3FTvU1RFFaC/mAmlID3QvPUPJxRj6UN+Zxvdk1Ha/4rh2H6m7KkPOC6
 KcT+KBbXVvzfx931802cZx+OWlQPVQc4hAvYoTROwjycqANRRIezkpDg9iNYj6+LciXGTF
 nnZlyJYxGBmIaUCuV9oXPIfeLfsIBo4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-SR8ZxMkWOVGwAT4BwolfMg-1; Sat,
 07 Feb 2026 08:48:29 -0500
X-MC-Unique: SR8ZxMkWOVGwAT4BwolfMg-1
X-Mimecast-MFC-AGG-ID: SR8ZxMkWOVGwAT4BwolfMg_1770472108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A461956088; Sat,  7 Feb 2026 13:48:28 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4014030001A8; Sat,  7 Feb 2026 13:48:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 06/12] netfilter: filter-redirector: always return iov_size()
Date: Sat,  7 Feb 2026 21:47:22 +0800
Message-ID: <20260207134728.1495932-6-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jason Wang <jasowang@redhat.com>

filter-redirector forwards packets to a chardev (outdev). The backend write
path may return 0 or a negative error even though the filter has consumed
(and should account for) the packet.

Returning 0 propagates back to the sender (e.g. tap backend) as "cannot send"
and can cause polling to be disabled, preventing further draining of tap
traffic into the netfilter chain.

Always report the packet as consumed by returning iov_size() when outdev is
connected. Errors are still reported, but the data path is kept progressing.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter-mirror.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 21598b97a7..eb703b7dee 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -247,7 +247,7 @@ static ssize_t filter_redirector_receive_iov(NetFilterState *nf,
             s->outdev_packets++;
             s->outdev_bytes += ret;
         }
-        return ret;
+        return iov_size(iov, iovcnt);
     } else {
         return 0;
     }
-- 
2.52.0


